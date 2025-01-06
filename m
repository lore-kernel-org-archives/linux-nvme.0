Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76E99E77188
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jan 2025 18:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VN2w7YY7FSFUfE0QVBg0AB5tbb1kjnD60fsO9HYNczI=; b=WJUSbMlBDbmJHrJG7FlRnsihxh
	TRNtzScOxw5EX8Hizbx0rwLYMLk6iE51KgHfAYewRSBg9GNxxJD0QDiBLdldFcpLLJfx2J5//pGbD
	5iCy9scS17+pdXp2Uawuq5JVsCNnacvadCFaHNat3BKsh/M6JJHPpi21Wc9rOR8H8SiGzn4itjLPE
	TvIChuzweVCvtI2W5Vr1+Tqw7/QR70zIBe4TEZHpDxtFjt+WvvM7hsbh7r4eEjS/ti8oWvhIVzive
	Vny533tnQkCkwwYuz9k2ziJ7RiUeWrNhk5YE7cK7QgTiEfiV1spxXeXNCj4Ty9uOcdTaUv5NKY9kT
	Ks9+e/jA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tUrxn-00000002JEB-16QN;
	Mon, 06 Jan 2025 18:36:31 +0000
Received: from mail-yb1-xb2f.google.com ([2607:f8b0:4864:20::b2f])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tUrxk-00000002JDF-4B38
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jan 2025 18:36:30 +0000
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-e545c1e8a15so8137714276.1
        for <linux-nvme@lists.infradead.org>; Mon, 06 Jan 2025 10:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736188588; x=1736793388; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VN2w7YY7FSFUfE0QVBg0AB5tbb1kjnD60fsO9HYNczI=;
        b=fipqoEvblL8buq9QoCoS3lDb145xUD9g8DnL6tEV4Rw9SYgEoUgUAMbfOmzU4N2673
         pyGABCS2PD0KXk3HJhPWp9pHOj/8rChXlDJ5AeAJ0DovV0KLEFzP6d7PMlp0GkrsBvxw
         xMJXxZS9TtvDnerrzv3qsJi2Hru47OyI8fP1MeNDQuRx0nK9nO7X8dj+CeU3W5/02nsD
         AQQTdNvHQtnWxqPNWgHHXb846O0Mt71yLQrpEhsJ8i3cFLhUnC5XF3J4Auuk8Sj1u5cH
         iVmLjVWBY2l9ltndIdTh9j2HSyGGMGsRicyMi6crv5VhJAJNA45YRbip/Vrdn0o/zo98
         rPMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736188588; x=1736793388;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VN2w7YY7FSFUfE0QVBg0AB5tbb1kjnD60fsO9HYNczI=;
        b=auXOAQvDHzf1XRmQJA+kK6YIalyG0Srl0Sb/9amVQb82MfZp7QO4RaYuf6o0nYGBeL
         v9hA9ozH+wpLiIh5PGjx5yycleX549ONt5CA4Z28ZF4j81grTIsoZcCNDr0rUxa8h/xB
         2S74/gKg2psdhf59+kkpaq4I+plvZPTWq58iv8ZfW/QM0gxtSHKaKwEiZJfymmve2nIa
         smWAMnk2HI77G9AkP2xz/LH3L968Ky2quvXXM5uZ4aOwHOYD7UdAlXlMBglI7fTpZw1j
         GxjIfjP5x2geZ7Ypw2Z1yLerhYjRzXM9Dg925g6cgX2MPqaAEVSBD+RiM70+Z26OOlbO
         8ubA==
X-Forwarded-Encrypted: i=1; AJvYcCXcGjW4/1QxwDZag58SrlgHWFjWO6TBvZDVC1OD+160U6aDmOuKWWhmljqYVygoALjs+b2+/B1no7Hs@lists.infradead.org
X-Gm-Message-State: AOJu0YxZuzlxaH5rh9VXjRc7wwkf2Rmi6fdCWXUYivSHfKe2EQLWYcHc
	1aulU9rUhccOPQqLwtW8y7X/s+Csm4qaMH1XMOQKIGE7g2t/pgjPpLVUxB6HRc0ap/aOnreWn5K
	sBd0m5T638OP56+5IyZ9ta8eVciE0S/vTFMec+w==
