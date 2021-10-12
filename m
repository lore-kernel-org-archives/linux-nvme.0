Return-Path: <SRS0=8G/6=PA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A901FC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Oct 2021 13:46:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B3EB60555
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Oct 2021 13:46:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2B3EB60555
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Lbu0LmTpswnC5yMU3ztoFkAlRcp0AP5x87zo8yrP6pc=; b=SzEvubdZj4R+2r
	fipQe+kWtDCOGHNBrGsWElWb9nL99INyAQHx2D995+ZpRPJfMKMBrB0piRqDTBHoi5lk2hLNG86oB
	9yXk609GUxrdTCWZ5oMledndDBtkzddWYY1uv4Tba9XaG6+MkwLL4b0WO3hvc0ROV2aCZGUtjtRHh
	AbxovHvGUXBsGBArf2F4Opq1TbDJCw5yDlqWEnylxYyCo60KImOtNjyQYqNw32qFjo18atIQei//X
	ZsAl9jluo0MByZkuZnLuIqMFmYt8mnNtdkMGJGkWmln+ejE1ScwCGaCQUmE/DScXLGtc/D4b45wbD
	o/42Hj9uuGTMFzwh5rlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1maI6S-00D4XS-0x; Tue, 12 Oct 2021 13:46:00 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1maI59-00D3yK-0D
 for linux-nvme@lists.infradead.org; Tue, 12 Oct 2021 13:44:40 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 1BFFE67373; Tue, 12 Oct 2021 15:44:36 +0200 (CEST)
Date: Tue, 12 Oct 2021 15:44:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Daniel Wagner <dwagner@suse.de>,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 linux-nvme@lists.infradead.org, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH 5/7] nvme: expose subsystem type in sysfs attribute
 'subtype'
Message-ID: <20211012134435.GA14007@lst.de>
References: <20210922063525.143045-1-hare@suse.de>
 <20210922063525.143045-6-hare@suse.de>
 <20210922080256.sxl437n22f2mcmsq@carbon.lan> <20211012131057.GB11640@lst.de>
 <5ced9d70-12ce-8995-3b94-ed4dc3c8e06a@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5ced9d70-12ce-8995-3b94-ed4dc3c8e06a@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211012_064439_231633_EF068BA9 
X-CRM114-Status: GOOD (  13.99  )
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

On Tue, Oct 12, 2021 at 03:43:22PM +0200, Hannes Reinecke wrote:
> >>>  	&subsys_attr_firmware_rev.attr,
> >>>  	&subsys_attr_subsysnqn.attr,
> >>> +	&subsys_attr_subtype.attr,
> >>
> >>
> >> Shouldn't this be subsystype to stay consistent with subsysnqn?
> > 
> > Hannes? I've aplied the patch for now, but the above seems like a useful
> > fixup to fold in.
> > 
> I don't really care. Should I send you a patch to update it?

That would be nice.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
