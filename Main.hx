package;

import js.html.FileReader;
import js.html.File;
import js.html.InputElement;
import js.html.ParagraphElement;
import js.html.DivElement;
import js.Browser;

typedef Entry = Array<String>;
typedef Entries = Array<Entry>;

class Main {
	static function main() {
		final input:InputElement = Browser.document.createInputElement();
		input.type = "file";
		input.multiple = false;
		Browser.document.body.appendChild(input);
		input.addEventListener("change", function() {
			Browser.document.body.removeChild(input);

			final file:File = input.files[0];
			final reader:FileReader = new FileReader();
			reader.readAsText(file);
			reader.addEventListener("load", function() {
				final csv:String = reader.result;
				final rows:Entry = csv.split("\n");

				final entries:Entries = [];
				for (row in rows) {
					if (row != rows[0]) {
						final entry:Entry = row.split(";");
						entries.push(entry);
					}
				}

				for (row in entries) {
					final div:DivElement = Browser.document.createDivElement();
					Browser.document.body.appendChild(div);
					final p:ParagraphElement = Browser.document.createParagraphElement();
					p.innerHTML = '<b>${row[0]} ${row[1]}</b>';
					div.appendChild(p);
					for (entry in row) {
						if ((entry != row[0]) && (entry != row[1]) && (entry != row[6])) {
							final p:ParagraphElement = Browser.document.createParagraphElement();
							p.innerText = entry.toString();
							div.appendChild(p);
						}
					}
				}
			});
		});
	}
}
