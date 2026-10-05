Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55425CA5FCE
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Oct 2026 11:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZTSRnK/72f03OAFyRZNcD9D1Hs2QM4XwAkI8vZWB3T4=; b=YMOjFAI9+sd7XsdDuyJ70jT5ON
	AqS5qlW7vMXX2NvCoCXVhKosiEU27P7T8XdHrR7COuXQbSxX1JkXH36DO4cPzG4uDMWf/+CMQ5yam
	EMcAB/smnuEnV0WXWXEubH8Bj/6psA0kcPrA8pxNbTNS0rUfOSeV5qBPvLcpLVgc14V1QxQRNms2m
	6QQGUT6YRE86fb9/EzoHvImLhlTdCu8Wis1p2xFZKu9exHby6TzbcnqtjIA7BCB0hBuDWr6EojB9J
	Mez/7uoHP+ONbXxWQFak7BhihV7Wte6oQDRXSyo3AygV6R2xGFCARaaMuvX9NAcDwOC4srUBu+D8u
	lyPzdBDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xDh9x-0000000GMGn-1WsH;
	Mon, 05 Oct 2026 11:47:09 +0000
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xDh7t-0000000GM4t-2BVP
	for linux-nvme@lists.infradead.org;
	Mon, 05 Oct 2026 11:45:02 +0000
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-48bbb06e746so744956f8f.3
        for <linux-nvme@lists.infradead.org>; Mon, 05 Oct 2026 04:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791200699; x=1791805499; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZTSRnK/72f03OAFyRZNcD9D1Hs2QM4XwAkI8vZWB3T4=;
        b=OhdEJNDRUxC5giQ5EeEuEYm/0VKzMomT2yCKrRPA3NulcVZzCSCOHnweIf2DLvuoQ2
         WdOGicMQaM/MWWy17B4jWk91EPPnq0RZDMWbGKGK1AWLD1DbG2A4f4d7io+okVhbc5U8
         EsygXFhComPGuvArMWudsGue36+Qb5yi7GandD3jC8s4ohh5ERdNX7HNDBm+F1AcN9cU
         nWDUPrTzGZMXj/oswwTzTOhA4rzBuIKofKnG+nm2OpRHp3pG9V65VwsRV5Xjak19EqWJ
         29g2qB48Sirw87/9eNof8EEXDrK61+nqvUUhri6qerp3LRDZqs56tmmt4icQL95lnhTT
         E42w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791200699; x=1791805499;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZTSRnK/72f03OAFyRZNcD9D1Hs2QM4XwAkI8vZWB3T4=;
        b=JB605NWzVOdAMaZnGY3gzDDoXeOvb9imbjVl4kqrxBYWC472OIovpjMI/qW99VYiHT
         eIveJARRSY7m7736vb7YYAdeoCHzcqlcYu/P8GmGzKP1qZPZnXCCi246kEUgHZP6irNK
         8w0GzuRfb3iRT60mUigXbanQhles+2st05EFdfraohhT+FaUKLdFdfnf34kKEgnBZsns
         HWKtsdd9wm9MFH4DzPbpsZzENxJJQX5r/aUf2th2tTCMupKQiEhQ4xRGcukVr/wKCvTb
         HK8S3Kpdgm170VW3OIglw+74Pof5bATF8bGfI3GzQF2lpapy+eTENJQTNjAvApmJrFsg
         wO7w==
X-Forwarded-Encrypted: i=1; AKwUvBzq8b59lbhhZisuBo6AkfoeQeEdcnqZWD80PanttNfm2OHKD1Bg/T7I3asA6DwgBkrCxqeByg0QSS2A@lists.infradead.org
X-Gm-Message-State: AFq9FYLALSFOnZ3jUvXCJgOo0gsGp0/1NRwortbs4VMBjbjmR3xJZiGZ
	U8j3z9jgbBXjcf5LsZFnxke8cS7LK2ubdGH07aBJymwXhPXetzKrF7FM4gq3jg==
X-Gm-Gg: AYBFou379NKJBajlOLSIoMYWvKErrd4UdexvuG7MSkAsGCIu5O1ZU+dqBi/T/BzRAx3
	DjUNPdbzlkZ7q6w1R9NMusrulhcMmjXoObImJs3TxF+OJ4P9TKvc4tbYOhgOVSbSu8Av1XOBUh5
	ZVPRWb7Y8HVrFaiqLjgMceCbh/fm63dW/xfzclw3BHPLGl5/Zv8O1DE65tZBK9wSpHBUrlb2sWG
	8S5w61OheM5S5GpJuge2wRNOR9fqdoupNHvksDikrW4zyxlXWnaGgHtAFXMlVppMn+R0XPZ4IU9
	ltdrSZKJbwG9RJd8EqhaplUqCJZL8OJ1BdfrvGjQrQ7ea+lUt2zQGXZ1NKlplBjJbB521/xU3F4
	GSoTeH1oV0vpX6IttsbtVeB/pkgZjX3FmPagyqF69ELETMAUMigpqvIkIK9zMMC5snNP8v95RO7
	yADr6ywPLJl1RviMhbFaQsXw323XaP5Cy74oDsHGv0KHcyqg/48QzJwlKrhnJ7KaBsAadvKQA9y
	cyvEVIb36JX0RRfuEe0moPTph00V8UaP8YFWvTe75V06LZQEGypA3PSo7GiL1RpTEm5IKI0XFM=
X-Received: by 2002:a05:6000:186a:b0:48b:6bd:1af6 with SMTP id ffacd0b85a97d-48c48000099mr10478688f8f.40.1791200699411;
        Mon, 05 Oct 2026 04:44:59 -0700 (PDT)
Received: from [10.41.30.1] ([161.12.45.16])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c62270751sm3087877f8f.13.2026.10.05.04.44.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2026 04:44:58 -0700 (PDT)
Message-ID: <fb0ec34e-deca-4365-8802-23d5688612e6@gmail.com>
Date: Mon, 5 Oct 2026 12:44:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 02/13] iov_iter: add iterator type for dmabuf maps
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Matthew Brost <matthew.brost@intel.com>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>, dm-devel@lists.linux.dev
References: <cover.1790602223.git.asml.silence@gmail.com>
 <74a9d65f5c4f9acce5f57ad5921a9fadc6eda712.1790602223.git.asml.silence@gmail.com>
 <20261005091008.GA10727@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20261005091008.GA10727@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261005_044501_598912_D3EB6B85 
X-CRM114-Status: GOOD (  15.93  )
X-Mailman-Approved-At: Mon, 05 Oct 2026 04:47:07 -0700
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

On 10/5/26 10:10, Christoph Hellwig wrote:
> On Mon, Sep 28, 2026 at 02:32:18PM +0100, Pavel Begunkov wrote:
>> Introduce a new iterator type for dmabuf maps. The map in an opaque
>> object with internals and format specific to the subsystem / driver, and
>> only it can use that subsystem / driver for issuing IO. The task of the
>> middle layers is to pass the map / iterator further down, maybe doing
>> basic splitting and length checking. The iterator can only be used by
>> operations of the file the associated map was created for.
>>
>> Suggested-by: Keith Busch <kbusch@kernel.org>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> 
> FYI, I think the Sashiko complaint about iterate_and_advance2
> is correct here.  We don't really hit that in the series, but leaving
> iov_iter methods partially implemented and fall through to others
> seems dangerous.  At minimum that needs a WARN_ON to catch that case.

v7 already covers iterate_and_advance2(). It complains about
iterate_and_advance_kernel() but there are many types this one
doesn't support.

-- 
Pavel Begunkov


