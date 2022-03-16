Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9324EC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Mar 2022 01:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0itwzaam4/XcENr6fxxZrti4pF8mDb4bPlEKxbmPjG8=; b=sd6S5AGAIeucjTGlgthpVabDnt
	Z+vJZFH7K/CjA0jHSGxpuVI62ZDcHmIAP9zVinvOVNBx/+yaemZCZXUtMbpsNP+9/ucgLfH6WI+iJ
	TToH6XM1+z3Nxax9egF0cvXu4/bvmOaWUOVziHN+uBuDfbZuaD3Okk6mDHiRfddlVf4qdffTqk9b2
	nLjRFwbDDbCRFXMz5YEvya1zqpi3dWDarfZFIb8d5fZcQg6lkXuC/WQlea4z3vh3+7GFBSpwlHMMN
	dBzDeP3gUo7nTVmJOns/UPkrFC6WHV8/vEjmE0OKsd3omBBoFqj7gY0blV5meTT2fTMLAox2XDXAH
	8oeSUN+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nUIip-00B6Gg-OD; Wed, 16 Mar 2022 01:45:07 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nUIim-00B6Fs-Ni
 for linux-nvme@lists.infradead.org; Wed, 16 Mar 2022 01:45:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1647395103; x=1678931103;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=BUDKqmZbcVaCzgnu+xxYVNx0j3TydSNyBEHMbCgsSwY=;
 b=jOrypReGI0qRevlSYNXTh+w/nxdh3YifEfQ2fipi3G8q9d1CG2m6YfqL
 yqUAdDPLdFRsvdyHswn0xFtDiusPnVUy9OPS6OT4TXY7j4H8lrep5e8Sh
 KGYxpd2YHh4LVi8/cVk/MiM9YQnltw5V0y2m71JZpACQgmxfWAna+lPTm
 qDHvb5OFeUj1Ry6wxW/jYktvD8BDnNgp6PKznMTx6kyxZVRTA0VzJ+JQN
 cr2YYFOwQOLQme9Qwc14ZYqBI9NR6VMs/CjtIbEJbNrSWsm2fnq5BfTLl
 3LOZ7eTSFtuOhikuB3tmM5G3Lj2zUexFemx9JkLd05D3aWj83/NENWK3N w==;
X-IronPort-AV: E=Sophos;i="5.90,185,1643644800"; d="scan'208";a="195461089"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 16 Mar 2022 09:45:00 +0800
IronPort-SDR: JcSS6UV/ytPShcX6Xf+hUG4HNL8lcBWkjlajwXEkVj1T/HcSV0MCUMwFF0PAnPmxa+EJRAguA7
 lizECQHizElS9RQwLRZcpb5RkYjn5j5aIUEubgAfl6tExtaW2NMHCMPsdd3QHJjkyTcwqyuYuE
 mOyRihIFg+01Wrm7I7CZ4vVihNc8kOPkv9/0X4PxzDZgN1MqVIZHWqHjyvrl1beD9Vqmu0jdXh
 fL+3uA044DATHNJ/AljptwQmVKBY2Wyuvzjrnot9ADeoSc+W6VPE5T8nrIAFZ06N8BX6hoVU5T
 xzHHEJjY1svV80zNPSrqa/KF
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2022 18:16:09 -0700
IronPort-SDR: jKPoHQrluBms7mBiNJtz0w4mfGpxLPp3cINHDYez4iHFgda+LclHRYDYRRuVhQGRAjKBRiDI2e
 RdFDfxivfjnyMHAeNT6/aisbPse3ejKoOax0sfCQW3wdct1idz/pgUdj3fRNWllh4b1fiX3tTT
 XIpx7KoRt31/A8XkEq38HuFtIW/5cou7zVSWERqCDmsO0n+s9AQJnSIFlda2ZzvGycIlE94O5l
 t3f+9ql+9FdjVWmdvavYVlK4Pf2ZKnxICPuEA0U5Hn/sWudb8ODV9mMZjR3etxApIRz6pNyhGx
 lH0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2022 18:45:02 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KJCl12hJdz1Rwrw
 for <linux-nvme@lists.infradead.org>; Tue, 15 Mar 2022 18:45:01 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:from:references:to:content-language
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1647395100; x=1649987101; bh=BUDKqmZbcVaCzgnu+xxYVNx0j3TydSNyBEH
 MbCgsSwY=; b=QHDXUtUXGlmTo36w7FxWaBnZ/RDjmxvoQtkuIiHF8r6HJvmUhlo
 rHiSUeRVbzI05Ki//9Zh8AXfSsKGnTJLQAxdqNkv9nOMUb8ywXBfLYY4pvMnGvOG
 gyoF0fvgEPh4j0WhM936WpX8A3QDq7Wh3sR14kaJqwqDVlGD/ZcXLj9itu72jw8h
 jmTztNzibijkjP/ux/C0hkDrYQCLXcRk55/Eeumdgp+9FMhhVgbtKNAA5fKbo+c5
 8vIHLZvW9HQdw7ObHpg2ut2hcB5AbeIvdV45JvFNj+cLmSD1qinaqGEs++X7y67m
 egaolzX00URHM32l8WU/gBS6cijAACMZj6A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id Ch211gnd3hzP for <linux-nvme@lists.infradead.org>;
 Tue, 15 Mar 2022 18:45:00 -0700 (PDT)
