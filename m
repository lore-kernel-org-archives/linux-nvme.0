Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFE9AC352A1
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Nov 2022 09:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nr3C6aRtazkcSwEZXaSHMymK8NK18HA5JswK5oxCw8c=; b=FcqYNEENQ0Sq6y5Rw1VEG5szpm
	ltPz9Yt4AtD0TqHv/lgId4WLurSme6EQMqcZkYbz9ZLErX4HVZj3bGhPvRT5OmHkM9vwxHyIO33Aj
	nvW94PO4SLNT8j5TeV83xYCz8QPx90e3PFN/PlVDKK8RzHwwk7cehViF8gUI73ho2VEwF2jJQf00n
	9JtYd3lUaIqoKliW7iV0B6NGl/6OstYchneRTI5+e1T1rXvdFHmBnuvv2Yz5rTFIk/FQOL6blraPV
	ktd79+t5FjpI/GIwJkSzihtwiahBxTw8jrLl5L7/lSIRr/Aonc8nPtReVWWhDgv3lYd8S7CQtrfO+
	mgzZqZXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0JoM-00FGRM-5U; Wed, 30 Nov 2022 09:55:26 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0JoI-00FGNf-8W
	for linux-nvme@lists.infradead.org; Wed, 30 Nov 2022 09:55:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1669802122; x=1701338122;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PfmM6a5gkT8LDyP+3VBEQwikCCOkyxOtDnm2zOUOXHY=;
  b=i+aTF8Ki45cAFgowgdJdpbE04dldbXHUqGErsLqFJd/ygVuBYV5NR3JY
   yP5x6t+nhUCHJmV4GUSUiv/rvPW/s4MV/u4e/xOg9wnsgjL9g4nUGuJo4
   a935zhGelLBX3sogj7JPoiRWc8oJ/WwZNxfDE5hsoDKcFbvFYWPuXQFXp
   TGSVvqkgKUxCOG2+7hVaiW6d7dKauUy/+LRRRf4HOyYKXpxPfqjMhMERK
   zp37tjEZ3qflXTY63OAXG/hNrj2bc/40qM0BwHvk898yWWQx1Gwysz/97
   gHTbE25AoLQXOxfLq2nUysZcfOrSy55WJZelPn72Vps2M5AoHKawAKbFP
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,206,1665417600"; 
   d="scan'208";a="217538416"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Nov 2022 17:55:17 +0800
IronPort-SDR: IPRK22cDiJot6LtEPi45BElVdHEzqvASt4XfJoCTuB10NsFzySYDEwf2kOLyp9tNNRqp8zcbZL
 41b1np3C71PGbLFakCRMMIwceLOUiejrmTylP0XZjMeuNpbBxIISrCwl7aPm8j8ThW7dT4lFpV
 8Kc13FqHihkTwfOUHMeAkORsFiK2ylo/BHHyZa9F8nyhSkrkoQjFl1ivkK3+x2dK/6xahqTu1O
 EUZl9/vB98zAlTbu76L4hG14nno60QODhTK2cB/Yv0FYreREg5pCEWR9pJZJGBVrzkaBS5G/yA
 V6g=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Nov 2022 01:08:12 -0800
IronPort-SDR: h279I9y9EpUe/NuUlWLiinuShUO+X3GmMUVsk6/gQZ8nzkVVaa1aAfpJ96gzvhu1qqPj9vjO4K
 FAzCRuMCjGOB2kmSa3GNS6beXmYowtdMQqqVsvTU3GrDrZUdW6BHHIhOxexYjaiBGbmZ1/812u
 ZIFTOIsw2oHQ3VsCutzIM75w/+5ifWWtwqFOSuERQSlhbE7yVJHFutC4hHqTAG0LYLL0mUglP+
 k539d6d+W1xVs3VAtLfJaFUUvlxJNxF4NveHC5vlKpHFJ28h58DTvuustVVlZe3kW3rfSWBeN2
 NrQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Nov 2022 01:55:18 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NMZM91Lmwz1RvTp
	for <linux-nvme@lists.infradead.org>; Wed, 30 Nov 2022 01:55:17 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:references:to:content-language
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1669802108; x=1672394109; bh=PfmM6a5gkT8LDyP+3VBEQwikCCOkyxOtDnm
	2zOUOXHY=; b=WO70GxcfoJkaidzfqKTpf6XdrSJR92gGBcqtVjjWImgnNKJFA3C
	1qQ9Pac2+l9iEMRSkNYcb3YtQr2CmP64cVFOL1AzWKkAattcadn9VRgdDzzu3sYw
	a+b7n0DmPMTxgPx0L+moOK5KuWtWefFwiMikDVPA+Rm9ccaiG+TK/Gt1Nscesz8s
	zfjKvyMMqoH4tmasBu11mn7xan6xxRBhghlPHoQ+BCXda+WI3SAj0t1z+JF5L3w+
	lOZ1r/wbs/0FcsfgTQXKDer3VH0RggQmo59VaOB/EpQKyYPqFr39FgByPQi74sIu
	yFIjzvJNf44Tp2JxaVnhNqH5C0oypUoGLzQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Pmcj_5MmBFsm for <linux-nvme@lists.infradead.org>;
	Wed, 30 Nov 2022 01:55:08 -0800 (PST)
Received: from [10.225.163.66] (unknown [10.225.163.66])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NMZLx09szz1RvLy;
	Wed, 30 Nov 2022 01:55:04 -0800 (PST)
Message-ID: <1ef5747a-9469-4365-ffc9-05daa6f69288@opensource.wdc.com>
Date: Wed, 30 Nov 2022 18:55:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v5 10/10] fs: add support for copy file range in zonefs
Content-Language: en-US
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org, dm-devel@redhat.com,
 kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, james.smart@broadcom.com,
 kch@nvidia.com, naohiro.aota@wdc.com, jth@kernel.org,
 viro@zeniv.linux.org.uk, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, anuj20.g@samsung.com, joshi.k@samsung.com,
 p.raghav@samsung.com, nitheshshetty@gmail.com, gost.dev@samsung.com
References: <20221123055827.26996-1-nj.shetty@samsung.com>
 <CGME20221123061044epcas5p2ac082a91fc8197821f29e84278b6203c@epcas5p2.samsung.com>
 <20221123055827.26996-11-nj.shetty@samsung.com>
 <729254f8-2468-e694-715e-72bcbef80ff3@opensource.wdc.com>
 <349a4d66-3a9f-a095-005c-1f180c5f3aac@opensource.wdc.com>
 <20221129122232.GC16802@test-zns>
 <b22652ee-9cca-a5b1-e9f1-862ed8f0354d@opensource.wdc.com>
 <20221130041728.GB17533@test-zns>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221130041728.GB17533@test-zns>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221130_015522_364462_ED3683A1 
X-CRM114-Status: GOOD (  13.90  )
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

On 11/30/22 13:17, Nitesh Shetty wrote:
> On Wed, Nov 30, 2022 at 08:45:55AM +0900, Damien Le Moal wrote:
>> On 11/29/22 21:22, Nitesh Shetty wrote:
>>> Acked. I do see a gap in current zonefs cfr implementation. I will drop this
>>
>> cfr ?
>>
> 
> yes, will drop zonefs cfr for next version.

I meant: I do not understand "cfr". I now realize that it probably means
copy-file-range ? Please be clear and do not use abbreviations.

-- 
Damien Le Moal
Western Digital Research


