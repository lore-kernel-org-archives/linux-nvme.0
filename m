Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B55BBC433EF
	for <linux-nvme@archiver.kernel.org>; Sat, 12 Mar 2022 08:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=STSxXvVEY+MYBCgKDy0jswPHfnHY0q90oenYKMFp6Rs=; b=FzO8+/hnWBzI76tV7N8uF+LCvV
	EWm+tYkeNinEmzo03EVqilnQOYvC8yEvbTw9xUIL7e8rD4XJ2BU2MqYo2B5TlGEYAkVFI8Gh8qNPi
	p5+BmT342ul8jTp9rlQyxjM9Cpn4GA1C/QF4NxZt5m3QBot2IVUV7ahWocLlv70jPMf+dmZakQEcd
	3Z8dc/I3CHY0Am7FM2vo9ukTD9THUJF6nVk2NHWfKCTkZVh8EEXqjqkU0kuU6qICd93JNaW46oYo/
	UygIg6DzbhLfDs7t7fUpFIgRwWn8F+v70I78cHNZ1HERUZYoSIHS3kchLEHuvWfGIcGvXM4LMdsrn
	ftX5jwZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nSwu0-000vPL-HI; Sat, 12 Mar 2022 08:15:04 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nSwtx-000vOt-Nn
 for linux-nvme@lists.infradead.org; Sat, 12 Mar 2022 08:15:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1647072900; x=1678608900;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=8dLxKQ8lA5pcpfKPWVJfrbFYATKFcrWi7qyE85BWWvU=;
 b=Q1bLngqav1l+8mqZLz/cqMK8i0EO7+6baqdX9mrneWMw3yKoc27KCa2O
 79Aw2ip/3MaqK4FCXWGtRLsUcBBu6lds/GYNeoyzD8Fx8w3FvRu77KWkj
 FEuTxE1nIDkTW8R2I3xuKlWxyqs5AWxgVfyDkxeDGyv+ajAn66hWuUylR
 1d5CxUi62fB/pFxTJFWjpwQ8wZ7b0H3UQhavv206xClXQZQlhEtqdIz+h
 tDKEmtSss29Ysy9/4l07jdXpULTLudaGqHXBN7Ht+IHhwZLZWW3jYaBc3
 BELwhQn2A1ySRZPrpHRR7wuDGRzJJ/ZaI10D/oLuy9Ahwwegu+yqcrOei g==;
X-IronPort-AV: E=Sophos;i="5.90,175,1643644800"; d="scan'208";a="200013432"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 12 Mar 2022 16:15:00 +0800
IronPort-SDR: 9l7aT50beoIU/IP2zDoqHRC7rmcrlwJeq8BZkxl2hOQV0TASjDitqIWd2o/ji786WUibPgg8F2
 6q1R3T8245yCP8yGrjcYOPZD9snc66lK8i/VdPaIF0NOYriW1X6kwtntbVj4wac9CH3h+ayUz9
 wlFLNrc/OdAwxoLoinm+pIasp1WeQXHYJRuCAnUy7gIuJ4bLBih5rlDKqNxt4I6rOu9W/izVXO
 6fhSd5Z/puzYkmkTB7mHvDw0RcL9RmpiVIY2+B8zq3/W4HgghgHh4qyYTjTciTBImoCMmy0aLe
 ILk43J2qOzT5b5Dvou/2TvNd
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Mar 2022 23:46:12 -0800
IronPort-SDR: v21zaZ7uSuG8g62By2ZpDeeVgyHKuNoDpJHaEgQquk1gl08h/LlbZCM6cbr7x2oN2C45s6H4El
 El/QizULU/2YCEVlNrLgu6TrqV+y11N03CmQig1kQ/gzqXkkHWcgjMkuAIVqawP2zywK0ijgK6
 bgO+w3vQZhpEZHD+cvrdVFPVMhG3UA4VXDI1rwWmw1F1S9/nNyu43OXP9KP6OK8ENf1DSmkhir
 UYggkic7Dpz5B43H/sADvgGAcJ5LgQErdf3rSBo3TxCWxGIDQLzcRc/Xo9kW7rOx88ko0QP6Is
 qbk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2022 00:15:01 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KFwZr4kv4z1SVp4
 for <linux-nvme@lists.infradead.org>; Sat, 12 Mar 2022 00:15:00 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:from:references:to:content-language
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1647072900; x=1649664901; bh=8dLxKQ8lA5pcpfKPWVJfrbFYATKFcrWi7qy
 E85BWWvU=; b=LuvARMAPL72exYhKQ4Lv5TxQ0zATKUiqMAbFhLkH7SMUvUll8K+
 E4W1pXMmA2hBvx25oYzgV8LteyAOkR/gC55PgiCs/cuS4BZH1aDQBZzbiOkrYiz1
 oA2Oz5fEp6j/aEeIQqcJWLLSiciI1tiX2vB6yAfcnXic2+rRGBTTNN5YxHTrNTEG
 rf3J7pAzgo6F4gZnEa9KwPFt5lWVS2ETS+UqoVmgMdVbqVMFs22PqC7Sv6G6m66a
 bpV6m9X+OgBkSZ2oKTtk1o0QCb9R2DEcY0E9XiCnJbxiNOWqx5VXrGfE2+zM/fnf
 7xIwgS5CH9bbahGPxhN9hYJf54FMCqTDK0Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id r0KRAIb71XRh for <linux-nvme@lists.infradead.org>;
 Sat, 12 Mar 2022 00:15:00 -0800 (PST)
