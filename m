Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF593C7EE22
	for <linux-nvme@archiver.kernel.org>; Wed, 17 May 2023 22:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=pF/BK5twFuO9WLsHo6pZir/ilqTxyADlenXwkImuocQ=; b=OoRSrtVCcuH1i1Qal0JEcRtex1
	59dxVjLq+8ALXOd3zvE7H51lJYPbW3t8+lmwKpvEFpJinWp4aIKBo9d92d845aJSIL8J4hruXL43U
	r3YjoodO7pbc7SDn8YGATVZdKXKA6jW6TApKFU+HAuka2PuN/ohLNd6f+XksqEsQtSUjAJNvT09kZ
	ZXh8HqXMPqV5DMP4huXsjaNPie9c6yowjvhfiiMq+qHPDY8ld5bipzuW0X6Nw51ssGnVZWaRH42zR
	FcVLmWrTmz/B5cc8Tl6qe1ZoJfmz5fmTVto0N5ywf9aZW/ZTBAvHnFfRv/WYQ2/2sw82RXes70W3D
	RxW2IUDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pzPKo-00BBdI-2y;
	Wed, 17 May 2023 22:09:26 +0000
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pzPKn-00BBcc-0K
	for linux-nvme@lists.infradead.org;
	Wed, 17 May 2023 22:09:26 +0000
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-39462726590so873430b6e.1
        for <linux-nvme@lists.infradead.org>; Wed, 17 May 2023 15:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684361362; x=1686953362;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pF/BK5twFuO9WLsHo6pZir/ilqTxyADlenXwkImuocQ=;
        b=qEEkRW9Vb8CMoBLBCoS/OPcT2FZ3pbSD1I8VIlGzxtjzICFP19E9vfKPqgm1sFMLdj
         xh8fbgc5/T28guWuifeqLNNLJQNqydjTvleNs1RHDiDrbslfbXntI6+/U6NM+/UrVFa0
         2ZCKaCCeA8b/RvNQhR1+8MCHIaHfjlD2yeVJi327vGSFCK9pYA17X94tt8OUaqSF64Ap
         XP2oNRIR1qLw3dCYtXn5LE8rVJXOLSaXxU3up7ki3zMb+MDeNCJRgch5upBeNPz3E/0n
         oV1XLfmrr2ynap/I7xm3IE5Zp6JxROMTOZS4GwKLgG3MRNrVZ7J7+fIbh2zVT3eV4qXa
         B2nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684361362; x=1686953362;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pF/BK5twFuO9WLsHo6pZir/ilqTxyADlenXwkImuocQ=;
        b=EfUryCC71fT1vHu8q4zN64v3jd51T2VE6yxDnfb9YGSLdrZj4jikMOs64rf22JG6am
         AAGIrl2HiFP1nqrpeNUmvqn8g+TSLrz+dXgeyaHvMzfr+R4ZWr0xzaRf5Iq4KlAOnDiP
         VXNfQa8mJrHddYva7aH4/jk3SxvHS5wUNH9mWl4VTzuY4nr7ntP8ubqtm3zSauH3Rf6D
         0ZOQS4YnfbQfQvuCxWSXnmNEIxKcKjwc+5ddgbae6yVY6y9wuatFoUQXfBgqo7ULRx1j
         Havg/IKZB5wqiPAuZKemUahpp7TBOmZfKF16ekDMkkJ+ht8zSbEeE7t3+eBlfrFjXbx8
         WfEQ==
X-Gm-Message-State: AC+VfDyxSb5ZTDy6iH8iRAuE5L2BfTOPoy98G2e9t1xXdMmvPfztWNSL
	JHwVz9MKJ+CWwTOVajXPoQw=
X-Google-Smtp-Source: ACHHUZ5tUr/KXsHJnFgYSOCmbOJizifBYj52Mx96iAeHfziAaLQUXxHzn2oFFNED2jflRFvWBSdzNA==
X-Received: by 2002:a05:6808:20a5:b0:392:1035:b8c3 with SMTP id s37-20020a05680820a500b003921035b8c3mr185904oiw.1.1684361362535;
        Wed, 17 May 2023 15:09:22 -0700 (PDT)
Received: from archlinux.fibertel.com.ar ([190.195.153.187])
        by smtp.gmail.com with ESMTPSA id v3-20020a544d03000000b0037b6f5d6309sm22747oix.2.2023.05.17.15.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 15:09:22 -0700 (PDT)
From: Irvin Cote <irvincoteg@gmail.com>
To: hch@lst.de
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	Irvin Cote <irvincoteg@gmail.com>
Subject: [PATCH 1/1] nvme-core : remove redundant check from nvme_init_ns_head
Date: Wed, 17 May 2023 19:09:15 -0300
Message-Id: <20230517220915.7244-1-irvincoteg@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230517_150925_157341_E18D576C 
X-CRM114-Status: GOOD (  10.40  )
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

nvme_find_ns_head already checks that the list of namescpaces
in an already existing namespace head is not empty

Signed-off-by: Irvin Cote <irvincoteg@gmail.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ccb6eb1282f8..54a8eadd9876 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4209,7 +4209,7 @@ static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
 			goto out_put_ns_head;
 		}
 
-		if (!multipath && !list_empty(&head->list)) {
+		if (!multipath) {
 			dev_warn(ctrl->device,
 				"Found shared namespace %d, but multipathing not supported.\n",
 				info->nsid);
-- 
2.39.2


