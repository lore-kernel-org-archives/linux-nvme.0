Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05A31C8303C
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jul 2025 15:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0v2CaHY1VAi0HOiCc4Zf7ehSdSOjQyZPIEDJJM+6zG0=; b=0N1hL+zcJ02tK4pUtghYzqyyNu
	aeZL2a695RD/iAgMxwvgIc+lmnX+yTd3hUMMaMG5Y6oH0WHkdqpyaiT9lVDugY+VPoKATB4DC1UrY
	GrUJSpW9J9BOnPN/zbX8FnaaiafqKpg1O9Tp0aV+wy4APH1D+UXHDhlBZ52GKsqKfwiMLAQbCs0CG
	0BPc+79tw6F/+QmZXb31w+SFrxInmjimQ6R+MoqUh0uY0zRP+1Xn5WPCJD07WunkVw9pAgHj9Uduk
	fdK/zZ3orwxxVYpa9SUeq65lecpL8jYIhh/qUioTpPkOCf0mifEdn6qp1r9tKCmuT8msaLqFVkjTY
	/qjH2kpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYnug-00000002tAC-0FgE;
	Mon, 07 Jul 2025 15:37:50 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYnrh-00000002sa2-1xCA
	for linux-nvme@lists.infradead.org;
	Mon, 07 Jul 2025 15:34:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751902483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0v2CaHY1VAi0HOiCc4Zf7ehSdSOjQyZPIEDJJM+6zG0=;
	b=WHJtULy+mHl+Ok0O7IHvNx1Upo5Kr0u57k/HY95rZ7gmi0GfVTTfFDTyKwDHrexdSPtAvs
	goHHtyCHu7uK+i4UFYWjTczWGMycY7FZTj0jA1vjrSn6Utd54N77jGpg0x+h+tLA19iOC/
	2TdLG7FdVlG6qQX3zouX65cX/OvI4+s=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-AGvAY3DMNaevRb-PSxnqpA-1; Mon, 07 Jul 2025 11:34:39 -0400
X-MC-Unique: AGvAY3DMNaevRb-PSxnqpA-1
X-Mimecast-MFC-AGG-ID: AGvAY3DMNaevRb-PSxnqpA_1751902478
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-32b4ef4055fso13021671fa.0
        for <linux-nvme@lists.infradead.org>; Mon, 07 Jul 2025 08:34:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751902478; x=1752507278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0v2CaHY1VAi0HOiCc4Zf7ehSdSOjQyZPIEDJJM+6zG0=;
        b=obzo8pJHt6RlPWsoWKyjnvd+EPYF2i6sfnpxHVUv1MN6Is7CD3j/Da8K2kAdffJs8s
         HauXjbxPWTVS/91p7EsoGdZekORIZ9fABj9qyiu5UtokxzZtPjd1plmP7dYI+DRoqcFO
         YBBaaXqp3ta0MFYI0LcK32I1OJ7rOcdjeC3RaogVF6PfXAk251HgwdAjdEvjfROd2oT8
         qSZhDPRpP5R3m/EZ5PusIja8pLzbMn/AElNFirFxbg1IGQC20TAhBUg7C6B0O5mXX/9h
         oRQQYzBgI/SDtINYZGhfdSqDHFg8jq9RyzWUIulgUrHZKPb9Z2JyBULNftQq07G+Qb9u
         L5BA==
X-Forwarded-Encrypted: i=1; AJvYcCW3WzYIhtpcHfvYLwRa5fe1kAtSfOkq7cUKyyScZB21wRshUlkjfejXUkvQRONCcmfVy4iRtAu6btif@lists.infradead.org
X-Gm-Message-State: AOJu0Yy62g2ZoSBNWtOpQfJBLUdJytRjmNlWoeA+LDxzQ1tGYIuIay4W
	6rlV8B2jqgHz1hHdD8M/76lCXKUzT9N28C6/TJO8BBN/nWi9mWstOBkm+r34zGvWqn37J2rKBra
	HUAcuedmtiIdqmUBoihdm3zOXuCtZO2G0VoW3Qf49zLbdaxqCeBh4dYhbMBt6FuSd1IGpty9v6B
	npssFUblSQPGGEuKTfYgdBCEiQAqxRGq0+83kovu+QJV0=
X-Gm-Gg: ASbGncsyThSTHeWHYV/Hgv8LTknnuKXVy6n9TStVNMGs0Xs9MiWNU3FVQQRN1Ri66kE
	bhBNlICJSSlyPTDcYj2oPe0PRUB4DM7cRgib7DkBosX+XZ+AAO1ItrAP9ywPanzpuB6tjhgN/w5
	r+XA==
X-Received: by 2002:a05:651c:511:b0:32a:7270:5c29 with SMTP id 38308e7fff4ca-32f00c8798cmr38754591fa.2.1751902478107;
        Mon, 07 Jul 2025 08:34:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKIHiywACdGBCTH/X8Ige8Yin2oQ8Gj/tg8va7lfqvYjW2jr4+erCyQPrXLSYqAtP0qHUjYrx+aoXHh15am7o=
