Return-Path: <SRS0=TApw=HT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C135C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Feb 2021 20:24:23 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3C8F64DF3
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Feb 2021 20:24:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3C8F64DF3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=kdW6gTiHb7pPyXBEWLp5zZHpSlV29rqVqApVveV1zOs=; b=yQDvIYWxYWYMJ0n+HQNn3Lkbo
	ELE51DgpW0am2u85Wp3OAfPItEB06P61G79A9hebNoQm4BflhR8r4VK8c4hV3qfUPlfaP2eqaKNBF
	51hHLQjcsi31JSR+Q8fDjrA810Hi31wxMriPDSHQPruFST0KHEJIjlIXT2ErSTbhQZuLdZ5eLAisy
	i3Kj8w4Jd24dgzsVEMz7ic7O2+mM+1MDXA2YPcz4bNyAs32zIR1eGOA3tuxol0Qq7cHxIYub+L0ZV
	M5NpMv9SJN1cs+6cX7H4NbA3gG1nN/Cr+jWVyun7LnQ8536yQXUD5pP+XkbILjplq1sk7BwRUvZbm
	coGnQ6ryw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lCTMR-0000gz-1p; Wed, 17 Feb 2021 20:23:47 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lCTMO-0000g2-7k
 for linux-nvme@lists.infradead.org; Wed, 17 Feb 2021 20:23:45 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5504364DF3;
 Wed, 17 Feb 2021 20:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1613593420;
 bh=uqJt9iQkoEDkdt9aUKxFb3wizNf2dqgiiZWXh4HxI/A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fE3FTPmZIkFZwevn8LK3QDaajmJCsgTPxsyFmCKlJXPSViZEY8VzMzcds6sGKbnz2
 M9MqXK7u/jqQx5sNB9nyB+8QU3gK5UCDNJL9sy/jj/bJbP/uuIk4hOxnYg8wBiE/og
 dJH5HuO+QJJFFHpvstw0TvjAilboJIKpXU+DA3dBLu6mYrpmzP9xW9vgxos9WZAlwx
 fhriXELHDzYJuf6MMAbUD7dTnSftn/LqtLgZ/r+aE38cNrCGLgYi3L/sVHUcIeXUkw
 vP+MrzsxS/osH1OptDXhDoMpePb7UlUF2iRGex3qD0aw5jxuMUKHPKtT8uRS3KuCpE
 4dZAhosqqa0cg==
Date: Thu, 18 Feb 2021 05:23:34 +0900
From: Keith Busch <kbusch@kernel.org>
To: Julian Einwag <jeinwag-nvme@marcapo.com>
Subject: Re: [PATCH] nvme-pci: mark Seagate Nytro XM1440 as
 QUIRK_NO_NS_DESC_LIST.
Message-ID: <20210217202334.GB25688@redsun51.ssa.fujisawa.hgst.com>
References: <38eae52a15c5474dbdf85defcf6a29fa@marcapo.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <38eae52a15c5474dbdf85defcf6a29fa@marcapo.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210217_152344_385008_7613A3BF 
X-CRM114-Status: GOOD (  16.07  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: "'linux-nvme@lists.infradead.org'" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Feb 17, 2021 at 07:33:32AM +0000, Julian Einwag wrote:
> The kernel fails to fully detect these SSDs, only the character devices
> are present:
> 
> [   10.785605] nvme nvme0: pci function 0000:04:00.0
> [   10.876787] nvme nvme1: pci function 0000:81:00.0
> [   13.198614] nvme nvme0: missing or invalid SUBNQN field.
> [   13.198658] nvme nvme1: missing or invalid SUBNQN field.
> [   13.206896] nvme nvme0: Shutdown timeout set to 20 seconds
> [   13.215035] nvme nvme1: Shutdown timeout set to 20 seconds
> [   13.225407] nvme nvme0: 16/0/0 default/read/poll queues
> [   13.233602] nvme nvme1: 16/0/0 default/read/poll queues
> [   13.239627] nvme nvme0: Identify Descriptors failed (8194)
> [   13.246315] nvme nvme1: Identify Descriptors failed (8194)
> 
> Adding the NVME_QUIRK_NO_NS_DESC_LIST fixes this problem.
> 
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=205679
> 
> Signed-off-by: Julian Einwag <jeinwag-nvme@marcapo.com>

Looks fine.

Reviewed-by: Keith Busch <kbusch@kernel.org>

> ---
>  drivers/nvme/host/pci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 0045c5edf629..91cefa40543f 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3233,7 +3233,8 @@ static const struct pci_device_id nvme_id_table[] = {
>         { PCI_DEVICE(0x126f, 0x2263),   /* Silicon Motion unidentified */
>                 .driver_data = NVME_QUIRK_NO_NS_DESC_LIST, },
>         { PCI_DEVICE(0x1bb1, 0x0100),   /* Seagate Nytro Flash Storage */
> -               .driver_data = NVME_QUIRK_DELAY_BEFORE_CHK_RDY, },
> +               .driver_data = NVME_QUIRK_DELAY_BEFORE_CHK_RDY |
> +                               NVME_QUIRK_NO_NS_DESC_LIST, },
>         { PCI_DEVICE(0x1c58, 0x0003),   /* HGST adapter */
>                 .driver_data = NVME_QUIRK_DELAY_BEFORE_CHK_RDY, },
>         { PCI_DEVICE(0x1c58, 0x0023),   /* WDC SN200 adapter */
> -- 
> 2.30.0

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
