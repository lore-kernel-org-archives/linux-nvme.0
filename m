Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34676C88E53
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Sep 2026 20:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jeYHidnwyFLGOcwUOYUy3OdpNurO7rwFcsY8EorS7Z0=; b=Kv0HVYLQRtKTD6/g+ScnXMFi8C
	Ue9AbsXx/gwF+0Q1NN8hazvqyoghIsmZxwnfhmOdXgyJeou1Wc5j1S7edqQdeXNfAJZE0y4usAnsl
	AdgMTMVPmriJg8shMVgsq90xK5HLSzLk6UBTXjbmQ5OsWybOxn8EGaSDk13FRRlWjOIonBQlWUVgb
	Lr1YlgRLDix+Z9w0cheX4JZ6QwAMv4CmB7iBvoLN/9rov9QTOY31VMsh3qtB+KJvFKgYF+JxD9q2O
	hfFR9RHQLy6e1trdKoxLSU91QOt8ZuYHg7+W55q9qMP1nkJ7EEgbYbLgjlJwxm6M1ySL3sI725uGz
	+mODeFvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x58Kp-000000008BM-0yqA;
	Fri, 11 Sep 2026 20:58:59 +0000
Received: from mail-wm2-f13.google.com ([74.125.225.141])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x58Kn-000000008Ao-1rRY
	for linux-nvme@lists.infradead.org;
	Fri, 11 Sep 2026 20:58:58 +0000
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e6b885ef8so919295e9.1
        for <linux-nvme@lists.infradead.org>; Fri, 11 Sep 2026 13:58:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789160335; x=1789765135;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jeYHidnwyFLGOcwUOYUy3OdpNurO7rwFcsY8EorS7Z0=;
        b=f16aHbMBO14D7nlNlTPJySqD+gTGD6YSSzC69Uj4bOKAuEUOYGZpNQ8LzMWSi5j3Vd
         ZP/jNiPNnlslle0vQVF8xjTrukmimAxf+Qn01E+lL5P/XTJSF3LWRKMYKZAkm5PzIbe3
         a0otjREgZXrDQ1441xvSOZFfL3bhaUIvPyVFDU6npVCrukLUBVt8QoDFRQQPS5Wke/A0
         JtwY73721x4fct+UCxa71SzmQGAfBspS/4PWxt0Hql4E4BeV9SfTL4+2fAP07BpOfvTf
         ySA0FIyz81Jx4s//Fm3Uagn/7M11IdBnbChBkBxnAyF+ydO/WQgsREY1WCa253KUWAuY
         9s2g==
X-Gm-Message-State: AFuF++k7g+2kRGtqFh4RG1I6t9jOy8wSF91IDcLwMiaeqjFvKqDUYVyF
	9hZAqD/ePOxIYFGVCQd4NYIsh9abecHS6AFC1wXT/kO53sklWjl0OO0u
X-Gm-Gg: AYBFou3H0eHZwYYhPWqflLHgG1sM5KvfdlyCmIqbiaQUWKOmGrfWPC0dwxX+j1JgvIr
	+xeYXoUTnqUQ85/Eg0qvjWQSNn5/igLQYXa/WATP5cSvibKgux8Nu2d1JNZBPIvnWJh4yDL+wYp
	qclT4NovjBokEn6kBpxd0fJKKcl5MRFbCEm7Wr2+i1MkM6zwc2EueMbg8FSEucDFQqZAc8TmetG
	107MUO9DC1l139LAdHXRDhXFiDtv+qq/NWoSCZjylyGQLxHHoZDy9bjz5v0xwngyoiX2EYsPQpF
	a7OyTDBoyGeyOSNLApMtjv60+OhpogC+QcKjsqeftsI2kCckkhdQ0uCMvYNf00HyNvRv1Jdk+xX
	70E8zRbq5U6YfUejVlh+4mpYqn/kMSlPcRnaKOW7vvpwW2mXhsh5x37OJFl/ME0QB3deAK+MQSk
	jQ22Z/PqfJKmVK1gRLmmDIU2YiXwJrbLM1Xf72BuexBqKK8lW/FVA+tV7+AiY/dn5ZmKM4OLcmc
	toXbx2ikjE31pfe9nm2wE+agIYqTZMGLw==
X-Received: by 2002:a05:600c:1385:b0:49d:243a:e4f9 with SMTP id 5b1f17b1804b1-49e6198bf39mr57198085e9.10.1789160334640;
        Fri, 11 Sep 2026 13:58:54 -0700 (PDT)
Received: from [10.100.102.74] (89-138-77-243.bb.netvision.net.il. [89.138.77.243])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e62227071sm63494375e9.3.2026.09.11.13.58.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2026 13:58:53 -0700 (PDT)
Message-ID: <8510cbc8-9dfc-415a-949e-c0f5f3f4e8b5@grimberg.me>
Date: Fri, 11 Sep 2026 23:58:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] nvme-tcp: allow setting per-queue io_cpu through sysfs
To: Saravanan D <saravanand@crusoe.ai>, Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Daniel Wagner <dwagner@suse.de>, linux-kernel@vger.kernel.org
References: <20260909211432.6741-1-saravanand@crusoe.ai>
 <8dfee10f-89f3-463b-8d16-587873c3394c@linux.ibm.com>
 <20260911060330.59998-1-saravanand@crusoe.ai>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260911060330.59998-1-saravanand@crusoe.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260911_135857_490937_693194B8 
X-CRM114-Status: GOOD (  18.13  )
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



On 11/09/2026 9:03, Saravanan D wrote:
> On Thu, 10 Sep 2026 13:55:59 +0530 Nilay Shroff <nilay@linux.ibm.com> wrote:
>> I wonder if we should avoid introducing a transport-specific tcp_queues
>> hierarchy here. io_cpu describes CPU placement of an NVMe I/O queue
>> rather than something inherently specific to TCP, and other transports
>> may have similar queue-level attributes in the future. Could we instead
>> introduce a generic "queues/<qid>/" hierarchy under each NVMe
>> controller, e.g.
>>
>>        /sys/class/nvme/nvmeX/queues/<qid>/
>>
>> and have transports expose queue-specific attributes there?
> Thanks for your review.
>
> A controller is backed by exactly one transport, so we can adopt the
> transport-neutral /sys/class/nvme/nvmeX/queues/<qid>/ path with the
> creation staying outside of core in nvme-tcp, which owns the queue
> lifecycle. The core only knows ctrl->queue_count and never sees
> individual queue lifecycle.
>
> No other transport has queue attributes today, so a controller backed
> by rdma will have no queues directory at all. The path appears only
> where a transport populates it, and if another transport grows queue
> attributes later, the creation can move into the core without any
> ABI change.
>
>> So could we expose this state through an additional read-only
>> attribute alongside io_cpu, for example:
>>
>>       /sys/class/nvme/nvmeX/queues/<qid>/io_cpu
>>       /sys/class/nvme/nvmeX/queues/<qid>/managed
>>
>> where "managed" indicates who currently owns the CPU placement. For
>> example, "1" could indicate that io_cpu is driver-managed and "0"
>> indicates it is managed by the control plane or user.
> Agreed, I can add the read-only managed attribute, 1 when the io_cpu is
> driver managed and 0 when the user assigned it in the next version.
>
> Both suggestions look good to me. I will wait for Sagi or Keith to
> weigh in before spinning v4.

I agree with this approach.

I think that making nvme-core more "aware" of individual controller queues
is a good thing.

