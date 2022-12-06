Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 156BEC352A1
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Dec 2022 14:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0kqoRf+XjnNXwhswsLJCrkOPC8aiO2DP0YqepNTsM5Q=; b=AKvd10fdS8PqhUdVpIoC6aRGOW
	pp0MI4p/spsfPfJ5XM8PkG6v9EaEL9uWGJqSsuRoJhNRwviYpx1PyWdpBOUAXuubppdRseuHOwwdK
	Wk1gd98u3ASucHHSGV6hC0qVTJaZrbrjqAyVTXXUTcn23LjnvwUC1sqDQphCFVDDL8akV/1F6GvN0
	2Il4WTc8VgfWAoxMDSByc0h316aycx5KDREsjEfmikd5xbk/IXrKDpwRRyAFUSTrPKNNP2olIanKS
	kaFHsYlhQcdGiVxHbCoWyonAivdjVA1aeZz/pt6C87Wah2HFMZK9GAUTDVeKtdC7aBfNVWop8kR1C
	ZF6saDrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2YoE-00ATzi-BV; Tue, 06 Dec 2022 14:20:34 +0000
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2YoA-00ATwx-LR
	for linux-nvme@lists.infradead.org; Tue, 06 Dec 2022 14:20:32 +0000
Received: by mail-pj1-x102d.google.com with SMTP id cm20so14576165pjb.1
        for <linux-nvme@lists.infradead.org>; Tue, 06 Dec 2022 06:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0kqoRf+XjnNXwhswsLJCrkOPC8aiO2DP0YqepNTsM5Q=;
        b=PoQVjmSy5xTwYFliGZR9OOSDBYM5gBvnpPzZAXulgAt+dJ3Yv8FA4gQGPA91tTC39N
         LGXjgSMxpNAMzBSzlnp2xg1KYYV/JyCxcLAYFBX2GZBMB0c6RiEu0J9jayvnlM8zlPWG
         TdNJ79c/8kWJX+0OpcsbH1BvWcP0DQJsxGigdO6dHgXKsTvh4pKLxnIP4dNArwZavnr0
         HBz6rREOxYExVSGE1TnP+BVjoIYmJJDAMTGM+K96jzrzY+42XewZ26j/jzggHCY5vxlf
         6X+Jvmcwo02YE8V2CwVpCFdPv6KPxJ0YwyCtTTBQptMnF+3oJt9+Bpi5mqqdqf2hToqR
         FWGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0kqoRf+XjnNXwhswsLJCrkOPC8aiO2DP0YqepNTsM5Q=;
        b=d1Lwv/icTaoimPq7Nb8teebFOHJ1K1w0osq6R4CG1sWVZvCvR18C9QtOOFVI7imQd5
         oI7AesOILWMojpttpB7o2nw3PrKOWugZE11VkKEiJLhUhwAoY1tBu0cuZ+11lCCcwPgw
         ZmacHOkmW3rwyXzkeFm0S3VHGgFR3XRXc13uXdgm3DLTZy6HgP7ClfWpkf/5ewqo9Zxc
         IU4pzc1z4ipa2AXKBnew/Us47xL0gtt1mbXms5lmfN9J64LeD+PsmLFIQ2gO0i9PLHHx
         JnXrR9btfuuUUwuyECDe1rM/DQByIxeXu/5lJTMf8qZQ9IVc/ZPEKZVTZU86Y+CPUxdB
         AlvA==
X-Gm-Message-State: ANoB5pk/j4ldgwG95ONGC5cncCssCcv2w/1ogTEBlDBFTd8X9ZmUQyYg
	kkQJiMg2E7gbr+LfijXr5kwsbw==
X-Google-Smtp-Source: AA0mqf5gHYWwo38iLmYp9F1iuP/OVjscdmaIJjaPvl1VQQ29+QjauKFugs2/SKKCFzZz6Vg4bd1Tjw==
X-Received: by 2002:a17:902:b184:b0:189:1d01:a4ae with SMTP id s4-20020a170902b18400b001891d01a4aemr71127865plr.93.1670336428643;
        Tue, 06 Dec 2022 06:20:28 -0800 (PST)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id 17-20020a170902e9d100b0018997f6fc88sm12648048plk.34.2022.12.06.06.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 06:20:27 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1p2Yo6-004c0g-KS;
	Tue, 06 Dec 2022 10:20:26 -0400
Date: Tue, 6 Dec 2022 10:20:26 -0400
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
Message-ID: <Y49PqoAhZOeraLVa@ziepe.ca>
References: <20221206055816.292304-1-lei.rao@intel.com>
 <20221206055816.292304-6-lei.rao@intel.com>
 <20221206062604.GB6595@lst.de>
 <Y48+AaG5rSCviIhl@ziepe.ca>
 <20221206130901.GB24358@lst.de>
 <Y49JNvdmRPNWw26q@ziepe.ca>
 <20221206140002.GB27689@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206140002.GB27689@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221206_062030_940700_31A8BE41 
X-CRM114-Status: GOOD (  17.34  )
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

On Tue, Dec 06, 2022 at 03:00:02PM +0100, Christoph Hellwig wrote:
> > >From what I understood this series basically allows two Intel devices
> > to pass a big opaque blob of data. Intel didn't document what is in
> > that blob, so I assume it captures everything you mention above.
> 
> Which would be just as bad, because it then changes the IDs under
> the live OS on a restore.  This is not something that can be done
> behind the back of the hypervisors / control plane OS.

Sorry, what live OS?

In the VFIO restore model there is no "live OS" on resume. The
load/resume cycle is as destructive as reset to the vfio device.

When qemu operates vfio the destination CPU will not be running until
the load/resume of all the VFIO devices is completed.

So from the VM perspective it sees a complete no change, so long as
the data blob causes the destination vfio device to fully match the
source, including all IDs, etc.

Jason

