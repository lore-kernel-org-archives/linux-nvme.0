Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46A8BC4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Dec 2022 15:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=+CpXX8ix7k82jmDw1nqAMg5CCW8sIBQI4jIZJeEyI2s=; b=z5EvxEpSTqJh9FCtTWP5BDhZSK
	72pzEm8w70sA2uK9M4GJ9nUaDVHvsBhyk8IAPuKpn7lk3oLqBynGbF91QpOVCYi0PgysgcvgWz5fZ
	eurAbUyDefVsciAuuY5J6qlg3uztqM8U2RjugLnEehT2RG/dvBke7+zcl5kcI/JBTJamm5BELfUvi
	u54nNYDQ4xC3h/sEzbrLQP1Uwq4Xm1hLTZNTyAURWpmfjeZcmJILjy3Xe05NQttxCOaJqfP4lfW57
	JsUqTpKmlKAUOLQArGUGWKssuxPCINrlfueroA1VfJ7qlhj4nYxMYtwQsn9swv9tYQw2VnSHcy4cb
	jQ6S/XNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p4kKr-000ggJ-Sk; Mon, 12 Dec 2022 15:03:17 +0000
Received: from wout1-smtp.messagingengine.com ([64.147.123.24])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p4kKo-000gZu-6z
	for linux-nvme@lists.infradead.org; Mon, 12 Dec 2022 15:03:16 +0000
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 18E98320096C;
	Mon, 12 Dec 2022 10:03:06 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 12 Dec 2022 10:03:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
	 h=cc:cc:content-transfer-encoding:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:sender:subject
	:subject:to:to; s=fm1; t=1670857385; x=1670943785; bh=+CpXX8ix7k
	82jmDw1nqAMg5CCW8sIBQI4jIZJeEyI2s=; b=hMqTNI2YoDdj8qMuqQMZU5X0+u
	QfNbVuXc0PpydR2jwiq65wYmAHSlmrfAMsXXogFuaKstLcUV2XDqDTOiBTRwCr4l
	bRSAhd+BkxuPdHjNXeLN04d0cgkfve7gFkmXnZQlrRS9HddR15ZXLq5uBUvtVpLT
	Kv08xTpVxiFNMWi6zcJW6z9Tgv4+sXdRRJQFIakKBE1n5ibEzJ3GcVeBRP7C2fiN
	XRgHNu+CavIazWYyugp6GXoxVVxUwjhOYUutgGqC/GaZkTNgCIsYJSZY+QzvkXMQ
	ULrJB8eRe+Rmz7yWNY3uiEXdaRI/8KtQXLVMpkpWmFrCooYAsYL5nlU9NOZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1670857385; x=1670943785; bh=+CpXX8ix7k82jmDw1nqAMg5CCW8sIBQI4jI
	ZJeEyI2s=; b=NSh60PpcgpOdNtajtNTZci/2MnW4JO6a7Ab8BmmsUhZAhqg142Z
	qj5HLeJ2fQW+IWX45BIwAEACm0ZwlNRm4L5QZMswwhgYTNAfwLXrCVF4g7KkVQGh
	m//j3J3kf0XrXukq7jHGWHUweRSdlpdq8IpOXpx5sK8a5MSc92ImTitKKUXHW+GU
	wJfYt7zJnS3ar5CIXVrP4uQnMvF4A+HFHn0O5JHNWrzjp8AYkOLRmh/IfhNTk2pH
	mTS3N8qe96l1a/aOeCKnmOufOEVFPaZ8IZ8l5gVPTqNBqPO59qSgKAqxcYAO42kw
	Lqf99dT2imE0Kbe/nhFsEj6z2CH0xqlxi/w==
X-ME-Sender: <xms:p0KXY9L7jVGRecdtV1BsrpGHX5RZIuAq_hOo3KnAkW-F-kpVN7bJsw>
    <xme:p0KXY5IAQdMyZFucVMcC_XOmwJvVmH-WeZ-oIRxqQhgT6aRBkA8wxa6X43Uwe8ZbA
    APkFDtbcN6mekLqEXU>
