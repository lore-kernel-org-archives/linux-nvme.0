Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9DF1C48260
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Feb 2024 18:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RwCUayfqln7dshRI+MqLDWSQL37KIcAvil/7zH0u+ps=; b=QVrDI3t272yGV0ohrvexsVItaX
	6+VCGkJB5Zj7p+3RqVHLDXej5dVNyH5Y4wI3A1fN8W5abOk7DcsdC3oBsgYxDrXHYWul6pqQ6TQUY
	PidKxsgmXXzOCTBU2pySCl17mjTsn8w7klgecucab6EkcVtOF8QoOLKh56Oi5sXsUl8eQrVNSZvMT
	KLsAn0gwq/PcUdhnZdfTDoW/OqcAF327T9MOFK8eTCQzCk96PUGI4WPjupR8yzM+kE/AdFrx+Dw6i
	7G2mzLY+q5jOOwa4nf9sCgdTi3qExhC7gM2XlB42SxvzfiM14UYZTveYu2r1d/OdlnsPCl/O1+uTN
	3gkKUW8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rY8jh-0000000EZ2G-2rL4;
	Thu, 08 Feb 2024 18:02:57 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rY8je-0000000EZ1a-3C8F
	for linux-nvme@lists.infradead.org;
	Thu, 08 Feb 2024 18:02:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707415373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RwCUayfqln7dshRI+MqLDWSQL37KIcAvil/7zH0u+ps=;
	b=T/NoPXzX40KDjNaLJKp5aGdJvS/ZilranaIjTWBMxRgZyGaT9c6y2H+K6/IYZFJ9zxmgJR
	54E3/azLWN6hlHCdDGe8nDESWJYb2yN0RIy5+figI9L3dSGHj0jyfIr7ob4YYOiLBHRb5Z
	3M/QGFngfPaW1Vw+4D9Jb/7KRy6c0wo=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-Rl9atz3ONWGOiIbahLk1rw-1; Thu, 08 Feb 2024 13:02:51 -0500
X-MC-Unique: Rl9atz3ONWGOiIbahLk1rw-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2d0908edbd0so1059121fa.2
        for <linux-nvme@lists.infradead.org>; Thu, 08 Feb 2024 10:02:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707415369; x=1708020169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RwCUayfqln7dshRI+MqLDWSQL37KIcAvil/7zH0u+ps=;
        b=h/NxpOOrBuQhK7dfZvAxMGmaeQb6a9gzp1VDk7XGvW6KsFJxRjeAKyywV2syfxYec3
         O4WpJopDQ2uwYF3nYaZa/wrGKLjXZqjR4eytKMjNinVm/QwfBGlX+fOLmcVt4iYymfqd
         ODbLjPPuVNsLNjWY2DfuGOEOb2wCfyZFdcogBnAlXS0DWMoaiMDuv9yIfGKrjccVadSx
         CX1ofxj47hgHhe6FmT/icFYHcnBEZHO7HKwvG1vPe8hLnZrxMToRsvMrqCanXt9Kvyhg
         jzUglj0DKmad3bEo+n30runBG0KHs/So6XOR5U+Y264YuvpF76YmtJSCXqmghFaevtbo
         67cg==
X-Forwarded-Encrypted: i=1; AJvYcCXoAnAhdefm9xOtilncsKqWkt7N3xQrYOFUG5oWCdMHbMNuEEsXafvV8ggCSO6n1l3U9NdH/oPMaXpApIOW3ATWfp1tTwAvB5F0jsrcKVs=
X-Gm-Message-State: AOJu0Ywcg0AqwBqsTyCZDf8xQi5OAdOsGdxqoRYLoEAuOGbTlY+3NtJr
	SLdrTzEPf82zZ+zopTWYZwXlalg4dm4eC573qfL7nO1LF8EZDQqYWjxzj1IxJvbZKU84yud/3I0
	LQGZWHph/nc1u6Lv/eKLPN9Io9C+lw4yYdiURoyMsdZ8981LBYBjgKqNvUitirR2vIuWKzXg4K2
	ydEYbl7D7Nx4uBsVIvwzA1cl0+z0n+o/JBfr5URrE=
X-Received: by 2002:a2e:be26:0:b0:2d0:9b68:d063 with SMTP id z38-20020a2ebe26000000b002d09b68d063mr73319ljq.31.1707415369735;
        Thu, 08 Feb 2024 10:02:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEbvoQ7BTTBlAV2OQ9wejxmKPGWfUsQ+R58hIzMIgM3dSdiUcqH40XvJOENi8WEzC+0gVB9ZFmovCi6afQm/wk=
X-Received: by 2002:a2e:be26:0:b0:2d0:9b68:d063 with SMTP id
 z38-20020a2ebe26000000b002d09b68d063mr73297ljq.31.1707415369390; Thu, 08 Feb
 2024 10:02:49 -0800 (PST)
MIME-Version: 1.0
References: <20240207214044.2374295-1-jallison@ciq.com> <20240207220048.GA919889@bhelgaas>
 <ZcP+I1iflY77Sh3W@jeremy-HP-Z840-Workstation>
In-Reply-To: <ZcP+I1iflY77Sh3W@jeremy-HP-Z840-Workstation>
From: David Jeffery <djeffery@redhat.com>
Date: Thu, 8 Feb 2024 13:02:37 -0500
Message-ID: <CA+-xHTGZrQhNULHh4aHG=70Led=RL1amZcRcFtmTWZtjKCtvpA@mail.gmail.com>
Subject: Re: Make NVME shutdown two-pass - Version 6
To: Jeremy Allison <jra@samba.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Jeremy Allison <jallison@ciq.com>, tansuresh@google.com, 
	hch@lst.de, gregkh@linuxfoundation.org, rafael@kernel.org, 
	bhelgaas@google.com, sagi@grimberg.me, linux-nvme@lists.infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240208_100254_895537_E56AF9F4 
X-CRM114-Status: GOOD (  16.58  )
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

On Wed, Feb 7, 2024 at 5:03=E2=80=AFPM Jeremy Allison <jra@samba.org> wrote=
:
>
> On Wed, Feb 07, 2024 at 04:00:48PM -0600, Bjorn Helgaas wrote:
> >On Wed, Feb 07, 2024 at 01:40:39PM -0800, Jeremy Allison wrote:
> >> This is version 6 of a patchset originally written by
> >> Tanjore Suresh <tansuresh@google.com> to make shutdown
> >> of nvme devices two-pass.
...
> >>
> >> NB. An alternate patchset from David Jeffery <djeffery@redhat.com>
> >> has been proposed that covers much of the same ground.
> >
> >Would be useful to have a link to David's patchset for comparison.
>
> Sorry, here it is:
>
> https://lore.kernel.org/linux-nvme/20240207184100.18066-1-djeffery@redhat=
.com/
>

Hi Jeremy,

I'm fine with merging our efforts. From reviewing your patch set, the
main problem I have is with the core patch compared to my initial 2
patches. Yours runs shutdown_wait calls after shutdown for all
devices. This design won't work for example with the scsi system sd
async shutdown. Scsi HBA shutdown calls may stop the HBA or firmware,
leaving the async flush for sd in an unknowable state as to if the
command succeeded or even made it to storage. My patches by ensuring
all shutdown for child devices is finished before a parent device's
shutdown may be called allows the ordering to work.

I'm not attached to a particular async API. If nvme and core devs are
fine with the shutdown_wait api, I can alter my core shutdown and
scsi/sd patches to match.

David Jeffery


