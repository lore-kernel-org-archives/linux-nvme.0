Return-Path: <SRS0=kg3i=MP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD50C4338F
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Jul 2021 01:00:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 894B260EBC
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Jul 2021 01:00:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 894B260EBC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7oZyzwy1vsqMfloVe4AZP9CcW7Zf5yKhtAWs7UFUnso=; b=onBNRp/Azqlp+A
	T4YcBYtSgnaAy869O/Ml1RqJo8Qfmbp/XBpC+MCHt6wp0/uooVa7wE4JvN+9qGvUfURzcEZ5+HcxY
	NEFkzi+gLCb/LMTpJPYSyZ1mdRe1kRjHFjIPpSdgfX8mIND60jF6Eby/sVuLObXiVMJK1nBFj1jt/
	SKk+0jxidk2zeMEDKYtAb7czhdXGb9q0Ucu7NyzaLVlJ2Ijm7GqYHoHf+zHN8zS8QvTyAWgiK/QRG
	t99fHIF6sXIUiiZ8wRVmRwgYoeZVcsjmNeY0xUx8x0wvYSRnXiXlX8zOyKS8/3+TvMe98eED/L+vz
	bHRchZfX5xiacJD0WDZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m6jXd-0031tt-KP; Fri, 23 Jul 2021 00:59:53 +0000
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m6jXa-0031tP-9J
 for linux-nvme@lists.infradead.org; Fri, 23 Jul 2021 00:59:51 +0000
Received: by mail-pj1-x102b.google.com with SMTP id gx2so8498543pjb.5
 for <linux-nvme@lists.infradead.org>; Thu, 22 Jul 2021 17:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2W4Y1AVSnOCr4H+Q6K/fkpHGhoCWhH4qklf0PRTZ8pU=;
 b=hP/Di7u70ZLV+s3kxQ6DhZDHqgJh19473Kf+TrodMGeLXR3iYdp8BWR6cICt6hQjds
 Bwf6tAiAi4AwH01jwrf7gcWw8+rDOhmrl/c8La76bpFB/n4ypahfaJ3NgIIrN4CyqsPy
 g0L/B0B28L2Qqev0gj3ruS0OKD5EO1TPiUWMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2W4Y1AVSnOCr4H+Q6K/fkpHGhoCWhH4qklf0PRTZ8pU=;
 b=sXLlVg4OYIE0vwK4OiH8Vt+nyEwrQNh8WKpX7F/gY/+cyqbXJuMi+h2hoEq2NyimXP
 LL33ASHmGVCvIQe3k7JIUYOdI/U6srXDCnlymIS5AcP0GhaX0FcR2OaZXI0L2Fd9w+Ws
 +gAXpf93uOHmryUbGdT8VBuKWQxg7FuGyEDTXwNoKjn3HufTFiRvXOYHJwhp/DJmxhiG
 dgoKpowFP/lTATi7c4NYQsAfjqex8RWNo/aHxkk4Na2vn319efqYSiJMKFPxhulYJq6+
 nO4/9Xh1R1RhCNjHPIJD20MqHkibgKODDc651eKVPRrTiIkGapTeH9ZQ6JdlaosddmRT
 /I3w==
X-Gm-Message-State: AOAM533X1/UUaTHmNzjIsgPKiS8YsCDrCvno/8MO1s8nJNNCbTSFCMhf
 1yYMsAGlMNXAP+I+U3y28ZumWA==
X-Google-Smtp-Source: ABdhPJzEUCL87iEthcZhgUyN6/zHZjFYduESEb2wsJNm3zPFdCcV7COXSgtvmoJj1WxrUIQEr/KXjw==
X-Received: by 2002:a17:902:a710:b029:12b:9b9f:c461 with SMTP id
 w16-20020a170902a710b029012b9b9fc461mr1853546plq.59.1627001988721; 
 Thu, 22 Jul 2021 17:59:48 -0700 (PDT)
Received: from dlunevwfh.roam.corp.google.com
 (n122-107-208-179.sbr1.nsw.optusnet.com.au. [122.107.208.179])
 by smtp.gmail.com with ESMTPSA id b2sm35185425pgh.9.2021.07.22.17.59.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jul 2021 17:59:48 -0700 (PDT)
From: Daniil Lunev <dlunev@chromium.org>
To: kbusch@kernel.org
Cc: Mario.limonciello@amd.com, axboe@fb.com, campello@google.com, hch@lst.de,
 hughsient@gmail.com, jorgelo@chromium.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, sagi@grimberg.me
Subject: [RFC 0/2] Split out firmware upgrade from CAP_SYS_ADMIN
Date: Fri, 23 Jul 2021 10:59:41 +1000
Message-Id: <20210723005941.111198-1-dlunev@chromium.org>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210218170947.15727-1-mario.limonciello@dell.com>
References: <20210218170947.15727-1-mario.limonciello@dell.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210722_175950_384509_0E938D0A 
X-CRM114-Status: UNSURE (   7.29  )
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

Signal boost on this thread for we are interested in a mechanism like that to
avoid running firmware updater with root privileges. We are looking into using
the mechanism to be able to update NVMe and SATA devices from a user with
limited permissions, and to tighten the security for eMMC device, which
currently require only RAW_IO capability to perform a firmware upgrade.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
