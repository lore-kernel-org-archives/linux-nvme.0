Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ECD4C7EE2A
	for <linux-nvme@archiver.kernel.org>; Wed, 17 May 2023 22:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6gy42kMEpnEV8zP9ru9KAsS6ZKRGA1EFjENI2uiPl7c=; b=bTEzuO4Rj7yheBCFIl0pXBM/xh
	ZV1ry81dQYfi6XXqhmFCWtPm3YvXIfy4glj6JVjQDOTyFhe0NRBjoh5QCTzh54gmpfVfMoXUaazSI
	GiRbPuLE2vef3Mb4f5depZ3PnJ1y8f3fkx/S9l2VQnpPG/DuQhKBAi+isGCzmlaeRQBLjbKJF4rhI
	xJn1b8pBb0sZX1R+jbM7ltAfAGcmRHKADhGRO1wDP5UtJJzU5giz3boKwjVzdUygGZZ2unMTPBA5M
	eWNsW3Up1VZ9pQ2fyiIZ/JxYtHN4R4xJa6FPO6QAOdlCAo0FZVGSsKvygcMytIXoVE9AhSRto2ifd
	1FNYI6UQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pzPWv-00BD2z-1O;
	Wed, 17 May 2023 22:21:57 +0000
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pzPWs-00BD2Z-0N
	for linux-nvme@lists.infradead.org;
	Wed, 17 May 2023 22:21:56 +0000
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-561bd0d31c1so11755537b3.0
        for <linux-nvme@lists.infradead.org>; Wed, 17 May 2023 15:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ds-gy.20221208.gappssmtp.com; s=20221208; t=1684362112; x=1686954112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6gy42kMEpnEV8zP9ru9KAsS6ZKRGA1EFjENI2uiPl7c=;
        b=Ao+DzxKbObl9GeaTUtQfxmKHySxrQOT01Zs3X4ICTWA0hEk7NQOikIpvnkaPV/IVmU
         0Y0irZrmZnF6y18tNHcCahJjXKD1HAunmx2lr9OtNnJUbqtIFuRnty3fto/JQY8vVXQk
         ADjkoB98+7QAIFLm0lrbHwh8dpLEMEj/ul/BfeitNBTU1IhwHZPPoeTC5YsnCme+Yqkb
         5ldDMXO6ofzJ+l6oNS/qVODL6m2zC2ttTAbc3YvSO276JF7hwNlc3pSGPcwUTx8+3Sji
         ACiUh2wfs6IoPN2Nam/1beQLcGSSBR77OveVrqZEPIfpxTDMAETBrdM2UdbZd+5+P8WF
         ByEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684362112; x=1686954112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6gy42kMEpnEV8zP9ru9KAsS6ZKRGA1EFjENI2uiPl7c=;
        b=E+XLmGWxBNXPnBp040dSaWkne6HaLLMBGlNhRQsJTbROWu+ZnGA5BT7ZaYqqFkGMnR
         N/TuIZUUWEVPGnG5uOFvnyxH+ZSIvf81rkwXhl+O2ArilcGUQRE5f1NnolAREOPyhG2S
         vtOfHdMIaTLAQRIhjrXAAEl9HtN049ipim7n5X6hrJZp6s56yvyZN+duysj+LqIOVnqJ
         3ZwQ0zYI6bWq1dEV7wEh1FsmmWpYCTHmLqpejv8XU79ko4sQMU2dfv5o016v7dF1jieH
         2VkxP3HEhv2NTld2YL/5KhAf/5J1QKcxaglmllXUlD1ZrI3XIqKZCU1HD5byPoSpWH2w
         yeQg==
X-Gm-Message-State: AC+VfDwCmItIZUVyutCDc9BvB1Uqlfw2J44183tcOl6/6azo3cPw1Rl/
	PMiv0TS+JnZwqXp6+Rp43B3nsZn21qeQ/7yzMeYfSA==
X-Google-Smtp-Source: ACHHUZ7xYLkc7TUeOEaeATq7diN4cVWSTQt/+LqjjCFv+j+onVdoyLCLfVq0ZoJRt3qvu7NHfCLYBamlxWeBr7SXhPw=
X-Received: by 2002:a0d:ebc8:0:b0:561:b5b4:ce58 with SMTP id
 u191-20020a0debc8000000b00561b5b4ce58mr3347355ywe.38.1684362112279; Wed, 17
 May 2023 15:21:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230517213232.4977-1-kch@nvidia.com>
In-Reply-To: <20230517213232.4977-1-kch@nvidia.com>
From: Daniel Smith <dansmith@ds.gy>
Date: Wed, 17 May 2023 18:21:41 -0400
Message-ID: <CAKv4OQ2VZSEdK90VqaV_EMd3TXZzr72gD+_gVm6YWisGZsmGvQ@mail.gmail.com>
Subject: Re: [PATCH V2] nvme-pci: Add quirk for Teamgroup MP33 SSD
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de, 
	sagi@grimberg.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230517_152154_392349_3236655F 
X-CRM114-Status: GOOD (  19.97  )
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

On Wed, May 17, 2023 at 5:32=E2=80=AFPM Chaitanya Kulkarni <kch@nvidia.com>=
 wrote:
>
> From: Daniel Smith <dansmith@ds.gy>
>
> Add a quirk for Teamgroup MP33 that reports duplicate ids for disk.
>
> Signed-off-by: Daniel Smith <dansmith@ds.gy>
> [kch: patch formatting]
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
> Hi Daniel,
>
> Can you please make sure this patch works as expected on nvme-6.5 ?
>
> I believe you already have the git repo link, above is the right branch.
>
> -ck
> V2: add original author.
>
>  drivers/nvme/host/pci.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index b027e5e3f4ac..b36c12238f1d 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3440,6 +3440,8 @@ static const struct pci_device_id nvme_id_table[] =
=3D {
>                                 NVME_QUIRK_IGNORE_DEV_SUBNQN, },
>         { PCI_DEVICE(0x10ec, 0x5763), /* TEAMGROUP T-FORCE CARDEA ZERO Z3=
30 SSD */
>                 .driver_data =3D NVME_QUIRK_BOGUS_NID, },
> +       { PCI_DEVICE(0x10ec, 0x5765), /* TEAMGROUP MP33 2TB SSD */
> +               .driver_data =3D NVME_QUIRK_BOGUS_NID, },
>         { PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0x0061),
>                 .driver_data =3D NVME_QUIRK_DMA_ADDRESS_BITS_48, },
>         { PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0x0065),
> --
> 2.40.0

tested-by: Daniel Smith <dansmith@ds.gy>

