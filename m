Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86FDFD637A6
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Nov 2024 18:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WgXDWP6uTO9OvPO11ONSGz0dajsnDJA8Ia+wd76L1pU=; b=g+Et5hTLmA5Ym2WFwD/MmzcUc0
	72vyhCrswPvoOpwrQl3wDupR2Dkxcmw0n6HF9dxgO9pEqHxLFzXwkIik0bed5h0af81TUWyM/m2oC
	RSoQlsV4bpnMT86JVLIbr3KnnKuo4OUTaJBC581vEV4Yl3GQcD5GZuflohZ+91rkYYOxFfxCGPreX
	sIneRNt9go87J0nQGzOp2NU28Vbl6ceuER/LcYXtCmY6DnwwtJ6rkQoUZMM9KL6E6DvmzIzah4qqx
	Q0FMQ3v/YYcMHSgDupiNmdKlba882z5p37YLPiEYSi7hF0yEy52X3jyqEzqZQtCxfL69fvZzgDXk9
	2bEunySA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBIJE-00000007kb4-40oz;
	Wed, 13 Nov 2024 18:41:44 +0000
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBIHV-00000007juL-1ien
	for linux-nvme@lists.infradead.org;
	Wed, 13 Nov 2024 18:39:58 +0000
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-5ee8eaa1694so1061297eaf.0
        for <linux-nvme@lists.infradead.org>; Wed, 13 Nov 2024 10:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731523196; x=1732127996; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WgXDWP6uTO9OvPO11ONSGz0dajsnDJA8Ia+wd76L1pU=;
        b=szpOcApt1uqTtkQRHvDgcMSG7/40j6drOIRUESJhEO3uUFoF2UbbENRgxW20SE/AxQ
         PNcTZ1CZfBYpf9UY9NuOc9ATmsZb0id30eEX5H9QjfvF3atY7S1BHUqUJLn3lT0X7Jmq
         PDv1Wx2eujk4Kph1EgPqTVOFUWlCK+jr/SqtFPrlnxlvztRqBXTPSfn58fpKgBQu3Xrn
         0CCHSdVBJhxt4aVKo1fj1DGKccZQfDC7cM+cPn9H77hroCWPdL0OZtUkrDgc5IDoISfe
         496YtmqLHWj2AWLDLEDaSPUNqVHVmnusYUYMHZgBTGyYecec2nK1prGjSHQwcv4KvZTR
         H2cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731523196; x=1732127996;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WgXDWP6uTO9OvPO11ONSGz0dajsnDJA8Ia+wd76L1pU=;
        b=N11TIyjmaVHCwCY5AS8GZModETLVH6BRLJiRRnB8hlWkZDuQHnUuMgDtitR2SoJa82
         jrqqbv5M/36U8bUb9GeBdLbXE12EuqYFhTSRbtDSO7PSFsE8cMfB5V74YKIT3guKEjZ9
         loXdbsz84nXJd2S1qH9OB86Arv9/IuuczBrOAgzQSg/+T0sQrIxuU/aLrsl+nIVxnXpq
         JxTgdShFZI1WKLZH6qaDnw5gfRsA9H5lohpUYtkvL+fIBPq+gMvWM+13K/Xni3TYQYMt
         o0n2OJ4xPrS00BlTd2pEr17lvQQMx9GtvK0tRJGZHQzqB8V5vS4liw4gTK/7J5FLAL44
         C5Yg==
X-Forwarded-Encrypted: i=1; AJvYcCUPhzwlZghcX2SCcKsdBN7kML00cTe2tsFzRJH7q2ZgtnEwFnXwEWVG8uTFAfAvqF6Y8dKZEbF62AAd@lists.infradead.org
X-Gm-Message-State: AOJu0YzHs8s/l2RWVOdfrpbEfF3yCJ2+WGyJxu/PFTkjmKPhyezBrLH/
	M36ziKXqgg3QSRB7/LmRJp+OQ7ZpupzHJPYxdS6a1pOcY1juXZILma92TEAJCAY=
X-Google-Smtp-Source: AGHT+IESBxgtKu/tqS069ieokYdQsF86VTGk5XXSX9JBOM6NYNLoE/FOQHmxs2aJ76kIzJOEXUf+Gw==
X-Received: by 2002:a4a:ec4c:0:b0:5e1:cd24:c19c with SMTP id 006d021491bc7-5ee868b0bf0mr6129208eaf.0.1731523194524;
        Wed, 13 Nov 2024 10:39:54 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ee4950edfesm3141888eaf.14.2024.11.13.10.39.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 10:39:54 -0800 (PST)
Message-ID: <ffe1f8e9-5484-43f9-a410-2927d0c63659@kernel.dk>
Date: Wed, 13 Nov 2024 11:39:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: don't reorder requests passed to ->queue_rqs
To: Bart Van Assche <bvanassche@acm.org>, Christoph Hellwig <hch@lst.de>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Pavel Begunkov <asml.silence@gmail.com>, linux-block@vger.kernel.org,
 virtualization@lists.linux.dev, linux-nvme@lists.infradead.org,
 io-uring@vger.kernel.org
References: <20241113152050.157179-1-hch@lst.de>
 <92954431-349d-4b75-b63f-948b1df9a3fc@acm.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <92954431-349d-4b75-b63f-948b1df9a3fc@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241113_103957_491693_AF86F116 
X-CRM114-Status: GOOD (  14.89  )
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

On 11/13/24 11:33 AM, Bart Van Assche wrote:
> 
> On 11/13/24 7:20 AM, Christoph Hellwig wrote:
>> currently blk-mq reorders requests when adding them to the plug because
>> the request list can't do efficient tail appends.  When the plug is
>> directly issued using ->queue_rqs that means reordered requests are
>> passed to the driver, which can lead to very bad I/O patterns when
>> not corrected, especially on rotational devices (e.g. NVMe HDD) or
>> when using zone append.
>>
>> This series first adds two easily backportable workarounds to reverse
>> the reording in the virtio_blk and nvme-pci ->queue_rq implementations
>> similar to what the non-queue_rqs path does, and then adds a rq_list
>> type that allows for efficient tail insertions and uses that to fix
>> the reordering for real and then does the same for I/O completions as
>> well.
> 
> Hi Christoph,
> 
> Could something like the patch below replace this patch series? I
> don't have a strong opinion about which approach to select.

I mean it obviously could, but it'd be a terrible way to go as we're now
iterating the full list just to reverse it...

-- 
Jens Axboe

