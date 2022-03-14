Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF7BFC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Mar 2022 13:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xmRXJ7cSNeAcmv5Hm9wlu6iuTVQueVA9pXDsaHvrpUU=; b=sJBHR4SRRTplmFfuxud7fEbax/
	96cxYfn4khY0G/35FVdEk2MwQzQi0AV4LdmLZBNUj+qUShtl5o0rITCyU5cOiS8rY2AtVsNV/WMtE
	iBYeWPQFLu89sm2nqzSq70n6zMEElD0q80yywnUyvda8PwN8CY21oub44DV8fN97C4N+UJ8bKy9MR
	cDnrStAhTW6Fkp/21xdvGkv9v86cTPDy67TcKIz5QpWEkGDa6r1MYHRzoj571V/Y34HokO4+GAurR
	uEGmCij8gJCqmoBezuuOt3vcOj5RlBzF9xz8FYIXnUNbpssZypypTe4eJzJd+yY1u+4z89sKiLYhc
	uCE5CpmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nTkbl-005WUD-Se; Mon, 14 Mar 2022 13:19:33 +0000
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nTkbj-005WTg-F4
 for linux-nvme@lists.infradead.org; Mon, 14 Mar 2022 13:19:32 +0000
Received: by mail-ed1-x52b.google.com with SMTP id r29so10648319edc.0
 for <linux-nvme@lists.infradead.org>; Mon, 14 Mar 2022 06:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=xmRXJ7cSNeAcmv5Hm9wlu6iuTVQueVA9pXDsaHvrpUU=;
 b=TE3Xtf5JI1Bd5qQFjUBaGfBQiaVepu0L1BoRDgkcfmQfliJO4nX+QxAa8UzlHoJBWr
 BBwsHJnUNzCNdCOcEk+iWNGF9ILcPAQUUEovCROYkA4V56z05PSkmssvbBacCKihRbVT
 mFGOkOluFgCW4GLWimsCgZHr+en5yAl1fSLHQvQUbbCKkucikIDVhN90Yl1e7mXh4sqY
 GlAFFui0G2D4V4iUFONjrnm4YUrHk+s5WSL9uHQTsosjJsQvUernqYtPqYVa7zDnGt0v
 y3ccgVw29e20t5FG7NKXEirLlrG4eK8SAud/iasP6S494XDs21zfEIGWlIOLfFc5E1FQ
 9/jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=xmRXJ7cSNeAcmv5Hm9wlu6iuTVQueVA9pXDsaHvrpUU=;
 b=f6A3otmjuN8BiiPiZB5KxESK4O/sup7cSLGR97jvHnn2Wfnm02Jd+EjZyyB8yd4nyM
 epOLz1ppazQeLD4CcJlImzEVlsNi1KPRjxQjJ3ZhGlzTv14VOKBflsVgUHJ9DRx3yyt7
 Ea8vv1662vQJovS4oHXZkqZzOjcupjJCjTSzS6zOO8GY0DnfnH+Q3Oajeg/oS4JxqxxG
 sifIpmLDF5m/tIECyMVdOg96TxARvWCW8fcl6jLtz1gYxc+is2/d50v1lOm5mKq15nO+
 QADraTA/8DbDhOzaiBh4iy6+bn4jiHwIBMnexWklaLJR8+fNG/8fGYiFELcWCiE40uSo
 YolA==
X-Gm-Message-State: AOAM531SVhVk6hiICedeT8VDt0ATuCgY12apxm2mJm/TQijAAkj8qVrP
 MEduteuCVy9/+IvL1+EBvqw=
X-Google-Smtp-Source: ABdhPJxcewpYiP4uaPFD3AP6cI26F5wWX4CmDaNViQKWR/sz+93xyrPuo0swU9cVGIJajtx4HvgS2A==
X-Received: by 2002:a05:6402:d4:b0:418:7193:da1 with SMTP id
 i20-20020a05640200d400b0041871930da1mr8164736edu.57.1647263968401; 
 Mon, 14 Mar 2022 06:19:28 -0700 (PDT)
Received: from [192.168.43.42] (178-117-134-240.access.telenet.be.
 [178.117.134.240]) by smtp.gmail.com with ESMTPSA id
 s18-20020a170906779200b006dbb2c2a847sm4075205ejm.125.2022.03.14.06.19.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Mar 2022 06:19:28 -0700 (PDT)
Message-ID: <34b44c52-434a-64b3-88f7-dd58727f7ce4@gmail.com>
Date: Mon, 14 Mar 2022 14:19:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v4] nvmet: add missing lock around nvmet_ns_changed in
 nvmet_ns_revalidate
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
References: <20220313234114.37931-1-dossche.niels@gmail.com>
 <20220314071705.GA3903@lst.de>
