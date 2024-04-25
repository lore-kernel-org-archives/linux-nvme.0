Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1132DC10F15
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Apr 2024 06:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vEKVDSHMK5F/yU8ggTZJjhUhsGYpK1yP0OK1ux8Mb5o=; b=QXR//v4TKPxHF2UfFBPU2tNrsM
	bcz38cvqzNIAVy4fl1ylEaPVwXhVo8M1TkMk/jDEpfAzMV+5NJ4gLUB1VKRkhbWLHnD2Bcj7Dr9Fv
	Z0WDKEbhL2yMLr9MnSzz3Mj0KP0gW87SNhIFmcP2zAFF8YHU6UPy4vdv63peAdCoJzEkYyS8ojAzL
	g++GOHopGRV8Qh3Y8KAQzP23a3IOCYc4kvXKcHAybV7GzrQTpcKgrQDgYUnNH9nwoFE5v0DlB7iHy
	esVzhmMF577zJxl+uLMgDtZW2Q19HTq5CIlded26QQjLmCkGAPMBq4serCKEXDdJL3SI3/9bBeWyB
	DJ1y49OA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzsZO-0000000784G-2pqh;
	Thu, 25 Apr 2024 06:26:58 +0000
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzsZL-0000000782z-0S9R
	for linux-nvme@lists.infradead.org;
	Thu, 25 Apr 2024 06:26:57 +0000
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 463A84059B
	for <linux-nvme@lists.infradead.org>; Thu, 25 Apr 2024 06:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1714026408;
	bh=vEKVDSHMK5F/yU8ggTZJjhUhsGYpK1yP0OK1ux8Mb5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=MEfmFbjRMHbZe7dqKwQyqOt/C1ykvWE0CHezyTR5NdnJ/yXWOxAhZij4rJ0BHJ59P
	 g9tO6H09BFy2sJ9DfyZHEcKvuyNH6an4/LpFXjvN1G9eLHJ+ma0DuKmzmER88ZIARk
	 wacon9ThfyZzGXp2ZKMmZfmyNZd1nT+63+BZ33ecTNaKonLXmSZbrDyRHOb+JEh1M5
	 nXeas9O8OqokbLCWhj4nLePWlCz3gUw8d0cZItwMgOG2inHQ6G62ngKt7XfyUjOdMu
	 /j3gH+IzNUBWGjhHg3DjUndwsCvYEi5GzPLfKQwfoCD31vERC2ElQ5ElYlVw1SETIp
	 ov4L7a/Bdmqdw==
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ae0abc0b41so819193a91.2
        for <linux-nvme@lists.infradead.org>; Wed, 24 Apr 2024 23:26:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714026407; x=1714631207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vEKVDSHMK5F/yU8ggTZJjhUhsGYpK1yP0OK1ux8Mb5o=;
        b=jTCSPiwtO83BRz1rO27U7sYqhf04RaYTzRkhYJr6E5y2pePEZ5MwhLAqN/fMgJouj4
         4vMmufVAQxmzje+/vSa/4xHwjYpm2w87OZu1tTzbeu7fAz0rk8UqHnWGzX9DNN0zgZkr
         SgVvFySRPJPRUamIkMH2ckT+4ktu0CMcscJpwvt4d7x5kV9oHq4QugSLANYbpMvKXasO
         W8F83FSCEwlA8AV+8pTAHTLnK0v390FsnGhnNk4TWrEMnvRrHq2YTkEiAAkb/M1bi0Su
         dyJ1CNcbK7+lw0xI3M+7TwdDNwtpG811ftS89S9meqidGXGG5eaVD6AUke3Y+l79BmFe
         CkHg==
X-Forwarded-Encrypted: i=1; AJvYcCXLTzgGtf+16Uf3ZtLQVKXB+SRICPdBlDc0Wq+/k2S317gt7pcMzngaEcrCOpNQwFo18evL3X4aeSDUl5spCsCG3+74581SV3ZZn3cZkLk=
X-Gm-Message-State: AOJu0YySn7OhnE8DFGjYpcmjBW3qYqwKdYjenHfKlUE+Ot1al1irb9Av
	HqGs92hpSwlHL1LabiCO1cH/I3zsOkWN1KGcb0fz9tpiwxm528tjlEzly/YVXTZh75NKs8GOav/
	r5gCErswWkS1yjNN1knB2Dv2uzrsA2bbSicFI1bGY0ksfJKyqK0Z9vdhEh0PekAW2YFnLFwlKEg
	J3jPFghGTCJLi1g885hAEVOrWjQhBunBBWNNjy2kfzBomotm9qoW6MPk8=
