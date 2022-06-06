Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AFB5C433EF
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jun 2022 15:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/3h8XmjbEv1X9r5vK05Sz6/Er02Y93RMLDDwbkih8jc=; b=u0TtdsHjdqwARFGq1elgQc6xEP
	pYeMm1PCp1m6qEV/uur6JbsQShn3bfUn9y1UvXlrmwy6LB/VoWwq0f9f27PoDmziHnOgfOoP8AWvA
	TsrB6MmN13yDsScqbAhPTxVjcHSOFs0Xe+8qUGdSKo+FgB1M9hb/s0MByxaQIQvkDM6Td/lignICm
	/8BQ5XG+qqRj9qFgp7qQiD7qyRnTIO0CP19hvaWlZBzPhX650DFbYeONtKCkTySrPHsbL1caozo6z
	vAMnhBgscg5S7AcplDq6kK18i45XQSXrvM3gwcBBTvzaVv5dRWJlI9zgFhKPMOo+OIdYcPYMzXisV
	GudmSF0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyEGg-001fmC-B5; Mon, 06 Jun 2022 15:03:46 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyEGC-001fMR-Hv
	for linux-nvme@lists.infradead.org; Mon, 06 Jun 2022 15:03:19 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7E9CD68AFE; Mon,  6 Jun 2022 17:03:07 +0200 (CEST)
Date: Mon, 6 Jun 2022 17:03:07 +0200
From: Christoph Hellwig <hch@lst.de>
To: Stefan <stefan@pimaker.at>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 4/4] nvme: check that EUI/GUID/UUID are globally unique
Message-ID: <20220606150307.GA9647@lst.de>
References: <6d463ee2-62d6-e36c-7059-af7fbf8639c8@pimaker.at> <20220606064055.GA2450@lst.de> <yvyNnbOuo1IZcw39mQoii7v-nZd1UfjV4OpU7gDT5Nacp5OsOzOvQUruPUp4haa2EX3dyB03_ye1D16XYFbY1-IWvHESkp3OWxIjSQO1WVg=@pimaker.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yvyNnbOuo1IZcw39mQoii7v-nZd1UfjV4OpU7gDT5Nacp5OsOzOvQUruPUp4haa2EX3dyB03_ye1D16XYFbY1-IWvHESkp3OWxIjSQO1WVg=@pimaker.at>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220606_080316_807372_AD610A36 
X-CRM114-Status: GOOD (  14.93  )
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

On Mon, Jun 06, 2022 at 12:42:41PM +0000, Stefan wrote:
> Will do, but just to clarify: Is this a problem with my specific drive or
> with the controller? FWICT my drives use a Phison PS5016-E16, which seems
> quite common in consumer PCIe 4.0 SSDs.

In general ID reporting like this is a firmware issue, so it is not
directly related to the controller hardware.  However for cheap
consumer drives most vendors simply take the default reference firmware
and ship it with the minimum required changes.  So if Phison fucked this
up, chances are it will be in most of these controllers.

> If I add the quirk for 1cc1:5350 it would only override it for this
> specific ADATA/XPG model, correct?

Yes.  We have to way to find out what actual controller hardware or
reference firmware a given device is based off.

