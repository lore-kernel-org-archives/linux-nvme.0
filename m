Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68319606A331
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2026 19:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=rc08xNCN;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Ky6TwSj6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=oBVCWZMOabVq55k67Q8GIm9NBAOJHOxllLRlvncSbis=; b=rc08xNCNBLFkI65fDQ80G/OwFm
	3XwU9kDljmhICV1rckkGPVswyYSvfJPSW7a8byah/k0JVKBTnV12o2Uiusj3Fqk9QgByfklDPe+TZ
	J4elxVXE80w2e+06eV4B2yQLSRw7oEHDbVB3ZDkSc4LkQtqjdB+NfHmNt5EAWouHhKx+FsD4FZZir
	/cJq51LWt+CsWqp2L29/rq2hg/wcjUu1e61DmKdLMpUtlkIImofE0xgNwwrkhlQpIN6VSGdRUit4d
	rK2e/e2svjtiRK5yXW/bro9Igg+bBYpNILJS42AfPHdc9omCfBQH79SwY1MGzMKDIh5utHQJ4GgCZ
	sOCGLOUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRx3R-0000000ECwE-3Hy8;
	Fri, 13 Nov 2026 19:35:21 +0000
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRoAk-0000000CIfV-0lkA
	for linux-nvme@lists.infradead.org;
	Fri, 13 Nov 2026 10:06:21 +0000
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-6b56221d361so1538902a12.3
        for <linux-nvme@lists.infradead.org>; Fri, 13 Nov 2026 02:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564376; x=1795169176; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=oBVCWZMOabVq55k67Q8GIm9NBAOJHOxllLRlvncSbis=;
        b=Ky6TwSj6Hx35xtd3uW9rI3rfDoBUA6/nvFksxP7ODldr8dpxDUwUqviuqmpvq+dj+k
         kitueMOE9PZs2bygpiub7RlRgx0yTws05c8XNUiDPEdgzWRwuriZD0Jv/d9Q+wyQNjc8
         dXRUkHGTh1rp7cMqph4XbVq1ZWayutisedDoFfmHYTfUlxSffwFiBIo9e1hF+XwZf+Uf
         1EVE7L9MrgiH2U10gB8puQhGgr02USBlBXFVFViIxrdDz5JQpZGv5O71XdOgqUFukS8O
         c5lPPsfoFnkpbdcoM0XMfFHm2wmnJ3cDt43zd2+MS2YNpeKGmsDaJf1/9JA8nYZEdv9T
         4C+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564376; x=1795169176;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oBVCWZMOabVq55k67Q8GIm9NBAOJHOxllLRlvncSbis=;
        b=AOEaiQKUFm65cIixqMcBhFsBRyCSVTnGLFSAw91TuWqbs5g5E3EcDQqWC2HlEqZA9d
         l/wJm5XXKvJCCxDgLzxew+4tdQmGDEo0KoOs1AD/wOteBH5KOfe07seeiDZk01QhQpOE
         kSQPO0OaxlQbyvzbhwCnbLweY7FPHRN+tx2BEKDGID1EOLaI2gYAz+sk9xHcKl3CpMhU
         pPQ5iDS02ZPKsacKriIrL17S+fVFxIV3M+BO3Pd1zWTJmANIBLNf+Hm8hvsy3RhVebqg
         WCWxIb/hrSAKLbGmtb4JnxGmeOuy8Wod8mkyxIh4FWDSXQm2Wye4HUmOSLRQpkBHpU7P
         e5dQ==
X-Forwarded-Encrypted: i=1; AL+hErEYpqkx4YRGlTrMm9C3lEIPSfeyoKsQK6h+Z27DIpxGHJaszzTTNBM+3cFnk1/t32aOJEsvnubapm4X@lists.infradead.org
X-Gm-Message-State: APuU4Z/L08RXsRflhJWzQtRWU67Q7BLXKKWNp94uW4xgRpETlzqp1XWs
	4f7C6BIF/icGMTrHbK1YHnNz8dtd4zbQDLxe/2kFPXcMTeoM9nZVIjPkGjKGFcJKimMf
X-Gm-Gg: AYBFou0f6x21/YybriSx8DlrJb3kfiyl1x9H19/OOlH6MVpOn9jxEdw3LCrraCjQJxx
	Uf32xMdxRVWaez/lzw/9QCJ9Zod51vihudIkb6riQm7+cbz2ge9zq3TjvG4tSPvxDZEz/obYDWH
	5npgSKThBDcRes6yi0kKgimGFuVAV8CzFbQd/ulLBhRJVZq4BybBO1aPPx2WBlCDfORhO2r2NY2
	z+yYkF67jkF+HZKN5jZHkEihqdP2a20jGNk02soaNGqRDMXxKrohxvwhMoK6vIKNUUHJ0OeQaSI
	g5NZ21rEnLQWRwJ0Zah/f7HRCLuLZ5Z74jq3P4774jjXkWqJMkrVhEi7AAkU2NzN6rMe++qgAq4
	wXtcE4oziO9yTR5kyidbdzkdBcrhfrDnyxVZWrnqQUXTxyiJyUC+idXzs7rHwM68ADNCtatcluc
	Pz9u7E1SYWkvcG4SSmIzbR1d0vDRQRVhXz3sHikDJ2+KTicOjSoHFiu4eW7U9CkRx4U0Cvb6H4v
	H+R6odNA013eE6iJrYYkETZo+5LXB/x4Nex1PaqZ5ixjFSoe1V6IBKTyqXCl3asRfm9UNnikxEF
	o3k0gLzNG8RU8Yt6oVEq4Zdv2MUc05j6c57BfZAvEVzBL6SqeEjkbnKB6DnKevQ=
X-Received: by 2002:a05:6402:280d:b0:6b6:4dcd:967e with SMTP id 4fb4d7f45d1cf-6b7c0bbc394mr1685420a12.20.1794564376161;
        Fri, 13 Nov 2026 02:06:16 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7c21b1b5asm706711a12.4.2026.11.13.02.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:06:15 -0800 (PST)
Message-ID: <4dfa19dd41ec1a202182284d9617926a259288a7.camel@amutable.com>
Subject: Re: [PATCH RFC 16/41] configfs: use fc_init_pseudo()
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
Date: Fri, 13 Nov 2026 11:06:14 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-16-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-16-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261113_020618_260363_73B613A5 
X-CRM114-Status: GOOD (  11.81  )
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
> Initialize configfs as a pseudo filesystem. This raises SB_I_PSEUDO
> and
> also SB_I_NOEXEC and SB_I_NODEV. configfs never holds executables or
> device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0fs/configfs/mount.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/fs/configfs/mount.c b/fs/configfs/mount.c
> index d8cac1cbf3bd..60ba24e7ae2b 100644
> --- a/fs/configfs/mount.c
> +++ b/fs/configfs/mount.c
> @@ -13,6 +13,7 @@
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/mount.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/pagemap.h>
> =C2=A0#include <linux/init.h>
> =C2=A0#include <linux/slab.h>
> @@ -106,6 +107,7 @@ static const struct fs_context_operations
> configfs_context_ops =3D {
> =C2=A0
> =C2=A0static int configfs_init_fs_context(struct fs_context *fc)
> =C2=A0{
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &configfs_context_ops;
> =C2=A0	return 0;
> =C2=A0}

