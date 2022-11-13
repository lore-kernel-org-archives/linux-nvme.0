Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C99E1C433FE
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Nov 2022 11:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H1q1ivAYna+oVAG/HiWwi7qxJVh9WCLB40+StGc2dSo=; b=2xjx7ti2plB930W+1HMAR6LQL5
	qQS0VTtdYma+tRWZ3+p3Cwp+JsxWXmHL1s/+wl5LBI6mdfNMKBeIWG2Jufan4qJlG9R6+jP8S3BcB
	w6f+CgUQAWly3H7fCxL/a5W1R4nK1qXtGLwdOj8IW8Uxoun4yQjmPaVxW6VTL1KsoXW2PcXY/W/aq
	5x98F/Zn+a9sGLuPNkryouxkBQMAFlsHY55Qgnwm9IbmNhUvU6znaUwxMPnlVT8aELXdvWFQOYK5i
	t4IoiXLjOa+C2FzMPLeIPMp3t+6qXQIPokxYWeHeMmOa2aXxL93eO0j3u1ad+PSmHs9o9E9OjN5TO
	9Vuh8i6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouB6g-00B6Zd-Os; Sun, 13 Nov 2022 11:24:58 +0000
Received: from mail-wr1-f41.google.com ([209.85.221.41])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouB6I-00B6Nc-Q4
	for linux-nvme@lists.infradead.org; Sun, 13 Nov 2022 11:24:36 +0000
Received: by mail-wr1-f41.google.com with SMTP id w14so12380834wru.8
        for <linux-nvme@lists.infradead.org>; Sun, 13 Nov 2022 03:24:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H1q1ivAYna+oVAG/HiWwi7qxJVh9WCLB40+StGc2dSo=;
        b=Rs5L3Cu7Re1dDCZlI+YZ6ABX1h6sAIb3nrr4TL9Yo0OQ0GFBWoFEK5gcAu114/JYRI
         8WMhffVUBhupZ43tBOvEf1oyLObycFxGWd+mIksrEBKWAvY4N3MzSthlQNt+z4sQOVNd
         kE+e1Fu896LOKCc91Guu3OPQyhlSrOWsuen7YEG08Qlwg1He/dLOaoB62+bJk6UGCN1X
         az9z1G+izSeyTYBS8llkEZ2/lFaJuQYMWF/yRdW7qUA8k09+YMiEHpn4vuLFe5Q/03M+
         Uoixrz88DbRB8Fv7Ey+JTPA2bfHDT57Fq44hTYTii14E/Hr63aOjbNmn4BnSZJsKJuab
         oUQw==
X-Gm-Message-State: ANoB5pnO6z37zCpL4+vtyuu/CLgU1Gp19BdRxv7cpm8Xmiw3lWVjBKkK
	0otsihUCzLATLU2aqy/mk55RK5j6Hp0=
X-Google-Smtp-Source: AA0mqf7W4V8FF87+SU6evUQQgeN3q19bCqIGCNOIGr8rc/Cmj8CoO/QcVJfzL/xDtFNiNWSP8UMy2g==
X-Received: by 2002:a5d:484d:0:b0:241:6f01:ad47 with SMTP id n13-20020a5d484d000000b002416f01ad47mr4884186wrs.222.1668338672840;
        Sun, 13 Nov 2022 03:24:32 -0800 (PST)
Received: from localhost.localdomain (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id p1-20020a1c5441000000b003b4868eb71bsm14318393wmi.25.2022.11.13.03.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 03:24:32 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH v2 05/20] nvme-auth: remove redundant buffer deallocations
Date: Sun, 13 Nov 2022 13:24:09 +0200
Message-Id: <20221113112424.1049834-6-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221113112424.1049834-1-sagi@grimberg.me>
References: <20221113112424.1049834-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221113_032434_866079_7CB38216 
X-CRM114-Status: GOOD (  10.71  )
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

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/auth.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 4f2c8d0567bd..0d0542e33484 100644
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


