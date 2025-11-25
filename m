Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E376CFD36C
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Nov 2025 01:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:Cc:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ry5dUxWKQuIvU0Z9oz0DQh9+43tGYessbm7lpwjbNgE=; b=31v9nkny0yZ2T+u6P0v0VIL6Rl
	8jL11n97YtcpkgyVbk5LGNC7qNFTsLTBMC8vsfimg4P8t6ZoC8gmu5AFfjxEt+VvI1b1q8EBnIuxX
	swzcITsFNrgMaEeWZeEEsfNCJtOpxP/z0zu+VHmPi7HOobKGMp4e+r18kk7Ay3zoehC+zQZoM1gZw
	DI7hfaQP8aS9uZQwpxaWOoZRgoOGGpHjx7XAtWwVOr08F6XcPZKaWAQcDldeLlzR72nXJGwYeRYmm
	zR98AG9tsMnSbdNjDLvHxDKuc09MpQtn2BuoA2tau/031WL4XbcNR1UjZq6cjgeifefOA68Nvz8kB
	0CIvE10w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNhZB-0000000CYO5-1zwH;
	Tue, 25 Nov 2025 01:10:01 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNhZ9-0000000CYNa-3Hql
	for linux-nvme@lists.infradead.org;
	Tue, 25 Nov 2025 01:09:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 9B25260010;
	Tue, 25 Nov 2025 01:09:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A996EC4CEF1;
	Tue, 25 Nov 2025 01:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764032998;
	bh=p+RQE8h6QFhjvlBxPivIpSfBdKHxPiCLXqbTGtWf46M=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=kQJwBRIeltEvdGX/fAzab87jUDhTkk9++PHTM3qoEmNCswD5CsY5f1W7YtjrR/vUq
	 LnALvZVuJEgGzptHvE6j3cCAhVedGqzRCrYyf1Fu00EXD6d6rEfAz9S+2YXLZBAQtJ
	 HxEQgduuPzo3Dd+9t3obcRy/Orvao8Wxj81DLFib2yxL6imPcs0CmgyKSODJ+S1VHT
	 CSCwwIQ5J/04Sxuq09AA5BVjAA/u3mNTjQ8XH4pJIhkIh/la8Ku+qYTUYAT/pLiICH
	 QJi87G1lUUrrxvn8l9VYu75SCwr+C+d3qno/7HTOSdpLH0GK1OOjpnIjQmZ4x+gudR
	 oNNSBkRlqrvOg==
Message-ID: <9c8a6b5f-74c8-4e9f-ae46-24e1df5fe4e0@kernel.org>
Date: Tue, 25 Nov 2025 09:10:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 bpf@vger.kernel.org, "Martin K . Petersen" <martin.petersen@oracle.com>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH V3 5/6] f2fs: ignore discard return value
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>, axboe@kernel.dk,
 agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com, song@kernel.org,
 yukuai@fnnas.com, hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
 jaegeuk@kernel.org, cem@kernel.org
References: <20251124234806.75216-1-ckulkarnilinux@gmail.com>
 <20251124234806.75216-6-ckulkarnilinux@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20251124234806.75216-6-ckulkarnilinux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 11/25/2025 7:48 AM, Chaitanya Kulkarni wrote:
> __blkdev_issue_discard() always returns 0, making the error assignment
> in __submit_discard_cmd() dead code.
> 
> Initialize err to 0 and remove the error assignment from the
> __blkdev_issue_discard() call to err. Move fault injection code into
> already present if branch where err is set to -EIO.
> 
> This preserves the fault injection behavior while removing dead error
> handling.
> 
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

