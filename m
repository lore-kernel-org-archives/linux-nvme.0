Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77DA6EA4E09
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Mar 2026 14:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NQSboOUCE1MZRdwtnGgUrTO3ZFv4uMpDjqNi+XdsG84=; b=rPmTTQx17YiNBx93KzBfUcyTqI
	0Z5SWJnr/eURhhbKaCB7HNEwC7piLHvQPrQP6RAtxEFEoAXYHCM3qbLyf3/OGL2Wj76sJ4zUZvIEa
	FytWSyH7jz1gKRIA2R74C/7W81xVk9IYQWCqJTCUrwsY3lTEBhDuR5F+c/boqlozny+nEmoKXIRw6
	3Y43KZjCWTU15hsg+kDIRStoW1ZvliCr2dN1LcZ5Thp2eG8EJBJSUqyxYoXSowklYxtNlV//DZVzp
	GYJUPS0P9aFtT3vCrFd9OykmYqB38H8nJKYL8o0s/MA/kQnJJ3aWrn0wtikyl/Abus4f/3jRWSAYr
	sq/Y0P2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vx41E-0000000DCz0-3nYM;
	Mon, 02 Mar 2026 14:13:08 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vx41B-0000000DCyC-465s
	for linux-nvme@lists.infradead.org;
	Mon, 02 Mar 2026 14:13:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772460783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NQSboOUCE1MZRdwtnGgUrTO3ZFv4uMpDjqNi+XdsG84=;
	b=LqPAvZxlv8+OAgA6m5Vo4kWryKVnPLD4cJmEdi0OCkRxWAyiA9FwD491G1ofSDZDwsQgrv
	duKvl4QmFLVuGFDbpDZXwIuSiTH5xaqjWFs5BPZENX7KYJMvy3Kyo8I7vnRQC40Zgd2Oqq
	B1nxBrqyK1ME7YQdEkGCD3SjY8rG6Oo=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-eDQZ_ZHvOgCBkLxO0t_WTw-1; Mon, 02 Mar 2026 09:13:02 -0500
X-MC-Unique: eDQZ_ZHvOgCBkLxO0t_WTw-1
X-Mimecast-MFC-AGG-ID: eDQZ_ZHvOgCBkLxO0t_WTw_1772460781
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-5fde9324273so47394970137.0
        for <linux-nvme@lists.infradead.org>; Mon, 02 Mar 2026 06:13:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772460781; x=1773065581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NQSboOUCE1MZRdwtnGgUrTO3ZFv4uMpDjqNi+XdsG84=;
        b=T4GaM4Co74FQL5YdtOGEfc1Wm0K57f6iVrvjdQgRsL03bZGLw2SlQUkFgFUo3kYbzt
         DiAsaivkxCq+ak986Y9sn6TAdPXlc2RnkVuHxlv4SKzg9/UiNOjAo2YndyBj29cud0dS
         j5MjAAUaFsd/CjwIXm8PGNBLbbkVzgshqKVtOuY4vnVgScQ3AnhwsMXlU1AeA5SX8jMd
         SRht9uPc77/VsNCjcGanLeWy6ETLl1X/apq6Kl0LcL6LFvtsIQ652efj9T/zHXkZLO7M
         YPyWxaPtQ+K+VH0+oDtDw2nys3wTq5SmeY++BPuMQfu8osnDvXAZbrkC9XgxsEHrndNt
         n8Cg==
X-Forwarded-Encrypted: i=1; AJvYcCX/GxkAGGK9T6y3OrhbBaswsSIGUNszvzxgIq1eFMjyZ7YRcf32Wu1ybflF0kdJSC3/GOdhOeNk2i2S@lists.infradead.org
X-Gm-Message-State: AOJu0YxqrSFkM9NXBujhOM5EiVzi1sUQRXaqFbd/ccxFs/80HYL9B8ig
	Kvyh8rByt77Mqsyqy4FTh75jIg6ji7B0Yx7uI+qHD7IDi3+LjukJy42YvsqGMyGo8En2BuJ91fH
	+7j7A8zjEub/hmDzOsMA1Si5BCKc/C/8VV4OISwyNroKIcsC1uXRCmtL1jkrNvybJnG0JhPdu4z
	EL0UWUmEO/MVV3U0ex4UspKgL0OlJsXruIdIUZynPCubM=
