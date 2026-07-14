Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04012C43458
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jul 2026 09:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ersi/mYvINkBI2FWvIZV+GjZx0POxK8U4eXz4ZcSu2s=; b=XXz0AH3ot1UBpKMuvyy5Ya65AJ
	iUVr0cx/yzZlTPOpcQe1CTvKBFO5g5s3eai2PclsT3fpbRXQx9Osuk6SRlLXODJCW5r9roIxSFi+T
	CnItjVDrGbDKFSssj/XXklyv8WTiXTTF88FwVPmGwD2vYXrqkbSFtY5gawFmSqsh9fiq3iWOyeqdF
	/LdqXxggJaQh7gllH1Wba/R/JhNwzPLfEhlddZzrrZ6t57Ip4nQ/810ROkxLwjR8/vXBeB/8mUGkm
	3+wihrmpkhdBeVnkNUVNHHh9Dj+vI/mRIlpoIOe3Htj8iJ157eNxNutoLp9eiHxd1VOZwtfhB1nvI
	5jBqYI6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjZLH-0000000BRji-2ScM;
	Tue, 14 Jul 2026 09:22:19 +0000
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjZL8-0000000BRid-1wcW
	for linux-nvme@lists.infradead.org;
	Tue, 14 Jul 2026 09:22:17 +0000
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-47d6c634f45so2210023f8f.3
        for <linux-nvme@lists.infradead.org>; Tue, 14 Jul 2026 02:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784020926; x=1784625726; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ersi/mYvINkBI2FWvIZV+GjZx0POxK8U4eXz4ZcSu2s=;
        b=cY+WGs++uj33j0nztjJ4q8KhipJ3pE00vvMy37/AULi5zaSMLeFZyS/a1wpVCB2fim
         H2GYj9N5vBrrtlJkEQEPrFqZ/N/sg2ar2bBBTfAV3o92Km75iFjxIELqtWHezoFqvoy4
         IqDRq8tH8SS+zgd0spnlH35CmvD4+nABx2A3hpduYirmwKvy5BXTW6dTHbnc8eGnK0iW
         T5XnUc7+xEAS2xN4JlQxtjNMNBiKc5Ys2R+yyTO4/+iYawdJBkeHZBLvZS/REUn3/aHH
         t9iivjCxqelCGCh5Q6jhehutzApve6fTKmGQh6K7T6+60g4KcahfKFGrjrEVON4s6ZYQ
         NIlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784020926; x=1784625726;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ersi/mYvINkBI2FWvIZV+GjZx0POxK8U4eXz4ZcSu2s=;
        b=TD5PDbusDAFvgjR1kjvGNiGJQ5oA6gyVvG5jhvsorOsoq5479Bn/02pK16JIUaOVKk
         JOfuYq5cFORsWBb3F0PFioOKhNOFPxD1crP9Jc9FalgICSlbYCUZzlYR7Ibl02AjPwgb
         zB9UJTso+UetSulyAfTLdbUMhJTMBw3fSo9tWGxnwoxZaJi+CGdCSfn6B8I6bK8C0bm+
         FHNu0V69rJ6zP8ppnsX1l2NdS/Bu3fYWTWBLSLWIgC311HDmFRSup9yge+4wWur1RqWO
         YtuBSQEU0DIV6GrWtr9gQJ4tjXujIXzlhEkS3SdENSn0pn8z9ITS1nJNotdfEPCzdycM
         sEsQ==
X-Forwarded-Encrypted: i=1; AHgh+RpQ2HtST6VHFJZX8C8hqjOnXTbe/4X4MYN3np4gV6oX/gS42o+NXei3LeoN8FAI6dn47c5C096KC+ey@lists.infradead.org
X-Gm-Message-State: AOJu0YzFE8a3SMKG4LwcY1cSdqFvEl9VxUUMMaPq6kBfX/BeN2b26mM+
	mgu44vkRXTXW6ZHW4FzkBUwY27R4y4TUhidawVpHlAP1Dr2st/qAaBI1
X-Gm-Gg: AfdE7clUJGs64+P4dkMyJT0LlD72v/1fd4pGm6zowEyxwCtL9cN/DBwSfSPQ4Tjv4Tr
	tIf3AQB4DSMNH5TBAIEgcpennLfzCWrl/n+7XOyndcEqM8cZeTcD2IEMnB0dJbFwDlW/Qz7w49Q
	cIkDnUdH45MmYUUJgVHKLsf6YlsTlzX0rh10GARLqNFtPU7GeAAyrUp6nQgPhkuNlIZ5VPdluRD
	gTyurQqR2Kq5+C1oMXUGQk4KM8p7vy294SDN0EcNwSzBoiOjb0UHiNbsEZuOfcUr92AyeiODSee
	Dxgr3G02Ft7QsnHXx9YLNeJIWI5qwW1wiAsnh2t/vEhXqYo/19wUGjJvqBq09k+1sKAS6kJpU7R
	no8YDxf4pdxAnO1fLVKlUu+c7xW+Fcga2B6zVuCRPgr4sNEBtbu1FjsgaBYMMM7LL+ZlzzZVEaS
	o2oE2SIvzRkUUrLMUrAK+imLcVWgcGXiHUs+phL8tpFC6nmTUN78mOYzMtYgPxV4XQ8UFUi2bvf
	8rXz/VBfg0jdC3hsrK2/LXWiT8os8EbGV4UYRuIdJ6lKA==
X-Received: by 2002:adf:e186:0:b0:475:6c34:2120 with SMTP id ffacd0b85a97d-47f4887dd78mr2004457f8f.18.1784020926324;
        Tue, 14 Jul 2026 02:22:06 -0700 (PDT)
Received: from [192.168.0.207] (nat-wifi0.uniroma3.it. [193.204.167.180])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f476e9d02sm6291743f8f.19.2026.07.14.02.22.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2026 02:22:03 -0700 (PDT)
Message-ID: <619bb771-1038-4ec1-8d4c-17dc69df33d6@gmail.com>
Date: Tue, 14 Jul 2026 10:22:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/10] Add dmabuf read/write via io_uring
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
 <20260713071828.GB30168@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260713071828.GB30168@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260714_022210_512558_5C2F09ED 
X-CRM114-Status: GOOD (  11.32  )
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

Hi Christoph,

On 7/13/26 08:18, Christoph Hellwig wrote:
> Hi Pavel,
> 
> do you plan to resend this series?  A lot of people are eagerly waiting
> for it to land.

Absolutely, I'm going to finish v4 next or hopefully this week.

-- 
Pavel Begunkov


