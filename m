Return-Path: <SRS0=HFDN=OT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C53CC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Sep 2021 23:36:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C047C61504
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Sep 2021 23:36:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C047C61504
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hUwYFqmgx96mcADZ/oSsENagifS3PHSPLfIoETGdzsw=; b=yo0VPdhatTSeYl
	JbKDMPIC9wEWlkSecEoNnspjgmRU+0kTGItRLqLRvBuvNx1i79FhCffEpPsBDg9rECY9wHj8G6KlR
	jruWwn0SudmnvcPojisUX1XLLnJiG57dIOgP3siPVdL/EvPlo0pVQzKNUGfmAWUh4IlOTd/J9lPrd
	eVLbiJ+qv3WoiZK3DOGLYP+9e+/ICzPfVeB0swlRia9FB1CLg1IXeqCCrHnhCS3eowcPN6WfioIAL
	M8zIf/OGpFXumMbcEoIMARSv4YPSTZWWAaj27gayjOKdYjKaP+XemdsnUCQwS+H4qIHcBdCcGtHmk
	SPGIKDLLA4zGEogYxouA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mVj7m-00CcMU-Dd; Wed, 29 Sep 2021 23:36:30 +0000
Received: from mail-qt1-x836.google.com ([2607:f8b0:4864:20::836])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVj7j-00CcLS-GH
 for linux-nvme@lists.infradead.org; Wed, 29 Sep 2021 23:36:28 +0000
Received: by mail-qt1-x836.google.com with SMTP id r1so3975212qta.12
 for <linux-nvme@lists.infradead.org>; Wed, 29 Sep 2021 16:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=p44CKw5NqI0dRYxuOA5K9AcDSEZdsWaIBA8jXRcCw5I=;
 b=BPbV7Ye4Bg5a1ZTPc0nR9KOXAhWl4vBzAsDP0t40qxFSH4OCK6/MQKoFgPTEuzSC9v
 9WzoiGlY1hhlhin2gZEWJVK42YbLrmi7f51aphr87IllDIDa/mW2TlwOq98Zvj0JRk6r
 inxpNiGI/a0tzZNBGtrfuGtkApxUXeOUvY5k07EjRTxe3FM8zYJRfjjEr2wiowyupIsP
 pguKaqLo4Vxp8H1+LxCZCv8O7UiZItzZkw/1xqVdmL+zc9QUl9vc75MtsgPZmJ4AEECN
 dBdxRWVA8aWYCV8FKdHpO9CE7a3VgpFt7E/hUggJ2cfyrdgPqy3taLCfKIMAeO9CnW6s
 e4ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=p44CKw5NqI0dRYxuOA5K9AcDSEZdsWaIBA8jXRcCw5I=;
 b=r31fuVt0Hf2dPwZ85PkIzLySHVTs5DB754t89Cxc03lFJRi3qYnf/NqPWo+/CcXIWP
 feqRdRnukkZxe+QLZsxUKwkcnk8hefb2m1mbiF/2AnwUWy4N1yI6vtWQaDM/N1MhDcrF
 qUv0/2msiifB3IUQ9LXr8gUi7RhkFB7GPcAagGHaSpQ+/+guRsdWJevp5ck+kR/LvI9g
 2ILIoVLPxmp+kDKPDI8cdNGRZJo39HH/f20Xwb2+WmezhK5h+Jlcie3uKVg+Qpt+lEY9
 TxLqYojHT3ERDs7D/k1SFiBKZb4AJwpPRFTdH7NU1fbpIbFHn4pqod6o7NXRe/Tuy90O
 qeMA==
X-Gm-Message-State: AOAM5324q0KYjny+Dxj4sNgDjakijiB0hCJBfSUFpfGz1tv23W8wl+gi
 BrBWF37/A+NsrIpqQ8nSB24DPw==
X-Google-Smtp-Source: ABdhPJyCMb0x8UTP251JMzz7qx/fZLPDIyTJit8sJRFPeoPnTFgHskOtgm8FIWQl2/TGWg7M25xovg==
X-Received: by 2002:a05:622a:492:: with SMTP id
 p18mr3159519qtx.282.1632958586146; 
 Wed, 29 Sep 2021 16:36:26 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.113.129])
 by smtp.gmail.com with ESMTPSA id f5sm706662qtp.44.2021.09.29.16.36.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Sep 2021 16:36:25 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1mVj7g-007iwP-Pe; Wed, 29 Sep 2021 20:36:24 -0300
Date: Wed, 29 Sep 2021 20:36:24 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Dan Williams <dan.j.williams@intel.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 John Hubbard <jhubbard@nvidia.com>, Don Dutile <ddutile@redhat.com>,
 Matthew Wilcox <willy@infradead.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Jason Ekstrand <jason@jlekstrand.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Ira Weiny <ira.weiny@intel.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Subject: Re: [PATCH v3 00/20] Userspace P2PDMA with O_DIRECT NVMe devices
Message-ID: <20210929233624.GG3544071@ziepe.ca>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210928200216.GW3544071@ziepe.ca>
 <06d75fcb-ce8b-30a5-db36-b6c108460d3d@deltatee.com>
 <20210929232147.GD3544071@ziepe.ca>
 <93f56919-03ee-8326-10ee-8fbd9078b8e0@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <93f56919-03ee-8326-10ee-8fbd9078b8e0@deltatee.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210929_163627_577376_FE9C0B93 
X-CRM114-Status: GOOD (  24.54  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Sep 29, 2021 at 05:28:38PM -0600, Logan Gunthorpe wrote:
> 
> 
> On 2021-09-29 5:21 p.m., Jason Gunthorpe wrote:
> > On Wed, Sep 29, 2021 at 03:50:02PM -0600, Logan Gunthorpe wrote:
> >>
> >>
> >> On 2021-09-28 2:02 p.m., Jason Gunthorpe wrote:
> >>> On Thu, Sep 16, 2021 at 05:40:40PM -0600, Logan Gunthorpe wrote:
> >>>> Hi,
> >>>>
> >>>> This patchset continues my work to add userspace P2PDMA access using
> >>>> O_DIRECT NVMe devices. My last posting[1] just included the first 13
> >>>> patches in this series, but the early P2PDMA cleanup and map_sg error
> >>>> changes from that series have been merged into v5.15-rc1. To address
> >>>> concerns that that series did not add any new functionality, I've added
> >>>> back the userspcae functionality from the original RFC[2] (but improved
> >>>> based on the original feedback).
> >>>
> >>> I really think this is the best series yet, it really looks nice
> >>> overall. I know the sg flag was a bit of a debate at the start, but it
> >>> serves an undeniable purpose and the resulting standard DMA APIs 'just
> >>> working' is really clean.
> >>
> >> Actually, so far, nobody has said anything negative about using the SG flag.
> >>
> >>> There is more possible here, we could also pass the new GUP flag in the
> >>> ib_umem code..
> >>
> >> Yes, that would be very useful.
> > 
> > You might actually prefer to do that then the bio changes to get the
> > infrastructur merged as it seems less "core"
> 
> I'm a little bit more concerned about my patch set growing too large.
> It's already at 20 patches and I think I'll need to add a couple more
> based on the feedback you've already provided. So I'm leaning toward
> pushing more functionality as future work.

I mean you could postpone the three block related patches and use a
single ib_umem patch instead as the consumer.

Jason

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
