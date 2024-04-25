Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57FF6C10F15
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Apr 2024 07:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N49t3AK4kKaDmcRRhdLxt0k+B5LqZexfU9NZVLcAJRM=; b=4Yg/WT5ABKa5/4t1467oBZlXux
	HbYUa74C8dppILxqDmvGpBWl+2Qf/ZdFcC3Z/gog2IN0CPrMuGuuZkPR5xTH2YyLwe05i125HVRob
	/dQ1UXJUjYnCqrBGdcBJUmlNIgnEPw09Jbp0ZYZlZb+cnaEQpvw714IN2/xVv71rFl5tFtG7vNoph
	bVorVbbJoGwPQHvbR79CCkiiGrZ1PZK1IcDHT16DkLwFXKhI3ACDu7awo4iRrh9qE/JtzA0uHV6s/
	EZPdJ+I2Y/pjMjHagsrmyyNJ0Oe9cndP76bS6sscofSaLXMqVq82C7V+MElG4bFzB1QvSM7Rez24I
	xlIq6MdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rztbe-00000007HsO-2BJF;
	Thu, 25 Apr 2024 07:33:22 +0000
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rztbb-00000007HqO-241N
	for linux-nvme@lists.infradead.org;
	Thu, 25 Apr 2024 07:33:21 +0000
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A63143FE5C
	for <linux-nvme@lists.infradead.org>; Thu, 25 Apr 2024 07:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1714030395;
	bh=N49t3AK4kKaDmcRRhdLxt0k+B5LqZexfU9NZVLcAJRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=K/N2DRIaAjRmNok+zH6+pAoU60HS5IhDtlWrvgoAC+5zlde01ji/jFB9aetPrMeeN
	 9pgn7qyz659domxob/FkcKPJfW0/vk6864KnoOLXosCrt26NqEll/LCHjuYSDs/KAK
	 /GwwGVFrS2ib1JkZmgqqi70fNvWJrYPjia0XLMXh/kwHDiN9adj4Szvs+t1ZlomlI4
	 bdGPm7KpPZG1k8Djjtmdbj6XX3BSHM5D9NKVQH2DoGwj29Y3neOyH2rSiX1S1e7N0R
	 WTe0I3dRI8Wklfu4T9wdQXSsC7s5A3dcbFa1Rxfqdq3KulbSK3SGmzfuYMtzFqCF6A
	 fDlP1dnM0ifTg==
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2a5457a8543so892621a91.0
        for <linux-nvme@lists.infradead.org>; Thu, 25 Apr 2024 00:33:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714030394; x=1714635194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N49t3AK4kKaDmcRRhdLxt0k+B5LqZexfU9NZVLcAJRM=;
        b=oogXFuS865vl6T/t3CJul2KqqPQXXFpTOUoypuFF98+r7YRa4xI3qwyZST/XvPwULR
         n5SVAPEFoSwfmtq99jYX1kxXryel2XItwH/8wVtuk2jOOn1EZFvcNy+v+3ol6Yxg7riR
         3/zz8YVyOVmeyARUJDA5FcINEwhVgFhMC6jRh3viBlK/k3c8Lp0D2EDsfst5aQsoRFxW
         u7IBFa/YfXaPZarEQnucK8RadxeNsgoqeuPqa7uDKpthI1zbQf/5W0s/0pZndpMgzUzs
         eWXIoVru2OuKXIJoxFumLaQ0dALjhSCK25cbzbF/NP6h+lbps0ZfjhyGScePcg2cm1qU
         wytA==
X-Forwarded-Encrypted: i=1; AJvYcCVfingMHRxm4Y/sXahphg13O5juqm6clfwczkQqZ3nCG3CNvT8hdfP69U4fhiW/BgkeDHIK0n8pTIy5jXigm2hiL7gTJAhsYsmi2287WWs=
X-Gm-Message-State: AOJu0Yw25S1KKyAbLDEdHsKHmZtLdt+Ln1DoGf0VGL+gz1SSowiueDwP
	vl9vmMGU0aRlFMXTFkGxoF5mL9BXw07DwCysOCCdMejsa/n0edznF/RVTJKp9uKu3mI8/H5hjn6
	FZ3q88TtT889eq/oT47QpVqUEREnBOeSvMvVzUoWhOxnWNdcHKXgjeNDuVeFmdF9WUqmnsGYvVG
	n6d5sm2QtiPTGN5UE97vD/qxSyAz5bnLrM34miQD1IebdN5iQ9orZXWck=
X-Received: by 2002:a17:90a:f18c:b0:2a2:775:9830 with SMTP id bv12-20020a17090af18c00b002a207759830mr3635606pjb.11.1714030393815;
        Thu, 25 Apr 2024 00:33:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxdkPh6jUQbDypZw6ih5aBEWZ8OaLuVmwkpiSeYBIaD8D8JrEbgl1UlPs5pmFlAQ5PAStLbkRGh+jSeMu9NOg=
X-Received: by 2002:a17:90a:f18c:b0:2a2:775:9830 with SMTP id
 bv12-20020a17090af18c00b002a207759830mr3635577pjb.11.1714030393404; Thu, 25
 Apr 2024 00:33:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240416043225.1462548-2-kai.heng.feng@canonical.com> <20240418203531.GA251408@bhelgaas>
