Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72D71CC6B19
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2026 20:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z2hIuYUY9dxFL1uM5B7+C8H4OaVqNBpDv98EiuOQjRo=; b=Ukk/gNoGqV26KbU7s+xNultcIo
	BHXgnwObMKReIJIewMQf4L32rtmKH48eKmB/sKtjpMfbzTWa74t99JKJstqb+HAk5f8hM7Qiz/2Fp
	4aldEeCGZkTRGtCOmaGcic9vf14+0XuGNS4FnT/vUqWTP9CFm4IkpvcCeSj8EzEN4uyMYi5J1xP2u
	MC2twIAsEtVk4pnkNVxJVeEmApvSiatY1iDrlHF0azVJh3nGBWH4m+/7kHhjywpBhQixxZjEAn6BH
	9J2WmEGln15SkYNL3n2aUfDBLJI0Xhxguo5fmuFVyBfninnNEE3yEjBxz1NyyAW4owGnnEPNwX1nI
	PIlwPe/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGisD-0000000DzFJ-41zP;
	Tue, 13 Oct 2026 20:13:21 +0000
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGisB-0000000DzEz-1YfC
	for linux-nvme@lists.infradead.org;
	Tue, 13 Oct 2026 20:13:20 +0000
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-4a16aaf2067so3542845e9.0
        for <linux-nvme@lists.infradead.org>; Tue, 13 Oct 2026 13:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791922397; x=1792527197; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z2hIuYUY9dxFL1uM5B7+C8H4OaVqNBpDv98EiuOQjRo=;
        b=Y2Gjyyyv0dYeC1nXvilqKqRk991sxl3GusfmC57OD+UAhNyi6hS3vFdKYSzW3PcH/z
         xXc0EbIhNQGUZ0OEsRE0HLa30DHFRIuzEAICDbNm/IAUMSC3NwxjWaYdltMY1LucCLR/
         PV2BGSlkZlM++vqqHXNxAkVIc2zFWy2AU+9pk79hT2+1Em8E1+LNRcBHSZi+GN4VZtim
         zRD35EM6TwoxWCQ+AiskqPow+4Gk/lxFq7ywOrzXqU8mwSTXmv0pFLS6q3fgeVcNI8SI
         UetL3V/dgdGD3fbVu4nOD49WaGC6z5T1nNzS0OZeQ3C1HLd3OcU7hSf5ZwKXgFhj5RZr
         byUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791922397; x=1792527197;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z2hIuYUY9dxFL1uM5B7+C8H4OaVqNBpDv98EiuOQjRo=;
        b=fszDefhBUvjVNqZDZ6X3EUy5P/GPrpH1Nqm/H/1ZU5HnNULPpAXd7JPefRVaZ3Kj3g
         NIGZZRu7e3i9ayaqxGUvnGdT2/0QPlhJExNfUsSboPUW7EpaamWI34WPaSG/UhFmU7ge
         +WQozpgYM7BT/UUI0FeMUTOxVcHq92XmHPILZi5Bu/qBs5kdc7nb5iO0twxP5EVXd73t
         tAT5pXZNsToSYALRTfqf1FaXbgWBzjy1oavnxi66bQiZCDJqeFo7mKZ/bqiH4CVWzqnR
         sbD4+TiWyDrs9YRQc6i/FcvQVsd9pM4WOsT3paBbLfdXM+27rhasMsLJTEe3NgfcoUHI
         TZvw==
X-Forwarded-Encrypted: i=1; AKwUvBz7EywXUo6H/RbUInf1+LNdj8QBYFDZfp0YXt8+0z4RW8WAqmof4dWIqI9G7qz1RfzV0d8vk1tdV87z@lists.infradead.org
X-Gm-Message-State: AFq9FYJfVZbH7hG+JowyUC33PUPLFK3nVTlVFXTDlGywDQfYRn9F7K48
	K+QHUJyPPaEhiIYuOixCvNz1U2UiAs8namH+X2nK0AnrItoLklB+4feQu07Xrg==
