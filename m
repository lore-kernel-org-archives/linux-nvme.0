Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF3C606A329
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 23:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=YXmVa5/E;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LqWd1b6/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=FEtpE65JhLGyAYaL/FOW2ebUIws2WwBZ/4Zy8VNXUuw=; b=YXmVa5/EhHb/7f
	4S23UjMEOf8Qw80BIn+8Bpu0rISBIaA7iEgRJ9tBJynRoEZibKhdcdrrjXvunxkQ0sYpknLMKRwIu
	j5rHemsSQ6xU0kYMclAz0jmj7sG0/NLFmRbI9NblpaNj1n1oT4dP5NoDEacbuofWzvfGWeGhyRdb/
	f1BpI96OjAfn3we1S/6S/gujolIIfBzVaFYzodXi4AdWk+MJ9CwG1f1Ri/xUXh3DkmHBAnnVu05Fy
	YnWTE8/QeX3BGgxUUbTmI6Qkm5P8+UU1ggDe1dBtQqs5LVMXrtiHnwhT+Jb0Wit1O6Eb1eeh8p1hC
	kKWeMdky9LPnKjHh4J+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xT5oZ-000000047go-1Ks4;
	Mon, 16 Nov 2026 23:08:43 +0000
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xT2vy-00000003ouT-33JK
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 20:04:12 +0000
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-48e47347279so1838152f8f.1
        for <linux-nvme@lists.infradead.org>; Mon, 16 Nov 2026 12:04:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794859448; cv=none;
        d=google.com; s=arc-20260327;
        b=jdVOC35AgUHPfyAOFC6Us2Hn/g+MkAMXLl3A8nzb8i7RCvhvX+JA2wUSjmDVO4MERV
         GFMZCiGtj59Aj7EntXIBT8ChYoC9oB6GWShWO6PWdA9qHOWeDyxRIH66Ho3TDKXbKXH/
         5NZB20fGAQkkOSl2iTilf/sPRLYsbbUYKbVRi9RODwtklCUEFRAliVDktQuB/BqrtY4J
         pF1InBhRcZmprYmX5kh8P+KpijSZvvvkLco6PdRm+RBI4PQLH/GzZ4dyUfYgrzi56LO/
         Efa2lxYhu5yRh3A/CpWYU3yGU/R406jPiMsFojQ55jIMFIFoog9Hw7NrzhhgogiWo+Yt
         e+nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FEtpE65JhLGyAYaL/FOW2ebUIws2WwBZ/4Zy8VNXUuw=;
        fh=H6Ggzr0QBjDPU/y4x8Vue36h5C/j0BbNqG19rm7MqUI=;
        b=A+Iyxgrn25YjoWSu3Zd5fnopiIGdj9nXNGNCIkCPSW7NboZ6a6r8cGS7Xu/s1m9FYO
         SWynv2LBBU428wrjAd/VzowRYKdY1Ftzzfe5aZHGjZUACMYAaPkMc4Wn1kX+BZ8ZCQhl
         y3H6vnQXzcFGzeB3ZhsqepU8dBpTNFCspNJ72FvWYW7mYqvp8NgGKZT424x4pxjBciWr
         5b4FPcOAnHMfyc7SoZn1xJMaWtBO5TCuH+nA7Y5T0skW833bCVJY6XACzXYAmFBmS2tJ
         Q6Th/D03WuNt+e6pKi+J5XkyAccwKSby+iDzcJW+z2btOb3f+sA1ir7LEwNeCBt9qapS
         ggpw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794859448; x=1795464248; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FEtpE65JhLGyAYaL/FOW2ebUIws2WwBZ/4Zy8VNXUuw=;
        b=LqWd1b6/pn8hMMY8e9LHjWDQF4fZ1QMOTmmPcudl7DXrJgI3hGdzPbIuc1fRoGghhJ
         s20AZdqFpxC2be3JU0XbgJDIc/sfXeB9XHjlkTr93f0KM9nseUe+ha5uMnYxvzqACnHp
         FkZWOJSDnQOBGSj2+sSxAfwZ+bJnS3RwRYCs6Vel9UMmNBBeU+s8F2ADvkTukbTjTF3N
         PDyYpwey+6qzmUmrsRMPwqPDIuFZpvj11juZMCLFzIBYA/3+d5AdXsF95khONg8DiqV7
         u2VH9NRRsrEfmSIKAgs2wIG/vMbu8+W8Pzhjo31oDHSno5g+2XrL2Ss6nwIbg6sMwiYp
         UmMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794859448; x=1795464248;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FEtpE65JhLGyAYaL/FOW2ebUIws2WwBZ/4Zy8VNXUuw=;
        b=fFoqYIArtYhFZMnps4lzZC2FgESviHn/JLf0mnHSvCt/71RK8eDXYtd0Lef0q+YBwG
         w73WMd/fToF0hBEFMAGL2d96nrFhMiv8ICbW/HdduN2p93Bw1DMCkxmrHktCN4tMsNYI
         dcG78flOH4twrAHMEZUw6oXErc5+vshBaudFBWZXlqGS3eO+BGTobr9YW4wiHJVMqUnH
         KmwNNg2OpmPY7gs7SGQZzBanPSzO/p21Fipq1cEMQZ0l4DscbgC/DAXdy0WJUj7T0T8i
         U0aOs/jchNwGVmUl1dUT3vy2Bo1aKs8igJgssH+NsVeN0gkXde7y/WDEUBSgqOvOPMje
         deNA==
