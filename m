Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 243CFC433F5
	for <linux-nvme@archiver.kernel.org>; Sat, 27 Nov 2021 01:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5PsMUD5vB6DEoL1+b/HsMANcJYUzsfwwrGOJoqujPe0=; b=MNUCc5NS2oTJt25+qO6Hpg8Qq0
	gWEfyyCvHcuVwmEBuBmhAqXzIwjAruXtunKrffoNRHZUvDpRqZcmzZUKgQCFAaHKRkvAX23GE8ZEh
	PicM3e+D1fyUg1YS9MZSOCxLNTNZrmFDsO4Vt8xItOnyNZBGDs0Tg32OGdJz2aunTqFQFrNvfH+yQ
	n5Megs6y8aWEWbRX/hdIKTf0yWvkFfYyHxh+vaQCZ+3ptmGqOjms7xAIgXvakTjSJz7J29VJ6Arxo
	zwVfjt4DfuWH/Yu27vANkZklCc18p0HMTav2n2O7Mequ/x6E/Iqnm4iUwg+gDWyswAPHSvYeQ56Nw
	RYoOxmUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mqmCo-00C6Vf-EP; Sat, 27 Nov 2021 01:08:42 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mqmCg-00C6VL-Tg
 for linux-nvme@lists.infradead.org; Sat, 27 Nov 2021 01:08:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1637975313; x=1669511313;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=JeEh0wBirBhWicGL8pepRh1yqbBvRlV2EWUTRaq+jHY=;
 b=VEhqQc1tuZxXZxeGNrggg/gU7Dcigi1QhPeBEk+BcsCLN9eBSNJqT4q9
 cGv+i7JtIHUI38ArKVXG0bl+WL91oWrDYiFaMQm+C4nRddwTymMrVn6hl
 YoC8T5pHAJ8f3OGYLN5yeHZc+ePKAXm3IP+D0OTMbVzwOqTIx6qn6x0VY
 yBPvZ2G7vJCg4uzlYB1bRLdxDeLym0VogpfLaJUzIUwyi1RSIELSfSNcr
 MLVVDgXs5w7H7x5ZrYXzCF3peJK/ZLfMnG9kFzgfY3nt7QvixzdyEXp/G
 kHQiAnRPLwjwW940elfH5EmSM2RqKy6cT+vlCgewQUh4PudIWGjNrAlZc w==;
X-IronPort-AV: E=Sophos;i="5.87,267,1631548800"; d="scan'208";a="186780746"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 27 Nov 2021 09:08:31 +0800
IronPort-SDR: o5iLvhpKouhqF7JEnd7d25BQxTQnkowpeftnQWVjz9NEg+IVt3DgJYF9MW15FHz83OleOOeacm
 ZkMeh3WjQOMhr4+cO2HrVg8gDTRIV0cQgLmIiOD+0+okqFV4taDLacbtrcnGvkEsDBJkvZ6ZJ0
 jExtjqarYH0x/GeFn8vqoNa+boG9Ly01bb5Tf0cAW+C6+fxOsyYqWa8bim2RtfjVGZviIPNmcJ
 aJ9UHYCmYYb9hI1BysLH9CvO8RoGDERft3MMkEfnJBWZWku3asSP1ax2Fm7e2ECad8muX1vsNo
 6xA7pbTir61KhlENNpfm+Zsf
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2021 16:41:49 -0800
IronPort-SDR: a5UtpPpXBnDt5EdEAoSgOZqZS2WfI3d31RSStRT39noDbCZDmvzQ+ebs25vTJkQ7ZJVhZ+8Cy+
 bEiW4RCu5e69nXNpbym/3YIYS71L4VNnx6i7i686MICW3FO9JPQdqdJvOfRT018fZwoYXmUMlf
 H5TipZFislKSj/s18GOIZcemFyYFDhZkrmAjy3kxVxcP56wTHSJs8y9BgWYB3mL+yizgPLHmMJ
 h2AyTZCYkZo33+eDMYBUcKURcbQdyD3hqQCMgQVvG/TJVMIQEYcw1l9D0KJ7hexP/FuhUSa8Fw
 r1Y=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2021 17:08:32 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4J1D5D0Crbz1RtVw
 for <linux-nvme@lists.infradead.org>; Fri, 26 Nov 2021 17:08:31 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:from:references:to:content-language
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1637975311; x=1640567312; bh=JeEh0wBirBhWicGL8pepRh1yqbBvRlV2EWU
 TRaq+jHY=; b=pMVAustdvyr0Mz+RxNV5LsZrFPm9QgKAQb0IG/aGJxfxtHVY+w3
 H2BxSMK++OVJ2+Oxj4xW3u2QJDZRTSpkEOXlIHsF+Y1/vCVQaRYElLyJ7yDo1o7r
 HU1cDXloVUHGGp1NlIL6wuPYIzvdaJxRy4+k0WzyhfWuYaExujnoA4PzrN/NChcs
 a8HvHZvZ0gFpgfKwqw8Rs+naEg6jliUgiZc6KBW4N8/R18Pi+fltwF3i69oW84eO
 dYd34uLRmskRRNUZz0ECbmOUsgutSRipVCo6bl62tUZaDiUFbfTtC5C3uO71+wtr
 D703sBjmg459d0cOSJeEcJ0z0yQ3PClyqdg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id y5VBhGyzvi6y for <linux-nvme@lists.infradead.org>;
 Fri, 26 Nov 2021 17:08:31 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4J1D5B1dgQz1RtVl;
 Fri, 26 Nov 2021 17:08:29 -0800 (PST)
