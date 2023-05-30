Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E326FC7EE24
	for <linux-nvme@archiver.kernel.org>; Tue, 30 May 2023 22:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=GwII/pBpzRjHmBm50Y6GQzomeYFbUc7r41qvBgVmL6E=; b=hpyeJI14+FQhNE2Piu6wkerJjQ
	TNO9SPE3Q63qumPHOM9TNFBI8XtJKtK1MJ6umqy497oAW5awp1DUuA9EDsEmsmUnkd/sigmmZ1Zen
	MDBC7YDTC2OjV65ok7ebc/C15DOXPlzg44VQlLt9bEbyvQKR0XBvNgBZhDlNVMaTnQXkrNocx3vFr
	bCnz8aUij7IejIgNGmptwvJJXJxSfMtSXv8HHIW4jD9nLrg6M8OnlJzrrD+dg4ZKlIbVJ/vZ6sm/B
	y111TER5oULCZCMNWJjQaq9f31n0mW36OyCyUMFXPYX4pQiCrqM5fbfhdYu5wUL1ZkVSTVrUYICdd
	dMQdQyow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q47oF-00FJhT-2u;
	Tue, 30 May 2023 22:27:19 +0000
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q47oD-00FJgm-1R
	for linux-nvme@lists.infradead.org;
	Tue, 30 May 2023 22:27:18 +0000
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-557d1360112so1308246eaf.3
        for <linux-nvme@lists.infradead.org>; Tue, 30 May 2023 15:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685485635; x=1688077635;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GwII/pBpzRjHmBm50Y6GQzomeYFbUc7r41qvBgVmL6E=;
        b=fswvfWJ+b018XVndmzi0qtzlJP2/fr5SghtP4h472MO867NV6Q37d+7SvVzgBAruDq
         /4r2a6IikH1ka8KisQIpvlumAECaE5OZYg3z4JQOWakhkqJUNpgL5WDT40w+b/RO0MNh
         Hin6Xef3aqrvM7WDuP7Vu73q8iFEr5zFv00uY6pTt/K9BQKyf879PTjP/0ZJZAUI5Fqq
         3Z4IOegCItumckcHIbPce7gEWX9vWpxFuXcOXQvXlzGNIJuIYLJ3cEZ6MpjGR+R7QoT0
         WYyE7C+g8pn0Uq1S6vbALwEK3Pdxqwb8xcwDQjfrZa7q/C891QpceX2zwfnWbr4cqELx
         PIlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685485635; x=1688077635;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GwII/pBpzRjHmBm50Y6GQzomeYFbUc7r41qvBgVmL6E=;
        b=CmBSSr7A8LinyeJciqAw5mj5S+V6VsxC2h0pmL25U17GaUPBH/iZfa7LFrySWVP3pq
         fTpsC/MVkYf5LcMV/GdPjSHXOsrVfdoiK9tXf7togcGxPiuheoehYfMObjUhUgsREeES
         m3kZVXD5A1ympTfM0e/7LR/E3ID0SfRyPPR7ucr2r6fnu1siXcJZAmziKYE+olEjMrjN
         zGA9woJYe4EVoo4mar1ySvZ25Q8ayqCxQwREo/TGMH4MqL2ztR8An+gDpO4kREmOqy79
         JKeyoG6gafz/fNn6H1+QjaxhXOYxYf2XUgJXrQ1VKpgAeIUbet9kVLU0QFWenok2VmU1
         QqTg==
X-Gm-Message-State: AC+VfDzUFOa/UiAzCYptFK68I74Wj8vH6GoXN5vx1I9XGvgy+od5c8X7
	j999SYc1ukVHxuhZhvO/nW0=
X-Google-Smtp-Source: ACHHUZ7y3XlO5fBcO19dPx4D+nqV3KnmRWnP16wvpS0uAKn/WkLIg8TTdKOj+BhOwNJA9OKpUcnYbw==
X-Received: by 2002:a4a:2c13:0:b0:555:5ab5:a0e0 with SMTP id o19-20020a4a2c13000000b005555ab5a0e0mr1502947ooo.8.1685485635236;
        Tue, 30 May 2023 15:27:15 -0700 (PDT)
Received: from archlinux.fibertel.com.ar ([190.193.134.103])
        by smtp.gmail.com with ESMTPSA id o10-20020acaf00a000000b0038c35f512a2sm6359041oih.56.2023.05.30.15.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 15:27:14 -0700 (PDT)
From: Irvin Cote <irvincoteg@gmail.com>
To: hch@lst.de
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	Irvin Cote <irvincoteg@gmail.com>
Subject: [PATCH 0/3] Start to disable shared ns without multipating
Date: Tue, 30 May 2023 19:27:06 -0300
Message-Id: <20230530222709.28682-1-irvincoteg@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230530_152717_484321_2BCEE91A 
X-CRM114-Status: UNSURE (   8.10  )
X-CRM114-Notice: Please train this message.
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

Staring to disable support for shared namespaces without multipathing
enabled. This is not meant to be an exhaustive list but rather a start.

Irvin Cote (3):
  nvme-Kconfig: updating MULTIPATH option's description
  nvme-core: exit scan if shared ns but no multipath
  nvme-core: changing comment on disk names in nvme_alloc_ns

 drivers/nvme/host/Kconfig |  2 ++
 drivers/nvme/host/core.c  | 12 ++++++------
 2 files changed, 8 insertions(+), 6 deletions(-)

-- 
2.40.1


