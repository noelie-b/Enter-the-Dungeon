<?xml version="1.0"?>

<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns="http://www.w3.org/2000/svg">

  <xsl:output
      method="xml"
      indent="yes"
      standalone="no"
      doctype-public="-//W3C//DTD SVG 1.1//EN"
      doctype-system="http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd"
      media-type="image/svg" />


	<xsl:template match="scenes">
	<svg version="1.1" baseProfile="full" xmlns="http://www.w3.org/2000/svg" xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape" xmlns:xlink="http://www.w3.org/1999/xlink" width="640" height="640">
	<defs>
    <pattern id="grid" width="20" height="20" patternUnits="userSpaceOnUse">
        <rect width="20" height="20" fill="blue"/>
    </pattern>

    <rect id="others" width="10" height="10" fill="blue" opacity="0.2" transform="scale(2,2)"/>
    <rect id="empty" width="10" height="10" class="background" stroke="black" stroke-width="1" transform="scale(2,2)"/>
    <rect id="void" width="10" height="10" fill="black" stroke="black" stroke-width="1" transform="scale(2,2)"/>

    <g id="window" width="10" transform="scale(2,2)">
        <rect x="-0.75" y="2" width="1.5" height="6" class="background" stroke="black" stroke-width="0.5"/>
    </g>

    <!--scene06-->
    <g id="gap" width="10" transform="scale(2,2)">
      <line x1="0" y1="0" x2="0" y2="2" stroke="#40304b" stroke-width="3" stroke-linecap="round"/>
      <line x1="0" y1="8" x2="0" y2="10" stroke="#40304b" stroke-width="3" stroke-linecap="round"/>
      <circle cx="2.5" cy="2" r="0.5" fill="green"/>
      <circle cx="-3" cy="3" r="0.5" fill="green"/>
      <circle cx="3" cy="4" r="0.6" fill="green"/>
      <circle cx="1.5" cy="4.5" r="0.5" fill="green"/>
      <circle cx="-1.5" cy="5" r="0.5" fill="green"/>
      <circle cx="2" cy="6" r="0.5" fill="green"/>
      <circle cx="5" cy="6" r="0.5" fill="green"/>
      <circle cx="-2" cy="6.5" r="0.5" fill="green"/>
      <circle cx="3" cy="8" r="0.5" fill="green"/>
    </g>


    <g id="secret" width="10" transform="scale(2,2)">
      <line x1="0" y1="0" x2="0" y2="10" stroke="black" stroke-width="3" stroke-linecap="round"/>
    </g>


    <g id="gate" width="10" transform="scale(2,2)">
      <rect x="-2" y="4" width="4" height="12" class="background" stroke="black" stroke-width="1"/>
    </g>

    <g id="one-way-door" width="10" transform="scale(2,2)">
      <rect x="0" y="2" width="2" height="6" class="background" stroke="black" stroke-width="1"/>
    </g>

    <g id="statue" width="10" transform="scale(2,2)">
      <rect width="10" height="10" class="background" stroke="black" stroke-width="1"/>
      <circle cx="5" cy="5" r="3.5" fill="none" stroke="black" stroke-width="0.5"/>
      <path fill="black" d="M 2,4 H 8 L 3,7.5 5,2 7,7.5 Z"/>
    </g>

    <g id="chest" width="10" transform="scale(2,2)">
      <rect width="10" height="10" class="background" stroke="black" stroke-width="1"/>
      <rect x="2" y="3" width="6" height="4" fill="none" stroke="black" stroke-width="0.5"/>
      <line x1="3.5" y1="2" x2="3.5" y2="8" stroke="black" stroke-width="0.5"/>
      <line x1="6.5" y1="2" x2="6.5" y2="8" stroke="black" stroke-width="0.5"/>
    </g>


    <g id="stair-big" width="10" transform="scale(2,2)">
      <rect width="20" height="20" class="background" stroke="black" stroke-width="1"/>
      <line x1="1" y1="3" x2="19" y2="3" stroke="black" stroke-width="0.8"/>
      <line x1="2" y1="6" x2="18" y2="6" stroke="black" stroke-width="0.8"/>
      <line x1="3" y1="9" x2="17" y2="9" stroke="black" stroke-width="0.8"/>
      <line x1="4" y1="12" x2="16" y2="12" stroke="black" stroke-width="0.8"/>
      <line x1="5" y1="15" x2="15" y2="15" stroke="black" stroke-width="0.8"/>
      <line x1="6" y1="18" x2="14" y2="18" stroke="black" stroke-width="0.8"/>
    </g>

    <g id="stair-big-spiral" width="50" transform="scale(0.4,0.4)">
      <rect width="100" height="100" class="background" stroke="black" stroke-width="5"/>
      <circle cx="50" cy="50" r="40" fill="none" stroke="black" stroke-width="5"/>
      <line x1="0" y1="50" x2="99" y2="50" stroke="black" stroke-width="5"/>
      <line x1="50" y1="0" x2="50" y2="100" stroke="black" stroke-width="5"/>
      <line x1="15" y1="30" x2="85" y2="70" stroke="black" stroke-width="5"/>
      <line x1="15" y1="70" x2="85" y2="30" stroke="black" stroke-width="5"/>
      <line x1="30" y1="15" x2="70" y2="85" stroke="black" stroke-width="5"/>
      <line x1="30" y1="85" x2="70" y2="15" stroke="black" stroke-width="5"/>
      <circle cx="50" cy="50" r="10" class="background" stroke="black" stroke-width="5"/>
    </g>

	</defs>

