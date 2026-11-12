Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505D860A3838
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Nov 2026 14:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=JpIO3/jg;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=FInfaeEA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Mime-Version:Date:Message-ID:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=ehMAux4zPO59WGmXjV45w0rvQhEn3+ok2cfsvTCiEm8=; b=JpIO3/jgq00ll6RhFqkbTpWY18
	xMPgJylxkfRBUvsgOAQ7ltXaRhdzCFWjgTauAIJmETiLaTXOpJEe9f6yEeXwNpzEmBo4TIw6p8H7/
	/4Nqr+qVxd4c0g9zYI8Fre45AUnSaVmGQujcWnq2wFE863SuxJei2hdk4QgRk/g5AwNGS6020TCyW
	y6o9yPgwm42T+2NLAZYh2+r2fvcqf1SIv+8eVcA/faveCOQK0mHt/68YXclBgyr+oEvvkKBc8q4ca
	r1Ry0oepxVm1PUd+b3UnO51VH5gTrM6sd6wDmLB3ksi8SBKijRcRgPZLGCJftGRZR/EmrysFu9kBy
	kn6hhUIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRVMd-0000000AANh-1hG2;
	Thu, 12 Nov 2026 14:01:21 +0000
Received: from mxhk.zte.com.cn ([160.30.148.34])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRVMV-0000000AAM1-1vqn
	for linux-nvme@lists.infradead.org;
	Thu, 12 Nov 2026 14:01:14 +0000
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jQMVj6LXNz4yjjF;
	Thu, 12 Nov 2026 22:01:01 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794492061;
	bh=2vd7az9105wcSaW62eUNl1HKGlFkwj5Se2CmMaZM/+M=;
	h=Date:From:To:Cc:Subject;
	b=FInfaeEAsyzxZEXYqHjivnoIpff+/7/yIUXlruzPUln8QVtJLfRNOwdqlaXq9KzzV
	 YHyVQDnVQnkFcicoF9cW/7HfbygM1EW961hX2XjqC4vcTc8yOtSj3T2frbk/PiEr1s
	 XfbfdviZ0C3fqbzS71AhBMlGp550PT0xdGNwHtf/rWhIc0pSgXIywVJpN8LjTa4EiW
	 QldLmqE/IKAtDFXnEKvt+5bvo7Pbhl2U+bjdCn2eE52D6clytFKB3vUyJsiPHUmn9H
	 rzVI58rM4/XqC/uBTdojt4vTS+/KGPaZDmVBHzaxP9EaykZfuf9UA1/0no/wLRZgyp
	 Ax9cjAct9hDwA==
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 6ACE0t93045249;
	Thu, 12 Nov 2026 22:00:55 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 12 Nov 2026 22:00:58 +0800 (CST)
X-Zmail-TransId: 2afb6af5c69a44a-d4bc8
X-Mailer: Zmail v1.0
Message-ID: <20261112220058755zQhw_h6UkcVSjRnu478lb@zte.com.cn>
Date: Thu, 12 Nov 2026 22:00:58 +0800 (CST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <kbusch@kernel.org>, <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>
Cc: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIHYyIDAvMl0gbnZtZXQ6IGZpeCBmaWxlIGJhY2tlbmQgc2hvcnQgSS9PIGFuZCBMQkEgcmFuZ2UgY2hlY2tz?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 6ACE0t93045249
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Thu, 12 Nov 2026 22:01:01 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF5C69D.002/4jQMVj6LXNz4yjjF
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261112_060112_785973_2AEA9E6C 
X-CRM114-Status: UNSURE (   6.15  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The file backend computes byte offsets from the LBA and block size with
unchecked 64-bit arithmetic and does not handle short reads or writes.
A host can therefore make the backend report success for a transfer that
only covered part of the range, and a large LBA or length can wrap the
range check and reach vfs_fallocate() with an out-of-range offset.

Patch 1 makes nvmet_file_execute_io() stop at an incomplete submit
instead of advancing the position and eventually reporting success, and
converts a zero-byte completion on the common path to -EIO.  Patch 2
adds a shared overflow-safe range check and uses it for read, write,
discard and write zeroes.

The two patches are independent and can be applied in any order.  Both
carry Fixes: and Cc: stable.

Changes in v2 (Christoph Hellwig):
- Patch 2: use the shared LBA range helper for reads and writes, with
  pos64 local to the helper. No functional change from v1.
- Patch 1: unchanged; add Christoph Hellwig's Reviewed-by tag.
Link to v1: https://lore.kernel.org/all/20261111224134934XG6vMtntrNJQL1ztj7imr@zte.com.cn/

Shao Mingyin (2):
  nvmet: handle short reads and writes in the file backend
  nvmet: use overflow-safe range checks in the file backend

 drivers/nvme/target/io-cmd-file.c | 47 ++++++++++++++++++++++++++++-----------
 1 file changed, 34 insertions(+), 13 deletions(-)

---
base-commit: ddfe51b0a0f5dc9e415cc2c8ad8db17532dd426b

