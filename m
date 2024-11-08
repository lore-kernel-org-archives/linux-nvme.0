Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD975D5C0E4
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Nov 2024 15:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XIfO4IBmV95o3mvGi/X69TvkVk5dIa1bbBWZFWR1V+g=; b=Hy4HKGBfk5VKG2ciuctKebK3/0
	4VSsebQf4/F8d5NEK6Vbbchff21OkTwBSoQgTVCbawFlPRkOKINsUoJDTHUBdSiq7bEEc7va5N51G
	b2N0q1MwN8ncYtFjjSGiAg7Aav6CptT8rHZv6nNThgWXZnkuS8E9xU68sbspZwkzqbme3YITWnTl7
	AspK1x6I+Aw/BKAO/KFzuJh1OKnLwx0Jad3UNehJniP1xM6583GeuOF3cTNn4HEKaws7HWdfqkd9e
	h0klu+erl9YKBktz3hKk09uDvQ1dC18BxwhKZ9ph6pSnYiPQPp4574gRMgAJu19G55usrnFOtcOUO
	wfml+v5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t9QXG-0000000AxJJ-0ZAr;
	Fri, 08 Nov 2024 15:04:30 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t9Pv5-0000000Aq9v-1YSD
	for linux-nvme@lists.infradead.org;
	Fri, 08 Nov 2024 14:25:05 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id CF79C68AA6; Fri,  8 Nov 2024 15:24:57 +0100 (CET)
Date: Fri, 8 Nov 2024 15:24:57 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, m@bjorling.me,
	matias.bjorling@wdc.com, kch@nvidia.com, kanie@linux.alibaba.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv4 04/13] nvmet: implement supported features log
Message-ID: <20241108142457.GC6694@lst.de>
References: <20241107193849.995554-1-kbusch@meta.com> <20241107193849.995554-5-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107193849.995554-5-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241108_062503_645973_E75F0074 
X-CRM114-Status: UNSURE (   9.93  )
X-CRM114-Notice: Please train this message.
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

On Thu, Nov 07, 2024 at 11:38:39AM -0800, Keith Busch wrote:
> +	features->fis[NVME_FEAT_NUM_QUEUES] = cpu_to_le32(NVME_FIS_FSUPP |
> +							  NVME_FIS_CSCPE);
> +	features->fis[NVME_FEAT_KATO] = cpu_to_le32(NVME_FIS_FSUPP |
> +						    NVME_FIS_CSCPE);

Totally nitpicky, but I find this version much easier to read:

	features->fis[NVME_FEAT_NUM_QUEUES] =
		cpu_to_le32(NVME_FIS_FSUPP | NVME_FIS_CSCPE);
	features->fis[NVME_FEAT_KATO] =
		cpu_to_le32(NVME_FIS_FSUPP | NVME_FIS_CSCPE);

especially if the number of flags keeps growing.

Either way this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

