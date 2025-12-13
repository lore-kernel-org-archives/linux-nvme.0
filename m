Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2154ED59D99
	for <linux-nvme@archiver.kernel.org>; Sat, 13 Dec 2025 03:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RVirYJs36pEisWr0xabkqAapKQWYDBIRC38oiXekHdM=; b=jxHbIzPkqy0d2Zi7Kyji8LQKZ3
	SBDSBBqpFskbDxAsa8gYFOUykyKoQpNfF9wUJcstKe9ZlpRO7hy2ZlfWVbbOTlsIJJyqP/zlDBqfV
	tDmYZbyyd/Zj+LQB9yMUo6b5xpx1K7Ge1Zku6puD3PRlM7CXWOo3+xv4NeOw8C5gGKIR17irZRa3c
	3cB5TEP/XWD7bBnJIFs51dBlXg2EW+7RAZwBKBh+w+XK1scHofhKWyP/PpHOJlg7nxH6xOsi9Bx4b
	jalLgnn91ht6TheQciX6/EaREWpuuuoeWv8nXiKRtboap2K7AAGkjQifQZQtaAmMyUIXFEhUiM0S8
	Fdysbssw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vUGNs-00000001NBH-48Dm;
	Sat, 13 Dec 2025 03:33:28 +0000
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vUGNl-00000001NAu-0pJe
	for linux-nvme@lists.infradead.org;
	Sat, 13 Dec 2025 03:33:22 +0000
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-2984dfae043so18066405ad.0
        for <linux-nvme@lists.infradead.org>; Fri, 12 Dec 2025 19:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765596800; x=1766201600; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RVirYJs36pEisWr0xabkqAapKQWYDBIRC38oiXekHdM=;
        b=ChfQjc4jB6TLUQ8RMRiktTD2MEC9cesjngOVadSx61HBrt4UfKx7U5aMRy7Kxwu/wV
         oXy8ivK6/4ru9srAdeenZZDikX52rImoL0led4Dmj6dxiCjOlNMJtol4nWowdq/jHKS6
         IOI5tYrTzuODDG3uYodiThT1Rf5wdBD3hLnOFeom/sJEtCzdCyRvKKrQVwretwtNWKW8
         T8dxA34ucK0wnFr0XaXDuvZsK4bPQ4L52o7lfb/cM6O8s5NL5868wsGn5rNKXFG+474a
         tFXw54YWqfwoMum/ImTh0Ktwecrlz9ILPzV9HKyLFmTg8zVmSMARdKUUCr198CdJ03Z+
         B21g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765596800; x=1766201600;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RVirYJs36pEisWr0xabkqAapKQWYDBIRC38oiXekHdM=;
        b=Ch8MIaxyg5KTJsYqO0zzCOBWK/NlM58Jse0Qs/5VauttX1hrhB7U1SqcXU29XiDhB6
         QN7QaPV78dZZtmqGXxfofrLiR7cwCWr4yQNmHETCjsAPk92h3oo8G+1V6MN5Yz5FqazJ
         ZBsC75Z3NmdQvhhJWm03zqoQbiJQC1Fa3JiFB//l03wqHVigXe22q5+mehu/STHrBCqH
         hFWqthLbbDmZ+F3ePT18s/xK1aHNb1LVWBAcyfTWl87LhioXOygoH1ETQx5wpYV88NVL
         91MovkvZ8OzBl2bL+mo0PgWb6JMhE2IpFxdPFfUQA5EAMTsE+7eeENJeU3lS2Vt1u/MD
         fb8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUN3ToTRGahBr2zBg/8LQwefbtuenuDv0kDDdFKoKVIAb3YhdBt30SQqC9rq34J9zzxn+Sgt1JX0+Sv@lists.infradead.org
X-Gm-Message-State: AOJu0YzjjwRZeMJ9mKQmkSFhyUSIKjnFphkOFbY4uyprpgrBVzNzA5ch
	bS+nPx2Jk2DkEpaRdFqR6JcUTL2K8g50UkMhWsJf9/+lZlkEX7C2/T1C
