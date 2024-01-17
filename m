Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2064C47258
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jan 2024 20:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RylSDua2BnQBNhz0ri2mwOlsrVpcdZ7iruL97tOno0k=; b=uY3TpFL6G4QN82QIaIHGE+misP
	7evkb6N42Oumj50cdyt1lA90sp+c2+IiPDLZ6FqIBa0MOvS+HXwUAhKQjq/3A4oUWctJY6EPSvBo1
	k+5oK1mgsP3Tk4x54D1VKnCOQptnea1rDumS8VBcXj33cYUZkyqDeivvrNHDflt20rC1flbSoB9Bi
	PbhRvglaT2aahMFhpZax0mS+bVAkkHny1fHVrzHZWBIGr8YxOC+5qHsK05MwN4glh5KnoLpHLWvpz
	bUAb8ggZb7/UtRPdsMCdlp/Il+j6qPZT5kWnyG7nx8BSSeryEin4DBwin04A2kP4kx/iXpjY9y5Ur
	8KLlsM6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQCBD-000bQV-1r;
	Wed, 17 Jan 2024 20:06:31 +0000
Received: from mail-io1-xd33.google.com ([2607:f8b0:4864:20::d33])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQCB9-000bOo-2v
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jan 2024 20:06:29 +0000
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-7bee9f626caso58677539f.0
        for <linux-nvme@lists.infradead.org>; Wed, 17 Jan 2024 12:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705521986; x=1706126786; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RylSDua2BnQBNhz0ri2mwOlsrVpcdZ7iruL97tOno0k=;
        b=0wOTj5wes9QRO+cv0bgIv3fCCPI+TFWt1ddDo27V3us097YTaxAlkmUIOgHpMXxkwd
         K6rVOa+i1+9ryYOJZU456DmxcKQ6J+APYZCX5Xr4kdoOhQECOcOmhe6bHnHxaPJ3oAnf
         Im2D6sJNfryQd4AHzM11HuVwX6dhvpDepPJo1xGDViPZyYOzhK0PbUpSx+7dTCkMFxxZ
         pswh3/L0PuBu+Wkvk5OJqMgLO6Lgx4NbtcRjk9MeCJimQ+DIrho9KVvxY79RgHvqn3po
         q/jFFE1lCHACgmyorAyl8izeVkobkKYs3hDoFQr3WO6RPjdmTQCj5bBNEkZFk/Msmsf7
         Bw9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705521986; x=1706126786;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RylSDua2BnQBNhz0ri2mwOlsrVpcdZ7iruL97tOno0k=;
        b=b+kNaAJQ0lV4D1+aCkBGE0RQgHwwOh3nHcYV05AjegR7m35TJcZdOhtvPyx5LVg5b6
         fOwWS7cL28wuNRiIkPMVYrWl7ms8pHx4bJKYBs7Tnr0DmKqHxgT3iCxitUOaM97yC0HJ
         1s7DodhzMTTlY1dw8b7/bwNBbnG4GYObMJgOO89iOZeCdBya6EImT694FYmzwRztHwsb
         J/24e3U5g72NSYTg0uNA5QR3nHNO3uNvXXtWTSIB+urqsT1HAMKWOH+7YhpnP9rmaUi9
         9PPW7M3Z+kcXJj6jp+NXyZQLQnfSfOnrtqRsUdviMgmg4fV4mAlPzl1N0A+d/NBjCHdo
         LAvg==
X-Gm-Message-State: AOJu0YxvogoTLDkpfyBB9naqVOzDOvh+4p/zzJP9wdddiTgF5SC8ZP5d
	CqHyQ2Rz9IpyDLA+Tsb0smBvt80RmwVN1Q==
X-Google-Smtp-Source: AGHT+IGWsohYVR1pZF1dkrm0P3WI2640KWeQttN82iMT/+YWYam6SPj4ldcXSQVyCmlk/vJ0pfftEA==
X-Received: by 2002:a5e:834b:0:b0:7bc:2603:575f with SMTP id y11-20020a5e834b000000b007bc2603575fmr3270490iom.0.1705521985985;
        Wed, 17 Jan 2024 12:06:25 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id l16-20020a056638221000b0046df601152dsm589695jas.66.2024.01.17.12.06.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 12:06:25 -0800 (PST)
Message-ID: <276eedc2-e3d0-40c7-b355-46232ea65662@kernel.dk>
Date: Wed, 17 Jan 2024 13:06:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Improving Zoned Storage Support
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
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
In-Reply-To: <9af03351-a04a-4e61-a6d8-b58236b041a3@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240117_120628_131220_D2D3085D 
X-CRM114-Status: GOOD (  11.85  )
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

On 1/17/24 11:43 AM, Jens Axboe wrote:
> Certainly slower. Now let's try and have the scheduler place the same 4
> threads where it sees fit:
> 
> IOPS=1.56M, BW=759MiB/s, IOS/call=32/31
> 
> Yikes! That's still substantially more than 200K IOPS even with heavy
> contention, let's take a look at the profile:
> 
> -   70.63%  io_uring  [kernel.kallsyms]  [k] queued_spin_lock_slowpath
>    - submitter_uring_fn
>       - entry_SYSCALL_64
>       - do_syscall_64
>          - __se_sys_io_uring_enter
>             - 70.62% io_submit_sqes
>                  blk_finish_plug
>                  __blk_flush_plug
>                - blk_mq_flush_plug_list
>                   - 69.65% blk_mq_run_hw_queue
>                        blk_mq_sched_dispatch_requests
>                      - __blk_mq_sched_dispatch_requests
>                         + 60.61% dd_dispatch_request
>                         + 8.98% blk_mq_dispatch_rq_list
>                   + 0.98% dd_insert_requests
> 
> which is exactly as expected, we're spending 70% of the CPU cycles
> banging on dd->lock.

Case in point, I spent 10 min hacking up some smarts on the insertion
and dispatch side, and then we get:

IOPS=2.54M, BW=1240MiB/s, IOS/call=32/32

or about a 63% improvement when running the _exact same thing_. Looking
at profiles:

-   13.71%  io_uring  [kernel.kallsyms]  [k] queued_spin_lock_slowpath

reducing the > 70% of locking contention down to ~14%. No change in data
structures, just an ugly hack that:

- Serializes dispatch, no point having someone hammer on dd->lock for
  dispatch when already running
- Serialize insertions, punt to one of N buckets if insertion is already
  busy. Current insertion will notice someone else did that, and will
  prune the buckets and re-run insertion.

And while I seriously doubt that my quick hack is 100% fool proof, it
works as a proof of concept. If we can get that kind of reduction with
minimal effort, well...

-- 
Jens Axboe


