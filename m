Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2343C55162
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jul 2026 11:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1Em3TiVNGp+VmJmgSiWpu5gfQqPyZu82htRVl47SZ0Y=; b=EWNX1HZ8zDhpF8XxCXVx3KhKVO
	55lR2ZItmr0wJL1uMYOhiGudNKV+HFQIxST34YgBdwvVDXobjMOPhJsw+HBMWlAnW61JDeGDq8lld
	trbCsKCNitL+RaIO+yTGX0NSTZ+CBmObyd0yYw+pAXLVLO0auFczVxmljKfd15HtbhVST88oXYUAc
	aInaulJ8+1L2VtRIU6f+wTtu/os5nMZ/INfINCaSvJg1JgNoHx9lWC5+EZC3CxU83Hu9jOmwVF9Cs
	SOa0sdwRY0ZP8RBzj/oN+ec0U5YhWPqrhOXp+tF0U4ALTXtIsDPZ6WkdDA21Skt8IDmouQ3u1TdWo
	NVmSYZng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpP43-0000000AMTO-240B;
	Thu, 30 Jul 2026 11:36:39 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpP41-0000000AMRv-0yxn
	for linux-nvme@lists.infradead.org;
	Thu, 30 Jul 2026 11:36:38 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4144B68BFE; Thu, 30 Jul 2026 13:36:32 +0200 (CEST)
Date: Thu, 30 Jul 2026 13:36:32 +0200
From: Christoph Hellwig <hch@lst.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>, Nilay Shroff <nilay@linux.ibm.com>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 4/4] nvme: clamp FDP placement handle count to the
 buffer size
Message-ID: <20260730113632.GC25454@lst.de>
References: <20260730043105.3071328-1-kanie@linux.alibaba.com> <20260730043105.3071328-5-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730043105.3071328-5-kanie@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260730_043637_431975_6979B5D7 
X-CRM114-Status: GOOD (  14.88  )
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

On Thu, Jul 30, 2026 at 12:31:05PM +0800, Guixin Liu wrote:
> nvme_query_fdp_info() allocates the RUH status buffer for at most
> S8_MAX - 1 descriptors and caps the io-mgmt-receive transfer to that
> size. head->nr_plids, however, is taken verbatim from the device-supplied
> nruhsd field, which can be up to 65535. If a non-conformant or malicious
> device reports more descriptors than the buffer holds, the copy loop
> reads past the end of the ruhs buffer (heap out-of-bounds read).
> 
> Clamp nr_plids to the number of descriptors the buffer can actually hold.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


