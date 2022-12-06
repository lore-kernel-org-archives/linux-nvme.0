Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B371BC352A1
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Dec 2022 13:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zsirKpdP0CfKhoTgNVDEM5IiWovPwvVngaB5BGDoZKs=; b=4Y8f2K0EELUzC2YOSbnvVvF8is
	7ukx9SczxuF0ihC1BcamOde4kifnhLtCEL52eQXHBmynQQBETC09vhlzqsc16tNWZImRkWk/hU5le
	ZYNJrBolwaElxgItXv8l3hGPTpeIGmQAJemFeN8Fi0kst4pOMftZe1HLxUwRI2nzFNBycX53mbdPA
	fSNTkgCpvFhoPaGmHfJ4/Tg3DlDXwuOxFZJUuykwaBc5KVyM0WlGWypQ/etLq8NVrBDEfT0bgwZ93
	HbBfsuF0K8XmsQmiY7gP0zy8IEysRDgokbFhT+6T/EVAv28svrFSStPQbaVUGRXZZKrm2F4AsNqbM
	Lio1HAzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2XdO-009VbP-Fn; Tue, 06 Dec 2022 13:05:18 +0000
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2XdF-009VW3-PS
	for linux-nvme@lists.infradead.org; Tue, 06 Dec 2022 13:05:11 +0000
Received: by mail-pl1-x629.google.com with SMTP id jl24so13829235plb.8
        for <linux-nvme@lists.infradead.org>; Tue, 06 Dec 2022 05:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zsirKpdP0CfKhoTgNVDEM5IiWovPwvVngaB5BGDoZKs=;
        b=IAnD9feziYzBDgH1vGA42RRh++QMPgElSoKUznefAOBu9T3PXWYquBguGryhoChzGU
         v4Lar+22f9uVJ0gD5vNYOsj7hSddLV6fF0C4jtmnhRcMiN5Be0NOIlOel2eytI4om9ii
         a67BNM6uqOjXVj+hCDI5eGPMCFBo82SecZ2GXlTvXd4DejBOuQPNlbJ+Hhb1sX5Cx5yP
         aM9Lw+2xXWYKXol7LmNlMvvNew1Y5y0tKhaTQcdndNCtylOEfqfkcYlWUoSEHfVk2Y14
         XL3mxcRF+MiF+rdDQFZT6nhQCxZETmhOt9JupdXPSYelXmBXqqm2LL54ECcvtuDKjPGS
         4qOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zsirKpdP0CfKhoTgNVDEM5IiWovPwvVngaB5BGDoZKs=;
        b=vZ0YxwAavTIrQfHRRNVQR+1cWl7bJ/UqXuEg64GVGc3Ob902NAeMYK/INsnkhmKumH
         kD3/vAMa4jefmXx6nQiCFarkgWJ1KJB+oscmES2kqsaQ4bDJ2sPlHPul172BAd7XnzsM
         wqCc6eJg8iyQc29KmIMbOMGJjgIKANhxVn+7OOiZ1znT76Z01c2Hxv1VNEc//BU68sWR
         ZBvf+01HiWaGGcVS+B+fiuVAhAIE+ecdtctHkhFwbtd2WJRwmR7BhymVcXuTt29YgX07
         O+HkffxaMO+kl8Ieb2Vt0L07YuMyCGDKF/MV40iE21N2cjfP0R1ywYhgkHVmiZTB9Mxt
         jGCA==
X-Gm-Message-State: ANoB5plEPPwM9encSEU9fH39QHlO2rZ2e/JZNfZkJoS2aSwa19HkmxcR
	c+AQEWw/id8Nthkg7UOfxi7wCw==
X-Google-Smtp-Source: AA0mqf4uiCr4rEXdMlHinSQYsz6GcoLqrKx0r6b8L4mWTRaRwDt/z11/nLxpi39beGa9Sv0DQXmnNQ==
X-Received: by 2002:a17:902:9881:b0:188:62b8:2278 with SMTP id s1-20020a170902988100b0018862b82278mr75419515plp.96.1670331907871;
        Tue, 06 Dec 2022 05:05:07 -0800 (PST)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id p7-20020a170902780700b00174c1855cd9sm12461140pll.267.2022.12.06.05.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 05:05:07 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1p2XdB-004arD-HJ;
	Tue, 06 Dec 2022 09:05:05 -0400
Date: Tue, 6 Dec 2022 09:05:05 -0400
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
Message-ID: <Y48+AaG5rSCviIhl@ziepe.ca>
References: <20221206055816.292304-1-lei.rao@intel.com>
 <20221206055816.292304-6-lei.rao@intel.com>
 <20221206062604.GB6595@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206062604.GB6595@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221206_050510_186773_44EC8E87 
X-CRM114-Status: GOOD (  18.57  )
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

On Tue, Dec 06, 2022 at 07:26:04AM +0100, Christoph Hellwig wrote:
> all here).  In Linux the equivalent would be to implement a mdev driver
> that allows passing through the I/O qeues to a guest, but it might

Definately not - "mdev" drivers should be avoided as much as possible.

In this case Intel has a real PCI SRIOV VF to expose to the guest,
with a full VF RID. The proper VFIO abstraction is the variant PCI
driver as this series does. We want to use the variant PCI drivers
because they properly encapsulate all the PCI behaviors (MSI, config
space, regions, reset, etc) without requiring re-implementation of this
in mdev drivers.

mdev drivers should only be considered if a real PCI VF is not
available - eg because the device is doing "SIOV" or something.

We have several migration drivers in VFIO now following this general
pattern, from what I can see they have done it broadly properly from a
VFIO perspective.

> be a better idea to handle the device model emulation entirely in
> Qemu (or other userspace device models) and just find a way to expose
> enough of the I/O queues to userspace.

This is much closer to the VDPA model which is basically providing a
some kernel support to access the IO queue and a lot of SW in qemu to
generate the PCI device in the VM.

The approach has positives and negatives, we have done both in mlx5
devices and we have a preference toward the VFIO model. VPDA
specifically is very big and complicated compared to the VFIO
approach.

Overall having fully functional PCI SRIOV VF's available lets more
uses cases work than just "qemu to create a VM". qemu can always build
a VDPA like thing by using VFIO and VFIO live migration to shift
control of the device between qemu and HW.

I don't think we know enough about this space at the moment to fix a
specification to one path or the other, so I hope the TPAR will settle
on something that can support both models in SW and people can try
things out.

Jason

