Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B430C5472F
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Aug 2024 14:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Eh0VzRORFKZhZFvFwkvP0kZK6MExTStJKlmuvnBU+kM=; b=FqtYDTFHVffpXwU/lybN32vRc0
	rmk+iJUN2zpkOJqEyYz0CawvYzlmPA1RUb3Q3zvr5syrAeetpQB90QdaOz6qGDtezmqaszhihnF5z
	5pAsWtY9w+NOdfsSjdP/rNfM1pYGWSLew0ybIl6siJAaYcyxYFpZBvn/oSTpUpb2sDNBbq9DeuJX4
	tWXvf6gfFeSMv+a9eXk+XLoCEws5n1Ohsk8pLF70/Yl+uTzl9ifjc4WfnvkwK73AZVfX6UiEMRWFs
	JavXcV6BVL67P2EFgGGoqVz/6TsSZv3vic9CWRCmpn82jaQ/pk3bTJDw+j6PWGxsmgXY0HR1GbV54
	reR/XHlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sixem-0000000BlXo-0Vmx;
	Tue, 27 Aug 2024 14:58:52 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sixds-0000000BlHN-1gYF
	for linux-nvme@lists.infradead.org;
	Tue, 27 Aug 2024 14:57:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id BE2B6A41B3F;
	Tue, 27 Aug 2024 14:57:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AAC6C61044;
	Tue, 27 Aug 2024 14:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724770675;
	bh=KU8fo/MpVgOPLr486ApuWjzsbSM+l8blnIPyfpFhI5Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=crTRU4f5SAvgAl2mGcYXsMIazGEVgHD75jvehoitJKsZGM7WN2cjhF4KRK4HcEeEo
	 4qmp7Q7KkjZzKS7WaIjB0KpwtpP9zGvdbXypSkd1c3AU5qbn6qwdDqE6rJMS1p8Hre
	 0m3VO90YFiHpFfYul8s3gIVeDnrnYQf0gZ+aXK86YESIdR9byJcXax7B9YLmOX8iFd
	 c+W38aJpWaNCHXlR1TyN3Lqvflv+eNwXVm16qLhysgPY1aB6itOvgI2CLVUEGWGtRi
	 risGIe4EjMXIt0/714ebhSUFaT212IBHbEu0C1HSKFiXQHQNYQmxN6+redwKjDspgI
	 S7XYMhJaNVrpQ==
Date: Tue, 27 Aug 2024 08:57:52 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	sagi@grimberg.me
Subject: Re: [PATCH] nvme-pci: allocate tagset on reset if necessary
Message-ID: <Zs3pcKTuruSHp8IV@kbusch-mbp.dhcp.thefacebook.com>
References: <20240826182719.3830725-1-kbusch@meta.com>
 <20240827054923.GA11156@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827054923.GA11156@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240827_075756_527727_2BD8BCA9 
X-CRM114-Status: GOOD (  12.67  )
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

On Tue, Aug 27, 2024 at 07:49:23AM +0200, Christoph Hellwig wrote:
> On Mon, Aug 26, 2024 at 11:27:19AM -0700, Keith Busch wrote:
> > +	if (!dev->ctrl.tagset) {
> > +		nvme_alloc_io_tag_set(&dev->ctrl, &dev->tagset, &nvme_mq_ops,
> > +				nvme_pci_nr_maps(dev), sizeof(struct nvme_iod));
> > +	} else {
> > +		blk_mq_update_nr_hw_queues(&dev->tagset, dev->online_queues - 1);
> 
> Overly long line here.  Maybe just return early after the allocation
> above?

Done.

I think I should also add more details to the change log because this
bug does cause a kernel crash. I think this is the first commit that
removed tagset allocation from reset_work:

Fixes: eac3ef262941f62 ("nvme-pci: split the initial probe from the rest path")
> 

