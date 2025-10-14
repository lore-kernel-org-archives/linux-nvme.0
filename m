Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 837E0CCD185
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Oct 2025 00:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0qomT1ZkVPDmIuCEoNEUDG95EzuPyhJMmV7fO0hnOBs=; b=wh8oqrqbKIKV52gsQ0xnTnhG11
	vGCmtnilwispjm1keirp+kIiDovmI4kZg+JbWiHPMl4EL7vWwd5ZsJCu228hUxvvysmCY71Hql/28
	OV/+9mn22zhWb+letT8pPPn2kwm4dGEeuZduLjjmM0aZ+V2TWlYg1nip93kuGCzx/JxsNd4bhGoRe
	zZoTPus62bQE0qfhaCZ5Sav1qhRkl+1QiK6WUt11xl0O9a+fCRXigkdG3cu4mfvOUuTIMqfS6kIok
	ixZ1U1xzFjaKSR/kq1E9XYXsZ6zfyxYqJGmAGVWfGn+HFVm1sQA0ktBHe3hovlDPDZQCMFBrNJTHn
	O7lA5cAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8TKE-0000000Eqwr-1iZB;
	Tue, 14 Oct 2025 00:55:38 +0000
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8TKB-0000000EqwO-3IZx
	for linux-nvme@lists.infradead.org;
	Tue, 14 Oct 2025 00:55:37 +0000
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-32eb76b9039so6119784a91.1
        for <linux-nvme@lists.infradead.org>; Mon, 13 Oct 2025 17:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760403335; x=1761008135; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0qomT1ZkVPDmIuCEoNEUDG95EzuPyhJMmV7fO0hnOBs=;
        b=R7Yc6n3Pz8xq/yKBrjLjzArNCGNW2+8fa7WBXb3aMKLI6NxjfKzJteFR8rwz4+RfSa
         tNDiZqcfSsHfSBFITclK88iC6iWb30J26x1ZIQpvJ9QcJopZFt9Wjr2egVhcoDpjN61T
         1lkveXn2gsTsYfD+Z9Gaia3vJNF13crYa7hyNvYOoe0YfhLUerk1G+xWaOeWrFkQM1U/
         /alvpdMbkcONlGs2NIsF+5tNqF3Of1VB6Ck4U+5INdf2DTgHpE+oKu+k3pQt9dOziszT
         +GRvkVosloCw49FL5uZIyMYqAOb1hJfAp6tJzazgfb5yc1jD1WE94sONTE0fKvj0faJd
         70Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760403335; x=1761008135;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0qomT1ZkVPDmIuCEoNEUDG95EzuPyhJMmV7fO0hnOBs=;
        b=JI52CBTDKJsr47e5uMJ/l8SzWUN7xMNMOkCIEvbRh2OmCsH0Wo8OQULvj/vkGUv2d3
         Ski4AX5TUzBdDk3TCa3VTC/b+0mAG1+TBuyAfRZ+WdK0pvB2s077DfYsDTfnJ3sMmXXe
         MhsvSL5+aT5dI6+MCKzYb8sOKCOFC711/exG4b5C5QEPmJiZAJRtkjzYe2xRJDOC4Ggg
         ffRFgjSX/2AYn0h6V7K0EfoUuZsOARTPoaZyv3AfZkmVKZUIXYpDN++oFvi+nJOSXOYH
         TNooxq2zcNpPo+2daCjHlSTYYMtMN9xzmkVo+U/9jl4ovGwJcJ11BTKSpH6p/j5aJYva
         U7UQ==
X-Forwarded-Encrypted: i=1; AJvYcCWl30ImxerI/s/l3DyFrb1RD6uHc7oIYVrfzLC2D1wvYz8r6ZA1lL+fRsWg+AkC2N+Yciy66dDmdsMF@lists.infradead.org
X-Gm-Message-State: AOJu0YxpGJpxRPK14bynol46UerAo0DmO6b+g51xn0GTA/4hCj7DvHxg
	lBiUEGkNtoneuQadPMXfRVMrZjeoDOyunf5ZGDqTSniP+xXQv8+MEvEu
X-Gm-Gg: ASbGncvNR/2Ky+hk/w7P7dobxpY7Qfb0oehkhNP0QxoRjv84QzUgD/ah6VGjBM/u4y8
	Srw0Y4QCFzxxpmxBDdKocnCJyYSQx6/hefinUvqoHhdjqi0kA673VV4FpC1RWGaQN+Be2Qvi5Hz
	/MJsB3Qd/+y3BmwYnFqwM0wdgUkFrFahtuGtXWVd7vPSrKP+HA+2XAFRZfJ8/E8IOmOTZ4q/43V
	IL5vF4vcq449VzC9oil5zIUUb5KGyJpt1w0UEnvetvFbTHZtpAFwdrnmRhPWHE26SKevE6yckxE
	FZYIG24BkbkmLhnw4Y/jt6eTJgS4k5fVM7Duh+iDq6WNG4q2zVi/rDlGQwUnyJl0xyGeJ9GZ8eF
	i2s/l5WIrn9NkjU2m4JdtonR5fqVkCA4cMysez0CA
X-Google-Smtp-Source: AGHT+IGniqk01IgDaiRJwaKVGBcopVfs/CxGUBowAuplH5VoT3lCcXuXMawjfUp7c/hF1vuAQ69KrA==
X-Received: by 2002:a17:902:e5c6:b0:268:db2:b78f with SMTP id d9443c01a7336-29027402c15mr322158845ad.44.1760403334516;
        Mon, 13 Oct 2025 17:55:34 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-29040e02648sm112012925ad.116.2025.10.13.17.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 17:55:34 -0700 (PDT)
