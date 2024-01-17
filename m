Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4278C47258
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jan 2024 21:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7NlonM47ZL/DaVG1oQ0pMdWoMVzqK9l5NUiiZ/sWieg=; b=MGRImu8aGE1IdfaCDxFpkK6BmZ
	Qb3rBn+/4ILTIZFlcAgwbTZQcsxe+M6sF63Kkp6m3CyFeib08v5C0wRMFG0P+4f2XGL9eh/qJvZQY
	PocY86mlGXtArBPiLvnUQ1fdPEwvS4Dic0DaW+NVQ3ylEzYdaanELUeAoz3ocyeqZ3/XUnjtSttQB
	1ZEjZ5rG+/SJldchIO/OBQvAFmGKgMvGkwgXkZzhCRYdYywmg6Nq+cOUMOiGVJ4mkvVrKfderQfN9
	xFXAeinnbhO7sJXpuEHRiRhrGma9onUOB6CZjDN+EmjMTuSR8C1dFekTE90kXiy4rliB5YJU0DkLZ
	PG+Hq8Bw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQDFJ-000ksx-0x;
	Wed, 17 Jan 2024 21:14:49 +0000
Received: from mail-il1-x12d.google.com ([2607:f8b0:4864:20::12d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQDFF-000krN-1j
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jan 2024 21:14:48 +0000
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-35d374bebe3so8876045ab.1
        for <linux-nvme@lists.infradead.org>; Wed, 17 Jan 2024 13:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705526083; x=1706130883; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7NlonM47ZL/DaVG1oQ0pMdWoMVzqK9l5NUiiZ/sWieg=;
        b=kZjZGUDhomPcVQ8Bwc02A/LvHqQFXnwT85A/j9cdBgbhTPpSwB5yApxqHe5bJhFQVi
         kmfzKPzYQtLDblkfxZKemXqSHhQ/YSbCFUvqSGwoaU0rpiEgZ2SxfECdYWRbElHDFXPP
         IPVHQ+z3hhiqAo1hFIp/CVo7xZbPuuMrzcHGndFrxJx561zuf7F24XktngjHyJDCoszA
         yHwM7Zp5aSuw86sKP9m0heHaQvbYL+14BCl4pyk1Zf9LSFzr2foHVT6DsDdF+MoJUpPb
         6mnpw2rBs9VFgS9TYWGoF0u2mY2DbYx0LhWzFfy/u4At85T/PNkXVIno8xqKBL0v8Wwi
         isVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705526083; x=1706130883;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7NlonM47ZL/DaVG1oQ0pMdWoMVzqK9l5NUiiZ/sWieg=;
        b=PFhRksGYpg2Feh+qK61XLl4k1Zzc5SPY57U6HkhOUbpavTFFOUmshd5hwFDSkD21kc
         ifhcynoDjGQtaqH6RjUSXBqwcGUwBsCw2fWaDiBqDHLW9l439saJhSkx4qUhtV45pCFz
         0DkbCo7/SE4pMz2ycZuy2AhFcBVo5S9oPiH5y3zQ5XtnzDOxsDkO8gkzmWHQSZN0taW5
         Gs0NrhDn3yHuVaDOzew4elHDMF/GJPJ+tr1yijwP0XizETNon2YYjDs99ECUj3S7p1vW
         X2J4mrOWvmPHzmHeoke4Ex63Svurw1AL7Hhan3yx75kOrmScbe1hTiWGAU7VSwY55/Iz
         +0ww==
X-Gm-Message-State: AOJu0YzbE0notrb4zjPwlF2eRV4cjZ6OFO413aK4kPCE/Fgvu73XGCAs
	RD5Gk2TiSsLoyGkf7StPpNo7zZT8kKaWoLcwGizi5XJ0jpfIDg==
X-Google-Smtp-Source: AGHT+IG6Rn34LZJ41NucbqmkdsoUihrlcTuf+Vz+HLae2MAYSroiYFWXViZpyUAv5pBL8ScpZdOEvg==
X-Received: by 2002:a05:6e02:1c0f:b0:361:9b07:be with SMTP id l15-20020a056e021c0f00b003619b0700bemr748987ilh.0.1705526083276;
        Wed, 17 Jan 2024 13:14:43 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id g14-20020a056e021a2e00b0035d6f8d02d7sm4308292ile.7.2024.01.17.13.14.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 13:14:42 -0800 (PST)
Message-ID: <e8c32676-114b-4aaf-8753-5a6d7b04fc4b@kernel.dk>
Date: Wed, 17 Jan 2024 14:14:42 -0700
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
 <276eedc2-e3d0-40c7-b355-46232ea65662@kernel.dk>
 <39dfcd32-e5fc-45b9-a0ed-082b879a16a4@acm.org>
 <9f4a6b8a-1c17-46b7-8344-cbf4bcb406ab@kernel.dk>
 <207a985d-ad4e-4cad-ac07-961633967bfc@kernel.dk>
In-Reply-To: <207a985d-ad4e-4cad-ac07-961633967bfc@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240117_131446_578947_E182F565 
X-CRM114-Status: GOOD (  22.01  )
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

On 1/17/24 2:02 PM, Jens Axboe wrote:
> On 1/17/24 1:20 PM, Jens Axboe wrote:
>> On 1/17/24 1:18 PM, Bart Van Assche wrote:
>>> On 1/17/24 12:06, Jens Axboe wrote:
>>>> Case in point, I spent 10 min hacking up some smarts on the insertion
>>>> and dispatch side, and then we get:
>>>>
>>>> IOPS=2.54M, BW=1240MiB/s, IOS/call=32/32
>>>>
>>>> or about a 63% improvement when running the _exact same thing_. Looking
>>>> at profiles:
>>>>
>>>> -   13.71%  io_uring  [kernel.kallsyms]  [k] queued_spin_lock_slowpath
>>>>
>>>> reducing the > 70% of locking contention down to ~14%. No change in data
>>>> structures, just an ugly hack that:
>>>>
>>>> - Serializes dispatch, no point having someone hammer on dd->lock for
>>>>    dispatch when already running
>>>> - Serialize insertions, punt to one of N buckets if insertion is already
>>>>    busy. Current insertion will notice someone else did that, and will
>>>>    prune the buckets and re-run insertion.
>>>>
>>>> And while I seriously doubt that my quick hack is 100% fool proof, it
>>>> works as a proof of concept. If we can get that kind of reduction with
>>>> minimal effort, well...
>>>
>>> If nobody else beats me to it then I will look into using separate
>>> locks in the mq-deadline scheduler for insertion and dispatch.
>>
>> That's not going to help by itself, as most of the contention (as I
>> showed in the profile trace in the email) is from dispatch competing
>> with itself, and not necessarily dispatch competing with insertion. And
>> not sure how that would even work, as insert and dispatch are working on
>> the same structures.
>>
>> Do some proper analysis first, then that will show you where the problem
>> is.
> 
> Here's a quick'n dirty that brings it from 1.56M to:
> 
> IOPS=3.50M, BW=1711MiB/s, IOS/call=32/32
> 
> by just doing something stupid - if someone is already dispatching, then
> don't dispatch anything. Clearly shows that this is just dispatch
> contention. But a 160% improvement from looking at the initial profile I

224%, not sure where that math came from...

Anyway, just replying as I sent out the wrong patch. Here's the one I
tested.
 
diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index f958e79277b8..133ab4a2673b 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -80,6 +80,13 @@ struct dd_per_prio {
 };
 
 struct deadline_data {
+	struct {
+		spinlock_t lock;
+		spinlock_t zone_lock;
+	} ____cacheline_aligned_in_smp;
+
+	unsigned long dispatch_state;
+
 	/*
 	 * run time data
 	 */
@@ -100,9 +107,6 @@ struct deadline_data {
 	int front_merges;
 	u32 async_depth;
 	int prio_aging_expire;
-
-	spinlock_t lock;
-	spinlock_t zone_lock;
 };
 
 /* Maps an I/O priority class to a deadline scheduler priority. */
@@ -600,6 +604,10 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
 	struct request *rq;
 	enum dd_prio prio;
 
+	if (test_bit(0, &dd->dispatch_state) ||
+	    test_and_set_bit(0, &dd->dispatch_state))
+		return NULL;
+
 	spin_lock(&dd->lock);
 	rq = dd_dispatch_prio_aged_requests(dd, now);
 	if (rq)
@@ -616,6 +624,7 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
 	}
 
 unlock:
+	clear_bit(0, &dd->dispatch_state);
 	spin_unlock(&dd->lock);
 
 	return rq;

-- 
Jens Axboe


