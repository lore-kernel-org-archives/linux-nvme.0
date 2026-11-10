Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682F0606A8B3
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Nov 2026 21:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=QWaEU+Ob;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=WPY4PaN9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Mime-Version:Date:References:In-Reply-To:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=e4ojIjypxpGFfHLcr9bc7NYtjzNqTM2+V21XA6rWCBM=; b=QWaEU+ObjN06Q6EHU2/KRdH+oR
	TLW2XmdN7QKhLDkReuI6fud4CPV3tp5J6Z/c2V5sIOH5zkP97j334DzdRtbZgJlBuiNqgiznNdZXm
	BeDReMaKedrA3w32DcYQr8SkpG2H9gi5ib95zpk9jBAZyAK28MSboLiKYTyyf3rLWO4QrZLNqXGWk
	F70zwu05jddECTFgLW3Scw/UczSAreFeqKV3P3jkrqBjP1XpZOVs4MFwea5/gWC8gvPyNidfIHKhZ
	z1cioalRoWsQ6772eGt+nX43EWcw+upr8aA4TmFReCcH1XMV6WILXQdiUosbUna4PzYSsze/JXiNk
	Aw//QRDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRFhz-00000007leb-2uGU;
	Wed, 11 Nov 2026 21:18:19 +0000
Received: from mxct.zte.com.cn ([183.62.165.209])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQnNZ-00000004J7c-3mTK
	for linux-nvme@lists.infradead.org;
	Tue, 10 Nov 2026 15:03:23 +0000
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jP8zL2Bkwz4xNty;
	Tue, 10 Nov 2026 23:03:10 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794322990;
	bh=esywIpnBzUeJpgm9FcNnCUHVepzzgXDRhZGqSs8qLD0=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=WPY4PaN9suiNoURjzOXv7BZPw1xatWi5LQHXqd7pTMmANdwLx/fOpI7SNXLALo3jx
	 J/xDNuzuaV4tJAcOPNSymEG7J4JVlYfgiv0GuK5jcxRVyPghrFJWSlhjKpQIRNk1SZ
	 X0HEu92QoTl9Cw/jCtZ9L+l6kocI86fnXIkkKnluh05iuX26/G2Ccs3AxoIsehfdJv
	 XxPd4uSbDzlhnQGsEeqfhtT3nM9lKf2uTkrt4D2fikCkUQFKr6LQ7130Kr1jNxlIwe
	 b8F7a4zJA2mw4g16TRZvBqWyzXN4PhVuT4yN5yyE3yRmbOoqS1E3qkdvcyaPSPXkPq
	 7rTnDumAkgyvw==
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl1.zte.com.cn with SMTP id 6AAF38pd011120;
	Tue, 10 Nov 2026 23:03:08 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 10 Nov 2026 23:03:12 +0800 (CST)
X-Zmail-TransId: 2afc6af3323029a-018de
X-Mailer: Zmail v1.0
Message-ID: <202611102303123637sawEnPImm3RHiCLaBc7X@zte.com.cn>
In-Reply-To: <20261110230304050fijuDcYKyYPS3lffioSeA@zte.com.cn>
References: 20261110230304050fijuDcYKyYPS3lffioSeA@zte.com.cn
Date: Tue, 10 Nov 2026 23:03:12 +0800 (CST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <kbusch@kernel.org>, <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>
Cc: <justin.tee@broadcom.com>, <nareshgottumukkala83@gmail.com>,
        <paul.ely@broadcom.com>, <kch@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIDMvNl0gbnZtZS10Y3A6IHJlcXVpcmUgdGhlIFIyVCBvZmZzZXQgdG8gbWF0Y2ggdGhlIGRhdGEgc2VudA==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 6AAF38pd011120
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Tue, 10 Nov 2026 23:03:10 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF3322E.001/4jP8zL2Bkwz4xNty
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261110_070322_111095_823B54CD 
X-CRM114-Status: UNSURE (   9.48  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -4.4 (----)
X-Mailman-Approved-At: Wed, 11 Nov 2026 13:17:03 -0800
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
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
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

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index bc46e5f3eaa7..2672aeae086a 100644
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

