Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE096C4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Nov 2022 06:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IZvxZdeiFIot+38v8EtAu24anLrNTZ7iaQ1vpidLarE=; b=pmo+8pVeZbH2E5HrNRomTHzhoN
	1ia3QHp/1FgGaNcPV+eQvH2ZR2sSLV+wZTpKVPCQz7C/5S9c1U0cfQiuVXrCFxozFfq6bJPx8vj5e
	MwZ4WG0x5AMEgRAXHt/JER4C/VEn0YuLwJCMcVivoE/3lGHtc+VvHDCJzNztCt5n/+CmSCmS1YxQZ
	IfQooDdUNiANvHO7YMrAjZSHJkDJPyvfacsCELI+C3aeabThvOeq/PtQHktuaIei2+A0BpuzGzZz0
	gTU8tUD0viXB2n7Gvq/M2ojz/WjF1O0QHMppv+3lPk7QBXst+nsgpT3ss0FEgE1i3SbkmkBhhs1to
	kIfKYGaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osecd-00BD6N-Mm; Wed, 09 Nov 2022 06:31:39 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osecN-00BCm6-C1; Wed, 09 Nov 2022 06:31:24 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9EDF068AFE; Wed,  9 Nov 2022 07:31:19 +0100 (CET)
Date: Wed, 9 Nov 2022 07:31:19 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Gerd Bayer <gbayer@linux.ibm.com>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 11/12] nvme-pci: split the initial probe from the rest
 path
Message-ID: <20221109063119.GG10528@lst.de>
References: <20221108150252.2123727-1-hch@lst.de> <20221108150252.2123727-12-hch@lst.de> <e1225fb6-0cac-ba47-df03-0be84cb3a09b@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1225fb6-0cac-ba47-df03-0be84cb3a09b@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221108_223123_586405_AFA6999C 
X-CRM114-Status: GOOD (  17.13  )
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

On Wed, Nov 09, 2022 at 05:14:02AM +0200, Sagi Grimberg wrote:
>> -		if (dev->online_queues > 1) {
>> -			nvme_pci_alloc_tag_set(dev);
>> -			nvme_dbbuf_set(dev);
>> -		} else {
>> -			dev_warn(dev->ctrl.device, "IO queues not created\n");
>> -		}
>> +		dev_warn(dev->ctrl.device, "IO queues lost\n");
>> +		nvme_mark_namespaces_dead(&dev->ctrl);
>> +		nvme_start_queues(&dev->ctrl);
>> +		nvme_remove_namespaces(&dev->ctrl);
>
> Is this needed? isn't nvme_remove coming soon?
> In fact, shouldn't all these calls be in nvme_remove?

This handles the case where a controller controller does not have I/O
queues. For controllers that never had them (e.g. admin controllers)
none of the three calls above is needed, but they deal with the
case where a controller had queues, but they are going away.  I'm
not sure if that can happen, but it keeps the behavior of the existing
code.  Keith wrote it to deal with Intel controllers that can be in
a degraded state where having the admin queue live even without I/O
queues allows updating the firmware, so he might know more.

