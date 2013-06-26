function write_meta(filename)
{
	name = sprintf("yha/%s.meta",filename);

	east  = $6 * 11930465;
	north = $5 * 23860929;

	printf("<POI ")							>	name;
	printf("Title=\"%s\" ",			$1)			>	name;
	printf("East=\"%d\" ",			east)			>	name;
	printf("North=\"%d\" ",			north)			>	name;
	printf("Elevation=\"%s\" ",		0)			>	name;
	printf("Visible=\"1\" ")					>	name;
	printf("Text=\"")						>	name;
	printf("{b}%s{*b}{br}",			$1)			>	name;
	printf("%s{br}",			$2)			>	name;
	printf("%s{br}",			$3)			>	name;
	printf("{b}%s{*b}{br}",			$4)			>	name;
	printf("{br}")							>	name;
	printf("{b}latitude{*b}: %0.6f{br}",	$5)			>	name;
	printf("{b}longitude{*b}: %0.6f{br}",	$6)			>	name;
	printf("{b}grid ref{*b}: %s{br}",	$7)			>	name;
	printf("\" ")							>	name;
	printf("Icon=\"\\Flash Disk\\My POI Icons\\1.Spots\\__AAF_diamond_red.png\"")	>	name;
	printf("/>")							>	name;
	close(name);
}

function write_kml(filename)
{
	name = sprintf("yha/%s.part",filename);

	gsub(/'/,"\\&apos;", $1);

	printf("\t\t<Placemark>\n")							> name;
	printf("\t\t	<name>%s</name>\n", $1)						> name;
	printf("\t\t	<description>\n")						> name;
	printf("\t\t		<![CDATA[\n")						> name;
	printf("\t\t		<b>Grid Ref</b>: %s<br />\n", $7)			> name;
	printf("\t\t		<b>Latitude</b>: %0.6f<br />\n", $5)			> name;
	printf("\t\t		<b>Longitude</b>: %0.6f<br />\n", $6)			> name;
	printf("\t\t		<b>Address</b>: %s<br /\n", $2)				> name;
	printf("\t\t		<b>Postcode</b>: %s<br /\n", $3)			> name;
	printf("\t\t		<b>Phone</b>: %s\n", $4)				> name;
	printf("\t\t		]]>\n")							> name;
	printf("\t\t	</description>\n")						> name;
	printf("\t\t	<styleUrl>#diamond_red</styleUrl>\n")				> name;
	printf("\t\t	<Point>\n")							> name;
	printf("\t\t		<coordinates>%0.6f,%0.6f</coordinates>\n", $6, $5)	> name;
	printf("\t\t	</Point>\n")							> name;
	printf("\t\t</Placemark>\n")							> name;

	close(name);
}

BEGIN {
	FS="\t"
	"mkdir -p yha" | getline
}

NR == 1 {
	next;
}

{
	filename = tolower($1);
	gsub (/ /, "_",        filename);
	gsub (/'/, "",         filename);
	gsub (/,/, "",         filename);
	gsub (/'/, "\\&apos;", filename);

	print $1
	write_meta(filename);
	write_kml(filename);
}

