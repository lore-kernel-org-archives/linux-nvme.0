Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43DEAC433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Nov 2022 03:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N8BoximgElJsrxzJf9JIvgGd84lbgTM3vODxVOIjybk=; b=405fep4weGX0zsEMqVDmfVvBzB
	/wnSl9r/WLUtSPhXnKnQglNVNmzfGH4hcSn0lKDDzKmYOhNQ/nL1YsBBWg/t71bwduo23NLdXamkT
	W4d6ZgSUgnmVf+kOHPHZc/UVc+Aq0USTYxFUirUveDDhmESQ6WqrjD3DyO+GAenWmk0K+jfJnE+es
	AFKXNVtiLCTJ5N464t7O4YrblReRYbwhRqD7Bxsbec5Fr0emHQaPHpDpDsSMeSaJ+fj0GrzVeeM6y
	Ies4og2PPdmh+lrqww0h2A9nwI/QZnYcRC+7aIdEGnH+oEvfWUm9ROHaKILLkEzZhHH+LNQt+Uhta
	ri62ivzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osc1L-00AOVn-7T; Wed, 09 Nov 2022 03:44:59 +0000
Received: from mail-pg1-f172.google.com ([209.85.215.172])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osc0q-00AOJ6-Vu
	for linux-nvme@lists.infradead.org; Wed, 09 Nov 2022 03:44:30 +0000
Received: by mail-pg1-f172.google.com with SMTP id f63so15143541pgc.2
        for <linux-nvme@lists.infradead.org>; Tue, 08 Nov 2022 19:44:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N8BoximgElJsrxzJf9JIvgGd84lbgTM3vODxVOIjybk=;
        b=Kg+Zs2d1YdOBiewvvBT4clWlqjE4C+lvVSh8Ptf4pJXSbrcT3+0wc0Yl77H5buS+zW
         USYmoEcrkvZ7oTfr5ZAFqDq5tvqrasxtcgD4oV3TyJUJGZUP8/TQqARKA21HA8bezsPO
         NPiRHqTeceUWc0Jqd2mSpq3stm1+Crg9xInBBHl1fa/6dZF491vS61+5+sVw3ac+ucX/
         yf+iNI+ZBKJvCr2cZTTXgKvibcLwDuyINce0ri9O8SAkHFFZQdxy3pO17VFK+/7AbhpU
         Tg1Hx0SrQndJ9Ghm9C3E/suzCaAsLNOylTu6GkNzhZ+K6egL6L6hO2W4V36vWwei5GYR
         3D8Q==
X-Gm-Message-State: ACrzQf3b1OXe8iXZEqdU5a0n60SVHR/jpfXtUx2HGeV1zJpJ7jv+Y/EW
	1soPdiOgtqXfnTjfW0JVQnwcARvWsqJeVazT
X-Google-Smtp-Source: AMsMyM6f0eeYWTtU2p4Th5px+M40iwhyv0IcO9AoXivjshosvcAYOUySBXZBZvsqfih9bH2MA9beyA==
X-Received: by 2002:a62:c70a:0:b0:56e:a51f:a990 with SMTP id w10-20020a62c70a000000b0056ea51fa990mr24851965pfg.16.1667965466958;
        Tue, 08 Nov 2022 19:44:26 -0800 (PST)
Received: from localhost.localdomain (69-170-33-158.static-ip.telepacific.net. [69.170.33.158])
        by smtp.gmail.com with ESMTPSA id i10-20020a17090332ca00b00186cd4a8aedsm7765612plr.252.2022.11.08.19.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 19:44:26 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH 03/16] nvme-auth: don't re-authenticate if the controller is not LIVE
Date: Wed,  9 Nov 2022 05:44:06 +0200
Message-Id: <20221109034420.1000086-4-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221109034420.1000086-1-sagi@grimberg.me>
References: <20221109034420.1000086-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221108_194429_038950_B67170D2 
X-CRM114-Status: GOOD (  11.99  )
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

The connect sequence will re-authenticate.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/auth.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 734928282d3e..93c0fc71bc7c 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -939,6 +939,13 @@ static void nvme_dhchap_auth_work(struct work_struct *work)
 		container_of(work, struct nvme_ctrl, dhchap_auth_work);
 	int ret, q;
 
+	/*
+	 * If the ctrl is no connected, bail as reconnect will handle
+	 * authentication.
+	 */
+	if (ctrl->state != NVME_CTRL_LIVE)
+		return;
+
 	/* Authenticate admin queue first */
 	ret = nvme_auth_negotiate(ctrl, 0);
 	if (ret) {
-- 
2.34.1