X-Gm-Gg: AYBFou3Nljdyv08LgA+fP+Hn2kw1voVNNLicGl4gNrDy7PNbXyx6GIvSo/SW861FBb2
	uJFl5kn+FMYCyla7G6qIK8LqtRHeANafnc7hPDJEqlFgU5QiREcvl7WLbbJRlVdQpP6U3jeCyJj
	GMBgLa9l6GBum9Sf3GQNI9d7sWto+Frfu67FmHg4qaHWLyyeFkjY7OtKBDVm/HxaSlPwCuXdv93
	/ldubmZozuWgo3HPSAVMO2saI3Ru100NkojUmy+/30g2GgJkC45cPyos1otEUHFn9SZ36WenuP0
	Pv9vq/DQVCEhDJ0qxMnAkH/AoXd5T71IVB7IC5RH17sarQuUpITcTd5aA/PUvI+opYVvRLKJZcf
	WTgkEwqFsmjcukVlBRTquFKclYL6/bhr5RSpooaDoM+BfdAXffLX+X7FD1WOs4h3cGDaTvvx3dI
	23WsaPD8O7HbuJXpHWBqqJnUiehkyZ0w0aZgwqUDpmGvUh8cKarwBygmA+yy0Yz+Whrhhk59q0j
	IbUT1fD0cI9stJbIxbYzfgwPbIxRRHEs/VlVCz8Z20WtUIroSfolvDy//su9M1exLbppqS8R3a6
	ywfyfCdedsfJ0nA+Hhr/GdCRv59XWKP1PyscmXCIoAiiRzZ9
X-Received: by 2002:a05:600c:4f42:b0:4a0:b6:4619 with SMTP id 5b1f17b1804b1-4a18e3ecfc8mr324117205e9.0.1791922397398;
        Tue, 13 Oct 2026 13:13:17 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18be97d1esm608335675e9.8.2026.10.13.13.13.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 13:13:16 -0700 (PDT)
Message-ID: <736950e0-c890-441e-bfa0-ef5d2b7b7d4a@gmail.com>
Date: Tue, 13 Oct 2026 21:13:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 05/13] block: add dma-buf support for raw bdev
To: Anuj Gupta/Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>, dm-devel@lists.linux.dev
References: <cover.1791336930.git.asml.silence@gmail.com>
 <CGME20261007014324epcas5p2a7f3b03f118c9a1d1c633fe839ed1e46@epcas5p2.samsung.com>
 <af2b48a490186edf38f1d4a5dfd9513574f7a350.1791336930.git.asml.silence@gmail.com>
 <bbb87d6b-b7a3-487a-8be4-27f3f9ce4a1b@samsung.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <bbb87d6b-b7a3-487a-8be4-27f3f9ce4a1b@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261013_131319_431199_9DD7EDB4 
X-CRM114-Status: GOOD (  12.44  )
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

On 10/8/26 13:27, Anuj Gupta/Anuj Gupta wrote:
> On 10/7/2026 7:12 AM, Pavel Begunkov wrote:
>> +static int blkdev_init_dma_buf_io_ctx(struct file *file,
>> +				      struct dma_buf_io_ctx *ctx)
>> +{
>> +	struct block_device *bdev = file_bdev(file);
>> +	struct gendisk *disk = bdev->bd_disk;
>> +
>> +	if (!(file->f_flags & O_DIRECT))
>> +		return -EINVAL;
>> +	if (!disk->fops->init_dma_buf_io_ctx)
>> +		return -EOPNOTSUPP;
> 
> dma-buf doesn't work with PI: bi_dmabuf_map aliases bi_io_vec, and
> blk_integrity_iterate() walks it as bvecs to generate/verify the
> checksum. rw-dmabuf liburing test hangs on a PI enabled NVMe. Something
> like below is needed:

Thanks, I already took it into v10! There is some some confusion
with the branches, but will get incorporated in either case.

-- 
Pavel Begunkov


