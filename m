Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 445BBCD4F3C
	for <linux-nvme@archiver.kernel.org>; Mon, 18 May 2026 09:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RUPmegXaiRoLRWLvDg/ljmtDOi29ffNPo2bGfVCm61A=; b=M+HiHYKrX4wjt1VBE8o6N1Sewn
	wcS5j1eeh5NKMxUe9sWnoeDAYENCM8JGlBAplZv3dfpMGXH3zf/PAoaxfMNB6q47ePR2Ybxfvz9cR
	kC4UyZGrLVGm5XgPf9OBaVcgW7/m6/m9nUETZZVWDecPkUA3DqBCozFwEo2EG3HLq7ocZyzcVVPPK
	tkFklSEPIfI/C9W+plPPjTgib3uuLZqn3GLV1dasAtikqeoojK7NQlVtbUXLR9iR151UGzhvsKeJv
	T7/g/G/c3z45CZre8LaWu+l3Y3047CYx6XX5T08rQFrSYTL5NA+5XCi5Hn3sTum8WJcjzxJDLimMG
	q37mMWOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOu0X-0000000Exhs-2ez8;
	Mon, 18 May 2026 09:11:29 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOu0V-0000000ExhK-2vWC
	for linux-nvme@bombadil.infradead.org;
	Mon, 18 May 2026 09:11:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=RUPmegXaiRoLRWLvDg/ljmtDOi29ffNPo2bGfVCm61A=; b=g0SU6Njo50zBoBDqTSzQET8BaR
	vwvlCdquNDc/nuol3MZkesByqlLSBtpMbGT9rnv+h7Eb+bQXZOZT6m+2GfcWrhtq3dLWVrnEUhglw
	kMj8W6asY7cuPwmddbbVP/hotW/ggjtg1x6p05lmbiRkU1lq/GRfMmlDLzl79ADqFp6NjgvSIWUqb
	T6DT6I5/Tmoxr9k0cdt8UCVwZ7Dot2SpRxQLlqW5WQlum45Ohg5Rx30mvpW5KfbYAlaQHDgym6Td/
	iAlUR6rsAf5t1Nzc9QVMHdY4AY93AkjiwaefjDTAjIBmA4yiqPXfS5szu86hei3Z0WBU9Y3ZyaeAy
	5b8h5wSw==;
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
	by desiato.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOu0S-0000000AWMq-1IcU
	for linux-nvme@lists.infradead.org;
	Mon, 18 May 2026 09:11:26 +0000
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-48ff4f8ef0dso22966575e9.3
        for <linux-nvme@lists.infradead.org>; Mon, 18 May 2026 02:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779095482; x=1779700282; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RUPmegXaiRoLRWLvDg/ljmtDOi29ffNPo2bGfVCm61A=;
        b=guAv5XRmhpXnNFxhy4tJmLlHrYod0eZ7gGFoT71ay+Odafg/HpdneDw8/PbRXLL0Y0
         BQJ2sSBHdgklAmZfTuTEaKujzMwDjOkJyVT2+bNkhibZHV04DIPSaEXyNhXk7HBwE8+s
         xSffKH37yJv/RKrYpGXuo6rKjYX2Ls37i5bu6IQlJzzLR1usv+DapduxKSEo8QBcWTug
         2onF/O1JwKU6amGWD8tDfSqXciE9nOD4h9vmTgPtEZ6yYSiFnvVGcCKiPZ8YS2bAXxnd
         kVtRTMvsjyg6Wi6FDMJaIhKVGYPeklg/ONyMM8JjfESPuVk8hZ7KYdbESVi7BZphsgXy
         E+2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779095482; x=1779700282;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RUPmegXaiRoLRWLvDg/ljmtDOi29ffNPo2bGfVCm61A=;
        b=P69miZTbkgx+7hY9QDcODqAHS+9QENJleJpWiivJq5JmTINVDsmCrHrB5GemJX0d50
         82Halkj+M6it+vd7UsqoT3wUk9KME6YcSVe5rxzcCAo/7VnrEfsMfI2mwr9McTv7rjWN
         RC395olfw25st9/6661W4refTixDlMq/llL1omR924N993jHhpYeQTVvhLd4YHDrD96a
         pYAqVa26b8xaBCexsU9pOajHMUFBjrL6eh/NXQzAn+MoOXKx0gK5QPW+NoeQSho3Yfzt
         xAk311ymlzOs0lIXYC5iu7Vwnip7dnpN5gzgOBKBCOxTJvC4XaEJICE+0Qb+vxLkbMaj
         RTAA==