From: Niels Dossche <dossche.niels@gmail.com>
In-Reply-To: <20220314071705.GA3903@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220314_061931_554868_DBDFB58F 
X-CRM114-Status: GOOD (  19.85  )
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

On 3/14/22 08:17, Christoph Hellwig wrote:
> On Mon, Mar 14, 2022 at 12:41:15AM +0100, Niels Dossche wrote:
>> -	mutex_lock(&ns->subsys->lock);
>>  	if (!ns->enabled) {
>>  		pr_err("enable ns before revalidate.\n");
>> -		mutex_unlock(&ns->subsys->lock);
>>  		return -EINVAL;
>>  	}
>>  	nvmet_ns_revalidate(ns);
>> -	mutex_unlock(&ns->subsys->lock);
>>  	return count;
>>  }
> 
> And now we lose the atomicy vs the enabled check.  I think we'll need
> something like:
> 
> 
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> index 6fb24746de069..46d0dab686dd6 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -511,7 +511,11 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
>  		goto done;
>  	}
>  
> -	nvmet_ns_revalidate(req->ns);
> +	if (nvmet_ns_revalidate(req->ns)) {
> +		mutex_lock(&req->ns->subsys->lock);
> +		nvmet_ns_changed(req->ns->subsys, req->ns->nsid);
> +		mutex_unlock(&req->ns->subsys->lock);
> +	}
>  
>  	/*
>  	 * nuse = ncap = nsze isn't always true, but we have no way to find
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
> index 091a0ca16361c..06ba477fbf771 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -586,7 +586,8 @@ static ssize_t nvmet_ns_revalidate_size_store(struct config_item *item,
>  		mutex_unlock(&ns->subsys->lock);
>  		return -EINVAL;
>  	}
> -	nvmet_ns_revalidate(ns);
> +	if (nvmet_ns_revalidate(ns))
> +		nvmet_ns_changed(ns->subsys, ns->nsid);
>  	mutex_unlock(&ns->subsys->lock);
>  	return count;
>  }
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 5119c687de683..17cc1cda836cc 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -531,7 +531,7 @@ static void nvmet_p2pmem_ns_add_p2p(struct nvmet_ctrl *ctrl,
>  		ns->nsid);
>  }
>  
> -void nvmet_ns_revalidate(struct nvmet_ns *ns)
> +bool nvmet_ns_revalidate(struct nvmet_ns *ns)
>  {
>  	loff_t oldsize = ns->size;
>  
> @@ -540,8 +540,7 @@ void nvmet_ns_revalidate(struct nvmet_ns *ns)
>  	else
>  		nvmet_file_ns_revalidate(ns);
>  
> -	if (oldsize != ns->size)
> -		nvmet_ns_changed(ns->subsys, ns->nsid);
> +	return oldsize != ns->size;
>  }
>  
>  int nvmet_ns_enable(struct nvmet_ns *ns)
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index af193423c10bb..731f529e11a51 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -542,7 +542,7 @@ u16 nvmet_file_flush(struct nvmet_req *req);
>  void nvmet_ns_changed(struct nvmet_subsys *subsys, u32 nsid);
>  void nvmet_bdev_ns_revalidate(struct nvmet_ns *ns);
>  int nvmet_file_ns_revalidate(struct nvmet_ns *ns);
> -void nvmet_ns_revalidate(struct nvmet_ns *ns);
> +bool nvmet_ns_revalidate(struct nvmet_ns *ns);
>  u16 blk_to_nvme_status(struct nvmet_req *req, blk_status_t blk_sts);
>  
>  bool nvmet_bdev_zns_enable(struct nvmet_ns *ns);
> diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
> index 46bc30fe85d2b..56c20502b7ef3 100644
> --- a/drivers/nvme/target/zns.c
> +++ b/drivers/nvme/target/zns.c
> @@ -123,7 +123,11 @@ void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req)
>  		goto done;
>  	}
>  
> -	nvmet_ns_revalidate(req->ns);
> +	if (nvmet_ns_revalidate(req->ns)) {
> +		mutex_lock(&req->ns->subsys->lock);
> +		nvmet_ns_changed(req->ns->subsys, req->ns->nsid);
> +		mutex_unlock(&req->ns->subsys->lock);
> +	}
>  	zsze = (bdev_zone_sectors(req->ns->bdev) << 9) >>
>  					req->ns->blksize_shift;
>  	id_zns->lbafe[0].zsze = cpu_to_le64(zsze);

Thank you for your time, this seems like a nice solution.

