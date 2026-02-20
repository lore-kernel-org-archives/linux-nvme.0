Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7E8AE9A041
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Feb 2026 03:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k7rjO09Qd1PCia3GWJepW+wiP4vdkps62yqOT5MFeTA=; b=ziH2zRgvDttDgQFQrHUmXmroL3
	E35xxqn6zmuSFgdAhzCntAEhqLZO0T/YbVXe1YBjv7pp5I8gG2N+z/NzKD6tdGIqxGL8ow+iwTZVi
	hg9jj+WxYHXz6n4yQ2X/dmhToTYTQ3LvZJmsGOGBtLbY8I/cAHzJQLCPE0WHln/nXU9d0hLV7tASK
	JIc1pTfsVTj2oT7wr/vmR24qskdwLbvunaho+gNi/Rae4CCgQ9gcycs5MTTcyMZmUmArCxJSOVuwF
	7PMxS9KlEStifChJZbrgzCP+3r6tM2K94yA0UT3i74sIdTHrYrutaJx74ipuJx7lP+LCvRf/riXae
	nnVN2VFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtHHw-0000000DB2v-22nO;
	Fri, 20 Feb 2026 03:34:44 +0000
Received: from mail-vs1-xe2d.google.com ([2607:f8b0:4864:20::e2d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtHHt-0000000DB2a-3x5y
	for linux-nvme@lists.infradead.org;
	Fri, 20 Feb 2026 03:34:43 +0000
Received: by mail-vs1-xe2d.google.com with SMTP id ada2fe7eead31-5faddf6db62so1029594137.0
        for <linux-nvme@lists.infradead.org>; Thu, 19 Feb 2026 19:34:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771558480; cv=none;
        d=google.com; s=arc-20240605;
        b=AqhoInyspsoCjlIFv1nKXF/IEZE1YhK3We7KkODOZ2PZTBYB8feOcA/v72URGw2uMl
         Qo9lq4VP36LA4+FXIKqut/BFdtLQrp8+knur38NbWyFf9jaGpszghQi8BGc4FvaHPj3u
         jCenyj7+mreTpAm/i05UwEUaBrhPuEBF3UXs15DtfXb8RzEpeuMbYYxQpNnDEbEnCtxn
         sR4EjXCSQMSONBdU8mzTBMxXkBU7DvxZKw3G5xW2FyYeF0BsVX5m3Uiu+BfJDk3APYCz
         hUPkRV2pqwYx8x3SDm8b1+DUcHQAQBofyQPPYgH8wJXynkf8as4HETOkf5l2W1SFrB5y
         ZlZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k7rjO09Qd1PCia3GWJepW+wiP4vdkps62yqOT5MFeTA=;
        fh=Q1fJgOLkZ2BQ7npR1oTKWEkxE0F83sFu+F0If+Tjzns=;
        b=QKYmCR7YOkl29/BFoEPIMe7tQAMt1/AgzfAHK0ocr9dn5+1oaCM9h5UQo37cPF+SGQ
         iicJ/sNrTBmuAiztfAz1ydx+Movv+fzK+bjcIH4eev4v5x2L08ccYHzDMhh9cfKEmEAf
         UKnYAOcDAD1irE/hjX3HoRYwt6QxvyWVrSRfHsoPXMr8qOQqGflfb507ooJBJ11vkZLq
         5MK+fHQVa/7ujr+fUxAzG6Q3xPtbynkOoXTpboK1BQQ1b6SrXcu6p396lmEE8i83OSDn
         wS2fhMN4V16zFC2hJbgt9xMNX1N0UT/PxYQ5iXJ4IlamGlcivCIAoKF9H0Qg17NtPimP
         9GdA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771558480; x=1772163280; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k7rjO09Qd1PCia3GWJepW+wiP4vdkps62yqOT5MFeTA=;
        b=BW+hPu53LqINu08rB5plVTDeuWE52PH/jBszXQqdqS7E8LrLLV6tjT9G68bUpWnWR9
         QvkP34n/2irP5gNZhdJvg6GAavI3n+f7WOhQMTIVSHOtHy2mhhYARdTNLvA1B/0bGk+T
         uoM+8QXU/Co0sVmY3vHQ3Z7B9egSREFGHGZZY1qhup2655ul7UUJLYiZIUp+aCEL0OaR
         S08SolJ7KI9b3TGyIoHsB11cbZz+0w3L5Q3oO3Yl4tTDlS238zoXl813gLGnUtrZA6CE
         LJ4AZYV5vJGYR/A1AlxxLwCT8p26WIn4TyLEosTPNQTrQpQLsQtxIzaJkMCAMS5RRTQo
         7BBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771558480; x=1772163280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k7rjO09Qd1PCia3GWJepW+wiP4vdkps62yqOT5MFeTA=;
        b=ulKfVqK+bsLI4DY8z0ZUWGubmaLw35ZnjHh5Fq2OPAAS0PcNedBHuaQIl90xM/6t0n
         d7k7cu/yDrPhX17hR6pG9aIDWwLPbHvQGNbhHlQIabSgGnUnb9ozAomxwMOVsB55jn62
         5XbH/QLKDYjfNmLjglcj6k01mHm+6gkAxO7clxMWmdwf/EGEVjEMObydFQ/VNwGPql8P
         D11Ex73Aq/yIqUVMJ+qq8Ug/JKKQPsOgyZOcP8PNeEOXBeJxisQD/h3R1VeeGEL8dbmE
         KY/7hhpCCPkTebHJElcWu6d27SskwM6YvDZ5uFrSABTcSU8YLQv2QNccN0q8SyTdB4Iq
         GUUA==
X-Forwarded-Encrypted: i=1; AJvYcCW++kQ0pRc6GtMbes1rsAFwwLaVZ0zpOx18YnbLCaxJFsu2xSq6U+iyE4Xpfv0mS9G+UYhHSmRWIkeX@lists.infradead.org
X-Gm-Message-State: AOJu0Yx5G1j8SAxqRZwGyBzB/uYMrCeed9svnTaUTqjBZf/H8p2swMh+
	0PTz0SuMhWuckOpgTZtoSlR9ukdCgk6zts1WTR2euXhch0moVUVk2/IKt6WdhQwHyrDTCsxfBsd
	rBA8iAAC3XfHuh1L4gHIBcnzwRVe8ALZRuKBayBeWUA==
X-Gm-Gg: AZuq6aIXxb4kDhH5oOBI8OwBZCpdVY6DPd1EKr1JofxoOStSlSl3DzPnEJ2IhmpIdOr
	5gJmCqX+P7CMbpZCOP2p6uXwTAQexupYbLKLueoCioTp2qc2WffFiWBuygVSNgfTg2KFlCf1Nq6
	RA5MOWXexk+npRSQb34IAqezflEyUwda4+gQKBggZnRr3ITB3Lu28+o9W8MttDdLRqY7kC3ua+j
	Y4JzMvX3xaZPWHeujrJj1hnIqeb2KuhjpRUGMVsWL915R5nDoKWC+7ZKwFaASzUBdcE00aI83Z5
	42MXCs9Vx8hxU8ztB0cgbkXM0bXeSWedJiHohZhwau2JhO8WavXKgYZnl8lbSpftBbIA
X-Received: by 2002:a05:6102:3f47:b0:5fd:d831:2938 with SMTP id
 ada2fe7eead31-5fea7b14d97mr246794137.22.1771558480289; Thu, 19 Feb 2026
 19:34:40 -0800 (PST)
MIME-Version: 1.0
References: <20260214042753.4073668-1-mkhalfella@purestorage.com>
 <20260214042753.4073668-10-mkhalfella@purestorage.com> <3b21ccbd-7948-436b-8faa-a5541c65946a@suse.de>
 <20260217182554.GE3435530-mkhalfella@purestorage.com> <1a9feff7-5a0d-4385-b582-c9ab60d724db@suse.de>
 <20260218124708.GJ2392949-mkhalfella@purestorage.com>
In-Reply-To: <20260218124708.GJ2392949-mkhalfella@purestorage.com>
From: Randy Jennings <randyj@purestorage.com>
Date: Thu, 19 Feb 2026 19:34:29 -0800
X-Gm-Features: AaiRm5379xPpMYTbIGARySCQChLDvx1N7AvbXm3OBFgfiG1adpfniuYYuE3nHLI
Message-ID: <CAPpK+O2cdnxkqrVtt4VPQWWmz-aotkCxQWntk-K8Q8Y2Vr+ACw@mail.gmail.com>
Subject: Re: [PATCH v3 09/21] nvme: Implement cross-controller reset completion
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Hannes Reinecke <hare@suse.de>, Justin Tee <justin.tee@broadcom.com>, 
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>, Paul Ely <paul.ely@broadcom.com>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
	James Smart <jsmart833426@gmail.com>, Aaron Dailey <adailey@purestorage.com>, 
	Dhaval Giani <dgiani@purestorage.com>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260219_193442_018211_3B05D47A 
X-CRM114-Status: GOOD (  24.07  )
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

On Wed, Feb 18, 2026 at 4:47=E2=80=AFAM Mohamed Khalfella
<mkhalfella@purestorage.com> wrote:
>
> On Wed 2026-02-18 08:51:31 +0100, Hannes Reinecke wrote:
> > On 2/17/26 19:25, Mohamed Khalfella wrote:
> At the same time the current implementation only waits for 1*KATO before
> retrying, so there will be regression if we switch to TP8028-compliant
> KATO handling for systems not supporting CCR.
Hannes, as I read the code (this is patch 19), if CQT is not set,
there is no delay. I
was expecting that to continue forward (I would be happy to exclude
'1' also).  I agree that we would not want to use CQT where subsystems
have not requested that time to quiesce.

Am I reading this wrong, and you are worried that committed code currently =
waits
for 1*KATO, and this patch set shortens that?  I do not see a delay of 1*KA=
TO in
committed code. What am I missing?

> > > On Mon 2026-02-16 13:43:51 +0100, Hannes Reinecke wrote:

> > So we can (and should) use CCR as the determining factor whether we
> > want to switch to TP8028-compliant behaviour or stick with the original
> > implementation.
>
> We do check CCR support and availability in nvme_find_ctrl_ccr(). Adding
> a second counter will spare us the loop in nvme_find_ctrl_ccr(), which
> is not worth it IMO.

Another option is the Commands Supported log page.  CCR is a command,
so support for it should show up there.  The data structure is not the
simplest to reference; it might end up more complicated than having a
separate flag (why use another counter?),

RE:
> > want to switch to TP8028-compliant behaviour or stick with the original
> > implementation.
Hannes, do you mean TP8028 or TP4129?  Yes, if we do not support CCRs
we should not send them or expect to receive a successful response.

I would be careful of stating this in terms of TP-compliant behavior.  I
care about fixing a data corruption.  TP4129 worked out what that
required and provided a channel to communicate how long the
subsystem took to clean up, but I really do not care much about
compliance outside of compatibility and predictability.  As long as the
data corruption is handled conclusively and in a feasible manner
(IOW, no, the subsystem cannot clean up instantaneously, and we
do have to deal with possible communication delays while
coordinating between the host and subsystem), I can be happy
with the solution.

Sincerely,
Randy Jennings

