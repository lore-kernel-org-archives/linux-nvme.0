Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4B40CA1005
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Sep 2025 19:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=keYWhxw77DCnP4ATStvL7xyBqHqD8YMxeUpPHYlowhs=; b=VR9OiO42FKXC2qRmTm0tVuq/GA
	wU3ojpufrkYzyzxhZuolb4sXt2B9ttW+yWN1tz3uAyaK1eWGt4aKz182mum6ytRNxBeuQ+5IdaZgF
	ymiAWccHKoWxBNJqM3ZcC1egLTGzWHYUNy+yMUPmv+7JwBxBssBSOVGotKOnaw2WDhbqzv7lIj7RH
	h2GDTC5nSYmVriJ0eJVSTarMOiGsL+YiD+hCo9fhjkvSM3IBCBHMiKLw3k4LZfQVdbiQsvQ0bmxUp
	HlJg9sbHOMiHCIoNVlh/lVFJRWxdmynJiCuo2MtPQZnZhEKv50Ayb7LYwp2WokikhMJmqpSJDRsdx
	iHKGe/GQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utWPE-00000001bk0-2bml;
	Tue, 02 Sep 2025 19:11:00 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utQzK-000000001PC-2zfz
	for linux-nvme@lists.infradead.org;
	Tue, 02 Sep 2025 13:23:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756819432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=keYWhxw77DCnP4ATStvL7xyBqHqD8YMxeUpPHYlowhs=;
	b=Wrkg104VJl1qtiT+O1lVJMa91DM2jvMjE7frDsiVYNv4XWncpmQCZa7eAly0UTm9FRtCj2
	MY6CH2OSzya1rQOcGY3iHhZkwWrQ5uIBHMIGChTAsV+oNcIOP0J+GXq6IalZFMCsaNlDxR
	BSesQzQwHquSLFvdHlz5EVBBBXEIp+A=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-E7FQj8C2OzWvGsr_UUb80g-1; Tue, 02 Sep 2025 09:23:50 -0400
X-MC-Unique: E7FQj8C2OzWvGsr_UUb80g-1
X-Mimecast-MFC-AGG-ID: E7FQj8C2OzWvGsr_UUb80g_1756819429
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-337e4d53fdbso7460001fa.2
        for <linux-nvme@lists.infradead.org>; Tue, 02 Sep 2025 06:23:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756819429; x=1757424229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=keYWhxw77DCnP4ATStvL7xyBqHqD8YMxeUpPHYlowhs=;
        b=Q5XJ3QuvZoPb29Xouc189v/InEbAzp5Dd+T0hAzy1Qged0UcaKD3spEIGwiXzJAGJv
         b6yxxNgb/yIksZWd78uLlZ+LYBYDWbn/iVFYuUNuH/DW5/6bwLDdknZ2/yTqqIuXJmjw
         aK6HDc7jxKS98Q5iz8exIqlkIvF/tk5Q387SzUevx1PW1BwzUPGJynGc8OKEkBtj3zWl
         BkM8W+pjQ5eDaIXr0SSkZeTzSgFNM7oBkOM3uLLs8pp6s8MLeQwnTZwUTdL9u6VeUKPz
         lJGyKVK2x4EvG9DK3ax8lTUIuSS0Q4PAfLN8E53biWy6FqHvhIdn6fPixiJrJ6CEmuLR
         kWfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUdR16c8joKbH6lilVAXSr3+jZowp6EIHYadteRl3Z47lql+PCv30RQ5i9mBCy2KLgHT1H45/ZNVvq@lists.infradead.org
X-Gm-Message-State: AOJu0YwpTYVquFe2e3q3cHVbtyFSKVqIY84EO2ehpFbbquuaiLalpbr5
	BC8yibfC8du0tunFiefIEj+53vp0D0Ym47zoxmk+msf6yPMmQGqitrqizdLF0kqZnAgb0rBTRDo
	0OZl7Eks6OekB0YYj7oQnnE5CZd7QsZ+AlCnTw6IkTCUn0+A/Lmy3GEL8sISnVijQ4WFYLSrVil
	ffyNYvKz/Ncu8Lbp6VoEYFE6yEkhya62MHIhws9tMMo1U=
