Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A49D43361
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Dec 2025 01:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IIn/LcD13PrglPwKrjbzANKOSQPEYp8vSoODGBl4RDw=; b=zUOga4n2Ncotl6L2/8vleQaZx9
	ZUyLsqukjVMYD3mMxAKOttbeE/YsOuUlEmoZqYBP97JCP4W8MTew8H46RnlMd/c720Yo9ta0xG4pe
	IwIju0VJwOAQQ0kWXP3XO0wsDVPiRCmXzuTGULIO9RqJ2bLBxDptFcrmZDa0ZZ/zLQBLn7N2l0HLy
	Myha19FDHXQrIoZChEnYr4mIwkt5tVMEVp2HTJR3UCBASM5BTKEwH5iM9nPge7kfQbAyKLfnwAwEv
	S332Hk2isKPqtJaB8aI4bjRtvDXKC+3lT5ecP/14AgTOH3wDxuFpCPv12JPr+EoP9DTA4bXigyMn3
	64u6VMIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTrbl-0000000HTGT-33Qg;
	Fri, 12 Dec 2025 01:06:09 +0000
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTrbi-0000000HTG6-11Gq
	for linux-nvme@lists.infradead.org;
	Fri, 12 Dec 2025 01:06:08 +0000
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-7bc0cd6a13aso404475b3a.0
        for <linux-nvme@lists.infradead.org>; Thu, 11 Dec 2025 17:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765501565; x=1766106365; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IIn/LcD13PrglPwKrjbzANKOSQPEYp8vSoODGBl4RDw=;
        b=R8LsTHvONpZxDccygdfyu4MxpQawOIpXx2ZzPjzCrl6gawvhZL6aTfng2ouU9+i/hc
         br7PP9BgQBE7Ulx+UU+MaYhyoko5iClisYu+VC8RLo15lrSOTId+t2C4cYU8BZaXOQv0
         QsOz008QUiT8C5tLJRyHFt4cIuHB/FyiQQltJ9LOGr37PP7FQ26dhEtd7UrVREMbGrad
         LXaZGD7kM7dnfOWdpXqRcMyZLF9zhPWYnI8MCLcA9bxxVm/ql2tCTBOVKoVwlIxcfhh4
         e8v08DOw6vm/T2iROFfwIMGP47+2Q95uYBi3vEkGOdvMPvCdEUPo3Dfgmu/SE07yLHmG
         1v7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765501565; x=1766106365;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IIn/LcD13PrglPwKrjbzANKOSQPEYp8vSoODGBl4RDw=;
        b=Yg8rlpOTS0mtNwQsbu71WzPmqzscVf7hoHHDby4ucYVZjINy8f/LnIins7pMoSfOif
         5GAFbpa2ys3/ax7HBO/EQJq7+TEnYwz1h9Vab+sMrZxbrn1v8gW3tRFuBRxjNA7dXgXz
         HuOsmtacmRqCcTysCJoP3kNm0yPbVTPH37yWyAjZpgeOrVFRXuh+lQGVQUUstMVtWnHt
         Qc+8k9qZVrbZoLtFFeAH0ro+G+0GtSw+gOErKNE2b6cwJDV/LfJ3eezDgzxoc8rqBAfF
         73p7ueV4l9XydVf9I5xDbQizZ1UHqYdsEmTyrGs0eBiN8n3t1cm8ZJhLWCaW+kBK+Mkd
         Nqhw==
X-Forwarded-Encrypted: i=1; AJvYcCXz0qbTHTX25Cz04E3NTV6Lsc3Ti13qEKd/kgk0HcFqOC4a1irUNgfS+g6HHa/JEXK8KjQeXuQUTS0w@lists.infradead.org
X-Gm-Message-State: AOJu0Yzvo5wPi0EvjkUPa5XjASVAUp3uYAjBlBVwcpFXOr/xlhBoAepT
	e/z0Uw8Mvs2xkepNZkKX9X5Fj2QF6vQnBBDkU2mRyuunVy/lxKy2a7Kp
