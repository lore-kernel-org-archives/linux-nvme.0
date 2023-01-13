Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E3E6C54EBD
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Jan 2023 12:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n0W2mIawT0ydAYmN/XMBiBeNi6lSFaH2N2Ub/HPnG+o=; b=13WtGmwi8DgEz3zfEfY/BZNmfe
	hOte9HTOKFZxuLW64sdbRhvoGiEEUKaD9ZVOBW0/L4RWAFYQPyjAMay+pQDgEc6o6L2SDx14Ev9ov
	vZ2SaUtx3d5hE//x47pZHM/EQ6SR8nN/BkKIkG05DATXS3KuzZ1aVuNoEirW9XJNtg1QcpUbu1dYB
	CKd2ThGRLyNDMIVXQBHyELPXS2X347fbXEYeiT2w0Ak5QTXqHvmeqSNINDJn1hszCKab0ktZquSto
	JptOOWXsmb/ZWQtVeO39zELbuw1Nyxq09DpBf+Qg+b8Nl0EOcM6lhx562hKM5yP6r6UlMoJkJ2ggv
	kv7wNI2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pGJOi-002arm-0e; Fri, 13 Jan 2023 12:43:04 +0000
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pGJOf-002aoA-I2
	for linux-nvme@lists.infradead.org; Fri, 13 Jan 2023 12:43:02 +0000
Received: by mail-pj1-x1031.google.com with SMTP id s13-20020a17090a6e4d00b0022900843652so5353012pjm.1
        for <linux-nvme@lists.infradead.org>; Fri, 13 Jan 2023 04:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n0W2mIawT0ydAYmN/XMBiBeNi6lSFaH2N2Ub/HPnG+o=;
        b=xhWfcZjDj2dY/m92e6ZOVrrWzdEFJues0yxiPtnuUTYuXOg6mZT20Q74E83NuSijPq
         w7l579nHKg54OBdOLBYTY5FrZdYZ22WF5EZ5W+taxikLrDvcaBMX7omwViPzLCjdSvqk
         UHSNr+VA4Dj0Pda9JpQhfXEO15WPvWp1L22WRY2ECRLNcq2Wop/d/dKNRj8S0OAta9XC
         jsKjaJp81vHIfXzMgQ6Dya6s25eM2lMKzwGK0V7xOPAyAy+lJwh+jWgj9oucziVwjLXp
         tlSQWPekic368WNl5y5JhTGNv2UlGzhIOM7Xw38hhAgIwfkWNdmqFkRGt46o+RCoOs6j
         bChg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n0W2mIawT0ydAYmN/XMBiBeNi6lSFaH2N2Ub/HPnG+o=;
        b=u2/o3KqYWQDFTUJrIXBt1QuHtZy13vNfd8L/R0E0p5q4URW5KypzNk2lmEV4nrK1Qr
         E+TviglPf7wtu+XKtaUoPoTU4FsF/B0MuF9dWxNJgciaF94A2mH85xXhKIzz2i8xoSqZ
         pCoqOqQGZUtVw27ssBFVR7lGX6Aal5rfhngLxJH8sbWgeZqU8/vxBJCm5SYr9w7mYtbz
         4ykNcr3Mpd8xynKVOECd8bvUH3TTfPxZbvaEN4XEgMmkDByQ8hbDSIGgN38xrO1iEm47
         WfFeQNuyX7P9nt7qpN7PwVtwuZEBV0nKgxX1j/94nLO8h2dCzSvTq5JKKWXNslUdCzU3
         OmOg==
X-Gm-Message-State: AFqh2kqF/QFvyZj0O55H3oTrUgx/JKR02zChP9fhqlE8TUK69WD79M7w
	1v1qCWZ/9R+DK5uDXLqwJxglxg5lU9Ha95hkGXBorNSkAl7j4g==
X-Google-Smtp-Source: AMrXdXusTyxu0htHyfjcei6wGaxy8mCHmGABGTKCNkU0eWrsHn4RmzQ89FXhw/X96KZfnedRpIaI6cY13JI/Anjov8Q=
X-Received: by 2002:a17:90a:77c7:b0:219:e2f1:81ad with SMTP id
 e7-20020a17090a77c700b00219e2f181admr6597272pjs.19.1673613773684; Fri, 13 Jan
 2023 04:42:53 -0800 (PST)
MIME-Version: 1.0
References: <Y8AG21o/9/3eUMIg@cormorant.local> <Y8EcOFE52X5KbzO7@cormorant.local>
 <CAFEAcA9y0E=EZwmetyvymvt64BpQxAnKMHs0E=BBH9_3OfMwFA@mail.gmail.com> <Y8FQnsxSwcTUYqYm@cormorant.local>
In-Reply-To: <Y8FQnsxSwcTUYqYm@cormorant.local>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Jan 2023 12:42:42 +0000
Message-ID: <CAFEAcA9H4bYfqmt2w_xSXS_uX9z-6NCRqdsn3tDz6h-v39cGKw@mail.gmail.com>
Subject: Re: completion timeouts with pin-based interrupts in QEMU hw/nvme
To: Klaus Jensen <its@irrelevant.dk>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org, qemu-block@nongnu.org, 
	qemu-devel@nongnu.org, Guenter Roeck <linux@roeck-us.net>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230113_044301_617683_BEEADA9B 
X-CRM114-Status: UNSURE (   7.82  )
X-CRM114-Notice: Please train this message.
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

On Fri, 13 Jan 2023 at 12:37, Klaus Jensen <its@irrelevant.dk> wrote:
> There are a fair amount of uses of pci_irq_pulse() still left in the
> tree.

Are there? I feel like I'm missing something here:
$ git grep pci_irq_pulse
include/hw/pci/pci.h:static inline void pci_irq_pulse(PCIDevice *pci_dev)
$

...looks at first sight like an unused function we could delete.

thanks
-- PMM

