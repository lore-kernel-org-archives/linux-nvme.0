Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC59606A339
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Oct 2026 08:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ClOxTdjj;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RnAE5EuM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=HgrAxwNlbkxj3ofFZk3KrlI08hFpgZlFX+Gs0l1sDls=; b=ClOxTdjjlEOFL3kvGByrG8HRpZ
	566ip76x1D1hs/lGgdHNhe6bFxnyA+Y4lbz9+yqYHeId3lqthB8ta45pEYgMqD3SglPasVCt+3Xgg
	DGZHwafdqcPenTV/s0swYky+zcd1ssv52RhujUfEgJGTlkNMjlMOHx5IeOLjFlwuOQgTx6jPM9hsg
	/XmH3I0Dpz0jtQgQ9Q/azvN1vesbNR3MH3aA+DGBVEo+8N7J4fzD4UK5TPMACTJsMIJMEeAKCf2ie
	Lpo1NQgUJkQelSTkFTK7jUuTcWAYCBPEp/fL+u6WPXMndrHLbMwam9JV02yyJzTUNREeA7M3eVfBt
	hL9SDpKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJRpP-0000000BOIv-3cSY;
	Wed, 21 Oct 2026 08:37:43 +0000
Received: from mail-dy1-x1332.google.com ([2607:f8b0:4864:20::1332])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJRpN-0000000BOIV-2iJO
	for linux-nvme@lists.infradead.org;
	Wed, 21 Oct 2026 08:37:42 +0000
Received: by mail-dy1-x1332.google.com with SMTP id 5a478bee46e88-3514b90bb89so1255656eec.1
        for <linux-nvme@lists.infradead.org>; Wed, 21 Oct 2026 01:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792571860; x=1793176660; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HgrAxwNlbkxj3ofFZk3KrlI08hFpgZlFX+Gs0l1sDls=;
        b=RnAE5EuMxZzRc1ts0JDIpESgWiS0LutcfYw0NlIYFItwI4NxI60TPnp1IamHuJ6bhT
         pX4NXn26ISqoi33skIcZf4L9/eMEmUPOIambp/32FTmEmEUoZaKZAt112XujHVZiCYsu
         xBxu8F7zJJcMYJ3D4bxAnByxJkcAo+cxPmdt8Y9r5K2AzzZvE2rLcwS4IBa2Rw0rkxI2
         BKujkZwpRD09AYfcPQ7fAutBJQuJFS4DaXYEzaUheKMj6x/Q9HrMcHcZ9NpqCrPTRktP
         hKVPlv89tEyl3Vn/T23eVnHUsJZWgyi1uWKIfqgcUMX+Crux8hqLF6uqKeZQv1jue9mz
         8u0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792571860; x=1793176660;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HgrAxwNlbkxj3ofFZk3KrlI08hFpgZlFX+Gs0l1sDls=;
        b=e29WOAAXh5ljS+gYX/DEQPJ1G7z1WBeOvnbqHjOWu8Ssz7wnRCf6crLVIMCPPGkISt
         mIbxGtS5nZdTCIyouqZXnAUqB4i4WjyCiWUTOaQoMJXPJby4MEMN+riEtkWHO4pfEIT2
         XTq5kCWtFrzHOnXZqQcuuRTaP6ohcbqrPlzVXG1nqCwYZqSGklSzxqwarpE7t+WnKev7
         pyktizmDlPK7Kw4ui0buUho6Gf64BDSMiorqElHY9bVNpXjzCus3FKF3qDjKBijyyVgG
         5nGXwUYaa8Q8Kkc3uaN9cywFEMGABioKLf/8vurgKiDTykrhQtymYD7Bcl062w6tcGiq
         5Tqg==
X-Gm-Message-State: AFq9FYK6f4fG/YVWniYPL+RKyx1PYGYPMx/ZXCRMQbCUYPMMzwzQAspY
	TRejlvK53VJ8q7vkUJp1JPq2TFTwUTU3dAoNLUJbEnS75qYJjmRWHi0rV5BrPQ==
X-Gm-Gg: AYBFou3+etP29gigyZjpc/oiz4ICV7XIgRKVd8SIsnIFmZahOdo54w/Nz7LGe7jr3cc
	WiJlqbVjoPUjJwh9tcBD0Ij3bOMGVg9oNuwcK+LEviLFfg+cZGauJ5kTb5gr5enCNg4Xz5n1DW/
	1JmUcdo1JuvH2nN/eHtCukh3K9XVw3qbbv9CVl+JlLwor7UtR2VoPZ+xH4/cQLLrcEzzV6GRkGl
	Rj8mEbUrV4t+JO9uoIZE5cmDJ9MNR0Qsztvc4G62frnemLiS2miQormybdEJMAi+Yw82aWiCWDD
	979GKj+iQ0eoz3dWbLAGJjyiO1LWF94hZB1WxkKsD1c9vHAbnnRH1P4Yd9RzJAYJ5rJhsarHFOk
	imHUu2JA0q758m1YpxLvxwqUPzTb/mgYtUX+RSbYp6L9fYFXKeB7MJgKmnLxVOmgDlNoMZT6JFR
	y3hUdu2jS2CV7RnERL4WgKlziBshf+ho5V23aAXLENDypHQvsktdxQKTfxkYqkq32jmOyCxCee/
	lTEuxCyne37RshGtp1Dry4MN1hhyTpndAHu3oggVTDP8Erv5ERtRJCamQ1I69KHneKFn7rucTjf
	dKY/Fa9P1ig=
X-Received: by 2002:a05:701b:270b:b0:187:a2b1:7b3a with SMTP id a92af1059eb24-190a6adcc50mr1788600c88.41.1792571860360;
        Wed, 21 Oct 2026 01:37:40 -0700 (PDT)
Received: from gooner.hq.netapp.com ([167.103.72.200])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903a74624csm4367375c88.7.2026.10.21.01.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 01:37:39 -0700 (PDT)
From: Martin George <martinus.gpy@gmail.com>
X-Google-Original-From: Martin George <marting@netapp.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de,
	kbusch@kernel.org,
	sagi@grimberg.me,
	hare@suse.de,
	Martin George <marting@netapp.com>
Subject: [PATCH] nvme-auth: update error log in nvme_auth_submit()
Date: Wed, 21 Oct 2026 14:06:46 +0530
Message-ID: <20261021083647.8519-1-marting@netapp.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261021_013741_682731_DDDC590C 
X-CRM114-Status: GOOD (  10.56  )
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

nvme_auth_submit() issues both AUTH Send and AUTH Receive commands,
but the failure messages are hardcoded to "auth_send failed", which
can be misleading when an AUTH Receive fails. So print the correct
direction instead.

Signed-off-by: Martin George <marting@netapp.com>
---
 drivers/nvme/host/auth.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index cbb38935fa22..85f005a5efd0 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -85,10 +85,12 @@ static int nvme_auth_submit(struct nvme_ctrl *ctrl, int qid,
 				     qid == 0 ? NVME_QID_ANY : qid, flags);
 	if (ret > 0)
 		dev_warn(ctrl->device,
-			"qid %d auth_send failed with status %d\n", qid, ret);
+			"qid %d auth_%s failed with status %d\n",
+			qid, auth_send ? "send" : "receive", ret);
 	else if (ret < 0)
 		dev_err(ctrl->device,
-			"qid %d auth_send failed with error %d\n", qid, ret);
+			"qid %d auth_%s failed with error %d\n",
+			qid, auth_send ? "send" : "receive", ret);
 	return ret;
 }
 
-- 
2.43.0


