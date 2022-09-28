Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 200F2C54EE9
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Sep 2022 14:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RlRvct3277EYFToPkW4od6VyhmMFB2bnHNyqnEFyrBM=; b=Y5Egfkfhh6P080VCEX6EDNCdiV
	1i7hbxB9k7CQZRkT7Jh75ZaE27awuPDhAdY9umPoVAU9/ptN48tHdEnrVkShOWs8pqTwzcFiJTxjH
	Nik4zG8rYmOzo2ocn6W1ulxRIt7iH8kX/WEDvbBbRaVPBjN5XdVgml+4s49JJBRJv75/k6QflC5it
	ds8NWU0KMvKMgYAc46+t3ZlM63gJxzJP2ibDgFHJIzjOHPQEklpnezYvxljnmmKwvqPRCGcAaKfK3
	mE44xqE0aaoQA7X+cYlAMrFp2QGv8x4eOfYcCONHlTHws7ON8L1OfQDW2kLs/cZOdTwp8ZFW7crPf
	hYkE0SCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odY2j-00GgLs-Va; Wed, 28 Sep 2022 14:28:10 +0000
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odY2g-00GgKq-Rb
	for linux-nvme@lists.infradead.org; Wed, 28 Sep 2022 14:28:08 +0000
Received: by mail-pj1-x1036.google.com with SMTP id e11-20020a17090a77cb00b00205edbfd646so2515399pjs.1
        for <linux-nvme@lists.infradead.org>; Wed, 28 Sep 2022 07:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=RlRvct3277EYFToPkW4od6VyhmMFB2bnHNyqnEFyrBM=;
        b=CTdt4QqtPWlmjOer5e4jfzrIOLyZndPvQViX2DxuaaYRi8jdHNRDhr15r7TTLmXcif
         ebtsA7cI6Yht1jcDtTlaI7tNQWSyu3lyLXeJvrYgKh2N6YcU+2pmRUbVjWWDCE00cbeg
         CHLGEXblutHx4aNfjvq7TzZheZqNR2IMKSDnFFZItikZb4W9FkWqXYG/Yyghk5Y/aEwT
         Ety7xrr38GrtQZE8vq52oiX0kfyEPpqLuMs8SlObeRtqUOlmpbe7RPUep0w/NeKfsql0
         6R5KsKOtX3ryXHOHNa0Qop+K8XGpOtUsbEPzMExvi7giv7WI3IsfIe2zhzJYnGWRov6U
         cyYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=RlRvct3277EYFToPkW4od6VyhmMFB2bnHNyqnEFyrBM=;
        b=VvfNQDvVcK/nA1lOM10xLEcEXUE47+6jWXa3ftbxHZLNNh/47/SXLyuQIAeMNYufm1
         HhERpu5A+zIdXqlBYrdv4+MISlDDPA9y+Y6lmeyG/5rUI2jSIXmig1l/prsfMsNW7cm0
         P2vyztJb9w2AvHn7H33w07xf0gdj+pHsl8TR5UTCfncs8uX1nhdriFJawWdpuOdnsaYj
         yPMCGQ2VmM0rE+xZp43RfaLNIjCl4kRB0licvBdKZ/tY9OcSejQN+O5aeTd7LzFrNIDv
         m5v/S85eL5pQocXMxgUusPtCLlyQ0X//gidtalmA2l3z5ybqPXaCOOOGXDw4FW6iE5T4
         oziQ==
X-Gm-Message-State: ACrzQf1thCrX23tA6Eezzo7LTHolNeBvBpOA4ywUfYNiCDDulU7ybNDN
	TD45nSajDlJ2vOxGATBhXWJZQw==
X-Google-Smtp-Source: AMsMyM4REYpTDSAfEZcJo3ADi76E0K/8bIe2v79W+pe1cKZ3OjTnXEc2ij22YaVeD7Sl7qwFecHbkg==
X-Received: by 2002:a17:902:dac7:b0:178:b5e0:3627 with SMTP id q7-20020a170902dac700b00178b5e03627mr72355plx.147.1664375283710;
        Wed, 28 Sep 2022 07:28:03 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id u8-20020a170903124800b00178b717a143sm3907725plh.126.2022.09.28.07.28.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 07:28:03 -0700 (PDT)
Message-ID: <96154f6c-c02a-4364-c2a8-c714d79806d3@kernel.dk>
Date: Wed, 28 Sep 2022 08:28:02 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH for-next v10 0/7] Fixed-buffer for uring-cmd/passthru
Content-Language: en-US
To: Kanchan Joshi <joshi.k@samsung.com>, hch@lst.de, kbusch@kernel.org
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, gost.dev@samsung.com
References: <CGME20220927174622epcas5p1685c0f97a7ee2ee13ba25f5fb58dff00@epcas5p1.samsung.com>
 <20220927173610.7794-1-joshi.k@samsung.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220927173610.7794-1-joshi.k@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220928_072806_922115_1BB48E68 
X-CRM114-Status: GOOD (  11.49  )
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

On 9/27/22 11:36 AM, Kanchan Joshi wrote:
> Hi
> 
> uring-cmd lacks the ability to leverage the pre-registered buffers.
> This series adds that support in uring-cmd, and plumbs nvme passthrough
> to work with it.
> Patch 3 and 4 contains a bunch of general nvme cleanups, which got added
> along the iterations.
> 
> Using registered-buffers showed IOPS hike from 1.65M to 2.04M.
> Without fixedbufs
> *****************
> # taskset -c 0 t/io_uring -b512 -d128 -c32 -s32 -p1 -F1 -B0 -O0 -n1 -u1 /dev/ng0n1
> submitter=0, tid=2178, file=/dev/ng0n1, node=-1
> polled=1, fixedbufs=0/0, register_files=1, buffered=1, QD=128
> Engine=io_uring, sq_ring=128, cq_ring=128
> IOPS=1.63M, BW=796MiB/s, IOS/call=32/31
> IOPS=1.64M, BW=800MiB/s, IOS/call=32/32
> IOPS=1.64M, BW=801MiB/s, IOS/call=32/32
> IOPS=1.65M, BW=803MiB/s, IOS/call=32/31
> ^CExiting on signal
> Maximum IOPS=1.65M
> 
> With fixedbufs
> **************
> # taskset -c 0 t/io_uring -b512 -d128 -c32 -s32 -p1 -F1 -B1 -O0 -n1 -u1 /dev/ng0n1
> submitter=0, tid=2180, file=/dev/ng0n1, node=-1
> polled=1, fixedbufs=1/0, register_files=1, buffered=1, QD=128
> Engine=io_uring, sq_ring=128, cq_ring=128
> IOPS=2.03M, BW=991MiB/s, IOS/call=32/31
> IOPS=2.04M, BW=998MiB/s, IOS/call=32/32
> IOPS=2.04M, BW=997MiB/s, IOS/call=32/31
> ^CExiting on signal
> Maximum IOPS=2.04M

Christoph, are you happy with the changes at this point?

-- 
Jens Axboe



