Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED8C0CE8D6B
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Nov 2025 00:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bpHc2p8ODNNIK/lF6+XRFVKpyWeb8OJK3ymFZky/zH0=; b=2nE1wZp9cYFoaJN9aTvuQrqdzn
	FosGYKl1+ua2PDsAh7St194ggijGP/bD55q/39IS/czlAjYADKJRbGgskojVNcRLSJMZf908rgL4i
	k6vLy4Q0XJjHCkshdvM7uLuY6tUOFXMZL37yRVyv5pCVUnzGYXBhHSdefrbdwx/ZDEmuJzpoFADJf
	XFgdyN8/FmrUBFNOKyPkWUrugHY+OAcunHE+NCHf8x4GwTCO6acrNcd+vj5ZQeE9pFU1S3EAvLGI4
	pdu+oz39X0yrON76BjY6Gw8iPutO9pH7LX964O1G0q7wW6qclS5XmqBBd9eQsTdXT4ZoDH1l7EnMM
	iDQhiILw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vL9my-0000000H3BD-3M0V;
	Tue, 18 Nov 2025 00:41:44 +0000
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vL9mw-0000000H3Ab-1Gjw
	for linux-nvme@lists.infradead.org;
	Tue, 18 Nov 2025 00:41:43 +0000
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-297d4ac44fbso43818755ad.0
        for <linux-nvme@lists.infradead.org>; Mon, 17 Nov 2025 16:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763426501; x=1764031301; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bpHc2p8ODNNIK/lF6+XRFVKpyWeb8OJK3ymFZky/zH0=;
        b=PVxYbcTCmSlAMCI3n5n7+KyuLDe8qsg+rDuWB3QAF3wpAddIWrVEpZcd/cT1kmgXes
         e8rnGFLr08/UIr2H66PDlBJKgJh0+LwtampgVr06LKMrUTyPVIk6VNzXEOn3CVW8V7rz
         JF0y89u48vf+WpVZAiCmNN0KOkLnEwKRb/p7IJW8eZmp9Yw1/TmfOtm+u7AQigfbir6E
         CnNLJtVFZ12ClZPDtLax6of6eg8oiBZ7YSgAixoFDAnZhY0ZjelSpMYnv+SliPCzOC8K
         v32fCFSOyxq01iwTDyNoyoR67zAPhgF8vAny1UY6SoRQ7yE/aAlYe8eOxLy1moSsBo83
         TiQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763426501; x=1764031301;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bpHc2p8ODNNIK/lF6+XRFVKpyWeb8OJK3ymFZky/zH0=;
        b=Wzaj+f0fajfooODbEXOz/xGR2i7EOIu7pmN6gscYPAePrLf8hoRhI0l/Ryka4GCJmS
         DKUZBHmITKpSYlrPQ0KviFFSZ8MXQdBluW71GxvlZLjzCVSOmkKrm1cIiQK7l+FuBe9e
         FwcFKSyFz5tVd+hyARdwhZsbJdPEZPySueG9knzE2+v2n8G2cDP48b+v0cy4otjJ3JI8
         RYJ18HegC/ElFKI7747vP2EBs6v8mQAkqOcj91nBH9AnAqihnhYMsmJPPvL32ykhwQ+r
         fPCUXxuGNRm4vCj/wgHWt+ihSvKZ1EhWJba3sYvoMBQfceKg4D96hEkVbFmTd0ja942e
         wtHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUq6HxlTzgUkJwiwlMugBUdIizyszQsmQG4RN6KSHI7w4ZnzZozlaNLu12u/BZKLecwtqKLw6agtJAf@lists.infradead.org
X-Gm-Message-State: AOJu0Yy3P8ROWwi2VgSb9pLVKVYYna/7mgimSfQHP795P6QfZZIBLlsb
	AWpD+BGJjjwm6gw25sIA7drA10iSALtB3Arg52uVAaMzJb9m7wlLLwWucT8PloeY