<style>
svg { overflow: visible }
text { font: 14px 'Courier New', Courier, monospace }
textarea { font: 10px 'Courier New', Courier, monospace }
p { margin: 0 0 10px 0; padding: 0; }
.line {  }
.line svg { display: inline; vertical-align: middle }
.labels text, #levels text, #label { text-anchor: middle; font: 10px 'Arial Narrow', sans-serif; font-weight: bold; }
.labels text.left, #levels text.left { text-anchor: start; font-size: 14px; }
a { color: black; text-decoration: none; }
.blue { fill: blue; }
/* http://paletton.com/palette.php?uid=30f0u0kk8qbaaFtfwuQo4mgswhv */
.background { fill: inherit; }
use.red { fill: #F6A17F; }
use.green { fill: #A1DB71; }
use.blue { fill: #88A9C2; }
use.colorQ { fill: #A9A9A9; }
use.colorE { fill: #FF5733; }
use.colorA { fill: #FFD700; }
use.colorS { fill: #FF8C00; }
use.colorS { fill: #A0522D; }
use.colorD { fill: #1E90FF; }
use.colorF { fill: #008000; }
use { fill: white; }
.key { color: forestgreen; fill: forestgreen; font-weight: bold; }
.invisible { display: none; }
.center:hover .dot { opacity: 1; }
#ui { -webkit-tap-highlight-color: rgba(0,0,0,0); }
#background { transition: fill 500ms linear; }
#help { transition: fill 500ms linear; }
text { fill: black; }

#help { fill: #fffff0; } /* ivory and light grey */
#background { fill: #d3d3d3; }

svg.black #background { fill: black; }

svg.white #background { fill: white; }

svg.grid  #background { fill: url(#grid); }

/* http://www.color-hex.com/color/01b0f1
   https://de.wikipedia.org/wiki/Non-Photo_Blue */
svg.blue * { stroke: #005878; }
svg.blue *[fill=black],
svg.blue a,
svg.blue text,
svg.blue tspan { stroke: none; fill: #005878; }
svg.blue .key { fill: white; }
svg.blue .blue { text-decoration: underline; fill: inherit; }
svg.blue #background,
svg.blue #help { fill: #01b0f1; }

.menu div {
    background: white;
    padding: 10px;
    overflow: scroll;
    font: 14px 'Courier New', Courier, monospace
}
.menu span { display: inline-block; width: 32ex }
.menu a { color: blue }</style>

    <!-- Scenes -->

  <g id="background" inkscape:groupmode="layer" inkscape:label="Background">
    <rect x="20" y="20" width="600" height="600" fill="#060a3f" stroke="black" stroke-width="1"/>
  </g>

	  <g id="levels" inkscape:groupmode="layer" inkscape:label="Levels">
    <g id="level0" inkscape:groupmode="layer" inkscape:label="Level 1">


		<xsl:if test="scene[contains(@id,'scene00')]">
		<rect x="200" y="500" width="180" height="100" fill="#296524" stroke-width="1"/>
			  			   <rect id="scene00" style="visibility:visible" x="280" y="540" width="20" height="20" fill="red" stroke-width="1"/>
        <g id="labels0">
          <text id="label_14_25" x="310" y="534">0</text>
        </g>
		    <use id="secret_12_25" x="260" y="520" xlink:href="#secret" rotate="90" transform="rotate(90,270,530)"/>
        <use id="secret_13_25" x="280" y="520" xlink:href="#secret" rotate="90" transform="rotate(90,290,530)"/>
        <use id="secret_13_24" x="280" y="500" xlink:href="#secret" rotate="90" transform="rotate(90,290,510)"/>
        <use id="secret_12_24" x="260" y="500" xlink:href="#secret" rotate="90" transform="rotate(90,270,510)"/>
		</xsl:if>

    <xsl:if test="scene[contains(@id,'scene01')]"><g id="scene01" style="visibility:hidden">
				<rect x="200" y="380" width="180" height="120" fill="#685450" stroke-width="1"/> <!--scene01-->
							   <rect id="scene01" style="visibility:hidden" x="280" y="430" width="20" height="20" fill="red" stroke-width="1"/>
        <text id="label_17_18" x="370" y="394">1</text>
         <use id="gate_8_22" x="180" y="460" xlink:href="#gate" rotate="180" transform="rotate(180,190,470)"/>
         <g id="floor0">
              <use id="stair-big_10_16" x="220" y="340" xlink:href="#stair-big" rotate="0" class="colorQ"/>
         </g>
        <use id="secret_9_18" x="200" y="380" xlink:href="#secret" rotate="0"/>
        <use id="secret_9_19" x="200" y="400" xlink:href="#secret" rotate="0"/>
        <use id="secret_9_20" x="200" y="420" xlink:href="#secret" rotate="0"/>
        <use id="secret_9_21" x="200" y="440" xlink:href="#secret" rotate="0"/>
        <use id="secret_9_22" x="200" y="460" xlink:href="#secret" rotate="0"/>
        <use id="secret_9_23" x="200" y="480" xlink:href="#secret" rotate="0"/>
        <use id="secret_18_18" x="380" y="380" xlink:href="#secret" rotate="0"/>
        <use id="secret_18_19" x="380" y="400" xlink:href="#secret" rotate="0"/>
        <use id="secret_18_22" x="380" y="460" xlink:href="#secret" rotate="0"/>
        <use id="secret_18_23" x="380" y="480" xlink:href="#secret" rotate="0"/>
        <use id="window_18_20" x="380" y="420" xlink:href="#window" rotate="0"/>
        <use id="window_18_21" x="380" y="440" xlink:href="#window" rotate="0"/>
        </g>
    </xsl:if>

    <xsl:if test="scene[contains(@id,'scene02')]"><g id="scene02" style="visibility:hidden">
        <rect x="380" y="380" width="200" height="120" fill="#685450" stroke-width="1"/> <!--scene02-->
        		<rect id="scene02" style="visibility:hidden" x="460" y="430" width="20" height="20" fill="red" stroke-width="1"/>
        <text id="label_27_18" x="570" y="394">2</text>
        <use id="chest_21_23" x="440" y="480" xlink:href="#chest" rotate="0" class="colorA"/>
        <use id="chest_24_23" x="500" y="480" xlink:href="#chest" rotate="0" class="colorA"/>
        <use id="chest_21_18" x="440" y="380" xlink:href="#chest" rotate="0" class="colorA"/>
        <use id="chest_24_18" x="500" y="380" xlink:href="#chest" rotate="0" class="colorA"/>
        <use id="chest_24_18" x="540" y="380" xlink:href="#chest" rotate="0" class="colorA"/>
        </g>
    </xsl:if>

    <xsl:if test="scene[contains(@id,'scene03')]"><g id="scene03" style="visibility:hidden">
          <rect x="180" y="220" width="120" height="120" fill="#685450" stroke-width="1"/> <!--scene03-->
          		<rect id="scene03" style="visibility:hidden" x="230" y="270" width="20" height="20" fill="red" stroke-width="1"/>
          <text id="label_13_10" x="290" y="234">3</text>
          <use id="secret_8_15" x="180" y="320" xlink:href="#secret" rotate="0"/>
          <use id="secret_8_14" x="180" y="300" xlink:href="#secret" rotate="0"/>
          <use id="secret_8_10" x="180" y="220" xlink:href="#secret" rotate="0"/>
          <use id="secret_8_11" x="180" y="240" xlink:href="#secret" rotate="0"/>
          <use id="window_8_13" x="180" y="280" xlink:href="#window" rotate="0"/>
          <use id="window_8_12" x="180" y="260" xlink:href="#window" rotate="0"/>
          <use id="gate_11_10" x="240" y="220" xlink:href="#gate" rotate="90" transform="rotate(90,250,230)"/>
          <use id="secret_14_11" x="300" y="240" xlink:href="#secret" rotate="0"/>
          <use id="secret_14_10" x="300" y="220" xlink:href="#secret" rotate="0"/>
          <use id="secret_14_14" x="300" y="300" xlink:href="#secret" rotate="0"/>
          <use id="secret_14_15" x="300" y="320" xlink:href="#secret" rotate="0"/>
          <use id="window_14_13" x="300" y="280" xlink:href="#window" rotate="0"/>
          <use id="window_14_12" x="300" y="260" xlink:href="#window" rotate="0"/>
        </g>
    </xsl:if>

    <xsl:if test="scene[contains(@id,'scene04')]"><g id="scene04" style="visibility:hidden">
        <rect x="300" y="220" width="120" height="120" fill="#685450" stroke-width="1"/> <!--scene04-->
        		<rect id="scene04" style="visibility:hidden" x="310" y="270" width="20" height="20" fill="red" stroke-width="1"/>
        <text id="label_19_10" x="410" y="234">4</text>
        <g id="floors0">
              <use id="stair-big-spiral_16_12" x="340" y="260" xlink:href="#stair-big-spiral" rotate="0" class="colorQ"/>
        </g>
        <use id="secret_14_10" x="300" y="220" xlink:href="#secret" rotate="90" transform="rotate(90,310,230)"/>
        <use id="secret_15_10" x="320" y="220" xlink:href="#secret" rotate="90" transform="rotate(90,330,230)"/>
        <use id="secret_18_10" x="380" y="220" xlink:href="#secret" rotate="90" transform="rotate(90,390,230)"/>
        <use id="secret_19_10" x="400" y="220" xlink:href="#secret" rotate="90" transform="rotate(90,410,230)"/>
        <use id="window_16_10" x="340" y="220" xlink:href="#window" rotate="90" transform="rotate(90,350,230)"/>
        <use id="window_17_10" x="360" y="220" xlink:href="#window" rotate="90" transform="rotate(90,370,230)"/>
        </g>
    </xsl:if>

    <xsl:if test="scene[contains(@id,'scene05')]"><g id="scene05" style="visibility:hidden">
        <rect x="300" y="100" width="120" height="120" fill="#685450" stroke-width="1"/> <!--scene05-->
        		<rect id="scene05" style="visibility:hidden" x="350" y="150" width="20" height="20" fill="red" stroke-width="1"/>

        <text id="label_19_4" x="410" y="114">5</text>
        <g id="floors0">
            <use id="stair-big_21_6" x="440" y="140" xlink:href="#stair-big" rotate="90" transform="rotate(90,450,150)" class="colorQ"/>
        </g>
        </g>
    </xsl:if>

    <xsl:if test="scene[contains(@id,'scene06')]"><g id="scene06" style="visibility:hidden">
        <rect x="460" y="100" width="120" height="120" fill="#685450" stroke-width="1"/> <!--scene06-->
        		<rect id="scene06" style="visibility:hidden" x="500" y="150" width="20" height="20" fill="red" stroke-width="1"/>
        <text id="label_27_4" x="570" y="114">6</text>
        <use id="gap_27_6" x="560" y="140" xlink:href="#gap" rotate="0"/>
        <use id="gap_27_7" x="560" y="160" xlink:href="#gap" rotate="0"/>
        <use id="one-way-door_24_10" x="500" y="220" xlink:href="#one-way-door" rotate="90" transform="rotate(90,510,230)"/>
        <g id="floors0">
            <use id="chest_24_4" x="500" y="100" xlink:href="#chest" rotate="0" class="colorA"/>
        </g>
        </g>
    </xsl:if>


    <xsl:if test="scene[contains(@id,'scene07')]"><g id="scene07" style="visibility:hidden">
        <rect x="60" y="380" width="140" height="120" fill="#685450" stroke-width="1"/>
        		<rect id="scene07" style="visibility:hidden" x="110" y="470" width="20" height="20" fill="red" stroke-width="1"/>
        <text id="label_8_18" x="190" y="394">7</text>
        <use id="gate_7_18" x="160" y="380" xlink:href="#gate" rotate="90" transform="rotate(90,170,390)"/>
        <use id="gate_4_19" x="100" y="400" xlink:href="#gate" rotate="90" transform="rotate(90,110,410)"/>
        <use id="gate_6_19" x="140" y="400" xlink:href="#gate" rotate="90" transform="rotate(90,150,410)"/>
        <use id="gate_4_20" x="100" y="420" xlink:href="#gate" rotate="90" transform="rotate(90,110,430)"/>
        <use id="gate_4_21" x="100" y="440" xlink:href="#gate" rotate="90" transform="rotate(90,110,450)"/>
        <use id="gate_4_22" x="100" y="460" xlink:href="#gate" rotate="90" transform="rotate(90,110,470)"/>
        <use id="gate_6_22" x="140" y="460" xlink:href="#gate" rotate="90" transform="rotate(90,150,470)"/>
        <use id="gate_6_21" x="140" y="440" xlink:href="#gate" rotate="90" transform="rotate(90,150,450)"/>
        <use id="gate_6_20" x="140" y="420" xlink:href="#gate" rotate="90" transform="rotate(90,150,430)"/>
        <use id="gate_8_20" x="180" y="420" xlink:href="#gate" rotate="180" transform="rotate(180,190,430)"/>
        <use id="gate_6_23" x="140" y="480" xlink:href="#gate" rotate="270" transform="rotate(270,150,490)"/>
        <use id="gate_4_23" x="100" y="480" xlink:href="#gate" rotate="270" transform="rotate(270,110,490)"/>
        <use id="gate_2_23" x="60" y="480" xlink:href="#gate" rotate="270" transform="rotate(270,70,490)"/>
        <use id="gate_1_22" x="40" y="460" xlink:href="#gate" rotate="180" transform="rotate(180,50,470)"/>
        <use id="gate_1_19" x="40" y="400" xlink:href="#gate" rotate="180" transform="rotate(180,50,410)"/>
        </g>
    </xsl:if>



    <xsl:if test="scene[contains(@id,'scene08')]"><g id="scene08" style="visibility:hidden">
        <rect x="60" y="220" width="120" height="120" fill="#685450" stroke-width="1"/>
        		<rect id="scene08" style="visibility:hidden" x="110" y="270" width="20" height="20" fill="red" stroke-width="1"/>
            <text id="label_7_10" x="170" y="234">8</text>
            <g id="floors0">
                <use id="stair-big_4_16" x="100" y="340" xlink:href="#stair-big" rotate="0" class="colorQ"/>
            </g>
            <g id="walls0">
                  <use id="secret_7_10" x="160" y="220" xlink:href="#secret" rotate="90" transform="rotate(90,170,230)"/>
                  <use id="secret_6_10" x="140" y="220" xlink:href="#secret" rotate="90" transform="rotate(90,150,230)"/>
                  <use id="secret_3_10" x="80" y="220" xlink:href="#secret" rotate="90" transform="rotate(90,90,230)"/>
                  <use id="secret_2_10" x="60" y="220" xlink:href="#secret" rotate="90" transform="rotate(90,70,230)"/>
                  <use id="window_4_10" x="100" y="220" xlink:href="#window" rotate="90" transform="rotate(90,110,230)"/>
                  <use id="window_5_10" x="120" y="220" xlink:href="#window" rotate="90" transform="rotate(90,130,230)"/>
            </g>
            <use id="chest_2_12" x="60" y="260" xlink:href="#chest" rotate="90" transform="rotate(90,70,270)" class="colorA"/>

        </g>
    </xsl:if>

    <xsl:if test="scene[contains(@id,'scene09')]"><g id="scene09" style="visibility:hidden">
        <rect x="60" y="80" width="120" height="140" fill="#685450" stroke-width="1"/> <!--scene09-->
        <rect id="scene09" style="visibility:hidden" x="110" y="170" width="20" height="20" fill="red" stroke-width="1"/>
        <text id="label_7_4" x="170" y="114">9</text>
        <g id="walls0">
                <use id="secret_4_3" x="100" y="80" xlink:href="#secret" rotate="270" transform="rotate(270,110,90)"/>
                <use id="secret_5_3" x="120" y="80" xlink:href="#secret" rotate="270" transform="rotate(270,130,90)"/>
                <use id="secret_5_3" x="120" y="80" xlink:href="#secret" rotate="90" transform="rotate(90,130,90)"/>
                <use id="secret_4_3" x="100" y="80" xlink:href="#secret" rotate="90" transform="rotate(90,110,90)"/>
            </g>
            <g id="floors0">
                <use id="statue_5_6" x="120" y="140" xlink:href="#statue" class="blue"/>
            </g>
        </g>
    </xsl:if>

		</g>
		</g>


	</svg>

	</xsl:template>
	</xsl:stylesheet>