In-Reply-To: <20240418203531.GA251408@bhelgaas>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Thu, 25 Apr 2024 15:33:01 +0800
Message-ID: <CAAd53p7O51mG7LMrEobEgGrD8tsDFO3ZFSPAu02Dk-R0W3mkvg@mail.gmail.com>
Subject: Re: [PATCH v8 2/3] PCI/AER: Disable AER service on suspend
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, mahesh@linux.ibm.com, oohall@gmail.com, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, bagasdotme@gmail.com, 
	regressions@lists.linux.dev, linux-nvme@lists.infradead.org, kch@nvidia.com, 
	hch@lst.de, gloriouseggroll@gmail.com, kbusch@kernel.org, sagi@grimberg.me, 
	hare@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240425_003319_704178_9F690F7E 
X-CRM114-Status: GOOD (  41.27  )
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

On Fri, Apr 19, 2024 at 4:35=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Tue, Apr 16, 2024 at 12:32:24PM +0800, Kai-Heng Feng wrote:
> > When the power rail gets cut off, the hardware can create some electric
> > noise on the link that triggers AER. If IRQ is shared between AER with
> > PME, such AER noise will cause a spurious wakeup on system suspend.
> >
> > When the power rail gets back, the firmware of the device resets itself
> > and can create unexpected behavior like sending PTM messages. For this
> > case, the driver will always be too late to toggle off features should
> > be disabled.
> >
> > As Per PCIe Base Spec 5.0, section 5.2, titled "Link State Power
> > Management", TLP and DLLP transmission are disabled for a Link in L2/L3
> > Ready (D3hot), L2 (D3cold with aux power) and L3 (D3cold) states. So if
> > the power will be turned off during suspend process, disable AER servic=
e
> > and re-enable it during the resume process. This should not affect the
> > basic functionality.
> >
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D209149
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D216295
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D218090
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>
> Thanks for reviving this series.  I tried follow the history about
> this, but there are at least two series that were very similar and I
> can't put it all together.
>
> > ---
> > v8:
> >  - Add more bug reports.
> >
> > v7:
> >  - Wording
> >  - Disable AER completely (again) if power will be turned off
> >
> > v6:
> > v5:
> >  - Wording.
> >
> > v4:
> > v3:
> >  - No change.
> >
> > v2:
> >  - Only disable AER IRQ.
> >  - No more check on PME IRQ#.
> >  - Use helper.
> >
> >  drivers/pci/pcie/aer.c | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> >
> > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> > index ac6293c24976..bea7818c2d1b 100644
> > --- a/drivers/pci/pcie/aer.c
> > +++ b/drivers/pci/pcie/aer.c
> > @@ -28,6 +28,7 @@
> >  #include <linux/delay.h>
> >  #include <linux/kfifo.h>
> >  #include <linux/slab.h>
> > +#include <linux/suspend.h>
> >  #include <acpi/apei.h>
> >  #include <acpi/ghes.h>
> >  #include <ras/ras_event.h>
> > @@ -1497,6 +1498,28 @@ static int aer_probe(struct pcie_device *dev)
> >       return 0;
> >  }
> >
> > +static int aer_suspend(struct pcie_device *dev)
> > +{
> > +     struct aer_rpc *rpc =3D get_service_data(dev);
> > +     struct pci_dev *pdev =3D rpc->rpd;
> > +
> > +     if (pci_ancestor_pr3_present(pdev) || pm_suspend_via_firmware())
> > +             aer_disable_rootport(rpc);
>
> Why do we check pci_ancestor_pr3_present(pdev) and
> pm_suspend_via_firmware()?  I'm getting pretty convinced that we need
> to disable AER interrupts on suspend in general.  I think it will be
> better if we do that consistently on all platforms, not special cases
> based on details of how we suspend.

Sure. Will change in next revision.

>
> Also, why do we use aer_disable_rootport() instead of just
> aer_disable_irq()?  I think it's the interrupt that causes issues on
> suspend.  I see that there *were* some versions that used
> aer_disable_irq(), but I can't find the reason it changed.

Interrupt can cause system wakeup, if it's shared with PME.

The reason why aer_disable_rootport() is used over aer_disable_irq()
is that when the latter is used the error still gets logged during
sleep cycle. Once the pcieport driver resumes, it invokes
aer_root_reset() to reset the hierarchy, while the hierarchy hasn't
resumed yet.

So use aer_disable_rootport() to prevent such issue from happening.

Kai-Heng

>
> > +
> > +     return 0;
> > +}
> > +
> > +static int aer_resume(struct pcie_device *dev)
> > +{
> > +     struct aer_rpc *rpc =3D get_service_data(dev);
> > +     struct pci_dev *pdev =3D rpc->rpd;
> > +
> > +     if (pci_ancestor_pr3_present(pdev) || pm_resume_via_firmware())
> > +             aer_enable_rootport(rpc);
> > +
> > +     return 0;
> > +}
> > +
> >  /**
> >   * aer_root_reset - reset Root Port hierarchy, RCEC, or RCiEP
> >   * @dev: pointer to Root Port, RCEC, or RCiEP
> > @@ -1561,6 +1584,8 @@ static struct pcie_port_service_driver aerdriver =
=3D {
> >       .service        =3D PCIE_PORT_SERVICE_AER,
> >
> >       .probe          =3D aer_probe,
> > +     .suspend        =3D aer_suspend,
> > +     .resume         =3D aer_resume,
> >       .remove         =3D aer_remove,
> >  };
> >
> > --
> > 2.34.1
> >

