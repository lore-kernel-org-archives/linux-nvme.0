Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C771C6FA83
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Sep 2022 07:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Rp7tfFaw/5/3OSN9x1diVf6OvwiDaTqegkT0VtaPbnE=; b=NR6AsdrB14xoUq0AYV57NC+VuD
	+FlQf5b28V8lp0F1EMZa2kxjsujLSe+JcBwgw4xzreoIZucyPB6/0b1VJS4wux5+V/24Ry2HAvu0r
	Kd9WGUaRlvQsS8A12a84qWGfwWnP/heeTFfWe39v1ZdciYTQnlHJJ1w4AA4+XOJNtld5kEvJb8b87
	64gSwFQzaVwx7EtpBmmBmLyu1ORN4REWyRVDmz5Y7pMQRtjOfEK4FOdn27mmCwoBM1J5P4ZT1M1SK
	UC+LAPUXductHezR4KgGRnT+ludy0mXGSyzM0kd8eXu0pVpT6fqHFoP3nB2RdVqfkutjzVCPfyJtZ
	PNPiEy6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1od4rO-008k7U-L6; Tue, 27 Sep 2022 07:18:30 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1od4rL-008k66-J1
	for linux-nvme@lists.infradead.org; Tue, 27 Sep 2022 07:18:29 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7B00D68AA6; Tue, 27 Sep 2022 09:18:23 +0200 (CEST)
Date: Tue, 27 Sep 2022 09:18:23 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>,
	James Smart <james.smart@broadcom.com>
Subject: Re: [PATCH v2 0/2] Fix missing AENs when discovery controllers are
 disconnected
Message-ID: <20220927071823.GA16121@lst.de>
References: <20220922081538.13364-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922081538.13364-1-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220927_001827_787003_4C1DBF97 
X-CRM114-Status: GOOD (  10.53  )
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

Thanks,

applied to nvme-6.1 after fixing up the bit positions.