X-Gm-Gg: ATEYQzwkHfy8G9gimbwq76No7ql9QK4Bu9TOvps9B0FO4GQJD5ucAfBIouhArouGcmA
	jNFZFahaqUwzKkof02PaYrywbUiOSN9A7uPYNzfin9KFpm0dcz98HaHJMNjVCrt93mJBqYewVGw
	lBJw4zY7pTnMJtC+L3DOTEKpDElVYoBc97E96xfIlQTRNAzv9H8O/NJ2t3IA1GVa0sIEZhq2BBh
	2ZZEOc=
X-Received: by 2002:a05:6102:3ec7:b0:5ef:8ae:85a5 with SMTP id ada2fe7eead31-5ff32324fa6mr6167076137.16.1772460781313;
        Mon, 02 Mar 2026 06:13:01 -0800 (PST)
X-Received: by 2002:a05:6102:3ec7:b0:5ef:8ae:85a5 with SMTP id
 ada2fe7eead31-5ff32324fa6mr6167053137.16.1772460780942; Mon, 02 Mar 2026
 06:13:00 -0800 (PST)
MIME-Version: 1.0
References: <20260226-revert-cpu-read-lock-v1-0-eb005072566e@kernel.org>
 <20260226-revert-cpu-read-lock-v1-3-eb005072566e@kernel.org>
 <aaBS4pvtiFHL1LSz@fedora> <eb461226-1b64-4b67-a419-5b5886792d68@flourine.local>
In-Reply-To: <eb461226-1b64-4b67-a419-5b5886792d68@flourine.local>
From: Ming Lei <ming.lei@redhat.com>
Date: Mon, 2 Mar 2026 22:12:49 +0800
X-Gm-Features: AaiRm51lhpC0NTqv2yO4th0zDsCHXsoRknyKS3DuJC9igXC7axPFJ7GZOoGtWQ4
Message-ID: <CAFj5m9LQ6KOhu0CsqYgW_9xZGDAj5KdUfX2gXAy_HODba-0GnA@mail.gmail.com>
Subject: Re: [PATCH 3/3] Revert "lib/group_cpus.c: avoid acquiring cpu hotplug
 lock in group_cpus_evenly"
To: Daniel Wagner <dwagner@suse.de>
Cc: Daniel Wagner <wagi@kernel.org>, Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Guangwu Zhang <guazhang@redhat.com>, 
	Chengming Zhou <zhouchengming@bytedance.com>, Thomas Gleixner <tglx@kernel.org>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mYocT0Gp-fvXpNmWPCFTMz40h3rRjTowqAyObYiKDi8_1772460781
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260302_061306_087710_F1894BD4 
X-CRM114-Status: GOOD (  28.73  )
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

On Mon, Mar 2, 2026 at 10:05=E2=80=AFPM Daniel Wagner <dwagner@suse.de> wro=
te:
>
> Hi Ming,
>
> Sorry for the late response. Last week the mail server did take a break..=
.
>
> On Thu, Feb 26, 2026 at 10:04:18PM +0800, Ming Lei wrote:
> > On Thu, Feb 26, 2026 at 02:40:37PM +0100, Daniel Wagner wrote:
> > > This reverts commit 0263f92fadbb9d294d5971ac57743f882c93b2b3.
> > >
> > > The reason the lock was removed was that the nvme-pci driver reset
> > > handler attempted to acquire the CPU read lock during CPU hotplug
> > > offlining (holds the CPU write lock). Consequently, the block layer
> > > offline notifier callback could not progress because in-flight reques=
ts
> > > were detected.
> > >
> > > Since then, in-flight detection has been improved, and the nvme-pci
> > > driver now explicitly updates the hctx state when it is safe to ignor=
e
> > > detected in-flight requests. As a result, it's possible to reintroduc=
e
> > > the CPU read lock in group_cpus_evenly.
> >
> > Can you explain your motivation a bit? Especially adding back the lock
> > causes the API hard to use. Any benefit?
>
> Sure, I would like to add the lock back to group_cpus_evenly so it's
> possible to add support for the isolcpu use case. For the isolcpus case,
> it's necessary to access the cpu_online_mask when creating a
> housekeeping cpu mask. I failed to find a good solution which doesn't
> introduce horrible hacks (see Thomas' feedback on this [1]).
>
> Anyway, I am not totally set on this solution, but I having a proper
> lock in this code path would make the isolcpu extension way cleaner I
> think.

Then please include this patch with an explanation in your isolcpus patch s=
et.

>
> What do you exactly mean with 'API hard to use'? The problem that the
> caller/driver has to make sure it doesn't do anything like the nvme-pci
> driver?

This API is usually called in slow path, in which subsystem locks are often
required, then lock dependency against cpus_read_lock is added.

Thanks,
Ming


