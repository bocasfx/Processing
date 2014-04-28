
class GplPalette {
	color colors[];
	int offset = 4;	
	GplPalette(String filename) {
		String lines[] = loadStrings(filename);
		colors = new color[lines.length-offset];
		for (int i=offset; i < lines.length; i++) {
			String line[] = splitTokens(lines[i]);	
			color colour = color( int(line[0]), int(line[1]), int(line[2]) );
			colors[i-offset] = colour;
		}		
	}	
}