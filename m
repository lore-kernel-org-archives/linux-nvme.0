Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5F7DC4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Nov 2022 03:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6/+E83ZG1+rthlv8Vc6GUdqZbDuzospA8VjpyGb0i9E=; b=FMkbBAgvu7Ezbha76ZLPBaaQXy
	OIJkRYqFS0JOESmlAmt9pO3QT7Ku7KTLzp9Z1yESnBJuJ8YYrYMUR6+hriNmqrpV7RK5ihITq9/4b
	Mmuy8M2AdvjRIAJAkCbOfHocA94KxhCdvZdYC4cVizGjoavRkU57vzvzmzJ5zdnjQRRiuRWVtTfP7
	J5X1ZDUaOXqbG4uxO+TUZgKide92OphjdVmiTx5KV1gcfXk54QJdp4FmLxuzp+4KwNSYZ4jkgRpUa
	4TkcGJLv0yAdY9bdAxIMeH1llC0+bNYYagLzBeq+nrc2kNdYnFRI/KHLoEB2PVq7L+1UzkBtQ972b
	MW/xP2Fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osc1R-00AOZ5-Pl; Wed, 09 Nov 2022 03:45:05 +0000
Received: from mail-pf1-f175.google.com ([209.85.210.175])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osc0r-00AOJP-H5
	for linux-nvme@lists.infradead.org; Wed, 09 Nov 2022 03:44:30 +0000
Received: by mail-pf1-f175.google.com with SMTP id z26so15577112pff.1
        for <linux-nvme@lists.infradead.org>; Tue, 08 Nov 2022 19:44:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6/+E83ZG1+rthlv8Vc6GUdqZbDuzospA8VjpyGb0i9E=;
        b=aSZDLoYiVYDfjjMrgws2/UuYZYPLeX+rKBDfFNly5WJrwWulYb9iGGdVjKgWWsIbp/
         p8ZU9gAo80i+OaDxahDz7VrOilPOtpb2pQV/D4bt/XiTIrVQjbOVf0Nsc9OzAOLB1xVX
         ztfWzpl0/Bl1qEDXZlBZJB8lNAijgCy/j34M3FkD35ddCHTC1ygUP2CuXJLYUlgN3rsE
         LgRNQTpMhQW5sYDPO9EZMLLr3p0vdmiYEQOmisUbR93/WbE7NdHkuhUSKrlzkPToxZMH
         KYlyFiI/dx0YwyPIrIwB9TrQrR7cOVzTx9nYTQS+VbpcpDaWUluwAtjDASW4A/9UlQre
         HkMg==
X-Gm-Message-State: ACrzQf3q3gtRmytgO/NxDqq472uk4gmHZmUxObvmP3wVobXRP+PW0ZC4
	199ngJGUiaKbjjcElCmIlreP1MozlGKy+tjL
X-Google-Smtp-Source: AMsMyM7rcCoYEuza31erh8NeAITB/YjXnaaKCP9xonbh7MBGSvDHYhL8a2ll2SVjRA+qTYgoLebRAw==
X-Received: by 2002:a63:5707:0:b0:46e:b83b:6084 with SMTP id l7-20020a635707000000b0046eb83b6084mr51569975pgb.233.1667965468484;
        Tue, 08 Nov 2022 19:44:28 -0800 (PST)
Received: from localhost.localdomain (69-170-33-158.static-ip.telepacific.net. [69.170.33.158])
        by smtp.gmail.com with ESMTPSA id i10-20020a17090332ca00b00186cd4a8aedsm7765612plr.252.2022.11.08.19.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 19:44:27 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH 04/16] nvme-auth: remove redundant buffer deallocations
Date: Wed,  9 Nov 2022 05:44:07 +0200
Message-Id: <20221109034420.1000086-5-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221109034420.1000086-1-sagi@grimberg.me>
References: <20221109034420.1000086-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221108_194429_579180_930D1BA5 
X-CRM114-Status: GOOD (  11.21  )
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


