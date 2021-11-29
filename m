Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0B6DC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Nov 2021 11:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H0JXB2aFPw0dUYnivc8qQx12q1DKPscmw026S8Jk2rA=; b=Cc4ieSWd2hLEEPX3FIg71pq1M4
	7J+gguaGs7o828fh5lWfwTCIN5kSj5o/LW58XSCXbplzyFAUGKlp/8XG4Eyx+mZobDEoHt1crAw0R
	AIsiWzUoyrikEUVSET/w4fZfOo+80KmGDapbCh+mc0vVXuwRdbj2woxf2pBBWGOS3Sy1sSJhfbzJw
	16wG+F0e6umLQyrMMeZTzczrozGiz+lAhOEtsaMSKUkt5jnhqH22Sa32sN5ggqC0scPSaWuzS+tZP
	WEuzICPcxeL4V/tCBUaPdGTY9QKGA68p2QCNqQDRZcZIL7UASt3dhPiT0GxyjneaGsDIzu2I54prq
	oG6YW5qA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mreg4-000WMN-Bd; Mon, 29 Nov 2021 11:18:32 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mreg1-000WLq-Fc
 for linux-nvme@lists.infradead.org; Mon, 29 Nov 2021 11:18:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1638184709; x=1669720709;
 h=message-id:date:mime-version:subject:from:to:cc:
 references:in-reply-to:content-transfer-encoding;
 bh=4Nc63BPJv7Pvc+v6SNeYLOPAEO9pBo/wRllT2Mr8apU=;
 b=QHxMIfV6nlWdchkyEBu474dZBOaRDeLtoOltU49HaphR12eJ3/3wD+9Y
 3VsNnLaR7q0LEHzwVs2ZMnVwhH8zjGBJsS+WAEUSd1KvIno2reuqL3sHu
 n/qAH5pb8wB441Euu3kaW53Aw9V9k+0gfm8rZ/3znw1qC7e4fHCGE4C7H
 +dhfH5S6BNtZFPWk5YrQJw71Sv7lNPQSF9x6QzYfAw5Dl2e3eUwG+QXvT
 +sjGJ48PtN3huvdcy0qU35NJD1j95zvHWKX6AxbiuCkGAFg5TG07PrjFo
 RbkWBHafBr20UFSiUJ1YK9diecrUSR9pR+pryfbm4dnEAbh8e1T0e2AwK Q==;
X-IronPort-AV: E=Sophos;i="5.87,273,1631548800"; d="scan'208";a="185937898"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 29 Nov 2021 19:18:27 +0800
IronPort-SDR: hex6jZ4DP50Edag7f3HmvOeDVItKu1oWUSoMfgcjEQBw/y26vH6slPPFRgc4zShHhE9OUI1q3P
 /jSA4SDpdS581lcWjKIbpzuzHylR338qummYYMUN26VbKfrjtnRjugPBa6XJzbdmfuei/l95cp
 DfzzR/nlThTWHXcqKbGnTjX+fdgj4rxH4r0NdYTDZzqPktgyzfmWkaDdwcvP5GrARrlyu/fAXp
 AmvE8iX9dykh8AWoU0kwZHFfFL9JpR2BepwnnelupbD3XCYBZ+3uHFSVwe8ZH7z2FUvH7rLRIb
 QyzpB6EOzDg6nUhjnidXhyMH
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Nov 2021 02:51:41 -0800
IronPort-SDR: MDtegMs3ECk6robk8gmwa2jxNHAToi2F07/J5GVQhO7cey7vX7JfdwRihWzd+HThu5BFqR6Jle
 SNA25KGW3VJ+yfpdq+2nIOz6b4dISxSnDWrfNda1qy6zdRmbGPkPvGKu7v0zVBVnkstcFLIeIh
 729IM8YJ+HGunoEz/G+EtYz5FUpeKv6TbDJXVV1P8l1Nn3rcwY4+f0n/SurlW/FxiaPNDjYbmo
 C5nJz2nZSfvXZ5IKHniiHVnr4OUEGj1vgIjKRFyWOjv9/+NA+JPZtigXeQDNOupCr5Ygmptv2m
 Qkc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Nov 2021 03:18:28 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4J2jX330yVz1RtVp
 for <linux-nvme@lists.infradead.org>; Mon, 29 Nov 2021 03:18:27 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:references:to:from:content-language
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1638184706; x=1640776707; bh=4Nc63BPJv7Pvc+v6SNeYLOPAEO9pBo/wRll
 T2Mr8apU=; b=PReaStNJm16GDAyQBn0XQhi32qAFVDJxY/A4soEcet3DIP1RyQV
 0fI2/8VEMOBOM0hj+mzBRGByxYaQam68jurCbNtSIMF7SQZvMheH9yFcwCfzBAnl
 Qn2mTd32jYz0BEzenzoJgzYI1IN0MdhWZ45/rMvFX5hsI02uwOktmZgDTYxmw0zt
 2b+9o/qc6W4f0av1sQIrFVtsKgY9wIT8br7sTe/nPo/CwXDMxZMGhmetAR1+bE/4
 g/zT0/4/Q8Yk8pcBYASYaEOJxuHUEROHnXaBYH0AK1YcYKSAHd2j0A1oywSdIUhJ
 njh7f71FfE1A0P37b7VM3y9abWtNFiYYFCg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id gRVMEoe1JBwx for <linux-nvme@lists.infradead.org>;
 Mon, 29 Nov 2021 03:18:26 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4J2jX16fRrz1RtVl;
 Mon, 29 Nov 2021 03:18:25 -0800 (PST)
