Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9EE3C433F5
	for <linux-nvme@archiver.kernel.org>; Mon,  9 May 2022 11:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R7p++eFkOmpFxyhEfVZjPFTiO7RXQjBryk+5g+fzIW4=; b=R1DsKFkuk4HVmxJLBnTKEPb+Sz
	/o0QTFyUpcG1hTUPmyIThKlCksre8vFQbJsDuDP6MxwXMgicmak/ikbjS8bCzg3SMGrefpKAIfS/U
	sd73BazQ3dKpFJqwj1mRcsR1U4fVGLtUbp9suaGcOiJ43vuWOPUQUzr7P1a+jtjglnvJ5VXQnYd+o
	5fCW9pIlOi53bKGvMqM5IPa81Y0+HMc4E9n5QjxNXtABMg5J20P0tHTNpRwvcVF9CrhSD0T5XAspJ
	eZUS4Y46nBW90cVKwzq2uVXRKXzc9G75E6CcmrW/X4mklwpLPiOp48pZSON2A3Xn3PORGHCvse5hR
	VjDCa4Sg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1no1cb-00E7HZ-OB; Mon, 09 May 2022 11:32:13 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1no1cY-00E7G7-VB
 for linux-nvme@lists.infradead.org; Mon, 09 May 2022 11:32:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1652095930; x=1683631930;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=v0lVI0gmiUvzoNmI5a0guGMpgDZX+uKFFD4KLqB/fQU=;
 b=CA2+t0avAnITT5MNseqitpiLsf/TgdwP4pQJj9r9feebQes73Q3iK5iD
 /EUakjrzIdM5sueaDZ7YXMuaaJhke6b/Exgshe40Ceu4pQAcunFkcjeUm
 FKhA2O9N2M2gRUL4FNPSaczi7RZVlbeUlEW924OeUkFb2D34pl1/Ibire
 ddoTjjdt/tpWys4vqz2zRWQztPJC2EvfpolbbOvTR+K1nc2mPX77iuiVg
 wvqGRTctOmaX4rXegdTYx95FC4OE6UEva+pD7Ao9rNYxNs/kLRocAOoim
 QQUXL0F2SAqYYW8LdrTU0IXUTDe0n4lhzw2dPHQ0Ug/0ok8Iov0QMPd6L A==;
X-IronPort-AV: E=Sophos;i="5.91,211,1647273600"; d="scan'208";a="304078993"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 09 May 2022 19:32:07 +0800
IronPort-SDR: FYv6v5hpJFywQ/eK90l/2HzJlCels4pOe0/ray3S7fksOqCNwEh0RCS2mqP58kEicd+eQq3AQ3
 4pjTWqEiD3JVepPVevnWU3u79BmxOuBVnZ3zaFmtz8KMcgX+5rzGduNAurHepbHF1OAjtxN+0T
 5rHZQ5aVts3BI2W1N4157WolWUILnesjSMotZ97XOymxiIIdc82tAJat2+sZUOgA1UM0ixbGwe
 VA6cW/4m7GRTlJu/4hP5c2cjtnQV5qYGfc6cL4rTFZ8nfGhmKf2v1HSPTZ046Hu7V4th3qfjrw
 qGIFYd7Z4Dc6SLlC0Wbw4wDS
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 09 May 2022 04:02:13 -0700
IronPort-SDR: yrVk7YjaZFYq9QUvbVTo9R7wMtNICsQsYFECc2AtonM1FCQ8Br5A5fGK7z5BgjSMaFYfquQsMT
 itEASkBSxW3Xttsfz10OfEpsAjNikJak2cmwCP3nCF4Aos4zf0qEQNOK0PpOf3/iv95Kyp+J8X
 XK+faXvnCOg83cJW470VcBmFz7xpW1JusWhMN6NbL3sgBTsrIPY1oStZoMOViEDwNdnq6TcIbd
 7OJ6zawyFWmpfDRaydghutTFni9TqyBWEHY3Q+V5YoBUJoQYcoen/x2UfafdkLti1wN9oUi5qL
 gm4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 09 May 2022 04:32:07 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KxfCW0vYLz1SVnx
 for <linux-nvme@lists.infradead.org>; Mon,  9 May 2022 04:32:07 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:from:references:to:content-language
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1652095926; x=1654687927; bh=v0lVI0gmiUvzoNmI5a0guGMpgDZX+uKFFD4
 KLqB/fQU=; b=E/S7+ftCKDojRwdfWfMiCt2FBFS6P6O4vQv9CY0mSrWKcOA/TUZ
 cINZhwkUJYr2VgFPHiRT6KCIT63B1UNrpbQrpHSC1d6EEDVjfyCzgGRo25Yk+Mak
 ke234L+h8WlpCNwP12dZFkUA1RUzY8bhjo/4g7dLD/EYNiArXQLxsSKwun2bK3Ud
 0wdN4f58GNZYl3Y6Xy2a/6WnwZ19GsujmmSXyN8pGC3Pw9VYMxpmDi/CSROhi8Gv
 ZaE8OWsdQY3K0YdfRMnjbNkDESbv3xgPsyP35A+xnGM6iDPATqr5gNEjatknRWB9
 QJziNpUStccPtJO2rPx1Sa+x/ad4k2zfTDw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id vYAoxxGvBsky for <linux-nvme@lists.infradead.org>;
 Mon,  9 May 2022 04:32:06 -0700 (PDT)
