Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F0E606A32D
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2026 19:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Ky4zr2bF;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=in71XsJQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=SoW/gPie2WRRtXdhiV6ow6HDYwH4jtR4w1oiMzBwW74=; b=Ky4zr2bFZ5tLb0vpibewE+zphS
	5v07yCzrZveTEQOOQCccL0xYWdDEKzIQsGErNsJs3idwUARidup5ctAgolY38p80o0CY/hXz9994M
	1pkFuhZSj5oXZI4ClNg1tVlzu0EqOWjIy5KiIxsGOioxapbfKgQNygBVE0UyDYfGkvPV7PBxXOzZ3
	B9jnyRXk8KafHVgzBsKhw3tHZJmV+zle1XE10Fx/NJwHR8DPB0WmQMyTMxpKjumW+dVG/azBSojg2
	T1RqgnJuDySP9+uErny5bhSgLvvuC2jF4h7rDNBmqVoT+LkwLazuGZdzWAciv46DNYLvDhh+AAaOk
	2MK/kqdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRx3N-0000000EClk-0b2q;
	Fri, 13 Nov 2026 19:35:17 +0000
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRo7h-0000000CIGf-3ncd
	for linux-nvme@lists.infradead.org;
	Fri, 13 Nov 2026 10:03:11 +0000
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-c4d427836e9so121393966b.1
        for <linux-nvme@lists.infradead.org>; Fri, 13 Nov 2026 02:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564188; x=1795168988; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=SoW/gPie2WRRtXdhiV6ow6HDYwH4jtR4w1oiMzBwW74=;
        b=in71XsJQOTrT7DL+9/Ioce0hkvdU9sOnZ+nqFE06pI2Bcz2LWA/AQevQVndLLi4px4
         Ctj0cxBBX8/slVAMkYZu9mwpH398Vfb8dXaPkbOqHVIF3TdESKJJfVJIohYKSVmCKuuj
         /fFTk759ykdbYDB/NmVgpGhvDdkHZtRIHOn5s7EKMVHQdbrtuSU2jjdK0WDB/stEhNdE
         gYB5Y3mXXNTbYx1xBtSYInZdnUXNuPl+8F7pi3t7B57VD8+69q2ZnlinWqNExrwRYk6I
         gj61kQH29yMXE9D3GHKbKfZ23UAA5AnIwQn9xjEYJLcRPLPGrA4fUCq9elcmKq8ie4dJ
         dI4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564188; x=1795168988;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SoW/gPie2WRRtXdhiV6ow6HDYwH4jtR4w1oiMzBwW74=;
        b=2eTxUyPEzU2SC/IBJQMjcnwSZH8mDAhHdy2qd4Ehwe5LmWROQ4EqZGVUyNk0Kbd4YC
         SKKM4tng2Dr/F32ssBvvDMBEGsZo/CCDm8NKhdSHxvTK3KC0HyNu9/scyxelT4HPSX/e
         hPrpZYx76JbNqVjVlAH8B4oSb2kR7Euef1RtJeYJMS6Reb1q44uLE/EOUWjAq3cN8tbm
         7+Iyby9lti3mXRRemnatiPLOi5dAmcUuFDWoh6jnbSqJAH/eGIZVfY+cmhIhT6J1CcRJ
         ZEUSMAV0jot1p10Nl2venjd61G1pVMhRLZI0LJO7EFSXtzNHqyNb4eIe7lWMqHvdjhE5
         iXlg==
X-Forwarded-Encrypted: i=1; AL+hErHclH+SV0Fv9T8ZlbunGVss3t0LgwFfq/7wYCMF6mYO0JbNTMamACaampwQChqcOFfxbSsj4zdZqgMY@lists.infradead.org
X-Gm-Message-State: APuU4Z/H/cNw89jtGSDClbkybdHuuaCpAArV46j+mCFEmGOTLx4KMxc8
	JeYs0gQJTfLWu5mvy9f4ilMmi0xrAW/Z98XKEiZWV9rz/9vyJP4w+RCvgP3Xcvp5JfNu
