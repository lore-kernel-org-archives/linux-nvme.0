From: keith.busch@intel.com (Keith Busch)
Date: Wed,  9 Dec 2015 11:42:56 -0700
Subject: [PATCHv2 1/2] Print: Add print format for 8-byte EUI-64 type
In-Reply-To: <1449686577-6319-1-git-send-email-keith.busch@intel.com>
References: <1449686577-6319-1-git-send-email-keith.busch@intel.com>
Message-ID: <1449686577-6319-2-git-send-email-keith.busch@intel.com>

MAC addresses may be formed using rules based on EUI-64, which is 2 bytes
longer than a typical 6-byte MAC. This patch adds a long specifier to
the %pM format to support the extended unique identifier.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 Documentation/printk-formats.txt | 13 ++++++++++---
 lib/vsprintf.c                   | 17 ++++++++++++-----
 2 files changed, 22 insertions(+), 8 deletions(-)

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
index f9cee8e..a2d20b7 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -889,9 +889,9 @@ static noinline_for_stack
 char *mac_address_string(char *buf, char *end, u8 *addr,
 			 struct printf_spec spec, const char *fmt)
 {
-	char mac_addr[sizeof("xx:xx:xx:xx:xx:xx")];
+	char mac_addr[sizeof("xx:xx:xx:xx:xx:xx:xx:xx")];
 	char *p = mac_addr;
-	int i;
+	int i, bytes = 6;
 	char separator;
 	bool reversed = false;
 
@@ -908,14 +908,21 @@ char *mac_address_string(char *buf, char *end, u8 *addr,
 		separator = ':';
 		break;
 	}
+	switch (fmt[2]) {
+	case 'l':
+		bytes = 8;
+		break;
+	default:
+		break;
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
-- 
2.6.2.307.g37023ba
