Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F6DAC4708C
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Dec 2022 19:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GG73iLTCO/uw4M1Ylg2jcMVxqfgJjKpsiaTSmU2EXGA=; b=B5kXfzjc0XQb+l6SMzAqysPvMr
	fTJi+jfMPp7WxUKVKX1Xs+QnlVrFmDy34jA7ZFZyobHU2aJ3SEyLaDJncFxhb36PMWS061dnozvH4
	XRgHH2PRA003sCU7j7GILrUQEdXKadWmEd41Ks5gg6CYCqZdXvVgfNoMtAIpOjQJiE6ut4XTZCyTb
	MIzvcp0kIAWF9K73H3KDSo/HRjWKZZjzF8Ww2qFab8keEG0nMFRFJFia/Ru9X0T0sreVQozo0eG3m
	Y+3byzIW6I/1/3e1oO3pZq8NzMod/m2FffG6zUp23FqBHySkuopjkhvyMrv4bETEc6bZuCqwb3r/+
	esWQsAXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2dPx-000QBg-PL; Tue, 06 Dec 2022 19:15:49 +0000
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2dPu-000Q21-II
	for linux-nvme@lists.infradead.org; Tue, 06 Dec 2022 19:15:48 +0000
Received: by mail-qt1-x82d.google.com with SMTP id h24so14497131qta.9
        for <linux-nvme@lists.infradead.org>; Tue, 06 Dec 2022 11:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GG73iLTCO/uw4M1Ylg2jcMVxqfgJjKpsiaTSmU2EXGA=;
        b=JIXO4eFgOaT8ujjjyeXvuO8qQ+yypxhZOimo6XQPj9ykjHnpz42lA0hxwRS2CqALlP
         InZ5KniMwf4gL2CkysIfWTSK/zRhcKpgYW1h7jk80RV72fs+TIGlADEs1qMbux4LzQXs
         kgFo0jiGF80V8ESdg6/Y8ivo2WWI0dTsZ+SjdqyptOk2b/5s3bOyMy2Cjfh133fw5t7P
         inVYux5ZW6ridMLq77+CizaOGY5xhsgGqo/Q+axhpiXkSy3h5saQm0aOlMTavw/1Z53L
         RwcTU+ikujUo3UDBcOg37Tvhuh6FiRok4lYQDG1ACo4Agcpan+pZrTeBeKsNDB9ShmHe
         G8Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GG73iLTCO/uw4M1Ylg2jcMVxqfgJjKpsiaTSmU2EXGA=;
        b=wy2pYM7/l9LVr/Kj/xr+JGccjxi531/qwzBN8gDie/3P+aVG9lojJ5PgzFyB/LQ9ht
         ag09O9ml/ln9TRdcOttzq1K1wpKLwysjV69slmkgJWOGR0gjCTL6V4J8D7p739Ik4wdP
         hxtg91fVmCfNmU9A0KT9lxrNa7pa4syDdOJaEDnccma15ecns/9y84eeSUX4xYD8wk3c
         BiIAKyY/XH/dia6Mlqa5Mk/V67t8Zaz1GJLeajgSYGiQg2pFdrBbGLHkekX0tUIMzhCk
         EqTCgVb259K8EMK5z59UP/j8XHU5+WF7uGGSQoAxjxtN8AnJCSOSyIH7KPucmmlSKoq0
         NoBQ==
X-Gm-Message-State: ANoB5plu9DbClCHfJRNtktnxSzlN1zHQiQDWSlxkaQ8lmbjmLFo2d7TH
	eIQdJdxV4j4M2f1WLsGupE1WnQ==
X-Google-Smtp-Source: AA0mqf6eCv+InVfKA4sHLrootqXhgKbPCqZwr/BHpgt/6iwDstlRrCS04XbrZWyIdohBA+R6Gq2t/Q==
X-Received: by 2002:ac8:5892:0:b0:3a5:3d08:9fdd with SMTP id t18-20020ac85892000000b003a53d089fddmr82236079qta.684.1670354143281;
        Tue, 06 Dec 2022 11:15:43 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-122-23.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.122.23])
        by smtp.gmail.com with ESMTPSA id y14-20020a37f60e000000b006fbaf9c1b70sm14752500qkj.133.2022.12.06.11.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 11:15:42 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1p2dPp-004gjs-T7;
	Tue, 06 Dec 2022 15:15:41 -0400
Date: Tue, 6 Dec 2022 15:15:41 -0400
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
Message-ID: <Y4+U3VR2LeEh2S7B@ziepe.ca>
References: <20221206055816.292304-1-lei.rao@intel.com>
 <20221206055816.292304-2-lei.rao@intel.com>
 <20221206061940.GA6595@lst.de>
 <Y49HKHP9NrId39iH@ziepe.ca>
 <20221206135810.GA27689@lst.de>
 <Y49eObpI7QoSnugu@ziepe.ca>
 <20221206153811.GB2266@lst.de>
 <Y49k++D3i8DfLOLL@ziepe.ca>
 <20221206165503.GA8677@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206165503.GA8677@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221206_111546_900124_3D02C15F 
X-CRM114-Status: GOOD (  24.27  )
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

On Tue, Dec 06, 2022 at 05:55:03PM +0100, Christoph Hellwig wrote:
> On Tue, Dec 06, 2022 at 11:51:23AM -0400, Jason Gunthorpe wrote:
> > That is a big deviation from where VFIO is right now, the controlled
> > function is the one with the VFIO driver, it should be the one that
> > drives the migration uAPI components.
> 
> Well, that is one way to see it, but I think the more natural
> way to deal with it is to drive everyting from the controlling
> function, because that is by definition much more in control.

Sure, the controlling function should (and does in mlx5) drive
everything here.

What the kernel is doing is providing the abstraction to link the
controlling function to the VFIO device in a general way.

We don't want to just punt this problem to user space and say 'good
luck finding the right cdev for migration control'. If the kernel
struggles to link them then userspace will not fare better on its own.

Especially, we do not want every VFIO device to have its own crazy way
for userspace to link the controlling/controlled functions
together. This is something the kernel has to abstract away.

So, IMHO, we must assume the kernel is aware of the relationship,
whatever algorithm it uses to become aware.

It just means the issue is doing the necessary cross-subsystem
locking.

That combined with the fact they really are two halfs of the same
thing - operations on the controlling function have to be sequenced
with operations on the VFIO device - makes me prefer the single uAPI.

> More importantly any sane design will have easy ways to list and
> manipulate all the controlled functions from the controlling
> functions, while getting from the controlled function to the
> controlling one is extremely awkward, as anything that can be
> used for that is by definition and information leak.  

We have spend some time looking at this for mlx5. It is a hard
problem. The VFIO driver cannot operate the device, eg it cannot do
MMIO and things, so it is limited to items in the PCI config space to
figure out the device identity.

> It seems mlx5 just gets away with that by saying controlled
> functions are always VFs, and the controlling function is a PF, but
> that will break down very easily, 

Yes, that is part of the current mlx5 model. It is not inherent to the
device design, but the problems with arbitary nesting were hard enough
they were not tackled at this point.

Jason

