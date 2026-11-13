Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531EA606A327
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2026 19:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=vn+qmeuR;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=gZmUFcaR
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Mime-Version:Date:References:In-Reply-To:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Qz4lwjhN+zy9UnJUi+NL0/dL5i5uur8jmQ6VApJh9bA=; b=vn+qmeuRdWY37J1HsSdj8n32yo
	KFj2bcpfEn2wVRSq3rYQxHa8lQ3VXyJOwMXoXAQm5vCRAW43VoGso9PYlc6bXg7iiYcHwmcf2PR0j
	EcWaBdQNiR+Fz2e6pOPxLd3L2zvj3Yp+jcf7GjYj8A9kxj9NSI19RlQB87q06zF+9SZzRqPqpU8ia
	HZI5N2reUxAsJczh5SlHfaprTW6yYclx9uofsKaEaXW1x6ZN2y3Lz55jBmRXD94ZIgNWfsj76+v+4
	8hxjj83eNH2+a32bykixa0/HXRF2MxlK9eafIN+XXUYLMJRwWJPiCfJVCTLmwasnEovoDGZCc6ax9
	eHggonfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRx3t-0000000EDkY-2SE0;
	Fri, 13 Nov 2026 19:35:49 +0000
Received: from mxct.zte.com.cn ([183.62.165.209])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRvc4-0000000DozI-0xOJ
	for linux-nvme@lists.infradead.org;
	Fri, 13 Nov 2026 18:03:02 +0000
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jR4qL4Mt2z51Sm6;
	Sat, 14 Nov 2026 02:02:54 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794592974;
	bh=UNN0dxgDClL2hwhFYfXAElfpVz8W23wJyKVhsYOTWPE=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=gZmUFcaR+po4DKC2TPjJJ+kTPFPt3BHZ/6NUd7FzsvF2qmdOJU6q5+nhjO+enmTYl
	 IGZ6IJszvWf7HSVbKLZiRHOoe4yCBdK0QQjkFYdV17HMGiapjh8ND1KjBmKDavdlcx
	 gwFqC7Wvr2D9hgfX5fWUzcJ68eb4DFJ+hWNp4DDThO1bXKEGEWjMTI412LcZcEnJAV
	 9ljmjXSBuQqyl1TyOj46SXVbP268t14d8GM2kh0NKSerNrWAXmJs7MIst/AUAoutca
	 kGypSiMLIIK/2tj/indXLDdfllwfxezDd0J9/bfXmQEVaDxiBpRatUQRMuF+jvZZzi
	 0k0QiuCHK9S6Q==
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 6ADI2k4G099800;
	Sat, 14 Nov 2026 02:02:46 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 14 Nov 2026 02:02:50 +0800 (CST)
X-Zmail-TransId: 2af96af750cacee-15c34
X-Mailer: Zmail v1.0
Message-ID: <20261114020250679P6SJTYtDDk-oB-bT_GjsW@zte.com.cn>
In-Reply-To: <20261114020245882Mvd6t10TkCZuRWpYFR3m5@zte.com.cn>
References: 20261114020245882Mvd6t10TkCZuRWpYFR3m5@zte.com.cn
Date: Sat, 14 Nov 2026 02:02:50 +0800 (CST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <kbusch@kernel.org>, <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>
Cc: <justin.tee@broadcom.com>, <nareshgottumukkala83@gmail.com>,
        <paul.ely@broadcom.com>, <kch@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIHYyIDMvNl0gbnZtZS10Y3A6IHJlcXVpcmUgdGhlIFIyVCBvZmZzZXQgdG8gbWF0Y2ggdGhlIGRhdGEgc2VudA==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 6ADI2k4G099800
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Sat, 14 Nov 2026 02:02:54 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF750CE.000/4jR4qL4Mt2z51Sm6
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261113_100300_739082_65EA2E91 
X-CRM114-Status: GOOD (  13.45  )
X-Spam-Score: -4.4 (----)
X-Mailman-Approved-At: Fri, 13 Nov 2026 11:35:09 -0800
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Shao Mingyin <shao.mingyin@zte.com.cn>

nvme_tcp_handle_r2t() rejects offsets below data_sent but accepts
larger offsets.  The send iterator still points at data_sent, so the
next H2CData PDU carries bytes from that position while advertising the
larger offset.  A target that accepts the PDU can place the data at the
wrong position; the Linux target rejects it and fails the connection.

Require the R2T offset to equal data_sent, rejecting the invalid request
before transmitting data with a mismatched offset.

Fixes: 3f2304f8c6d6 ("nvme-tcp: add NVMe over TCP host driver")
Cc: stable@vger.kernel.org
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Changes in v2:
- Code and commit message unchanged; add Christoph Hellwig's Reviewed-by tag.
Previous version: https://lore.kernel.org/all/202611102303123637sawEnPImm3RHiCLaBc7X@zte.com.cn/

Tested on 7.3.0-next-20261030 (QEMU/TCG guest) with the nvmet-tcp
target on 127.0.0.1; no extra hardware is needed.

A test-only hook in the nvmet-tcp target shifts the R2T offset by one
4 KiB block.  The 4 KiB write to a loopback namespace is then answered
with an R2T at offset 4096 although the host has sent 0 bytes, so the
host either transmits an H2CData PDU with the wrong offset (unpatched)
or rejects the R2T (patched):

  unpatched                            patched
  nvmet_tcp: ttag 2 unexpected data    nvme nvme0: req 99 unexpected
  offset 4096 (expected 0)             r2t offset 4096 (expected 0)

In the unpatched case the target detects the mismatched H2CData offset
and rejects it.  This test demonstrates transmission of an incorrect
offset, not a successful corrupted write.  With the patch the host
rejects the R2T before transmitting H2CData.

 drivers/nvme/host/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index bc46e5f3eaa79ed402cd238caa7300ff7a7bb156..2672aeae086a9a1605d9c64dc73ab837beca05a3 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -846,7 +846,7 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
 		return -EPROTO;
 	}
 
-	if (unlikely(r2t_offset < req->data_sent)) {
+	if (unlikely(r2t_offset != req->data_sent)) {
 		dev_err(queue->ctrl->ctrl.device,
 			"req %d unexpected r2t offset %u (expected %zu)\n",
 			rq->tag, r2t_offset, req->data_sent);
-- 
2.27.0

