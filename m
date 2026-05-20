Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9D40CD5BA4
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2026 19:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Idq3g52uIiBvH2yixrvLS7jLQ3Jl6Es6K5syhNvywDE=; b=jZ0dCho05sg4BcJ78Q9shFW5+M
	gskOhZUdKqD0+wGffkdqp8encPqKf3qEqFr4soXkrqM6zTu2pbzcE3WCqakAN9OLPl9cdq0IRdPV1
	8yiPKNbT4d4/RbW3KfYgIJMAsdRVkNvoK88tPV/oupwhE+ro7FTb5Dk5Dmp/N1QZF9o/1gf5/ffFP
	WCKrE5X2Iu6/9a/JhP9ulgh4fwzUswUCTrmZa1vxgNFe2/q+5W3fXi7cdZkZF8Wzh6TSDz0kEoD8y
	DtNAR944UL4fE03CiV7cGkupIMBvAXgYNkijg02JtJKKg9gxwu5YK3WCCbm/T6L2/nAfaUQS1b7YF
	n3N//7Pg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPmzh-00000005fdz-3zQY;
	Wed, 20 May 2026 19:54:17 +0000
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPmzf-00000005fdD-4A7y
	for linux-nvme@lists.infradead.org;
	Wed, 20 May 2026 19:54:17 +0000
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-bdb3eb93e20so122576066b.0
        for <linux-nvme@lists.infradead.org>; Wed, 20 May 2026 12:54:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779306854; cv=none;
        d=google.com; s=arc-20240605;
        b=asvkyuXuXqA3maPmGpoHyZF/qdikqBC7TyaCBy5S3VypLJSpxOSO/YI0f3tw5qRPZg
         rHsFWpAUO1B1MyzoIGREDXtrPBxbtF5O2oAs51AwviNGdF1tM2hImIvSRAaU0+rFyRL5
         ygai/SHSxu61jf+qYGkNToFrbAmFYqQYnJXh//eaxGj+iurmI70bohxDcfdbgE1Eg8jJ
         BAO2Qe27mizozj0xFcc/gW1u46jDYgUdilnH9DdVYy+mB8cuHjzZ8tCXPLGps9+Jk1sP
         Zb5Q/KZb8i/SXlacqVXqqiOAh7c6dD6Fbtvck6SUPOqvpHfU8UQuHX07qSvG+WJ25WIX
         W1Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Idq3g52uIiBvH2yixrvLS7jLQ3Jl6Es6K5syhNvywDE=;
        fh=kO4kgYJt0Yfjyipyv5bd6+Ib0sJmbdb74GPlOu60BW4=;
        b=XjWB1c5l5U71xp79gqdO/AsGfSVkNL4kX3pyBhIUHWCJt95GBWOkj5hd9ga4gzTdnj
         khn33ViVHzN8vUNyxZs9JukuDNfcHhcJOhOR5qO040BlnOwXVSfRQO35mMvURRlswbaR
         abMq4PnknxvBax/4q4NkA/zraRKZckm2Wyd/3rsdIe9D2aji5ctwBrMdJGm8cH7CDjff
         yJhUtGLrmLqILpFAh7u9AZ09450lkPHAz3wyKMAfQxsdXwW2QXFnDc3FK68Z+rJA5Fgr
         VrQqW4K3OE2RsyThd4y6DHNfowR2upUEtxHcotCUY3TDbVzqbZW1cgin26MP1mebnOtM
         oN7g==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779306854; x=1779911654; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Idq3g52uIiBvH2yixrvLS7jLQ3Jl6Es6K5syhNvywDE=;
        b=sYF+TRPiLqKCacEJgxznscsDdR+M5vIp7VdmwshYl7ZbrYowH2+d4DpBvtTj5y6Ud8
         vu58C00FjWE4cK+jfsuo4D9u2Sgr7FKCwVajG+OYiDnjyLoC0Io/IObUHkNXKJadAklp
         AU/kgh9DBURAS2cTgy4IVu+VjGQC1V4mN/a0GMxZXIBknYImzsS/AAzMyyYviCp3Fg4g
         pMyA+m/cV0hRg7ivTWZvemyvRQrWnu8XKRB9PLx7ZRvVvOhOjxO6cuBzXYNN2adMdFA4
         +/Jbydj48T0DxzwwZYmg1cH5AlkiscKiqI8aouPTBtZey1E9a2mEHNweIkm9EDJQ+hHj
         RGxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779306854; x=1779911654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Idq3g52uIiBvH2yixrvLS7jLQ3Jl6Es6K5syhNvywDE=;
        b=lf8RZlR0/mnbgsxWdA9EU9sATqsCkS7LYUCEHV+XB7EKCNgZiDibkRf+3sdmESFM4p
         /YULtEcLemKnTAnWDEtyP0848a7DdufjE4jMoyFhllu4AYrHwwxLYveme8YxP5dXHbqN
         f8lLa9YjG9MXFH//p5N99MsbxNSiLLrUPz13McFsZtfXTeq38xGZdbvKXknv4i5VJJcO
         ylHJ0ZzPWc6/zeA2YaH66BtFbuiLU3d+OyaCeANgr8mY9jF+ZXYhFDxuCWJXwFqnlyoS
         eNulFLvCVG3/0bLvDtu0Ko5x6DAcuixPwXJ/Tbs4MG4JayXqtE0La3/IYVWDXRL1sEly
         J9BQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Yuvxqlp0a7A1TY+gnWRm98ye1T3yk7CI3w9NHnfHxr9X2tDLiBaPmtSNPzrnBvaMpMQDZVW7P1EFe@lists.infradead.org
