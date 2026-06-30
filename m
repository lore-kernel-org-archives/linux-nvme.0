Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8A98C43458
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jun 2026 10:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iWjx8rAhOE58GpFxQdio8yvkPjUqPBmmzdlN1xwVU/w=; b=VQK1fKA0foZfvihqTEMOd67fZw
	qNG9s4jJjLkupoCiJr4zfZo5GKxNKbzIktB5LswHFhGnHye1fLfuEet26blAHBn9wT9RddwQIFoGg
	bVfhvr1LmIb6oV6N/ozn1NeiQJmMfwcwhEXXklCRTG+285Iu3vxHMzKrhJ3aswmbUStMPo73N8UwG
	LPpfePiN+yefZOdqU6S6gv9d8V8XaU4J4GFihW+Ros0rzLkO8w3Fc0WB4UliBTN4DVb4MBZPX7r//
	HV6bOJdb4e5UEGmOeEsaYcN8dtKIH/+3LZazgpgHgT9c+TbkJk9L7vJ3E2KcUF4aGEERvrDDSNXQt
	+HWNwaug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weW93-0000000GjO8-0WR4;
	Tue, 30 Jun 2026 10:56:49 +0000
Received: from mail-dl1-x1229.google.com ([2607:f8b0:4864:20::1229])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weW90-0000000GjNT-3jpF
	for linux-nvme@lists.infradead.org;
	Tue, 30 Jun 2026 10:56:48 +0000
Received: by mail-dl1-x1229.google.com with SMTP id a92af1059eb24-1390f75d8bbso8816957c88.0
        for <linux-nvme@lists.infradead.org>; Tue, 30 Jun 2026 03:56:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782817006; cv=none;
        d=google.com; s=arc-20260327;
        b=ClW2gKALK6pvFsGQFo70xxzVB96lrmlLsBsqK7kgMVl6XqJnJW5ZcVV1wgEWf/WRSt
         Z3hTcBQhOko6ykoaBdXZBXwsmSLtQ1PHEoyBVfIKbozEe3SQPPASdQ41TBXLbrqIsDsc
         Mr4wj5tijPSsPMU7qtW0p75sg8I9AI7fk1o1Jnmfo1MrnYIKZdPyL8BCpb0H0xjR80K7
         z0/vjrSSExfnO5jpYUIAdVsE4yt/b7xJQ+pfMBd22NG0icNySwB6h2J3SvMu50sEsgXS
         4b4xLn9fg9LmiKPwiv7AyPM10rCkphbVgbc5s0eNaApdi1RGrATg+JOIOtZQXGuXJGQp
         NLyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=iWjx8rAhOE58GpFxQdio8yvkPjUqPBmmzdlN1xwVU/w=;
        fh=cc75tngbtK0TGxzYQXeZA5EdXVOcHozyK71rNp+qTN0=;
        b=Ff2Mr3/AdkRomNKCeZdPCx/bcL7azBMiu1t7CPNbFhIzfdq7icfh3oQIBboJ9sVcwj
         xj9+mOuTrUF891+8WZmTpgSR4MQ+pdbSDHd8zoaTRtmp5rXMmxmqtwJOhuMlWLvu2InD
         nNKCUGuxYUUpj/sdKMkpi4SlKobhm/+tZXrGzn98EyycJ5dWuE804Qec3Gm1Ee0QMO9c
         mcQO3Hkz4EqVsEXz3NNzgyRauWTQ6X3r/3bdJWIffU4TuRLk2M1rHk2g/syKozoewk1Q
         dFzAyvs3OdNkqH7gZ+hd4muu+HPD46h+48rP8CITm95bJ+xkRR2Y6CwBdvi7X2N8iQBQ
         oLpg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782817006; x=1783421806; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iWjx8rAhOE58GpFxQdio8yvkPjUqPBmmzdlN1xwVU/w=;
        b=U4fKl86mwsmsaz6lHV0py0Jp4rpw+E4YYrxVOy2m35A7//DhCOTaNNZYOvmBfl3bwQ
         hkNzdvy/TehFezcQFRwzUImX7C+Ue7iQeA52kioQ76j8+uz6xBAPXRIEulzQaRrzIpmV
         wVXSfUBstUN2m/osdK2bGypTWELz/sXA1HD0hWh+pRESLvjZ9Ey1nAHbNv8UIL65KQWM
         viuKIY4U0n4A6ziqzbOe/+XpDKc20hzIUXJLiSs02YvSlrukfwBmL/JafboCNbkdyRW6
         nOTHWiotUk7aXubLyzyLQNbcazQh+zd8VNzHBce8xAHEOwp1/TtoEDGwdmY072YujD6o
         DwqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782817006; x=1783421806;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iWjx8rAhOE58GpFxQdio8yvkPjUqPBmmzdlN1xwVU/w=;
        b=GgcHuokpKvhu9/1cI4iXE5oxWVPLJ/zWl9eLci/AMDUWJRGxXe7M81p75PD7jWawZF
         eMai2qgMk76OrJMmSKcOlmgdG6loFrIaUThi9MTJmJcVP0qPpexSF8MCvaFT3LNDkuwH
         6W4bZrvQfucCYvadg1GStunEphSWM25N9X0BtcXqR9IxMvpJeLN3rlbk2ma3j/uvR4DC
         9IDkoCnb2sEuZefeltCqba6Oh60grAy7yf6Zwdrf8s3eWfsmaiYpClUiOnrh38vkkShF
         KmAQt9oWPD/+0aRGGJ6BpYTl7tb6T7iyoK07PXwCwrDfk6QsfwiFTtjRqNEQ9TWZ2ZGE
         n6Kg==
