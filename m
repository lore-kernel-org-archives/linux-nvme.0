Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B2C2C352A1
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Dec 2022 13:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t87VCeTJakslqAl3f0yNOxHf0LTh2ZN124YXucQTICI=; b=ZX7rDC8gGnctr7ki1lmxXVTd5q
	sI2T0EvCIppSaPpI5U+TFJSMSZYEhp2xPyEXxUml3H8vodWmlGVHr6Yfdp2kXwRMtjsG06EeBCZqO
	Qs4YsKYYjG/IrI4ldi5c+FttlQZS4GswcjzkBrwq+urt44aqZCbdmBS2etaUeyueQYOQc42A112Sc
	fO61noOQJtgCs9Q3/AwLffwsi9hVGpq55o3tQw+VUyo96Ulnb2r5bXyzml2siYf5mqXKiG4eYDL7Y
	2xW2k4XVxQfCKHZL3VOwx/IlNasrvZqOHuS7W2TdoW7g1eL2iU1sHp4ETaXBUQoEjcVZJRAMqQPCE
	TqJgw43A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2YNh-00A0L6-Nj; Tue, 06 Dec 2022 13:53:09 +0000
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2YNf-009zsl-2f
	for linux-nvme@lists.infradead.org; Tue, 06 Dec 2022 13:53:08 +0000
Received: by mail-pl1-x62a.google.com with SMTP id y17so13968870plp.3
        for <linux-nvme@lists.infradead.org>; Tue, 06 Dec 2022 05:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t87VCeTJakslqAl3f0yNOxHf0LTh2ZN124YXucQTICI=;
        b=oZGCxyk5W3TMdU2o6vRqmJnJcYsYsbgQZVSOM118UHdICsH3wPjWdG68J6fsdeUwJJ
         LZjdlixk2hY+1rJAdlL5ClWxqqWJXOGkHw3uofhd5LW64YmHG0gTJHdph0anX+bb/9My
         jiDJujt3G7mvNF1/Fx9hDpNb6NDreKAF66YocfaiFEXNsIGJlveHzNomXypy1L28wwa2
         vgrb7StUm5lVgdw01n/1Sd3qqNYmdgviT+hKhkTj38U16G3HVYESw6VZgHmfCwwdeoXU
         BYxTR7YpicHMjA5z7L+fboO2DZA51Ze4QnenI7roy3++oRxN1gnjVynwB/LUaBTpYfEu
         /gpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t87VCeTJakslqAl3f0yNOxHf0LTh2ZN124YXucQTICI=;
        b=ql7tQQ4qgljybnUWjZRs3JhdYYkroiq4mIPb3xJ1TXVTw2nr97ViMOlbqFwA0MkvHi
         mzOjTK/QuPX9kaQMSs4OfHfC+2p1vBx42rkD49Tgv+aQJVO2ypcw1RSRG0sImxsJDU39
         qyl28KvBLPJCQXoim9QA2V3vmzFaMuBlSq0InpMYxSMRDDCzSTXoC6XBAmxSfBda9Ltj
         ENAEYIRIhPp46bS1TT28seXdDSEFHwKA0rAjJEeYCgIaDFECAZ9bAAz4as+FetU4neaT
         DQ9/UnIV8N13f5IMClsno3UyEkFkGv1cjMi6MGmSOcLktazCN/QVZQ8W41j7rJ/2vtWX
         fepg==
X-Gm-Message-State: ANoB5pni7s2EZLnhXMtdKIXi/PSricBSGjZrp/jCy7derdObByQkiPPH
	h23p7Hg0XiLLgKexSeSyCjF4qg==
X-Google-Smtp-Source: AA0mqf482EjTSHDI4493LMS4boQvscR6VQMN38fEM7NnhASxT/N8ZFwDvLrAcycEwor9hfBksmUO8Q==
X-Received: by 2002:a17:90a:5998:b0:219:d33d:4689 with SMTP id l24-20020a17090a599800b00219d33d4689mr10666134pji.233.1670334775910;
        Tue, 06 Dec 2022 05:52:55 -0800 (PST)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id b16-20020aa79510000000b00574f83c5d51sm11772416pfp.198.2022.12.06.05.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 05:52:55 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1p2YNS-004bct-0n;
	Tue, 06 Dec 2022 09:52:54 -0400
Date: Tue, 6 Dec 2022 09:52:54 -0400
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
Subject: Re: [RFC PATCH 5/5] nvme-vfio: Add a document for the NVMe device
Message-ID: <Y49JNvdmRPNWw26q@ziepe.ca>
References: <20221206055816.292304-1-lei.rao@intel.com>
 <20221206055816.292304-6-lei.rao@intel.com>
 <20221206062604.GB6595@lst.de>
 <Y48+AaG5rSCviIhl@ziepe.ca>
 <20221206130901.GB24358@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206130901.GB24358@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221206_055307_157062_C6C49E77 
X-CRM114-Status: GOOD (  19.13  )
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

On Tue, Dec 06, 2022 at 02:09:01PM +0100, Christoph Hellwig wrote:
> On Tue, Dec 06, 2022 at 09:05:05AM -0400, Jason Gunthorpe wrote:
> > In this case Intel has a real PCI SRIOV VF to expose to the guest,
> > with a full VF RID.
> 
> RID?

"Requester ID" - PCI SIG term that in Linux basically means you get to
assign an iommu_domain to the vfio device.

Compared to a mdev where many vfio devices will share the same RID and
cannot have iommu_domain's without using PASID.

> > The proper VFIO abstraction is the variant PCI
> > driver as this series does. We want to use the variant PCI drivers
> > because they properly encapsulate all the PCI behaviors (MSI, config
> > space, regions, reset, etc) without requiring re-implementation of this
> > in mdev drivers.
> 
> I don't think the code in this series has any chance of actually
> working.  There is a lot of state associated with a NVMe subsystem,
> controller and namespace, such as the serial number, subsystem NQN,
> namespace uniqueue identifiers, Get/Set features state, pending AENs,
> log page content.  Just migrating from one device to another without
> capturing all this has no chance of actually working.

From what I understood this series basically allows two Intel devices
to pass a big opaque blob of data. Intel didn't document what is in
that blob, so I assume it captures everything you mention above.

At least, that is the approach we have taken with mlx5. Every single
bit of device state is serialized into the blob and when the device
resumes it is indistinguishable from the original. Otherwise it is a
bug.

Jason

