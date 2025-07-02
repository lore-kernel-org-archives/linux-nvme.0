Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F27DC77B7C
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Jul 2025 18:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Date:Cc:To:From:Subject:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dF1EXAIq4wk1M3/9HbP1JUeR1sLlcJURpHYduXCz2Hg=; b=vNfWx8uGtHJKBwkWW6dUd+REgy
	xwFctbj0GCep59VmbYU8nK2tAzDD3lRgxHyK+EzwzK63vCA5iT6eyEmY8hqnIQ2RMSOINC32PSQow
	CDMINlMyrbwJRNL+lj86kLODMIS6cW3dwMUmmmrKR1jueoRR20ODSu7cW+aZizYTvBpK3SjCmcg3i
	JXjPzhw7fU1fcE9FJT+ap/uZusUEwnoV8XxAu7vCLjxkx91k3mSCqtEQgX3gk09DmRmu/Oel7pey/
	0//SJLkNli3X03/Qw2K04ouLELQTsEivSUKCmXe808sXizt2PkeFiceliA/LIVVp6OsGBqn0srANO
	kexCuQvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uX25k-00000009Fg5-32PV;
	Wed, 02 Jul 2025 18:21:56 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uX220-00000009FHK-1DCa
	for linux-nvme@lists.infradead.org;
	Wed, 02 Jul 2025 18:18:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751480281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dF1EXAIq4wk1M3/9HbP1JUeR1sLlcJURpHYduXCz2Hg=;
	b=WAilTkbbwtK/dJyOuhfMWkHaQ6IX9KwAVOeYHEv2ADee1DwI5pdJcr4ycpmfS25UWeKwjn
	Jf7m6YOJxJYi0abQ/tw6OaQC9On5gd2nsg3zCgygnSX7GBjOoI4vEuhbe9vjdfHzCfP0Rn
	cX4Py/VIC3DjaC9DcDftRAUUApxmDrw=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-7i49KsRINqiq8cse3dlUjA-1; Wed, 02 Jul 2025 14:18:00 -0400
X-MC-Unique: 7i49KsRINqiq8cse3dlUjA-1
X-Mimecast-MFC-AGG-ID: 7i49KsRINqiq8cse3dlUjA_1751480280
Received: by mail-yb1-f198.google.com with SMTP id 3f1490d57ef6-e87a485af5dso5803682276.3
        for <linux-nvme@lists.infradead.org>; Wed, 02 Jul 2025 11:18:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751480279; x=1752085079;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SXem2kP0QB8Oo7KcBzHOvp791dBRTASWSc/+/nAB7Jw=;
        b=uyuBjiEDCJLffMeAQwM9bBZpcwaINFJH8hOwArfsMDbGHrGY5TXWh/qkPMS/CarScA
         rbOP4MAyAwZbRBSGWPjSjlC4RowcMUMxIFxpwrZbXG6CgdnC4Z4JChLGa5cJfd50YcFC
         RjnT3737pCZGD3qq6mWDa+DD0gD+VPMkeMF352DWmB3PpWoJxCdCYsLfy1W8JzN8er4w
         18qSeCLktcNNGDYGMJ1vjccYSYtLxOjrnD+0DKvLjDr88KOHr3YhryQIYAqTSMmHmmBF
         xpyXDAWWbEDa+9jDgGZcjeKg7pI7g0a71VMz+1wDSN/yPNfoQRv5HEr3J+PWJx9lvKda
         dWYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWF3ubMZLZEgXR7CEP9xuiasJzGgg2PNcoXS2QEft1yQkQZuz7NGzk/G5rPQlyjxFYExsEPOB4DYSV+@lists.infradead.org
X-Gm-Message-State: AOJu0YxPsF7F9imDuAKk8mqqk9hTcZmU6dDH4Awbr8ZOSXiqWWSRDhf2
	qHSi3zqpPGype4TqqwshwxNjeGsUmnsB5ZWvZlMWCkZKOrzT90gcpwHa1JJc7Jsg6QweYkMMaoL
	VZ1Fp/l6VVyjTY+yiq8BVMwHTe59sSlpLEExMBTKfsPqCvXmT7uLHMkZnFAfTbWBlWyW3
