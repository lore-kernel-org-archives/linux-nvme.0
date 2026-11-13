Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96493606A33B
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2026 19:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=rQ3Oh3/I;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=i8SUB3cM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=yP9dZgkD4P/bNBFnmHOgKVBIpz9VJZUP73dl9853V04=; b=rQ3Oh3/ITgs1zbS3TibsMH2KAo
	XKqJ60/g9mLyxjca1CqhShCZMTVNsx/U++U3P8jb8r62fV8Qc3CM1mSNYR8Zg7xc3blxAmFXVMIr0
	E4OenPBmhwVc72RpQ61C9xWT+15AhPAwroo1EMd3qIemM+OaFvs4CngL/9K2pfIw+ngYNWLhxlx2F
	M0GiLxj6gx3cu+nHTmZ75ZOmAHo/bk6wOMZDa8Em9R5BuZzYCCESVfWJEvz/cVWmz5jnkiI9P8QWh
	oB39qydm2hej/jlj7uybT2Bz164wAs/dfbVujZhwU2uxrCONBmAkDlEyo+TX+C23DWhDzEWHwmXfA
	u6mJSxHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRx3N-0000000ECmW-3BCK;
	Fri, 13 Nov 2026 19:35:17 +0000
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRo82-0000000CIKM-3uGg
	for linux-nvme@lists.infradead.org;
	Fri, 13 Nov 2026 10:03:33 +0000
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-6b7a488a0a4so1112973a12.0
        for <linux-nvme@lists.infradead.org>; Fri, 13 Nov 2026 02:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564209; x=1795169009; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=yP9dZgkD4P/bNBFnmHOgKVBIpz9VJZUP73dl9853V04=;
        b=i8SUB3cMExgPgI5VYD8oVQTQWv82cKiJyWyOrTiK4tiAwXYdk29p1PQoyLpjgg7e5I
         FtLO0AXHu4YbPujdJORr/ml3q7YRvMuXtbCr5tQ6KQQv2h3cXhx5XTGF/8B+3+B/NfQ6
         ihVRmOS7WzpNJ6pphIHD5B67rWKHMyOrWf8YauFtzTokEyvNP9BxTuTUYUcJdB+jpR9x
         njV6iJcI2BbnqXDWSlZzZ7uZb9AUAz8rIpeqLWcbUe/8F1wLgclPpCDfxiUhICkTrwcp
         3NvkjwZVMgZ4ncQ+PKUkb6u9TpnfK5hMc0UICG/VcrvNVvDwdej+HJpF3Jmd5f2b2ze+
         XdHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564209; x=1795169009;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yP9dZgkD4P/bNBFnmHOgKVBIpz9VJZUP73dl9853V04=;
        b=Pn2yuBw9ilsGyyLEYGdNR8aHdlw6BR6M+QJv/VklkCGXCDsvvLUjtdUkqig5nc1waz
         DYhILOWrbJpfUoA28dNiyJOZ+nnriG5mSoWtN+GL5+js+NuVU3nkJOUnYJ8wR/72SKmh
         Mb431a3M1gNKUWbPyvcptXQjbGuFWsZUN29Vz/UeYTPRhKf9U4iH7/ueufJi3PdvEPTH
         xQM0wdGv1ZRa+q/IqTAva/EVgWH4i7Vc1dJpcF0n8Nvh0HPReyix3poAazp8ZsCvmis1
         d5WbHGYodLZtmnaG0wwcz8HEBp46vk5P1Zw2Gx40+ztufI3fwaieoaCy5e19FqH5lRC6
         59ZA==
X-Forwarded-Encrypted: i=1; AL+hErFVQ9hU7YWz+1Y7I33+07JRrnA5OZpg7w1nqQx5rLZ5BVepFVO/CczpWddpb+ZjIr1tzKRnZ3IZaKcZ@lists.infradead.org
X-Gm-Message-State: APuU4Z9N/wlhzK1zFcISlQA3JprNVrePpoX7D+AskOK2T7/3qaDGn3Z+
	e4s7rq7+ifl2QSVj+sDRGeVaVFWtlE+lFmH7kD98NtCUu61EUwY9ONB3WVyRyepyE+mL