X-Gm-Gg: AYBFou1uHbnb4/al2JAVKpQXQxzvXhY5a98TVUONKHRAUFxfHomK9J2bAOG+eNOHBqN
	+54mCP1KoCfcxGbUzyRlLIXYfORgoLwnpIOY6j989yVhW1tPRZyAQ86yfbbZPvt1d3Bjd7l5iBt
	A9IcwwyRW38l7aNPg6kk0jfe/Wi2WD6N2V8NkTIAsoq7t44GSfh1E6vVOejCxtKdEBUsWARn2hP
	7qNpt3qk1DynOmk331WGdCdfKuZt0EEEmkEYGwJ0fVz86bD/VegH01osyZehzJrdRuXxxWeWHeg
	7SQ9I238/N5dtOm2WqMCRkjzZL0vXRnH5rJC7Wxql8va6WvCdEl5D7iinY+b7s9E6yaorauFeq8
	jhjrHUPx184dTOeH4gfu3Y8cUntulq3oflrPdeWVsDzOgX0z+qPMd3vfC7ryD+JQaMVG/Qh+4qR
	65Rwukhbj9g/iLjvvi7sdeN23i0bXeH5SyJwFYcrxRKtp1ZJWf0kzPxsAd+34y+dY9b6B3Pj2JQ
	E4AF8n12PlPOiZA4saBuBC8y+iIBwCfWAgdAIAKi9RoNVNNNary12vXBC+o+aKSXVumUxwyxCdN
	SGfcTjDVJH5vGOXblFpebzOp3/4koCbB3olABKJMdPVkMJWe
X-Received: by 2002:a17:907:d12:b0:c4c:b4fe:c9e8 with SMTP id a640c23a62f3a-c50963dbee5mr161853166b.38.1794564187801;
        Fri, 13 Nov 2026 02:03:07 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b3dbaesm74933966b.32.2026.11.13.02.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:03:07 -0800 (PST)
Message-ID: <fffc4f7f87fd5f03d1ef409df76f71ddad552213.camel@amutable.com>
Subject: Re: [PATCH RFC 07/41] binfmt_misc: use fc_init_pseudo()
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
Date: Fri, 13 Nov 2026 11:03:05 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-7-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-7-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261113_020309_961831_BC4865A8 
X-CRM114-Status: GOOD (  14.34  )
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
> Initialize binfmt_misc as a pseudo filesystem instead of raising
> SB_I_NOEXEC and SB_I_NODEV by hand. This adds SB_I_PSEUDO.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0fs/binfmt_misc.c | 5 +++--
> =C2=A01 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
> index d945b4f6e158..7dc233becd98 100644
> --- a/fs/binfmt_misc.c
> +++ b/fs/binfmt_misc.c
> @@ -22,6 +22,7 @@
> =C2=A0#include <linux/file.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/init.h>
> =C2=A0#include <linux/kstrtox.h>
> =C2=A0#include <linux/limits.h>
> @@ -1575,8 +1576,7 @@ static int bm_fill_super(struct super_block
> *sb, struct fs_context *fc)
> =C2=A0	if (user_ns !=3D current_user_ns())
> =C2=A0		return -EINVAL;
> =C2=A0
> -	/* Never exec off this instance and never let anything stack
> on it. */
> -	sb->s_iflags |=3D SB_I_NOEXEC | SB_I_NODEV;
> +	/* Never let anything stack on this instance. */
> =C2=A0	sb->s_stack_depth =3D FILESYSTEM_MAX_STACK_DEPTH;
> =C2=A0
> =C2=A0	/*
> @@ -1660,6 +1660,7 @@ static void bm_kill_sb(struct super_block *sb)
> =C2=A0
> =C2=A0static int bm_init_fs_context(struct fs_context *fc)
> =C2=A0{
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &bm_context_ops;
> =C2=A0	return 0;
> =C2=A0}

