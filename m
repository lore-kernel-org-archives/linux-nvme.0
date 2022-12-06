Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98599C352A1
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Dec 2022 15:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UbvbC5wWAbTk1+A45QMi3yV7gKIuXUVlv7TRLX6QDzQ=; b=36Q2Fzo1FtLbT14lxPmVCTDo+G
	OLnisfoYNz1kvp9QWET/vmbS+Rd337gbHIvqRSpvz7muo0vjmnqh9oLzxzTZk1hvLFP4fr+XT1qLk
	PGwpXafVWYjvjQIh5SpqxwIWHE22CkE7V+7guAeteMaeCmhyey6dGqhTmTCe2PnrYZSAFA5g1IeMI
	fMgsg7yo9fa/rbOu2V2mqQ95ZaddohFTgQ9cBOvUoiMPYnE9MkagsuvPTsCA3pvY4W1lDMK1cWMcz
	EIB2MDNF2Wq5aX9G8tJStKFwSZEV0vR14nl1RsM4/xUkPfOkdLO+VNheinPepqYtQ0s6qQqFXWDOR
	A1AUx0Zg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2Zro-00CPnJ-E6; Tue, 06 Dec 2022 15:28:20 +0000
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2Zrl-00CPgs-T8
	for linux-nvme@lists.infradead.org; Tue, 06 Dec 2022 15:28:19 +0000
Received: by mail-pg1-x52a.google.com with SMTP id 136so13687606pga.1
        for <linux-nvme@lists.infradead.org>; Tue, 06 Dec 2022 07:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UbvbC5wWAbTk1+A45QMi3yV7gKIuXUVlv7TRLX6QDzQ=;
        b=o2pfBKad+xs/gHyi3mDpxXl3Ejx08rQwd7nDOZGu8tih+03yTLG9XNmst/u1NsCpd2
         kyGJtZ5d7CWoKzweigchYufl1D8gierL43WqERJwGSSQeRHqmRZWusQ6eSD0wl6ytQAR
         PFhlOF+Zravyw5C5LhmVc6V5UXDs6Ieixn7Z71yBPjdl7i+Rhqodee7VZzSZxM6gbJ+M
         mUv+e7BMb1dEYVIavlac4VR+uJPX1dz2MgumEnsBWeA5UZ3V9ne5rWYEA66kFu8C1QG1
         JYeIna0Nvi7bBdxHdo5P39G0mu/SsSFQ/pA0afbIWx+7D7CDy0/xKN1Q9huuXlirg552
         jxng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UbvbC5wWAbTk1+A45QMi3yV7gKIuXUVlv7TRLX6QDzQ=;
        b=2cj2JDKtGzFpZHRnprpBuS9K/wlo+94l61tE59Cz8qh/+eTmRQSHXPPMAafyGhrdVx
         rVOXzBDvWZqCKYAJwGqhf49szcRk5Txf3VYuzV8fiRWIHl1zjLoWDu1B9GrIU7Lfk5Jj
         gX4wj6wMGViJeFKFYKb7yTlz3m5RC9oRHQuy9dU2mE0E5bxFw/XIkr/UhHYPMBvNwLP0
         55MaLppiT8KjrDn3KXdMv2wR8AjtL2txQLH6WCYCkttvt3+ann015kdfwJ7aGtgBJq6G
         4t+yLNJK1OeyHUQ7RrucAI3txqM19610FWS1XGxyVg066tcu4m6lImmtXr5voeZbKhsg
         IG/g==
X-Gm-Message-State: ANoB5pnnp5Y7pb7v3J4yMD9gUBOehjaRedG2ex5ArbNRdnBhp5O9ZDmT
	IIS2J9EtHkf4iQDOI9dY6QQCog==
X-Google-Smtp-Source: AA0mqf55x7M4sv2x3tayft1I7V3sSjX0b6B+H4EoWIBSX/GlBW1IkeeiP/C1ZdGWLs42NtueKdU4uw==
X-Received: by 2002:a63:1865:0:b0:478:b1f4:1661 with SMTP id 37-20020a631865000000b00478b1f41661mr10871408pgy.317.1670340495049;
        Tue, 06 Dec 2022 07:28:15 -0800 (PST)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id d12-20020a170903230c00b0016c9e5f291bsm12848547plh.111.2022.12.06.07.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 07:28:14 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1p2Zrg-004crv-OQ;
	Tue, 06 Dec 2022 11:28:12 -0400
Date: Tue, 6 Dec 2022 11:28:12 -0400
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
Message-ID: <Y49fjFD6foGorhmp@ziepe.ca>
References: <20221206055816.292304-6-lei.rao@intel.com>
 <20221206062604.GB6595@lst.de>
 <Y48+AaG5rSCviIhl@ziepe.ca>
 <20221206130901.GB24358@lst.de>
 <Y49JNvdmRPNWw26q@ziepe.ca>
 <20221206140002.GB27689@lst.de>
 <Y49PqoAhZOeraLVa@ziepe.ca>
 <20221206143126.GB30297@lst.de>
 <Y49WNo7XWZ2aFfds@ziepe.ca>
 <20221206150131.GA32365@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206150131.GA32365@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221206_072817_998972_74E2D594 
X-CRM114-Status: GOOD (  15.32  )
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

On Tue, Dec 06, 2022 at 04:01:31PM +0100, Christoph Hellwig wrote:

> So this isn't really about a VF live cycle, but how to manage life
> migration, especially on the receive / restore side.  And restoring
> the entire controller state is extremely invasive and can't be done
> on a controller that is in any classic form live.  In fact a lot
> of the state is subsystem-wide, so without some kind of virtualization
> of the subsystem it is impossible to actually restore the state.

I cannot speak to nvme, but for mlx5 the VF is laregly a contained
unit so we just replace the whole thing.

From the PF there is some observability, eg the VF's MAC address is
visible and a few other things. So the PF has to re-synchronize after
the migration to get those things aligned.

> To cycle back to the hardware that is posted here, I'm really confused
> how it actually has any chance to work and no one has even tried
> to explain how it is supposed to work.

I'm interested as well, my mental model goes as far as mlx5 and
hisillicon, so if nvme prevents the VFs from being contained units, it
is a really big deviation from VFIO's migration design..

Jason

