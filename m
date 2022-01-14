Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F9E2C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Jan 2022 02:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x8E4rD8Rz/JKte0ZApLAtI01ZkoCv/YtSv05wruJE3I=; b=aFNllIgPTej54Zzv1NbAf/C7ZQ
	+bVvcyahy8sWPbWez+JZtfd5q9aRKuDlIKwVUP/y8sXydMO73bPwhrWSqeAML6l20jfZpKU/rhVJu
	LxVYcY7X+F3n8YdmNQp5GZ5Vm0I5vbuC3LlfGk59ZiT+4ixXvpVW9J5rtdfYditaPspW+enoLRGw9
	SQBP7tGaGJgbtOrdGlIsOwl4rbzVUXTushTHJlEOMRvf+bahkFz4eohUhl6OFhBape16a98P2KuwY
	mI/SQuWBURyf2V7NO2Z+DE1bwNQdaP0sUMksvisU/qMQFulGactuDSf2EDSG83adhXehH0bcGZF9V
	P984Q0bg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1n8CUF-007Vnj-Tn; Fri, 14 Jan 2022 02:38:43 +0000
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n8CU9-007VnI-CF
 for linux-nvme@lists.infradead.org; Fri, 14 Jan 2022 02:38:38 +0000
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 44AEF3F1A4
 for <linux-nvme@lists.infradead.org>; Fri, 14 Jan 2022 02:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1642127910;
 bh=x8E4rD8Rz/JKte0ZApLAtI01ZkoCv/YtSv05wruJE3I=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=SoPK+5wXGs1NBac9+bzNQzI8R8LJ0HgbOTRxCnvQ2h81s9TpLp6UsrxGh9jHXJUk9
 ilmGR5FZDAgPPeO3hIX0C53Or2ZTsecKdicsnUkf00L/2JTfBwvIB/CQZr1tktXvPE
 EwaYkwLOXRoLEJGw1AyrlIj3QdeTv11hFeOngUI0fe+yjxYe6SxoR7lh9gSmD33NeM
 vbYPIV9RSfk9srxql7uNUvgoGyd78vXPyhc0fQC32BYPEcKytfsyGdRt3PyG/A/lBv
 55zh+qLiHzKJc2JZrxyYMoQ2aaRQrqvBj8qC1k4FE8ZMi0V7as3wE8+8GqXMQQrYsN
 6/iNuy+EuGeDw==
Received: by mail-oo1-f72.google.com with SMTP id
 t12-20020a4aa3cc000000b002e087a8da2eso355802ool.8
 for <linux-nvme@lists.infradead.org>; Thu, 13 Jan 2022 18:38:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=x8E4rD8Rz/JKte0ZApLAtI01ZkoCv/YtSv05wruJE3I=;
 b=PshAAM2ZDZlUNBlLA6ZPjbScB2F4ab40il4uYulLp+9luJ7gYIdvf3AIN4h1uDTPQ4
 qvUoKozFznfuqIPwt0XekwV9d/lyK0BQq/AdS8ntbz2udDkWfEgpXao3L0C3JCfbovka
 PBjp2ai0dh53zora4NrbblNEYZ9PjKMsOTP9zn3kyFMR5pEDqELnLCIPgnZfCPjdBlVe
 4eJniYGisZyMZd0Ud2uw0kIhNNjjv1iSRBhaas2+eMwv17vP1OKTgZOZFzzRrrW5+Wfv
 4q9BskNGD+D2Z0pcIwxOqnD6qz1cYvW3vgOnSvnSV8rhT2JD3Up+x07VmyKrIMXy61G/
 IZlg==
X-Gm-Message-State: AOAM532XVhOVHk+GkJzTeROMtj59+D+BpENl8JJ3xhru/hchxfqLNlKV
 cwn2mv63LHxVT8eP9LLAHR5/B8CYnk/tPsJ96jVlP+nDSNuWpowSkR5ieCktSKu82UQNtrdpII4
 s+Oj7M9OSNb4O26OZOpFcwouj9yAG9geKpqqetFbsq9P3Wu4GjSKllKPjLySx
X-Received: by 2002:a9d:7e84:: with SMTP id m4mr1875162otp.269.1642127909149; 
 Thu, 13 Jan 2022 18:38:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzvqAmlOvlR76bRJnqo/vJfDqUjOyrMMWBDWMbgWdZMnxcPeeLGWg2dW7qFpTsYBIpbombT5vHF7LsHoStuXYg=
X-Received: by 2002:a9d:7e84:: with SMTP id m4mr1875147otp.269.1642127908879; 
 Thu, 13 Jan 2022 18:38:28 -0800 (PST)
MIME-Version: 1.0
References: <20220112013154.1210480-1-kai.heng.feng@canonical.com>
 <20220112071659.GA4502@lst.de>
 <CAAd53p4+WjhPM6VKZOZKQ4WcgNWjR7Eh_7Kjs1HZ_wiKov6Ctw@mail.gmail.com>
 <20220112140304.GA27446@lst.de>
 <CAAd53p5Qo3+-sXMLLPxe3ckY4ySxRvaLZkv=0zgKc=EVun9uYg@mail.gmail.com>
 <20220113161204.GA3230285@dhcp-10-100-145-180.wdc.com>
In-Reply-To: <20220113161204.GA3230285@dhcp-10-100-145-180.wdc.com>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Fri, 14 Jan 2022 10:38:16 +0800
Message-ID: <CAAd53p6X5otqff+LCe94qoG+QiqEofNmGM1p4q-fGfTU186gMg@mail.gmail.com>
Subject: Re: [PATCH] nvme: Mark external NVMe devices as removable
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, axboe@fb.com, sagi@grimberg.me, 
 Rajat Jain <rajatja@google.com>, linux-nvme@lists.infradead.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220113_183837_575170_35CE7D79 
X-CRM114-Status: GOOD (  16.21  )
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

On Fri, Jan 14, 2022 at 12:12 AM Keith Busch <kbusch@kernel.org> wrote:
>
> On Thu, Jan 13, 2022 at 02:39:02PM +0800, Kai-Heng Feng wrote:
> > On Wed, Jan 12, 2022 at 10:03 PM Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > On Wed, Jan 12, 2022 at 08:50:33PM +0800, Kai-Heng Feng wrote:
> > > > USB thumb drives also use this flag, so I am not sure why it's not
> > > > applicable to NVMe?
> > >
> > > They shouldn't report this flag and might need fixing.
> >
> > So what should we do? Introduce a different flag but with identical
> > usage for external USB and NVMe storages?
>
> What's the user visible result with this flag set? Does some rule
> automatically mount a 'removable' block device's filesystem partitions
> to something like /media/?

Udisks uses 'removable' to flag its 'HintAuto' attribute, and GNOME
Shell will automount the disk based on 'HintAuto'.

Kai-Heng

