Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A8D1C54FCD
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2026 11:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p8KbmJYcU1SAlCdU+OP1hBT5okmuW3fRl/0GYAxB+Rg=; b=inhZ6ydFUJ6/f91/ZhK+52PWOf
	QchK4CQt6qN7VD74EFn9VWMUTXgeRa+7/UqATQlSqd+vNUqbsY+AJoKKzbvV6E11e4KBgmSJBKZIM
	01T8FIWaXEr4j3/DcXY/lTm6V1OmGb4gL/lDPSH4ymFwNR5JNJzeMoKtPXTaJO53qQ+srQkHGzaKJ
	p7LeF0FhHQ4uX+rWLJiTQ1GhqW9WeifVzP5sUAAbdjrw3y/WQB/UxftZMa+oWMhsqTr41cYkXPIBx
	7hYQx8EDtXZotbegaMFHcfevEfd2lQIqKKNNj7ZOBlRjwmrCnT/sHt52KyHArynb+JAKAGKX+JPPI
	LQSa5RZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp24r-00000007fzJ-0lve;
	Wed, 29 Jul 2026 11:03:57 +0000
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp1fH-00000007ZG6-3sir
	for linux-nvme@lists.infradead.org;
	Wed, 29 Jul 2026 10:37:33 +0000
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-69ffbd2a277so1208692a12.0
        for <linux-nvme@lists.infradead.org>; Wed, 29 Jul 2026 03:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785321450; x=1785926250; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p8KbmJYcU1SAlCdU+OP1hBT5okmuW3fRl/0GYAxB+Rg=;
        b=Xf7qNpjo8AhHK7ntB552/xJL8sUFGq3WoJEyAd17m/tRtzuAphS1h3OcYrcQDKz5z2
         Si2BYhW2hrINUzya799FDhB5cFgzkP9YOaVMRcN3xn0B1SWB/8WkcPXnTIQqfY9F8DDv
         sxYsFbOBpX+z7QANcvH4rcF+fONILqyxa0O0Ap5KrLXktO+185sBiB0WBNgJpNzuyCzR
         sdh1n9KYgqq6K7QOZn1eEGDrMyRye9hx+RJNToWko/aKC9Wa+j2oJ8zDj0xkdqbecMDw
         8bmsKV/C6kcQ4C+xVqYWyflgbZU6Elpu+8JzPR/kxqDvQ1Gr66dTALlXb3fCrbf6J+VJ
         km4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785321450; x=1785926250;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p8KbmJYcU1SAlCdU+OP1hBT5okmuW3fRl/0GYAxB+Rg=;
        b=jHnG7XUgJa+Fk5n/0LrzgEO5a3Qysc19jiMTToJXIuWSpxHqlor2hplqau2cr79mSV
         ip2RSuDU/uzKiNzdsLlePFbMKABLkkGvpM2NHPMLy9uFv976ibgYmSuSoOFV2aY+ZsY0
         ukxxqVmCraPAQx+Ur079vZbRY74BipbqTBDZhEWm0eerV0+XC9kVBw6beyarIsusz0Lq
         7VDTTZFEecdQJ3GYTY6VlO/As1yAMyCJwHdharh8NgLnFpMYs+/ApN0t9uv1/lJKCtut
         YRyg0TjgmeLQEKPYE0McKQwCcy4zXNFSwOl5S8UTfn3BfrOzS7bS2QbHiwkXKAjEMiuM
         i7Uw==
X-Forwarded-Encrypted: i=1; AHgh+RqUtpNXcysBpB4VKxW8EJXdcGtDOYmF/xB4VAivT9Pq3fvk8PZMxsgAEJPjzLn/mu97E7K4ojx54i+E@lists.infradead.org
X-Gm-Message-State: AOJu0Yw8nnrN68Q00+OzMLVfQSEDZP7Hp2Vx8dCTDm0BQ7Wc8fGOK3nP
	UEOTHWtmrwkc30JGZGVOIRaw7VBL61235cOj9ilSPedZLaqSam3xyWyM
X-Gm-Gg: AR+sD12SXZ6sykq73ndNBMIZzZykWLB5OWnp0uBzWg9Og2svMUFQXoNGo4v3omixA0j
	SO6zdOyhaIsKmqBMweYN63RBMpTpbUHfmb6PgXSgh1atGJFidrT0DeR8j2riC8SLi4gKpj/rQCp
	DZOJT34z9myO+Fv75ZkNgodCAL5jtEMOnf1TEfacbrM/Lz08UX/6rmj1i5C/FsAvXG/wPuR3frm
	NENRkoDFgd3nSAU/s8n2ze2Rp+aKD+W7yD52J1LETrHYu9xnM4Lhh+FKynrXw+1L/Jdf51pgVuV
	reWcFqGPmGSJ6vXv1I1aKGjztHTIkMu7mJOuNuNqCaFbyl/40UQk5pVRt2rp+LuIv8oTSmAGtbw
	nL7mR5DbgaQZrBzEhidl8gO5wfPoeBZgK+pYy5ssVb/fy/fwNF4PnL6yXvIOI7awvIuyJQNqJDb
	uyTktnKfW0d0RaPCVHmoDr65HWPESB6urwQ1968cbOtWqD8OAV155WAVCK0NtzayRoXOYW0BYgN
	B1TGmc4v0Jh9UhmLzYueh5TXkS9/e1P1AY7IkgcbP5nPabnRIzZUovhHcLQoYeslDzQHAh+r8jJ
	dASkFkCjpTIKgB2p+j4=
X-Received: by 2002:a17:907:9617:b0:c1c:62b4:1ebf with SMTP id a640c23a62f3a-c1f721913ddmr365145166b.60.1785321449861;
        Wed, 29 Jul 2026 03:37:29 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:640])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1f84026c47sm93918766b.63.2026.07.29.03.37.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 03:37:28 -0700 (PDT)
Message-ID: <340dd033-2a45-49e7-afd6-95dbbbf624da@gmail.com>
Date: Wed, 29 Jul 2026 11:37:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/14] dma-buf: introduce initial file I/O
 infrastructure
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Damien Le Moal <dlemoal@kernel.org>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>,
 Vishal Verma <vishal.l.verma@intel.com>, David Sterba <dsterba@suse.com>,
 Ilya Dryomov <idryomov@gmail.com>, dm-devel@lists.linux.dev,
 nvdimm@lists.linux.dev, linux-btrfs@vger.kernel.org,
 ceph-devel@vger.kernel.org
References: <cover.1785274111.git.asml.silence@gmail.com>
 <bc20381e8daf85ac58811c344325d8192cde9d1e.1785274111.git.asml.silence@gmail.com>
 <20260729065927.GA9534@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260729065927.GA9534@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260729_033731_985527_29CB5090 
X-CRM114-Status: GOOD (  11.41  )
X-Mailman-Approved-At: Wed, 29 Jul 2026 04:03:55 -0700
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

On 7/29/26 07:59, Christoph Hellwig wrote:
> The method name feels a bit convoluted, but given all the
> previous discussions I don't care too strongly.  I'll leave
> the dma-buf side review to those who understand it.

I assume you mean this:

+	int (*init_dma_buf_io_ctx)(struct file *, struct dma_buf_io_ctx *);

I agree, and all dma_buf_io_[ctx,map] look clunky, but I don't
see what I can drop out of the name. Suggestions? Maybe I at least
should make the fs op sth like "register_dma_buf".

-- 
Pavel Begunkov


