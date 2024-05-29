Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 527D8C25B75
	for <linux-nvme@archiver.kernel.org>; Wed, 29 May 2024 07:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bB0HANADKEt7RaCD2J1XtUdtzqjGQA/PQ6f6Pbtfj7A=; b=OqrgyPTtSrb8+TiNUXgjAyPlcw
	dk/wBOI8kGC22hsRhiwEMPjp2i3LWesjhPm3eFwHMt41JUaN1xhnuY57h49BJFUecOKVoAcy8CKhx
	hoGXGmzNGRypkSEo5KTxp00CwbU2URgj3U1YycDPJlJ65zoYdf7Hw9WCGMeYjXY/6B1MR2lo8NK7g
	OhlkgqUhzVaFGnBMWlrQh4exER++o2tVI1tWUDYA+jLquiO8QEw0P+Di57oGVPZPJap7BOS66BENU
	GWIrerUZvmaeE6yQM2IY7pM2zzChQYU6KTEOKbHGDRY6ZoUJjjvDlO35Xkojt/eYn5UT75BokSj9D
	VVgQUagQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCE2w-00000003DA7-24iW;
	Wed, 29 May 2024 07:48:30 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCE2s-00000003D7t-3zwB
	for linux-nvme@lists.infradead.org;
	Wed, 29 May 2024 07:48:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 5EE26626FE;
	Wed, 29 May 2024 07:48:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B05F7C2BD10;
	Wed, 29 May 2024 07:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716968903;
	bh=S3iTcM1ZSPmjm7GZozDt8RGkp17GchQ3Ca1mGNH4Urc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dfbgA6jNdLtv905YzgHRwUpIcUYBb2/FqhbHwVVPi8jDYBzJegkHqnKtVllDgSZxJ
	 hl119F1YITV2L0CzUXjFMz0P8CY1JoKC531SnvSR0HoJ9YdSPXasTOt6h/EqHBOz5D
	 L6tidnnLJT9F5jmKbw3Jjz/je6ejB31Y6FneddoZhnRuBt9uZ2weZz0M8qraIlnOGu
	 b564lvPJrYPe1xyTLSU6lOiEFiwyarsZVBy/9tTbFhKAXiUQ99rmKkFZCc0tkP24fr
	 AM3HjKJP/ev9C0RkvyustpQi11rCci5L99jxRXkdkeoJFk08ttBvU+/Hb1H+2ytDwu
	 nVyuobiiw1hmg==
Message-ID: <9f1ec1c1-e1b8-48ac-b7ff-8efb806a1bc8@kernel.org>
Date: Wed, 29 May 2024 16:48:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 02/12] Add infrastructure for copy offload in block
 and request layer.
To: Nitesh Shetty <nj.shetty@samsung.com>,
 Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, martin.petersen@oracle.com, david@fromorbit.com,
 hare@suse.de, damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com,
 joshi.k@samsung.com, nitheshshetty@gmail.com, gost.dev@samsung.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
References: <20240520102033.9361-1-nj.shetty@samsung.com>
 <CGME20240520102842epcas5p4949334c2587a15b8adab2c913daa622f@epcas5p4.samsung.com>
 <20240520102033.9361-3-nj.shetty@samsung.com>
 <eda6c198-3a29-4da4-94db-305cfe28d3d6@acm.org>
 <20240529061736.rubnzwkkavgsgmie@nj.shetty@samsung.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240529061736.rubnzwkkavgsgmie@nj.shetty@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240529_004827_075348_94241A79 
X-CRM114-Status: GOOD (  12.03  )
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

On 5/29/24 15:17, Nitesh Shetty wrote:
> On 24/05/24 01:33PM, Bart Van Assche wrote:
>> On 5/20/24 03:20, Nitesh Shetty wrote:
>>> We add two new opcode REQ_OP_COPY_DST, REQ_OP_COPY_SRC.
>>> Since copy is a composite operation involving src and dst sectors/lba,
>>> each needs to be represented by a separate bio to make it compatible
>>> with device mapper.
>>> We expect caller to take a plug and send bio with destination information,
>>> followed by bio with source information.
>>> Once the dst bio arrives we form a request and wait for source
>>> bio. Upon arrival of source bio we merge these two bio's and send
>>> corresponding request down to device driver.
>>> Merging non copy offload bio is avoided by checking for copy specific
>>> opcodes in merge function.
>>
>> In this patch I don't see any changes for blk_attempt_bio_merge(). Does
>> this mean that combining REQ_OP_COPY_DST and REQ_OP_COPY_SRC will never
>> happen if the QUEUE_FLAG_NOMERGES request queue flag has been set?
>>
> Yes, in this case copy won't work, as both src and dst bio reach driver
> as part of separate requests.
> We will add this as part of documentation.

So that means that 2 major SAS HBAs which set this flag (megaraid and mpt3sas)
will not get support for copy offload ? Not ideal, by far.

-- 
Damien Le Moal
Western Digital Research


