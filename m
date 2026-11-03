Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D322606A32D
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Nov 2026 16:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=4X1BFkcT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Mime-Version:Date:References:In-Reply-To:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=z7BFpxHBFAMv9NUJbg2Nh0kMD5DcNem/O4u4vl1QoWo=; b=4X1BFkcT7lbIB2lR9F1K551eqY
	h5Z+drAkfgXago+Qbb+GdgBOEGLDiZfme1adI3yXkFyRKMbGo8JULMMkcAkp2194P17RIzq+idNH2
	18ccTnSpN+UIBp1rJbS/nY2kaGTp1Fw0dTlv9jz2mgSutIqWmyAR5fM3shV2v5W60FvgcNvbJt2l+
	5yfUuRJCAky9fogK16CFmFyK2XqCjbz/Jv6zBvSVBGS3JdZJs+EnKsCA4IfnmEt5vS2Q2lafmYLuk
	WT1EcpYujZAqzvjuebtgMYWTbgJwyBFwBNHuphP5OOQ3vD0brJ9llcypgD+dCKSqEmUNbmXd9cNqR
	owVyDigg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOdSC-00000005sHI-0Qxj;
	Wed, 04 Nov 2026 16:03:12 +0000
Received: from mxhk.zte.com.cn ([160.30.148.34])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOJr0-00000003URl-1OKp
	for linux-nvme@lists.infradead.org;
	Tue, 03 Nov 2026 19:07:31 +0000
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jJykS4TDmz5B0rY;
	Wed, 04 Nov 2026 03:07:28 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl1.zte.com.cn with SMTP id 6A3J7Ldi084634;
	Wed, 4 Nov 2026 03:07:21 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 4 Nov 2026 03:07:25 +0800 (CST)
X-Zmail-TransId: 2afa6aea30eddb9-da2f8
X-Mailer: Zmail v1.0
Message-ID: <20261104030725983jzZdkZpfTBDh22QD5TL5N@zte.com.cn>
In-Reply-To: <20261104030720567AV9nG8iiGp4C0YlWIDDs7@zte.com.cn>
References: 20261104030720567AV9nG8iiGp4C0YlWIDDs7@zte.com.cn
Date: Wed, 4 Nov 2026 03:07:25 +0800 (CST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <kbusch@kernel.org>, <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>
Cc: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIDEvMl0gbnZtZXQ6IHRha2Ugc3Vic3lzLT5sb2NrIHdoZW4gZm9yY2luZyByZWNvbm5lY3RzIGZvciB0Ymthcw==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 6A3J7Ldi084634
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Wed, 04 Nov 2026 03:07:28 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEA30F0.000/4jJykS4TDmz5B0rY
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261103_110730_538765_8659EEA4 
X-CRM114-Status: UNSURE (   5.51  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -1.9 (-)
X-Mailman-Approved-At: Wed, 04 Nov 2026 08:03:11 -0800
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

nvmet_subsys_attr_tbkas_store() walks subsys->ctrls to force a reconnect
while holding only nvmet_config_sem.  The list is protected by
subsys->lock: nvmet_alloc_ctrl() adds entries and nvmet_ctrl_free()
removes them under that lock, and the controller free path does not take
nvmet_config_sem.  Writing attr_tbkas concurrently with a controller
going away, for example on a keep-alive timeout or a fatal error, can
therefore dereference a controller that has already been removed and
freed.

Take subsys->lock around the list walk, as
nvmet_subsys_attr_qid_max_store() already does for the same loop.
delete_ctrl() only schedules the asynchronous teardown, so it does not
recurse into subsys->lock.

Fixes: e98e45e9465b ("nvmet: Add traffic based keep alive support to configfs")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Tested on 7.3.0-next-20261030 (QEMU/TCG guest, KASAN) with the loop
transport.

One process hammers the attr_tbkas store while another connects and
deletes loop controllers, so the walk over subsys->ctrls races with
nvmet_ctrl_free():

  unpatched                            patched
  general protection fault,            no report in 60 s,
  KASAN wild-memory-access 0xdead...   39591 iterations
  in nvmet_subsys_attr_tbkas_store

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index b3a5242d06f9..c17f2c8ab2df 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1466,8 +1466,10 @@ static ssize_t nvmet_subsys_attr_tbkas_store(struct config_item *item,
 	subsys->tbkas = tbkas;
 
 	/* Force reconnect */
+	mutex_lock(&subsys->lock);
 	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry)
 		ctrl->ops->delete_ctrl(ctrl);
+	mutex_unlock(&subsys->lock);
 	up_write(&nvmet_config_sem);
 
 	return count;

