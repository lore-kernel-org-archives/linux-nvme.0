Return-Path: <SRS0=DDko=AE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 115FBC433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jun 2020 14:59:42 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D285B20723
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jun 2020 14:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BLEQs4Ap";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1e47alOJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D285B20723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=XvU4yM12ETn7o47DQvklPEbSepa1zzp2oiKhDfVJA+c=; b=BLEQs4ApvWmHt8z2L7omJ3rb4
	vjA1BtTxcXrH/YhZcTehMoqWa4XwfhjzSWaMeHHz6z/AD5/tY6rzfylUDLSrG2cRzULsZa5cX8KCu
	QPtAK56MABC+PYppd6PwnO07iEeDF3EE+FE28rpxqfvVadmS2dTr5Nm0K9lbhgfDb5EE9tHzTYJTv
	GybXcSR9AQElA/YseEnwQXDmeHcJfz7WJCbVhzPEeaOGNL9ykCqU7uRWGMnlta+nASGw0/pb/AL70
	INnqFYszdY/Ka7JGu7uM83UQPZbzZuLAc4mVyTbWtgq3l2yKS44BpHPL0LBnIpV85woNujXeJJq8N
	I7XKt0qeA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jnkOi-000465-4I; Tue, 23 Jun 2020 14:59:40 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jnkOf-00045D-OP
 for linux-nvme@lists.infradead.org; Tue, 23 Jun 2020 14:59:38 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4D12920723;
 Tue, 23 Jun 2020 14:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592924377;
 bh=/Qkci1EEnMCWNpzEwR13xM7o3TscwH9pyJgzBww5lv0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=1e47alOJYPzSlqwRXo9pkqSlo+vYqR5JzNXKOTIptcly8djVuf7hlRw9DHD/zIkjI
 8DVDrzswRdL7os0bUJTD/MtBbt5wC1fUTuYJx2IjUtofnGwF6g/LxSH8qFZzMY7/4P
 8I+QvPwFym98s5b2clUJ9vVBFASKmTrKUz/gc1Lw=
Date: Tue, 23 Jun 2020 07:59:34 -0700
From: Keith Busch <kbusch@kernel.org>
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Subject: Re: [PATCHv3 3/5] nvme: implement I/O Command Sets Command Set support
Message-ID: <20200623145934.GC1288900@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200622162530.1287650-1-kbusch@kernel.org>
 <20200622162530.1287650-4-kbusch@kernel.org>
 <69e8e88c-097b-368d-58f4-85d11110386d@grimberg.me>
 <20200623112551.GB117742@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200623112551.GB117742@localhost.localdomain>
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Daniel Wagner <dwagner@suse.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
 "hch@lst.de" <hch@lst.de>, Matias Bjorling <Matias.Bjorling@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jun 23, 2020 at 11:25:53AM +0000, Niklas Cassel wrote:
> On Tue, Jun 23, 2020 at 01:53:47AM -0700, Sagi Grimberg wrote:
> > >   static int nvme_setup_streams_ns(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
> > > @@ -1930,6 +1950,15 @@ static int __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
> > >   	if (ns->lba_shift == 0)
> > >   		ns->lba_shift = 9;
> > > +	switch (ns->head->ids.csi) {
> > > +	case NVME_CSI_NVM:
> > > +		break;
> > > +	default:
> > > +		dev_warn(ctrl->device, "unknown csi:%d ns:%d\n",
> > > +			ns->head->ids.csi, ns->head->ns_id);
> > > +		return -ENODEV;
> > > +	}
> > 
> > Not sure we need a switch-case statement for a single case target...
> 
> I would consider it two cases. A supported CSI or a non-supported CSI
> (which means any CSI value != NVME_CSI_NVM).
> 
> However, a follow up patch (patch 5/5 in this series) adds another case
> to this switch-case statement (NVME_CSI_ZNS).
> 
> I guess this patch could have used an if-else statement, and patch 5/5
> replaced the if-statement with a switch-case.
> However, since a patch in the same series actually adds another case,
> I think that it is more clear this way.
> (A switch-case with only two cases added, in a patch that is not the last
> one in the series, suggests (at least to me), that it will most likely be
> extended in a following patch.)

Yeah, this patch is laying the foundation for future command sets.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
