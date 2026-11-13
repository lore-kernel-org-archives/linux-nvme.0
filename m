Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE35606A33F
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2026 19:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=lJ/B0NEp;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=cSjtKfFR
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=gXMsjTg9KyNTuX1cuQ9yr2iJq2/VClhNCtHhh+FL0ZU=; b=lJ/B0NEpWrZHbuLlcNeFRTJGJS
	cKM6uz6wOKJHMqGHJc6LncOu6CiXgNooaM0XjRK2+RFPL8I0JKh+NW3lpoUpn+XOIaq3TqIPmAPAg
	DcNIXP4Hsp0fRa4J7Z1bhwSEXBD4MWI3olZSfFIIw0SSHbBm0BqwV6k6BWVIKEJn41AaLqpXholNk
	PsbJ8ibTQzA6vIkEPJfny5eywTMfsJhgpNLKeFnDSqu6/gMpRZSDnmdNHZEnBwK4u1Wb85fltQizc
	sNGABFykGNlsk4mrbPKy8EfQVSf+nmjDySQDEkRWjiH/9ZhRQOAdLBjiGyMkWtofsa/iaRsbAez/Q
	uHX7ml1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRx3U-0000000ECzE-2SRV;
	Fri, 13 Nov 2026 19:35:24 +0000
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRoG0-0000000CJYf-31yb
	for linux-nvme@lists.infradead.org;
	Fri, 13 Nov 2026 10:11:46 +0000
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-48e09aa5264so307489f8f.2
        for <linux-nvme@lists.infradead.org>; Fri, 13 Nov 2026 02:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564703; x=1795169503; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=gXMsjTg9KyNTuX1cuQ9yr2iJq2/VClhNCtHhh+FL0ZU=;
        b=cSjtKfFRcnpLwkbfONRm29Gi26spuBfSjbW5ALw1pj4oJo1c1yQ2cCW8bDHcHzr9vr
         LUCP/dQPmMYyfJdmrOWOYJaqtSn1FWb6XS4Wzsi4oh2tVralASAb4C0HW1DEgIuWL1Ou
         X/3r2l6HmazJgEtzvX5b4y7z9e3rkcHA6l+y+k10s0ceBVLiSU0HcG3oEOdjyZ4p/Ppz
         QN5o3Ovuzgv4CRP/oP8kBrJH7xZYsKZVsCOE+JDFCLanMXlB/ANtB/VP/gK2P/f6U4Zo
         F6ZEHvaTL9nR587vChcljxcgIyQ8jp1VXizR2K08qaH9RMbRBzsiRLHmCPSdCFeygFu1
         BZlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564703; x=1795169503;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gXMsjTg9KyNTuX1cuQ9yr2iJq2/VClhNCtHhh+FL0ZU=;
        b=iPfQmass78zax5TotahOGvPAXcQOAkHy2yhaVY8KuD+Qh1j2SvfAxvwvFRUAV0yxCE
         AAG+sF3SdYkLI3Q1pA1KCdHzQ7OXNNzdNp+fRtSbuS3DeegZzse1Q2fjcti78pddIPgQ
         nYU0YXFDy+tw5dsB2QWqzMTbrY+5IiYSt8j05jCBSmjvrDWlRcpMRNnUZwvHDuRunEpH
         8VVFEftQXkwPzOCITJoVWBV3mrxYXMN6V8Bt2sZRFqagFDSLPLx6KcaS3pof9hdii36f
         nAVUQjzSJLHkazbGA1Ii0zlV4efoFJvnYj72bNgULpHtk0oCMgyBQKd+Pq2ld3Hurblm
         QvDw==
X-Forwarded-Encrypted: i=1; AL+hErE+w+IWxBagl1BwQUrH51El/mGbJZQveVM8ngNPcRC2/4N1qz34t0E+KxSj9HTA5SAe1vaTuEQIsBV2@lists.infradead.org
X-Gm-Message-State: APuU4Z+Ze9p6ndniD96JhJEwSVdm6bJChTTfZgTQAVBd4C17tzBrr2Ga
	ng1GQdZZIELrJ+AIolRXPaOKDeCIO0kz6uSu18ZdcAC8qWu+VaQzz7Sqwjsldw50aVxk