Message-ID: <ef1c39ab-7b56-6a37-0f4f-1ca111d5b48b@opensource.wdc.com>
Date: Sat, 27 Nov 2021 10:08:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH v2] nvme: report write pointer for a full zone as zone
 start + zone len
Content-Language: en-US
To: Niklas Cassel <Niklas.Cassel@wdc.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20211126104157.227400-1-Niklas.Cassel@wdc.com>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <20211126104157.227400-1-Niklas.Cassel@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211126_170835_039141_A1EBC2FF 
X-CRM114-Status: GOOD (  28.89  )
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

On 2021/11/26 19:42, Niklas Cassel wrote:
> From: Niklas Cassel <niklas.cassel@wdc.com>
> 
> The write pointer in NVMe ZNS is invalid for a zone in zone state full.
> The same also holds true for ZAC/ZBC.
> 
> The current behavior for NVMe is to simply propagate the wp reported by
> the drive, even for full zones. Since the wp is invalid for a full zone,
> the wp reported by the drive may be any value.
> 
> The way that the sd_zbc driver handles a full zone is to always report
> the wp as zone start + zone len, regardless of what the drive reported.
> null_blk also follows this convention.
> 
> Do the same for NVMe, so that a BLKREPORTZONE ioctl reports the write
> pointer for a full zone in a consistent way, regardless of the interface
> of the underlying zoned block device.
> 
> blkzone report before patch:
> start: 0x000040000, len 0x040000, cap 0x03e000, wptr 0xfffffffffffbfff8
> reset:0 non-seq:0, zcond:14(fu) [type: 2(SEQ_WRITE_REQUIRED)]
> 
> blkzone report after patch:
> start: 0x000040000, len 0x040000, cap 0x03e000, wptr 0x040000 reset:0
> non-seq:0, zcond:14(fu) [type: 2(SEQ_WRITE_REQUIRED)]
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> ---
> Changes since v1:
> - Minor commit message rewording.
> - Use if/else instead of setting wp unconditionally and then
>   conditionally updating it.
> 
>  drivers/nvme/host/zns.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
> index bfc259e0d7b8..9f81beb4df4e 100644
> --- a/drivers/nvme/host/zns.c
> +++ b/drivers/nvme/host/zns.c
> @@ -166,7 +166,10 @@ static int nvme_zone_parse_entry(struct nvme_ns *ns,
>  	zone.len = ns->zsze;
>  	zone.capacity = nvme_lba_to_sect(ns, le64_to_cpu(entry->zcap));
>  	zone.start = nvme_lba_to_sect(ns, le64_to_cpu(entry->zslba));
> -	zone.wp = nvme_lba_to_sect(ns, le64_to_cpu(entry->wp));
> +	if (zone.cond == BLK_ZONE_COND_FULL)
> +		zone.wp = zone.start + zone.len;
> +	else
> +		zone.wp = nvme_lba_to_sect(ns, le64_to_cpu(entry->wp));
>  
>  	return cb(&zone, idx, data);
>  }
> 

Looks good.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

Note: read-only zones also have an undefined wp. So I wonder if we should not
set the wp similarly to full zones, to match the fact that we cannot write to
these zones. Same for offline zones, but these are tricky since they cannot be
read either, meaning that wp should be set to the zone start for that case...


-- 
Damien Le Moal
Western Digital Research

