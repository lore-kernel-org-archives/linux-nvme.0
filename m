Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C62DCCD1297
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Apr 2024 06:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c4RLomVFx/TuAWRMBXK2XWbrdYltPGPf0njvoF5tjOU=; b=DMZynHdrJrA374JB7R13vu6+sH
	iEqN1treANBc4M9aHahTkDaC36jDV318hZP5odgRkGx402nOZa0pa/abqj0fQbgxAsL3sCYat9RZw
	KN1c+sNpPezs0w64hHuJeDsk0CodSy1YW55iwUGYVS4SEPk0Al2Wpu7yykR920HK+FhcM8Cy/ItzT
	v/1KrKEhCbwYjNsaUsdtJqLcesza9gbnbdqJRYafxrPp/aMdJPVSrzjI/jldUNLRNG7Hy3MJs87OF
	2CcxO73bm53Toeb7A2bcTXt1ZvnxNTX9I0zSPAVjv+1pkECJqp41oBsC70ZGYKoQbWQtigzyF0DXq
	O3B7W0sw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruRKS-00000005MM3-07VM;
	Wed, 10 Apr 2024 06:21:04 +0000
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruRKH-00000005MEa-19aA
	for linux-nvme@lists.infradead.org;
	Wed, 10 Apr 2024 06:21:01 +0000
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id F20DE3FFE2
	for <linux-nvme@lists.infradead.org>; Wed, 10 Apr 2024 06:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1712730046;
	bh=c4RLomVFx/TuAWRMBXK2XWbrdYltPGPf0njvoF5tjOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=q9ZFvoSYcYAy+m3Mb+OTaWOvRAKPupMlXZLfEHa/bnq03dP9cFUFZn3jbeBLPpO0L
	 6TNLKC3Sd+9c5sMMdLtEGVZzrXsFNZ1JH+xCySilJ/aD+LLSjilEGbSzznqd6h05/j
	 bhDsNr88mZfzHUcWVJtIW+H3yrx1TjLbf8MAmGqiE+G+jEgcLoWRenxW1mEZD+pB5d
	 Q3+SVoGt3jz2tp6BxtUBMjEk3bvcqZj4rAOhBUaRBkhGRUDYtOdb6Td0DcHepeoJ26
	 jofJFrtGHJgU5MEG1xwYZJz9QxvfydHSJRVVgit8ZICly51/ZGHhTlxXXXP3BfM7Sj
	 u++vqB0fhjwqA==
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5e5022b34faso7454316a12.0
        for <linux-nvme@lists.infradead.org>; Tue, 09 Apr 2024 23:20:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712730043; x=1713334843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c4RLomVFx/TuAWRMBXK2XWbrdYltPGPf0njvoF5tjOU=;
        b=R5xvbLtCltBiXjZlg5+79SMebHIyGSCBoT6BDApMKtroJkwSaOaax8ibrMpJm49Vfa
         fRAr4q2loTaaJU1MTeJfBRi20JSz8XozeAXfPV0v7BNe1TUD1poacGZUcrQ0KPMMV6Wl
         PxFjE7uHf1yAntZlvvrhAjrwAbif2w7EDz4PIC4gD0wbXXK3r6CsoQPDcJFbsgCv/QZZ
         csmmjK9CxS+L22Nz53kE5hVvsUcSB5/ZB4tnofBk5a5y0Uf3Daw9TPQn6TH6xtAhLET+
         O3e5g7A44JsnX8fGwoDSQcF0NbJSU4ZSzrQktkDWV3F1dcX9o6ve8z0lCbo+KhZiO50F
         tNzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMc9INOMftIN/TkVhOLBT5he3LzCR86THIPEoT/sb1YX3iXiWh+8A3y6OHPEmGc+MSZJeyawuMlAMlHUapvskr0poTCEV6wIenjWW+Mwg=
X-Gm-Message-State: AOJu0Yy++vHsgeuPGE1ATEOstuFJHwjP1ud6E2Bei8GtC6jSvsut83FX
	nu5hGKv8SgkoAOQRbBb778nFD0U1he0PHtM3rlPS5f5Mx7p7lYDYKxvPq15UXdY2rYHdBPxIvsp
	U/S5NOiwJauHuB4LedQPnp0oEBetlGiZ04t477FMSeNGN6ldivukHSvJ5Ec5yYdx2W0w1asJjx3
	IGzegybbiI6MIsM7Ti1qLVu4HXAv7JxBBPd80jHe9QZ1JymFVJZLh8c0U=
