Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F411CCF9FE
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Nov 2025 07:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qINSATYiiPG/ea0NZ+pHvptCYVzcnYTKfwrdFdwLrAs=; b=X78juKS/Ajmnu8lxGzaL9/QN8z
	8bMWOdab8MB8tVhhp8I8Jjxy56tnU3vcIzqRM+k3hVfcmb7sirvETrVRwiWtkRJYP8/89GhKUw20u
	oFzgmf/DMQD+y4gjR13704gQAQFcp8r6jKt49VzU3QL7cmgp4IbgdWx8vNr1uoycQyBFPaJnfT9oI
	xyHha+O7C6QJVZHGhBlrYmJqYM5eR/uGvPWecgqKz+vY0HlrhSbaWiZIHLEij89ve/B8kIyTNzjbc
	pV2yU8pN0mzsUJ3ARxUIMLmLetPj1mYH9fzRG664MZCedPoQivvSL4E+iWjPCMZCf9yuNNGkouRlI
	8MAnJsBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFopZ-00000009LRy-1ii7;
	Mon, 03 Nov 2025 07:18:21 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFopX-00000009LR7-16Bz
	for linux-nvme@lists.infradead.org;
	Mon, 03 Nov 2025 07:18:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 950F8445F0;
	Mon,  3 Nov 2025 07:18:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E082C116B1;
	Mon,  3 Nov 2025 07:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762154298;
	bh=vlAqAmTDh4Z/QVBO24ytbjpGSmt0U77g+FzG3aQu5i4=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=sXgqXUKrx4uv7eCDDbOTW1FX2EPok9okwx0Lrr6XBQ45+D708jWbU21sZDvabs/hn
	 qvNvsMevjEkOo6P3J42RSOQ3Ac+pQ5EdatTBhtEwIUWGGrBBq20xe3q6xxFFsJNKul
	 /8fHCp3TUL/EkkGaTHHAsONSBNYkj8+xxoX+y49HwtFgaCqvyAbc+/FfzYtRjHwDSZ
	 gAuXGCMs1NkkiH83gyEO+vnrejyB8h3zyAACvbXKd1oLdL+P7gTfjX8PJox2wBwNln
	 TWVE+b2XT2lo4y1t4cK//cuvil16uW/0WrZZAuJVZhSMMX8d6tnb/t/8nekeQqT4jb
	 GMfwQhjssGKGQ==
Message-ID: <7a8d31de-f1bb-468f-8a44-2787f0080dcf@kernel.org>
Date: Mon, 3 Nov 2025 16:18:14 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/13] block: introduce blkdev_report_zones_cached()
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Keith Busch <keith.busch@wdc.com>, Christoph Hellwig <hch@lst.de>,
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
 Carlos Maiolino <cem@kernel.org>, linux-btrfs@vger.kernel.org,
 David Sterba <dsterba@suse.com>
References: <20251031061307.185513-1-dlemoal@kernel.org>
 <20251031061307.185513-10-dlemoal@kernel.org>
 <4287484a-3a3d-4f50-9c5b-7a901458bfbc@acm.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <4287484a-3a3d-4f50-9c5b-7a901458bfbc@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251102_231819_350969_1BB2D921 
X-CRM114-Status: UNSURE (   7.42  )
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

On 11/1/25 06:53, Bart Van Assche wrote:
> On 10/30/25 11:13 PM, Damien Le Moal wrote:
>> Introduce the function blkdev_report_zones_cached() to provide a fast
>> report zone built using the blkdev_get_zone_info() function, which gets
>> zone information from a disk zones_cond array or zone write plugs.
>> For a large capacity SMR drive, such fast report zone can be completed
>> in a few millioseconds compared to several seconds completion times
>> when the report zone is obtained from the device.
> 
> millioseconds -> milliseconds
> 
> Does retrieving the cached zone information really require multiple
> milliseconds instead of only a few microseconds?

There are over 100,000 zones on large capacity SMR HDDs. And I have models with
smaller zone size that have over 200,000 zones. So yes, a few milliseconds are
needed on normal (read not super fast) CPUs.


-- 
Damien Le Moal
Western Digital Research

