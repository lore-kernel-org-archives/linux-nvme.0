Return-Path: <SRS0=U7R3=J6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1587C433B4
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 18:47:03 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 532DF61029
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 18:47:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 532DF61029
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:Cc:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=4oP5/mpl74xZmNNRkOmo46pkJuuqMsKbNwwdl6E9chc=; b=pOPEKRUXGP6v9pW8p9m5tEFqD
	/QWaHasgNK61tkFbHFA3ri6QqFQg1Vj6bXYPCITTxweIHN4VRkvUOq0NW7Y464e95ufTctfREmgJN
	o4QwczwZkpd7o3Bg8MfL75RZ+Iz65YDrFxqBcmuZdpa35ixBxQxuo243+8CiA6IhMHduSmFCH67uQ
	2pAuJSVJVG2C1mM5jW6kl4dNU0zZ+EXeTb4ANp/zUZHPKziqg1YC/eA2prPpHBTbWqeRGRxQwLhyS
	+9ueHj7BUCexjh8NeYC+/3Fpp6AIADiAF18rm1fL9YoXcDXf9ZtmwO2ZnLDWpNAY2F660bB/bz8T8
	fWZIQC11A==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lddaS-00Edb6-DD; Mon, 03 May 2021 18:46:32 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lddaL-00EdaK-S2
 for linux-nvme@desiato.infradead.org; Mon, 03 May 2021 18:46:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Subject:Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=FQlZSc22rDFnyD/b3PGREqWaL5WzGsfMM4i2vFu2da4=; b=wGtVZtgpkvxDvEU3D9s8kRulpF
 6IDMidqro/oATHDdjaSpfJ1wRaR7cQEcBX9eHBHzBBPdF0cVlWcgJTcVVR58/6llHNUJCPzz+9Qah
 anm6wRggjevGMS6yC13Lu46ebW5X+8W3x0cOmE2B0GxnCvfKdIQO+HHu8oxBd6jLSSGLCZmDYhQPj
 rpN9ti3xDjCt0EGHQQd+dYCuIFvDtjK+83UNBtHnY+PyHzfcMiiL425nQam+0koLFARAqunLCjtOi
 8Fvr9IXKcSejN8GIIvSj11U0QQBSQH4Nb+n/i2nFdMcKibVQe/WJ+BVeUa2M6+6kvQWzJYWTe6tY6
 9HtRvybA==;
Received: from ale.deltatee.com ([204.191.154.188])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lddaJ-003PU5-6h
 for linux-nvme@lists.infradead.org; Mon, 03 May 2021 18:46:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=FQlZSc22rDFnyD/b3PGREqWaL5WzGsfMM4i2vFu2da4=; b=IjY1prSgciJlO7qETHoHcDfvVo
 474Xui/7jwzyvAcWaBDmxoOFd8uUVi4aWV7PQwD6cV/vy5cZzNo0VGRA9oBXLxQpeKYJmpYH4jFyb
 4wFa1eShvwuPp+3pmYC4qq4DvJ9Z2+ZznJ5szAfZyCxaIRohe3bxb+xs950S+H/+mvsScLGbX8B45
 NzXRP57YewUyLmWEB0dkwAeAOpDzXaLnaMXhIujZcHeNydo4HTpR+9b6Qg4uIif2wRfBJ8qvAgoiG
 zwo0WfN8QxtRRhA24zXz3sRBsHqPStF4rnlp5K7yiV9Rf9KQdWrbwuBKRWO+YajAWnmHIvq365iJz
 t2H/5Otg==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1ldda9-000141-N8; Mon, 03 May 2021 12:46:14 -0600
To: Christoph Hellwig <hch@lst.de>
Cc: John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, Stephen Bates <sbates@raithlin.com>,
 Dan Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Don Dutile <ddutile@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Jason Ekstrand <jason@jlekstrand.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>, Bjorn Helgaas <helgaas@kernel.org>,
 Ira Weiny <ira.weiny@intel.com>, Robin Murphy <robin.murphy@arm.com>
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-4-logang@deltatee.com>
 <3834be62-3d1b-fc98-d793-e7dcb0a74624@nvidia.com>
 <a1b6ffa9-7a9c-753f-6350-5ea26506cdc3@deltatee.com>
 <20210503183509.GA17971@lst.de>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <d563acfa-f7d5-2f11-4c1b-b5e2f341a2cb@deltatee.com>
Date: Mon, 3 May 2021 12:46:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210503183509.GA17971@lst.de>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: robin.murphy@arm.com, ira.weiny@intel.com,
 helgaas@kernel.org, jianxin.xiong@intel.com, dave.hansen@linux.intel.com,
 jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com,
 daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com,
 christian.koenig@amd.com, jgg@ziepe.ca, dan.j.williams@intel.com,
 sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 jhubbard@nvidia.com, hch@lst.de
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 03/16] PCI/P2PDMA: Attempt to set map_type if it has not
 been set
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210503_114623_253632_A538ADE7 
X-CRM114-Status: GOOD (  15.02  )
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



On 2021-05-03 12:35 p.m., Christoph Hellwig wrote:
> On Mon, May 03, 2021 at 10:17:59AM -0600, Logan Gunthorpe wrote:
>> I agree that some of this has evolved in a way that some of the names
>> are a bit odd now. Could definitely use a cleanup, but that's not really
>> part of this series. When I have some time I can look at doing a cleanup
>> series to help with some of this.
> 
> I think adding it to the series would be very helpful.

Ok, I'll prepend a handful of cleanup patches.

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