X-Gm-Gg: ASbGncuD1HWhrc/XpQ6CjYHW9MCFDUGLGMdbiKmNjB9cN70KkXY1Toe/S2JgKSwqC/M
	1XPry3CnSas+wDaZI+I5zLfbSyw2jOx2LwsHvk0ifI38Hj+Hr/xRqntw1q7eU4Xz5zCyx6yodIa
	f8TnJOldpcesNGx/BCBKfeJjcZse+oRGTN629PsIFNdSHFIM8REDHE0sZohtGa0duXt4hasy/d5
	cxrqZ7MedUYzakhRohuI6R2jWB/GF4nYk6+FoPKF7wqm8fHI69s0nMUXVTWW/oclFn1BFq4Noyk
	TdRcOBtNoOtlltwgQMvB6weCCLg56eJcXzKxxPEgMF/BAArs+WMlWUGIdnueMdcArVlLH70oPxR
	kTpYrmBY85yAh1Kx/EVE63uvNmE+Pw6qy/uJFyAWMPgQ1FlE6M+aGtTFV7FL9p+JQg23dD3AQh8
	h5Uf/ZlJpMRZ4m2tNa
X-Google-Smtp-Source: AGHT+IEhFOKmc58ohvnpobB7KIG0elSsabMrwKXRwmi86n4DPe+i6UIYR5HA8VZ2wYsVPqZV67uguw==
X-Received: by 2002:a17:90b:1b49:b0:343:a298:90ac with SMTP id 98e67ed59e1d1-345aea647d1mr1558664a91.0.1763426501585;
        Mon, 17 Nov 2025 16:41:41 -0800 (PST)
Received: from [192.168.0.233] ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc375081bf8sm13401253a12.24.2025.11.17.16.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 16:41:40 -0800 (PST)
Message-ID: <7a0343ee69331f1ade97b909cfd13a1ff04a09ae.camel@gmail.com>
Subject: Re: [PATCH v3 3/4] nvme: Expose the tls_configured sysfs for secure
 concat connections
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: alistair23@gmail.com, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, 
	sagi@grimberg.me, hare@suse.de, kch@nvidia.com,
 linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Alistair Francis <alistair.francis@wdc.com>
Date: Tue, 18 Nov 2025 10:41:35 +1000
In-Reply-To: <20251114045850.1898865-4-alistair.francis@wdc.com>
References: <20251114045850.1898865-1-alistair.francis@wdc.com>
	 <20251114045850.1898865-4-alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251117_164142_340252_FB691E00 
X-CRM114-Status: GOOD (  13.45  )
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

On Fri, 2025-11-14 at 14:58 +1000, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
>=20
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
> v3:
> =C2=A0- No change
> v2:
> =C2=A0- New patch
>=20
> =C2=A0drivers/nvme/host/sysfs.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> index 29430949ce2f..6d10e12136d0 100644
> --- a/drivers/nvme/host/sysfs.c
> +++ b/drivers/nvme/host/sysfs.c
> @@ -838,7 +838,7 @@ static umode_t nvme_tls_attrs_are_visible(struct
> kobject *kobj,
> =C2=A0	=C2=A0=C2=A0=C2=A0 !ctrl->opts->tls && !ctrl->opts->concat)
> =C2=A0		return 0;
> =C2=A0	if (a =3D=3D &dev_attr_tls_configured_key.attr &&
> -	=C2=A0=C2=A0=C2=A0 (!ctrl->opts->tls_key || ctrl->opts->concat))
> +	=C2=A0=C2=A0=C2=A0 !ctrl->opts->concat)
> =C2=A0		return 0;
> =C2=A0	if (a =3D=3D &dev_attr_tls_keyring.attr &&
> =C2=A0	=C2=A0=C2=A0=C2=A0 !ctrl->opts->keyring)
Reviewed-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>

Wilfred

