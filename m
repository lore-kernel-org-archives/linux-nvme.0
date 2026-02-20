Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D9B7C5ACD1
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Feb 2026 16:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XaF1f3cJEdHRGliN11gnnnA7ZEoMVYioRvxvKw9NRtk=; b=l2PYeSPDjdANTlL8pPUVJz/5Pm
	SQhntLaLnkHET7UGC51bsDP8PSrtAifTj//ZdlUOr5pN/tyYaLrhJZ1b24v76Q5u4y/V071Fhr7EB
	9k4L5NEX3rvHN8vXOq3HIenPsvTVRefwPtw5pANrcAKQyLR3OPh8pMtWG4KZ1c4aQuj3hzQWdWbpu
	mgHAkdGIEt3aW99YJKDfOZ30hU2yxmd0vkFtA8bL7URb1WfPJ1+xjoegWWiu+xLqjrO5cS6uq3C/C
	EpiHukEeEbJL5nnhxe9IwoA4rnY2UPuA1xTB7wk43s0KDcqpJbUfF3p1BZni8OMT2yOvOoXM1Mq9K
	WPo8y2gQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtT5X-0000000FBag-2l3e;
	Fri, 20 Feb 2026 16:10:43 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtT5T-0000000FBTN-0al0
	for linux-nvme@lists.infradead.org;
	Fri, 20 Feb 2026 16:10:40 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 29FB268B05; Fri, 20 Feb 2026 17:10:36 +0100 (CET)
Date: Fri, 20 Feb 2026 17:10:36 +0100
From: Christoph Hellwig <hch@lst.de>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] nvme: set discard_granularity from NPDG/NPDA
Message-ID: <20260220161035.GE15071@lst.de>
References: <20260220032809.758089-1-csander@purestorage.com> <20260220032809.758089-5-csander@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220032809.758089-5-csander@purestorage.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260220_081039_345123_2E969CED 
X-CRM114-Status: GOOD (  12.83  )
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

On Thu, Feb 19, 2026 at 08:28:07PM -0700, Caleb Sander Mateos wrote:
> -static void nvme_config_discard(struct nvme_ns *ns, struct queue_limits *lim)
> +static void nvme_config_discard(struct nvme_ns *ns, struct nvme_id_ns *id,
> +				struct nvme_id_ns_nvm *nvm,
> +				struct queue_limits *lim)

The indentation here looks weird, this should be just two tabs.

> -	lim->discard_granularity = lim->logical_block_size;
> +	optperf = id->nsfeat >> NVME_NS_FEAT_OPTPERF_SHIFT &
> +		  NVME_NS_FEAT_OPTPERF_MASK;
> +	npdg = optperf & 0x2 && nvm && nvm->npdgl ? le32_to_cpu(nvm->npdgl) :
> +	       optperf & 0x1 ? le16_to_cpu(id->npdg) + 1 : 1;
> +	npda = optperf & 0x2 && nvm && nvm->npdal ? le32_to_cpu(nvm->npdal) :
> +	       optperf ? le16_to_cpu(id->npda) + 1 : 1;

Please undinw this into a few if statemens.  (And I really
with the spec would given the bits names..)


