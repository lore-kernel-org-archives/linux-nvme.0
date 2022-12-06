Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13359C4708E
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Dec 2022 14:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6Mdjw8teEuS8fu1LzdE03VCDBBE/nyDuXFgC+OWm78E=; b=eLJpbc4wPkW0mhA3PCJOdqgAbt
	pDK5EpcqP6J3zSRb/mf6ZN+A6Z6zw7QGwVkE1plyrF1Ll+Wbi/FVNYuplHlF5JyAsujASfQ1Eo+29
	ry9o0uEneVKXMLYSc5iRG2gVPUw67YT9qkerp08hIGll4PQqK0TgGMU9I6yoIkr5ptvS6gowwCEyA
	fatbdI8O4UlStiz121rYEf0wwtkterWHiWhNEDLe9zn2IVWqhsVROelpQHXdeFrmrg+dK7k5YUP+4
	8F0+gGHjU5XhOP47sGvo95hw0HstziAQB6AmyKjVOIRsnLPnpDRyuh3/Lq6KmiDe15gk5oSUEDPsl
	5FqjBJ8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2Yud-00AhqQ-Sf; Tue, 06 Dec 2022 14:27:11 +0000
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2Yub-00AhoM-Ok
	for linux-nvme@lists.infradead.org; Tue, 06 Dec 2022 14:27:11 +0000
Received: by mail-pj1-x1030.google.com with SMTP id k88-20020a17090a4ce100b00219d0b857bcso6314114pjh.1
        for <linux-nvme@lists.infradead.org>; Tue, 06 Dec 2022 06:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6Mdjw8teEuS8fu1LzdE03VCDBBE/nyDuXFgC+OWm78E=;
        b=JTrqxIKbISVas3nmVgciA/jFgtsvHbGds9y9TE+NeJDiSpP6+RfmKxfgtL0v0hVlhx
         Xt+JIhTdyVpZq/qBAkgyvyud2u6wCPMjw+bwqYEUXXzPteMf6wDSZpfj9PyGoZj8hpJo
         Ri6AC6357268HQeq5Ar2oWAJ8mMTmSqto4tssZvSPA85TofMwONCiCV/2FSVtO/72cCv
         B4gSYLk2107+aX7tn9bgF8waU10Ev4Dh6UupBGr2l5q2PSQNBAxCwG0vfqH7hsXiBnRs
         NZq3Tu7/kQ/vmrMQG0RXz7KdWbYOd3Td/2yrZmGPyhtywi+LAcIvwY+AnNrKY7dnLH/6
         eJpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Mdjw8teEuS8fu1LzdE03VCDBBE/nyDuXFgC+OWm78E=;
        b=TbkDR0pfTML0CBHY2gteCI2+cRfbJIf3FjKpqVoC/oN5BhT94qZNTVlf/hEqpUP4yb
         VAVkpsLgXv6YMpLOwH+V0YCx9M53aYBeW55F2xDK/gmLdG6iX/aKx4v+VIy+ap6QIz3z
         QmqIrcxGa80SyUPOpsXbh2HetGjfaEYCBfnNxPHxnVIqBTtFxH3hgxMPFlRC4q0bsgND
         8JQS3dA3bMj6XYejmqNfFOf6DdYjDgxnyHtuIdDQl6QjVw6MZUcRY+a8T0cQvLY+84UU
         Ciipv21mZN8RPmDeEQFgfZEX/razD7xSKsZrt8bche3BXm+FHNN9WIRVmJNKcXT2PU+l
         dqQw==
X-Gm-Message-State: ANoB5plMbQMQ5g9sytqu5XX5uIW42HXdJ9rYhM1J2cUbfDDllCTVxFdf
	gKRt0zUEfvPfT/2crCsH3Hsmow==
