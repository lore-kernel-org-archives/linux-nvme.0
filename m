Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D020C6FA90
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Sep 2022 15:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aj427EoyOIOpXGm7xFat3kqE/v++sDMs91pMGtHoDng=; b=BopbwufLjylFDcWOwJTkxpWVkt
	dmdm2qL4cNTbl23fuCTsg5pbhnNJCKf++WHb8l5OPrsYVV9VnXGQ16P9fLxP+kWrPw3sjZ4V6LgQo
	sNXmUU44AmUT9PDgKvMec/Z9kJvdLQJeFS66OIxoGruXupoMASYWwOJ2xpJuxbw7fh0sqUUiv5alm
	8/NtFnHT+KfM0byEKCgB8+8YEFlGxilxoq7DsnJHzaorsw1iSso0r/NnGo+d+ALJ3WKq+SdAAC1jb
	tqz85o2vyrSuolV7hdJ1EQlcPqXi+NcbaUyqx1BEXPFy5ahQKbrB+ZEp2UDl8bmUkWYIfjadyAlhy
	36+ddnZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obkW1-004nau-VZ; Fri, 23 Sep 2022 15:22:58 +0000
Received: from mail-io1-xd32.google.com ([2607:f8b0:4864:20::d32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obkVz-004nZd-VI
	for linux-nvme@lists.infradead.org; Fri, 23 Sep 2022 15:22:57 +0000
Received: by mail-io1-xd32.google.com with SMTP id q83so173425iod.7
        for <linux-nvme@lists.infradead.org>; Fri, 23 Sep 2022 08:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=aj427EoyOIOpXGm7xFat3kqE/v++sDMs91pMGtHoDng=;
        b=RuQ488wvYkdtTlucK5RLBdMTThXD3sbSSbXW2cXsiqxLGIQK9mZXy5XJwisC727RR2
         v1mOFOB7KncwMOjpCHSAXz3qJc2PzLN0zAd98/cbaGvOlm+ps5VKAnLSRfoJV34OlrrG
         JFdo/85HBFYbI6eFHMMj1Th5685EbncE1VUJ6bizqOlthoM+mwyji6AGoxxTRvpyQncm
         +SSO5GLwHgMMD8fKQ3gaCWhXQJQvkMJCt2NX3QddiRi23dN7pVD+rPrYWNE4oqp81NKM
         OQIa9oXnaJZYufjF49owWISPcocZ781LqwxyhEOPEcT8FOD8SiV4w1FitmMR9Oo0QFqr
         +9OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=aj427EoyOIOpXGm7xFat3kqE/v++sDMs91pMGtHoDng=;
        b=tFMTHCZCr/xO7ifwLL1hQOloV8Jz16PU/8Nc5USUSpTJGrbETQJNY8dHxdTwPcR35n
         ECuM1qP/WiX7XJ6PYdsyw0HfLQD5TaCYa+98IVIwLak6+XZ8Tp+43DkevXOQRL+8yy2Y
         3h1iW+89XCTQdSdZ36cdrE3y7D0hBSjvYF7ikZ7/xFZSy9DVjM6NiAkSA4DKEIAmveX8
         8fKTdGNfk67//K2I77fVtezSsPj1jCGXdCALgpyR6u3CHC1ALSZlQyjwVoE3P9jTYCtq
         iAYj1vMIoyMH7OyOMpUYduwGLhXaycJGursmgvOm0iADyxSEWLqGKKJbncuUPTDgAsU1
         j7tQ==
X-Gm-Message-State: ACrzQf1DN8ZfVyKhkHT8w/JBVkA2olNEqStsEyoX2Lj4Sin8MNfzZSSZ
	Hw0nUFYorfgTD5wpluBjqsTtew==
X-Google-Smtp-Source: AMsMyM66wPHtkFQ9IeC/C8z8JolIyiwSxGByINDT3QSo+pKmW5TeLs+OL/+8aAXBzDYx8annuJPNzA==
X-Received: by 2002:a05:6602:2d44:b0:6a1:b558:272d with SMTP id d4-20020a0566022d4400b006a1b558272dmr4127633iow.7.1663946572978;
        Fri, 23 Sep 2022 08:22:52 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id x3-20020a056602160300b006a19872663bsm3575750iow.53.2022.09.23.08.22.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 08:22:52 -0700 (PDT)
Message-ID: <11a6e8c4-690c-d1bc-70fd-8dd33825fadf@kernel.dk>
Date: Fri, 23 Sep 2022 09:22:51 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCHSET 0/5] Enable alloc caching and batched freeing for
 passthrough
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20220922182805.96173-1-axboe@kernel.dk>
 <Yy3NyACongSfayY+@infradead.org>
 <6f7600be-d4b9-aeac-7dd1-71992a4dd5e8@kernel.dk>
 <Yy3PEjD2pkSq84RW@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Yy3PEjD2pkSq84RW@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220923_082256_035664_82C480FB 
X-CRM114-Status: GOOD (  14.15  )
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

On 9/23/22 9:21 AM, Christoph Hellwig wrote:
> On Fri, Sep 23, 2022 at 09:19:15AM -0600, Jens Axboe wrote:
>> On 9/23/22 9:16 AM, Christoph Hellwig wrote:
>>> On Thu, Sep 22, 2022 at 12:28:00PM -0600, Jens Axboe wrote:
>>>> This is good for a 10% improvement for passthrough performance. For
>>>> a non-drive limited test case, passthrough IO is now more efficient
>>>> than the regular bdev O_DIRECT path.
>>>
>>> How so?  If it ends up faster we are doing something wrong in the
>>> normal path as there should be no fundamental difference in the work
>>> that is being done.
>>
>> There's no fundamental difference, but the bdev path is more involved
>> than the simple passthrough path.
> 
> Well, I guess that means there is some more fat we need to trim
> then..

Yes and no, there's always more fat to trim. But some of it is
inevitable, so...

-- 
Jens Axboe



