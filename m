Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F23AC6FD1E
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Mar 2023 14:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=v+JUoEiDjiVAF4hinlDEQAHLm42+5L3JayYCS+t/dGI=; b=UFaA57x7v2cYxMEUPO4SgRKvKo
	HdtWwFSeNKln6TdJOvBy5u7bFaXmBSTuhGnnzWUtXHFfOB8M6/SIZZ7QS7tC4kLiqywew6ac/GvqD
	FLlQoF51KgueNVTkU7yhOuV82GclKJYrB9EGTNGblrdG8RsHbe3Xqtg66RP4Vx4jOlJGw9CdnKDeu
	WJAqyR9zPAtB2G2wqWyvsGeRrQs08VVCmzFonmJNxjM1Fm0LjaFNeEsbufewiBf5Mq04tjK1XtFg3
	C97+/ea1OgFQJSvKYnxLS8vPaWhD2YRu+kPqA822XyVgwAUwmbBOmY1kugN7rsY6yxuowxov0zeJJ
	9TyA0WwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZuz9-005WxD-TI; Wed, 08 Mar 2023 14:41:43 +0000
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZuz7-005WvB-0S
	for linux-nvme@lists.infradead.org; Wed, 08 Mar 2023 14:41:42 +0000
Received: by mail-ed1-x535.google.com with SMTP id o12so66624691edb.9
        for <linux-nvme@lists.infradead.org>; Wed, 08 Mar 2023 06:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678286496;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v+JUoEiDjiVAF4hinlDEQAHLm42+5L3JayYCS+t/dGI=;
        b=YgQKkB5o9lGKdTSTzpvNGjP+WTSAbSw0TXvtkc7h+vfVXfnFJI38yNmcGSXm/tiofh
         llophtlweoJE7W4nLp9FgiJwy8ZhEhgGGxXUBLDcZDpMSWdovrcMHFv5ohV2mrs3V0XZ
         BFhD1ZTWgbF3vbSfWuso3+y4F2BXB36M1veC5K3ld0CYiniLKWNBauBLpWeSpUJMUou8
         wACGNw4jSpGhH94Xs3InBzv25yjxL5Jy9ERkfDrJ1ew5aKZvWckhAe4vhBMLpYHavYb5
         UgwkzK6i8lK4f1h1VmZetp9qgtJh44CFdpQU5O59vCAyCdCLefxYbkeEqWTdC7tStRmy
         rmlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678286496;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v+JUoEiDjiVAF4hinlDEQAHLm42+5L3JayYCS+t/dGI=;
        b=T7IaDNKQkh9Oer6ZYCzwqaaPpvePC/7DELixTQONFC/vNpNutwQDgWWFIcbmBPMwIk
         hDraGMgpBg5+YMaAZgzRnQd45iJ0PD+HY2bJFYtEKvxd71m83plVfXpUEEvY0p0R3Qhm
         bXRgfYezsU0X8qQiuCZm9SuknhlX+q5Zk0KXNQJX38WRT1rnmxuCPRTRmL1EYowxWRqS
         wkcOyGUSmplf6h8T+ZfSaX8f2b5kDk4r3tzs9gP56BswwIu7gsU1XXhTvffW1C5ZCw7X
         JTUVwaX2Cj1CBimTRG/yTeBKgAc/GcLbBgDyFR2xTSxmcJrjObV6gmFFWvCDGxV+MowC
         Pz5g==
X-Gm-Message-State: AO0yUKWZNa5dXEOkJdrZ1Vp1z3CylWJYrOdhLmX7ZmTAulIuSUalfFZa
	aYsJyH4zVpd6uJbXr6G8AqE=
X-Google-Smtp-Source: AK7set/F/vAHk6cQOofkDJMVBMZUYjEPMWZm+MonLPRbXoJZTwkysJFfvEfV1hELi/mA+jpIqFUbeg==
X-Received: by 2002:a17:906:fe07:b0:8b1:7de3:cfaa with SMTP id wy7-20020a170906fe0700b008b17de3cfaamr24945626ejb.3.1678286496524;
        Wed, 08 Mar 2023 06:41:36 -0800 (PST)
Received: from felia.fritz.box ([2a02:810d:2a40:1104:c4be:f7db:77fd:b9e5])
        by smtp.gmail.com with ESMTPSA id j23-20020a170906255700b008d9c518a318sm7687620ejb.142.2023.03.08.06.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 06:41:36 -0800 (PST)
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	linux-nvme@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: repair malformed T: entries in NVM EXPRESS DRIVERS
Date: Wed,  8 Mar 2023 15:41:32 +0100
Message-Id: <20230308144132.13368-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230308_064141_071175_83DE0A27 
X-CRM114-Status: GOOD (  11.96  )
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

The T: entries shall be composed of a SCM tree type (git, hg, quilt, stgit
or topgit) and location.

Add the SCM tree type to the T: entry, and reorder the file entries in
alphabetical order.

Fixes: b508fc354f6d ("nvme: update maintainers information")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a51fdde146db..dd805e784e6d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14905,12 +14905,12 @@ M:	Sagi Grimberg <sagi@grimberg.me>
 L:	linux-nvme@lists.infradead.org
 S:	Supported
 W:	http://git.infradead.org/nvme.git
-T:	git://git.infradead.org/nvme.git
+T:	git git://git.infradead.org/nvme.git
 F:	Documentation/nvme/
-F:	drivers/nvme/host/
 F:	drivers/nvme/common/
-F:	include/linux/nvme.h
+F:	drivers/nvme/host/
 F:	include/linux/nvme-*.h
+F:	include/linux/nvme.h
 F:	include/uapi/linux/nvme_ioctl.h
 
 NVM EXPRESS FABRICS AUTHENTICATION
@@ -14945,7 +14945,7 @@ M:	Chaitanya Kulkarni <kch@nvidia.com>
 L:	linux-nvme@lists.infradead.org
 S:	Supported
 W:	http://git.infradead.org/nvme.git
-T:	git://git.infradead.org/nvme.git
+T:	git git://git.infradead.org/nvme.git
 F:	drivers/nvme/target/
 
 NVMEM FRAMEWORK
-- 
2.17.1


