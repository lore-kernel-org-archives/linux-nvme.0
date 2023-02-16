Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F3A2C636D6
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Feb 2023 12:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=05dZJbEkLcyvJKficN7EL+9lgf/S5/q0x+ZILsExxD4=; b=n0Ne1Ui/eVyNAw8sOJLSrQPA4v
	rFRRdyaenIr/uyqjmZJDN31onyjFfx4NygTOESu6OJpfawtQHYngjZhIjMFML2fRYX7JNmP9wLKik
	rUwKvvC9c8Cq+TdY/gtIuWPq5JZQX0Q3WPvISJKKjlkrMerbrxs/bbsKGMYESGrolllFBF8musyJ2
	So5xBU2FUo1Jc06QWOedhdpQ1WA8u/QHsIOas4pG7Ssru+lBaa431Dkry0JBhJEdNwO5Vg3C6fdtu
	Tnbl3WwwezDojkZC9dR4CRftr7tIXi5HUk/C4XiAakV3jDjbLXARY7blqiyQnMov2fJ4b8AZ3T6AF
	88XTT+ZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSdAD-00A7df-78; Thu, 16 Feb 2023 12:15:01 +0000
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSdAA-00A7cM-PJ
	for linux-nvme@lists.infradead.org; Thu, 16 Feb 2023 12:15:00 +0000
Received: by mail-ej1-x636.google.com with SMTP id kt5so15120ejb.4
        for <linux-nvme@lists.infradead.org>; Thu, 16 Feb 2023 04:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=05dZJbEkLcyvJKficN7EL+9lgf/S5/q0x+ZILsExxD4=;
        b=JJF565ms5kq1yZuDtRpYMMc/afWOEuKSQVDoG87jJ8N/Qu9ae7BxFv4xutakF/O5z/
         561BCniSWL5xXcPYJvXqzF050iJMwwgYrz8XPxOpFd6iTMftL3C47qnwAVg0L90UIPVr
         RBGjk/BYPV/JMS5XzyhK5Gj57hG+tWdXqVu7CZTjQSvOBXzWhnjwb7UQ52YgXv+FClJR
         pxz+LyRKwIjwpQiv3KlwVFV04Cs3v7FzEdRpnCQJoRNEWGbomIp2DEMV08t16VEPWZtZ
         /EvYbrPz7Er5TGlrOJB/8c74Le9Ma8d9fFp1uoliOkuvO4k4e1hfOojlBN71zaYIVSdr
         Rlww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=05dZJbEkLcyvJKficN7EL+9lgf/S5/q0x+ZILsExxD4=;
        b=krL23b8aftKps8R2q2de8o7KpApYUiu/wV+Tt0Z0FejZXUtpcmKcT/ocGKJOqQV+fd
         O1ivDO9/OuVHAK9Z+GqQ399nOY8kQni8/I9erP1tSHRzNqNsLXCABIY8+/P518KSOqsa
         gDE9IIO8EyKHuNtkeOUBvvayTDvmWoz62wBZloGYcsaDXcfrhp5r3P7qnCD2RKaf3AhL
         5O1EG/cmTA0+ovtJ3SxL1YAOqtN9BhhrpLm1H9Zm31iB8Jt65fpD+OZEdrhVnomZp1Fz
         UAQ6EuL7ruMOdzHemIjqYpAKtX7YOQdciD+x1mFBbaIBCDEE2yzNzdJFKBNcUpiDeYoE
         GCDw==
X-Gm-Message-State: AO0yUKVwu4pBIDDoU3+ajhddqem3J7BTy15OXfbYGeJaJDk6D8KZHyX9
	KVul4mRKBaCd5Wc4WRYW+2M=
X-Google-Smtp-Source: AK7set8xpL1VXfk2h8B2idIYRFOEdWU8TszgUtK+kw/hBd7jDkyrQo5qecX4Ogy9hpumJq239adt4A==
X-Received: by 2002:a17:906:4e4d:b0:87e:a34b:9e2b with SMTP id g13-20020a1709064e4d00b0087ea34b9e2bmr6152186ejw.28.1676549695041;
        Thu, 16 Feb 2023 04:14:55 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id jr14-20020a170906a98e00b008af574fbfc2sm746839ejb.33.2023.02.16.04.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 04:14:54 -0800 (PST)
Date: Thu, 16 Feb 2023 15:14:49 +0300
From: Dan Carpenter <error27@gmail.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] nvme-auth: fix an error code in
 nvme_auth_process_dhchap_challenge()
Message-ID: <Y+4eOa57zTdCZ56P@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230216_041458_857559_2B24B1BC 
X-CRM114-Status: GOOD (  12.57  )
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

This function was transitioned from returning NVMe status codes to
returning traditional kernel error codes.  However, this particular
return now accidentally returns positive error codes like ENOMEM instead
of negative -ENOMEM.

Fixes: b0ef1b11d390 ("nvme-auth: don't use NVMe status codes")
Signed-off-by: Dan Carpenter <error27@gmail.com>
---
 drivers/nvme/host/auth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 901c59145811..ea16a0aba679 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -256,7 +256,7 @@ static int nvme_auth_process_dhchap_challenge(struct nvme_ctrl *ctrl,
 				 chap->qid, ret, gid_name);
 			chap->status = NVME_AUTH_DHCHAP_FAILURE_DHGROUP_UNUSABLE;
 			chap->dh_tfm = NULL;
-			return -ret;
+			return ret;
 		}
 		dev_dbg(ctrl->device, "qid %d: selected DH group %s\n",
 			chap->qid, gid_name);
-- 
2.39.1


