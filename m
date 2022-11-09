Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38CF1C433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Nov 2022 03:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UWdmLoc+dgwVR1Jr81WSL4PMYIv/Rr+x2qbfSOqeEBo=; b=djaj+D5bV07sF3ZlqBJwLzmb+k
	fVzj+jpon73fTW3A5vC/zJi12zybedROTDAp3hXnyNZpslXCaQn3CCoTs1k4qnWSmEc8WP+C8OmpA
	iSL0yad6QXLXUTjWNqbgf0TNslX8et6ZRdXaUJE/z2BhkagTD8S2m7Vs9K6dP5yRUh2lW62TxiB0E
	yZ8gKTr9h77TsNNSrRfsg8BouU+JdW2djPKT2+a1WF0+QybluAZ04KlM0XgmIXNIaQBvqMIp7DWcy
	5m3SjXPtOux66ig3nPcLKrt7Bxq1n3XgnSLWLYjSNk1GWslThplkfgn3lNPPQjNrPosZjusqzemX1
	S4GuaB3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osc1u-00AOmc-TR; Wed, 09 Nov 2022 03:45:34 +0000
Received: from mail-pf1-f182.google.com ([209.85.210.182])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osc0v-00AOLI-QI
	for linux-nvme@lists.infradead.org; Wed, 09 Nov 2022 03:44:34 +0000
Received: by mail-pf1-f182.google.com with SMTP id q9so15559071pfg.5
        for <linux-nvme@lists.infradead.org>; Tue, 08 Nov 2022 19:44:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UWdmLoc+dgwVR1Jr81WSL4PMYIv/Rr+x2qbfSOqeEBo=;
        b=CgnbganNFKoM6d0fvUuYiGm3aSznePyZwl9BdqKGMjDAfMv5n/j4LtCIteLPTALJTn
         ssUOLEPZovEwa3CY0soTBBPN3WiAQjrpH2XpnvaP21hCwimXBY9b4aGZGI+nvH6rzViK
         CKG5vlLgFTpL+IKqrmuapS7Wf7/jtY/XxSpHqj9sk5+2bEw7O2DXTnc3z6jtbZYAVi6q
         HsiwjsiKYUKlKuLc0bYQJ+w4gA2ycununiMuPT7NqFR4LPlSb1GzjS5fe4ST2+o7XFVW
         ml1iY7lcYS3OgqDKWiwv4Qun3hzDccXuKtUoUrLVYKng3Pr/hek1aYp6So4gDHnXmcCV
         BpFg==
X-Gm-Message-State: ACrzQf2CWcCKLRLXKa1XDqhYTLTELpsNOka50xPCYg+oIgAUOx4GJ2UN
	LuUJQEqqhMFZwGpAXsnapiWJCayqymN9VZvg
X-Google-Smtp-Source: AMsMyM7xKK+WT+b4iZWKwuXzwgnfVuQW6HmWSVApkUVxGav3CtyrRWj/9Pmhi6nKNdXEg4FngpAh3A==
X-Received: by 2002:a65:604c:0:b0:46f:a98a:5ac3 with SMTP id a12-20020a65604c000000b0046fa98a5ac3mr46037985pgp.473.1667965472388;
        Tue, 08 Nov 2022 19:44:32 -0800 (PST)
Received: from localhost.localdomain (69-170-33-158.static-ip.telepacific.net. [69.170.33.158])
        by smtp.gmail.com with ESMTPSA id i10-20020a17090332ca00b00186cd4a8aedsm7765612plr.252.2022.11.08.19.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 19:44:31 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH 07/16] nvme-auth: remove redundant if statement
Date: Wed,  9 Nov 2022 05:44:10 +0200
Message-Id: <20221109034420.1000086-8-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221109034420.1000086-1-sagi@grimberg.me>
References: <20221109034420.1000086-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221108_194433_869661_DD1E3307 
X-CRM114-Status: GOOD (  12.13  )
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

No one passes NVME_QID_ANY to nvme_auth_negotiate.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/auth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index a6312a8846f8..07d497f49e4b 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -874,7 +874,7 @@ int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int qid)
 		mutex_unlock(&ctrl->dhchap_auth_mutex);
 		return -ENOMEM;
 	}
-	chap->qid = (qid == NVME_QID_ANY) ? 0 : qid;
+	chap->qid = qid;
 	chap->ctrl = ctrl;
 
 	/*
-- 
2.34.1