X-Gm-Gg: AYBFou2SZUFZ4bU2mUbaBwDz95dqY5FNCWdsfnDNQyQAQNExCGvhP5qF1oK8LPfPZd6
	9Ht2aBqtPxuxvoGGbShqoMEtN/QGadagcLPLkJHOtBjuLfPsvQ+6ERNQcCu0fxFTWzHDNG3ad8J
	bWsX+Dr3k9Zefz8L2ymhDpYa6a+kWzUesE+sEcMgp4HZ8lnKrX9R/00IlbshdHs+75XhWBXUI7c
	I0DY3GG8ifq22Cvs3Pyalt8Mz3yjIrU6lTiwmY1P7tZuNwQADA3kq5kfB9etCY/33kmDYsL0cC9
	/P3e/dI4qStx25c1Cn9biKs5ODIaXGSPymGm1afoo2F6LBpbjAWx2tHNYOddG+qXWI1/LRp0x9Z
	KlauD9YxsUvIjVbiKDPeA0aHA1CeG0r+qWTaCwqI2hUXYjuR/x+IyEOHuSKt+TCfjNdOP06G3T+
	xI7NJ0eD1scjCWzAWJUiG3cvniOhPshSe4hc+9C3qvTbRJIeAnUZjKAZTnSvZgUDV4lHB8GzHVP
	ZyAf5kZyPIy3cUy8sJ5b6Sjp5Czy00ljCzKaa4jgmi0UZNliU+AKkpeQ4x4OUYfLKnv4ocqoeJf
	9dqt78L40bCavMUTx7DfhGRUMXGpCRjZGZo2WeepR7jmZR9/qCit5kqGyLn53Q4=
X-Received: by 2002:a05:6402:270d:b0:6b7:d479:654a with SMTP id 4fb4d7f45d1cf-6b7d47965e6mr298323a12.36.1794564203570;
        Fri, 13 Nov 2026 02:03:23 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7c236124esm752333a12.6.2026.11.13.02.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:03:22 -0800 (PST)
Message-ID: <e5f36cc53b733383ac1d1f1e8c03f73091595edf.camel@amutable.com>
Subject: Re: [PATCH RFC 08/41] mqueue: use fc_init_pseudo()
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
Date: Fri, 13 Nov 2026 11:03:20 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-8-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-8-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261113_020330_984862_3B9096CE 
X-CRM114-Status: GOOD (  11.97  )
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
> Initialize mqueue as a pseudo filesystem instead of raising
> SB_I_NOEXEC and SB_I_NODEV by hand. This adds SB_I_PSEUDO.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0ipc/mqueue.c | 3 ++-
> =C2=A01 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/ipc/mqueue.c b/ipc/mqueue.c
> index 322c3dd98c44..8bbe32d0881f 100644
> --- a/ipc/mqueue.c
> +++ b/ipc/mqueue.c
> @@ -18,6 +18,7 @@
> =C2=A0#include <linux/file.h>
> =C2=A0#include <linux/mount.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/namei.h>
> =C2=A0#include <linux/sysctl.h>
> =C2=A0#include <linux/poll.h>
> @@ -405,7 +406,6 @@ static int mqueue_fill_super(struct super_block
> *sb, struct fs_context *fc)
> =C2=A0	struct inode *inode;
> =C2=A0	struct ipc_namespace *ns =3D sb->s_fs_info;
> =C2=A0
> -	sb->s_iflags |=3D SB_I_NOEXEC | SB_I_NODEV;
> =C2=A0	sb->s_blocksize =3D PAGE_SIZE;
> =C2=A0	sb->s_blocksize_bits =3D PAGE_SHIFT;
> =C2=A0	sb->s_magic =3D MQUEUE_MAGIC;
> @@ -457,6 +457,7 @@ static int mqueue_init_fs_context(struct
> fs_context *fc)
> =C2=A0	put_user_ns(fc->user_ns);
> =C2=A0	fc->user_ns =3D get_user_ns(ctx->ipc_ns->user_ns);
> =C2=A0	fc->fs_private =3D ctx;
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &mqueue_fs_context_ops;
> =C2=A0	return 0;
> =C2=A0}

