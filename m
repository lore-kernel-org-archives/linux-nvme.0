Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D73A8C77B73
	for <linux-nvme@archiver.kernel.org>; Tue,  2 May 2023 14:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oD7I841GKziOZSmnGBqqnqgAzBVwUkEri/Jv0IUfVTI=; b=mo9ahDeu3izpPQI+tC4y5faJtu
	VxP1bk4l+tJ68JGYdVvOT0zojuAMV1YVHo+oqWFvWNl3Qwlf4AudrVc491cYkRqMducfgeGJkUYQx
	cDbKlNGL0W661amg92LymfeBeEzhneRiWA8mg08RqWczWY4vBqpim6Me6jtiXxo+s9eNXhrJXUC8S
	BoqqIEtfyby2KCeSTcVru3MKMFmaCRP3x+5Tp1PAHYps423VrYSAC7aB52y3zclJkiZhzT2Nd/yyM
	fI0HTd+nS81P4mtxHd51ZaRSubr+kVQ+uwLxX972EF94NDAaVG+yb+HnFYQkr0JcfolXOakA8vZeI
	BNnpkDEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ptqc3-001lNJ-2G;
	Tue, 02 May 2023 14:04:15 +0000
Received: from desiato.infradead.org ([90.155.92.199])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptqc1-001lN2-2M
	for linux-nvme@bombadil.infradead.org;
	Tue, 02 May 2023 14:04:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:To:Subject:Message-ID:
	Date:From:In-Reply-To:References:MIME-Version:Sender:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oD7I841GKziOZSmnGBqqnqgAzBVwUkEri/Jv0IUfVTI=; b=GVf2t8tXQWu9IxhW5eB4iTz1br
	OqjFBNUXA3ITL7svHlyBJqQEHyUm1e5bqYoCvQAwKaaq065kEKeVTqXMBi5C1v3ZOupooAw/4D/es
	zhUHjxLoJUwlXogAcv77c57BBsZEr+N59iPWnERFMHdSr3LTr7XjOPYFMm9XeAXKvPrHJkFzwv/Wk
	caJ4Yd16rCN0yPubQYm1h5o6DHCbSUu8wgCD6wnnC5rN7u+X19+szZr04eQPhNkC1zDomA4EtzRbu
	+dm+3JzwWpw8x7ZbrL82hd6wQTMsUaoHOM7D5f9VVKoXyRzxz1Y36XTh4iNhXUkSeDGOpdyL/oZqx
	1IDIhVKg==;
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptqbx-00GK4a-2l
	for linux-nvme@lists.infradead.org;
	Tue, 02 May 2023 14:04:12 +0000
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-55a64f0053fso27429207b3.3
        for <linux-nvme@lists.infradead.org>; Tue, 02 May 2023 07:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ds-gy.20221208.gappssmtp.com; s=20221208; t=1683036245; x=1685628245;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oD7I841GKziOZSmnGBqqnqgAzBVwUkEri/Jv0IUfVTI=;
        b=egvEE0X3L0D9MrcIHYlUjJBSHpzzmM2Y0NW6U1hQEOxdSXn/SywjMd+0EdgURGkcsp
         cDGx9QBF3Udi6qu+aKr/gzLlk3TFRfgPvJ2R2FcVVMkxBvwkpuTAAO2lss2PK22tdm5U
         bw+ShRk+GIKOlYHfVp3/rfqiVHeA8mefMT8OfN9vwlKYWZe1+KBY6L2ZCZTO6jKzUCbS
         dY2fm2kMH9A3aAtYWaMcne2cHfmMsW67BvrARceB4tKvie9uFgNnlVAa+XZMuWqCNYOO
         4PiE/KENUdHD65XIShVR+lKq9FxdovW8o0NO7NvWgp0SWUCPsZ+oej2pqXqLPrymIluI
         HeAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683036245; x=1685628245;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oD7I841GKziOZSmnGBqqnqgAzBVwUkEri/Jv0IUfVTI=;
        b=IhBspPyHSIvxnq4/9JqpNJgZFOJ6Ct56+Tei0Kl/dUFSZgIP/FkJm8CsxyfmHlcXX1
         CWNQ4yGBLjDPysZBPoTyQBumDqjBEgulzDtRi3QLdyatDUN5WmAcUM30VpkOy/3hy9nb
         mnFtHywe2KK4wQzd8bUaDce5yVETh7gc0DFP9fQUuYznVuB7FN7neNttv4/FhjArTSVT
         c0liMMqR8DELmdP3aU3UtB4PD6lXvf7mGHbB6JMj7H5pLIU2E7Igs4tMJhwOFXIipcT+
         F3smJQDSi33mhDiLII/SD/2fgWLo7TR9+gXI9/OQJAazhK5DMnxZ94ibRH0ENaipumeI
         KEGQ==