Message-ID: <d612503e-6856-cc3f-40ed-4c487af7feb1@opensource.wdc.com>
Date: Mon, 29 Nov 2021 20:18:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH v2] nvme: report write pointer for a full zone as zone
 start + zone len
Content-Language: en-US
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
To: Niklas Cassel <Niklas.Cassel@wdc.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20211126104157.227400-1-Niklas.Cassel@wdc.com>
 <ef1c39ab-7b56-6a37-0f4f-1ca111d5b48b@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <ef1c39ab-7b56-6a37-0f4f-1ca111d5b48b@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211129_031829_701367_1AEC9BC0 
X-CRM114-Status: GOOD (  27.15  )
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

On 2021/11/27 10:14, Damien Le Moal wrote:
> On 2021/11/26 19:42, Niklas Cassel wrote:
>> From: Niklas Cassel <niklas.cassel@wdc.com>
>>
>> The write pointer in NVMe ZNS is invalid for a zone in zone state full.
>> The same also holds true for ZAC/ZBC.
>>
>> The current behavior for NVMe is to simply propagate the wp reported by
>> the drive, even for full zones. Since the wp is invalid for a full zone,
>> the wp reported by the drive may be any value.
>>
>> The way that the sd_zbc driver handles a full zone is to always report
>> the wp as zone start + zone len, regardless of what the drive reported.
>> null_blk also follows this convention.
>>
>> Do the same for NVMe, so that a BLKREPORTZONE ioctl reports the write
>> pointer for a full zone in a consistent way, regardless of the interface
>> of the underlying zoned block device.
>>
>> blkzone report before patch:
>> start: 0x000040000, len 0x040000, cap 0x03e000, wptr 0xfffffffffffbfff8
>> reset:0 non-seq:0, zcond:14(fu) [type: 2(SEQ_WRITE_REQUIRED)]
>>
>> blkzone report after patch:
>> start: 0x000040000, len 0x040000, cap 0x03e000, wptr 0x040000 reset:0
>> non-seq:0, zcond:14(fu) [type: 2(SEQ_WRITE_REQUIRED)]
>>
>> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
>> ---
>> Changes since v1:
>> - Minor commit message rewording.
>> - Use if/else instead of setting wp unconditionally and then
>>   conditionally updating it.
>>
>>  drivers/nvme/host/zns.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
>> index bfc259e0d7b8..9f81beb4df4e 100644
>> --- a/drivers/nvme/host/zns.c
>> +++ b/drivers/nvme/host/zns.c
>> @@ -166,7 +166,10 @@ static int nvme_zone_parse_entry(struct nvme_ns *ns,
>>  	zone.len = ns->zsze;
>>  	zone.capacity = nvme_lba_to_sect(ns, le64_to_cpu(entry->zcap));
>>  	zone.start = nvme_lba_to_sect(ns, le64_to_cpu(entry->zslba));
>> -	zone.wp = nvme_lba_to_sect(ns, le64_to_cpu(entry->wp));
>> +	if (zone.cond == BLK_ZONE_COND_FULL)
>> +		zone.wp = zone.start + zone.len;
>> +	else
>> +		zone.wp = nvme_lba_to_sect(ns, le64_to_cpu(entry->wp));
>>  
>>  	return cb(&zone, idx, data);
>>  }
>>
> 
> Looks good.
> 
> Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> 
> Note: read-only zones also have an undefined wp. So I wonder if we should not
> set the wp similarly to full zones, to match the fact that we cannot write to
> these zones. Same for offline zones, but these are tricky since they cannot be
> read either, meaning that wp should be set to the zone start for that case...

Thinking about this some more, I think we should do nothing. Reaction to RO or
offline zones will always come from an IO error path, in which case, it should
be clear to the user that the zone wp is invalid/undefined. E.g. zonefs has such
IO error path.


-- 
Damien Le Moal
Western Digital Research

