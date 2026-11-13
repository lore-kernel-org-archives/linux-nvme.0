Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A07606A327
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2026 19:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=zkXtMYUX;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=GAYwxhgO
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=PGZ86VpI4/X6bkLIqgY54HnsW6MSps296zHbeFwxlLU=; b=zkXtMYUXapyX2KMkQk992HRC7k
	8C5z+QtKtzfxTAqaSFfbmk1J1NGU8o/gVsU5lzMAbaXE+sQvd0ywJnMIO+9av9NukN+TFyAhpZNDE
	Td0idsDLxFUw7fy0AEUUcK9EYhEa6rqvMzjnQ2wob6TPwFcsheS/waBIjjeLdgIa3MKtNnFt/+cdy
	DOaCOdDAU4P6hP4MxsPxiv34Ke79F1QKLSH5jAmvRS+tLUj48b4nswiJmZEgb4gyCKm5KcanbfPPd
	Hh4eOVdOFGkA1Z1yPV6vKJ0QBM8qnwhlKMttRjx72f7/pocyfX11FZ/TKclkYM5R8i24qevydjapm
	0wo9/XSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRx3W-0000000ED6S-1148;
	Fri, 13 Nov 2026 19:35:26 +0000
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRoHI-0000000CJlN-3lda
	for linux-nvme@lists.infradead.org;
	Fri, 13 Nov 2026 10:13:06 +0000
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-4a214c5c4c0so10676575e9.3
        for <linux-nvme@lists.infradead.org>; Fri, 13 Nov 2026 02:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564783; x=1795169583; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=PGZ86VpI4/X6bkLIqgY54HnsW6MSps296zHbeFwxlLU=;
        b=GAYwxhgOnyx0RdoHBlFf1AeYK0fuv6QNnmg2rMRtwWLu/gNvOd/zIK0DlgWFHANZ7s
         MxKTkfhfnOpIXAylTRICT0GDm8jngHY72pDr//1MuA5lviYhKLGQ5uCrv5vDay0EuQMq
         0X5dNh4RYtYzIKYlqTjVjZFaRqc303GQ0qgmO2M3/7F5UeeToMTEONrFRgsbii+4ySEy
         zzpx4qGN9bDTtRbY/aUz8BZCRLOpSwYPY67T43bk+leDem/+gzCFRmXkHJpqzEwwBtsv
         adssf/XsYlOq/mlYqtFWabiIaesbhZAf7mchvg1FeuNRUglrLeBv7vou4/KkyMNnQQ9O
         k5fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564783; x=1795169583;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PGZ86VpI4/X6bkLIqgY54HnsW6MSps296zHbeFwxlLU=;
        b=02F+UVGfOFqiX3sq8EwFuLf2zVq2dzP66HGJQErnrRaoE1OH5DBrNd/hN0WIJrAW2l
         TR/XSedhAKp+zuIqonvfAnDQXXyKMclhp7GXPX47yK3Z6knQhOlFNMe5W8GNrbtpLa+d
         wOi2wLT6fnE8ht/b/A3HWzYYZJ2f2QkedUPYddNO/SBtp9l6+cb9gOb99yPBLfwsdnsk
         +Kay8ObOSFMCCCbjjNPr6PCQ12pvCNS7tzY+0lW5KFzxLvxHNl9Snr3oIgKqpsqQuOJO
         nwuU92GjS4SLPxWO7r3GlFydKnNXf91ORDBXgx+vYBGEvkrIjHyZCEb0xgGeU4El0fOl
         KwMg==
X-Forwarded-Encrypted: i=1; AL+hErE743/oucmKtY8f+j48csDQmH0SXsirzgU3tEDZ7g4WAz3CW4jlPk3i9Kp2cbckMsMOy8z/Sf3koY2x@lists.infradead.org
X-Gm-Message-State: APuU4Z8joxnMf1R5sk7w/mp3VgFhRxkKCydDodOXXqWsdwV7UZxEy6zl
	90MiumqZCh2h1ly5RiMndkQuUP4N5lxkgfQxyAWwpsNnxoeA2NLo2uYhCwmPmIM9tmhi
X-Gm-Gg: AYBFou0mXlYildE4evuQ45SzydYwnE4LWjp0cUwCwFdJkD2BaDR9Yk/1AJEJTy0fDlm
	7jYUq5RT61OeoORhxyYe3obnGFuhrwB1fkpUDL2U+7I3sKHMvoLG9tTjoPAhne/qK/wYl0+T525
	afuKjw8NG6dkVDGHJZKDoB5fONGpdoeuEKivmTlcOAB+c+PFpRTEAAkxHuj3vK46ttLWY8gYpM7
	S6diC9/F8qoIkjEu5oA2NNQk4uGyhJ0TDDCXgg8T+GLqWokkzHqKj+qX/wiJ8416V0qpuAkeL2w
	SzUkg1IiF3I3YjYvJGkimfNUHaKpN7dB+hJiqY1Kq3zJoqIzqtqBJTjYG0TlZOsg94UdVUjl5FZ
	Knlo8BUIyB/lOyuDzcTn4TzYJErpECvxVTU+u4sbnvRR3dHuzs18UBuQao25jjTXCnDGDvgKVt/
	4J7NaN4YeiDAIUShDUnjax/KMn+9MkzBdbvzlxIKNnLmlU+ZULonMYmKJ/ikRSJmbZ6k6rMUjG9
	Th626OX0mY9WVV5xAqgtiAoxAN/+5KLfJTYVqMPTfMZm4vVbOSO3Hie6eycC3sdJ6vn5m3n8mQ4
	x12WQdpi1mLZ1EII9o73DZiDkkY/GFVsM/OiCt+QSorTkpRo/ty8Owoy4sssNpqz
X-Received: by 2002:a05:600c:4f90:b0:4b7:6c16:7b43 with SMTP id 5b1f17b1804b1-4bb55a47602mr36814615e9.10.1794564782834;
        Fri, 13 Nov 2026 02:13:02 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb5d2872edsm4056955e9.12.2026.11.13.02.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:13:02 -0800 (PST)
Message-ID: <94dfa5ec75f4479663dd79f3ce05c1dc6c080185.camel@amutable.com>
Subject: Re: [PATCH RFC 22/41] sunrpc: use fc_init_pseudo() for rpc_pipefs
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
Date: Fri, 13 Nov 2026 11:13:00 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-22-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-22-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261113_021304_953049_CF9E9DD1 
X-CRM114-Status: GOOD (  11.46  )
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
> Initialize rpc_pipefs as a pseudo filesystem. This raises SB_I_PSEUDO
> and
> also SB_I_NOEXEC and SB_I_NODEV. rpc_pipefs never holds executables
> or
> device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0net/sunrpc/rpc_pipe.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
> index 9d349cfbc483..37277a6d2415 100644
> --- a/net/sunrpc/rpc_pipe.c
> +++ b/net/sunrpc/rpc_pipe.c
> @@ -15,6 +15,7 @@
> =C2=A0#include <linux/pagemap.h>
> =C2=A0#include <linux/mount.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/namei.h>
> =C2=A0#include <linux/fsnotify.h>
> =C2=A0#include <linux/kernel.h>
> @@ -1181,6 +1182,7 @@ static int rpc_init_fs_context(struct
> fs_context *fc)
> =C2=A0{
> =C2=A0	put_user_ns(fc->user_ns);
> =C2=A0	fc->user_ns =3D get_user_ns(fc->net_ns->user_ns);
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &rpc_fs_context_ops;
> =C2=A0	return 0;
> =C2=A0}