Received: from [10.225.163.101] (unknown [10.225.163.101])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KJCkx5c4Hz1Rvlx;
 Tue, 15 Mar 2022 18:44:57 -0700 (PDT)
Message-ID: <8e842ca0-1885-4738-0099-24409c108b2a@opensource.wdc.com>
Date: Wed, 16 Mar 2022 10:44:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Content-Language: en-US
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, =?UTF-8?Q?Javier_Gonz=c3=a1lez?=
 <javier@javigon.com>, =?UTF-8?Q?Matias_Bj=c3=b8rling?=
 <Matias.Bjorling@wdc.com>, Keith Busch <kbusch@kernel.org>,
 Pankaj Raghav <p.raghav@samsung.com>,
 Adam Manzanares <a.manzanares@samsung.com>,
 "jiangbo.365@bytedance.com" <jiangbo.365@bytedance.com>,
 kanchan Joshi <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 Sagi Grimberg <sagi@grimberg.me>, Pankaj Raghav <pankydev8@gmail.com>,
 Kanchan Joshi <joshiiitr@gmail.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20220314195551.sbwkksv33ylhlyx2@ArmHalley.local>
 <BYAPR04MB49688BD817284E5C317DD5D8F1109@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220315130501.q7fjpqzutadadfu3@ArmHalley.localdomain>
 <BYAPR04MB49689803ED6E1E32C49C6413F1109@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220315132611.g5ert4tzuxgi7qd5@unifi> <20220315133052.GA12593@lst.de>
 <YjDGS6ROx6tI5FBR@bombadil.infradead.org>
 <62ed2891-f4b2-d63c-553d-8cae49b586bc@opensource.wdc.com>
 <YjEuAv/RNpF4GvsJ@bombadil.infradead.org>
 <c3d71cd7-cf95-c290-bfc6-29d307b7b4e8@opensource.wdc.com>
 <YjE8VZ1bbdE9nV0C@bombadil.infradead.org>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <YjE8VZ1bbdE9nV0C@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220315_184504_835542_08E1E96C 
X-CRM114-Status: GOOD (  32.48  )
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

On 3/16/22 10:24, Luis Chamberlain wrote:
> On Wed, Mar 16, 2022 at 09:46:44AM +0900, Damien Le Moal wrote:
>> On 3/16/22 09:23, Luis Chamberlain wrote:
>>> What applications? ZNS does not incur a PO2 requirement. So I really
>>> want to know what applications make this assumption and would break
>>> because all of a sudden say NPO2 is supported.
>>
>> Exactly. What applications ? For ZNS, I cannot say as devices have not
>> been available for long. But neither can you.
> 
> I can tell you we there is an existing NPO2 ZNS customer which chimed on
> the discussion and they described having to carry a delta to support
> NPO2 ZNS. So if you cannot tell me of a ZNS application which is going to
> break to add NPO2 support then your original point is not valid of
> suggesting that there would be a break.
> 
>>> Why would that break those ZNS applications?
>>
>> Please keep in mind that there are power of 2 zone sized ZNS devices out
>> there.
> 
> No one is saying otherwise.
> 
>> Applications designed for these devices and optimized to do bit
>> shift arithmetic using the power of 2 size property will break.
> 
> They must not be ZNS. So they can continue to chug on.
> 
>> What the
>> plan for that case ? How will you address these users complaints ?
> 
> They are not ZNS so they don't have to worry about ZNS.
> 
> ZNS applications must be aware of that fact that NPO2 can exist.
> ZNS applications must be aware of that fact that any vendor may one day
> sell NPO2 devices.
> 
>>>> Allowing non power of 2 zone size may prevent applications running today
>>>> to run properly on these non power of 2 zone size devices. *not* nice.
>>>
>>> Applications which want to support ZNS have to take into consideration
>>> that NPO2 is posisble and there existing users of that world today.
>>
>> Which is really an ugly approach.
> 
> Ugly is relative and subjective. NAND does not force PO2.
> 
>> The kernel
> 
> <etc> And back you go to kernel talk. I thought you wanted to
> focus on applications.
> 
>> Applications correctly designed for SMR can thus also run on ZNS too.
> 
> That seems to be an incorrect assumption given ZNS drives exist
> with NPO2. So you can probably say that some SMR applications can work
> with PO2 ZNS drives. That is a more correct statement.
> 
>> With this in mind, the spectrum of applications that would break on non
>> power of 2 ZNS devices is suddenly much larger.
> 
> We already determined you cannot identify any ZNS specific application
> which would break.
> 
> SMR != ZNS

Not for the block layer nor for any in-kernel users above it today. We
should not drive toward differentiating device types but unify them
under a common interface that works for everything, including
applications. That is why we have zone append emulation in the scsi disk
driver.

Considering the zone size requirement problem in the context of ZNS only
is thus far from ideal in my opinion, to say the least.


-- 
Damien Le Moal
Western Digital Research

