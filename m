Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30D7CC433FE
	for <linux-nvme@archiver.kernel.org>; Sat,  1 Oct 2022 00:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/OPnFwMXp4MthxK0p6Qc7SOdevksy8NVFGtOASvAaY8=; b=YKBvV4FbOW4GQPvB5YxqSTRZSV
	/LXYl378+cfYe6yMNrKM8S/rwGMVvwIHjSqHvcFR7+pIKbnV5N6TBnpRuv7P0zNuaFA8SSyLd4hix
	jVEqq0ICwhpH/bLtCk2eNcJs/umR8WH5F/BUu5UgGS+o3Z62qeavta9qVOJqjXj+lMAgKecWi23m8
	p67Zc61foNGhPCgVmlTgMLaR9KhnqZKxGOTtero4iKQ2ldFOe40fZslM8RZOYInnFgE3fIHrwrHek
	I3DyB8PPWVt+xkzOgaVgh8i4VdvMS/iAJgxKEX/+6EV82AknC0LjBR6/h41WlCMbprzeWgCeeCl/U
	r9GSiBzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oeQd9-00CLHG-OP; Sat, 01 Oct 2022 00:45:23 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oeQd6-00CLEi-Bs
	for linux-nvme@lists.infradead.org; Sat, 01 Oct 2022 00:45:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664585120; x=1696121120;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0k8Omvocy/Lmn1JNbD0D6pTNgD8xKFYnwKObyBLyY3Q=;
  b=LcJ2Lwnf/2fuVnv4WmLTwqhr0+dQe/oXx/5T6YSjY3F+dWsgpnLVq4Qn
   9ogb9XAoe5V/jcWbIfD0I1OgrPf+5ayGtS5ZcnlixAbY6ARgHPBHisufO
   2sNOZOqcQbJxltWPpbD3h2VgC+Ljb9Srri1795c7kUY2CZMpLMhichszo
   AMUEwP0Qr/nja+AIG7EW5qLVDwFQv5+KSZq9fJkbouvhTe8XtIUbcAHWC
   Y+KJ+p+Iq7LNi/xzj/g21trvkdoaZbyeat50q5zFASvvTYWYzYI0v7QBH
   v+YAhqlUPbM9fxo84AgV1zLZuK5UycGBC6Ui4ev5CfAp68TuvMeuTPWr2
   w==;
X-IronPort-AV: E=Sophos;i="5.93,359,1654531200"; 
   d="scan'208";a="213116206"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 01 Oct 2022 08:45:16 +0800
IronPort-SDR: CWCFfvUzGZZvj0S0f+D7HMNHbRdkdnJ+C/DfGF03kiNc3AacYX3p5+vMaGHC6xtR9ijWENbJzy
 j8d9OlLfqjTa5dzwofx9jNq84LJnACeG/O2OM4GnOYw5Rg/h1pSqNuKQTcnk39nu2UUbwfhofj
 3bMaafnPtG+UYxZZ7J0lwLBF9aUvqLz/UC54kcb09IUUMXezkmSx00lNCWGnFb5+udUwROXgCe
 ieMiKhIaayxLgmbngtxti9nTlpUDljkYU9lxHYbFEwDIF45Zr3NDvqjIY4rBWZos+tts+757/v
 SxzoTSkQmGIvShdudddT4dvp
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Sep 2022 17:05:09 -0700
IronPort-SDR: p9XsClJ2SdotBpIS7tS6SKSPmSMcpijh1hSoKvZxAaWFyrFGaPPgGuuYuYrUmTg9vYTF2pZTYx
 AVQAFB/1VcLoT7w+KRsiZDVBjW1igQGpOwldspZNg8U98DbfgO8Ge0UXm851UTjZLcI0SopWs6
 KLbYZ6q4fC40vYP9yxjjCv830jdpMrA1gYz2rDGFtwfHYLi2bia3fNUTHX75S8VLOEEcM0cvl0
 rVIPD5nhoMfwcJ+K4ofiafHEuYCH/BPagYHRt2nVaw4RikqHg0MK9a6hcxCxehja3duFuYDKZi
 oqk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Sep 2022 17:45:17 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MfT0D3ydmz1SHjy
	for <linux-nvme@lists.infradead.org>; Fri, 30 Sep 2022 17:45:16 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:references:to:content-language
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1664585115; x=1667177116; bh=0k8Omvocy/Lmn1JNbD0D6pTNgD8xKFYnwKO
	byBLyY3Q=; b=TBmgxUD6GnERjJmdq/0e0i+8yyLf3pp02kEDYv4DrQaFwp/O95E
	D+qy3e2Uo87AHw1O34ZcgRE4Zlvrggr1hP2DdqpE6ihqkKd+3wMtDyqp5HPHXef2
	PG8ulQHC7ut9HCxTvuSaNTqWuRb+F7nMkdNuLqGCpwzB47XZpTqwILKVVARsbsmw
	pdXs48ruVM7tKnCAIMze46IRWrk/AhxTr0fSnA6fbmzB5Ioof7WfHOETwFrUUIap
	iX73D1EoSLUH2PCw7/fX+uCpz3CEaeP9wnUBDUfsb0k7G8LM2/Jz76KhfBBTDFlW
	uDGkZbNTsPzlXsWya34a2a72rMhzYcB+fUQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Hmn0A6L0z7WA for <linux-nvme@lists.infradead.org>;
	Fri, 30 Sep 2022 17:45:15 -0700 (PDT)
