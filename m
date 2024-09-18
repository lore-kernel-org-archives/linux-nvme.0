Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDED4CDD556
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Sep 2024 21:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Date:Cc:To:From:Subject:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wBM1ofSGNndQ096F+gd6jV81rsbzNDDn5M19SAETclk=; b=4PIoHyThS9Y1jV6q6tRePBQAsr
	XXom4u0C1DI6fX3eeuFrnnRUW7CDT+N7RXd9XgeEXNjtRflCBWENPi8fX0XMZFEczfpqsAjACbOXE
	FUnjfvenxDDT+RnKCp99zSXyw4uYKesIZMFRd7Wb4os5TXygWXiP89TgrIfywFyx9NY0hUzAcPGF4
	yI/VAtQWBYbuo7POjwNOFndUm8IofrUiKS8SY9AdokMCSmj4/0usqfQcQsCvnAqGsnQOR5lzWMUwc
	RQK+hCSWqa+w8tE158hJlKWpwmQeh47cg2/r5rcZPCs+Gj9ebjdcfeWxeuWJaObyUfk3gaVLTZAs+
	fgEINchQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sr1uD-00000008zpJ-3YSY;
	Wed, 18 Sep 2024 21:08:09 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sr1uA-00000008zoc-472j
	for linux-nvme@lists.infradead.org;
	Wed, 18 Sep 2024 21:08:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726693684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wBM1ofSGNndQ096F+gd6jV81rsbzNDDn5M19SAETclk=;
	b=UiHp7lZGbS7fpziVOHLL5zV9N0NqFsf3bff65229knDwA3Rz6xPF1YG5sEtBbGKpClIlkJ
	iBHDezbdffHeTT/X8GwAq8F3OEP6FTcGq0uQqg5hXD/A73ggQoW89CaBxfksrTXm/w4fBW
	+BeYcdJ0R4HH4WadFfuV3C7M0AMUXp4=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-_g292xMdNNmboO4RsDmPcA-1; Wed, 18 Sep 2024 17:08:03 -0400
X-MC-Unique: _g292xMdNNmboO4RsDmPcA-1
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82aa4678394so43246539f.3
        for <linux-nvme@lists.infradead.org>; Wed, 18 Sep 2024 14:08:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726693682; x=1727298482;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wBM1ofSGNndQ096F+gd6jV81rsbzNDDn5M19SAETclk=;
        b=kdNH6JFgNiH3kKX0/bGECXkuD32nZvAxo9VSXk6lvLwt6VLVs7fzjuYHfE3bpQMBcZ
         ezyICgHMBUV0iq5GINzWUfqHbT9h5XIsvaovpCg5fQOd9fumhSvZ7ABiki8KGZF9tTyB
         O1wY+MTY34zSMWMF2CigcGYrw6jQILAKKgmRwcpUFvWEXOR1a6mLgYoNGciL+TylMolh
         EWIuKlj9+PqUATcSHq6xS22g42UGKw2ZUkR242Hd4IJAqVjxkp2FgZtNIx1E+bfdFmD2
         EvS9bNQIqzjWNou+QrNFk+jyaS9LlHL6EybuuHHR3kFIASe3JPE9dcEa4bWASWKcT00b
         w8eg==
X-Forwarded-Encrypted: i=1; AJvYcCVSJ8CfDak+v7VZsdmS0+3dzVIquwA0U4cg3Rf8NgyW8m3UnXlldg3XTdBc3WxEf+ioFTuSmE3Pp3iZ@lists.infradead.org
X-Gm-Message-State: AOJu0YztD1cAlXg3WrMSavzdcYNRxkzMbvC0Fzj+ScQo9bcVXLZObTAW
	K/0kvd2qitGS5MAh3EUL2ofqlWS+mme+BIKyAxxO0QCp3mpG6Y1tcQo5d3Lk64p2XvdC8dz5I0E
	Gx3Qm+rRI9PejWg13WdWF9BG7skmkIj7WWkntX0xywHM/ReMTz1EKSkvXRSArKITs