X-Forwarded-Encrypted: i=1; AFNElJ8MxDbF7FVDr0hqVOYi7pnzQm6Hj7+VwxNL5MLdLsyG44UOU9j78/DCczqhj4qI+JnW/0Kqtwrm9rIQ@lists.infradead.org
X-Gm-Message-State: AOJu0YzxnT/bJi435rxLeVUQ5z3Ss3yQGmhq/ymHyNaQQ7gvidqlEMNz
	nmujc0MfhF3ZSjhqQfJlHNLRJtyNloU3Vgn4mA4pTIPtjvUtyS+VM9gr
X-Gm-Gg: Acq92OHLxO3AxTD4eqAf6/dkXq7mrwchjL7ewyZtrKud0++LF6mwj9rVC/GuLDNG7RB
	euESfGZhCd+rwyg5NGnlvMFu8lpFTwIdJSmc/03cYtrbncDPVZUdR0QQ9Uid4J8wGZkjocd9zDI
	K6cAgk5aDbEoRreviw13I3NzjCJ46E9Or1I/qWJw0kbIuqQXne06QlVTLKUB8SOmD1Ih9LmzVEl
	ZaN0GwjFuF6cthsKY22U/85h6uIoqgKo6zryIzXkgdpbyfZAsz4WswzxuupXFsxm/1xrxiai/dE
	VOQLnB5ji0ACXTtRvYSwhN9ZlLSEzf4QvV+NjJDRTifm26tXovobkd0IylWMx6I37Tj9zPLX1l/
	2u7R1POuqcmS3vtgsjM0IHK1yu+OYiHLvMsVpGbFLoq5CWVtWLhxsFDvEHLGGvaiePP6us0TRHf
	7ierN0XIfm+QO2B7lOEmzrr+sWgcBj+BpW+9OewB+zIMYMxok9CfOpPV6GvwEw6gmru8xxEsXjP
	6Hkv+Wbv9KUUZB/zhdlBBLnP5wVCoXFXdtGagteEhs2tVh8qrdOqIrfNdc=
X-Received: by 2002:a05:600d:10:b0:48a:568f:ae6d with SMTP id 5b1f17b1804b1-48fe60e7d79mr178172895e9.8.1779095482306;
        Mon, 18 May 2026 02:11:22 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:6e9b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febe79ce3sm80272945e9.31.2026.05.18.02.11.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 02:11:21 -0700 (PDT)
Message-ID: <d262dbc0-48c1-4994-917a-1f975c60b2af@gmail.com>
Date: Mon, 18 May 2026 10:11:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Pavel Begunkov <asml.silence@gmail.com>
Subject: Re: [PATCH v3 04/10] block: introduce dma map backed bio type
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <cover.1777475843.git.asml.silence@gmail.com>
 <646ecd6fde8d9e146cb051efb514deb27ce3883e.1777475843.git.asml.silence@gmail.com>
 <20260513083937.GD6461@lst.de>
Content-Language: en-US
In-Reply-To: <20260513083937.GD6461@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260518_101124_798640_B3836BE5 
X-CRM114-Status: GOOD (  10.89  )
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

On 5/13/26 09:39, Christoph Hellwig wrote:
>> +	union {
>> +		struct bio_vec		*bi_io_vec;
>> +		/* Driver specific dma map, present only with BIO_DMABUF_MAP */
>> +		struct io_dmabuf_map	*dmabuf_map;
>> +	};
> 
> ... and please add the bi_ prefix we're using for all (well except for
> one oddity) fields in struct bio.

Ok, going to add

-- 
Pavel Begunkov


