Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28476C63703
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Dec 2022 15:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Wjikf8BONkNBHq/mdSHMPb1S0WDsfH+RsTxDU14w2U8=; b=brZkCmCfEsHboDv9dz5xQUpvYd
	zPPrwesAx4y4N3X5iqzWWadBNLLHAkHE/t9LI1BxcYH8BQR4qyukmcUlLErMa1SHZxKdzLRM70O7k
	ErgQPkSIgKVS2sHBQXv9prs0aNK/ym5duX7BDl3bc0eU4OQXcgozg4qcy20806DEkLoDThkaGNFYQ
	rcF3oUdzfBJapFRzzhoS2NOIwOzQHUZQU605mhpjHR9gOqos67o3ffDe+6t4YCnb8S5QWsprhv3WV
	NBDcSRB6IteHipyhXNIdbUFY+uggFWlkB99hx56odNNMvQIq+r9LF+zOOhuUU7O9di4kwAcq41iX7
	TRHVlD8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2wQW-005rvj-TK; Wed, 07 Dec 2022 15:33:40 +0000
Received: from mail-qk1-x72a.google.com ([2607:f8b0:4864:20::72a])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2wQU-005rpD-3G
	for linux-nvme@lists.infradead.org; Wed, 07 Dec 2022 15:33:39 +0000
Received: by mail-qk1-x72a.google.com with SMTP id j26so10219022qki.10
        for <linux-nvme@lists.infradead.org>; Wed, 07 Dec 2022 07:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wjikf8BONkNBHq/mdSHMPb1S0WDsfH+RsTxDU14w2U8=;
        b=WLyP/sfOhBiMsNF2s65Gxuq7n9uP2ESaakKI/3HI1+vYUOiel9xaoXz4rrPACjE1t6
         BcAHNJCIpzJ3DcERjul4uyDvWESyrxasi3bBWJGFp3W+fkHrf9Jvg3wGOJa8qBdBJbJJ
         r+a2klUQv/qyzv7o81LiM0UrHNEE9sgzO2I00mp1FAqrnsn7/8TsfzUYJP+u3SP3Viab
         XmkrnQPBMqktuVRXx1NySaLMv9T14aEYK0Pbr6gyMRycrQEN+aT528SEbc/byp3iOQh+
         jGD3RhcmDgwvBvuaUIpDQq/WhR4jfDsEHX27fFvpg5PNbyPfHtWh4Iksxi/ZxJUi38g5
         RaAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wjikf8BONkNBHq/mdSHMPb1S0WDsfH+RsTxDU14w2U8=;
        b=TqLhWNS4Uv+vZxttu6al9O3ewNl8D14ZuTsiuWfMLqLhLq3tJOiMn07kS9AUX+J9lp
         3Am9yEwCHJ82Lkvr0PvziquaB3ipJSMRO8ib1mMeyBmXB1HbPx1EYTi82NKZENh9m5ot
         fkOs35FljY5BeQS2MNBIgGjKCD1gtUqVTN6vb4+H0gYymyIz6hEBW6gGFDCbgKopMQKI
         ixeQj2FbqayTTeI+JB3oLVwAKMeF/2Zu6mG7w0iU99wfIRWsXoc2UrCmWPO/OjdU/aIN
         PlXogflX7n2gZWtteOLO3xJFKznadKskGTsEfKlI68pQ2I7Thm5H7mLDS5XKBC+XDL7h
         jpUQ==
X-Gm-Message-State: ANoB5pncifeRfjHW4RWcA7OQCupJnv2q4WLBfTnmvEO8MU1mKXISaAqs
	giH3SN8pwA/C0QNC7VS9xNN5Ng==
X-Google-Smtp-Source: AA0mqf6H3CUbZahGNznYB0JQYDxDw79bxzgM/h4A32ynuBG2ju5kK/9OhXvFJpvphgAQq9r/tBJFwA==
X-Received: by 2002:ae9:e919:0:b0:6fe:c7a2:b2d0 with SMTP id x25-20020ae9e919000000b006fec7a2b2d0mr8631309qkf.317.1670427215720;
        Wed, 07 Dec 2022 07:33:35 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-122-23.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.122.23])
        by smtp.gmail.com with ESMTPSA id o21-20020a05620a2a1500b006eeb3165554sm17830112qkp.19.2022.12.07.07.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 07:33:35 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1p2w0t-005E3g-AJ;
	Wed, 07 Dec 2022 11:07:11 -0400
