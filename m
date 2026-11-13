Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD80606A32E
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2026 19:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=iVOnz8h4;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=oo/VgN1z
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=QOKRfXbntKilXKCbQIPuMXmISRmnU6cXIBUGi5zYMoA=; b=iVOnz8h4gU34p1kOY+2ze17mRA
	60SlKYTY2GDXQRyBsMG5TTaz2/UMKHDzV8CMIA2gj1Ao+0zEPQ0BcrAABFqDcGD4fsRx05/quES2D
	sbiB8i8Zh5gcGrPAHunlvTQytGdvlzsae6HXoFA7drSr57dgSIN41XyCjfTdDEWEwWNpfSbOmju2g
	6BPowplYtSZaIf2s3cEDdUZArVbBK/NYzybCd+ffqjUR/snkkM+9dqx7PnScqjTYgyreb5r27WzKv
	L3of4GEzoNhYBCp1aJcA2VknbYdIiEi7h/rJa+MLW2/z0ZpMihyd2Labd2MU1C4WDMHHKUpy6VsX3
	kq8ES3Lg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRx3M-0000000ECib-2gO9;
	Fri, 13 Nov 2026 19:35:16 +0000
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRo7R-0000000CICm-17gA
	for linux-nvme@lists.infradead.org;
	Fri, 13 Nov 2026 10:02:55 +0000
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-6b70880c0a4so1098385a12.2
        for <linux-nvme@lists.infradead.org>; Fri, 13 Nov 2026 02:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564171; x=1795168971; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=QOKRfXbntKilXKCbQIPuMXmISRmnU6cXIBUGi5zYMoA=;
        b=oo/VgN1zzskEXJOvg9cSQI4VypUo5jd6IzEFL1NdAWj5TtTcsJVJWBwFwgZpGW44a4
         AKkzyWYhgFHSc2uH/cLqNPRfR7eMYr3ez7IH5TXCPzra6Rnhmk5UfSQJjaMxjUfHgnDU
         ZzRjDX3HVXJWCk5uMiyv8pXImGRLi0l3GiVb5/Q4CEkpTwCwGLfMUGLF2PPwDzQbQXxz
         yjcbKrqcZqCvXWiaWZgtyeo07BgQ6e6+mLy6enBsYI1VfCwB1OafqKy8ebuaVxASO317
         3ivvd7LadFhTZ2K9HTGFWGYJcTvM2Ve0LkWMrzp1R+dW77o4z80LfDtjbuzRmavoQfbv
         rqFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564171; x=1795168971;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QOKRfXbntKilXKCbQIPuMXmISRmnU6cXIBUGi5zYMoA=;
        b=haV+HbnC7AkbjOWL2qnYWJw9YQxasOvoHKXkBkOC04TJm4sfEmrJ6T+taJm2Iirlci
         Lmd4laeC3UorAYOjHoKfCRGMM411fqqZYfTraoejg+NZ0gQkiycp+31Q+SgY5Iee2Eta
         TJjLJ9XS/oj9t4m0BxuR1at+Y9KTQPEcAq2reFkq4IHLHtje7CcToIptH50UdwZ+v0LE
         1/+tiZGV0UgQEBZ7MLZLySZpfZzP1oEPV+LgbHpRibVa1eE9y+dyCTZq7RHyG3Fz8GCs
         qOnHlQ5+ycLg6Bnu9S+8we1D5I8whfilgCf/+GkKn5rHzaC6//LFt8QJlwJTYzc8TKEe
         FUMg==
X-Forwarded-Encrypted: i=1; AL+hErEUMN3lBHclh6jdbbo+nPS+E1C9uKOYRN/V1el4dk556qCFv/cYpCD+0rax1zwmQ3gLU1BSJUGMaWhD@lists.infradead.org
X-Gm-Message-State: APuU4Z+I1/3wsWU+ipDBXbT0ImjRdowbYXBmY654FJrzT42EfWwoS4cs
	xCSIASDF0tM81JdC/RgsJ+rfTW1J4K+DpjQNOL4t9HHK6sA276HA7CpP1sVnW/NUG36a