X-Received: by 2002:a05:6a20:4309:b0:1a7:3b64:d502 with SMTP id h9-20020a056a20430900b001a73b64d502mr2208373pzk.2.1712730043051;
        Tue, 09 Apr 2024 23:20:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgyoDZl5olc2xjm1Mxx1Ht8QRN5jAV8LOnYj30hN5SCozJfPV5QBdffJRdphGLQ2L4F90HAbAmEOPBLEJnwNg=
X-Received: by 2002:a05:6a20:4309:b0:1a7:3b64:d502 with SMTP id
 h9-20020a056a20430900b001a73b64d502mr2208360pzk.2.1712730042713; Tue, 09 Apr
 2024 23:20:42 -0700 (PDT)
MIME-Version: 1.0
References: <20231101114541.GA43502@bhelgaas> <20240330134655.GA1659153@bhelgaas>
In-Reply-To: <20240330134655.GA1659153@bhelgaas>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Wed, 10 Apr 2024 14:20:31 +0800
Message-ID: <CAAd53p6hH1=pchRidgMg2Go21tG=nJz+nz+6w++9hGSgFOcVgQ@mail.gmail.com>
Subject: Re: Fwd: Regression: Kernel 6.4 rc1 and higher causes Steam Deck to
 fail to wake from suspend (bisected)
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Regressions <regressions@lists.linux.dev>, Linux NVMe <linux-nvme@lists.infradead.org>, 
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>, gloriouseggroll@gmail.com, 
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240409_232058_749245_AD5A6D88 
X-CRM114-Status: GOOD (  48.47  )
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

Hi Bjorn,