X-Received: by 2002:a05:651c:511:b0:32a:7270:5c29 with SMTP id
 38308e7fff4ca-32f00c8798cmr38754371fa.2.1751902477586; Mon, 07 Jul 2025
 08:34:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250625201853.84062-1-stuart.w.hayes@gmail.com>
 <20250703114656.GE17686@lst.de> <aGaklKejxefXTQB4@jeremy-HP-Z840-Workstation>
 <CA+-xHTFC6KTs6D8EdvmVe=buqw9oN5P7GJ-WWvam6M3SzeZF4g@mail.gmail.com> <aGgAuje4tpIOveFc@sultan-box>
In-Reply-To: <aGgAuje4tpIOveFc@sultan-box>
From: David Jeffery <djeffery@redhat.com>
Date: Mon, 7 Jul 2025 11:34:25 -0400
X-Gm-Features: Ac12FXy7hQPGBK3xlwuh3LCyK0QkERATPwkzNINwGBKvhalA6yUfuGbVbXEvMNc
Message-ID: <CA+-xHTFNRwbxH=zNMM4kasB=kUAne0b6cxPM+sq5FyM32k8peg@mail.gmail.com>
Subject: Re: [PATCH v10 0/5] shut down devices asynchronously
To: Sultan Alsawaf <sultan@kerneltoast.com>
Cc: Jeremy Allison <jra@samba.org>, Christoph Hellwig <hch@lst.de>, Stuart Hayes <stuart.w.hayes@gmail.com>, 
	linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Martin Belanger <Martin.Belanger@dell.com>, 
	"Oliver O'Halloran" <oohall@gmail.com>, Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>, 
	Lukas Wunner <lukas@wunner.de>, Jeremy Allison <jallison@ciq.com>, Jens Axboe <axboe@fb.com>, 
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org, 
	Nathan Chancellor <nathan@kernel.org>, Jan Kiszka <jan.kiszka@seimens.com>, 
	Bert Karwatzki <spasswolf@web.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: V9oAtMjhyxg0Xkrm4RZ7_xkXLiEVIu_0bv_6U6tw57Q_1751902478
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250707_083445_578099_A3B729A4 
X-CRM114-Status: GOOD (  34.10  )
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

On Fri, Jul 4, 2025 at 12:26=E2=80=AFPM Sultan Alsawaf <sultan@kerneltoast.=
com> wrote:
>
> On Fri, Jul 04, 2025 at 09:45:44AM -0400, David Jeffery wrote:
> > On Thu, Jul 3, 2025 at 12:13=E2=80=AFPM Jeremy Allison <jra@samba.org> =
wrote:
> > >
> > > On Thu, Jul 03, 2025 at 01:46:56PM +0200, Christoph Hellwig wrote:
> > > >On Wed, Jun 25, 2025 at 03:18:48PM -0500, Stuart Hayes wrote:
> > > >> Address resource and timing issues when spawning a unique async th=
read
> > > >> for every device during shutdown:
> > > >>   * Make the asynchronous threads able to shut down multiple devic=
es,
> > > >>     instead of spawning a unique thread for every device.
> > > >>   * Modify core kernel async code with a custom wake function so i=
t
> > > >>     doesn't wake up threads waiting to synchronize every time the =
cookie
> > > >>     changes
> > > >
> > > >Given all these thread spawning issues, why can't we just go back
> > > >to the approach that kicks off shutdown asynchronously and then wait=
s
> > > >for it without spawning all these threads?
> > >
> > > It isn't just an nvme issue. Red Hat found the same issue
> > > with SCSI devices.
> > >
> > > My colleague Sultan Alsawaf posted a simpler fix for the
> > > earlier patch here:
> > >
> > > https://lists.infradead.org/pipermail/linux-nvme/2025-January/053666.=
html
> > >
> > > Maybe this could be explored.
> > >
> >
> > Unfortunately, this approach looks flawed. If I am reading it right,
> > it assumes async shutdown devices do not have dependencies on sync
> > shutdown devices.
>
> It does not make any such assumption. Dependency on a sync device is hand=
led
> through a combination of queue_device_async_shutdown() setting an async d=
evice's
> shutdown_after and the synchronous shutdown loop dispatching an "async" s=
hutdown
> for a sync device when it encounters a sync device that has a downstream =
async
> dependency.
>

Yes, but not what I think fails. This handles a sync parent having an
async child. It does not handle the reverse, a sync child having an
async parent.

For example, take a system with 1 pci nvme device. The nvme device
which is flagged for async shutdown can have sync shutdown children as
well as a sync shutdown parent. The patch linked pulls the async
device off the shutdown list into a separate async list, then starts
this lone async device with queue_device_async_shutdown from being on
the async list. The device then is passed to the async subsystem
running shutdown_one_device_async where it will immediately do
shutdown due to a zero value shutdown_after. The patch sets
shutdown_after for its parent, but there is nothing connecting and
ordering the async device to its sync children which will be shutdown
later from the original device_shutdown task.

> > Maintaining all the dependencies is the core problem and source of the
> > complexity of the async shutdown patches.
>
> I am acutely aware. Please take a closer look at my patch.
>

I have, and it still looks incomplete to me.

David Jeffery


