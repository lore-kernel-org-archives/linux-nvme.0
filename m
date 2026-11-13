Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320B1606A32E
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2026 19:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=tK47Xcfr;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=MBzxyYRN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=6cN8hpP/bnwcYzPsZf0cUkd2pk5Vve+UdRh8Jmnig90=; b=tK47Xcfr8WbtzhehlF+BFjIfh/
	zNh0Una6djojsTUla5/sWZgzoGrC1g93FhkzD6VkmIGe2TmhSzVB2XQZZKky61hbYuP8y0szplB1H
	Bm6xKEe2uLVEdHL2Q2poqHTDr/1/8pzBP13miKynkuA3KWhnmnupADyW8NZRj17EIdp4s7v6qNaGW
	0nXNagmeaErSHavAu6nezbJQC0AAF7O77Qh7PwuhXu+a4DsVYVwepdg/JRbY7lxQlZIENeqblrm9E
	t0skDnMVd8BzsHts5Gvjp0FyQk5HRjfp2FeehCLR60nP2q5LXKzB6Ur76PkzwnUpRVJrcpoaSonWH
	1ZIIARwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRx3O-0000000ECnj-1JeB;
	Fri, 13 Nov 2026 19:35:18 +0000
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRo8F-0000000CIMm-0jg3
	for linux-nvme@lists.infradead.org;
	Fri, 13 Nov 2026 10:03:47 +0000
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-6b58cb69927so1442634a12.0
        for <linux-nvme@lists.infradead.org>; Fri, 13 Nov 2026 02:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564221; x=1795169021; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=6cN8hpP/bnwcYzPsZf0cUkd2pk5Vve+UdRh8Jmnig90=;
        b=MBzxyYRNvWxcEZBgf29WyuuY0I+jN/r+3GVJ6JtKhr6hdsbsKGcbr0UYkj/wtYryGm
         C/ZQW5LmA59TfFbNrWfMJrityOvcV0g7lYzTBTES47G5KG/p9eVuVqX2Wa/CvosHpzKN
         NxcgY8ZAFy3aQFOc3+rqDNVGV0qRXYPcOzy7EOw+pmCupO1Yar2DZdAxbyuQ+UfVVedw
         3WpaS7eSEgo6qPiglcqVGhwby1Ihft538mhAMbIxlfEHZ9hRaJU8LClEot5sLxyw33cV
         y+l17ww5UMsI/3fKo4w8BgaDaf0Tl16ODJTQSV80FVc9e8szQOpxGoSozm5bDCAsRatg
         9tlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564221; x=1795169021;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6cN8hpP/bnwcYzPsZf0cUkd2pk5Vve+UdRh8Jmnig90=;
        b=QfgfK+T+tcbZ+v2ksc1Iq8qtcOEbbHdvxLCEi+F/9UjbEZCYk93ktsJ3WZ68wKtS7i
         oUTRjsGo20CwpNsQE9fXFYaaSfSmZyS8Ee+l5aKhX2rRjJV/FbvHB3CCunT1GJDKPfvO
         tPelNzqjBimh8B9mV+R5ARlIytjNoJ1eeGbXA+vqvZXRzCVcKqnPv5sDhRx67F3akUMb
         1sQMPyYQ4E804dDq7UtiOPgebnCZzorhlAPXEIczEdlKPI70/YDOhAKRmvkTdbR9HH5F
         RncjXR4jJNhI1Ufp/wlxO7Qf5LDos7t78tQ693kjPg8L1RfOk2Z0qpho7P+B9+zJ9rm3
         /sog==
X-Forwarded-Encrypted: i=1; AL+hErE8+aTL4Y+gidnwMbboJrF9nW8HK4f+ZzqfVhjwOJrjKfJC9NIKqfTwE5Mlr5BVURDiM7MGzM7nSLjU@lists.infradead.org
X-Gm-Message-State: APuU4Z8m+CIE2asnwnrVvoTcnPiMyAytBYUK/0iYFbPUzCZkhna1fGpq
	exsKsX7+WtF/dAaoCbWuJ8njGQRwEMK/HLbsNeOCDAnuEI7l/86e9vm78POoi970HmbN
