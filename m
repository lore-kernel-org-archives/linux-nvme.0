From: keith.busch@intel.com (Keith Busch)
Date: Wed,  9 Dec 2015 14:09:17 -0700
Subject: [PATCHv2] printf: Add format for 8-byte EUI-64 type
Message-ID: <1449695357-22163-1-git-send-email-keith.busch@intel.com>

MAC addresses may be formed using rules based on EUI-64, which is 2 bytes
longer than a typical 6-byte MAC. This patch adds a long specifier to
the %pM format to support the extended unique identifier.

Since there are now two cases that use the default ':' separator, this
initializes the separator during its declaration, and removes the switch
fall through case.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
Changed from previos version:

  Fixed checks for the 'l' specifier. This can be in fmt[1] or fmt[2],
  pointed out by Joe Perches from original review (thanks!).

 Documentation/printk-formats.txt | 13 ++++++++++---
 lib/vsprintf.c                   | 31 +++++++++++++++++++++++--------
 2 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/Documentation/printk-formats.txt b/Documentation/printk-formats.txt
index b784c27..e2fe4ed 100644
--- a/Documentation/printk-formats.txt
+++ b/Documentation/printk-formats.txt
@@ -136,14 +136,21 @@ Raw buffer as a hex string:
 MAC/FDDI addresses:
 
 	%pM	00:01:02:03:04:05
+	%pMl	00:01:02:03:04:05:06:07
 	%pMR	05:04:03:02:01:00
+	%pMRl	07:06:05:04:03:02:01:00
 	%pMF	00-01-02-03-04-05
+	%pMFl	00-01-02-03-04-05-06-07
 	%pm	000102030405
+	%pml	0001020304050607
 	%pmR	050403020100
+	%pmRl	0706050403020100
 
-	For printing 6-byte MAC/FDDI addresses in hex notation. The 'M' and 'm'
-	specifiers result in a printed address with ('M') or without ('m') byte
-	separators. The default byte separator is the colon (':').
+	For printing 6 or 8-byte MAC/FDDI addresses in hex notation. The
+	'M' and 'm' specifiers result in a printed address with ('M')
+	or without ('m') byte separators. The default byte separator is
+	the colon (':'). Append 'l' to specify an 8-byte in accordance
+	with EUI-64 format.
 
 	Where FDDI addresses are concerned the 'F' specifier can be used after
 	the 'M' specifier to use dash ('-') separators instead of the default
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index f9cee8e..a5eb82c 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -889,10 +889,10 @@ static noinline_for_stack
 char *mac_address_string(char *buf, char *end, u8 *addr,
 			 struct printf_spec spec, const char *fmt)
 {
-	char mac_addr[sizeof("xx:xx:xx:xx:xx:xx")];
+	char mac_addr[sizeof("xx:xx:xx:xx:xx:xx:xx:xx")];
 	char *p = mac_addr;
-	int i;
-	char separator;
+	int i, bytes = 6;
+	char separator = ':';
 	bool reversed = false;
 
 	switch (fmt[1]) {
@@ -902,20 +902,33 @@ char *mac_address_string(char *buf, char *end, u8 *addr,
 
 	case 'R':
 		reversed = true;
-		/* fall through */
+		break;
+
+	case 'l':
+		bytes = 8;
+		break;
 
 	default:
-		separator = ':';
 		break;
 	}
+	if (separator == '-' || reversed) {
+		/* 'F' and 'R' may take additional length specifier */
+		switch (fmt[2]) {
+		case 'l':
+			bytes = 8;
+			break;
+		default:
+			break;
+		}
+	}
 
-	for (i = 0; i < 6; i++) {
+	for (i = 0; i < bytes; i++) {
 		if (reversed)
-			p = hex_byte_pack(p, addr[5 - i]);
+			p = hex_byte_pack(p, addr[(bytes - 1) - i]);
 		else
 			p = hex_byte_pack(p, addr[i]);
 
-		if (fmt[0] == 'M' && i != 5)
+		if (fmt[0] == 'M' && i != (bytes - 1))
 			*p++ = separator;
 	}
 	*p = '\0';
@@ -1496,6 +1509,8 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 	case 'm':			/* Contiguous: 000102030405 */
 					/* [mM]F (FDDI) */
 					/* [mM]R (Reverse order; Bluetooth) */
+					/* [mM]l (EUI-64) */
+					/* [mM][FR]l (FDDI/Reverse order EUI-64) */
 		return mac_address_string(buf, end, ptr, spec, fmt);
 	case 'I':			/* Formatted IP supported
 					 * 4:	1.2.3.4
-- 
2.6.2.307.g37023ba