X-ME-Received: <xmr:p0KXY1vCKHMWIABoHo5LTf47XWWrg3P8E4jTJdnb6Lf-IuRJbDPVUXLFTRXFl7ate8lDa_XRW89uIvIFgnEX9x9ZTREHL5Fs-W-Y4Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekgdegkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefmlhgruhhsucfl
    vghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtthgvrh
    hnpeehkeevvdelueejteeffeevgfeiueegleduhedtheeltdefteegkeejkeehffekteen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:p0KXY-buvwHA7HSMp70Id30aucwRcPklGX2Ugr7oOUWQ3b4BHN2fYQ>
    <xmx:p0KXY0YgpxuXYlP-PuMUkjnPElIt0fYiLVlexQOyxxk9sd8FSGzGaw>
    <xmx:p0KXYyA-luIp-6PvRcC9QBWwv44OjB9gpdc2fnxBl0piEvyZTt2zOA>
    <xmx:qUKXY07TExrqh8sQZz13bgtJRr4tnaMNOz21G5Xqc1qWmNKZ7-e8wg>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Dec 2022 10:03:01 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-kernel@vger.kernel.org,
	Klaus Jensen <its@irrelevant.dk>,
	Klaus Jensen <k.jensen@samsung.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] nvme-pci: fix doorbell buffer value endianness
Date: Mon, 12 Dec 2022 16:02:43 +0100
Message-Id: <20221212150243.41283-1-its@irrelevant.dk>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1971; i=k.jensen@samsung.com; h=from:subject; bh=pxJNDl8z/idTl/CswBiokgDVOX6TDTlQcOByQIFgEs8=; b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGOXMchwq1RBbre4jil8uMe7uh7Elh6G4BXztt+w Ocm9dCjel4kBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJjlzHIAAoJEE3hrzFtTw3pXW YH/1255wB1gfHisAM9eUIme2xEgthZVQugLOJyBqXCq5FJa+/oVw6273qSuBBffp008C4tlkUfgAB8 TjgD1tN1vgALVrHKmoIGCMebymjxrSH9EU93HYFXPRq0RGADgnWiOMo6Ucbg/M5SYOHJ1iDgQIB19l vCjLwDGyinwepk2KQrQCmf82ELy8lPLKQuP1E4AqXltCUFGT9ehTSnsKL9kO6qWcIERNG1oCLsph/y ZVI2USj35vR/8qiwIlJ5nNGZ7zrQ3g9KJVcRrlM04WYVHHLnBim0ul/uu0lKS5EKi40ETH2kpn1jle /PfqvfJUWdzYeBj0xWbVVm9k3dM/AUteAm6Khn
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp; fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221212_070314_638961_6B980516 
X-CRM114-Status: GOOD (  12.22  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Klaus Jensen <k.jensen@samsung.com>

When using shadow doorbells, the event index and the doorbell values are
written to host memory. Prior to this patch, the values written would
erroneously be written in host endianness. This causes trouble on
big-endian platforms. Fix this by adding missing endian conversions.

This issue was noticed by Guenter while testing various big-endian
platforms under QEMU[1]. A similar fix required for hw/nvme in QEMU is
up for review as well[2].

  [1]: https://lore.kernel.org/qemu-devel/20221209110022.GA3396194@roeck-us.net/
  [2]: https://lore.kernel.org/qemu-devel/20221212114409.34972-4-its@irrelevant.dk/

Fixes: f9f38e33389c ("nvme: improve performance for virtual NVMe devices")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 drivers/nvme/host/pci.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index f005e8569266..d12d4c3cb6d0 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -347,7 +347,7 @@ static bool nvme_dbbuf_update_and_check_event(u16 value, u32 *dbbuf_db,
 					      volatile u32 *dbbuf_ei)
 {
 	if (dbbuf_db) {
-		u16 old_value;
+		u16 old_value, event_idx;
 
 		/*
 		 * Ensure that the queue is written before updating
@@ -355,8 +355,8 @@ static bool nvme_dbbuf_update_and_check_event(u16 value, u32 *dbbuf_db,
 		 */
 		wmb();
 
-		old_value = *dbbuf_db;
-		*dbbuf_db = value;
+		old_value = le32_to_cpu(*dbbuf_db);
+		*dbbuf_db = cpu_to_le32(value);
 
 		/*
 		 * Ensure that the doorbell is updated before reading the event
@@ -366,7 +366,9 @@ static bool nvme_dbbuf_update_and_check_event(u16 value, u32 *dbbuf_db,
 		 */
 		mb();
 
-		if (!nvme_dbbuf_need_event(*dbbuf_ei, value, old_value))
+		event_idx = le32_to_cpu(*dbbuf_ei);
+
+		if (!nvme_dbbuf_need_event(event_idx, value, old_value))
 			return false;
 	}
 
-- 
2.38.1


