Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C54EC4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Dec 2022 19:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YL1+jd+bqxEYuNhsfkKoW4Bib0tbO/GWG1d3h67uOqo=; b=FByTcM8wBjy9VkZ1ViliXjsF/1
	kIyYf25lpssqv+D7YZtoPakpQY9AebGElfglfb+MMHybCfZm1i17p3zgsGj3eQpOKIkETofjwckfF
	DDelEGXvjaP02uu0rjx1CBH+/uFkuqin77ZjLFvnhmXEd4EnZ4Fc1eJ0LLYoL7GOh64QI+J5wDOdO
	079PweW700xAQS7rG1YUmLYSunrdTcjWMYjePPyOO+/02fc68RU1aeziRiV+aycx6nLPmlFC7X8u2
	Sfejo7CdQZYZ2g+qYbXOoVUa1hQHRjz9naIMVubm7YL7hnGpzCIPXtb9+qGiv8xTCZ+puEXbe9dI4
	BZivxn2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pAyHV-0016Te-JW; Thu, 29 Dec 2022 19:09:33 +0000
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pAxoN-000rmt-AR
	for linux-nvme@lists.infradead.org; Thu, 29 Dec 2022 18:39:28 +0000
Received: by mail-oi1-x236.google.com with SMTP id s187so17750080oie.10
        for <linux-nvme@lists.infradead.org>; Thu, 29 Dec 2022 10:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YL1+jd+bqxEYuNhsfkKoW4Bib0tbO/GWG1d3h67uOqo=;
        b=RqetY5wq3Isg0XpDwrtgF58pMUZ91i3hZQu1kIW/923plJ95a91r8xq2bp9eQz8ztu
         LXaqbR48IrAunbPdY/ItJ2X63rtW1mptuS+uc18XNwHqA10P7wWlBvac79bXmFvgvmst
         D38bUiT123LS6MRFw5oPXHNBsIL7QVoxH2LR+WRb9BjM4NwWaCDAzAO3EU2vC5/BRLoI
         x2v21MSTjSu7REXira0bwgbrODiznCOTX/M08qfqq39q1WOmKEUHZrS34aw3Q0jV7asU
         fEa9/VDLt6g23id++bl7x/yA2FaN+4WAiCiKzfStkoUVGsh5kC+oXUxd8hGPauFxFl7q
         QqMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YL1+jd+bqxEYuNhsfkKoW4Bib0tbO/GWG1d3h67uOqo=;
        b=Z6nKtcXWJWXD/0e+ACyZRRMyLqhmtbz9qO2ZXtfkZ6r9wn6FF8FLqoYikaaFIeEsyR
         Fi76/3ekzTx+JmuN7mxcSn4kqhqQr0mOvQkHwJmv3tnXApPXLfJOM39Suxo0Vo752A5l
         JRu5xNy0U6uQq3tlpitcTbe+/d2DEeuUSFigh2ndmispRhUDJIsXRrVb8u77hLx1BgZg
         um/QRyT3BTR55SGrMG/jOFBXdkrQOwm1HyrZ3/pdA9SvMPTQC6SS1eD9jz7Grsj28EbG
         Idluos87wqNoKaxZ7ahAzh6KYPvQFR8WnyywieD8OA21k2ylexK7iOTzQLOBi5hTMDdk
         mZeA==
X-Gm-Message-State: AFqh2kr+TwGqGu5XoRj/nuECVqDhOy0uMFxU3KYmLLFqDX9VgkJOjjVQ
	5WIQSuDaSRYTEDnqg2vQLdIpTu9EzbJFi1Nfk6A=
X-Google-Smtp-Source: AMrXdXsENIQJahUj9UFgrkh5/8IScjIPoncvjIGWSO7C76fOzgfaDskmNsrRotPE1nZcskTQO1LK7Ir95OCeh9xUqSk=
X-Received: by 2002:a05:6808:7ce:b0:35e:250d:abc1 with SMTP id
 f14-20020a05680807ce00b0035e250dabc1mr1194682oij.222.1672339165839; Thu, 29
 Dec 2022 10:39:25 -0800 (PST)
MIME-Version: 1.0
References: <20221229060549.3976570-1-ztong0001@gmail.com> <Y63WsX8Hvxep/dtN@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <Y63WsX8Hvxep/dtN@kbusch-mbp.dhcp.thefacebook.com>
From: Tong Zhang <ztong0001@gmail.com>
Date: Thu, 29 Dec 2022 10:39:15 -0800
Message-ID: <CAA5qM4Djc+5p45+isj5Vn47erUR6rY32n-2Epkkx1Pv-PX8wRg@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: free irq properly when cannot create adminq
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, t.zhang2@samsung.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221229_103927_469675_A708510B 
X-CRM114-Status: GOOD (  19.87  )
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

On Thu, Dec 29, 2022 at 10:04 AM Keith Busch <kbusch@kernel.org> wrote:
>
> On Wed, Dec 28, 2022 at 10:05:49PM -0800, Tong Zhang wrote:
> > nvme_pci_configure_admin_queue could return -ENODEV, in this case, we
> > will need to free IRQ properly. Otherwise following warning could be
> > triggered
> >
> > [    5.286752] WARNING: CPU: 0 PID: 33 at kernel/irq/irqdomain.c:253 irq_domain_remove+0x12d/0x140
> > [    5.290547] Call Trace:
> > [    5.290626]  <TASK>
> > [    5.290695]  msi_remove_device_irq_domain+0xc9/0xf0
> > [    5.290843]  msi_device_data_release+0x15/0x80
> > [    5.290978]  release_nodes+0x58/0x90
> > [    5.293788] WARNING: CPU: 0 PID: 33 at kernel/irq/msi.c:276 msi_device_data_release+0x76/0x80
> > [    5.297573] Call Trace:
> > [    5.297651]  <TASK>
> > [    5.297719]  release_nodes+0x58/0x90
> > [    5.297831]  devres_release_all+0xef/0x140
> > [    5.298339]  device_unbind_cleanup+0x11/0xc0
> > [    5.298479]  really_probe+0x296/0x320
> >
> > Fixes: a6ee7f19ebfd ("nvme-pci: call nvme_pci_configure_admin_queue from nvme_pci_enable")
>
> Right. It's really only needed when called from probe as the reset_work
> handles the cleanup when called from there, but this is safe for both
> cases.
>
> > @@ -2584,8 +2584,13 @@ static int nvme_pci_enable(struct nvme_dev *dev)
> >       pci_enable_pcie_error_reporting(pdev);
> >       pci_save_state(pdev);
> >
> > -     return nvme_pci_configure_admin_queue(dev);
> > +     result = nvme_pci_configure_admin_queue(dev);
> > +     if (result)
> > +             goto free_irq;
> > +     return result;
>
> Since you're already in this function, you should also add a "goto
> disable" if pci_alloc_irq_vectors() fails. Right now it just returns
> with the pci device still enabled, and it won't get disabled from probe.
>

Thank you Keith! I have added this fix and sent a v2.
- Tong

> > + free_irq:
> > +     pci_free_irq_vectors(pdev);
> >   disable:
> >       pci_disable_device(pdev);
> >       return result;
> > --

