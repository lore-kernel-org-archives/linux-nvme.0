Return-Path: <SRS0=7pRJ=KP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69EFAC433B4
	for <linux-nvme@archiver.kernel.org>; Thu, 20 May 2021 11:31:36 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3173C61057
	for <linux-nvme@archiver.kernel.org>; Thu, 20 May 2021 11:31:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3173C61057
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/VBpGO2xKmFFwUrijwnHU0X2jGFqbFrLCcxCo5x1IyA=; b=Wtq1FgPPFrwcrzeulAEpgScjmW
	mJG/XdE+CMy95G8amfFe9rvmX0D+qqW/yza3bHQwlJvikywgo2eQ0vux+5HN02rlGHmt4wG5R8TOJ
	qv06ZKN8vwLxFB7fTom5wXnlL58v4YpofWysYb4qOUSQL00whKcdbQee/oVCK4WSi7ejZYIHuYVoG
	f7/NXiwMs3iejcXnPbM86dPep9E/5f8Mm4FzETz+x0PFbH9yHNT5oWYV/LpN1SLgvZnU6ljrX//6q
	ZNVDuVyJQZRAxsMwCpGJ5+vIbnVro6kE/zlv+X5JHDk9jWs2aMaHgblYnc7kNKaXt7KrcmPJJig73
	7zpM15sA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ljgth-000UJE-Vz; Thu, 20 May 2021 11:31:26 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ljgtT-000UHw-HY
 for linux-nvme@desiato.infradead.org; Thu, 20 May 2021 11:31:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=gXu9uEcJna4q6NRWZgEPEDr8/VWcJ4AZ5wGy4RVofiM=; b=fhXAmpDDWOxhwCjEcWNOJyDGXd
 TlR9s1YOBAChdJh7V2eSoV/ZIu83naNX+okHSRbXgI5+WVGNkjm76VhgxQueYrSBqaDkHoSpGCceS
 RrSENrjTx3TA93ypkri7vgDLTCUcfCN8VxhYxvv7sHpF25wLndyTQm9c+QPXKZs5ZihBirXCr+uqN
 RdXUl4cWKGzzYphGBLCwO+9ysOQRx5R97PLinQydGGt4EvamhYCyC177uMNhU3Wd1a4WISTcL81Aa
 r1t1XghOJxexChbEEXnnhx9jh6rYzQtkLUDTNJBBPAWRKFpOyhrE3/x6Qz/hcS96WY8V9TpB+47lt
 rwWV6y+Q==;
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljgtR-00GFYq-6S
 for linux-nvme@lists.infradead.org; Thu, 20 May 2021 11:31:10 +0000
Received: by mail-pl1-x62c.google.com with SMTP id t21so8866005plo.2
 for <linux-nvme@lists.infradead.org>; Thu, 20 May 2021 04:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=gXu9uEcJna4q6NRWZgEPEDr8/VWcJ4AZ5wGy4RVofiM=;
 b=oGwLYSSEGMcvgPsAi2Hn5wAOOwZjx9xYPXXGI3nJKlE3sJI513PUOvs/e54D8nU8au
 lnoKoLS8r0uR3q8X5lZldwD590O9Z9DhRf9I8ouZqC7GxSV6Y1sf8R8nvdre7m6vqsOh
 sqKN7vzDTwyNaH6m75VJwklc7TH2cjFT01ePeC4puHmtKGakNuh8xZt5kQurOr2bBdT2
 OetlYD8qK1A2YMyJfIXui5jV6x0m61/wZC/dlysA67VRs99NCo7CJfL8b/bx71pnPJkM
 h2tWFNO3ZjZVmG6qOk0Fwbj0V4oWLUT/WQ+c/AbiZlXuJPrkeYDXajYLVfPfNoM7r2jp
 LoLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=gXu9uEcJna4q6NRWZgEPEDr8/VWcJ4AZ5wGy4RVofiM=;
 b=UybLaoxv2Lc2CA0StEu4xiIQrfNAk8HBbK5j40uF23n7lkuAxEODvjeTCyDFKuiL1I
 e+9rCCar5TZaI90iKgOOvSKy5e75BKFY/FpmIZeLwuTK7BBuO/HAcwmgvEz3N7FEUEVX
 /QUiA07ugP9LymuEzTD/L4p8dlg8G1mrYVGKmSPawXmdA5e4qt/XoQz/+nlcyOO13cI9
 t1lI4AnGL/ZLhKwfpYBqS4dsAjx/YN8qrN8YB11a9BTTrfCVk4DaYwwcK8BRD4YwTAAy
 1ZSdct7MJapJ5uxJXUHhxKs8h/3Q7fj8ypZJGLQUoMeU7s6i6fg8bhnFXJfvtbMhzJsK
 OVIA==
X-Gm-Message-State: AOAM5308Jv7gNOY1nYq/UEouk2I2fu+RlLY64olP+FfUuR7eLc5ZKims
 kUB0YH+3GHJEgloVSZH2ov+sUdelRdDv4g==
X-Google-Smtp-Source: ABdhPJw3s4C1ghFQwY7U/Fg193Pkd7W4PZGay4FDNZX8EnYxUOLlqCgKy4I0WOAAQvqY+Hg/nJTAKQ==
X-Received: by 2002:a17:90a:55c5:: with SMTP id
 o5mr4309924pjm.191.1621510267519; 
 Thu, 20 May 2021 04:31:07 -0700 (PDT)
Received: from houpudeMacBook-Pro.local.net ([61.120.150.70])
 by smtp.gmail.com with ESMTPSA id i197sm1917443pgc.13.2021.05.20.04.31.03
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 May 2021 04:31:07 -0700 (PDT)
From: Hou Pu <houpu.main@gmail.com>
To: sagi@grimberg.me,
	hch@lst.de,
	chaitanya.kulkarni@wdc.com
Cc: linux-nvme@lists.infradead.org, houpu.main@gmail.com,
 larrystevenwise@gmail.com, maxg@mellanox.com, elad.grupi@dell.com
Subject: [PATCH 0/2] nvmet-tcp: fix connect error when inline data size to 0
Date: Thu, 20 May 2021 19:30:44 +0800
Message-Id: <20210520113046.27821-1-houpu.main@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210520_043109_252521_0F5F5CDB 
X-CRM114-Status: UNSURE (   9.79  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

For nvme over tcp, connect error happens when setting inline data size to 0.
Patch 2 tries to fix this.

Patch 1 is a small fixes, it could be merged with patch 2 if you want.


Hou Pu (2):
  nvmet-tcp: fix inline data size comparison in nvmet_tcp_queue_response
  nvmet-tcp: fix connect error when setting param_inline_data_size to
    zero.

 drivers/nvme/target/tcp.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

-- 
2.28.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
