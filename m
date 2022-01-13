Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8B92C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Jan 2022 06:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z/d7ON8aStCCPS5HD+SrrIVpBpxi2CdKa+GaDG4iK0o=; b=V+ejPc3bc4mpXRNLlbYlOxa/Ss
	OqZEGQbEertC953gB1ki7O2hDvlC31hTxwvvUHxcz2m4SK/dgLS9WyWy4nMaoSROZ/rALGOKZyV3Q
	vHoALMCWkxWl/tXojtxMA6xPIAxrCZ34kiYKcKbDej9R2eTLauml2zpCPXYvw13Kjyj5KTC57bTrj
	MNX8UPDOc3eLL89KH/9MvhUDpWcr3Eh3y47Psy1JhjXTuUopxu37KEYbyBzTW5AKg29R92hof2gqJ
	gofO/g8eLhV8Yuk+3D88Kl1WZ3L7OVRQl6HL55v9UPmQFPjmv8TMKxAhSL1o8+hjoKHG/zrjzzd3/
	/KZtFvAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1n7tld-004pig-Uq; Thu, 13 Jan 2022 06:39:25 +0000
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n7tlb-004phw-Oz
 for linux-nvme@lists.infradead.org; Thu, 13 Jan 2022 06:39:25 +0000
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id CECE13F1A4
 for <linux-nvme@lists.infradead.org>; Thu, 13 Jan 2022 06:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1642055954;
 bh=Z/d7ON8aStCCPS5HD+SrrIVpBpxi2CdKa+GaDG4iK0o=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=Unf3GggJb9/z+ZWX4zMCO3vyZ88JE0j7Tj1rgYF7XhjtSx/SgoAYre4OGmrUHr4JF
 09L7VgSs1lxZV3sFTrL46b2PlqAxzn8pYUOuYr851gZKFB7Y1LtoF1b8LogpTOLZtH
 EZoV+ROAb+mogLwMnTnNyd9jnqhcc9KN24XXIQuegrJLT4he5xbsrUb4vYvbTeHbcL
 iJvWa6osQwYBKYR8bW97+D1YNoj6WNXNeYWaIqhnEAqs7+x1LBDNchZv7olsx02rnr
 yULzQZeyw19N7DDpdko9/GqgoQ98pQEDeIukiTQi7tqhz8mzlkvRQxBphZkOoebToS
 gsZRB19xujorw==
Received: by mail-oo1-f70.google.com with SMTP id
 v30-20020a4a9761000000b002daad3afaf6so3407112ooi.18
 for <linux-nvme@lists.infradead.org>; Wed, 12 Jan 2022 22:39:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Z/d7ON8aStCCPS5HD+SrrIVpBpxi2CdKa+GaDG4iK0o=;
 b=AjuBEq8V9+vMrjh5hfveUD/GoAyplQjCkN+Q2re17mXc3iYkDLHpnTaF6uTvQpnV39
 /0mCHJaIu9C00diRcaEVMs2jAoM2IFHw0Xan9XMwE8a8qTcCntRrB4S56YNKiBw5FuUR
 JTJMm1+OrUyRzAZkxdHTjcwf/eRnoo7LT+J/JCxkHJZMU7AjMDdQr8piStMFv4UVEEAs
 FpkGpRBugXvDQ1HydceAvE3mt3vf8NwFb25DKM6rX+ebMMSX75nsz4BSe4M4wiEU7Yrt
 IKV+mqVUKdASt4FsrgNtWPj/m9JmY42DKartx9VQV/dEs8w2KfXHv8whmPQsAqajYeRW
 5Big==
X-Gm-Message-State: AOAM5307cD3YgfOM3heRxL/GPnF6vnwIciURPxVYJkLJIFqqzkWdpvu6
 GinvCnFvTRub2sWcqXRRaqTukbqhSAp+AJwLDzwhel3BngwcKCQGy8/8nTkt4wIk8uSCMbD9Qkc
 UemHsCvvjwhk+FR4XIjnlGAOV8EmPoiLWBJxap+FHZDYsKjklNawD3SdAdkZM
X-Received: by 2002:a4a:ba90:: with SMTP id d16mr2034224oop.80.1642055953617; 
 Wed, 12 Jan 2022 22:39:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzEMpazgYUKs+xSD8KDd1iXrFDQ8M0eRXsEmPqcnb56gtzNC3Fy7zUJntyN9v+/auUMk2mULVsKUj/6+1novVI=
X-Received: by 2002:a4a:ba90:: with SMTP id d16mr2034216oop.80.1642055953371; 
 Wed, 12 Jan 2022 22:39:13 -0800 (PST)
MIME-Version: 1.0
References: <20220112013154.1210480-1-kai.heng.feng@canonical.com>
 <20220112071659.GA4502@lst.de>
 <CAAd53p4+WjhPM6VKZOZKQ4WcgNWjR7Eh_7Kjs1HZ_wiKov6Ctw@mail.gmail.com>
 <20220112140304.GA27446@lst.de>
In-Reply-To: <20220112140304.GA27446@lst.de>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Thu, 13 Jan 2022 14:39:02 +0800
Message-ID: <CAAd53p5Qo3+-sXMLLPxe3ckY4ySxRvaLZkv=0zgKc=EVun9uYg@mail.gmail.com>
Subject: Re: [PATCH] nvme: Mark external NVMe devices as removable
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, axboe@fb.com, sagi@grimberg.me, 
 Rajat Jain <rajatja@google.com>, linux-nvme@lists.infradead.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220112_223923_992053_61D29682 
X-CRM114-Status: GOOD (  10.79  )
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

On Wed, Jan 12, 2022 at 10:03 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Jan 12, 2022 at 08:50:33PM +0800, Kai-Heng Feng wrote:
> > USB thumb drives also use this flag, so I am not sure why it's not
> > applicable to NVMe?
>
> They shouldn't report this flag and might need fixing.

So what should we do? Introduce a different flag but with identical
usage for external USB and NVMe storages?

Kai-Heng

