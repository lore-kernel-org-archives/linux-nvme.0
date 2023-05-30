Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B355AC7EE23
	for <linux-nvme@archiver.kernel.org>; Tue, 30 May 2023 22:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e61w57IvqTrC2HqGDt7aftIFNF+nQpkFiAElH9ITAy4=; b=Smk+wlZ93VFZIRCSsP9/6pUZxQ
	yFHLN3QUZcSR7yuXZJP9sPkoYyN5uGw0i6B3Lda8TgOEriaJodpW1rSGnEeH/Lk8b8oxEwT1vyXB4
	tpiPB47qJHEs3O55uziNR//g77ySJRgbRaGx0jrgrUC+gRo5vdWQoc7iWvapWqMXiYjVBD3aFDJZ0
	yI6q475BuakJ3jlhtXshpRZlNBRKK5c3y14YOjd9xKnu5WKVNAlojMhVMAHRXtLzpVS+m5p+MQ3S6
	xNVkcABdQH7Z+XPOqCG3RzF9lKjINB+KNEAWTGCqpJxuO+PjHSFjxKve4Bq4K0nUAwz9/QREvAX2b
	VOky7AoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q47oI-00FJiL-2D;
	Tue, 30 May 2023 22:27:22 +0000
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q47oG-00FJhL-0y
	for linux-nvme@lists.infradead.org;
	Tue, 30 May 2023 22:27:21 +0000
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-38e3228d120so3217037b6e.3
        for <linux-nvme@lists.infradead.org>; Tue, 30 May 2023 15:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685485638; x=1688077638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e61w57IvqTrC2HqGDt7aftIFNF+nQpkFiAElH9ITAy4=;
        b=pqlW0Hdn8A+Aq1XhBNfff2+Poju6BGwSWd8SCwXyjFr9WKzfEql9T0+zO7Fny8hJGi
         KPQZrF/IRs+fijLrLiAfZlTs2tGv0qIQDpjRm5tk0vyZU3DKbBd1h2iDplrKo+HCW7JJ
         HJ0MKtCPnANIAkbA9c6jD4PtURIDfI7Qj7IlfMfA/D6J0OAPturOL8/6VB6yMewGC9UY
         aZ/klUM+sv6fiCACT6nJCisF8yH1XLdRof7G6WQiiFxgga9wHGUoPP+nghVMAdOdz1QN
         IDnDml/h3JYPKjUW9ebQqTcZomCJ8mN8o9OKoAQ3YcFSWAbUfpgA7qJlHHiX7QyjyP/C
         4A2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685485638; x=1688077638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e61w57IvqTrC2HqGDt7aftIFNF+nQpkFiAElH9ITAy4=;
        b=dTbX0BtWQzj5xap2MfnORiDqs2Q2y8RswzjSq3bFvttkqbDJ5db9StJ1QW9hlVc2GY
         bLYvQqPjIwrEEHJ4sPBvf/36p+BL7Q/KIomIzc27zknWNWyBsOBPMs863bu98ee/oUEo
         zQpLQ4aS4HArol5wYPraxPho1L66JF7okSbIjjgweSM8ff9fQi7tpHfwy2qdU5S2JEhJ
         TSCnpFu5DmpKkutfYZctI5ykPYKJyxgekO45aLEyo8zWl/z5sScaClsbyoYheuNaZtgk
         33dqGE125+MUUn+cJT9Fxc600i3if4eBtD3S8N9CusMgggyGyR8hrbuuZ49WDaclC1JB
         bvdA==
X-Gm-Message-State: AC+VfDyxNUwWt8CM0pFtVVKGuZw1JTs/BfgoFRALrmdScc4BFPV6KaEa
	n6fnROOL6OK0f5pSqHcH07g=
X-Google-Smtp-Source: ACHHUZ64AYGWol+ncHq/7vy74Gr2fQDce155C5h5VuvD5KZP7vuNPMTkQCgFp8kqDXNkeEU9pbzutg==
X-Received: by 2002:a05:6808:23c9:b0:398:5473:89b9 with SMTP id bq9-20020a05680823c900b00398547389b9mr2440249oib.19.1685485638417;
        Tue, 30 May 2023 15:27:18 -0700 (PDT)
Received: from archlinux.fibertel.com.ar ([190.193.134.103])
        by smtp.gmail.com with ESMTPSA id o10-20020acaf00a000000b0038c35f512a2sm6359041oih.56.2023.05.30.15.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 15:27:18 -0700 (PDT)
From: Irvin Cote <irvincoteg@gmail.com>
To: hch@lst.de
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	Irvin Cote <irvincoteg@gmail.com>
Subject: [PATCH 1/3] nvme-Kconfig: updating MULTIPATH option's description
Date: Tue, 30 May 2023 19:27:07 -0300
Message-Id: <20230530222709.28682-2-irvincoteg@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230530222709.28682-1-irvincoteg@gmail.com>
References: <20230530222709.28682-1-irvincoteg@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230530_152720_339597_8DD812F7 
X-CRM114-Status: UNSURE (   9.57  )
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

In the MULTIPATH build option's description, mention that
the option is mandatory to support shared namespaces.

Signed-off-by: Irvin Cote <irvincoteg@gmail.com>
---
 drivers/nvme/host/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index 2f6a7f8c94e8..f22cf71b205d 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -23,6 +23,8 @@ config NVME_MULTIPATH
 	   subsystems.  If this option is enabled only a single
 	   /dev/nvmeXnY device will show up for each NVMe namespace,
 	   even if it is accessible through multiple controllers.
+       This option must be enabled to allow sharing of namespaces.
+       among multiple controllers.
 
 config NVME_VERBOSE_ERRORS
 	bool "NVMe verbose error reporting"
-- 
2.40.1


