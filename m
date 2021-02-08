Return-Path: <SRS0=c0j7=HK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6BCAC4332D
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Feb 2021 15:05:20 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BE0C64EE4
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Feb 2021 15:05:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BE0C64EE4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=6/YICviPkXtketZLTX2xiaXxMYIKZDf2lYQEPKi8D8k=; b=rvdyLfAZ0HnrZ2hPpt1M/Fyza
	najOicBc/VOxb6uY7driLAtd3AbeZoMcDmgITrn9wUHe8PPSgUbnqY3pWRCiORnD56+IslMI25Q+5
	+4SfRuQo1BMNSiu6+/Lmg9oRmzL8c7DWrM0L/yVenOVEUlzRwftq8WO+vCyRaEx10H+Y8KvAw684r
	VFJgAQyTRAaXaxzrfRfoV2M/fJh5rY5E/oci4u4spNRIbcamSF1KmTds1/EKU8WhE2cilTNTb+9fp
	LeYJH0XP5Rh1FRSYo+EyS5LOhqgs4yP8l1mD/uWSQgYJHd+21ypnKJDKOksq62bA8mafRQNcsX2RB
	LKVlcG3Gw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l986G-0003Zl-TC; Mon, 08 Feb 2021 15:05:16 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l986E-0003Z6-Cf
 for linux-nvme@lists.infradead.org; Mon, 08 Feb 2021 15:05:15 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 362A768AFE; Mon,  8 Feb 2021 16:05:09 +0100 (CET)
Date: Mon, 8 Feb 2021 16:05:09 +0100
From: "hch@lst.de" <hch@lst.de>
To: Minwoo Im <minwoo.im.dev@gmail.com>
Subject: Re: [PATCH] nvme-multipath: set nr_zones for zoned namespaces
Message-ID: <20210208150509.GA12734@lst.de>
References: <20210205195002.2657209-1-kbusch@kernel.org>
 <BL0PR04MB65147CDC426FC6345B2048D7E7B09@BL0PR04MB6514.namprd04.prod.outlook.com>
 <20210208032851.GA14062@redsun51.ssa.fujisawa.hgst.com>
 <BL0PR04MB651449A902E7FAD397E2169EE78F9@BL0PR04MB6514.namprd04.prod.outlook.com>
 <20210208145747.GA8941@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210208145747.GA8941@localhost.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210208_100514_554707_645B91BC 
X-CRM114-Status: UNSURE (   8.01  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <kbusch@kernel.org>, Damien Le Moal <Damien.LeMoal@wdc.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Feb 08, 2021 at 11:57:47PM +0900, Minwoo Im wrote:
> But, there are also little more differences between the path namespace
> and head namespace:
> 
> 	cat /sys/block/nvme0n1/queue/nr_requests:	128
> 	cat /sys/block/nvme0c0n1/queue/nr_requests:	1023

nr_request is a noop for bio-based drivers.

> 	cat /sys/block/nvme0n1/queue/iostats:		0
> 	cat /sys/block/nvme0c0n1/queue/iostats:		1

iostats for bio based drivers require extra code, and we don't really
need those.

> 	cat /sys/block/nvme0n1/queue/rq_affinity:	0
> 	cat /sys/block/nvme0c0n1/queue/rq_affinity:	1

rq_affinity is a noop for bio based drivers.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