X-Gm-Gg: AY/fxX6uUqv0lUJoAeDt+YLr9Xoev2b3h1kprOnFPdCkePCZ6aXRNBXZNBDKkd51+IE
	fdJLAOz05xzUC8H3rTf8wlTheVMFJlUuAd1lfs8VM4IWzphRH1wqOzXgAJHy2nJmp8dClUaYv+a
	6D1tHSPIEAfgZORhVg5uQJ9PqLkkBnZ/N8nj1OlaHf/tZEq+gd1qC6u19rcRcDpOEW3bs3/IRvU
	OeEEUL9w9QLno2MUpWxYHc9UPPf6JLK2D1rOyCW+94E76uXy8W/dcgs4tW3peHaUCglm2mfVCO6
	FnNRIMDJuFbravTlgNPM0jowzd9EciXFed4SGcwWaPEwxUa0Dd232QaDBylqR0buoCKIp1Cr7LW
	447TUeD4tVNdx9QobjP/CrFp+xhazWChoSWfjDVVstyizVTNSUCh6//f6Y2uzna5FHpcAN6/0n7
	1A52IcQ4mVU8StJLPE6YtTqtjZbFfmvhBxhBXkcQelqYcVB6eARFIU0QFUGg==
X-Google-Smtp-Source: AGHT+IH6Au00sYNWU8Mi5YUTwgkiE8WaJV919Fm+0jkmxXzOjLssbO+WP7Caj1TQxwhH44sOyNCD6w==
X-Received: by 2002:a17:903:2f45:b0:299:fc47:d7e3 with SMTP id d9443c01a7336-29f2403aef7mr45500585ad.31.1765596799733;
        Fri, 12 Dec 2025 19:33:19 -0800 (PST)
Received: from [10.200.4.113] (p99249-ipoefx.ipoe.ocn.ne.jp. [153.246.134.248])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29efd74f5e1sm51961605ad.16.2025.12.12.19.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 19:33:19 -0800 (PST)
Message-ID: <101bb8011cc6be8e60409d294c8c0abe93b9ed72.camel@gmail.com>
Subject: Re: [PATCH v4 4/4] nvme: Allow reauth from sysfs
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: alistair23@gmail.com, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, 
	sagi@grimberg.me, hare@suse.de, kch@nvidia.com,
 linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Alistair Francis <alistair.francis@wdc.com>
Date: Sat, 13 Dec 2025 12:33:16 +0900
In-Reply-To: <20251202051755.1312158-5-alistair.francis@wdc.com>
References: <20251202051755.1312158-1-alistair.francis@wdc.com>
	 <20251202051755.1312158-5-alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251212_193321_257244_A64E28CD 
X-CRM114-Status: GOOD (  17.60  )
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

On Tue, 2025-12-02 at 15:17 +1000, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
>=20
> Allow userspace to trigger a reauth (REPLACETLSPSK) from sysfs.
> This can be done by writing=C2=A0 a zero to the sysfs file.
>=20
> echo 0 > /sys/devices/virtual/nvme-
> fabrics/ctl/nvme0/tls_configured_key
>=20
> In order to use the new keys for the admin queue we call controller
> reset. This isn't ideal, but I can't find a simpler way to reset the
> admin queue TLS connection.
>=20
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
> v4:
> =C2=A0- Forcefully reset the connection
> v3:
> =C2=A0- Only trigger if a 0 is written to `tls_configured_key`
> =C2=A0- Add documentation
> v2:
> =C2=A0- Trigger on any value written to `tls_configured_key`
>=20
> =C2=A0Documentation/ABI/testing/sysfs-nvme | 13 ++++++++
> =C2=A0drivers/nvme/host/sysfs.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 44
> +++++++++++++++++++++++++++-
> =C2=A02 files changed, 56 insertions(+), 1 deletion(-)
> =C2=A0create mode 100644 Documentation/ABI/testing/sysfs-nvme
>=20
> diff --git a/Documentation/ABI/testing/sysfs-nvme
> b/Documentation/ABI/testing/sysfs-nvme
> new file mode 100644
> index 000000000000..16aaf0dca9e2
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-nvme
> @@ -0,0 +1,13 @@
> +What:		/sys/devices/virtual/nvme-
> fabrics/ctl/.../tls_configured_key
> +Date:		November 2025
> +KernelVersion:	6.19
> +Contact:	Linux NVMe mailing list
> <linux-nvme@lists.infradead.org>
> +Description:
> +		The file is avaliable when using a secure
> concatanation
> +		connection to a NVMe taget. Reading the file will
> returns

s/a NVMe taget/an NVMe target
s/returns/return

Otherwise LGTM

Reviewed-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>

Wilfred

