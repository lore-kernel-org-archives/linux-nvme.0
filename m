Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1815C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Apr 2022 21:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZNrBueKTjD7dGBtEbx+EAM6bS8oVowYUPhaEXf+r/YI=; b=a6xPRQzhynTJXwbHwFlfi7Y8AF
	kZ4GXq8m784w62SHB574KTab7QQ5wnyS4fq1zux2tnX4SZIi6tjgL4bvcl7xwsL/cgZHSSH727n1q
	pttmOf2IlyLJlu9TGOpn2hKGB08UlJP+TLyoFIZU6u1PhxkZbn/4mvybiZEw4UoNLmUmdqxUWjnG+
	b5s9B8SpUg5c6kF/i7M/vL4TQgjWqXgKDQSVgzHVy7Taw8gZxj1h3awZFyyvMF3ezkEKBpyNuHSdI
	LgRbIfNzEEHH+OnB+uIDphXqDzP4FNJUh1ykE57lh8coomxNwpL4OYz4QIH/RVQCpqFnCpfwHiXyb
	cMQ3mM/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1njpfL-003hNQ-Cp; Wed, 27 Apr 2022 21:57:43 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1njpfI-003hMM-16
 for linux-nvme@lists.infradead.org; Wed, 27 Apr 2022 21:57:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1651096659; x=1682632659;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=AUyIcwobFfV5SoYGzqqBamGFyyqRQJh2j8T40K6gwpo=;
 b=pHm/ovlvkcgXfXcu442KUwrc8Y+5jThMTlC8fmV+8OK/8pZUfjiu3/36
 EPIGUB1PJoqsYCH5eglpQdEuyyG0i+e0qszKX+I5F/PdgAOh0XZSySlgg
 /yICTBJWN+/CztWeMGvGFYhmbITEdzxGwR9Sk/wKQReAxMR4APnNmP5+k
 djXrZXGWxLJbHG03+5EQURMpe9RBZadzphPPWReBOF4v0TJzJm6G8tfKF
 dh5LAo7Na4yrk7MDgoC1OWcFlBYndUywf95MTrcM+kzeHKIMv6+xdRkAm
 4inPMocExvk03BZW4xgEMLgVTSbVFzOQk19HsKqf+/JtWD+T1LstxRkZC w==;
X-IronPort-AV: E=Sophos;i="5.90,294,1643644800"; d="scan'208";a="303207113"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 28 Apr 2022 05:57:38 +0800
IronPort-SDR: 7ASwaP3VnxsjGQh1SgTYbikxmKN0IUyv2qSG2a22bTfhSPllxyM242VeCj778qClJ452nvJW1B
 wf2gihYv/3hXg8ZkDpE8eSOEeFIJ79d+pandYlH51pnhKnm0rLyV1DqP59zmRzm289RoKTYBeB
 Ro3q6wqOJZnWDhzPY9c9tyYLjLLpXeJfcI+tLgLoI9UYgMMFO/T/hqOA2u+Tynr+L0fr5EGwAb
 n1GlmTTO0hoChIgJwz6yfkpjM+6Cmkulj4uaQ7QRnFaC1747Sf5sIN65yM10ewl8/xbNy5XJO8
 v2jq/mIVDPHhH3PUUXobiANF
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 27 Apr 2022 14:27:47 -0700
IronPort-SDR: kR2e8M+VlWIvi4NUCqRjCNMODHr94gZiZ7MVtH6alhimERAse65EbkJU+d7IKW/qKX3lRVhAj6
 X5ir2WZK/mqA4wWbqjOeq56kj5iU/6OYOZTq2Bwn3E8hwHBN8CR5oVrdV83mNPZKq3iCK5VMYK
 vXZuIwvpvxMOc8VJOet7UC0cA8lyuA0wTiF7+pNUMnDu6aqc3SsvmJIJk3FBjlppkNDPMJ5LsT
 8Qp0xAamjlnavsXkMHT8ClyQflx8StKrjCGlYPNRKXjJQHrKIGryt1fjXMY99wzFAGEc/6JHrp
 7Dg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 27 Apr 2022 14:57:38 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KpXfp2pJCz1Rvlx
 for <linux-nvme@lists.infradead.org>; Wed, 27 Apr 2022 14:57:38 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:from:references:to:content-language
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1651096657; x=1653688658; bh=AUyIcwobFfV5SoYGzqqBamGFyyqRQJh2j8T
 40K6gwpo=; b=PSstadGp5ulB2J+BWMxkaXnwwaZ8yjM0p23ACWCmqaNxmGu2kGS
 C8l6BvptPaomaiRYSqAyEpBwVAZubeO6rdS2iadrzki/hkGC2m6LaHJas2Yo0byY
 b9/2e33a44eeqtMNBaFgpcrEk472ygG6lllz6Td6b0v/IC3Xb6COAp8AGPgaIUvG
 DA37YPM7cc2BTrg4NKQT0+sj6QcAEOlIpxkKWtjy6UKghsbkrYOsdezEtdxNTpY1
 lZjeKqdK16ZbuRaO/nwXFLCpv4KwgJcUyGUvM7/EhO6RzVJtcVZ8NbXkoF2BZzMF
 oWpLBf6y7Wn2PVIlOH20Sd65u7CYkD88S2w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id 9UZz4g8LXxq4 for <linux-nvme@lists.infradead.org>;
 Wed, 27 Apr 2022 14:57:37 -0700 (PDT)
Received: from [10.225.163.27] (unknown [10.225.163.27])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KpXfm4bP3z1Rvlc;
 Wed, 27 Apr 2022 14:57:36 -0700 (PDT)
Message-ID: <ae18fae1-c914-7bea-7c7b-861962b10c2c@opensource.wdc.com>
Date: Thu, 28 Apr 2022 06:57:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v4 01/10] block: Introduce queue limits for copy-offload
 support
Content-Language: en-US
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 dm-devel@redhat.com, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, nitheshshetty@gmail.com,
 inux-kernel@vger.kernel.org
References: <20220426101241.30100-1-nj.shetty@samsung.com>
 <CGME20220426101910epcas5p4fd64f83c6da9bbd891107d158a2743b5@epcas5p4.samsung.com>
 <20220426101241.30100-2-nj.shetty@samsung.com>
 <0d52ad34-ab75-9672-321f-34053421c0c4@opensource.wdc.com>
 <20220427153053.GD9558@test-zns>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220427153053.GD9558@test-zns>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220427_145740_180630_B5DDC98C 
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

On 4/28/22 00:30, Nitesh Shetty wrote:
>>> +/**
>>> + * blk_queue_max_copy_sectors - set max sectors for a single copy payload
>>> + * @q:  the request queue for the device
>>> + * @max_copy_sectors: maximum number of sectors to copy
>>> + **/
>>> +void blk_queue_max_copy_sectors(struct request_queue *q,
>>
>> This should be blk_queue_max_copy_hw_sectors().
>>
> 
> acked. Reasoning being, this function is used only by driver once for setting hw
> limits ?

function name points at what limit field it sets.

-- 
Damien Le Moal
Western Digital Research

