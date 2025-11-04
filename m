Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFECCCCFA04
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Nov 2025 20:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/CPwuE1CKuAfGfZcSYSQ1oDoZgraxoGGdLplL8QseJU=; b=Ed/l2tN2D6eQLS4aFsaywvL8GA
	MnzvCd56hAmtVUD6aWoM+agGOT/anrn5sEeXuDZRaLMwfzeGZcWhlC2ovp7kY0PhvJi+CtBSliW5C
	myIDbyromLOLFCoUxWTtuSJsBmjcgtkkcMkK4R9O7P5VfQnme++wmjH30ya3azww+T2gOoIv9Jm4o
	h6BUKn1n773aaPf90MiFhDu+RfkkRlgo3uVtnvTUu3Txf0A123XpnAAU3Ftng3J2iqN3+2le6jm0P
	R/DV5HiIhXqyk+B6m1Qzm+zy8qnJDA7aIHsDaDD8trTWLT3vc04Iy8Q2GCRTgQ6OKvDCfj0t6kzis
	GaLQ563w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGNPb-0000000CWvu-3uEd;
	Tue, 04 Nov 2025 20:13:51 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGNPa-0000000CWvU-1B0D
	for linux-nvme@lists.infradead.org;
	Tue, 04 Nov 2025 20:13:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 38EA2601FE;
	Tue,  4 Nov 2025 20:13:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A74D6C4CEF7;
	Tue,  4 Nov 2025 20:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762287229;
	bh=3FSJqyPE1Vqo06Q/AoUzipo9gS2M6q2r8A7ZJUYYuF4=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=CJbwQVBE1D1MYm990XnLqqMuyjhnCCOdAlu+z03qAX2ImU+84t4gZezs53Dzn9YpY
	 xtvwjMHu+8X7lnYZ7JH4Pylbx4OxU+wk7qFyH49pRSdzAPUohWE2+gx1CkiP48JcWA
	 mnW2fbmijTHwh06o/88J4zyBfAaWNyvd7glFfXqzL0ir7Ks5RBywi418cZ1gnuwbTq
	 wppFtkGUZqi82Yt8ZyH+IqGRrBTo8wU4a2GROfbtr/EK6jMSAgdty7FmdAiDrAR2fM
	 g7o35wTbh4g/MsecHVA5qC90s2DhjfjjHF23pfL29BWk6AO7AJmXaPL94b6x2Yg39y
	 uSGT2Lsjtq+xw==
Message-ID: <da7e8c3e-49fe-49bd-9642-3b0ae67a3503@kernel.org>
Date: Wed, 5 Nov 2025 05:13:45 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/15] block: introduce BLKREPORTZONESV2 ioctl
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Keith Busch <keith.busch@wdc.com>, Christoph Hellwig <hch@lst.de>,
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
 Carlos Maiolino <cem@kernel.org>, linux-btrfs@vger.kernel.org,
 David Sterba <dsterba@suse.com>
References: <20251104013147.913802-1-dlemoal@kernel.org>
 <20251104013147.913802-12-dlemoal@kernel.org>
 <0cb7eefb-4501-47e8-805f-6e8737ca6bb5@acm.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <0cb7eefb-4501-47e8-805f-6e8737ca6bb5@acm.org>
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

On 11/5/25 04:00, Bart Van Assche wrote:
> On 11/3/25 5:31 PM, Damien Le Moal wrote:
>> - * @BLKREPORTZONE: Get zone information. Takes a zone report as argument.
>> - *                 The zone report will start from the zone containing the
>> - *                 sector specified in the report request structure.
>> + * @BLKREPORTZONE: Get zone information from a zoned device. Takes a zone report
>> + *		   as argument. The zone report will start from the zone
>> + *		   containing the sector specified in struct blk_zone_report.
>> + *		   The flags field of struct blk_zone_report is used as an
>> + *		   output only and ignored as an input.
>> + *		   DEPRECATED, use BLKREPORTZONEV2 instead.
>> + * @BLKREPORTZONEV2: Same as @BLKREPORTZONE but uses the flags field of
>> + *		     struct blk_zone_report as an input, allowing to get a zone
>> + *		     report using cached zone information if BLK_ZONE_REP_CACHED
>> + *		     is set.
> 
> Was it promised to add information in the above comment about the 
> differences in accuracy between the two ioctls? See also
> https://lore.kernel.org/linux-block/97535dde-5902-4f2f-951c-3470d26158da@kernel.org/

As I said, I did. See the comments with the BLK_ZONE_COND_ACTIVE condition.
If you think that is not enough, I can cross reference tht in the comment for
BLKREPORTZONEV2.



-- 
Damien Le Moal
Western Digital Research

