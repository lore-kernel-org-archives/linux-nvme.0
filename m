Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E779DC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Mar 2022 07:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xaQbNnml7OINWGRC4mr9BPsYltCL5c+p6aE0bzYVPrQ=; b=v/oyTazZlXSs50/JeyiexPO1Ud
	mzCSJa8rCVmgIeEv4C/9KAZ9WEEtPzI+6+UCAqYvvq55JAwVtJ6nc4JuwcaXJV/5q3VIpzVOSmD+b
	pMDH5hdU8PTK7BWn2PAitXo7u6ZBtD4AubOz2nvQOX0DCkgasjigk6bphuJ4XojFIZSiqhd2fTDln
	M6EBheFZJeykKFVo4HaZ1nw1/6NGHeOdhQ+d4bz9fLkkw9cnPa7slEYWCNnRbC1zVHwistT8j7BrA
	6KVmCR+GCHAMdSTeK/6KcF0Zt+pxgkXug90hyEnrwYm5nO3duxZROSMA0Y5dmQTLeYWYX+Kszkss7
	gIosTiJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nTfOS-004D1T-50; Mon, 14 Mar 2022 07:45:28 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nTfOL-004CxI-3H
 for linux-nvme@lists.infradead.org; Mon, 14 Mar 2022 07:45:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1647243920; x=1678779920;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=V+3KYbua71jUhDORfVa83LVFcqf30QkwdJlYrkUTcVY=;
 b=f7g0qCcbtzG2DhKvGBb36VGzILpGq9zOPbXKwX3ZpZXUSL5sMItaMF5e
 CAUEjOr+I8NaWRtvXlj2N/T1DH2bKnmREeBgzYH4PnCQ0W417mcKDqo8E
 vK3EVhULMO/wuxwN3EzrkWemI4Gm2tQf2wQwpTtc5Jir13cKIp29idu4g
 gFZOo/rwIGFlGFFvFHYYdXdGsfNSvMUi34eWx8sCYCIX4CAT+GJSaUqHH
 Zudb2snjXfaz5Dh7+v/H6rZG2/DfhMC+fXA1QI6MbEUj10WvPoSZssDs7
 g+mjB/cD2dBnVILNMXZMLLx05EgZpa554xY8ELycY15t/437N0G08SEhK g==;
X-IronPort-AV: E=Sophos;i="5.90,180,1643644800"; d="scan'208";a="195284832"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 14 Mar 2022 15:45:16 +0800
IronPort-SDR: rIhdwrgaReWk2wvok8UiDwDObwaZvNdq+riIbSYjoeHG4KYAISgLJVurebnVFW7uFfcGhQrA3F
 WXuVVvU1A+bYCO8NR9crdQlGIwGBa02gVXbPXmRtOlQSURwHlyH24EEHOwsTHIVFf0UcW8mU65
 NmqRUp2ffPxacnzhSbO86jWt/hhuUwbwjHQxUDfqAkf/uCbPyRAtpKFp1BfgcJPhZIVBFdrBRk
 dhzCqKdC5a4UwFHtX4ND49DelqrX3i/XCxUMZvmbmFUpzyxAqb0TvjERwNrZTvRE8zQBLvxBQH
 BsPh5Gy+PUrSO+wmNTowA7uy
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Mar 2022 00:16:27 -0700
IronPort-SDR: DAf7vDlbd2IEu0BLJigFAlA331pDimsztjQwcOhTbAeTesXfgdaAOVkZvpNX/zXPSNJQPV9Op8
 SmQ37Be/M6gO/lhwtaTzOXoaBdD70jJy4MrxZpRF6NVZAR9Ef7j7G4OBDtn88wqBTetWA8qxZ0
 p+beO6GWMIlAmxeZl2+rl4l2sMlVpTTqpATvb8QdHwirYKVaRnk0q0o5gXTqBFI0wbDUMxC8ZG
 IXuzC1YYzUUkIWq2ViWCIibPhlSJT5Y13LTDnhSmPRJb5vBW/PevbsoTDEnpr1NwLomqEzUWet
 voc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Mar 2022 00:45:18 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KH7qd2XXRz1SVp9
 for <linux-nvme@lists.infradead.org>; Mon, 14 Mar 2022 00:45:17 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:from:references:to:content-language
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1647243916; x=1649835917; bh=V+3KYbua71jUhDORfVa83LVFcqf30QkwdJl
 YrkUTcVY=; b=EMSCGg1vtL0OMQ/pQyrqZ4MRLnBRNNTLlzCjQCXidNdkUDKkBw6
 qyH28PZg+fBtAFung3UsyKTIaZPo54azKyNG6YLyanojXFDdNTJKv0Rph8ndIzAJ
 MIJv+xuBsOf/agIrLHW1AqyYiF2Qv0yqKM64duyq1TBSDlQIP6MPZ5JVx/NDwzxD
 quPhQ70zGgKhEpyNqGrXpKCGt7gzSSiHZH12EKQZlxSx8Jl4GqXKzHMHsj/gDm/k
 EpcyQF9C2jTXDKRUkTasZBCsC0y3+VUNTSYv2X20maqahraz3Gnbr3yljxPILLIZ
 prTxrrBGLP0U8jGIycrI/jmut+eNqvbYsdg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id 76f21Wt0Eelr for <linux-nvme@lists.infradead.org>;
 Mon, 14 Mar 2022 00:45:16 -0700 (PDT)
