Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6918A606A32D
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2026 19:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=wn2PTiQT;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=IC9Oa8AG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=isfwHOSFEU1THdAtyjNR/BymwB+TGu4CpGjFt5oul8o=; b=wn2PTiQTEcci28JGoc5HTF2IUB
	LJnSmARnqRZIux6XubVd5/tK1c+A5xqpUQTNCRy9gnuGLqI5o6oLtpbnLsyASaOs1HxDXeXA71WUu
	J3sIgarSuEDHTDnWPsyH/OO+M0uCLnqRb2aAWrG3P1H08A6bdBgJXLYoJTTw1jV6idq2702GXhHYv
	l7mUHjag2Y+4kNTwRnCb6RuXzyyomVc899t/AjxR0fW/X07cV++Sh6I9Z4P5Ecpy+wQle9Ca7An5g
	Iu83cC2uf9abvyEKWhYSTq/wbgVnZ52CpgNaN3xS74elvHAj9frK+qz5/kUJ9JGCdlb/UQQUEWwQj
	hI0jEyAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRx3O-0000000ECoi-2Rd2;
	Fri, 13 Nov 2026 19:35:18 +0000
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRo8S-0000000CIPi-3rRJ
	for linux-nvme@lists.infradead.org;
	Fri, 13 Nov 2026 10:03:58 +0000
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-6b6f42095bcso1441617a12.3
        for <linux-nvme@lists.infradead.org>; Fri, 13 Nov 2026 02:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564235; x=1795169035; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=isfwHOSFEU1THdAtyjNR/BymwB+TGu4CpGjFt5oul8o=;
        b=IC9Oa8AGniYLj44bWbe6WiW5frpw9UC0b0Y0G7WXTGZsb8JkwOi/0zG2fQ7+Bu5+Bl
         fmcNSlAZTOHc4Pg9V4AyU6rutATSomVVosZvDwS8+VNB5zxqU75dkv6GeXwVKx3M6p+H
         9syQhpE8s2t1DZaRrw2Xy5lrbprGNlrRZdHVSFtfklTN7GnWaY/AcSWkU4OWXmvMOcjj
         85PSv6OgaBZLts8+QMe6cFum3Ma6rpYm5eQYvJv7R2XBJxM/sLw1ivDNL67+Sws2Bqvv
         W8CpF4Ybv/cCsobZjgRI7HIaHOBPiZ3j3Rl655GijbH7hiw7wb93Gw+YrOU2RfF2WLhF
         mYyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564235; x=1795169035;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=isfwHOSFEU1THdAtyjNR/BymwB+TGu4CpGjFt5oul8o=;
        b=SJlqkLneOqUjaHKxyAbhz7bSJPruc3XeWlLbuU6EH4RhUNumsUjw+rh2YcAbH0A0i3
         sVoHAYw5s+gH0omelDCAdUqD+8kslDFY96v/Z1YaEPD3IjthO8W/rdLOE/U7OOOdLFSX
         Uul1yUN+S8CQygDiC74SUmywA7sxTWt7C62txzJTzBk68kYlW+//DUZ0t0INPtgINKvr
         /PPfu1yOGLphpNMkL1Ilp69hhn1UKZR+4m7f0YJtA7ymq+GS6gc8WHESAkZEe7NVx3xQ
         PM+iQwZqBhPLbZYAz5qhm7MmPsMabn8UqbUKxIlj74Tvo+p4eBXZmmbVu1dtjna59x12
         aTKA==
X-Forwarded-Encrypted: i=1; AL+hErHpH33XRcOpGXOSYbc8ZRlMwAwAxe9/p0Th6yH01hlQ1fvK/D10SF7B9cw24a+YSPab6YptrDzB/aF7@lists.infradead.org
X-Gm-Message-State: APuU4Z8QmQYrQ+lQuntHmHaKOoztI4F5VGVxdXbYXQNK5BrT3zJW+a92
	aPEhMwupVIdBBV3pMCr8HwrpiiZOomzaGNSKuaWyT3yggjS0k5vs2PbAtnFh/CzRiX/F