Received: from [192.168.10.49] (unknown [10.225.164.111])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KxfCM384lz1Rvlc;
 Mon,  9 May 2022 04:31:59 -0700 (PDT)
Message-ID: <9eb00b42-ca5b-c94e-319d-a0e102b99f02@opensource.wdc.com>
Date: Mon, 9 May 2022 20:31:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH v3 10/11] null_blk: allow non power of 2 zoned devices
Content-Language: en-US
To: Pankaj Raghav <p.raghav@samsung.com>, jaegeuk@kernel.org, hare@suse.de,
 dsterba@suse.com, axboe@kernel.dk, hch@lst.de, snitzer@kernel.org
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 bvanassche@acm.org, linux-fsdevel@vger.kernel.org, matias.bjorling@wdc.com,
 Jens Axboe <axboe@fb.com>, gost.dev@samsung.com, jonathan.derrick@linux.dev,
 jiangbo.365@bytedance.com, linux-nvme@lists.infradead.org,
 dm-devel@redhat.com, Naohiro Aota <naohiro.aota@wdc.com>,
 linux-kernel@vger.kernel.org, Johannes Thumshirn <jth@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Alasdair Kergon <agk@redhat.com>,
 linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>,
 Keith Busch <kbusch@kernel.org>, linux-btrfs@vger.kernel.org,
 Luis Chamberlain <mcgrof@kernel.org>
References: <20220506081105.29134-1-p.raghav@samsung.com>
 <CGME20220506081116eucas1p2cce67bbf30f4c9c4e6854965be41b098@eucas1p2.samsung.com>
 <20220506081105.29134-11-p.raghav@samsung.com>
 <39a80347-af70-8af0-024a-52f92e27a14a@opensource.wdc.com>
 <aef68bcf-4924-8004-3320-325e05ca9b20@samsung.com>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <aef68bcf-4924-8004-3320-325e05ca9b20@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220509_043211_146643_4C662688 
X-CRM114-Status: GOOD (  18.07  )
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

On 2022/05/09 20:06, Pankaj Raghav wrote:
> 
>>> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
>>> index 5cb4c92cd..ed9a58201 100644
>>> --- a/drivers/block/null_blk/main.c
>>> +++ b/drivers/block/null_blk/main.c
>>> @@ -1929,9 +1929,8 @@ static int null_validate_conf(struct nullb_device *dev)
>>>  	if (dev->queue_mode == NULL_Q_BIO)
>>>  		dev->mbps = 0;
>>>  
>>> -	if (dev->zoned &&
>>> -	    (!dev->zone_size || !is_power_of_2(dev->zone_size))) {
>>> -		pr_err("zone_size must be power-of-two\n");
>>> +	if (dev->zoned && !dev->zone_size) {
>>> +		pr_err("zone_size must not be zero\n");
>>
>> May be a simpler phrasing would be better:
>>
>> pr_err("Invalid zero zone size\n");
>>
> Ack. I will change this in the next rev.
>>>  		return -EINVAL;
>>>  	}
>>>  
>>> diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
>>> index dae54dd1a..00c34e65e 100644
>>> --- a/drivers/block/null_blk/zoned.c
>>> +++ b/drivers/block/null_blk/zoned.c
>>> @@ -13,7 +13,10 @@ static inline sector_t mb_to_sects(unsigned long mb)
>>>  
>>>  static inline unsigned int null_zone_no(struct nullb_device *dev, sector_t sect)
>>>  {
>>> -	return sect >> ilog2(dev->zone_size_sects);
>>> +	if (is_power_of_2(dev->zone_size_sects))
>>> +		return sect >> ilog2(dev->zone_size_sects);
>>
>> As a separate patch, I think we should really have ilog2(dev->zone_size_sects)
>> as a dev field to avoid doing this ilog2 for every call..
>>
> I don't think that is possible because `zone_size_sects` can also be non
> po2.

But when it is we can optimize that. All we need is add a "zone_size_sect_shift"
field that is initialized when zone_size_sects is set when the device is
created. Then, you can have code like:

	if (dev->zone_size_sect_shift))
		return sect >> dev->zone_size_sect_shift;

Which avoids both is_power_of_2() and ilog2() calls for every IO.

-- 
Damien Le Moal
Western Digital Research