X-Gm-Gg: AYBFou2cnVyAcEbdqiYDYdDWUx/Jgz8qqBTu9X0qpnFWCIlUJ4dBhEbneh74sXrFTKd
	fFl0OOVhGweIPLQOKmg4fZILNtGzJW5LfgzIa4Xlq4urCrJ+cN4rlvUbysB673W8vw3pFcp8W0a
	FMU5sYHCCfPHviJZSMC6f5myJ3jBGC954yFZZZcVd6y/IK9nrgF0JLE2yOaGd37TmY00EKibVEm
	+TYTGQrFpPfzL4VKHwH2coNmurVoSlaMWUoYAJZZUGKOETMtQmgH7iWaCqre+s+uxmrlMz+cCm5
	LEC3RyaXn5tVPUIVZkyv9CIDEMIx2Fz8wZ7ghS3+qw3m9pKQfdnAFGvw0+M6Pum1a8lfSlplA1j
	7P/pC1kgW9OBJ6pJuYo7CQJNEqTMeCgNr2n06UxxrNdTRfQnpxcA6Hn9/Nr0/VapMUZh2a93ZDq
	Gi/cA2YYOXxRUzFnRDlAUlHUQfEckwBJQepJjAuiDuujSt3H2TB9sx3Ym0xNHgk2zNeTvM/HScd
	fEvZxcr15YPOj3Sux/6sKZXS/Bt7xz/pjnnhdvc6nVwHjfrA1AM4Q+kd+kWTH/HcJBmi4r0ws9Y
	vtbOL7w/ur0tdL5AsUTYh0/NSGCAw+GElEkEY9+fLPbhrjKCSmPCfLrZQXmIafI=
X-Received: by 2002:a05:6000:2501:b0:488:88ec:59c3 with SMTP id ffacd0b85a97d-49c73259cc3mr5012611f8f.14.1794564703010;
        Fri, 13 Nov 2026 02:11:43 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5f1c1797sm4931434f8f.11.2026.11.13.02.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:11:42 -0800 (PST)
Message-ID: <ff6d2a8c8623f5476d5c352dac1ad98ab3da303c.camel@amutable.com>
Subject: Re: [PATCH RFC 18/41] selinux: use fc_init_pseudo() for selinuxfs
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
Date: Fri, 13 Nov 2026 11:11:40 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-18-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-18-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261113_021144_798547_ACC7A651 
X-CRM114-Status: GOOD (  15.34  )
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
> Initialize selinuxfs as a pseudo filesystem. This raises SB_I_PSEUDO
> and
> SB_I_NOEXEC. selinuxfs never holds executables. SB_I_NOEXEC also
> refuses PROT_EXEC mappings but the status and policy files are only
> ever mapped for reading.
>=20
> But selinuxfs needs device nodes. The kernel replaces file
> descriptors
> with /sys/fs/selinux/null on exec via dentry_open() which doesn't
> care
> about SB_I_NODEV. Android init however opens /sys/fs/selinux/null by
> path as /dev/null doesn't exist yet at that point. So clear
> SB_I_NODEV
> again in sel_fill_super().
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>
   I.=20
> ---
> =C2=A0security/selinux/selinuxfs.c | 5 +++++
> =C2=A01 file changed, 5 insertions(+)
>=20
> diff --git a/security/selinux/selinuxfs.c
> b/security/selinux/selinuxfs.c
> index 310e19efff1d..d7ae853b6d68 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -18,6 +18,7 @@
> =C2=A0#include <linux/vmalloc.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/hex.h>
> =C2=A0#include <linux/mount.h>
> =C2=A0#include <linux/mutex.h>
> @@ -1852,6 +1853,9 @@ static int sel_fill_super(struct super_block
> *sb, struct fs_context *fc)
> =C2=A0 /* last one */ {"", NULL, 0}
> =C2=A0 };
> =C2=A0
> + /* Android init opens the null device below by path. */
> + sb->s_iflags &=3D ~SB_I_NODEV;
> +
> =C2=A0 ret =3D selinux_fs_info_create(sb);
> =C2=A0 if (ret)
> =C2=A0 goto err;
> @@ -1955,6 +1959,7 @@ static const struct fs_context_operations
> sel_context_ops =3D {
> =C2=A0
> =C2=A0static int sel_init_fs_context(struct fs_context *fc)
> =C2=A0{
> + fc_init_pseudo(fc);
> =C2=A0 fc->ops =3D &sel_context_ops;
> =C2=A0 return 0;
> =C2=A0}

