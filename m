Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A552CC47258
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jan 2024 21:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xWPWFxixc3gOJ5TuAohxDe3jpGLKyM0nNrCjE6iAnNI=; b=Ua8IG8iUhE+JVW3BXiiLWOlHr8
	+jbFDN1geIjdx+bI+Bds0HMjclHWyuTitnZT3nl+5o0QFGH0NaLJ54H5cufsYBQgeS8C18W7+AM3w
	Vn+lElQCBRDACDFd/8UvyScyixEUUmKq6QOAQr5jpi+iDJSFBwIPRBjbiMSsJTpKIaVaGzjSI3Tfw
	N0pA1Cd+a76H/NeaLQDTnst1nEBXrxSpS7kIx+MDWDRXUzv9gHD5NZDX4IzYDjeCHnoN3jdwz6cby
	mHGrEIItQU2hpoX0BWYQIk7VrODEHHtKxkqQOnejOD2851mayOGVJAn5zEOFwnTy9+tQipCYKmroV
	WTT6Ws3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQD3s-000j8W-3C;
	Wed, 17 Jan 2024 21:03:01 +0000
Received: from mail-il1-x130.google.com ([2607:f8b0:4864:20::130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQD3p-000j7l-1D
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jan 2024 21:02:59 +0000
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-36191ee7be4so2114955ab.0
        for <linux-nvme@lists.infradead.org>; Wed, 17 Jan 2024 13:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705525374; x=1706130174; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xWPWFxixc3gOJ5TuAohxDe3jpGLKyM0nNrCjE6iAnNI=;
        b=Wy/lQGtQ79eVdXwTVKtA8ilbDiCoVKG2d2NU3a6e2Gc+f3GL95Mi/CvNYO8XC8AJ9D
         NKrtj/PccdH3BQUcGWLDNNd+ECmKwbpbs/QBfmAxPO3LYwbVi+AAPB8RyfczP+7tIVdK
         7TIk2QD6uZm3FjCthtKPwNjitGuNLNlIq+URpoOnvRLPfNkrs+6Lc1CH4MGbWfSbc1UE
         Xrfzd+nN2jQ932Wd5qKXUsPNUYzA3yTESgiHb7d0qQmeVEtr8Vomy7ksOZHBGUIuNlC1
         czFNx1X6awXi9xY9PBrCM3lSRfA8gyC18fYVmmzZ9+/2OX2Kjpegk0AJQrMyga9coBBV
         r6dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705525374; x=1706130174;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xWPWFxixc3gOJ5TuAohxDe3jpGLKyM0nNrCjE6iAnNI=;
        b=U/RDimOAV373denMKCAL8PyU2x+FgMgH7JQDTy2WHgFhmCI0JHWiv/1Z/HamQcsy/h
         nClm8f+XUfbAQfO4Vmis/AY3CaJhWwFAx9nOFIxsjxLxWxpP0yUORRoDvgnbArSK05mt
         9sbYIwsCsrCMbYYBo1dsUG7P1Fw1mxNzYNJXbV9/NoHhtlctYxbixW1Xn0fl4RJFvLuR
         pIGvJULH9gxLL4iN4q457LGVTxrwZZtPtWTNFIbkv1JJoUrCu7leCeSPC1ep3j/gbST8
         dWypon38JXsRpSixnBJGHLDOxpJZ1rlnLya9gXluB50svvwCZ5SLSQk4SJfZkHAWVYdu
         of3g==
X-Gm-Message-State: AOJu0Yx9EIa3kFX0MminFrO7xzv9+wzg+AuoW/5zuQpS1ULjj15+FNc+
	9VutBgRfuTiBpUymRmUNmfx8DaFhLdbe2g==
X-Google-Smtp-Source: AGHT+IEqv20xRorrWet2nJBHIW4ExNsaq6Cj0+pd1nBEWoPOk2NmeNwke4/2lBC1s1s3GmOQvjXZ0g==
X-Received: by 2002:a6b:7e01:0:b0:7be:e328:5e3a with SMTP id i1-20020a6b7e01000000b007bee3285e3amr15427250iom.0.1705525374172;
        Wed, 17 Jan 2024 13:02:54 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id l13-20020a02cd8d000000b0046e578ed0aasm609987jap.96.2024.01.17.13.02.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 13:02:53 -0800 (PST)
Message-ID: <207a985d-ad4e-4cad-ac07-961633967bfc@kernel.dk>
Date: Wed, 17 Jan 2024 14:02:51 -0700
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
In-Reply-To: <9f4a6b8a-1c17-46b7-8344-cbf4bcb406ab@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240117_130257_460134_1A04C031 
X-CRM114-Status: GOOD (  24.54  )
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

On 1/17/24 1:20 PM, Jens Axboe wrote:
> On 1/17/24 1:18 PM, Bart Van Assche wrote:
>> On 1/17/24 12:06, Jens Axboe wrote:
>>> Case in point, I spent 10 min hacking up some smarts on the insertion
>>> and dispatch side, and then we get:
>>>
>>> IOPS=2.54M, BW=1240MiB/s, IOS/call=32/32
>>>
>>> or about a 63% improvement when running the _exact same thing_. Looking
>>> at profiles:
>>>
>>> -   13.71%  io_uring  [kernel.kallsyms]  [k] queued_spin_lock_slowpath
>>>
>>> reducing the > 70% of locking contention down to ~14%. No change in data
>>> structures, just an ugly hack that:
>>>
>>> - Serializes dispatch, no point having someone hammer on dd->lock for
>>>    dispatch when already running
>>> - Serialize insertions, punt to one of N buckets if insertion is already
>>>    busy. Current insertion will notice someone else did that, and will
>>>    prune the buckets and re-run insertion.
>>>
>>> And while I seriously doubt that my quick hack is 100% fool proof, it
>>> works as a proof of concept. If we can get that kind of reduction with
>>> minimal effort, well...
>>
>> If nobody else beats me to it then I will look into using separate
>> locks in the mq-deadline scheduler for insertion and dispatch.
> 
> That's not going to help by itself, as most of the contention (as I
> showed in the profile trace in the email) is from dispatch competing
> with itself, and not necessarily dispatch competing with insertion. And
> not sure how that would even work, as insert and dispatch are working on
> the same structures.
> 
> Do some proper analysis first, then that will show you where the problem
> is.

Here's a quick'n dirty that brings it from 1.56M to:

IOPS=3.50M, BW=1711MiB/s, IOS/call=32/32

by just doing something stupid - if someone is already dispatching, then
don't dispatch anything. Clearly shows that this is just dispatch
contention. But a 160% improvement from looking at the initial profile I
sent and hacking up something stupid in a few minutes does show that
there's a ton of low hanging fruit here.

This is run on nvme, so there's going to be lots of hardware queues.
This may even be worth solving in blk-mq rather than try and hack around
it in the scheduler, blk-mq has no idea that mq-deadline is serializing
all hardware queues like this. Or we just solve it in the io scheduler,
since that's the one with the knowledge.

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index f958e79277b8..822337521fc5 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -80,6 +80,11 @@ struct dd_per_prio {
 };
 
 struct deadline_data {
+	spinlock_t lock;
+	spinlock_t zone_lock ____cacheline_aligned_in_smp;
+
+	unsigned long dispatch_state;
+
 	/*
 	 * run time data
 	 */
@@ -100,9 +105,6 @@ struct deadline_data {
 	int front_merges;
 	u32 async_depth;
 	int prio_aging_expire;
-
-	spinlock_t lock;
-	spinlock_t zone_lock;
 };
 
 /* Maps an I/O priority class to a deadline scheduler priority. */
@@ -600,6 +602,10 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
 	struct request *rq;
 	enum dd_prio prio;
 
+	if (test_bit(0, &dd->dispatch_state) &&
+	    test_and_set_bit(0, &dd->dispatch_state))
+		return NULL;
+
 	spin_lock(&dd->lock);
 	rq = dd_dispatch_prio_aged_requests(dd, now);
 	if (rq)
@@ -616,6 +622,7 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
 	}
 
 unlock:
+	clear_bit(0, &dd->dispatch_state);
 	spin_unlock(&dd->lock);
 
 	return rq;

-- 
Jens Axboe


