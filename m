Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130BD606A334
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2026 19:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=H/nSCQ0b;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=BpxcsSKF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=LWRhkHq/o14g3eGvU8PB/2eVsiZ8AcgjQiitoPu4Uko=; b=H/nSCQ0b2Pw0as8VyHSDJcRhxF
	7syXM4xAcEHscQwpsCf7h51MJu8hco1VNHwbMluIrb6UXUqhPk1c3zPgRQQXeyC3V5AmcRcA4XeKS
	G9vRZW91Aeya6rOEEAadxVSo2EPS4zc+sx45ZZwiTpTARcdI/MYode6RJZcJiqk611JbnJ0UYQQs3
	1tmTxBR+2k3k69EAy1ROnL9/t3uwzfP9FOyLLVJjoaSP7R9oVo9FbBtB04tGD0ZPPneVj/hWXwxdL
	YlqDuchrnoBRl1OOlXel3DXN0NjzAamjD37OcEfGMG9hlxNEAQaF/+X33obYH78jHNxoghcRX1aUb
	SEhS97vQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRx3Z-0000000EDEg-2Q67;
	Fri, 13 Nov 2026 19:35:29 +0000
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRoID-0000000CJtI-0Uus
	for linux-nvme@lists.infradead.org;
	Fri, 13 Nov 2026 10:14:02 +0000
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-492690dd5daso1015561f8f.1
        for <linux-nvme@lists.infradead.org>; Fri, 13 Nov 2026 02:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564839; x=1795169639; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=LWRhkHq/o14g3eGvU8PB/2eVsiZ8AcgjQiitoPu4Uko=;
        b=BpxcsSKFeHaGOTcq6G2/LWT57D64EGv4WN1zp+Uc8f+rZ5+6r38xKPVGy6yazDUf8o
         8kqtm001Z374DD/wO1DSh1bFmY/nXUfLOVx3RznPv+AGnQVvjelGwokqfZmiKBqPJEDy
         9tOtev4+O6ZkBWLF5F5H2Lwr5HewAPtUbQk/gExhVuAHnJF2yPVhOH0NQe2eOSfF7b7n
         9uvC6BVG3oGzlqfMvriqD6DBWyQRaZv2myKptKaoXpo3r3YHSlvBHb4kJu3NTa939pDb
         SfJfQzbZ5jTCL/EbwrD8tRSTMN6sRXSrDw5sXBsrQj3Ynd1HpW336gaxB7bIu5fXnTgM
         /AKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564839; x=1795169639;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LWRhkHq/o14g3eGvU8PB/2eVsiZ8AcgjQiitoPu4Uko=;
        b=qRAJ0Enb3WYLzHl8GsRE9V9wU944OeTs0+lTt7s3Pt++x/LwuU4yxIiSgzyU7gl+By
         NLQBW8rLSpJMvCTrQsZjEYViBvMyuPDeZyxutB54mFG39bMponS+PIwH+I7AF3swAlu+
         +Uk/IPUKadnLNDFqObadOficnXNUVkQie4ExLfxF9xzXSgFY6cddq/dGTnNneEZ4qHJT
         jS+cHoIwwfD+900UhMzYiS4nOLIXLTrmJFZRXLeeM1B87i0RtNmW04tfdfNGDgYk0daq
         6FgwJzPUaCPv0L+sEoeqoHB6zd55ABDrPfrxSUwB6M/6D2G/Fe3tTx+UGbAC/kRElIJT
         IwZw==
X-Forwarded-Encrypted: i=1; AL+hErG+3Nk/qp0kYnvU41Zf8BTmlBH+sWTgFxnGCWogKuBbBJa1rmCPG5C6UyM5XlRQ9/dixFZcp5BpKPc1@lists.infradead.org
X-Gm-Message-State: APuU4Z+kcuWNhBbBuw1f5+sm0I+PEyOK4e5Oli7GWYUqxeDaviDSb+XQ
	/Nq/QQQmxdBj0/vYSqTbbkZThGyQ0lAqdOKgBdjzpGohh9+bQmtHFhdjXUfHgkin/KvP
X-Gm-Gg: AYBFou3vKTTV9b+Afl5MM1d3O9FcQrqVfFgKlZVA4zghiAzA8iY7TZm7jEUVBUntolg
	c486enHu3YRqIOcCvLGzNYD0Hny43UTSyOsSZiHsoQfqTbOM47L882Oji07tvXBokvsarfNqxM2
	6yVmjsZqsUQWwHFVicR6o4ToIAs4Hwrpbj789PzNyFiNcZiX5pTIS84eP65sjNHqmcwqelvtrQK
	jrGgpikaWYlMpqfBwgv29kvq+Dwl9HW6a2ohwKVPudnf8xdDuwTIiq9JYYcfSVnHTnKjzT6CTDd
	cYcITDowZyFIBpY274u//Tbh2UsjZC7aU6R5dl8jfeTBjInYbLwkYU6GYjfpbOlNDx/G77ZTnZj
	zJi0dwxOyEyJ/x3M1NsmBFRZcI/gRt4QIzJJ+17DSJr/OrkX7tpakPeFTXyNJvp9vLMvVr1WA9H
	0wiLpvZNoFWylHORCaCeEfx70yJNxWlD2sDfyw69xtx2Esjs1su4IwiE1gZBZuTjSfqj5+9J2rj
	3aQRQpptCLBcLUaYS/AP50UgfNiJau1UV9M4zvU3OXfcbNhmis5VOGRh1e8K2XeZ4/gSvtGGkH+
	/zk21eDqlQhQjgL96QOmB7EnFmHDdDk6fBhLLsmsFqwpRddfifMTCCrljyfU3Xs=
X-Received: by 2002:a05:6000:993:b0:48f:bc59:ab9c with SMTP id ffacd0b85a97d-49c6fd932f0mr4358101f8f.12.1794564838578;
        Fri, 13 Nov 2026 02:13:58 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49d673ce75fsm190118f8f.55.2026.11.13.02.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:13:58 -0800 (PST)
Message-ID: <77855be3fb9f0e1888c6dddc56d73a1683c820f0.camel@amutable.com>
Subject: Re: [PATCH RFC 25/41] pstore: use fc_init_pseudo()
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
Date: Fri, 13 Nov 2026 11:13:56 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-25-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-25-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261113_021401_202904_90004318 
X-CRM114-Status: GOOD (  11.03  )
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
> Initialize pstore as a pseudo filesystem. This raises SB_I_PSEUDO and
> also SB_I_NOEXEC and SB_I_NODEV. pstore never holds executables or
> device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0fs/pstore/inode.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
> index cf499ba72702..4658561cf90b 100644
> --- a/fs/pstore/inode.c
> +++ b/fs/pstore/inode.c
> @@ -18,6 +18,7 @@
> =C2=A0#include <linux/ramfs.h>
> =C2=A0#include <linux/fs_parser.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/sched.h>
> =C2=A0#include <linux/magic.h>
> =C2=A0#include <linux/pstore.h>
> @@ -491,6 +492,7 @@ static int pstore_init_fs_context(struct
> fs_context *fc)
> =C2=A0	ctx->kmsg_bytes =3D kmsg_bytes;
> =C2=A0
> =C2=A0	fc->fs_private =3D ctx;
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &pstore_context_ops;
> =C2=A0
> =C2=A0	return 0;

