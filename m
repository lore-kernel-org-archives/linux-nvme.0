Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8375CCF9F8
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Nov 2025 01:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JcVQUQ0qnDBf3C5wW1/fc67OMw8xFeuyes8rlP2eE2s=; b=0I+VpGlWKn3brqYMNtJ+DOW4iC
	uGfdWl2SlE9gu9w9mtxg5PFDeTWxcFgA3CIgMuYZHzSWQZEsDJX4OmCr5XvcwRiQAfnSXtbLMUme0
	fnXaMc5QzwebvirgdntDNs0qT/GJjp7esa0aJPw5cobB7TeN7wL15LF0PyLGPNkD5oR0ZkQ8t8ADN
	tZ5DMjcsrSgbtzMA4KV/8gzdixEKx/AKSUctwoQjHqZJTW4RNGDYVvYCAiNl/frV+nCXGBQW+5jKI
	WXHfkx5gABe2QBhlb0WAdEqkl+HkulWsB7lWkZEsGpgkSkoGCEYnTXw9vicW2i+1BIiKOC4rHnALz
	n+JjaCgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vG5iU-0000000At5w-1X29;
	Tue, 04 Nov 2025 01:20:10 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vG5iT-0000000At5m-0bRw
	for linux-nvme@lists.infradead.org;
	Tue, 04 Nov 2025 01:20:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 3AEF0601DF;
	Tue,  4 Nov 2025 01:20:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD839C4CEE7;
	Tue,  4 Nov 2025 01:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762219207;
	bh=B9r9ZwP9Zh5rBTzvhh3Jm+fmjQMtHYtUw8GVnM21l5A=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=DKyaruManSVZUbUf1gEWKFtbuu2E7kerKWb9JMaAkt4sznVdpIut1bvM4I2R67YHB
	 7nw9TQLSIi5fHY4eWEMmds9v+KxxDIaCcuOdT+9KGgdrmb9az4YW0Ewb9LwuwARJvh
	 7zKksVg4QndgEvOhRVKWC3bZDeesfmYFIzxJMeJG6ACGmYd/Tlv5po1NGdP8WKqBk9
	 obl6t4bx4qf3RnNVLD078RVyEZL/x0wX175TOCO2WHG+dmnyt/ug0dlYWj0aVfDEXc
	 x/X5PuVtpHISFb/mMIsohchwin4IbSqoV3GCvFjxSadfPW5YjGsyf/7gGBzSmpG/G1
	 mZLof6jfwIKsA==
Message-ID: <97535dde-5902-4f2f-951c-3470d26158da@kernel.org>
Date: Tue, 4 Nov 2025 10:20:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/15] block: introduce BLKREPORTZONESV2 ioctl
To: Bart Van Assche <bvanassche@acm.org>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, Jens Axboe
 <axboe@kernel.dk>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Keith Busch <keith.busch@wdc.com>, hch <hch@lst.de>,
 "dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
 Carlos Maiolino <cem@kernel.org>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 David Sterba <dsterba@suse.com>
References: <20251103133123.645038-1-dlemoal@kernel.org>
 <20251103133123.645038-12-dlemoal@kernel.org>
 <982ed7d8-e818-4d9c-a734-64ab8b21a7e3@wdc.com>
 <0154c2a8-a3ed-45d3-8f8a-1581106212fb@kernel.org>
 <a6d95da9-afdc-4885-bcc7-246d6d133ba7@acm.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <a6d95da9-afdc-4885-bcc7-246d6d133ba7@acm.org>
Content-Type: text/plain; charset=UTF-8
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

On 11/4/25 10:01, Bart Van Assche wrote:
> On 11/3/25 4:15 PM, Damien Le Moal wrote:
>> The old one is needed to allow getting the precise imp open, exp open, closed
>> conditions, if the user cares about these. E.g. Zonefs does because of the
>> (optional) explicit zone open done on file open.
> 
> How about adding the above information in include/uapi/linux/blkzoned.h?

I did.

> 
> Thanks,
> 
> Bart.


-- 
Damien Le Moal
Western Digital Research

