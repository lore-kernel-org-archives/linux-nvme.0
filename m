Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CF4BC352A1
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Dec 2022 17:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GGYm/U8zQZjJljcYBsuBB43oBO+UowQVbQ4PB8XzHy4=; b=p17i945xEeSpO+BNBJZ/K4PZSs
	caVDAs7yTnc9vmtA+QBRcXYZzf9+iariSs4P3n81vkuBFktMYG8FwFwV9xhkSa6Mc6qgJoFPc/r+8
	PDJBA4fbEHsrMNRhDpUGd3MP3WO4RJibSugFmkbfy9Yh2TIuOToaYsxS7XzvC3/4bKQMrP97M9QKH
	Ei5O0lbSvhyGWzAU2sd53uxKnWH9w3myPtZU8UzNubm8UWOm2jsiQHvMAK+pDiXxcQgnj1rzmGNud
	pHhHd3SY2nWy28eo8d2+2dy59fTBZWvssO1j+OboMSJuONqtMCv4/Ul75rrihY0t6TfkscHy7hz4R
	icUGg+vQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2yGu-007P2d-Lf; Wed, 07 Dec 2022 17:31:52 +0000
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2yGs-007OxV-MO
	for linux-nvme@lists.infradead.org; Wed, 07 Dec 2022 17:31:52 +0000
Received: by mail-qt1-x82f.google.com with SMTP id ay32so8656470qtb.11
        for <linux-nvme@lists.infradead.org>; Wed, 07 Dec 2022 09:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GGYm/U8zQZjJljcYBsuBB43oBO+UowQVbQ4PB8XzHy4=;
        b=JVYHn2Uq7dr+ybmwbABL740dori9GKB6509NnTrMEa0HWmWilQWCIsVF0ukAsjG0NJ
         QB//ZxGk2bJyMjHgSdkpktwlHmE19dA8spOKyggVH/cdq3YhnCzM1OQu10Am4JJ/l6b9
         2nSL+gRXQWCEy3K+o7LxOw8fQnrdBysQlRwgT7fXE1KZKfzPNG6gD8G5T0vGKFy/spxj
         FSD0L66l01my1N0CgZoGKZTtdXiH42Kst31L7UDnWFgCpMa2vTSyYkSWzRCMEwZlVv6M
         KWPgTxnjaLbHpwVKG8Sc8MS+9eVKpTy4TSwNughyBUWBb5GB6feee5Zf7HbiedQI/CPq
         GFyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GGYm/U8zQZjJljcYBsuBB43oBO+UowQVbQ4PB8XzHy4=;
        b=Lz+NB6cmNdxEXJzuqY4JJqYSAvJnaaPK6A/gsw2fDCBOdNTafRwKlbcrqoBw5Q4Qzn
         wHhwplk4gvzvd9KMp2qemzYzlKkcc8txRnqimQ9JHZq2YkHuikqvDCFi1lUMgtjafAh7
         otZ6JLMObdm/VC+hVaaL2jOCDbeSZ7ROo5kd7/qoe4PDWm/7YABftOmBJc8IvKAWTa/6
         yuOSVtQcvfdFHb3PtiAfZGqqZ23FQ1YjP1FDcT1wNiA03+YGRrPTRUqFAVfURIbJWXiw
         COXZTKRf7JiOcOYsxNWKrWYFg5yww+vav1zu6t2VQ4wfqcoOCrz5AaL3mlgNodo/Gn/C
         Oa/g==
X-Gm-Message-State: ANoB5pnjNMExEfgzf/QIIpq7LfwIwbhDhI9yRwlzwSgzjVmInEX9+z59
	qTPVn2/KG4MHqImdcfEMl+UDCQ==
X-Google-Smtp-Source: AA0mqf42zyYSULlUE4U8ptwueXX6sRZDqQITBgKVrqFCvFRJD27eq+kQvOKvmlFR+vkVg2fYBCK3PA==
X-Received: by 2002:a05:622a:17cb:b0:3a6:21fd:6c9a with SMTP id u11-20020a05622a17cb00b003a621fd6c9amr71657357qtk.545.1670434305934;
        Wed, 07 Dec 2022 09:31:45 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-122-23.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.122.23])
        by smtp.gmail.com with ESMTPSA id t3-20020a05620a450300b006eea4b5abcesm18442401qkp.89.2022.12.07.09.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 09:31:45 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1p2yGm-005IGO-HV;
	Wed, 07 Dec 2022 13:31:44 -0400
Date: Wed, 7 Dec 2022 13:31:44 -0400
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
Message-ID: <Y5DOAKArjyfb6Mcz@ziepe.ca>
References: <Y49eObpI7QoSnugu@ziepe.ca>
 <20221206153811.GB2266@lst.de>
 <Y49k++D3i8DfLOLL@ziepe.ca>
 <20221206165503.GA8677@lst.de>
 <Y4+U3VR2LeEh2S7B@ziepe.ca>
 <20221207075415.GB2283@lst.de>
 <Y5CWVu08abcOuEQH@ziepe.ca>
 <20221207135203.GA22803@lst.de>
 <Y5CsH5PqMYAWYatw@ziepe.ca>
 <20221207163857.GB2010@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207163857.GB2010@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221207_093150_759846_2C9A1451 
X-CRM114-Status: GOOD (  15.87  )
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

On Wed, Dec 07, 2022 at 05:38:57PM +0100, Christoph Hellwig wrote:
> On Wed, Dec 07, 2022 at 11:07:11AM -0400, Jason Gunthorpe wrote:
> > > And while that is a fine concept per see, the current incarnation of
> > > that is fundamentally broken is it centered around the controlled
> > > VM.  Which really can't work.
> > 
> > I don't see why you keep saying this. It is centered around the struct
> > vfio_device object in the kernel, which is definately NOT the VM.
> 
> Sorry, I meant VF.  Your continued using of SR-IOV teminology now keeps
> confusing my mind so much that I start mistyping things.

Well, what words do you want to use?

Regardless of VF/VM, it doesn't matter - my point is that the
vfio_device is the hypervisor control for *whatever* is under the
vfio_device and it is not desirable to break it up along arbitrary HW
boundaries.

I've given lots of reasons why not to do this now.

I strongly suspect it can work technically - as ugly as it is Pensando
shows an approach.

So I don't think I've learned anything more about your objection.

"fundamentally broken" doesn't help

It is a major point, because if we are going to have to rip apart all
the uAPI we built here and are completing the qemu work for, we need
to come to an understanding very soon.

And given how difficult it has been to get to this point, I want a
*really* good reason why we have to start again, and rewrite all the
drivers that exist and are coming.

Jason