X-Gm-Gg: AYBFou3Kk6b5RmJCany0s9cXxb2yagYQxMgvLBYghkpa2bV4TftmghHI93fv6X6bCcp
	CyjxbKKxlmfczgDGJXYiVQ7ghMgdK0vxzud7g7yKfKo2asAVWOfMooQR4eOx9TI20+ni2/sqViz
	ZDksGGvS4mazaE4aHmDqFJY0I83wNL7GjGtBmBy2KZlJa3TweTkPPspc4C1XS9fw9MdbKbh6SMz
	BWpOSXlP13HhVVCHGy2IAg8+kFocOXb/z/iBX+j7EH7PDznIec+Jd56hlfj+4T6cegwMgMYK3u/
	LLvw3NRCohldSTEIU8XGnI4KERWcIvLq7qdLosjgBxZmqQ6bTMW7/ZuUAEr+WH6Qx0My0W9qa3T
	rxqIXtdx49wmgOt1pXTq11BeEIMIu1k9viIBcX4HvmuvduCON8p7DBw5tIeHM1ZWXi0Y3bN0BtC
	4/UADMivyS1nPGYorPCRIBnkLUcoE48/s6VYBeSgoKQmQ9vHXxCbvyig10um/s6MQHxSRXmg7Wb
	kL7q9bThVPfqrNyKq2T0ZSN1TULu4xt84WGAbvHpzdbxbNmVZWrJKDWDlkhgKR4134IytuwCgTd
	eAqHI1b0q+YjRukAsCbhPLii99JCLJrxbNtcW+4T6HWRbstA2g7/2DArjVioixo=
X-Received: by 2002:aa7:d556:0:b0:6b5:96e9:ae97 with SMTP id 4fb4d7f45d1cf-6b7c0ccaafdmr1234919a12.34.1794564235160;
        Fri, 13 Nov 2026 02:03:55 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7c23611casm766458a12.9.2026.11.13.02.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:03:54 -0800 (PST)
Message-ID: <16dbddeb5cbb9613dc806b43fc681eb26aa3b0dd.camel@amutable.com>
Subject: Re: [PATCH RFC 10/41] nullfs: use fc_init_pseudo()
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Chris Mason <mason@kernel.org>, Josef
 Bacik	 <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, 	driver-core@lists.linux.dev,
 linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org,
 netdev@vger.kernel.org, 	fuse-devel@lists.linux.dev,
 linux-efi@vger.kernel.org, 	xen-devel@lists.xenproject.org,
 ocfs2-devel@lists.linux.dev, 	linux-s390@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, 	linux-usb@vger.kernel.org, Amir Goldstein
 <amir73il@gmail.com>, 	linux-erofs@lists.ozlabs.org,
 linux-kselftest@vger.kernel.org
Date: Fri, 13 Nov 2026 11:03:52 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-10-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-10-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261113_020356_978993_198FB203 
X-CRM114-Status: GOOD (  12.44  )
X-Spam-Score: -1.9 (-)
X-Mailman-Approved-At: Fri, 13 Nov 2026 11:35:09 -0800
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 2026-11-10 at 10:14 +0100, Christian Brauner wrote:
> Initialize nullfs as a pseudo filesystem instead of raising
> SB_I_NOEXEC and SB_I_NODEV by hand. This adds SB_I_PSEUDO.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0fs/nullfs.c | 3 ++-
> =C2=A01 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/nullfs.c b/fs/nullfs.c
> index 319c2f5c5a67..2fe24cb97160 100644
> --- a/fs/nullfs.c
> +++ b/fs/nullfs.c
> @@ -2,6 +2,7 @@
> =C2=A0/* Copyright (c) 2026 Christian Brauner <brauner@kernel.org> */
> =C2=A0#include <linux/fs/super_types.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/magic.h>
> =C2=A0#include <linux/splice.h>
> =C2=A0#include <linux/uio.h>
> @@ -174,7 +175,7 @@ static int nullfs_init_fs_context(struct
> fs_context *fc)
> =C2=A0{
> =C2=A0	fc->ops		=3D &nullfs_fs_context_ops;
> =C2=A0	fc->sb_flags	|=3D SB_NOUSER;
> -	fc->s_iflags	|=3D SB_I_NOEXEC | SB_I_NODEV;
> +	fc_init_pseudo(fc);
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0

