Return-Path: <SRS0=8G/6=PA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27953C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Oct 2021 14:47:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 837D66101D
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Oct 2021 14:47:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 837D66101D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=10Q5J3nKdzGV1fhnMmnn3JqIKAoas9T5xa+agK50VWg=; b=dAF0CBjCt0SRYrGnrHeb6gfnt+
	KYt9ZQZ/u8LFD5VsvXc4M2MLWHxApftJwbiTT6A7DzIUc1j79iq+8tTYWsbJtRZZ051/paK79A1GL
	UlnQLgKYslc6ztB5OeZ3/DDY9NvtqDtRS+H6ouytknFY0eafmmTQYklg1vYy43DYSRjTehDh57vA9
	NqvY+V+eYRw+e72d8V+MEenv4q/i3IGZv927KWkAJcI9/araW9AeBxpRsCNYe09XRL4FogJuTGeJZ
	pi0eVm2p4FfzBaXjqbFsPOwFy8ZzuPTG48LfN4Te1YbYeNTqnzWxZxE4aAEeqh8/s+peYD8dmr0RV
	RwRZ/B1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1maJ44-00DFnA-5G; Tue, 12 Oct 2021 14:47:36 +0000
Received: from mail-il1-x12d.google.com ([2607:f8b0:4864:20::12d])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1maJ40-00DFmU-Jn
 for linux-nvme@lists.infradead.org; Tue, 12 Oct 2021 14:47:34 +0000
Received: by mail-il1-x12d.google.com with SMTP id i11so20889881ila.12
 for <linux-nvme@lists.infradead.org>; Tue, 12 Oct 2021 07:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=4MJaMMW8746DQT1wOfh06NFmp8vY5yRZAB/PDHHSeGY=;
 b=wOIbilVM5gc/k/LZ9/Ir1wHPCDEC+IR+oeQmi8pjQTvUyvfa2oZbSfQqPDImNMgtyQ
 DxhGgaz5+RPNRuFubDCiRCMnZceDLrc+C4OB89sWzEOWrTG+y91hDngiR3YIKZ+/aVH/
 9Bii7ghXtllIvrSjzGpTWpaI1pJURBqQbV6hd8+09Ufn95OxlNx5YjjsjiyT5oglv1Xe
 ToMkqjYZp0OudBD2QdC/8exoIwens1dkP4DGoLp6RebMGZTeOkDN3LAr6NIZDEU1VHWS
 PvyzkvQuSb/1CIei/9oaMldCHe344kFIwyg0rEFoGlgBAJfyJh0Q+Lx1Q2O/iSyAVSfO
 sxjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4MJaMMW8746DQT1wOfh06NFmp8vY5yRZAB/PDHHSeGY=;
 b=T+uy4OdhdLsai8H7JvFofneSZ/0/n0ZU8dmKvmJo61NuB/d3Jp5eOKZ6ddhrrmwOVA
 OnT+vqSMvKUVboREmO9a1PeWPRplidr1vj55MZXW2dJG2xAaXprH7RFpEvrt1aEzYHp9
 eFY+Gs/NWUExn3iOKzIiZYXwuXNUy+mkB8ud5IFNS9aWaofNqbLwjUwoPj4ENMj981Hz
 9HplSHMP0O6X0A5hx3BGwvUiOrOM369d7VS9Pxr/yO3canwLoqCrA4+25EldOvqYUS4U
 sGQQ0pjckZjfG+9c9OY4mBoj+nqgu8DeI4/J5GoYrCJD/gW82sXpNL9acLcjAIMeeNRg
 Vxgg==
X-Gm-Message-State: AOAM533yKtzxUydWLBXdaM/xeOjsGBvBc+SUCxSEhbqkW4BRLkUnNwxK
 bhIY5ataQhKJ6d5jonJu4R79r50nOWcJnA==
X-Google-Smtp-Source: ABdhPJxapnRy6JleZezPqu6pNBbq7PwR7Um8itvadPDoYS1xyG7UZ+W6d1/blh57xUyZyd+hWUDWDg==
X-Received: by 2002:a05:6e02:160a:: with SMTP id
 t10mr23554089ilu.207.1634050050606; 
 Tue, 12 Oct 2021 07:47:30 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
 by smtp.gmail.com with ESMTPSA id 2sm5337003iob.13.2021.10.12.07.47.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Oct 2021 07:47:30 -0700 (PDT)
Subject: Re: switch block layer polling to a bio based model v4
To: Christoph Hellwig <hch@lst.de>
Cc: Jeffle Xu <jefflexu@linux.alibaba.com>, Ming Lei <ming.lei@redhat.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>,
 "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "Vasudevan, Anil" <anil.vasudevan@intel.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20211012111226.760968-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <07f31547-5570-4150-7a4b-1d773fb9fa87@kernel.dk>
Date: Tue, 12 Oct 2021 08:47:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211012111226.760968-1-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211012_074732_733944_68130A18 
X-CRM114-Status: GOOD (  22.75  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 10/12/21 5:12 AM, Christoph Hellwig wrote:
> Hi all,
> 
> This series clean up the block polling code a bit and changes the interface
> to poll for a specific bio instead of a request_queue and cookie pair.
> 
> Polling for the bio itself leads to a few advantages:
> 
>   - the cookie construction can made entirely private in blk-mq.c
>   - the caller does not need to remember the request_queue and cookie
>     separately and thus sidesteps their lifetime issues
>   - keeping the device and the cookie inside the bio allows to trivially
>     support polling BIOs remapping by stacking drivers
>   - a lot of code to propagate the cookie back up the submission path can
>     removed entirely
> 
> The one major caveat is that this requires RCU freeing polled BIOs to make
> sure the bio that contains the polling information is still alive when
> io_uring tries to poll it through the iocb. For synchronous polling all the
> callers have a bio reference anyway, so this is not an issue.

I ran this through the usual peak testing, and it doesn't seem to regress
anything for me. We're still at around ~7.4M polled IOPS on a single CPU
core:

taskset -c 0,16 t/io_uring -d128 -b512 -s32 -c32 -p1 -F1 -B1 -D1 -n2 /dev/nvme1n1 /dev/nvme2n1
Added file /dev/nvme1n1 (submitter 0)
Added file /dev/nvme2n1 (submitter 1)
polled=1, fixedbufs=1, register_files=1, buffered=0, QD=128
Engine=io_uring, sq_ring=128, cq_ring=256
submitter=0, tid=1199
submitter=1, tid=1200
IOPS=7322112, BW=3575MiB/s, IOS/call=32/31, inflight=(110 71)
IOPS=7452736, BW=3639MiB/s, IOS/call=32/31, inflight=(52 80)
IOPS=7419904, BW=3623MiB/s, IOS/call=32/31, inflight=(78 104)
IOPS=7392576, BW=3609MiB/s, IOS/call=32/32, inflight=(75 102)

with some of my pending changes and hacks. Using IRQ mode, we're at around 4.9M
and I don't see any particular impact of needing deferred RCU free of the bio
for that case.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