X-Forwarded-Encrypted: i=1; AL+hErF9tWWMZTFahgJOxOo5ROXWhJ1I6dEM4uBlHmdrjO5tF+KjeTZVB2JUrNPtZv9tCULMnkkeNeWn3sld@lists.infradead.org
X-Gm-Message-State: APuU4Z/T5lghBMg8fAbFuKJfO3NaLoGgOnJgFtfHSisX1mDp5Xvswb1v
	K/CqX8my7OGZ93zJnT+wWFTJXDmSHPGJgDlruHfWciylm/iMiXScWE/Jl8o8Vt+eTvlo3VnX4lg
	QwQB0QgWO9nWzkePhUUJc7hbh7rAITEY=
X-Gm-Gg: AZFdTZeDiUtthyaa4CkpDbDlMWf6XIL+3VIzCEx+LG3utMTN9JIgw7ZckxzEjeSfI8/
	NYC6JWMVZpM3hKeGcxPu00ovaqNsyV+F4DyP/aofUEBbQnbcO49PfWtXuyP8RgvqKNJZjzXQdqW
	ivQi8dYF14dBGept5KI+CxO+neIpe1H+eYykb7okyY3R24yY4pzIGZAU0j3Zhz0XGsLXPryhy/W
	XuOm/FSX9zPTtaioetmThHeVkTJFOVIGk6+dK/yBoavulk2ID/GzfIL1aZfewzC3YUNnfvWxDKe
	6Gt952yL2IZEA2vchQD8ex6O42KBY6KW/yNVa9WqRVSRKsxZBCQyc/AAsYGJO4eFnuq0Hw4Tm0K
	8DIGqtDIgumYK7GFHMM+CxhtPNzbIWgYPnj89OBqGU1ufMbzSnq25NEu15b3+V9CnwIukny+Rl+
	F7vPCbcxVQTm39Kielp2o=
X-Received: by 2002:a05:6000:4692:b0:491:3fdd:af34 with SMTP id
 ffacd0b85a97d-49d61c80db3mr13343868f8f.36.1794859448335; Mon, 16 Nov 2026
 12:04:08 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org> <20261116-work-loop-pseudo-v3-9-8cbbea1cf34f@kernel.org>
In-Reply-To: <20261116-work-loop-pseudo-v3-9-8cbbea1cf34f@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 16 Nov 2026 12:03:57 -0800
X-Gm-Features: Aa3M54q6P4M0RFDCKQ8HHGNCWJafItTSPdWR1qNwVGtToDAv2VOv8vDfWHzYR6A
Message-ID: <CAEf4BzbLFVawibuX0wk=8uzy0WZSYHbkgK55d7rqLab2qAM1Fg@mail.gmail.com>
Subject: Re: [PATCH RFC v3 09/44] bpf: use fc_init_pseudo() for bpffs
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, 
	fuse-devel@lists.linux.dev, linux-efi@vger.kernel.org, 
	xen-devel@lists.xenproject.org, ocfs2-devel@lists.linux.dev, 
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-usb@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>, 
	linux-erofs@lists.ozlabs.org, linux-kselftest@vger.kernel.org, 
	Alexander Mikhalitsyn <alex@amutable.com>, Chris Down <chris@chrisdown.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261116_120410_785310_F54D8BA3 
X-CRM114-Status: GOOD (  15.67  )
X-Spam-Score: -2.1 (--)
X-Mailman-Approved-At: Mon, 16 Nov 2026 15:08:42 -0800
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 16, 2026 at 3:21=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> Initialize bpffs as a pseudo filesystem instead of raising
> SB_I_NOEXEC and SB_I_NODEV by hand. This adds SB_I_PSEUDO.
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>
> Reviewed-by: Chris Down <chris@chrisdown.name>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  kernel/bpf/inode.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> index c6f328e4752e1..57cf3775c0766 100644
> --- a/kernel/bpf/inode.c
> +++ b/kernel/bpf/inode.c
> @@ -15,6 +15,7 @@
>  #include <linux/namei.h>
>  #include <linux/fs.h>
>  #include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
>  #include <linux/fs_parser.h>
>  #include <linux/kdev_t.h>
>  #include <linux/filter.h>
> @@ -1197,8 +1198,6 @@ static int bpf_fill_super(struct super_block *sb, s=
truct fs_context *fc)
>         sb->s_magic =3D BPF_FS_MAGIC;
>         sb->s_op =3D &bpf_super_ops;
>         sb->s_xattr =3D bpf_fs_xattr_handlers;
> -       sb->s_iflags |=3D SB_I_NOEXEC;
> -       sb->s_iflags |=3D SB_I_NODEV;
>         sb->s_time_gran =3D 1;
>
>         inode =3D bpf_get_inode(sb, NULL, S_IFDIR | 0777);
> @@ -1261,6 +1260,7 @@ static int bpf_init_fs_context(struct fs_context *f=
c)
>         opts->delegate_attachs =3D 0;
>
>         fc->s_fs_info =3D opts;
> +       fc_init_pseudo(fc);
>         fc->ops =3D &bpf_context_ops;
>         return 0;
>  }
>
> --
> 2.53.0
>
>

