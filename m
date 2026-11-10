Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A080606A32E
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Nov 2026 21:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Q+yaDn1b;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YSj0RR1a
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=qJiFf9w4hToXcclP9ppmON8B46ZerQobJ1F8sM9X2a8=; b=Q+yaDn1bpXb7Td
	YUic+B1nBzBKeicEszLSvupv6BxmTdTorFG/svtCO6SDnU94zX5NTGDpc0HmUDC3//HAgDMzPef9f
	vIpWbgncF7VXqtsg/jPOK02i0CqrkAidIndqWAdtQIuj64tNsYmJcLSToD+2NnjXYeJM/qSNLrNH5
	UKT7JQy8nik4VGwV4eIUpnw7DRPh2qxQQ8garyIMG/triUgLlV787L26FjxPrQ4PAmtDxojD20mTX
	7pw4st08ga7l7CP4o2hAmHcjtgOZxyalTm/fUcbjNqIGCYnn5Yewzp1nV325UftLjHUjx7J2BUUO3
	96tuNPSYNfxS3rA9d7GQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRFhK-00000007k2x-1FjW;
	Wed, 11 Nov 2026 21:17:38 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQi1F-00000003Eri-127H
	for linux-nvme@lists.infradead.org;
	Tue, 10 Nov 2026 09:19:57 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0712846B0B;
	Tue, 10 Nov 2026 09:19:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F39D1F008A1;
	Tue, 10 Nov 2026 09:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794302396;
	bh=qJiFf9w4hToXcclP9ppmON8B46ZerQobJ1F8sM9X2a8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=YSj0RR1aG6qNPyxHpaLvknjLVj91ILD+92zWFulNcS/9GzuRoaQHatZawU0nYbR8y
	 wus7ohgAGQBai1txsuKrJnXmIbOHGPu8ofJJf/FVDtHI8ClyJKzU7qfsjBbW0aZ+ce
	 zWv3AeSLtwvY+Mjd5A9NqJjMByywMDui/mH5eL6dgY9srHxtjNOSh4WuAXPTmUK3oc
	 rj74FmSQAg97IU/fPvixOSTy1hGHbrW8yJHlHbDd2o5Lngy9Nmbmsk6Ah2dyvn2OaD
	 xaVAA8ELW3uvaLp+l18HV1m2/38wuA8CuBANF9a3ezWOwggIRGtvqG3gki5e2MoaKT
	 vZL834m+QNo/A==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 10 Nov 2026 10:14:51 +0100
Subject: [PATCH RFC 35/41] zloop: refuse zone files on pseudo filesystems
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-work-loop-pseudo-v1-35-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
In-Reply-To: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Chris Mason <mason@kernel.org>, 
 Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org, 
 target-devel@vger.kernel.org, driver-core@lists.linux.dev, 
 linux-mm@kvack.org, bpf@vger.kernel.org, 
 linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
 apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org, 
 netdev@vger.kernel.org, fuse-devel@lists.linux.dev, 
 linux-efi@vger.kernel.org, xen-devel@lists.xenproject.org, 
 ocfs2-devel@lists.linux.dev, linux-s390@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-usb@vger.kernel.org, 
 Amir Goldstein <amir73il@gmail.com>, linux-erofs@lists.ozlabs.org, 
 linux-kselftest@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=822; i=brauner@kernel.org;
 h=from:subject:message-id; bh=li+gC8cc0Mt1bD1j4gMcmL8SOHESlN2++n5Uf9tP8Fo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR9erDHcu21pTOZuhx19nwxdyrrCmUMb3503015p6SPw
 76FMcqxHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABN5bMvwv9AwrjaFoTvl5SXZ
 U7d+5SbufCNqdW372nkxojHPVJnq7Rn+R03u+RT9ITNnZY8fx/JF32OmNseuuiD0fVMyz/+nq9X
 nMAAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Mailman-Approved-At: Wed, 11 Nov 2026 13:17:02 -0800
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

zloop opens its zone files by name below the base directory but a bind
mount can put any file there, including a procfs or sysfs file. Refuse
files on pseudo filesystems as zone files just like loop does.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/block/zloop.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
index 65634a39b0bf..dcc06dd47b04 100644
--- a/drivers/block/zloop.c
+++ b/drivers/block/zloop.c
@@ -1137,6 +1137,11 @@ static int zloop_init_zone(struct zloop_device *zlo, struct zloop_options *opts,
 		goto out_fput;
 	}
 
+	if (file_is_pseudo(zone->file)) {
+		ret = -EINVAL;
+		goto out_fput;
+	}
+
 	if (zlo->block_size) {
 		ret = zloop_get_block_size(zlo, zone);
 		if (ret)

-- 
2.53.0


