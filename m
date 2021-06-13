Return-Path: <SRS0=vQ/w=LH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D64A3C48BE8
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Jun 2021 20:03:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B4776124B
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Jun 2021 20:03:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B4776124B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=YOVm8E0kmkPXOWyMuFt6cizzCHwPj8lm7b0cw9VbT5E=; b=1ob6aRULW027dU
	NlBt59KzRQdXOyfmfEffB1BNXwm8JJCp1avCc9kOQw2SlcAtzddvFL2symq0XxHLLzC0wZM1kwLY5
	dgx2B8ZqgIA4ZXhGZIGDEHTge3seCLHjILLED88wzkUakF+aau7MfztYnPcGXMGHtxDr4cnh/JAXj
	MmOKp1LPrVw+iWH1KCrypMYXKJ2m+7JRdvA83plWafIMNjC0XKNbNz7GECjx/Sj56WZzkflD2x88F
	gYEhyp07fZHPZN2H0SpOZdlLOuEd//n5k73xUGv+MrUOs4nyaNeizR+RXFvUMreTGE0cX95B8AfQt
	VqQGbVWjq9N0GxzSMCNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lsWKA-00B6hZ-PZ; Sun, 13 Jun 2021 20:03:14 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lsWJu-00B6ga-0W
 for linux-nvme@lists.infradead.org; Sun, 13 Jun 2021 20:03:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1623614578; x=1655150578;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=lYQqG1+gldKyShUgqD5oI8qrc9iKijuN2GTrwFHqjcw=;
 b=Zr9It7d/VQsi8FGdFj8WOjKeXcl5YOtpzq93Zz7UrszBXclPPcTwuasH
 RLodpnZdJX0HZvaTnQ4e9EyJDgPJwquCmJa4grttjomi4upb4TgFOEEWA
 KPQvNHVDiBScZalusqeP9beUDtq9p3QEG/1VdjITzoqZ3051muM+QO06T
 OHdNOOg5q6kWU9pAKmr0bQL71iGTnuUV4hdwmpAIN7OdXsO4YeuK9/yKY
 R6pLnHSRSe/P/mx1dPHOVZJ4mJWHfPW+UdMjtNjgdWGcnwrYxd8DcpmKX
 Vz35q/RJPM7v0UCj05ZM89NlkgC335R5/FLTfsuaG5h+KyqFH7VtMkfd8 w==;
IronPort-SDR: 0vHtSOF/XKVK+/4towFcnKVMGbaP+jKz8yTxsgDBoCZvRfgXc0bIybJUsdhaM8CBpelh15dkOk
 KdQGZ8jQmKorAFSBF3rAFwUSKsIcKiX1Uh3dWsLTrHP6mr2jWdvkXOyOIOo+CSZlQMQvCxjfWc
 VX492Tyznb4gL4SSvherdgkfYP0SzMAN47SsV/HbQ507+tDjZHgSRLhc48aASaaR/qezXP87HV
 zfurNPKsCjG+E2/4ng6Pk/zRcqAPqiAEgvc7HLD68EnQa5WTgsLJpNMBX6Sx7P4VDTor3PdGOY
 Opk=
X-IronPort-AV: E=Sophos;i="5.83,271,1616428800"; d="scan'208";a="172326116"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 14 Jun 2021 04:02:54 +0800
IronPort-SDR: O3bPu78YfcOLm6R2QpEEM0uLFvdZWDxnq1n+EOYU0KZQT+7EHIiO1jMkHp68iCy5m7QHG53HhG
 LODCWtx6N6wmHQ/oLZfciY8e61Vgls4AcHcoZenfSPijtp/6NOM8cy33n6Ly10xsOw38DhjQ7z
 bcAoHR+gm42/pLfk9Hodhvi/CnQkBJA8fx9rnQC+eCk3k9v8qI+CtUuWv84XqEdiqo2puUuAiK
 +F4AJEDIBuW+I9nMzO96XWFh6RV8hWyyEJLbxP2HQbsYlnVjgvtNwI/nMkcnNXbyuZIA3+1zKo
 rRXgQHwGti5TV1fppvk8viXa
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2021 12:40:25 -0700
IronPort-SDR: NQHJXSIzOBiGh9jDnItxpjVZllyVIR66HNmJDsrqk/t9eVf8Chbc+j+fnJM6+4Zk8Maw1Nbd86
 kKrrKCjvNTewmX8FsO3Z5Kvur+npW9x0FtxVdwwRy3EADL2wqdFKQG0lx+hh+29Ka0u0IaCPR2
 WrLWlSKPOVxPfKLEwkBwoMeTzBFhNKgR0XQ3XdTNnCJherXnZT4ScDAdQ4dFs0/ozU/kfIOdau
 lBD/K2Zhy/8hrAUq3mqQHDSlnraKi5ntiMBvOsC0RItOp8OhS1/Cq/sP/Ng0Kb2NRQeZTiLA7A
 ktE=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 13 Jun 2021 13:02:54 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, dwagner@suse.de, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 0/3] nvmet: use right MNAN value for controllers
Date: Sun, 13 Jun 2021 13:02:49 -0700
Message-Id: <20210613200252.9167-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210613_130258_190851_22746500 
X-CRM114-Status: GOOD (  12.24  )
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

In current implementation we report MNAN value as NVMET_MAX_NAMESPACES.

For Spec regarding MNAN value:-

If the controller supports Asymmetric Namespace Access Reporting, then
this field shall be set to a _non-zero_ value that is less than or equal
to the NN value.

The first patch sets identify controller MNAN value to subsys->max_nsid
that is always less than or equal to the NN.

The second patch prevents creating the controller from subsys if subsys
has 0 namespaces since it will report 0 (invalid) MNAN value.

The third patch prevents reporting such subsys in the dicovery log page.

-ck

Chaitanya Kulkarni (3):
  nvmet: use subsys->max_nsid to report MNAN
  nvmet: prevent creating ctrl with no namespace
  nvmet: don't report subsys with 0 namespaces

 drivers/nvme/target/admin-cmd.c |  2 +-
 drivers/nvme/target/core.c      |  9 +++++++++
 drivers/nvme/target/discovery.c | 13 +++++++++++++
 3 files changed, 23 insertions(+), 1 deletion(-)

-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
