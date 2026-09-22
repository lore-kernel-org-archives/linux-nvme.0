Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 351CCC982FE
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Sep 2026 06:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k6ZrA+9QVdzReIQQVq0tjFXt64yIhgrf6yRyPH022w8=; b=chH/GPx11dvxCz/iXaFU1XTfGp
	QG2n0OiLtXdBCap1anJgcQ8tNwXfeyyrJ+S8r6nErsBurSFfGwT01xoJHgN1pV2j3xZJImNjsv0+e
	J84bvs3MS37e2XMlco+O6GUpbo1Vch6SaxyIG8lvQxElizh+vZG5MbFNcG+q3+9rzob2DIuoBH8c9
	GRx4I4RNtC+0CW8j5NLtxXuuZhXW1UGWAdVszWWMLSBvXs1dnfL/I3JLL15Y7TitrWvYeEPnAHtz0
	Y1QmiVYFm5m/zOfhjFJp0b5+8kamoNAQ7R64EujzLFls3TkDdMCOePJJo1jVIAUPWyPshCWKzeUA9
	j+JG2EPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8tus-00000004KgX-2ja6;
	Tue, 22 Sep 2026 06:23:46 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8tup-00000004Kfr-0aSi
	for linux-nvme@lists.infradead.org;
	Tue, 22 Sep 2026 06:23:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=mail1; bh=+W/+qy8dN82JRq
	L2/6riw5tyqhHG1BqM+2TpCeDV620=; h=in-reply-to:references:to:from:
	subject:cc:date; d=arkamax.eu; b=Jh8Br0IKuk5d+X6eCud/s7LhzjRuiOfJ1N8Fp
	3GdorYx2rTlmic/RripSkWlJABBfA8zvv67X8tDbs06ESw5U9TML32h1+XWbV9hK9yB+4g
	7ZnA8AM9pzX/VtnhAn4j0748vgpsStDH1R2+cuoARNGrjthF6XSUljQHhTUldVVAiTCqeg
	N9gZXss/PN2DW+iEcg2ZgiT8M+2UFy5dv16eiDFZZXuAz7SVVcPtPf7rmLWC9D147sdTmO
	jU2wbS2npFhontgZZjVriDMCCZsq8GJM9+1hcZ4psMN3v2C0BmlUWa5MRbPadkfVXq13iZ
	bnjBlqePZqHu4sZVVs+6iicuw==
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id 8e6623e2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 22 Sep 2026 08:23:36 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 22 Sep 2026 08:23:36 +0200
Message-Id: <DLLMOFXNSI43.22DN54SMA5U6L@arkamax.eu>
Cc: <sagi@grimberg.me>, <kch@nvidia.com>, <linux-nvme@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <mlombard@arkamax.eu>
Subject: Re: [PATCH] nvmet-tcp: fix stale comment on NVMET_TCP_MAXH2CDATA
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Ing. Alfonso Kuen Arroyo" <gerencia@idkmanager.com>, "Christoph
 Hellwig" <hch@lst.de>
X-Mailer: aerc 0.22.0
References: <20260921065448.GA13764@lst.de>
 <178999815960.27132.5021907314171265355@idkmanager.com>
In-Reply-To: <178999815960.27132.5021907314171265355@idkmanager.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260921_232343_815266_8D5625DD 
X-CRM114-Status: GOOD (  15.86  )
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

On Mon Sep 21, 2026 at 3:42 PM CEST, Ing. Alfonso Kuen Arroyo wrote:
> On Sun Sep 20, 2026, Christoph Hellwig wrote:
>> Maybe use SZ_4M instead of having a value and a comment that can get
>> out of sync?
>
> Good call - that also gets rid of the case Maurizio flagged (a value and
> a human-maintained comment that describe the same number and can drift
> independently). v2 below; the file doesn't pull in linux/sizes.h yet
> (checked, no other SZ_ user in it), so it needs the include.
>
> Signed-off-by: Alfonso Kuen
> ---
>  drivers/nvme/target/tcp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -18,12 +18,13 @@
>  #include <net/handshake.h>
>  #include <linux/inet.h>
>  #include <linux/llist.h>
> +#include <linux/sizes.h>
>  #include <trace/events/sock.h>
>
>  #include "nvmet.h"
>
>  #define NVMET_TCP_DEF_INLINE_DATA_SIZE	(4 * PAGE_SIZE)
> -#define NVMET_TCP_MAXH2CDATA		0x400000 /* 16M arbitrary limit */
> +#define NVMET_TCP_MAXH2CDATA		SZ_4M
>  #define NVMET_TCP_BACKLOG 128
>
>  static int param_store_val(const char *str, int *val, int min, int max)
> --


Looks good to me, but you should formally submit it with subject "PATCH V2"
and proper commit message.

Maurizio