X-Received: by 2002:a17:90a:4485:b0:2a6:ff2e:dce0 with SMTP id t5-20020a17090a448500b002a6ff2edce0mr5440128pjg.5.1714026406794;
        Wed, 24 Apr 2024 23:26:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLNR3SuwzJ2NqCuDu7XgA6QzggBx2sXnYGhGItyhdXG9zOH57lKQGVFKFleuFQOUiHqsV2LTxk6EPDijTfycg=
X-Received: by 2002:a17:90a:4485:b0:2a6:ff2e:dce0 with SMTP id
 t5-20020a17090a448500b002a6ff2edce0mr5440111pjg.5.1714026406400; Wed, 24 Apr
 2024 23:26:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240416043225.1462548-1-kai.heng.feng@canonical.com> <2aff18aa-32b7-4092-8235-aead9b708ea0@linux.intel.com>
In-Reply-To: <2aff18aa-32b7-4092-8235-aead9b708ea0@linux.intel.com>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Thu, 25 Apr 2024 14:26:34 +0800
Message-ID: <CAAd53p7e5dWEsSdrvpZ_5b9LLrhVwQEChUkFityN_nOuT2K=zQ@mail.gmail.com>
Subject: Re: [PATCH v8 1/3] PCI: Add helper to check if any of ancestor device
 support D3cold
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: bhelgaas@google.com, mahesh@linux.ibm.com, oohall@gmail.com, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, bagasdotme@gmail.com, 
	regressions@lists.linux.dev, linux-nvme@lists.infradead.org, kch@nvidia.com, 
	hch@lst.de, gloriouseggroll@gmail.com, kbusch@kernel.org, sagi@grimberg.me, 
	hare@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240424_232655_338862_55097ECF 
X-CRM114-Status: GOOD (  27.25  )
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

On Thu, Apr 18, 2024 at 9:15=E2=80=AFAM Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
>
> On 4/15/24 9:32 PM, Kai-Heng Feng wrote:
> > In addition to nearest upstream bridge, driver may want to know if the
> > entire hierarchy can be powered off to perform different action.
> >
> > So walk higher up the hierarchy to find out if any device has valid
> > _PR3.
> >
> > The user will be introduced in next patch.
> >
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
>
> Since it has been a while, I was not sure what this series is about.
>
> IMO, it is better to include a cover letter with the summary of your
> changes.

OK, will do in next revision.

>
>
> > v8:
> >  - No change.
> >
> >  drivers/pci/pci.c   | 16 ++++++++++++++++
> >  include/linux/pci.h |  2 ++
> >  2 files changed, 18 insertions(+)
> >
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index e5f243dd4288..7a5662f116b8 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -6225,6 +6225,22 @@ bool pci_pr3_present(struct pci_dev *pdev)
> >               acpi_has_method(adev->handle, "_PR3");
> >  }
> >  EXPORT_SYMBOL_GPL(pci_pr3_present);
> > +
> > +bool pci_ancestor_pr3_present(struct pci_dev *pdev)
> > +{
> > +     struct pci_dev *parent =3D pdev;
> > +
> > +     if (acpi_disabled)
> > +             return false;
> > +
> > +     while ((parent =3D pci_upstream_bridge(parent))) {
> > +             if (pci_pr3_present(pdev))
>
> I think it should be "parent" here?

Thanks for catching this.

But this patch will be dropped in next version for better simplicity.

Kai-Heng

>
> > +                     return true;
> > +     }
> > +
> > +     return false;
> > +}
> > +EXPORT_SYMBOL_GPL(pci_ancestor_pr3_present);
> >  #endif
> >
> >  /**
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index 16493426a04f..cd71ebfd0f89 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -2620,10 +2620,12 @@ struct irq_domain *pci_host_bridge_acpi_msi_dom=
ain(struct pci_bus *bus);
> >  void
> >  pci_msi_register_fwnode_provider(struct fwnode_handle *(*fn)(struct de=
vice *));
> >  bool pci_pr3_present(struct pci_dev *pdev);
> > +bool pci_ancestor_pr3_present(struct pci_dev *pdev);
> >  #else
> >  static inline struct irq_domain *
> >  pci_host_bridge_acpi_msi_domain(struct pci_bus *bus) { return NULL; }
> >  static inline bool pci_pr3_present(struct pci_dev *pdev) { return fals=
e; }
> > +static inline bool pci_ancestor_pr3_present(struct pci_dev *pdev) { re=
turn false; }
> >  #endif
> >
> >  #ifdef CONFIG_EEH
>
> --
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer
>