X-Gm-Gg: AY/fxX5ZFJFAY0dWvqTGzow1SutNY6393VkCra963NF6UtSJuOHF52sSqJEw0lOiDs3
	MK2o+gXfhdR38flbH7/CArwOe0fYefbhcoNMW8Md+iS7ZV8KtGY/R1YU1essoKbC/X6nAZruQg/
	+jLzoz5hE+Bd2yW2PBIU8UkKr40Uqj7W823+FZoM1q+BkpD5U7hiVVbnc0RoPyha5sjCaDay3Gv
	X/lu0f3OTEa+s0Rv0ErtNezK+i62wlY1bMUy0tFPZhMDDm2Fo0mghckF8hiENsqygDVTdee2ZQ1
	BcRAf5pb8i4yKZEmbPvHcJTCeDSnvUoHbL6kQFX2k8dJUVKNPV1m0LRO/7ohRSds+1FMzmUkAVp
	I3oN4tvh5r28qeJboMzmUsZXOG6Dss+8OT96ryhYijPQEeVXj3cCCyNfwtNn8TECK+gJAHEzuuZ
	wcOK5HE4ZyiqcRuG8U6Nu5M1OkHkpUOUrT07AmuLRoM+dklCbQDeV/MoQfGSuLbLa/x+X7vLmsu
	XqIQQRQrFE6hdMTbBNVx+nvsF72OEBSgbD6jfFVCpYF/ZOub/ONaOij1zirHg==
X-Google-Smtp-Source: AGHT+IEhxHfa3EvqLnd161U/iUsmuB/KO5aMfBcewaILSnv9w+0OotqTV/mO8Q9y2e3SELVXDNPiCw==
X-Received: by 2002:a05:6a00:8c12:b0:7e8:3fcb:bc4a with SMTP id d2e1a72fcca58-7f669c8a4efmr414424b3a.31.1765501565293;
        Thu, 11 Dec 2025 17:06:05 -0800 (PST)
Received: from [10.200.8.97] (fs98a57d9c.tkyc007.ap.nuro.jp. [152.165.125.156])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7f4c5093a56sm3565645b3a.47.2025.12.11.17.06.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Dec 2025 17:06:04 -0800 (PST)
Message-ID: <6edcb112-dabc-41ff-8e47-8b331de12f5c@gmail.com>
Date: Fri, 12 Dec 2025 01:06:09 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 02/11] iov_iter: introduce iter type for pre-registered
 dma
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-block@vger.kernel.org, io-uring@vger.kernel.org,
 Vishal Verma <vishal1.verma@intel.com>, tushar.gohad@intel.com,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
References: <cover.1763725387.git.asml.silence@gmail.com>
 <f57269489c4d6f670ab1f9de4d0764030d8d080c.1763725387.git.asml.silence@gmail.com>
 <aTFlx1Rb-zS5vxlq@infradead.org>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <aTFlx1Rb-zS5vxlq@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251211_170606_289891_1A8433CC 
X-CRM114-Status: GOOD (  13.15  )
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

On 12/4/25 10:43, Christoph Hellwig wrote:
> On Sun, Nov 23, 2025 at 10:51:22PM +0000, Pavel Begunkov wrote:
>> diff --git a/include/linux/uio.h b/include/linux/uio.h
>> index 5b127043a151..1b22594ca35b 100644
>> --- a/include/linux/uio.h
>> +++ b/include/linux/uio.h
>> @@ -29,6 +29,7 @@ enum iter_type {
>>   	ITER_FOLIOQ,
>>   	ITER_XARRAY,
>>   	ITER_DISCARD,
>> +	ITER_DMA_TOKEN,
> 
> Please use DMABUF/dmabuf naming everywhere, this is about dmabufs and
> not dma in general.

I guess I can do that (in all places) since it got that much fat
around dmabuf, but for me it was always about passing dma
addresses. Dmabuf was a way to pass buffers, even though
mandatory for uapi.

-- 
Pavel Begunkov


