Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2AD606A33B
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 11:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=XmDhcMJK;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nYXu1uiQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=pjbhVx2fs5v7PEkUYOgJa+aS4bC1ZGO8oQVzHBWC01U=; b=XmDhcMJKkFUgeL
	2MFB5RrLhOk3o5nk4JKZKl5iLcCK6TWq4cwXQ5uZc7kaw3J6eZ3dC8eTPsrw480/bdvcyiG2sBvTF
	JBNKHzqSnxt6OFHStggUYWvUCikl/yxK8txKFjmnKREJO9FRiNcisf+Izy1RpRReTsjKpY7nzeLFx
	TchkTD4xNcABgQo9gk9VB8GyKgS+esthDM1S1Ks/bS5fl13DvvQ5Zdk/VQJqs3svQyT/BhAhxGxUn
	UN/Eb3BCBvfLRRGJrDOw3Swo5x/ByOnLReQ9jG9KFFLuCE+mm0Oti1NdyRU5l+l8IUZUZ5BU09JSh
	sKc9tF54Of7RdiT8epjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSuWN-000000025Go-1Noo;
	Mon, 16 Nov 2026 11:05:11 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSuWM-000000025G8-3Xiv
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 11:05:10 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 95E0B46263;
	Mon, 16 Nov 2026 11:05:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D04171F0093E;
	Mon, 16 Nov 2026 11:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794827110;
	bh=pjbhVx2fs5v7PEkUYOgJa+aS4bC1ZGO8oQVzHBWC01U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=nYXu1uiQb94rPtCHLvJxnWX/TUDUZcHdjNN+JiXznWofO/Ao94RfItRka5GVt69Nd
	 56ZQzYNlXAl+s8vv/MrU8u9kvtGLL2+icBZWnMXmeoBkwje9K4MgBxwaU3dvYOUcB7
	 kGGgVDP3KnDjLMW+vvytpomBwqRACF5eYPYpd8kBMJoayxEvV3Y0RvdYx98QkT5CaK
	 maRZwaZ2Ay9bITJIM5uB6jEAX8BVeOoFxX+MwqN967mZuxjhRgAsGX7zHbZiJfy9vD
	 iUa59+RNlZIUWgraD/XFuuXksPNfW154MGZ8J/zg/hvkES9dSpVeywguSGp39q2+9g
	 97P9YY9aJ2raA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 16 Nov 2026 12:03:51 +0100
Subject: [PATCH v2 11/17] coredump: take freeze protection for the truncate
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-work-fs-frozen_writes-v2-11-ecc4a2aac40e@kernel.org>
References: <20261116-work-fs-frozen_writes-v2-0-ecc4a2aac40e@kernel.org>
In-Reply-To: <20261116-work-fs-frozen_writes-v2-0-ecc4a2aac40e@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 io-uring@vger.kernel.org, Christoph Hellwig <hch@lst.de>, 
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, 
 linux-unionfs@vger.kernel.org, bpf@vger.kernel.org, 
 linux-nfs@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1200; i=brauner@kernel.org;
 h=from:subject:message-id; bh=34ncq8Kdq+MSTLVnNDtgt7r/DShig8xHabTi/tdVmLw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT9eqzVKTV/xdpjUtYvDKKMtkfu+/pAYoskz9s09sIX2
 zharnlHdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEykZSHDf7cN0mGeKyubxTpC
 60IvHJxm/OTpFmOeMo4pz+f+73sweQbDP1vh6dcLH1+ZrugULr/z0EeeCduWNHB9dro4297B6vW
 GRwwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

coredump_file() truncates the core file after filp_open() returned.
The open took freeze protection for the create but dropped it again
before returning and coredump_write() only takes it for the dump
itself. So a freeze that lands in between lets the truncate modify a
frozen filesystem.

Take freeze protection around the truncate like do_ftruncate() does.

Fixes: 14da9200140f ("fs: Protect write paths by sb_start_write - sb_end_write")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/coredump.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 82ef9d115999a..cc6a0c7e48ce2 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1060,8 +1060,10 @@ static bool coredump_file(struct core_name *cn, struct coredump_params *cprm,
 	}
 	if (!(file->f_mode & FMODE_CAN_WRITE))
 		return false;
-	if (do_truncate(idmap, file->f_path.dentry, 0, 0, file))
-		return false;
+	scoped_guard(super_write, inode->i_sb) {
+		if (do_truncate(idmap, file->f_path.dentry, 0, 0, file))
+			return false;
+	}
 
 	cprm->file = no_free_ptr(file);
 	return true;

-- 
2.53.0


