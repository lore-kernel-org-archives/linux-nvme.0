Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FA91C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Apr 2022 00:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=PvgQEVGOj3yHRAJSh95613lBNApR4G1//R4YAdPTUPA=; b=PUrnOfFPRWFmt/BHRc9HsMLXlP
	zoJftH/q0/me1WBibulogERVrLZOEQBV5uirRjlfrzATNP9poQKTfs0b8GWb82q3eIu8XcPfNQsr4
	iFb1JfAUSWBFelqp8DH0GJ+DVvjoNdQHCtYhns/hhHESCjw02MwLKoyKD9ucBv3J8ztRXjRKsn57C
	3fmmjOTDk44QC7bzgGcw0+mgb7jVfjFDLUsdRfdyZeS0qIdX1gYGey1oolU/XtQHvSvOuhLmzjvic
	cuG/49Y3Hn5VCwO0E0Lm6gte0VCjrMHg94RgvXTnYbYfOE0syItQRpZNWOZfGNS3KVWAtBhhQtLjZ
	Dja7K0zQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1neQnm-00GAa3-Jm; Wed, 13 Apr 2022 00:24:06 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2
 (Red Hat Linux)) id 1neQnk-00GAZp-VK; Wed, 13 Apr 2022 00:24:04 +0000
Date: Tue, 12 Apr 2022 17:24:04 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: bvanassche@acm.org, yi.zhang@redhat.com, sagi@grimberg.me
Cc: Luis Chamberlain <mcgrof@kernel.org>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: can't run nvme-mp blktests
Message-ID: <YlYYJC/WUEsnI9Im@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

I do have CONFIG_NVME_MULTIPATH=y but I also have:

cat /etc/modprobe.d/nvme.conf 
options nvme_core multipath=N

And yet I always end up booting with:

cat /sys/module/nvme_core/parameters/multipath 
Y

So trying to run:

nvme_trtype=rdma ./check nvmeof-mp

I end up with the warning:

nvmeof-mp/***                                                [not run]
    CONFIG_NVME_MULTIPATH has been set in .config and multipathing has been enabled in the nvme_core kernel module

Are there times where one cannot disable multipath? I'm not using
any nvme drive at boot, but I do use one for a random data parition.

Any tips?

  Luis