X-Gm-Message-State: AC+VfDxc0Hrl12OXrV9esEYwS4Ef3OKt1498IFTw2IQFYCFnHoYFYgNZ
	rUFoS05a2OUUjc2hu2suIF7rkwAxhL7feqMP2oJ/YQ==
X-Google-Smtp-Source: ACHHUZ51NiUed0ZLkDhqn1ZmJ5oE1e7uFRGSgHFEFUkrqlyED+Ammpe100Qh58RvNPIZhbqp/vxG0HDXE4pM9o3WV1w=
X-Received: by 2002:a05:7500:c25b:b0:105:6d34:b729 with SMTP id
 qf27-20020a057500c25b00b001056d34b729mr167534gab.15.1683036245134; Tue, 02
 May 2023 07:04:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAKv4OQ08jfk6r-c0T9U-WtZ6ORt2kbR0ARiH1isav-uFZYoYpQ@mail.gmail.com>
 <e092dba7-5e7d-7306-683c-e9d53228cce0@nvidia.com>
In-Reply-To: <e092dba7-5e7d-7306-683c-e9d53228cce0@nvidia.com>
From: Daniel Smith <dansmith@ds.gy>
Date: Tue, 2 May 2023 10:03:54 -0400
Message-ID: <CAKv4OQ0twOgJ6wfaHD-tPwTNEBwc233H-751Ya2W98qHeNkunw@mail.gmail.com>
Subject: Re: [bug report] Duplicate IDs for nsid 1 on another drive
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230502_150410_215866_B27B5191 
X-CRM114-Status: GOOD (  15.19  )
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

Much appreciated. I created this diff from the latest stable source:

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 7f25c0fe3a0b..be5fa7bae285 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3441,6 +3441,8 @@ static const struct pci_device_id nvme_id_table[] = {
                                NVME_QUIRK_IGNORE_DEV_SUBNQN, },
        { PCI_DEVICE(0x10ec, 0x5763), /* TEAMGROUP T-FORCE CARDEA ZERO
Z330 SSD */
                .driver_data = NVME_QUIRK_BOGUS_NID, },
+       { PCI_DEVICE(0x10ec, 0x5765), /* TEAMGROUP MP33 2TB SSD */
+               .driver_data = NVME_QUIRK_BOGUS_NID, },
        { PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0x0061),
                .driver_data = NVME_QUIRK_DMA_ADDRESS_BITS_48, },
        { PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0x0065),
________________________________
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Sent: Tuesday, May 2, 2023 2:49 AM
To: Daniel Smith <dansmith@ds.gy>; linux-nvme@lists.infradead.org
<linux-nvme@lists.infradead.org>
Subject: Re: [bug report] Duplicate IDs for nsid 1 on another drive

On 5/1/23 21:44, Daniel Smith wrote:
> Hello, I ran into a shoddy manufacturer which duplicates IDs in disks.
> In this case the device is:
>
> VID:DID 10ec:5765 model:TEAM TM8FP6002T firmware:VC2S038D
>
> I was able to set NVME_QUIRK_BOGUS_NID, build, and verify it resolved
> locally, but I'm completely out of my element to submit a proper patch
> for this.
>

if you can share the diff using "git diff" I can help you to get your patch
submitted ...

-ck