X-Gm-Gg: AYBFou1X+7YQ6/7qEsTea+4ShNhOEAhADj5hacosbm4YcWgtgDfZ+jlVPeb76kuBzV+
	SUeQsHc+gxYcAOW6iusUrKS+MUNo0Buh0OkUET05Nuvf4HLPWftGgu7P53F4TQgUmi3KOtcIsfp
	bigrDHq/5jPj8S5ZvWLrxzqbR3IaYbcjbxCtbSEArYsap9QNsZ5TwIKLTyMhzbzvktAVmAO3V8U
	ZssCrhxnorI2S9y9tuGUn0jaRf6AmcHSpvttPClCr20MGRF8SMl8L1exfOwAdZLxjUyYus7PpHF
	x9a/UKTXjh636uIMeDxA7A0ci7S8Jul83QyLIcz60YQ+cJztceEQTQ9Kq6XD9ycRoebLhb2MNgT
	JRUwGBioQEDR4lmPWyMoAuS8aUzDRuy1sEA//PkjM1GVyVVei4/utQcnd9RRSUQmKu3pdQfKhht
	Uz/uLx+gcNUC4Q0qPgw9aeMUL2rXL0HrJzLf6BGNM5rWBDSvjGBR5B4FG2c3ACk1GpQwavCE2z7
	FeHO2EFzCVZbdd6cFlHGQqjx8bY7wf1z4zPXfUi8bT7ZxsnhEHj8en/hwZJw7CjnxiLBF0iQi7P
	BdEd43BS0GobMl2pG+z4lsjVnWUCausNeEcbu01SzvUEgyBRdldirlWfZpD5VCk=
X-Received: by 2002:aa7:c842:0:b0:6b7:82cf:f69f with SMTP id 4fb4d7f45d1cf-6b7c0ceaefemr1298014a12.41.1794564171137;
        Fri, 13 Nov 2026 02:02:51 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7c262338csm739270a12.33.2026.11.13.02.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:02:50 -0800 (PST)
Message-ID: <06b194053de4f4b65895248d1f2ba29d42a21b17.camel@amutable.com>
Subject: Re: [PATCH RFC 06/41] proc: use fc_init_pseudo()
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
Date: Fri, 13 Nov 2026 11:02:49 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-6-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-6-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261113_020254_106787_8DBA2EE9 
X-CRM114-Status: GOOD (  12.83  )
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
> Initialize procfs as a pseudo filesystem instead of raising
> SB_I_NOEXEC and SB_I_NODEV by hand. This adds SB_I_PSEUDO.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> =C2=A0fs/proc/root.c | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/proc/root.c b/fs/proc/root.c
> index 7fbbe92bf73a..ca0e75081934 100644
> --- a/fs/proc/root.c
> +++ b/fs/proc/root.c
> @@ -17,6 +17,7 @@
> =C2=A0#include <linux/bitops.h>
> =C2=A0#include <linux/user_namespace.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/mount.h>
> =C2=A0#include <linux/pid_namespace.h>
> =C2=A0#include <linux/fs_parser.h>
> @@ -265,8 +266,6 @@ static int proc_fill_super(struct super_block *s,
> struct fs_context *fc)
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> -	/* User space would break if executables or devices appear
> on proc */
> -	s->s_iflags |=3D SB_I_NOEXEC | SB_I_NODEV;
> =C2=A0	s->s_flags |=3D SB_NODIRATIME | SB_NOSUID | SB_NOEXEC;
> =C2=A0	s->s_blocksize =3D 1024;
> =C2=A0	s->s_blocksize_bits =3D 10;
> @@ -350,6 +349,7 @@ static int proc_init_fs_context(struct fs_context
> *fc)
> =C2=A0	put_user_ns(fc->user_ns);
> =C2=A0	fc->user_ns =3D get_user_ns(ctx->pid_ns->user_ns);
> =C2=A0	fc->fs_private =3D ctx;
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &proc_fs_context_ops;
> =C2=A0	return 0;
> =C2=A0}

