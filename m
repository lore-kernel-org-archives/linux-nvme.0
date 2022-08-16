Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A73C1C25B0E
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Aug 2022 21:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dlmkCHwvDqI7TrthDWzwPnDA00fDNxdw3pPu/XeTTCc=; b=j+NibutF8uCMFOK2vT4BZUouuO
	q3OsBjmHMwEp6j7TkJn6qFNfa269vzqZ+LpMlzgfV0v2tL1VbEMBK50JWB6Yrn00k1fsRW4zlBq5W
	79EHUBKkHosjFihhh7sUmUv0rlEdPXb5wGCeN3En+HrEIjmldy3yNHZTTQxc0EoT9iQE31Z521dEn
	tfpJZrsnu3meSGZCvkpHfZT15M2Y68o4wLdk1i60bXmUASnj7Vcf5hh5oXEZtbZ00kebKk6/JgG45
	/5mCXeY3czEo3ctRj6IcM3owfKriRg7kwDREVMHUfuv2JFKtA2VNvI8fuqOrZ7M3QHoxGIXO6uRoS
	DTUH3tmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oO3tg-00738x-BN; Tue, 16 Aug 2022 21:14:48 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oO3td-00738A-Fu
	for linux-nvme@lists.infradead.org; Tue, 16 Aug 2022 21:14:46 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id DB19CB81AF2;
	Tue, 16 Aug 2022 21:14:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 416BFC433D6;
	Tue, 16 Aug 2022 21:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1660684482;
	bh=m0n9HY+gqxmJTWtx8pVWHb4MyNuPPxntKDcT0U/yHjo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fNvpog6Ne0DR3YdxWE9freAnZ7a2ReiwVLY1m4s5+zot9uAgmDME/NRiby+5oJOAD
	 xzLoKSbrGeG+66XxwECTjXfQRZQOahXKh4KuXGfa8jyHRYf0bL2bIZAl1uL7ehpHqf
	 tvXiK+xqK0OmYOlowdq6ZKR5zPxWbAfJzCVG4z3NTzpD/MYv0cdkCKIGc4b80N29iR
	 naZME4/PnOZ9ioia8+1c+a64iK74vcAX2tv0A12Sg1dMYr28pky3mv5FI8PtHLWw7b
	 ktQ/952RKdm6J2LIsUrK1UXpm7Ju0epIjKmgeN0lAVRcUKZ/7pnD0DYiF4+v2iFK8k
	 1UbsVnRZsNfJg==
Date: Tue, 16 Aug 2022 15:14:38 -0600
From: Keith Busch <kbusch@kernel.org>
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: snitzer@kernel.org, axboe@kernel.dk, hch@lst.de, agk@redhat.com,
	damien.lemoal@opensource.wdc.com, linux-block@vger.kernel.org,
	Johannes.Thumshirn@wdc.com, bvanassche@acm.org,
	matias.bjorling@wdc.com, hare@suse.de, gost.dev@samsung.com,
	linux-nvme@lists.infradead.org, jaegeuk@kernel.org,
	pankydev8@gmail.com, linux-kernel@vger.kernel.org,
	dm-devel@redhat.com, Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v10 05/13] nvme: zns: Allow ZNS drives that have
 non-power_of_2 zone size
Message-ID: <YvwIvrToFYMDwQoj@kbusch-mbp.dhcp.thefacebook.com>
References: <20220811143043.126029-1-p.raghav@samsung.com>
 <CGME20220811143050eucas1p12321909b1b7f94182708b935b35e4ff9@eucas1p1.samsung.com>
 <20220811143043.126029-6-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220811143043.126029-6-p.raghav@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220816_141445_702550_23BA7616 
X-CRM114-Status: GOOD (  11.66  )
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

On Thu, Aug 11, 2022 at 04:30:35PM +0200, Pankaj Raghav wrote:
> @@ -101,13 +101,6 @@ int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf)
>  	}
>  
>  	ns->zsze = nvme_lba_to_sect(ns, le64_to_cpu(id->lbafe[lbaf].zsze));
> -	if (!is_power_of_2(ns->zsze)) {
> -		dev_warn(ns->ctrl->device,
> -			"invalid zone size:%llu for namespace:%u\n",
> -			ns->zsze, ns->head->ns_id);
> -		status = -ENODEV;
> -		goto free_data;
> -	}

We used to bail out early if the format wasn't supported, which wouldn't create
the namespace.

Now you are relying on blk_revalidate_disk_zones() to report an error for
invalid format, but the handling for an error there is different: the namespace
still gets created. I'm not sure if that's a problem, but it's different.