X-Gm-Gg: AYBFou2mWCjJL+JEaNNYkDsYW1gqErCcwP7Adrc2oYIeWkoqvNiNRHsM3hr0AmLCiN4
	tNBuP7fRcoK+bz6Sr3UvU/zSCZVVhbUzVzZpeB/4r5uW+nn78Bg39ikHFpxUGZv6062Pt4diErV
	UxS3mu8rzMzjq3aMXyoXvyqb6qutAPhhrSRaljfMZugABI3hwF7SIbGJX0OxUvpIu3u+Bpj3DWC
	anW/bFbYOsLDf3T0D5htgDIy1ZMT8wXr1xmnQ2cVJ5KaRML7W6FTP1aINdzagycUHdP7IMPqq+Z
	lw592+PcBgQHc3CLijIMMuiMBePPkMOZF+PVpdNeoO88nPa/JDfWekIPDCVCFMHyL4GW4HgdE8P
	o0L91+9Q0Yctt3Y+3rEQyuQR8qW5XDLa/JLwbG0Z2brAEjlnqrWoStFcNB8vQdTJMpGrcpVHQId
	oIhw1KtNSbpgrK18q4ooEKoWIZTYw04IgfOTVS6KAFhx0eWNbPusiGy2PUOgf17qg7qYo+4YunZ
	k8YAYwaat6A2uHY8uxgWE+j0JaP87pPWqolPVQwKqxSROZw11xWpPvRSPOaNCGxxUkBrOSaC0Ek
	TB4m25oaV7lczBvYe7+EF6nJzVHULRXAlIDA03B6SY6Jo8atiBxdvIgjNQPI8jc=
X-Received: by 2002:a17:907:7b8c:b0:c42:bc58:f21 with SMTP id a640c23a62f3a-c50963856f2mr175546966b.15.1794564221164;
        Fri, 13 Nov 2026 02:03:41 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b23b3asm74752966b.27.2026.11.13.02.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:03:40 -0800 (PST)
Message-ID: <cfcbef5caf7651b63774549fa1999d34981c78a4.camel@amutable.com>
Subject: Re: [PATCH RFC 09/41] bpf: use fc_init_pseudo() for bpffs
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
Date: Fri, 13 Nov 2026 11:03:39 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-9-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-9-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261113_020343_235579_1FF6B7B1 
X-CRM114-Status: GOOD (  12.31  )
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
> Initialize bpffs as a pseudo filesystem instead of raising
> SB_I_NOEXEC and SB_I_NODEV by hand. This adds SB_I_PSEUDO.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0kernel/bpf/inode.c | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> index c6f328e4752e..57cf3775c076 100644
> --- a/kernel/bpf/inode.c
> +++ b/kernel/bpf/inode.c
> @@ -15,6 +15,7 @@
> =C2=A0#include <linux/namei.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/fs_parser.h>
> =C2=A0#include <linux/kdev_t.h>
> =C2=A0#include <linux/filter.h>
> @@ -1197,8 +1198,6 @@ static int bpf_fill_super(struct super_block
> *sb, struct fs_context *fc)
> =C2=A0	sb->s_magic =3D BPF_FS_MAGIC;
> =C2=A0	sb->s_op =3D &bpf_super_ops;
> =C2=A0	sb->s_xattr =3D bpf_fs_xattr_handlers;
> -	sb->s_iflags |=3D SB_I_NOEXEC;
> -	sb->s_iflags |=3D SB_I_NODEV;
> =C2=A0	sb->s_time_gran =3D 1;
> =C2=A0
> =C2=A0	inode =3D bpf_get_inode(sb, NULL, S_IFDIR | 0777);
> @@ -1261,6 +1260,7 @@ static int bpf_init_fs_context(struct
> fs_context *fc)
> =C2=A0	opts->delegate_attachs =3D 0;
> =C2=A0
> =C2=A0	fc->s_fs_info =3D opts;
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &bpf_context_ops;
> =C2=A0	return 0;
> =C2=A0}

