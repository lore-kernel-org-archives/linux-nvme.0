Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA5E4C04A95
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Oct 2022 13:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6/+E83ZG1+rthlv8Vc6GUdqZbDuzospA8VjpyGb0i9E=; b=UlyZPXkuNXcHuYs4ZjqwiVymTY
	G1SnoCFGjCx5uqC7+b+yR52RzUrREWfO52p9n4pAOR1IwvBGfAVyz9wTEt9/sR0BaU2Sbf6QpC+kl
	WehYGMBvxk8F4dW811pKmgvSfSDT5jdzffhDZcmd+ozWPQbBaaTIaYFrir+Yg6ug7z0diGo+hmapE
	aKTgiR0IxrnclkQIBPtL86ztNTYcI5e4RhuFAfgf0Hh+0q1EI+Fpf8ay/2pxWEhEYv5VhkUKfP6eW
	g59qsUvVpJdoTia8SVOf6vpsGdZk3umJtZb0EUzqk26teLo2xSkYa5eEDZhDvQGvmRDoJeRTAw1m5
	OvYgTZyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onKDn-005Wjo-Jn; Tue, 25 Oct 2022 13:43:59 +0000
Received: from mail-wr1-f41.google.com ([209.85.221.41])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onKDX-005Wea-RM
	for linux-nvme@lists.infradead.org; Tue, 25 Oct 2022 13:43:45 +0000
Received: by mail-wr1-f41.google.com with SMTP id g12so8304822wrs.10
        for <linux-nvme@lists.infradead.org>; Tue, 25 Oct 2022 06:43:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6/+E83ZG1+rthlv8Vc6GUdqZbDuzospA8VjpyGb0i9E=;
        b=jYsVFh+PmuDrZVpvrM9sdCN6ilxrrw+bbJfSoDD/1mSFRlCxA64vhRYsvwIij3LWg8
         hESG5HmILjQw3l4JJKSdbiMy4MDrUQ972FVFje/g79WyA9+zzj6SiwOD3/l5kz5Aw2K4
         rC4yNkNeddmCRTtp78G/STPM2ftOgrItlAwG70mQiQiRfzsbK25al8Pg94IU0DQta5cN
         TxuddIgIvX7LOOUAD/wUgr5/DeY0WxlRSYr3D86/pQkKmHcGGgGz80Q59NACeQry+VPL
         E9vTYVMSD0WOPoqioJogwer196YUsVVrRgtfohkmA95dQVqMPMATxQAxDsGZHSQEZjpP
         14ng==
X-Gm-Message-State: ACrzQf3lK7e0d7JbKlPl0j/kjOo7LjE27o4UlMxcv1wdhoEREul3Xpq/
	fyBDSm7k7NEC6QFzQEjuB7ZTZts0mTA=
X-Google-Smtp-Source: AMsMyM754kTE/Lk8FGfXz5xXp77oLPE1pKyUYlmzwpwPuKhxl3asnHgxeogLDDqb4XSMEokTZRjmKw==
X-Received: by 2002:adf:de8d:0:b0:236:6087:e07e with SMTP id w13-20020adfde8d000000b002366087e07emr11585643wrl.533.1666705420999;
        Tue, 25 Oct 2022 06:43:40 -0700 (PDT)
Received: from localhost.localdomain (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id n7-20020a05600c4f8700b003c6c1686b10sm11442239wmq.7.2022.10.25.06.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 06:43:40 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 4/6] nvme-auth: remove redundant buffer deallocations
Date: Tue, 25 Oct 2022 16:43:28 +0300
Message-Id: <20221025134330.1028352-5-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221025134330.1028352-1-sagi@grimberg.me>
References: <20221025134330.1028352-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221025_064343_904382_B92705CA 
X-CRM114-Status: GOOD (  11.30  )
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

host_response, host_key, ctrl_key and sess_key are
freed in nvme_auth_reset_dhchap which is called from
nvme_auth_free_dhchap.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/auth.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 93c0fc71bc7c..15cddc2bb14d 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -683,10 +683,6 @@ static void nvme_auth_free_dhchap(struct nvme_dhchap_queue_context *chap)
 		crypto_free_shash(chap->shash_tfm);
 	if (chap->dh_tfm)
 		crypto_free_kpp(chap->dh_tfm);
-	kfree_sensitive(chap->ctrl_key);
-	kfree_sensitive(chap->host_key);
-	kfree_sensitive(chap->sess_key);
-	kfree_sensitive(chap->host_response);
 	kfree(chap->buf);
 	kfree(chap);
 }
-- 
2.34.1