Received: from [10.225.163.91] (unknown [10.225.163.91])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KFwZn3ByWz1Rvlx;
 Sat, 12 Mar 2022 00:14:57 -0800 (PST)
Message-ID: <07484796-d692-6247-427f-20d0e9ac6193@opensource.wdc.com>
Date: Sat, 12 Mar 2022 17:14:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] nvme: Fix zns drives without append support to export
 correct permissions
Content-Language: en-US
To: Pankaj Raghav <p.raghav@samsung.com>,
 =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>,
 Johannes Thumshirn <johannes.thumshirn@edc.com>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, Jens Axboe <axboe@kernel.dk>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
 Adam Manzanares <a.manzanares@samsung.com>,
 kanchan Joshi <joshi.k@samsung.com>, Pankaj Raghav <pankydev8@gmail.com>,
 Kanchan Joshi <joshiiitr@gmail.com>, linux-nvme@lists.infradead.org
References: <CGME20220311201638eucas1p18b9c5ecb3442b5a53bba233591d34db0@eucas1p1.samsung.com>
 <20220311201608.275384-1-p.raghav@samsung.com>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220311201608.275384-1-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220312_001501_843378_4B545247 
X-CRM114-Status: GOOD (  25.95  )
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

On 3/12/22 05:16, Pankaj Raghav wrote:
> This commit 2f4c9ba23b88 ("nvme: export zoned namespaces without Zone
> Append support read-only") exported zoned namespaces without append support
> to be marked as ro. It does it by setting NVME_NS_FORCE_RO to the
> ns->flags in nvme_update_zone_info and later nvme_update_disk_info will
> check for this flag and set the disk as ro.
> 
> But later this commit 73d90386b559 ("nvme: cleanup zone information
> initialization") rearranged nvme_update_disk_info to be called before
> nvme_update_zone_info thereby not marking the disk as ro. The call order
> cannot be just reverted because nvme_update_zone_info sets certain queue
> parameters such as zone_write_granularity that depend on the prior call
> to nvme_update_disk_info.
> 
> Call nvme_update_disk_info after nvme_update_zone_info again so that the
> permission for ZNS drives are marked correctly.
> 
> Fixes: 73d90386b559 ("nvme: cleanup zone information initialization")
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  drivers/nvme/host/core.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 51c08f206cbf..67a78653b07c 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1913,6 +1913,11 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
>  		ret = nvme_update_zone_info(ns, lbaf);
>  		if (ret)
>  			goto out_unfreeze;
> +		/* nvme_update_zone_info might set the namespace to be marked
> +		 * as read-only. Call nvme_update_disk_info so that the disk
> +		 * is updated with the appropriate permission.
> +		 */

Multi-line comment block should start with a "/*" line without text.

> +		nvme_update_disk_info(ns->disk, ns, id);

It may make more sense to move the "set_disk_ro()" call at the end of
nvme_update_zone_info() into a different helper (say
nvme_set_disk_mode()) and call that new helper here to avoid going
through again all the settings that nvme_update_disk_info() does.

>  	}
>  
>  	set_bit(NVME_NS_READY, &ns->flags);


-- 
Damien Le Moal
Western Digital Research

