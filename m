Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F67606A323
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 19:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=CsavccaL;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=s/E2t7Tq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Mime-Version:Date:References:In-Reply-To:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=EFB6pKr0axxbQJKX6PGyT2Y/es1tTUX6URN47Nk5Agg=; b=CsavccaLhUw2b2S3/80okzcVxr
	00ZHeJxB3ynj9YqdMLpOned9So4w3kg3QehTCME9l7VwM4kkTkDjXSAtzGZ5yOf/PdljQ91H6ZVQR
	rrYUUny3+D74RTZuiLtbuiL/OYXRDi6AvX57G8Wh0SlQEsZv2JL/IoxDs15tPIqRtXa8A8+geaY8c
	v80VlYMX2OGPfGy6sBRQGV+i7vOHqHzHoGO2BxMnJyGVPknsPtuIR5swMCpuJoKpwu5wzpF5F1EKU
	CXLmw0d1+QBnOXdcNpEsWTszMRGZvwyKueBFACo4/JVh/7hR/6IVS0PXV+Ldey2YpTKeBVRe1tJ+E
	BFB0ZkVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSJAJ-0000000GeHU-2MGp;
	Sat, 14 Nov 2026 19:11:55 +0000
Received: from mxhk.zte.com.cn ([160.30.148.34])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSHXm-0000000GWy9-13za
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 17:28:04 +0000
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jRh0c12RNz4yjS5;
	Sun, 15 Nov 2026 01:28:00 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794677280;
	bh=I1JG6le6Uef8Mt4c0Q+i/wiVYoqj4sIPEdX4T175tuY=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=s/E2t7TqGkFshyW9bTVLC6is4aTXF/0bMqlDyKlEZcn1b8LYH1QarlIyWIv37TuMM
	 tTqLQM58d7DWv3PefspZ2rccCgdPakucxD/F3KCT+31q153n7dG8LRPMlnyS/oz9o1
	 Fq7eZe7SZqrTVSRBLjatFCVWoZzcXLuil6Iy27MGV3ly3wAC6OipOk2hMqd4oV7roT
	 JJHlF1U+hIDpAgPrJAJhpUDIoY8rsc95of1s3vCZ60ueLxN86iNm4jMZfLyrRbr63z
	 7iq6c3gWc3QjG75iALqrvlw64Uwm44J8Q2yS1gcuJBUhaicGZZth7cM/XqN0wTYABP
	 WvZEpiD5nad+g==
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl2.zte.com.cn with SMTP id 6AEHRrTL016767;
	Sun, 15 Nov 2026 01:27:53 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Sun, 15 Nov 2026 01:27:55 +0800 (CST)
X-Zmail-TransId: 2af96af89a1bfaa-57f53
X-Mailer: Zmail v1.0
Message-ID: <20261115012755704MxVgLMp__EddTP_3H7nCd@zte.com.cn>
In-Reply-To: <202611150127512368BGQ07ZNIRAIwClkam-8u@zte.com.cn>
References: 202611150127512368BGQ07ZNIRAIwClkam-8u@zte.com.cn
Date: Sun, 15 Nov 2026 01:27:55 +0800 (CST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <kbusch@kernel.org>, <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>
Cc: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIDMvNV0gbnZtZXQ6IHZhbGlkYXRlIHRoZSBMQkEgZm9ybWF0IGNvdW50IG9mIGEgcGFzc3Rocm91Z2ggbmFtZXNwYWNl?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 6AEHRrTL016767
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Sun, 15 Nov 2026 01:28:00 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF89A20.000/4jRh0c12RNz4yjS5
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261114_092802_663794_D93E2AB9 
X-CRM114-Status: GOOD (  11.60  )
X-Spam-Score: -2.1 (--)
X-Mailman-Approved-At: Sat, 14 Nov 2026 11:11:53 -0800
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

nvmet_passthru_override_id_ns() clears the metadata size of every LBA
format reported by the backing controller:

	for (i = 0; i < (id->nlbaf + 1); i++)
		if (id->lbaf[i].ms)
			memset(&id->lbaf[i], 0, sizeof(id->lbaf[i]));

The Identify Namespace data comes from the backing controller and nlbaf
is a u8 in that structure, while the LBA format table has only 64
entries.  A broken or malicious backing controller can report nlbaf =
0xff, which makes the loop clear the vendor specific fields that follow
the LBA format table and return an inconsistent identify structure to
the host, e.g. a format count that does not match the table.

Reject such an identify data structure and return an internal error
instead of rewriting unrelated fields.

Fixes: c1fef73f793b ("nvmet: add passthru code to process commands")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Tested on 7.3.0-next-20261030 (QEMU/TCG guest) with the loop transport.
A passthru subsystem is backed by a file-backed loop namespace, so the
host driver and the target run in the same guest.  A TEST-ONLY hook
makes the backing Identify Namespace report nlbaf = 0xff; only the
nvmet fix differs between the two runs.

Sending Identify Namespace (CNS = 0) to the passthru controller, the
unpatched loop runs (nlbaf + 1) = 256 times against the 64-entry LBA
format table and clears the 768 vendor bytes right after it:

  unpatched                            patched
  identify accepted (ret = 0)          identify rejected (ret = 6,
  nlbaf = 0xff                        NVME_SC_INTERNAL)
  vs[0..767] cleared to 0              no data returned
  vs[768] still 0xaa

 drivers/nvme/target/passthru.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 6b67880c7bb2..30c06bf0e5f1 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -195,6 +195,11 @@ static u16 nvmet_passthru_override_id_ns(struct nvmet_req *req)
 	if (status)
 		goto out_free;
 
+	if (id->nlbaf >= ARRAY_SIZE(id->lbaf)) {
+		status = NVME_SC_INTERNAL;
+		goto out_free;
+	}
+
 	for (i = 0; i < (id->nlbaf + 1); i++)
 		if (id->lbaf[i].ms)
 			memset(&id->lbaf[i], 0, sizeof(id->lbaf[i]));
-- 
2.43.0

