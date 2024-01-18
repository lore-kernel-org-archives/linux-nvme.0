Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 381E9C4725D
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jan 2024 00:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FG4Zm7CAtcnjduN+LxFRfeYRTiMSCzl2syqW6Cg8J1c=; b=RXeAWDWvpckHurenuWtOqRvU15
	AsqfHtDhBIrq5B9pvIsJ9ydPUFPn2obueLNewE0O6F1Mp3jprNgOmXSa3/9vFU5/fZQJVIZcDI54j
	waU+3Bq3WSq0PQ+Ivhv4RoIdltfjksheQgVtjFlKRl+s9hocLa7hSBTwhH+Ydh6d1f4LGaJQ29HNi
	l9JhX/2uA3iV5Tf/nP+k6ZyLvjjgEW/cpMf3jtkVgw/0QKaVYe2MoR4BLvJOJsQevbpnOMNlEOBx1
	nBJ7QBVYTow0yqK8k7nl5SEw73vlsjCeMc26o18U/WdSYFeNWlbw/K0eDl8WBwQ+HXwEXHoU3ar0k
	XFdNZ2Vw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQGUj-001D3Y-1X;
	Thu, 18 Jan 2024 00:42:57 +0000
Received: from mail-io1-xd2d.google.com ([2607:f8b0:4864:20::d2d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQGUe-001D2w-0i
	for linux-nvme@lists.infradead.org;
	Thu, 18 Jan 2024 00:42:55 +0000
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-7bed82030faso66976939f.1
        for <linux-nvme@lists.infradead.org>; Wed, 17 Jan 2024 16:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705538570; x=1706143370; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FG4Zm7CAtcnjduN+LxFRfeYRTiMSCzl2syqW6Cg8J1c=;
        b=q41G6A3D5slTaRBA3SeGQ/aW/r7G0uUWB/9T/HTjrXvZGNo8gRS+f5a03JhCbeEduA
         jnAAdL0PLVdqG3yvu3HSqVfuqtNGpTff0bVU01WJgezvd8/62EIolXfBtVGD8dZCfXNT
         o8KsLhOkhIoThisldNgijjyLv3ZjbmZmnpPxyTFJXYLP6AaaP1TlZHPqHbdDfwskf3W6
         23T9VHh8HIMJLGGIxwywBxC1vfoSzn9b6jAJIhJ6qfVuCd32+EhJcIifNruree2l2OrJ
         bFm3/1N2nuBA4vXUBKldRr03EwgMptMf51ntk+ESqBA6A4St3nqgzq/UYC0mmvDYZs9E
         oxTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705538570; x=1706143370;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FG4Zm7CAtcnjduN+LxFRfeYRTiMSCzl2syqW6Cg8J1c=;
        b=Xr80EnoiXX3Bj4s4Vc9mAUuM1ujAuDm4eSaPdgM9bPr+ic5REsXKfVZTIGGVfwcKuK
         lo++00juN3MW9cSDFgQG9dSjsXDvS136poWArmVc6e4l5ui7o7U5/3kfD5iRti8sZRR2
         /CwnfpRiXisdejyOzDF9Km/nta8pWKpp42edQt8/xkmbDpFJkZalK9ruSWzoqzHZPf74
         V6nKT3qpIuTQF6IlGrdf2slNpR9JYBd4CCB3j2mJNYMm+QBLxb7mfB4LKvCKxMVKg20F
         Mu/+4F9f0DENdnPbeGx85kpuJ2KlkCyCJvlRZu6fTGH7RQMLROaksMzxiYTuV1QRKlm/
         k4Bg==
X-Gm-Message-State: AOJu0YwCKQs/b80rdUEqOyAMnw3VArDeeQ2bIERIctrkRh9AdtUvY+ml
	FuSrI2YLcAHZlVsen1VPoDHLUDlcyX6eQvOmrkGFKcCYTqnQJaBNo9omd0Lj7gTA6tAYhvbPYKp
	IqVY=
X-Google-Smtp-Source: AGHT+IFGchJpPnccB7isRFn/p46Slms2dH/kxBcnF4iOxIjjlX8qYmgIHiIQq/SK4rI8fR+fMFtByg==
X-Received: by 2002:a6b:7301:0:b0:7bf:60bc:7f1e with SMTP id e1-20020a6b7301000000b007bf60bc7f1emr269240ioh.1.1705538570121;
        Wed, 17 Jan 2024 16:42:50 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id i22-20020a05663813d600b0046e57c0e834sm709306jaj.27.2024.01.17.16.42.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 16:42:49 -0800 (PST)
Message-ID: <e19746ce-fdea-4372-bc26-1ee7b1a9a22d@kernel.dk>
Date: Wed, 17 Jan 2024 17:42:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Improving Zoned Storage Support
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>, Damien Le Moal
 <dlemoal@kernel.org>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>
References: <5b3e6a01-1039-4b68-8f02-386f3cc9ddd1@acm.org>
 <cc6999c2-2d53-4340-8e2b-c50cae1e5c3a@kernel.org>
 <43cc2e4c-1dce-40ab-b4dc-1aadbeb65371@acm.org>
 <c38ab7b2-63aa-4a0c-9fa6-96be304d8df1@kernel.dk>
 <2955b44a-68c0-4d95-8ff1-da38ef99810f@acm.org>
 <9af03351-a04a-4e61-a6d8-b58236b041a3@kernel.dk>
 <c6dfb4f5-10f9-461e-8743-b730a8384f95@acm.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <c6dfb4f5-10f9-461e-8743-b730a8384f95@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240117_164253_286036_19643EE7 
X-CRM114-Status: UNSURE (   9.02  )
X-CRM114-Notice: Please train this message.
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

On 1/17/24 5:38 PM, Bart Van Assche wrote:
> On 1/17/24 10:43, Jens Axboe wrote:
>> Do we care? Maybe not, if we accept that an IO scheduler is just for
>> "slower devices". But let's not go around spouting some 200K number as
>> if it's gospel, when it depends on so many factors like IO workload,
>> system used, etc.
> I've never seen more than 200K IOPS in a single-threaded test. Since
> your tests report higher IOPS numbers, I assume that you are submitting
> I/O from multiple CPU cores at the same time.

Single core, using mq-deadline (with the poc patch, but number without
you can already find in a previous reply):

axboe@7950x ~/g/fio (master)> cat /sys/block/nvme0n1/queue/scheduler
none [mq-deadline] 
axboe@7950x ~/g/fio (master)> sudo t/io_uring -p1 -d128 -b512 -s32 -c32 -F1 -B1 -R1 -X1 -n1 /dev/nvme0n1

submitter=0, tid=1957, file=/dev/nvme0n1, node=-1
polled=1, fixedbufs=1/0, register_files=1, buffered=0, QD=128
Engine=io_uring, sq_ring=128, cq_ring=128
IOPS=5.10M, BW=2.49GiB/s, IOS/call=32/31
IOPS=5.10M, BW=2.49GiB/s, IOS/call=32/32
IOPS=5.10M, BW=2.49GiB/s, IOS/call=31/31

Using non-polled IO, the number is around 4M.

-- 
Jens Axboe