X-Gm-Gg: ASbGncuMfkw+5vqGcDnKN43o/iigi9W6n8r3ICOpR+EXiAOk+nRYP9TnbWL7Z089m0c
	5BhkZpavK62QxYkk71p/ml/R1zAwa788w2b8QkokMuY6uzTrz3iLWcRq1VdPAl3xmMeYfOLYx2s
	erYtyb4FwL0SaqMCQIiMtfm/quDIX+33WNpHJLUw20/X7lyG7ZYYP+IHDRzwX+oCSYbzYkaFRYZ
	JUJN+0t5PMC9FKh+UVVcUYMYLeSN244YlP4I1wCOMKymC2vpnFYpeL5Y/bpt/jkkSeitML/qR33
	Ue22oXykWuujWuIr6gppA0Uqwfq3h/oFkVGQINgVMGh4H444h9IIXvVeW1fEHq3bKqhGDeRo
X-Received: by 2002:a05:6902:1448:b0:e84:1af0:96b7 with SMTP id 3f1490d57ef6-e897e242b8cmr4623657276.48.1751480279393;
        Wed, 02 Jul 2025 11:17:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFn2eMSAlG5ExF5OxJxXYxgtPZmuAwENb/PmKQ48IpuFptAJdpS7CueQrv3zuDbqD4iJsL8jw==
X-Received: by 2002:a05:6902:1448:b0:e84:1af0:96b7 with SMTP id 3f1490d57ef6-e897e242b8cmr4623624276.48.1751480279035;
        Wed, 02 Jul 2025 11:17:59 -0700 (PDT)
Received: from ?IPv6:2600:6c64:4e7f:603b:fc4d:8b7c:e90c:601a? ([2600:6c64:4e7f:603b:fc4d:8b7c:e90c:601a])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e87a6b65aeasm3786007276.19.2025.07.02.11.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 11:17:58 -0700 (PDT)
Message-ID: <b30c3f7ff8082bfa9ff2ed2c65c4ed40c93933db.camel@redhat.com>
Subject: Re: [PATCH V2] nvme-tcp: log TLS handshake failures at error level
From: Laurence Oberman <loberman@redhat.com>
To: Maurizio Lombardi <mlombard@redhat.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, hare@suse.de, 
	mlombard@bsdbackstore.eu
Date: Wed, 02 Jul 2025 14:17:57 -0400
In-Reply-To: <20250702140629.70378-1-mlombard@redhat.com>
References: <20250702140629.70378-1-mlombard@redhat.com>
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1I4wdZf1HkL0myCnd7apxic8QOIwSqIqMAP5_omEGJE_1751480280
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250702_111804_471454_B6893D1D 
X-CRM114-Status: GOOD (  15.69  )
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

On Wed, 2025-07-02 at 16:06 +0200, Maurizio Lombardi wrote:
> Update the nvme_tcp_start_tls() function to use dev_err()
> instead of dev_dbg() when a TLS error is detected.
> This ensures that handshake failures are visible by default,
> aiding in debugging.
>=20
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
> ---
>=20
> =C2=A0v2: Hans suggests to print a dev_dbg() message
> =C2=A0=C2=A0=C2=A0=C2=A0 if handshake is succesfull
>=20
> =C2=A0drivers/nvme/host/tcp.c | 11 ++++++++---
> =C2=A01 file changed, 8 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index d924008c3949..9233f088fac8 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1745,9 +1745,14 @@ static int nvme_tcp_start_tls(struct nvme_ctrl
> *nctrl,
> =C2=A0=09=09=09qid, ret);
> =C2=A0=09=09tls_handshake_cancel(queue->sock->sk);
> =C2=A0=09} else {
> -=09=09dev_dbg(nctrl->device,
> -=09=09=09"queue %d: TLS handshake complete, error
> %d\n",
> -=09=09=09qid, queue->tls_err);
> +=09=09if (queue->tls_err) {
> +=09=09=09dev_err(nctrl->device,
> +=09=09=09=09"queue %d: TLS handshake complete,
> error %d\n",
> +=09=09=09=09qid, queue->tls_err);
> +=09=09} else {
> +=09=09=09dev_dbg(nctrl->device,
> +=09=09=09=09"queue %d: TLS handshake
> complete\n", qid);
> +=09=09}
> =C2=A0=09=09ret =3D queue->tls_err;
> =C2=A0=09}
> =C2=A0=09return ret;

V2 Looks good to me
If you need another review here it is

Reviewed-by: Laurence Oberman <loberman@redhat.com>