X-Gm-Gg: ASbGncvrkR98+cKCrW6pIBmsqMyJQx7B09M79bWCQ78VfRkpCN3+V2SBy+q17OuXGxp
	tJ951HuK0ry5Mv98h0xjTojbbrSAKM/k4QcSiu5zmEdBlUAx+69prfq3shnQJn+1m85t0hyslk8
	yZexjneW6oSJOCOwpD3gZBwg==
X-Received: by 2002:a2e:bea4:0:b0:333:fff0:7d21 with SMTP id 38308e7fff4ca-336ca95a342mr33887681fa.10.1756819427050;
        Tue, 02 Sep 2025 06:23:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcT7cPp+UnG7lIIOV9SxTwhQbXg1xHDcH9jqEMVEqMlEpkDwbCfgUCeDPbwb5bGfUErqCVNlbgtYOIHwmTOzo=
X-Received: by 2002:a2e:bea4:0:b0:333:fff0:7d21 with SMTP id
 38308e7fff4ca-336ca95a342mr33887401fa.10.1756819425084; Tue, 02 Sep 2025
 06:23:45 -0700 (PDT)
MIME-Version: 1.0
References: <20250901-nvme-fc-fix-leaks-v1-1-3ae0aa88d5e5@kernel.org>
In-Reply-To: <20250901-nvme-fc-fix-leaks-v1-1-3ae0aa88d5e5@kernel.org>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Tue, 2 Sep 2025 21:23:32 +0800
X-Gm-Features: Ac12FXzr_vFxaGgXnCYVDwNxKYkvmNxqEe2JJkAWFfqshFoTKnLq5QQfPxa6IvI
Message-ID: <CAHj4cs-7v_=LD5oKSGimH1_vKp0T5tmemqsMoAw+ZZGTMP9k9g@mail.gmail.com>
Subject: Re: [PATCH] nvmet-fcloop: call done callback even when remote port is gone
To: Daniel Wagner <wagi@kernel.org>
Cc: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8DAskiY--zPnRHg_NWGzlFuWcFYCDcJnnj3YpC4ECK4_1756819429
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250902_062354_827120_2A62B10B 
X-CRM114-Status: GOOD (  26.11  )
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

On Mon, Sep 1, 2025 at 11:58=E2=80=AFPM Daniel Wagner <wagi@kernel.org> wro=
te:
>
> When the target port is gone, it's not possible to access any of the
> request resources. The function should just silently drop the response.
> The comment is misleading in this regard.
>
> Though it's still necessary to call the driver via the ->done callback
> so the driver is able to release all resources.
>
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Closes: https://lore.kernel.org/all/CAHj4cs-OBA0WMt5f7R0dz+rR4HcEz19YLhny=
Gsj-MRV3jWDsPg@mail.gmail.com/
> Fixes: 84eedced1c5b ("nvmet-fcloop: drop response if targetport is gone")
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>  drivers/nvme/target/fcloop.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>

Verified the kmemleak issue fixed with this patch:

Tested-by: Yi Zhang <yi.zhang@redhat.com>

> diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
> index 257b497d515a892a39da82d2f96b3fa3c6e10cdd..5dffcc5becae86c79ef75a123=
647566b2dfc21f6 100644
> --- a/drivers/nvme/target/fcloop.c
> +++ b/drivers/nvme/target/fcloop.c
> @@ -496,13 +496,15 @@ fcloop_t2h_xmt_ls_rsp(struct nvme_fc_local_port *lo=
calport,
>         if (!targetport) {
>                 /*
>                  * The target port is gone. The target doesn't expect any
> -                * response anymore and the ->done call is not valid
> -                * because the resources have been freed by
> -                * nvmet_fc_free_pending_reqs.
> +                * response anymore and thus lsreq can't be accessed anym=
ore.
>                  *
>                  * We end up here from delete association exchange:
>                  * nvmet_fc_xmt_disconnect_assoc sends an async request.
> +                *
> +                * Return success because this is what LLDDs do; silently
> +                * drop the response.
>                  */
> +               lsrsp->done(lsrsp);
>                 kmem_cache_free(lsreq_cache, tls_req);
>                 return 0;
>         }
>
> ---
> base-commit: b320789d6883cc00ac78ce83bccbfe7ed58afcf0
> change-id: 20250901-nvme-fc-fix-leaks-4a25ca3875ab
>
> Best regards,
> --
> Daniel Wagner <wagi@kernel.org>
>


--=20
Best Regards,
  Yi Zhang


