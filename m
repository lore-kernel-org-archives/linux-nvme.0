Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B252A606A32E
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2026 19:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=k6pjsfYz;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=Mw2jAWKW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Mime-Version:Date:References:In-Reply-To:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=0tiw501LQlDT/C/vtvjmBBlL6OpfGScC/n0wVEWEnzo=; b=k6pjsfYzJ/VM/ZA3/vbbGPMfou
	maflaufnX/SbZknTtocXLultIr1mbMHgUZEETHnS2l82rBV2szrbq9+2td+YkR/m5JuIjFtPfOyW4
	3qfVbT4n0tPXwuPV3Sx1kHvF8LeNI0sSyhRHnIiSVLJw/QD+jWNcqQaSrea5UnV7UhJXBjCiYvKNP
	r7Rv8e4DM4TiiytAbtQIBFp2We85wXY8mwEg5V3dYf5/sbuSXWjp2YJJh4yJ1oP6hcKJrbywLLTpv
	NMPAQBGl+XKxY4kl9kj81ltFyK1M2H1y7z8t3UqAE2uyz+BgaufuNIU7IIWKuguuG2O0hqN+cVHaL
	igF5/Y3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRx3v-0000000EDvB-3g9z;
	Fri, 13 Nov 2026 19:35:51 +0000
Received: from mxhk.zte.com.cn ([160.30.148.34])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRvc4-0000000DozG-17ef
	for linux-nvme@lists.infradead.org;
	Fri, 13 Nov 2026 18:03:02 +0000
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jR4qM2R50z5B0yy;
	Sat, 14 Nov 2026 02:02:55 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794592975;
	bh=o2bgXvusxuIZ0pl55yltht2SatK+daXQrJdQ1UvZbdM=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=Mw2jAWKWk1vYg3Kw2Hvvo8GZT2/gUJeFUsxH9/FYLSxd8JDWDTjqCetiYiXt1WKmX
	 YhMweOo1RRv3EihvwikLHJuSylZmbNkFShChYrbOcl5rJ3lI3MzG9Y8zyXT85HaETB
	 Cjb//FdSVocplwNJDlcAjVlptASiiilbQdu98Jg1/5+TLV57obUXXxfNKcuZG5fKu4
	 RUkPdFoU9dltvrM3MY8pIfG4xYXZ7CUPXKxwelZ8jRxtASO7zkpD9bIhuVxOyfFN5h
	 YMXvPpnYmyTp1Ze+8UUvt3mLSMSC+up3H4ZHhUkt4+qmqtfczQPNDDYMe0r175CgeR
	 1WnI2w1Q+1mFA==
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 6ADI2nKc099801;
	Sat, 14 Nov 2026 02:02:49 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 14 Nov 2026 02:02:53 +0800 (CST)
X-Zmail-TransId: 2af96af750cdd92-15cd8
X-Mailer: Zmail v1.0
Message-ID: <20261114020253302taupmFxThUvQwCc2ab2CI@zte.com.cn>
In-Reply-To: <20261114020245882Mvd6t10TkCZuRWpYFR3m5@zte.com.cn>
References: 20261114020245882Mvd6t10TkCZuRWpYFR3m5@zte.com.cn
Date: Sat, 14 Nov 2026 02:02:53 +0800 (CST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <kbusch@kernel.org>, <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>
Cc: <justin.tee@broadcom.com>, <nareshgottumukkala83@gmail.com>,
        <paul.ely@broadcom.com>, <kch@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIHYyIDQvNl0gbnZtZXQtZmNsb29wOiBmcmVlIHRoZSBMUyByZXF1ZXN0IHdoZW4gZGVsaXZlcnkgZmFpbHM=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 6ADI2nKc099801
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Sat, 14 Nov 2026 02:02:55 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF750CF.001/4jR4qM2R50z5B0yy
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261113_100300_738028_87F25C71 
X-CRM114-Status: GOOD (  10.57  )
X-Spam-Score: -2.1 (--)
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

fcloop_h2t_ls_req() allocates a fcloop_lsreq from lsreq_cache and hands
it to nvmet_fc_rcv_ls_req().  That function only takes ownership on
success and returns an error without invoking any completion callback
when the target port is shutting down, the LS payload is too large, or
the target has no free LS request slot.  The error is returned as-is, so
the fcloop_lsreq is leaked; every failed LS during a target port
teardown or an LS slot exhaustion loses one slab object.

The target-to-host direction already frees the request when
nvme_fc_rcv_ls_req() fails.  Do the same here.

Fixes: 772042dd38ee ("nvmet-fcloop: allocate/free fcloop_lsreq directly")
Cc: stable@vger.kernel.org
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Changes in v2:
- Code and commit message unchanged; add Christoph Hellwig's Reviewed-by tag.
Previous version: https://lore.kernel.org/all/20261110230313720JCGXeTg2zOideed82vWy9@zte.com.cn/

Tested on 7.3.0-next-20261030 (QEMU/TCG guest) with the fcloop
loopback transport (nvme-fc host + nvmet-fc/fcloop target); no real
FC HBA is required.

The -ESHUTDOWN error path is otherwise only hit in a sub-instruction
teardown race, so it is exercised with two TEST-ONLY changes (not part
of this patch): a debugfs knob that makes nvmet_fc_rcv_ls_req() return
-ESHUTDOWN, and SLAB_NO_MERGE on lsreq_cache so the 72-byte
fcloop_lsreq does not merge into a kmalloc cache.  A stock host sends
120 Create Association LS with ctrl_loss_tmo=0 (each failure deletes
the controller); the cache is shrunk afterwards, which only reclaims
empty slabs:

  unpatched                            patched
  lsreq_cache objects 0 -> 120         lsreq_cache objects stays 0
  slabs 0 -> 4                         slabs stay 0

 drivers/nvme/target/fcloop.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index b63af3b643a648dc6878ab5afaa711b6294bf5c3..a9cde536c33ba11ced49bf74314aa5eed714df48 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -379,6 +379,8 @@ fcloop_h2t_ls_req(struct nvme_fc_local_port *localport,
 	ret = nvmet_fc_rcv_ls_req(rport->targetport, rport,
 				  &tls_req->ls_rsp,
 				  lsreq->rqstaddr, lsreq->rqstlen);
+	if (ret)
+		kmem_cache_free(lsreq_cache, tls_req);
 
 	return ret;
 }
-- 
2.27.0