Received: from [10.225.163.101] (unknown [10.225.163.101])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KH7qY5yctz1Rvlx;
 Mon, 14 Mar 2022 00:45:13 -0700 (PDT)
Message-ID: <05a1fde2-12bd-1059-6177-2291307dbd8d@opensource.wdc.com>
Date: Mon, 14 Mar 2022 16:45:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Pankaj Raghav <p.raghav@samsung.com>,
 Adam Manzanares <a.manzanares@samsung.com>,
 =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>,
 jiangbo.365@bytedance.com, kanchan Joshi <joshi.k@samsung.com>,
 Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 =?UTF-8?Q?Matias_Bj=c3=b8rling?= <matias.bjorling@wdc.com>,
 Pankaj Raghav <pankydev8@gmail.com>, Kanchan Joshi <joshiiitr@gmail.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20220308165349.231320-1-p.raghav@samsung.com>
 <20220310094725.GA28499@lst.de>
 <e02dfd21-31c6-95b6-1127-3f18c79116ee@samsung.com>
 <20220310144449.GA1695@lst.de> <Yiuu2h38owO9ioIW@bombadil.infradead.org>
 <20220311205135.GA413653@dhcp-10-100-145-180.wdc.com>
 <Yiu5YzxU/PjxLiUL@bombadil.infradead.org>
 <20220311213102.GA2309@dhcp-10-100-145-180.wdc.com>
 <YivMBj7+j/EZcMVV@bombadil.infradead.org>
 <bc0e53a9-f623-c69f-002e-d62e697a43d1@opensource.wdc.com>
 <20220314073537.GA4204@lst.de>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220314073537.GA4204@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220314_004521_237226_924F1A2B 
X-CRM114-Status: GOOD (  29.16  )
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

On 3/14/22 16:35, Christoph Hellwig wrote:
> On Sat, Mar 12, 2022 at 04:58:08PM +0900, Damien Le Moal wrote:
>> The reason for the power of 2 requirement is 2 fold:
>> 1) At the time we added zone support for SMR, chunk_sectors had to be a
>> power of 2 number of sectors.
>> 2) SMR users did request power of 2 zone sizes and that all zones have
>> the same size as that simplified software design. There was even a
>> de-facto agreement that 256MB zone size is a good compromise between
>> usability and overhead of zone reclaim/GC. But that particular number is
>> for HDD due to their performance characteristics.
> 
> Also for NVMe we initially went down the road to try to support
> non power of two sizes.  But there was another major early host that
> really wanted the power of two zone sizes to support hardware based
> hosts that can cheaply do shifts but not divisions.  The variable
> zone capacity feature (something that Linux does not currently support)
> is a feature requested by NVMe members on the host and device side
> also can only be supported with the the zone size / zone capacity split.
> 
>> The other solution would be adding a dm-unhole target to remap sectors
>> to remove the holes from the device address space. Such target would be
>> easy to write, but in my opinion, this would still not change the fact
>> that applications still have to deal with error recovery and active/open
>> zone resources. So they still have to be zone aware and operate per zone.
> 
> I don't think we even need a new target for it.  I think you can do
> this with a table using multiple dm-linear sections already if you
> want.

Nope, this is currently not possible: DM requires the target zone size
to be the same as the underlying device zone size. So that would not work.

> 
>> My answer to your last question ("Are we sure?") is thus: No. I am not
>> sure this is a good idea. But as always, I would be happy to be proven
>> wrong. So far, I have not seen any argument doing that.
> 
> Agreed. Supporting non-power of two sizes in the block layer is fairly
> easy as shown by some of the patches seens in this series.  Supporting
> them properly in the whole ecosystem is not trivial and will create a
> long-term burden.  We could do that, but we'd rather have a really good
> reason for it, and right now I don't see that.


-- 
Damien Le Moal
Western Digital Research