Date: Wed, 7 Dec 2022 11:07:11 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@lst.de>
Cc: Lei Rao <lei.rao@intel.com>, kbusch@kernel.org, axboe@fb.com,
	kch@nvidia.com, sagi@grimberg.me, alex.williamson@redhat.com,
	cohuck@redhat.com, yishaih@nvidia.com,
	shameerali.kolothum.thodi@huawei.com, kevin.tian@intel.com,
	mjrosato@linux.ibm.com, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, kvm@vger.kernel.org,
	eddie.dong@intel.com, yadong.li@intel.com, yi.l.liu@intel.com,
	Konrad.wilk@oracle.com, stephen@eideticom.com, hang.yuan@intel.com
Subject: Re: [RFC PATCH 1/5] nvme-pci: add function nvme_submit_vf_cmd to
 issue admin commands for VF driver.
Message-ID: <Y5CsH5PqMYAWYatw@ziepe.ca>
References: <Y49HKHP9NrId39iH@ziepe.ca>
 <20221206135810.GA27689@lst.de>
 <Y49eObpI7QoSnugu@ziepe.ca>
 <20221206153811.GB2266@lst.de>
 <Y49k++D3i8DfLOLL@ziepe.ca>
 <20221206165503.GA8677@lst.de>
 <Y4+U3VR2LeEh2S7B@ziepe.ca>
 <20221207075415.GB2283@lst.de>
 <Y5CWVu08abcOuEQH@ziepe.ca>
 <20221207135203.GA22803@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207135203.GA22803@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221207_073338_215308_8E9309C1 
X-CRM114-Status: GOOD (  29.00  )
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

On Wed, Dec 07, 2022 at 02:52:03PM +0100, Christoph Hellwig wrote:
> On Wed, Dec 07, 2022 at 09:34:14AM -0400, Jason Gunthorpe wrote:
> > The VFIO design assumes that the "vfio migration driver" will talk to
> > both functions under the hood, and I don't see a fundamental problem
> > with this beyond it being awkward with the driver core.
> 
> And while that is a fine concept per see, the current incarnation of
> that is fundamentally broken is it centered around the controlled
> VM.  Which really can't work.

I don't see why you keep saying this. It is centered around the struct
vfio_device object in the kernel, which is definately NOT the VM.

The struct vfio_device is the handle for the hypervisor to control
the physical assigned device - and it is the hypervisor that controls
the migration.

We do not need the hypervisor userspace to have a handle to the hidden
controlling function. It provides no additional functionality,
security or insight to what qemu needs to do. Keeping that
relationship abstracted inside the kernel is a reasonable choice and
is not "fundamentally broken".

> > Even the basic assumption that there would be a controlling/controlled
> > relationship is not universally true. The mdev type drivers, and 
> > SIOV-like devices are unlikely to have that. Once you can use PASID
> > the reasons to split things at the HW level go away, and a VF could
> > certainly self-migrate.
> 
> Even then you need a controlling and a controlled entity.  The
> controlling entity even in SIOV remains a PCIe function.  The
> controlled entity might just be a bunch of hardware resoures and
> a PASID.  Making it important again that all migration is driven
> by the controlling entity.

If they are the same driver implementing vfio_device you may be able
to claim they conceptually exist, but it is pretty artificial to draw
this kind of distinction inside a single driver.

> Also the whole concept that only VFIO can do live migration is
> a little bogus.  With checkpoint and restart it absolutely
> does make sense to live migrate a container, and with that
> the hardware interface (e.g. nvme controller) assigned to it.

I agree people may want to do this, but it is very unclear how SRIOV
live migration can help do this.

SRIOV live migration is all about not disturbing the kernel driver,
assuming it is the same kernel driver on both sides. If you have two
different kernel's there is nothing worth migrating. There isn't even
an assurance the dma API will have IOMMU mapped the same objects to
the same IOVAs. eg so you have re-establish your admin queue, IO
queues, etc after migration anyhow.

Let alone how to solve the security problems of allow userspace to
load arbitary FW blobs into a device with potentially insecure DMA
access..

At that point it isn't really the same kind of migration.

Jason