Received: from [10.225.163.96] (unknown [10.225.163.96])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MfT076V2Xz1RvLy;
	Fri, 30 Sep 2022 17:45:11 -0700 (PDT)
Message-ID: <bb2b3784-422f-fc82-e5be-e4d24412e21f@opensource.wdc.com>
Date: Sat, 1 Oct 2022 09:45:10 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v15 00/13] support zoned block devices with non-power-of-2
 zone sizes
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
 Pankaj Raghav <p.raghav@samsung.com>, hch@lst.de,
 Keith Busch <kbusch@kernel.org>
Cc: jaegeuk@kernel.org, agk@redhat.com, gost.dev@samsung.com,
 snitzer@kernel.org, linux-kernel@vger.kernel.org, hare@suse.de,
 matias.bjorling@wdc.com, Johannes.Thumshirn@wdc.com,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 pankydev8@gmail.com, dm-devel@redhat.com,
 "Martin K. Petersen" <martin.petersen@oracle.com>
References: <CGME20220923173619eucas1p13e645adbe1c8eb62fb48b52c0248ed65@eucas1p1.samsung.com>
 <20220923173618.6899-1-p.raghav@samsung.com>
 <5e9d678f-ffea-e015-53d8-7e80f3deda1e@samsung.com>
 <bd9479f4-ff87-6e5d-296e-e31e669fb148@kernel.dk>
 <0e5088a5-5408-c5bd-bf97-00803cb5faed@acm.org>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <0e5088a5-5408-c5bd-bf97-00803cb5faed@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220930_174520_551446_A405C0EF 
X-CRM114-Status: GOOD (  23.02  )
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

On 10/1/22 04:38, Bart Van Assche wrote:
> On 9/30/22 08:13, Jens Axboe wrote:
>> On 9/29/22 12:31 AM, Pankaj Raghav wrote:
>>>> Hi Jens,
>>>>    Please consider this patch series for the 6.1 release.
>>>>
>>>
>>> Hi Jens, Christoph, and Keith,
>>>   All the patches have a Reviewed-by tag at this point. Can we queue this up
>>> for 6.1?
>>
>> It's getting pretty late for 6.1 and I'd really like to have both Christoph
>> and Martin sign off on these changes.
> 
> Hi Jens,
> 
> Agreed that it's getting late for 6.1.
> 
> Since this has not been mentioned in the cover letter, I want to add 
> that in the near future we will need these patches for Android devices. 
> JEDEC is working on supporting zoned storage for UFS devices, the 
> storage devices used in all modern Android phones. Although it would be 
> possible to make the offset between zone starts a power of two by 
> inserting gap zones between data zones, UFS vendors asked not to do this 
> and hence need support for zone sizes that are not a power of two. An 
> advantage of not having to deal with gap zones is better filesystem 
> performance since filesystem extents cannot span gap zones. Having to 
> split filesystem extents because of gap zones reduces filesystem 
> performance.

As mentioned many times, my opinion is that a good implementation should
*not* have any extent span zone boundaries. So personally, I do not
consider such argument as a valid justification for the non-power-of-2
zone size support.

> 
> Thanks,
> 
> Bart.
> 
> 

-- 
Damien Le Moal
Western Digital Research


