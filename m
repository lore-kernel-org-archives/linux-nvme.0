Return-Path: <SRS0=LLxJ=NI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D9F1C4338F
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Aug 2021 22:03:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B84961038
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Aug 2021 22:03:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3B84961038
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=interlog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:Reply-To:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=L8/xrcwgEd4y4PFNu8LQYVl8QoofJQjkQOPU/rO5/mo=; b=yS8QxOgC9o3c5j
	7bpC0uDWv/T3dfpkIFskOUSMIxf4wn0cW/zVPUZyIiiNvZQ+A1vE8GVV+3Afk4cB3ClpGFOYjtRBK
	h5OCfEgXeh8mvICmCNSVRDSs1BkHAq5n6flccBX5FYFbCkaZyJ+LBsFKghi/a7QEtZxxDEnspxtGW
	3luWN0fGaXKpCKssAGfzestAiJIkvPPMCjIM3NVuszH97c6uWUGPbUqVKOuJPbr5xYxV45Oke6AwL
	IHERBG97HVTeBxuzrpbrtRUrjZp9RjHbZ7/Jf8EMSyGvmkEGzKTQuJdV2wtm1WqgL0lIUv1v5mbb3
	z70nkMKDLgaNKnYoDP8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mG7AM-003bPC-S3; Tue, 17 Aug 2021 22:02:38 +0000
Received: from mail-1.ca.inter.net ([208.85.220.69])
 by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mG7AF-003bNp-MW
 for linux-nvme@lists.infradead.org; Tue, 17 Aug 2021 22:02:36 +0000
Received: from mp-mx11.ca.inter.net (mp-mx11.ca.inter.net [208.85.217.19])
 by mail-1.ca.inter.net (Postfix) with ESMTP id 8E3912EA3C6;
 Tue, 17 Aug 2021 17:53:50 -0400 (EDT)
Received: from mail-1.ca.inter.net ([208.85.220.69])
 by mp-mx11.ca.inter.net (mp-mx11.ca.inter.net [208.85.217.19]) (amavisd-new,
 port 10024)
 with ESMTP id OvSH92nd_r9u; Tue, 17 Aug 2021 17:53:49 -0400 (EDT)
Received: from [192.168.48.23] (host-45-78-207-107.dyn.295.ca [45.78.207.107])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: dgilbert@interlog.com)
 by mail-1.ca.inter.net (Postfix) with ESMTPSA id DC7C52EA1C8;
 Tue, 17 Aug 2021 17:53:45 -0400 (EDT)
Subject: Re: [PATCH 3/7] block: copy offload support infrastructure
To: Mikulas Patocka <mpatocka@redhat.com>, Bart Van Assche <bvanassche@acm.org>
Cc: SelvaKumar S <selvakuma.s1@samsung.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-api@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 dm-devel@redhat.com, kbusch@kernel.org, axboe@kernel.dk,
 damien.lemoal@wdc.com, asml.silence@gmail.com, johannes.thumshirn@wdc.com,
 hch@lst.de, willy@infradead.org, kch@kernel.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>, djwong@kernel.org,
 Mike Snitzer <snitzer@redhat.com>, agk@redhat.com, selvajove@gmail.com,
 joshiiitr@gmail.com, nj.shetty@samsung.com, nitheshshetty@gmail.com,
 joshi.k@samsung.com, javier.gonz@samsung.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20210817101423.12367-1-selvakuma.s1@samsung.com>
 <CGME20210817101758epcas5p1ec353b3838d64654e69488229256d9eb@epcas5p1.samsung.com>
 <20210817101423.12367-4-selvakuma.s1@samsung.com>
 <ad3561b9-775d-dd4d-0d92-6343440b1f8f@acm.org>
 <alpine.LRH.2.02.2108171630120.30363@file01.intranet.prod.int.rdu2.redhat.com>
From: Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <bbecc7e7-8bf5-3fe3-6c24-883c79fb7517@interlog.com>
Date: Tue, 17 Aug 2021 17:53:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.02.2108171630120.30363@file01.intranet.prod.int.rdu2.redhat.com>
Content-Language: en-CA
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210817_150231_901351_469DBF46 
X-CRM114-Status: GOOD (  18.04  )
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
Reply-To: dgilbert@interlog.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2021-08-17 4:41 p.m., Mikulas Patocka wrote:
> 
> 
> On Tue, 17 Aug 2021, Bart Van Assche wrote:
> 
>> On 8/17/21 3:14 AM, SelvaKumar S wrote:
>>> Introduce REQ_OP_COPY, a no-merge copy offload operation. Create
>>> bio with control information as payload and submit to the device.
>>> Larger copy operation may be divided if necessary by looking at device
>>> limits. REQ_OP_COPY(19) is a write op and takes zone_write_lock when
>>> submitted to zoned device.
>>> Native copy offload is not supported for stacked devices.
>>
>> Using a single operation for copy-offloading instead of separate operations
>> for reading and writing is fundamentally incompatible with the device mapper.
>> I think we need a copy-offloading implementation that is compatible with the
>> device mapper.
> 
> I once wrote a copy offload implementation that is compatible with device
> mapper. The copy operation creates two bios (one for reading and one for
> writing), passes them independently through device mapper and pairs them
> at the physical device driver.
> 
> It's here: http://people.redhat.com/~mpatocka/patches/kernel/xcopy/current

In my copy solution the read-side and write-side bio pairs share the same 
storage (i.e. ram) This gets around the need to copy data between the bio_s.
See:
    https://sg.danny.cz/sg/sg_v40.html
in Section 8 on Request sharing. This technique can be efficiently extend to
source --> destination1,destination2,...      copies.

Doug Gilbert

> I verified that it works with iSCSI. Would you be interested in continuing
> this work?
> 
> Mikulas
> 
>> Storing the parameters of the copy operation in the bio payload is
>> incompatible with the current implementation of bio_split().
>>
>> In other words, I think there are fundamental problems with this patch series.
>>
>> Bart.
>>
> 


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
