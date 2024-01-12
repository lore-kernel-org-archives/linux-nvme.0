Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DCE4C4725D
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Jan 2024 03:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=51JBtsq8ZttIempiBCMSOXAOl4TR6QuRx5ZeEfZRTaY=; b=NGHduFH0u8PBGj6rCjbmHRTfS8
	VznCLXLyFseQ2IDM95AvQ/Rn+MS4OoIkFxeIzoL/gm1XThcpd0WCp+Q25BlAyE9iYWQ+8nIZphfjq
	4yJsclsLf89ve2kmpj1tRuoDBQvgsPackCw31V5B5ox+7T9nj/a70CFklNMQLiJB7FNkYhxUHBwPn
	Vry0IW09p/NNNuZ6/NPkCarFltLaH8fbza9JoRH4fifk3csDwcUzWqm9zpLS7MxhlTIutsNbE03vL
	QbLPkX2ceb+IckvWEJKLkzun2Za5R6GDUjrhfl1soH57ykKqd3qRzhBBR1v8+EcrljMlJho0yGag9
	x7c8OMQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rO8Jd-001lar-0H;
	Fri, 12 Jan 2024 03:34:41 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rO8JY-001laK-2H
	for linux-nvme@lists.infradead.org;
	Fri, 12 Jan 2024 03:34:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 1ABDDB81D07;
	Fri, 12 Jan 2024 03:34:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA95AC433F1;
	Fri, 12 Jan 2024 03:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705030473;
	bh=U2WlBkeflJvpAc1+F5XCZJzmPfGFvOUX0WGz15O93zo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dupFg3TiYXHcowGOPj1VuQ3cF7htHd3EBTb9Ay8QOQAmTZiRTLyE4tTKAEOSvSW7N
	 dgaDzJbm8IB0lmRkq0Jw0HOVkYfxSPh0WBQNjtMSQ4WzAE1iOBTIOIAdxTDoTTWk6t
	 nDXAXJ0Vzk+XViDn0jrsLsfLI+ZYjA9AxyJIQrQP1pqEsUTg5562pQe6P+D0Ganmrd
	 k5qn2OudwttBzD+LQ0EcRRsBoOPLLMjaFIjgVYByLAwJA81lEKoazKcko1Nb7/WAst
	 +5Iln7STcahWXeD0uJnElg38mzczKBhC+Hj7yN8aQdYlJeBKArdRUAgf4VKKEJWxTq
	 XxO9MOHAlw99g==
Message-ID: <6fe89190-a8ff-47c3-a6c4-7d69296c9883@kernel.org>
Date: Fri, 12 Jan 2024 12:34:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Report] blk-zoned/ZNS: non_power_of_2 of zone->len]
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>, Bart Van Assche <bvanassche@acm.org>
Cc: linux-block@vger.kernel.org, Yi Zhang <yi.zhang@redhat.com>,
 John Meneghini <jmeneghi@redhat.com>, linux-nvme@lists.infradead.org,
 hch@lst.de, Keith Busch <kbusch@kernel.org>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>
References: <ZaCSOH7L+Nm6PvcN@fedora>
 <20503cd0-3a99-45bb-8374-40296a3cb92a@kernel.org> <ZaCyC5RIAcbkBYeL@fedora>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <ZaCyC5RIAcbkBYeL@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240111_193437_465068_28D2EDB1 
X-CRM114-Status: GOOD (  21.26  )
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

On 1/12/24 12:29, Ming Lei wrote:
> On Fri, Jan 12, 2024 at 12:05:45PM +0900, Damien Le Moal wrote:
>> On 1/12/24 10:13, Ming Lei wrote:
>>> Hello Damien and Guys,
>>>
>>> Yi reported that the following failure:
>>>
>>> Oct 18 15:24:15 localhost kernel: nvme nvme4: invalid zone size:196608 for namespace:1
>>> Oct 18 15:24:33 localhost smartd[2303]: Device: /dev/nvme4, opened
>>> Oct 18 15:24:33 localhost smartd[2303]: Device: /dev/nvme4, NETAPPX4022S173A4T0NTZ, S/N:S66NNE0T800169, FW:MVP40B7B, 4.09 TB
>>>
>>> Looks current blk-zoned requires zone->len to be power_of_2() since
>>> commit:
>>>
>>> 6c6b35491422 ("block: set the zone size in blk_revalidate_disk_zones atomically")
>>>
>>> And the original power_of_2() requirement is from the following commit
>>> for ZBC and ZAC.
>>>
>>> d9dd73087a8b ("block: Enhance blk_revalidate_disk_zones()")
>>>
>>> Meantime block layer does support non-power_of_2 chunk sectors limit.
>>
>> That is not true. It does. See blk_stack_limits which ahs:
>>
>> 	/* Set non-power-of-2 compatible chunk_sectors boundary */
>>         if (b->chunk_sectors)
>>                 t->chunk_sectors = gcd(t->chunk_sectors, b->chunk_sectors);
>>
>> and the absence of any check on the value of chunk_sectors in
>> blk_queue_chunk_sectors().
> 
> I meant non-power_of_2 chunk sectors limit is supported, see
> 
> 07d098e6bbad ("block: allow 'chunk_sectors' to be non-power-of-2")
> 
> And device mapper uses that.
> 
>>
>>> The question is if there is such hard requirement for ZNS, and I can't see
>>> any such words in NVMe Zoned Namespace Command Set Specification.
>>
>> No, there are no requirements in ZNS for the zone size to be a power of 2 number
>> of sectors/LBAs. The same is also true for ZBC and ZAC (SCSI and ATA) SMR HDDs.
>> The requirement for the zone size to be a power of 2 number of sectors is
>> entirely in the kernel. The reason being that zoned block device support started
>> with SMR HDDs which all had a zone size of 256 MB (and still do) and no user
>> ever wanted anything else than that. So everything was coded with this
>> requirement, as that allowed many nice things like bit-shift/mask arithmetic for
>> conversions between zone number and sectors etc (and that of course is very
>> efficient).
> 
> Thanks for the clarification.
> 
>>
>>> So is it one NVMe firmware issue? or blk-zoned problem with too strict(power_of_2)
>>> requirement on zone->len?
>>
>> It is the latter. There was a session at LSF/MM last year about this. I recall
>> that the conclusion was that unless there is a strong user demand for non power
>> of 2 zone size, we are not going to do anything about it. Because allowing
>> non-power of 2 zone size has some serious consequences all over the place,
>> including in FSes that natively support zoned devices. So relaxing that
>> requirement is not trivial.
> 
> Just saw Bart's work on supporting non-power_of_2 zone len:
> 
> https://lore.kernel.org/linux-block/dc89c70e-4931-baaf-c450-6801c200c1d7@acm.org/
> 
> IMO FS support might be another topic, cause FS isn't the only user,
> also without block layer support, the device isn't usable, not mention FS.

And if the FS requires a power of 2 zone size, that will create fragmentation of
the zoned device support: some devices will be usable with an FS, others not.
Not nice at all. That is *not* something that exists today, for any block
device. I am not very keen on going down such route.

> Since non-power2 zoned device does exists, I'd suggest Bart to restart the
> work and let linux cover more zoned devices(include non-power 2 zone).

See above. Others (Keith, Christoph, Martin) may also have a different opinion.

-- 
Damien Le Moal
Western Digital Research


