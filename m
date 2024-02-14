Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB5D1C48BC1
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Feb 2024 21:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1zLAECwrJ2PUOqlfWdr2qyktfryL4kJ22/dpgwjQNas=; b=dxb4Uh4iGpCO4rkJEVgTNHdpdC
	au02uj90fnuHd5DQTFp5cWo3R7lwKpxF5bOokDvFVJHa1IocPb25/UX9dhAk9y6BNpW/keQ27vY9b
	VFua/CMyGPa45rLUxCPPlDhnB7PGzGKx8Br0P+IG4U4GRdsFy6qW+4fUpvhBjO16FVh8eEe9NL3V6
	PydMhKi31PMzjWl8c3JPI3jASikGOdTs8wct4bThcT7q27WmUFkSxL50HbsECjdX5Ff+o0OxL/l36
	06j6fSpv2XJ1R5yllZiYKoWHsSTXzRbOUI9SLjKPCik8drtZx26+bjex+gG4wwP6JQ4w/Bg5TBrTz
	5oxH+yaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raMwJ-0000000EKCj-1GnI;
	Wed, 14 Feb 2024 21:37:11 +0000
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raMwG-0000000EKC0-3mwi
	for linux-nvme@lists.infradead.org;
	Wed, 14 Feb 2024 21:37:10 +0000
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-42dc7306ca1so11821cf.0
        for <linux-nvme@lists.infradead.org>; Wed, 14 Feb 2024 13:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707946627; x=1708551427; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1zLAECwrJ2PUOqlfWdr2qyktfryL4kJ22/dpgwjQNas=;
        b=GQ7GOt4fY0j6kKSDqHOFaFknNaTdP/hoUOK4UHnmtiCWVjABssi9xf34K40QaNshlh
         /eXzh9MBuxHeQGUQdfVjhF99+mNCePxRrziZGmhNwkJ6iBKldVNx7v691ohok4aWI1G6
         VVT8UIax4uPiDDdyjtRQ1WCpPt/nenfX7fcg9e5GlcCGd5i+HNPK2H3Ga+9rOlXfFh+4
         HFzONGF4AJL3kY+kaXQwKoclFczAwxkTyeZqGCaCVZivt7seLRaKoBFTrZ3zuY30eomC
         Ru3opnlHis3XIGVAiLJYfmEKupzRmN0NjtJ4LyrgxLUkPD/OvBSTcv/vuCn/I4lcF7Dg
         XqqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707946627; x=1708551427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1zLAECwrJ2PUOqlfWdr2qyktfryL4kJ22/dpgwjQNas=;
        b=i7GHnMCy+CJAkPmUe438puFC9giskswAontaqLm0F5kWH6GoK1WxtUdJ+IS0a4Nc8o
         cUQ/IAZrEu4RLgEpygbc2RFz1ypUDgKtMmWEac/2SvCb6xrHhHx0l0v123Th7mVSaPiL
         8IMgxMCjQBCh1B3w7wFZv8tiXlEO7owBeEusKt5JRP6LJUreuATbtzjVMw6iw+jRdLe2
         5L2ESQoW961CsYHphD33Gr5VUmPPZKDPyjlORDddbdIGpQNLYthpdSfG5PGxSU76DELy
         kHWf0dKwmXZot+s6RZIvZ5cQA8z51o6DAXpUtoR1BUvYd+9CgRvPsDpJSIH1yULn6wOv
         dAwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfGcH1HugDLBbGCddN0dOR3XVpHE83ElNEf6XBkpFpkdSxtwrOZ3wUnosy8+u37wKma+j9Pzm9plMIBDnw6m51llRplYORsBU3HxGv+SI=
X-Gm-Message-State: AOJu0Yw8TeyCrlO9cpefh1TkiIKoxsaP80Fh1CtHL6Xyr/DQayt7F8cI
	yvyX1+4BuhoHNmF6nBgcNRvApKaKmiOU41RjVkUvgzoKccvX8VP0qHcsBpAjUFUPNTgCqxr97bf
	0NIg43eb2gFzfzIe3ocGz2IxTDGE134VGpnsE
X-Google-Smtp-Source: AGHT+IEa+zEp2N4eV2YHM0tM1J6qxXMR+UEs9s4UYYmlt9dA2BKy0wFqPHgzVIzfHLj0HFTJsfr3+shAV4H0XnC6ofM=
X-Received: by 2002:ac8:5c56:0:b0:42c:757b:9409 with SMTP id
 j22-20020ac85c56000000b0042c757b9409mr407445qtj.16.1707946627357; Wed, 14 Feb
 2024 13:37:07 -0800 (PST)
MIME-Version: 1.0
References: <20240129181953.1183084-1-jallison@ciq.com> <20240129181953.1183084-2-jallison@ciq.com>
 <CAGETcx_eUELgBcTdmgA=iN9Mx7U4jHmjEZm_ZjEphF-VB4Thyw@mail.gmail.com> <20240214081003.GA10980@lst.de>
In-Reply-To: <20240214081003.GA10980@lst.de>
From: Saravana Kannan <saravanak@google.com>
Date: Wed, 14 Feb 2024 13:36:28 -0800
Message-ID: <CAGETcx9WiPUcVkU3bc3-HA7WN_Mq4JaBZB9HQn+LE0F26Tte1w@mail.gmail.com>
Subject: Re: [PATCH 1/5] driver core: Support two-pass driver shutdown.
To: Christoph Hellwig <hch@lst.de>
Cc: Jeremy Allison <jallison@ciq.com>, jra@samba.org, tansuresh@google.com, 
	gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com, 
	sagi@grimberg.me, linux-nvme@lists.infradead.org, 
	Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240214_133708_968253_03C67E26 
X-CRM114-Status: GOOD (  23.80  )
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

On Wed, Feb 14, 2024 at 12:10=E2=80=AFAM Christoph Hellwig <hch@lst.de> wro=
te:
>
> On Tue, Feb 13, 2024 at 07:36:35PM -0800, Saravana Kannan wrote:
> > > This changes the bus driver interface with an additional entry point
> > > to enable devices to implement two-pass shutdown. The existing
> > > synchronous interface to shutdown is called, and if a shutdown_wait
> > > method is defined the device is moved to an alternate list.
> >
> > This sounds more like you need a parallelized async shutdown than a
> > two-pass shutdown. Similar to how async probes are done today. Why not
> > do that so it'll actually be useful in a more general fashion? You can
> > even add a flag like we have for probes so that drivers don't need to
> > do anything special to allow this parallelism.
>
> Well, we had that discussion before.

Can you point me to this please? I looked around and wasn't able to find it=
.

> The typically time consuming
> part in a shutdown is waiting for the device to actually shut down.
> An submit and then wait later scheme is more efficient for that,

This seems like yet another one of those "who needs more than X
levels" issue we run into with initcalls. We are finally getting rid
of that with fw_devlink and device links. This two stage approach
breaks down as soon as there is any kind of dependency order that
needs to be maintained across device shutdown.

> even if the "simple" async shutdown that just spawns more threads
> will also work, while being a lot less efficient.

Lot less efficient how? Shutdown is not a frequent / hot path event. I
don't think the number of threads spawned is an efficiency concern as
long as it's faster and is not fragile to use in a generic fashion for
all devices.

> So unless we
> have a strong reason for that the two-phase scheme seems preferable
> to me.

I think the strong reason is dependency tracking and ordering doesn't
work with a 2 pass system. Dependency levels are often several levels
deep.

-Saravana