X-Received: by 2002:a05:6602:6413:b0:82a:1f14:997f with SMTP id ca18e2360f4ac-82d1f8bbde6mr2516109639f.4.1726693682476;
        Wed, 18 Sep 2024 14:08:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkUVfTAp5Wr13Jqwkm/X1NBX5DOzVnNokAqP7pwBgUyqOhY9E7PXC6BFmhUymoXthcPBuzwg==
X-Received: by 2002:a05:6602:6413:b0:82a:1f14:997f with SMTP id ca18e2360f4ac-82d1f8bbde6mr2516106839f.4.1726693682141;
        Wed, 18 Sep 2024 14:08:02 -0700 (PDT)
Received: from ?IPv6:2600:6c64:4e7f:603b:2613:173:a68a:fce8? ([2600:6c64:4e7f:603b:2613:173:a68a:fce8])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-82d4926954asm281046539f.9.2024.09.18.14.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 14:07:59 -0700 (PDT)
Message-ID: <1b5cc9421cfd8dced181335b426646aef2f7309a.camel@redhat.com>
Subject: Re: [PATCH] driver core: fix async device shutdown hang
From: Laurence Oberman <loberman@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stuart hayes
	 <stuart.w.hayes@gmail.com>
Cc: linux-kernel@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>, 
 Martin Belanger <Martin.Belanger@dell.com>, Oliver O'Halloran
 <oohall@gmail.com>, Daniel Wagner <dwagner@suse.de>,  Keith Busch
 <kbusch@kernel.org>, Lukas Wunner <lukas@wunner.de>, David Jeffery
 <djeffery@redhat.com>,  Jeremy Allison <jallison@ciq.com>, Jens Axboe
 <axboe@fb.com>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
 <sagi@grimberg.me>, linux-nvme@lists.infradead.org, Nathan Chancellor
 <nathan@kernel.org>, Jan Kiszka <jan.kiszka@seimens.com>
Date: Wed, 18 Sep 2024 17:07:57 -0400
In-Reply-To: <2024091838-keenly-scrabble-8cce@gregkh>
References: <20240917201517.1145331-1-stuart.w.hayes@gmail.com>
	 <2024091753-estate-legroom-5d62@gregkh>
	 <751d4ba8-1e35-47a5-9a94-9873ff2619ae@gmail.com>
	 <2024091838-keenly-scrabble-8cce@gregkh>
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240918_140807_253526_8CB0E61E 
X-CRM114-Status: GOOD (  30.12  )
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

On Wed, 2024-09-18 at 08:12 +0200, Greg Kroah-Hartman wrote:
> On Tue, Sep 17, 2024 at 07:20:41PM -0500, stuart hayes wrote:
> >=20
> >=20
> > On 9/17/2024 3:42 PM, Greg Kroah-Hartman wrote:
> > > On Tue, Sep 17, 2024 at 03:15:17PM -0500, Stuart Hayes wrote:
> > > > Modify device_shutdown() so that supplier devices do not wait
> > > > for
> > > > consumer devices to be shut down first when the devlink is sync
> > > > state
> > > > only, since the consumer is not dependent on the supplier in
> > > > this case.
> > > >=20
> > > > Without this change, a circular dependency could hang the
> > > > system.
> > > >=20
> > > > Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> > >=20
> > > What commit id does this fix?=C2=A0 Should it go to stable?
> > >=20
> > > And what driver is causing this problem, is this a regression or
> > > for
> > > something new that just got added to the tree?
> > >=20
> > > thanks,
> > >=20
> > > greg k-h
> >=20
> > This fixes commit 8064952c65045f05ee2671fe437770e50c151776, in
> > driver-core-next & linux-next... it's problem with code that was
> > just
> > added to the tree (in drivers/base/core.c).=C2=A0 It is not in stable.
>=20
> Ah, that wasn't obvious, sorry.
>=20
> > Apologies, I should have mentioned that from the start.
>=20
> Can you resend this with a "Fixes:" tag in it so I can just take it
> that
> way and not have to edit it by hand?
>=20
> thanks,
>=20
> greg k-h
>=20

FYI=C2=A0
This patch plus the rest of the original Bundle has been tested=20
at Red Hat on a system with 24 nvme devices.=20
Improvement was almost 8 times faster to shutdown.

Tested-by: Laurence Oberman <loberman@redhat.com>