On Sat, Mar 30, 2024 at 9:47=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> [+cc Keith, Sagi, Hannes, Kai-Heng, +bcc silverspring from bugzilla]
>
> On Wed, Nov 01, 2023 at 06:45:41AM -0500, Bjorn Helgaas wrote:
> > On Tue, Oct 31, 2023 at 03:21:20PM +0700, Bagas Sanjaya wrote:
> > > I notice a regression report on Bugzilla [1]. Quoting from it:
> > >
> > > > On Kernel 6.4 rc1 and higher if you put the Steam Deck into
> > > > suspend then press the power button again it will not wake up.
> > > >
> > > > I don't have a clue as to -why- this commit breaks wake from
> > > > suspend on steam deck, but it does. Bisected to:
> > > >
> > > > ```
> > > > 1ad11eafc63ac16e667853bee4273879226d2d1b is the first bad commit
> > > > commit 1ad11eafc63ac16e667853bee4273879226d2d1b
> > > > Author: Bjorn Helgaas <bhelgaas@google.com>
> > > > Date:   Tue Mar 7 14:32:43 2023 -0600
> > > >
> > > >     nvme-pci: drop redundant pci_enable_pcie_error_reporting()
> > > >
> > > >     pci_enable_pcie_error_reporting() enables the device to send ER=
R_*
> > > >     Messages.  Since f26e58bf6f54 ("PCI/AER: Enable error reporting=
 when AER is
> > > >     native"), the PCI core does this for all devices during enumera=
tion, so the
> > > >     driver doesn't need to do it itself.
> > > >
> > > >     Remove the redundant pci_enable_pcie_error_reporting() call fro=
m the
> > > >     driver.  Also remove the corresponding pci_disable_pcie_error_r=
eporting()
> > > >     from the driver .remove() path.
> > > >
> > > >     Note that this only controls ERR_* Messages from the device.  A=
n ERR_*
> > > >     Message may cause the Root Port to generate an interrupt, depen=
ding on the
> > > >     AER Root Error Command register managed by the AER service driv=
er.
> > > >
> > > >     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > > >     Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> > > >     Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > >
> > > >  drivers/nvme/host/pci.c | 6 +-----
> > > >  1 file changed, 1 insertion(+), 5 deletions(-)
> > > > ```
>
> > > > Reverting that commit by itself on top of 6.5.9 (stable) allows
> > > > it to wake from suspend properly.
>
> > > [1]: https://bugzilla.kernel.org/show_bug.cgi?id=3D218090
> >
> > Thanks, I requested some dmesg logs and lspci output to help debug
> > this.
>
> silverspring attached lspci output and a dmesg log from v6.8 to the
> bugzilla and also noted that "pci=3Dnoaer" works around the problem.
>
> The problem commit is 1ad11eafc63a ("nvme-pci: drop redundant
> pci_enable_pcie_error_reporting()")
> (https://git.kernel.org/linus/1ad11eafc63a)
>
> 1ad11eafc63a removed pci_disable_pcie_error_reporting() from the
> nvme_suspend() path, so we now leave the PCIe Device Control error
> enables set when we didn't before.  My theory is that the PCIe link
> goes down during suspend, which causes an error interrupt, and the
> interrupt causes a problem on Steam Deck.  Maybe there's some BIOS
> connection.
>
> "pci=3Dnoaer" would work around this because those error enables would
> never be set in the first place.
>
> I asked reporters to test the debug patches below to disable those
> error interrupts during suspend.
>
> I don't think this would be the *right* fix; if we need to do this, I
> think it should be done by the PCI core, not by individual drivers.
> Kai-Heng has been suggesting this for a while for a different
> scenario.

Should I send the patch to mailing list again to stir more discussion?

Kai-Heng

>
> Bjorn
>
>
> commit 60c07557d0cc ("Revert "PCI/AER: Drop unused pci_disable_pcie_error=
_reporting()"")
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Fri Mar 29 17:54:30 2024 -0500
>
>     Revert "PCI/AER: Drop unused pci_disable_pcie_error_reporting()"
>
>     This reverts commit 69b264df8a412820e98867dbab871c6526c5e5aa.
>
>
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index ac6293c24976..273f9c6f93dd 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -243,6 +243,18 @@ static int pci_enable_pcie_error_reporting(struct pc=
i_dev *dev)
>         return pcibios_err_to_errno(rc);
>  }
>
> +int pci_disable_pcie_error_reporting(struct pci_dev *dev)
> +{
> +       int rc;
> +
> +       if (!pcie_aer_is_native(dev))
> +               return -EIO;
> +
> +       rc =3D pcie_capability_clear_word(dev, PCI_EXP_DEVCTL, PCI_EXP_AE=
R_FLAGS);
> +       return pcibios_err_to_errno(rc);
> +}
> +EXPORT_SYMBOL_GPL(pci_disable_pcie_error_reporting);
> +
>  int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
>  {
>         int aer =3D dev->aer_cap;
> diff --git a/include/linux/aer.h b/include/linux/aer.h
> index 4b97f38f3fcf..425e5e430e65 100644
> --- a/include/linux/aer.h
> +++ b/include/linux/aer.h
> @@ -40,9 +40,14 @@ struct aer_capability_regs {
>  int pcie_read_tlp_log(struct pci_dev *dev, int where, struct pcie_tlp_lo=
g *log);
>
>  #if defined(CONFIG_PCIEAER)
> +int pci_disable_pcie_error_reporting(struct pci_dev *dev);
>  int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
>  int pcie_aer_is_native(struct pci_dev *dev);
>  #else
> +static inline int pci_disable_pcie_error_reporting(struct pci_dev *dev)
> +{
> +       return -EINVAL;
> +}
>  static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
>  {
>         return -EINVAL;
> commit 8efb88cf23d4 ("nvme-pci: disable error reporting in nvme_dev_disab=
le()")
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Fri Mar 29 17:52:39 2024 -0500
>
>     nvme-pci: disable error reporting in nvme_dev_disable()
>
>     Debug patch.
>
>     The PCI core enables error reporting in pci_aer_init() for all device=
s that
>     advertise AER support.
>
>     During suspend, nvme_suspend() calls nvme_dev_disable() in several ca=
ses.
>     Prior to 1ad11eafc63a, nvme_dev_disable() disabled error reporting.
>
>     After 1ad11eafc63a, error reporting will remain enabled during suspen=
d.
>     Maybe having error reporting enabled during suspend causes a problem =
on
>     Steam Deck.
>
>     "pci=3Dnoaer" prevents pci_aer_init() from enabling error reporting, =
so as
>     long as the BIOS doesn't enable it, error reporting should always be
>     disabled.
>
>       nvme_suspend
>         nvme_disable_prepare_reset
>           nvme_dev_disable
>
>
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 8e0bb9692685..2be838b5d1f6 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -5,6 +5,7 @@
>   */
>
>  #include <linux/acpi.h>
> +#include <linux/aer.h>
>  #include <linux/async.h>
>  #include <linux/blkdev.h>
>  #include <linux/blk-mq.h>
> @@ -2603,8 +2604,10 @@ static void nvme_dev_disable(struct nvme_dev *dev,=
 bool shutdown)
>         nvme_suspend_io_queues(dev);
>         nvme_suspend_queue(dev, 0);
>         pci_free_irq_vectors(pdev);
> -       if (pci_is_enabled(pdev))
> +       if (pci_is_enabled(pdev)) {
> +               pci_disable_pcie_error_reporting(pdev);
>                 pci_disable_device(pdev);
> +       }
>         nvme_reap_pending_cqes(dev);
>
>         nvme_cancel_tagset(&dev->ctrl);