X-Gm-Message-State: AOJu0YzCzP7sigqLAcMWkDhY6oMmUytlaDN/fImnzFbx3qEvWRyIpxRJ
	RPvzDoo5TIXDmjWIN0FkxslPNjzaNSRg9CQbYdSrH5KzkW+p3iIF8IKnDJBVKHIKNZkq8bRF3uL
	yu8M1e+tzm5uH57zbOXoh+gqLAerorVA=
X-Gm-Gg: Acq92OEgWR6JM1QB6CpAvh3/Zirzpsi03Yx8ySCHQ1FkXIoAf9C/TYAoCJJIjjZEm5U
	Vpnlj9cTuN9bmrGQ30lBzcSBfOzOhS5Pe0m67Bis5HATZYQOVwo6zik4iZj15kNo7GIVIlyG/1d
	9WaH4SmV3Yj76e/FHMc7kt+o4/bzY8ymrb1Qv3qPHLvTABqggJEyTJEH9BAYxvEhgZAr22f/+Zb
	4rvSl6uBovNW1PoPd36MBqDyrqNXn4sksC9FcQL01vTB9qyCWVfdUWcBqSRzk4VNpZGZuuMUHO4
	5qx/Kdk=
X-Received: by 2002:a17:907:3ea5:b0:bd4:c64c:5a9a with SMTP id
 a640c23a62f3a-bd517aa757bmr1498301266b.36.1779306853243; Wed, 20 May 2026
 12:54:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260519172326.3462354-1-kbusch@meta.com> <20260519172326.3462354-2-kbusch@meta.com>
 <20260520072250.GA14937@lst.de>
In-Reply-To: <20260520072250.GA14937@lst.de>
From: Chao S <coshi036@gmail.com>
Date: Wed, 20 May 2026 15:54:02 -0400
X-Gm-Features: AVHnY4LUfvb8kQcg0Gdncx9V5QaE6U9ARHtMSYBUfU3zjF8mOxyspQdwZP7NJH8
Message-ID: <CACd_6n0Mhn9tLj4H7EojOfaF5uKj0Zu6iZDDxf+tJPUgEABBng@mail.gmail.com>
Subject: Re: [PATCH RFC 1/5] blk-mq: fix status for unaligned bio
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org, axboe@kernel.dk, tom.leiming@gmail.com, 
	Igor.Achkinazi@dell.com, dlemoal@kernel.org, Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260520_125416_038204_1925E78A 
X-CRM114-Status: UNSURE (   8.61  )
X-CRM114-Notice: Please train this message.
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

Looks good to me.
I also appreciate your consideration of my report.
Need a little more time to go through other patches.

Reviewed-by: Chao Shi <coshi036@gmail.com>

On Wed, May 20, 2026 at 3:22=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> Looks good:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
>

