From: jonathan.derrick@intel.com (Jon Derrick)
Date: Fri, 17 Feb 2017 15:56:16 -0700
Subject: [PATCH 3/5] block/sed: Check received header lengths
In-Reply-To: <1487372178-15715-1-git-send-email-jonathan.derrick@intel.com>
References: <1487372178-15715-1-git-send-email-jonathan.derrick@intel.com>
Message-ID: <1487372178-15715-4-git-send-email-jonathan.derrick@intel.com>

Add a buffer size check against discovery and response header lengths
before we loop over their buffers.

Signed-off-by: Jon Derrick <jonathan.derrick at intel.com>
---
 block/sed-opal.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index d3d6db2..4fc4d7b 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -411,10 +411,17 @@ static int opal_discovery0_end(struct opal_dev *dev)
 	const struct d0_header *hdr = (struct d0_header *)dev->resp;
 	const u8 *epos = dev->resp, *cpos = dev->resp;
 	u16 comid = 0;
+	u32 hlen = be32_to_cpu(hdr->length);
 
-	print_buffer(dev->resp, be32_to_cpu(hdr->length));
+	print_buffer(dev->resp, hlen);
 
-	epos += be32_to_cpu(hdr->length); /* end of buffer */
+	if (hlen > IO_BUFFER_LENGTH - sizeof(*hdr)) {
+		pr_warn("Discovery length overflows buffer (%zu+%u)/%u\n",
+			sizeof(*hdr), hlen, IO_BUFFER_LENGTH);
+		return -EFAULT;
+	}
+
+	epos += hlen; /* end of buffer */
 	cpos += sizeof(*hdr); /* current position on buffer */
 
 	while (cpos < epos && supported) {
@@ -784,6 +791,7 @@ static int response_parse(const u8 *buf, size_t length,
 	int total;
 	ssize_t token_length;
 	const u8 *pos;
+	u32 clen, plen, slen;
 
 	if (!buf)
 		return -EFAULT;
@@ -795,17 +803,16 @@ static int response_parse(const u8 *buf, size_t length,
 	pos = buf;
 	pos += sizeof(*hdr);
 
-	pr_debug("Response size: cp: %d, pkt: %d, subpkt: %d\n",
-		 be32_to_cpu(hdr->cp.length),
-		 be32_to_cpu(hdr->pkt.length),
-		 be32_to_cpu(hdr->subpkt.length));
-
-	if (hdr->cp.length == 0 || hdr->pkt.length == 0 ||
-	    hdr->subpkt.length == 0) {
-		pr_err("Bad header length. cp: %d, pkt: %d, subpkt: %d\n",
-		       be32_to_cpu(hdr->cp.length),
-		       be32_to_cpu(hdr->pkt.length),
-		       be32_to_cpu(hdr->subpkt.length));
+	clen = be32_to_cpu(hdr->cp.length);
+	plen = be32_to_cpu(hdr->pkt.length);
+	slen = be32_to_cpu(hdr->subpkt.length);
+	pr_debug("Response size: cp: %u, pkt: %u, subpkt: %u\n",
+		 clen, plen, slen);
+
+	if (clen == 0 || plen == 0 || slen == 0 ||
+	    slen > IO_BUFFER_LENGTH - sizeof(*hdr)) {
+		pr_err("Bad header length. cp: %u, pkt: %u, subpkt: %u\n",
+		       clen, plen, slen);
 		print_buffer(pos, sizeof(*hdr));
 		return -EINVAL;
 	}
@@ -814,7 +821,7 @@ static int response_parse(const u8 *buf, size_t length,
 		return -EFAULT;
 
 	iter = resp->toks;
-	total = be32_to_cpu(hdr->subpkt.length);
+	total = slen;
 	print_buffer(pos, total);
 	while (total > 0) {
 		if (pos[0] <= TINY_ATOM_BYTE) /* tiny atom */
-- 
1.8.3.1
