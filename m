Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD92606A32D
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2026 19:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=iYO48p9C;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Vt2gj+QB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=fNM18G1T3F0ezY9f7dMoEwC6d3kOVWk14Z1vuqkOGWM=; b=iYO48p9COmHXiskStcbgPTorq4
	bantwHwSLLTGOdPH/G+ZXq37q9YONtjtH5CBwuGmcMZk6mFcF6SAkm99ZtvwuOmdMw2YQp1+Yqaze
	BNG8mxs0KiG1FW2hxo3U7BvqnNci5/RnbOApl3iP5k9CcMtThQD4Y+gMUX8iu84kskBZTQjzrJTP6
	5jX68hZNOQzmB9yoxnkjNgL/hcxvlXE4NMiWdjIMA2XkamGeUQPPqnFZWQnIszT84FE4ZAmSigSdw
	InqmE7z7j8rDHfzjXhxd38Nnni4/88ACjSY9gnOsm4F4Vydy8+2tv7tl9ao2Z6xiM/QTszYxlS0yr
	0DeZ2Txw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRx3P-0000000ECpX-14if;
	Fri, 13 Nov 2026 19:35:19 +0000
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRoA4-0000000CIZj-0ACD
	for linux-nvme@lists.infradead.org;
	Fri, 13 Nov 2026 10:05:37 +0000
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-6b7bfefba55so1543248a12.0
        for <linux-nvme@lists.infradead.org>; Fri, 13 Nov 2026 02:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564334; x=1795169134; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=fNM18G1T3F0ezY9f7dMoEwC6d3kOVWk14Z1vuqkOGWM=;
        b=Vt2gj+QB60U0OPgjIQxLvrN4UkO+VtJmMtLqoZ82KhYjLRew9d5q+2+7aVXhqrE3uv
         ga53nBRMpknItk+hj3/ZS+jiTuZb5smjXzrLS9poq9Efj46Z6bUBFYmH6pNsuUxQT1bg
         5W52g2HNrT9Xv5QQZ90hdGpqiS3/cxezPciOXwKyJUod0JBvCZMijbDUdBNc9Gajpoc0
         gWF/S/9g8ggJJkQE2XBjvlNCQGkVLdhwKD4l9AwtIzocuKDlcLNLKs2hUdZvlpYWAY6L
         DbI1SvZkCqUu0clZU+hUPVPeIvxXyWxO8hW1JjHL4wXwPRbcYNmLG4Q57Q9QAbPTQzYb
         u8yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564334; x=1795169134;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fNM18G1T3F0ezY9f7dMoEwC6d3kOVWk14Z1vuqkOGWM=;
        b=ZOxr2s47YAnOt8HQJwdmRgUueS1ar7R97EImsFQAaKR1NfVLBBv2P9b3oe7QN677Fw
         5D9AQBxP5MLhdqk7hnawTAPRpzRESsap0JzqZmWQxI7dNhpnNoK/o7+6GDhKScCykEJo
         W5YWPpbJSy/Nup/zr/gK6xjJ+myco9wuvG0eoLT8OPxYSeAKPZoYKTFbu+ROdHa9m+Oa
         KOReXPdRHmOGPz0saimO/LbQK3XaZQHy6KX4LVq5IEVzsyYVp2c9aWX59e57gYyAq70q
         vsLXmo1qyZtii2liYgOnTNYdz0Y+qppn9y7tURzbnldnBCdiO9rHFx0dSH+uMf9c1RnX
         N1ow==
X-Forwarded-Encrypted: i=1; AL+hErGSUHcCX8BloZF4wJgoA9brhn18OtqFyegBm8Pzon1KCob4EMlwT3xkyzRC0KbPEtFgekcN9zIWko/5@lists.infradead.org
X-Gm-Message-State: APuU4Z/AIbzA3dozbjm3cPeCwz4X7EmFP61i7ZYkK7RB0QPf1Ef1o4dt
	PtbseZQOopSLw3xv0boFnKeZC9oh/WVclEtMjA13Cwnys8Ntnt++W1mOTTXSkYWqpESPezsK8mW
	yW0MBAl/xDWw=
X-Gm-Gg: AYBFou1QYUy4nL9lCsEHcjGhXbJL0S3Am2/6PgjaLTwgVDvHvjdM2PeIY2FkiREitmO
	2KeHDWmIgIOMVimM/L8A/FDR9oWol9wxlqZQ/6W16ObE0kCHmpV175W09t7MJm/yAF5/CvfVPHc
	RnQ2f11RMkRaQz0J6rbMeWOzRkyazXj3OiGg3zMIbv5X/2Em2RSOwvlZ7KrCeEvLv9H/+7w9k5f
	Aoz4fCGNRlLUfTsxajca8Ew0su4zMJ/8KFfbSVWR/FzXX8avMftDPEitqgG+FynP5ttwBfKtuxG
	HS0bI8Qbp72430UvDvnIgAuOdEguYDWcVv0O3BXMXRTMYynSVUwQPPseso0BaEIGmt54Qm2TnJs
	bLhzqbT8W//z2EGP4zf5h6gpA5Gk9epveSOFU5nKEEECD0c1v6k4nXAQUJHnvnztAxAaaPKSLZm
	UA+KtFlV+Tlwm9Ges2+hupSUlVShQfgEUfMIjsdhkR2iRGbQsYIEj4fbVqR6fOoifmmRLNycdk9
	+0ra3unsQyJ385f+bZCFBaqwQ5JKYoaoiVUAoZjAVOkJpzsmjE8gnb1/iRC47ps++kBuRpODNU7
	3yibjopkk9aSxd0C3rZAr4vNwQeamIRsEuelbv5XiG+gRBN044tPE0wnE8DJI8k=
X-Received: by 2002:a17:907:608f:b0:c43:eae5:ee80 with SMTP id a640c23a62f3a-c5096398b03mr148720566b.17.1794564321873;
        Fri, 13 Nov 2026 02:05:21 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b7b2c9sm75811766b.73.2026.11.13.02.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:05:21 -0800 (PST)
Message-ID: <08fa1be263cf4a3db6b3e5ec2847107fba7acfba.camel@amutable.com>
Subject: Re: [PATCH RFC 13/41] devpts: use fc_init_pseudo()
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
Date: Fri, 13 Nov 2026 11:05:19 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-13-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-13-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261113_020536_094099_276BDA19 
X-CRM114-Status: GOOD (  11.22  )
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
> Initialize devpts as a pseudo filesystem. This raises SB_I_PSEUDO and
> SB_I_NOEXEC. devpts never holds executables. devpts_fill_super()
> keeps
> clearing SB_I_NODEV for the pty device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0fs/devpts/inode.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
> index bd1e8eb26edb..47ef12241d92 100644
> --- a/fs/devpts/inode.c
> +++ b/fs/devpts/inode.c
> @@ -13,6 +13,7 @@
> =C2=A0#include <linux/init.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/fs_parser.h>
> =C2=A0#include <linux/sched.h>
> =C2=A0#include <linux/namei.h>
> @@ -438,6 +439,7 @@ static int devpts_init_fs_context(struct
> fs_context *fc)
> =C2=A0		fsi->mount_opts.reserve =3D true;
> =C2=A0
> =C2=A0	fc->s_fs_info =3D fsi;
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &devpts_context_ops;
> =C2=A0	return 0;
> =C2=A0}

