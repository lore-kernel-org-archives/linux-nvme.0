Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E780BC4708C
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Dec 2022 14:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E3b5bdWA85OzMOTjNeR+xYtDEAbTCZli0u3K40D9kx4=; b=e9k+PiPYzZQoN3km6ojAYN8MRH
	SdEoQ4QhHSlTM0V0jN73I3y8O4A1W7IA61vXXTjBxlu/qAgH3RCbTDHoWvAq4+KUpmUI0UFN7N8uk
	OMBueg46CJnfrDkQ8AFOHOPs6ltnEJXgTJsPIhcrjV35oC5qVQncOkjE9qJfWqB4ErEFkBTz6Sx3S
	R/LvWqrPMpHT4Bd5ScdfWiJNySY9PAgAcf7kHbyk4diEnFwlJqVBEdAN7/Dsz+LhzqhHK6Py9Ittx
	utDWpOh5z+dIWB6lm7KBJ8aSDuj8QMrXxspoJs+JnrIHQH9epPsC6yCh9nGSMDRA/5vCsVPwArAHH
	VSJSbXZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2ZFR-00Bh9u-Ex; Tue, 06 Dec 2022 14:48:41 +0000
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2ZFD-00Bgvq-V9
	for linux-nvme@lists.infradead.org; Tue, 06 Dec 2022 14:48:29 +0000
Received: by mail-pf1-x435.google.com with SMTP id c7so11341730pfc.12
        for <linux-nvme@lists.infradead.org>; Tue, 06 Dec 2022 06:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E3b5bdWA85OzMOTjNeR+xYtDEAbTCZli0u3K40D9kx4=;
        b=OFUOd4PNQR8bRxCK6qegIBSYa3MK8J/1a32WRukCTxAY5fTbE+omxk8YDjbYTugGMt
         YeXjCnUiKvlBk7edXLLva1LG+EYEPJj21wfIj1MmX7CR4SOWyOYUEzYSPs05BYdfhIq5
         z1IaXMgmuZsbEAXA7r01df8vhuih3NfsWItIHWKZi0n6rXD8IocqnRosa8UqEyN/8mVL
         i6iXH2dMdNFy5yDeIFaIvU+1FfeV0PfX9RbViXvdq9awFDH4LYyYXr/zLukIzNQ2rY4g
         WSup0IALJEblLWRnTR/3BL3KE6NdkyZhPvl0lshlmlVISJYUUF2mgQiKaTs/T2Pmpe+Y
         t8FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E3b5bdWA85OzMOTjNeR+xYtDEAbTCZli0u3K40D9kx4=;
        b=FTMzzOkRBQXSEJgNdDo5g0+tFK05A01Cxmz7JQCPTawVua1mZeEekETBaxxvTTv8lz
         wPFkDA0skeNvsYmZhPP7r7mBNkNgFl6i5NefEjedpW+S6GHPx/9bQqcNXi/necqa08VK
         jtV3SaF2xGrE7bgX4y2uFuhSfi+lBPIi1kjoGBo7VFL++//ELYGD7yJNBEjio0XIowYI
         YrjLfKh1afYX/6Zd061DyJJ7xWHSbtVu2r6Gp/OfLL08Lrm3RSgK4q6oQxXmyeb1N1Zn
         X0N9AJK/rUoVufBbISsE212AH6HpgQhIzvFRBIR5UVMtC301Joo71mVNPhBtZkXrd2F9
         AZJw==
X-Gm-Message-State: ANoB5pkS6/INMMoWlWhiuivgD7y9Zs8vDO8/RWOZDfcyvVS2ktUniE/D
	61Oqp/a4oCj0LHB5b+cdioNqIQ==
X-Google-Smtp-Source: AA0mqf6wZNYJR+nxEDntmIwoB1WTx5lMm+/0X87R2SrkgFXKtucbmHuGQYhQGln4hWgCmve4UUXs+g==
X-Received: by 2002:a63:105c:0:b0:46f:f72c:cdae with SMTP id 28-20020a63105c000000b0046ff72ccdaemr62687659pgq.237.1670338104328;
        Tue, 06 Dec 2022 06:48:24 -0800 (PST)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id u2-20020a170902e5c200b00186c5e8a8d7sm12785747plf.171.2022.12.06.06.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 06:48:23 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1p2ZF8-004cPA-AK;
	Tue, 06 Dec 2022 10:48:22 -0400
Date: Tue, 6 Dec 2022 10:48:22 -0400
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
Message-ID: <Y49WNo7XWZ2aFfds@ziepe.ca>
References: <20221206055816.292304-1-lei.rao@intel.com>
 <20221206055816.292304-6-lei.rao@intel.com>
 <20221206062604.GB6595@lst.de>
 <Y48+AaG5rSCviIhl@ziepe.ca>
 <20221206130901.GB24358@lst.de>
 <Y49JNvdmRPNWw26q@ziepe.ca>
 <20221206140002.GB27689@lst.de>
 <Y49PqoAhZOeraLVa@ziepe.ca>
 <20221206143126.GB30297@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206143126.GB30297@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221206_064828_055847_53BE3935 
X-CRM114-Status: GOOD (  20.48  )
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

On Tue, Dec 06, 2022 at 03:31:26PM +0100, Christoph Hellwig wrote:
> On Tue, Dec 06, 2022 at 10:20:26AM -0400, Jason Gunthorpe wrote:
> > In the VFIO restore model there is no "live OS" on resume. The
> > load/resume cycle is as destructive as reset to the vfio device.
> 
> Of course there may be and OS.  As soon as the VF is live Linux
> will by default bind to it.  And that's the big problem here,
> the VF should not actually exist or at least not be usable when
> such a restore happens - or to say it in NVMe terms, the Secondary
> Controller better be in offline state when state is loaded into it.

Sadly in Linux we don't have a SRIOV VF lifecycle model that is any
use.

What we do have is a transfer of control from the normal OS driver (eg
nvme) to the VFIO driver. Also, remember, that VFIO only does live
migration between VFIO devices. We cannot use live migration and end
up with a situation where the normal nvme driver is controlling the
VF.

The VFIO load model is explicitly destructive. We replace the current
VF with the loading VF. Both the VFIO variant driver and the VFIO
userspace issuing the load have to be aware of this and understand
that the whole device will change.

From an implementation perspective, I would expect the nvme varient
driver to either place the nvme device in the correct state during
load, or refuse to execute load if it is in the wrong state.

To be compatible with what qemu is doing the "right state" should be
entered by completing function level reset of the VF.

The Linux/qemu parts are still being finalized, so if you see
something that could be changed to better match nvme it would be a
great time to understand that.

Jason