X-Gm-Gg: ASbGncu23EuX1zkCenwaZSzduSYERVWAH6Zaoirv0FsYz3WV6KenDUCXk2dQKUm/rxe
	L8yx6PIqbQA8qBb4HbYHlcRD9uMJfDSURB60msiWL
X-Google-Smtp-Source: AGHT+IFWoEjaetOCXkyP5M8zxfOMZNipZ8dkUPXy0YYnoPeLo83JBMX14PaoDJCWB3aOTFkvuecUd63rv7lHPEs699w=
X-Received: by 2002:a05:6902:2290:b0:e4b:6380:f4c4 with SMTP id
 3f1490d57ef6-e538c259e83mr41698329276.15.1736188587937; Mon, 06 Jan 2025
 10:36:27 -0800 (PST)
MIME-Version: 1.0
References: <CAJHDoJac2Qa6QjhDFi7YZf0D05=Svc13ZQyX=92KsM7pkkVbJA@mail.gmail.com>
 <CAPhsuW7+ORExwn5fkRykEmEp-wm0YE788Tkd39rK5cZ-Q3dfUw@mail.gmail.com>
 <CAJHDoJYESDzDf9KJgfSfGGit6JPyxtf3miNbnM7BzNfjOi7CQw@mail.gmail.com>
 <Z3uIOPxr4s09qS1X@infradead.org> <6c63dd3a-378d-471f-8af0-725edc3785ed@linux.dev>
In-Reply-To: <6c63dd3a-378d-471f-8af0-725edc3785ed@linux.dev>
From: Vishnu ks <ksvishnu56@gmail.com>
Date: Tue, 7 Jan 2025 00:06:16 +0530
Message-ID: <CAJHDoJYcqAHqtLVwC=P8Q=CmF1K==A_VA8oBuAc9hhnsUBz5xg@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Improving Block Layer Tracepoints for
 Next-Generation Backup Systems
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Christoph Hellwig <hch@infradead.org>, Song Liu <song@kernel.org>, 
	lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org, 
	bpf@vger.kernel.org, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250106_103629_026859_EEA10AED 
X-CRM114-Status: GOOD (  21.21  )
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

Thank you for the suggestion about fentry/fexit monitoring. However,
as Christoph pointed out, the fundamental issue isn't just about
performance or number of events - it's that the sector numbers
themselves can be modified by drivers during submission and I am not
sure if this is notified back to the kernel somehow.

On Mon, 6 Jan 2025 at 20:09, Zhu Yanjun <yanjun.zhu@linux.dev> wrote:
>
> On 06.01.25 08:37, Christoph Hellwig wrote:
> > On Sat, Jan 04, 2025 at 11:22:40PM +0530, Vishnu ks wrote:
> >> 1. Uses eBPF to monitor block_rq_complete tracepoint to track modified sectors
> >
> > You can't.  Drivers can and often do change the sector during submission
> > processing.
>
> If I get you correctly, you mean, the action that **drivers often change
> the sector during submission processing** will generate a lot of
> tracepoint events. Thus, this will make difference on the performance of
> the whole system.
>
> If yes, can we only monitor fentry/fexit of some_important_key_function
> to reduce the eBPF events? Thus this will not generate too many events
> then make difference on the performance.
>
> Zhu Yanjun
>
> >
> >> 2. Captures sector numbers (not data) of changed blocks in real-time
> >> 3. Periodically syncs the actual data from these sectors based on
> >> configurable RPO
> >> 4. Layers these incremental changes on top of base snapshots
> >
> > And all of that is broken.  If you are interested in this kind of
> > mechanism help upstreaming the blk-filter work, which has been
> > explicitly designed to support that.
> >
> > Before that you should really undestand how block devices and
> > file systems work, as the rest of the mail suggested a very dangerous
> > misunderstanding of the basic principles.
>


-- 
Vishnu KS,
Opensource contributor and researcher,
https://iamvishnuks.com