X-Forwarded-Encrypted: i=1; AFNElJ8LDvv0KlJJ9pZTLXvFvBz48pxAEQuOYF3UB0mMyguqDqnzNjlYrOELXDCqZ64Eij6j7JGdx4wEdifW@lists.infradead.org
X-Gm-Message-State: AOJu0YzQexzquRU1yuu83fcx1lwv6GHQQLyeZKNUqW636iK/wS5urjXm
	j/+UZphifqMatonW7Df8LtufzmBkK00xTeCRJLFsk7230NEpKWD+PnTOv/qouPxd4xIvjZX+RZf
	QqC2MQ9DFEZbE7c65GI3w4ZebyxqntMX3kYRJ1lOYkZof8dGL7odmRsdBBT4Q4A==
X-Gm-Gg: AfdE7cls+U2UR5ARJ7EEJI3zWqlY80vZ7E/9ujHlSlPHEw+LCOoGy4febWE5UOnLf/o
	pktzWID9ok6LLUQfE8m/DvL5A8+v7UNU95nT3lTq/65vBP0ENdFgavM9ZunfkyAHn1izuYt/Zxw
	P/VAMO0sY6Nsm7QC0V9aEoHfHyvMc+6u+IdyjTkm2GJQDOU3vRXahCFCm9ZDCEvA219bXDidqmi
	pIyM5Wk5vQl6sWl6gnRndzizYvvVIXkSh0oaoiqnVWLGpRCQI5yZNrva3Srb9wVs6iD
X-Received: by 2002:a05:7022:160c:b0:138:507b:30fd with SMTP id
 a92af1059eb24-13b2a15076dmr2003427c88.6.1782817005212; Tue, 30 Jun 2026
 03:56:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260614131541.2017845-1-nilay@linux.ibm.com> <20260614131541.2017845-13-nilay@linux.ibm.com>
 <20260626064816.GB11106@lst.de> <b9961ab6-897d-4a93-8e43-8b23eb439fc5@linux.ibm.com>
 <20260629125010.GB23695@lst.de> <5eb42ac4-9fda-48ec-ad65-c895c81d7608@linux.ibm.com>
In-Reply-To: <5eb42ac4-9fda-48ec-ad65-c895c81d7608@linux.ibm.com>
From: Marco Elver <elver@google.com>
Date: Tue, 30 Jun 2026 12:56:08 +0200
X-Gm-Features: AVVi8Cf57SFOnjwJgycj6ifmVOzfxEjJy4c4ZEmoyxeD8BitA2N4ce102U1SMjw
Message-ID: <CANpmjNMnaxfoT6C5rC_Q8NaEuVANN0-imbYKZ6LNA004_uuMxg@mail.gmail.com>
Subject: Re: [PATCHv2 12/17] nvme: add Clang context annotations for nvme_queue::cq_poll_lock
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kbusch@kernel.org, sagi@grimberg.me, 
	axboe@fb.com, bvanassche@acm.org, gjoyce@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260630_035646_961690_CDA3F9E0 
X-CRM114-Status: GOOD (  25.05  )
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

On Tue, 30 Jun 2026 at 11:26, Nilay Shroff <nilay@linux.ibm.com> wrote:
>
> On 6/29/26 6:20 PM, Christoph Hellwig wrote:
> > On Fri, Jun 26, 2026 at 08:52:36PM +0530, Nilay Shroff wrote:
> >>
> >> That's because nvme_poll() and nvme_irq() both reuse nvme_poll_cq() to
> >> process completions, but they rely on different synchronization mechanisms.
> >
> > Well, we could split the function easily, but it still uses the same
> > data structure and thus annotations.
> >
> I see your point. The annotations describe only the polling synchronization model,
> while the same state is also accessed under interrupt serialization for IRQ queues.
> Since __guarded_by() cannot express alternative synchronization mechanisms today,
> the annotations end up requiring __context_unsafe() for the IRQ path.
>
> It sounds like your preference would be to leave these fields unannotated rather
> than partially annotate one synchronization model. Is that the direction you'd
> recommend until the annotation infrastructure can express multiple valid
> synchronization schemes?
>
>
> Marco,
> I know it's not currently supported, but are there any plan to extend the current
> capability model to support multiple valid synchronization mechanisms for a single
> object? For example, allowing a guarded field to be protected by either a lock or
> another abstract capability (such as interrupt serialization), instead of requiring
> a single __guarded_by() relationship." For instance,
>
> __guarded_by_any(&cq_poll_lock, IRQ_CONTEXT)
>
> Then irq handler would be annotated with __capability(irq_serialization).

I had planned to support IRQ context locks, which would be abstract
but not be backed by a real object (similar to how RCU is handled).
Just haven't gotten around to it.

> So now the compiler would know if the code executes in the interrupt/irq context
> then access to the guarded variable doesn't require any lock otherwise it needs
> ->cq_poll_lock when accessed. I don't know how easy it'd be to add such support
> but it may be explored.

Multi-arg __guarded_by() is supported by Clang, but perhaps not
exactly the way you imagined above. This has a brief summary:
https://patch.msgid.link/20260515124426.2227783-1-elver@google.com

In short, you can hold any lock to get reader access, and must hold
all for writer access.