Date: Tue, 14 Oct 2025 08:54:49 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Genes Lists <lists@sapience.com>, Inochi Amaoto <inochiama@gmail.com>, 
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org
Cc: linux-pci@vger.kernel.org
Subject: Re: mainline boot fail nvme/block? [BISECTED]
Message-ID: <xfzcvv6ezleds24wvha2apkz5kirhcmoydm3on2hnfrxcwuc3g@koj6plovnvbd>
References: <4b392af8847cc19720ffcd53865f60ab3edc56b3.camel@sapience.com>
 <cf4e88c6-0319-4084-8311-a7ca28a78c81@kernel.dk>
 <3152ca947e89ee37264b90c422e77bb0e3d575b9.camel@sapience.com>
 <trdjd7zhpldyeurmpvx4zpgjoz7hmf3ugayybz4gagu2iue56c@zswmzvauqnxk>
 <622d6d7401b5cfd4bd5f359c7d7dc5b3bf8785d5.camel@sapience.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <622d6d7401b5cfd4bd5f359c7d7dc5b3bf8785d5.camel@sapience.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251013_175535_855772_D7CB5E98 
X-CRM114-Status: GOOD (  37.66  )
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

On Mon, Oct 13, 2025 at 07:45:05AM -0400, Genes Lists wrote:
> On Mon, 2025-10-13 at 16:46 +0800, Inochi Amaoto wrote:
> > On Fri, Oct 10, 2025 at 07:49:34PM -0400, Genes Lists wrote:
> > > On Fri, 2025-10-10 at 08:54 -0600, Jens Axboe wrote:
> > > > On 10/10/25 8:29 AM, Genes Lists wrote:
> > > > > Mainline fails to boot - 6.17.1 works fine.
> > > > > Same kernel on an older laptop without any nvme works just
> > > > > fine.
> > > > > 
> > > > > It seems to get stuck enumerating disks within the initramfs
> > > > > created by
> > > > > dracut.
> > > > > 
> > > > > ,
> ...
> 
> > > Bisect landed here. (cc linux-pci@vger.kernel.org)
> > > Hopefully it is helpful, even though I don't see MSI in lspci
> > > output
> > > (which is provided below).
> > > 
> > > gene
> > > 
> > > 
> > > 54f45a30c0d0153d2be091ba2d683ab6db6d1d5b is the first bad commit
> > > commit 54f45a30c0d0153d2be091ba2d683ab6db6d1d5b (HEAD)
> > > Author: Inochi Amaoto <inochiama@gmail.com>
> > > Date:   Thu Aug 14 07:28:32 2025 +0800
> > > 
> > >     PCI/MSI: Add startup/shutdown for per device domains
> > > 
> > >     As the RISC-V PLIC cannot apply affinity settings without
> > > invoking
> > >     irq_enable(), it will make the interrupt unavailble when used
> > > as an
> > >     underlying interrupt chip for the MSI controller.
> > > 
> > >     Implement the irq_startup() and irq_shutdown() callbacks for
> > > the
> > > PCI MSI
> > >     and MSI-X templates.
> > > 
> > >     For chips that specify MSI_FLAG_PCI_MSI_STARTUP_PARENT, the
> > > parent
> > > startup
> > >     and shutdown functions are invoked. That allows the interrupt
> > > on
> > > the parent
> > >     chip to be enabled if the interrupt has not been enabled during
> > >     allocation. This is necessary for MSI controllers which use
> > > PLIC as
> > >     underlying parent interrupt chip.
> > > 
> > >     Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> > >     Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > >     Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > >     Tested-by: Chen Wang <unicorn_wang@outlook.com> # Pioneerbox
> > >     Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
> > >     Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > >     Link: https://lore.kernel.org/all/20250813232835.43458-3-
> > > inochiama@gmail.com
> > > 
> > >  drivers/pci/msi/irqdomain.c | 52
> > > ++++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  include/linux/msi.h         |  2 ++
> > >  2 files changed, 54 insertions(+)
> > > 
> > > 
> ...
> 
> > 
> > 
> > I think this is caused by VMD device, which I have a temporary
> > solution
> > here [1]. Since I have no idea about how VMD works, I hope if anyone
> > can help to convert this as an formal fix.
> > 
> > [1]
> > https://lore.kernel.org/all/qs2vydzm6xngul77xuwjli7h757gzfhmb4siiklzo
> > gihz5oplw@gsvgn75lib6t/
> > 
> > Regards,
> > Inochi
> 
> Thank you Inochi
> 
> I tried this patch over 6.18-rc1.
> 
>  It get's further than without the patch but around the time I get
> prompted for passphrase for the luks partition
> (root is not encrypted) it crashes. 
> 
> I have uploaded 2 images I took of the screen when this happens and
> uploaded them to here:
> 
>     https://0x0.st/KSNz.jpg
>     https://0x0.st/KSNi.jpg
> 

This picture is only a WARNING from perf_get_x86_pmu_capability,
and no other information. So I am not sure whether it is caused
by this change. But from the original report I have, it solves
the problem at that time.

By the way, can you test the following change?
https://lore.kernel.org/all/2hyxqqdootjw5yepbimacuuapfsf26c5mmu5w2jsdmamxvsjdq@gnibocldkuz5/

If it is OK, I will send a patch for it.

Regards,
Inochi

