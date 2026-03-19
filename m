Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6C6CFB5EAA
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Mar 2026 03:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xqQAQ5Zsq0NfzEjfwKLl7x00nUp4Lg/FBdio+v8iK5w=; b=1jq0rnx5gkP0FVTnpIWEJn/4kS
	vatrZkjDvBGgr0+2j7Wh8agF2GqFaGFiR8R/yTQcjbBBzyvfBjdCn358gzIrOXVKVkJMI56RM4r2R
	6zppXN6ZF2WagynwcSyILwwKW4f/iRj4esnAqDTmsHUVZAr1z4MAGF5fZFDQG9QD5dmzohR7vdu67
	m5RJrCIj8Sd8ktamCxIOTvfhPa0MiwTN/MYZoxLZxVLgWVsuqCgrAxRS0rm/e6h5yYFQhLOeVlZ61
	TK1lLYcUcVieum+aWFKEVPeQsI5wv0+jkrZQ69/RkStBXcDxb+smBYO1hyY+nTB5pjNm/wMG1lOnl
	H5wp6XlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w342y-00000009pwW-1Peo;
	Thu, 19 Mar 2026 03:27:44 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w342x-00000009pw7-2PDq
	for linux-nvme@bombadil.infradead.org;
	Thu, 19 Mar 2026 03:27:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=xqQAQ5Zsq0NfzEjfwKLl7x00nUp4Lg/FBdio+v8iK5w=; b=eEHc0WyyLZqEC07vNuEvPK1GVW
	C8tycsNltNoIfxu0Nrd1DHFzs+wzWonE3T0+7Lrk5NdACct85rUyAzv14HojlRsoDjBU9GywORtLN
	9Da6/DX+X612RBlwOaT6OUVgqZD1dG3ICIqknAR5Ty2xi8bRU0DS0HyG4GOnDyo6rRiocI5MeunO1
	Zw7IEWtgkbQ754/yXsVNrnTlMjcCHTB9YjDeftYuP3Fk3gQ5Na0Z8TWp03wIAcMUV+KQ45ffPjtHy
	UwKA1HyQDyvjUaJXLQxGmiBCrRZY8C9HDxYaaY1UeiEI9afpJKcjhZfAzCkgsbsS3BOYlu2EoLrHd
	MsHNpw/A==;
Received: from sea.source.kernel.org ([172.234.252.31])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w342o-0000000CeM9-1Z9V
	for linux-nvme@lists.infradead.org;
	Thu, 19 Mar 2026 03:27:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 9D1DD40127;
	Thu, 19 Mar 2026 03:27:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF8E9C19421;
	Thu, 19 Mar 2026 03:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773890851;
	bh=sRx/e6yBG83MxWAyEYb9aM48iMeWBalueRmbRh5WjdE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=S4EpimIq4LnMdEYbgP3izMuEMgLIMR+ETM5Wh6j+kDP02xLrAerV6MhJv4MFj6I39
	 2kgyZxsn0gmWzn+37imwh+VQKkBZroYX5QftmsDHGTm82JmGes8UN+q1FxaBQE8zIu
	 +lvwv5WWph4ovhxC7IDfRa+sSueronJlgWg8mnBgTPLyoxsVRrk76YkdCySYXjzA2Z
	 /AVHRIqQL9S5KJtbyCTIVLh6chRQLaZKvql7I98jZV4tlzl6N77Qf9/irBdDap/Vmp
	 4NZr0fg25um4rTaxxbYDL1cHYrMpLl7kl2hZlK3yAzSbt9ATcyZiO9K0v8oOD+Ol/+
	 A9zLnT3Fn+F8w==
Message-ID: <1adabe3e-4497-4e71-b6a0-f3b81df322eb@kernel.org>
Date: Thu, 19 Mar 2026 12:27:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] scsi: sas: skip opt_sectors when DMA reports no real
 optimization hint
To: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>,
 "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: ahuang12@lenovo.com, axboe@kernel.dk, damien.lemoal@opensource.wdc.com,
 hch@lst.de, iommu@lists.linux.dev, ionut_n2001@yahoo.com,
 john.g.garry@oracle.com, kbusch@kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 m.szyprowski@samsung.com, robin.murphy@arm.com, sagi@grimberg.me,
 stable@vger.kernel.org, sunlightlinux@gmail.com
References: <20260318200532.51232-1-ionut.nechita@windriver.com>
 <20260318200532.51232-2-ionut.nechita@windriver.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260318200532.51232-2-ionut.nechita@windriver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260319_032735_735617_C35066DC 
X-CRM114-Status: GOOD (  13.30  )
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

On 3/19/26 05:05, Ionut Nechita (Wind River) wrote:
> +static unsigned int sas_dma_opt_sectors(struct device *dma_dev,
> +					unsigned int max_sectors)
> +{
> +	size_t opt = dma_opt_mapping_size(dma_dev);
> +	unsigned int opt_sectors;
> +
> +	if (opt >= dma_max_mapping_size(dma_dev))
> +		return 0;

I really do not understand this one. How can the optimal DMA mapping size be
larger than the maximum possible DMA size ?
If that happens, it is a driver bug, we should WARN_ONCE and return
dma_max_mapping_size(), no ?

> +
> +	opt = rounddown_pow_of_two(opt);
> +	opt_sectors = opt >> SECTOR_SHIFT;

if opt is super large, can this overflow the 32-bits opt_sectors ?

> +
> +	return min(opt_sectors, max_sectors);
> +}
> +
>  static int sas_host_setup(struct transport_container *tc, struct device *dev,
>  			  struct device *cdev)
>  {
> @@ -239,10 +268,9 @@ static int sas_host_setup(struct transport_container *tc, struct device *dev,
>  		dev_printk(KERN_ERR, dev, "fail to a bsg device %d\n",
>  			   shost->host_no);
>  
> -	if (dma_dev->dma_mask) {
> -		shost->opt_sectors = min_t(unsigned int, shost->max_sectors,
> -				dma_opt_mapping_size(dma_dev) >> SECTOR_SHIFT);
> -	}
> +	if (dma_dev->dma_mask)
> +		shost->opt_sectors = sas_dma_opt_sectors(dma_dev,
> +							 shost->max_sectors);

Splitting the line after the "=" would make this look nicer:

	if (dma_dev->dma_mask)
		shost->opt_sectors =
			sas_dma_opt_sectors(dma_dev, shost->max_sectors);

>  
>  	return 0;
>  }


-- 
Damien Le Moal
Western Digital Research

