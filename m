Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7367D637AB
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Nov 2024 19:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5d6zxdFkPsU+sD0oXkQof2KZyod3gas1uEecLduAVek=; b=0HHmnck/KI2J0rs6fdu/hzTC+/
	e4SJS8SclqQLLVppfnRl0hTRSJlGZ/FarpGSWlkNe0nWRWtiE0z1BxTOxx4vuFpey6Dt7U5av49D+
	yTcyAQluMIf5W0GIdMJK0OIrJ/ZTzlIOpXVeEt9Bfd++9VdxSDFufJRbnP6whQW4CJL+E0jX2ESrm
	mTdDJbGdMgQUivTIBYef/wQU8STd0AqngCtNBtz7fbGwthkoxzBSO5Meenrm/Xu2yLrmjssDsRkFt
	p7OkRzsKKrj9gdMU4CB47UcaWRQ3RL8EuhTPVBZb3IgACT5RHV+rVsR/6Au+Aj70VW6f3rbq5ad24
	93Sby0Mw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBIoO-00000007opM-0ogg;
	Wed, 13 Nov 2024 19:13:56 +0000
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBIg3-00000007ncn-1HBN
	for linux-nvme@lists.infradead.org;
	Wed, 13 Nov 2024 19:05:20 +0000
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-2958f5387d2so2494276fac.0
        for <linux-nvme@lists.infradead.org>; Wed, 13 Nov 2024 11:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731524718; x=1732129518; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5d6zxdFkPsU+sD0oXkQof2KZyod3gas1uEecLduAVek=;
        b=2x1hEheOhoepYZxORB+zy7CkV4qAPTZ19p0d7uAUMYS54PCn8Y8Yylfv34eJKaMd0I
         Xl5AK4Du6XFgZ7b1AAdzyUrO36mkb8Rg+TfGidlmPNp/6Rp1/6L5MiKuaqYOtZxw4Uj/
         cOwxYAABR2VWEF+ns6oGl2IVDWoJQ4QFiCOCpec3gcuUnQYNL1Eku1XExfKEsmqKU8GD
         Dt2IjR+Se+53qkFaCEzY4yWHQPZsDsV27CPgFuDWOaT+7soiDzsLh8vi9fuQHQwrDqbW
         /vWzmXSbGPtZS8ztGyNBbXaV65qR40yut8ONoUli4Cq4mpgZjnGXnf1xjXRhpKV1amt9
         x4Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731524718; x=1732129518;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5d6zxdFkPsU+sD0oXkQof2KZyod3gas1uEecLduAVek=;
        b=EoNZ+6hqaboupUxr0W9rKYXicz/6sV2LcRyXda4llHKKo22nXFQZiYYBTSaJbChxfs
         ZnGP7eVbU2PKUfkB1GgaOYUvTEM38DChzzqyJtcVf0giuW1McC447zmajb79aCiUtiul
         3vqrZ6rS3h3xAVbDlYrFdqHYOLop31FDgEAy6U2lkLaFEWLce3aeO0luwv76QgGQVQM7
         l581bMWf9z9DDJ7K9UUe0Nq9DjTnQYfoo4nQpTOZVqj9mpUjQNXKuAFuDBOreccrVIJq
         9prcWhP+T8aiZN627MYmLCvDdWQQZVTflXHUnWaDAPdeKCfda5unJ/SbfswacfxRC8Nj
         de0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWn+TX6GspvgSkuL7qkIlHvN5hJPSj0fpukZ6X3W251U2oCY6W95p7SjlsXv+2ENi2YIXiXYmg/207k@lists.infradead.org
X-Gm-Message-State: AOJu0Yws0p6FOC6B2mLQN5IsijMnbMfF6cRy0HxvVBik5QNeyGyLadgj
	8OPrqobO0x+1Zu51usBrSF0T/7GqMlN7agRVOuMLQai9/WXchukEPSxJjxCfrSo=
X-Google-Smtp-Source: AGHT+IEqEfISzu+U6ZtkcyQQ168T1b3zcTYcdZM+b6/RCKr3qC5Y1tU76M7H+wd+oi8YKkF3o4FBcw==
X-Received: by 2002:a05:6871:6c9a:b0:295:f651:da2e with SMTP id 586e51a60fabf-295f652881dmr2201325fac.21.1731524717878;
        Wed, 13 Nov 2024 11:05:17 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71a5fe673a1sm865837a34.3.2024.11.13.11.05.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 11:05:17 -0800 (PST)
Message-ID: <c09728ae-1a53-4b6d-8407-07c18fc27e50@kernel.dk>
Date: Wed, 13 Nov 2024 12:05:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] virtio_blk: reverse request order in virtio_queue_rqs
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Sagi Grimberg <sagi@grimberg.me>, Pavel Begunkov <asml.silence@gmail.com>,
 linux-block@vger.kernel.org, virtualization@lists.linux.dev,
 linux-nvme@lists.infradead.org, io-uring@vger.kernel.org
References: <20241113152050.157179-1-hch@lst.de>
 <20241113152050.157179-3-hch@lst.de> <ZzT4CHjrmD5mW2we@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZzT4CHjrmD5mW2we@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241113_110519_386477_543EF2FC 
X-CRM114-Status: GOOD (  11.15  )
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

On 11/13/24 12:03 PM, Keith Busch wrote:
> On Wed, Nov 13, 2024 at 04:20:42PM +0100, Christoph Hellwig wrote:
>> in rotational devices.  Fix this by rewriting nvme_queue_rqs so that it
> 
> You copied this commit message from the previous one for the nvme
> driver. This message should say "virtio_queue_rqs".

I fixed it up. As well as the annoying "two spaces after a period", that
should just go away.

-- 
Jens Axboe