X-Google-Smtp-Source: AA0mqf4onWTUgiJ4pOlfZR6yKmpmp9+evnjGR22ptDTfxs3rCfyKWJ8/Zxj8Atiyy/h4dPtnxckbDA==
X-Received: by 2002:a17:90b:4d84:b0:212:9b3f:dee5 with SMTP id oj4-20020a17090b4d8400b002129b3fdee5mr99097552pjb.62.1670336829049;
        Tue, 06 Dec 2022 06:27:09 -0800 (PST)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id n6-20020a170902d2c600b0017c19d7c89bsm12695526plc.269.2022.12.06.06.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 06:27:08 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1p2YuY-004c5n-RN;
	Tue, 06 Dec 2022 10:27:06 -0400
Date: Tue, 6 Dec 2022 10:27:06 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Lei Rao <lei.rao@intel.com>,
	axboe@fb.com, kch@nvidia.com, sagi@grimberg.me,
	alex.williamson@redhat.com, cohuck@redhat.com, yishaih@nvidia.com,
	shameerali.kolothum.thodi@huawei.com, kevin.tian@intel.com,
	mjrosato@linux.ibm.com, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, kvm@vger.kernel.org,
	eddie.dong@intel.com, yadong.li@intel.com, yi.l.liu@intel.com,
	Konrad.wilk@oracle.com, stephen@eideticom.com, hang.yuan@intel.com
Subject: Re: [RFC PATCH 1/5] nvme-pci: add function nvme_submit_vf_cmd to
 issue admin commands for VF driver.
Message-ID: <Y49ROloD4qWzjqnz@ziepe.ca>
References: <20221206055816.292304-1-lei.rao@intel.com>
 <20221206055816.292304-2-lei.rao@intel.com>
 <20221206061940.GA6595@lst.de>
 <Y49HKHP9NrId39iH@ziepe.ca>
 <Y49I5MRsgHdNkIff@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y49I5MRsgHdNkIff@kbusch-mbp>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221206_062709_827852_7AE4A016 
X-CRM114-Status: GOOD (  23.96  )
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

On Tue, Dec 06, 2022 at 01:51:32PM +0000, Keith Busch wrote:
> On Tue, Dec 06, 2022 at 09:44:08AM -0400, Jason Gunthorpe wrote:
> > On Tue, Dec 06, 2022 at 07:19:40AM +0100, Christoph Hellwig wrote:
> > > On Tue, Dec 06, 2022 at 01:58:12PM +0800, Lei Rao wrote:
> > > > The new function nvme_submit_vf_cmd() helps the host VF driver to issue
> > > > VF admin commands. It's helpful in some cases that the host NVMe driver
> > > > does not control VF's admin queue. For example, in the virtualization
> > > > device pass-through case, the VF controller's admin queue is governed
> > > > by the Guest NVMe driver. Host VF driver relies on PF device's admin
> > > > queue to control VF devices like vendor-specific live migration commands.
> > > 
> > > WTF are you even smoking when you think this would be acceptable?
> > 
> > Not speaking to NVMe - but this driver is clearly copying mlx5's live
> > migration driver, almost completely - including this basic function.
> > 
> > So, to explain why mlx5 works this way..
> > 
> > The VFIO approach is to fully assign an entire VF to the guest OS. The
> > entire VF assignment means every MMIO register *and all the DMA* of
> > the VF is owned by the guest operating system.
> > 
> > mlx5 needs to transfer hundreds of megabytes to gigabytes of in-device
> > state to perform a migration.
> 
> For storage, though, you can't just transfer the controller state. You have to
> transfer all the namespace user data, too. So potentially many terabytes?

There are two different scenarios - lets call it shared medium and
local medium.

If the medium is shared then only the controller state needs to be
transfered. The controller state would include enough information to
locate and identify the shared medium.

This would apply to cases like DPU/smart NIC, multi-port physical
drives, etc.

local medium will require the medium copy. Within Linux I don't have a
clear sense if that should be done within the VFIO migration
framework, or if it would better to have its own operations.

For the NVMe spec I'd strongly suggest keeping medium copy as its own
set of commands.

It will be interesting to see how to standardize all these scenarios :)

Jason

