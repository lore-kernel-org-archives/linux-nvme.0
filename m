Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830A4606A32C
	for <linux-nvme@archiver.kernel.org>; Sat, 21 Nov 2026 16:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=n37s4Lfd;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=jF+1G8u7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=zuUcsMvbqw5dxN0Fzu67367bPJAUtTqv88LLlRQCTVU=; b=n37s4LfdrRX9bwrOZOxMeqUQL4
	ElrcJuh8hJTgKnsWrPNiiM8biMUygaSHjBJVOu2yMvYqK3GKxfN/s0nt6i2MlMsadfoLMAMrvg/Rd
	2ia9T1j3WIeHTv2ThpmGBO5klmXOGe/L7nNysGmwHMAlsClwCOVx+u/0TmweIvJtuIQkAZ/Q05bxb
	iT+tlUxHgfjoXiMMIPiiZhS5qChhdxuCDMAtKf9wyYjQKLsbu8sS6xE5q1jHiKusBfK7fMXd62O6P
	X0eSx7KpgK/Ldu+61GuTbAPvtlWj/ajOA5cnQ8kABG4y2ueCEWxkBNi1rAHd83uZqd0+IdA7p9Ips
	MOtpn7cA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUnbN-0000000HPYh-39w8;
	Sat, 21 Nov 2026 16:06:09 +0000
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTEWc-00000004sja-26J7
	for linux-nvme@lists.infradead.org;
	Tue, 17 Nov 2026 08:26:47 +0000
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-49412eb1474so2231629f8f.3
        for <linux-nvme@lists.infradead.org>; Tue, 17 Nov 2026 00:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794904004; x=1795508804; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=zuUcsMvbqw5dxN0Fzu67367bPJAUtTqv88LLlRQCTVU=;
        b=jF+1G8u7J/eJFfjb4Q+2d0FgNYnwrkSuzcRr9gow3ZI1J6pBU32ukCJhSVsoa6XnvM
         8PPseXgIXNXm7ZMh2vAD9P6iPhqP3TPYFiCJIQBzKXYPdILv2Feah1QWeejsWrJ1ZUFP
         Ryl8m2hFyzTD5Tl7YDp+vyJKTWt/03AhF1pxOR4GsMHnYg+/4Kg7KZw/jlinVPCIo10Z
         KQqvIQebS4S07VmfMDj20Zpb856svXTlRfB00LlY0GaeOhH722VqtQxdLmEI8KX/v2bw
         kFd21aRAs0Sxlpw9zCOvcAug6+7+GKd3E/rYLXxVWoj6Tlk5GR67MlDChuQ5GoLdSDoG
         2n2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794904004; x=1795508804;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zuUcsMvbqw5dxN0Fzu67367bPJAUtTqv88LLlRQCTVU=;
        b=Ne4AbAjLSVx0+36iFSyIlukloITfcIIZArUXPVIRu5JUtvazfygDm4qzUbNCjdgQ/f
         amKkIigaAuwhpMKTCj3TulCKplKEHTVrT766yiMtBIfMg1xSeCmEvFPqBWMKAQdHpOrO
         p17Ggj9BJf/eoK+ZIu1FX6HuedAjtQY50FKw3x1RsgIYvOPe4aGgUuLxNSjFwP7JKEig
         qiDYn8o3cpTLoztomp9657McPlep5SnKTlg4J6PqPQrYS1V8GWvkrKtqqSSgxUevvnC/
         uAyYfY+Cb/8o56EEO/AIZr3LMvqtGxFMav4HxmM8w5RgE7w36VirO3SOYR6gaCWRJcIo
         WLxw==
X-Forwarded-Encrypted: i=1; AL+hErGAhwMbbUMZLzAEfS4m6IKq5NU2vJkzdmrIMgSOXP1gLJ//2oFoqZjwou6fWwsNNmZcANch1sZEFAx/@lists.infradead.org
X-Gm-Message-State: APuU4Z+ym2DpKcvDJ8eIAIm+Y+mLSuprsm7OjTclIzL/6D2GAC1ac0oC
	QlbjHrt6kN4dXtylDTskWre58PI8/nTQi45SajuaRwzqxx1i+Zn/7n1J+DI3iEM4tNYk
X-Gm-Gg: AZFdTZcIn2qlgEuBITLul+w6ujyJ6OE5kUoFUreTsRW38ly+LiU+zLQ8/8lWVHFq1o4
	4yx6NtzvAuSyV0YxBpbm3L0jjmsLP8rNhxnkMC28nzmDcBItntrRYeC3foNL7LySnz+KlzMByjM
	r1f7aN8hB8RKWCiXPv+QK0mJwoE5w0gNvUwUcQJd+J43WW1DNbv3Xof/f1+T6dRFskileADWvFd
	tUlAZhVfVcxaT18ZN2gIju7eRFa7Xs/5sdP4yH0EJZldLshLMSMk7KJPpswxScQdp0qr4nNKS0J
	P9LnVDlsh+lC8NmrW2UXRoWI+zZ9fPrUEQZ2e+gWiKcvMc1BypWeGQ6mhqRf4SmPQXOG4qGRTTX
	nKNBk9VDtR1DzJ7eleYvlVq5tpV7C0WreqIQxh7DWx2R51GFH0r/VLJrFcep+VxqafKzjfSmh5e
	tP3fVsPKOlIlYqHo0/ko9EH7jHU9DSxsaDpeSOXLGTKM83fS54xCTNgE+uqSIN6yrHceYHXiwB/
	e2dd9sPU5vkPXhF2ZWVjj2T2vnr92ONkGbv+BVETAjDb/ux+Nf46D9BoVUDNniOzjMJBBXNfW8M
	sGzHu6hOmekjFJCreQwO5f5JPT5W/fSyk7Hkh15+GvqStqBot+6m6eRR2Okr6/QrpSl5LW/Epe7
	sD/vjmTru1UAWiivOc6oHtyx6VySfTaSpvThyh+btGakbO+K3l885+TT6
X-Received: by 2002:a05:6000:2009:b0:4a5:2e5b:51c2 with SMTP id ffacd0b85a97d-4a52e6a947bmr243585f8f.29.1794904004601;
        Tue, 17 Nov 2026 00:26:44 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:de4c:6789:33ce:97c2? (p200300cf572c2800de4c678933ce97c2.dip0.t-ipconnect.de. [2003:cf:572c:2800:de4c:6789:33ce:97c2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a4de4cb1c3sm977858f8f.8.2026.11.17.00.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:26:44 -0800 (PST)
Message-ID: <c43d70badf41f62f8e149ac024bab3df979fa756.camel@amutable.com>
Subject: Re: [PATCH RFC v3 11/44] failfs: use fc_init_pseudo()
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
 linux-kselftest@vger.kernel.org, Chris Down	 <chris@chrisdown.name>
Date: Tue, 17 Nov 2026 09:26:42 +0100
In-Reply-To: <20261116-work-loop-pseudo-v3-11-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
	 <20261116-work-loop-pseudo-v3-11-8cbbea1cf34f@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261117_002646_557769_443B41A5 
X-CRM114-Status: GOOD (  14.21  )
X-Spam-Score: -1.9 (-)
X-Mailman-Approved-At: Sat, 21 Nov 2026 08:05:53 -0800
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

On Mon, 2026-11-16 at 12:04 +0100, Christian Brauner wrote:
> Initialize failfs as a pseudo filesystem instead of raising
> SB_I_NOEXEC and SB_I_NODEV by hand. This adds SB_I_PSEUDO.
>=20
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Chris Down <chris@chrisdown.name>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> =C2=A0fs/failfs.c | 3 ++-
> =C2=A01 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/failfs.c b/fs/failfs.c
> index 437cdc981c2de..f03334f361c0e 100644
> --- a/fs/failfs.c
> +++ b/fs/failfs.c
> @@ -3,6 +3,7 @@
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs/super_types.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/fs_struct.h>
> =C2=A0#include <linux/magic.h>
> =C2=A0#include <linux/mount.h>
> @@ -132,7 +133,7 @@ static int failfs_init_fs_context(struct
> fs_context *fc)
> =C2=A0	fc->ops		=3D &failfs_context_ops;
> =C2=A0	fc->global	=3D true;
> =C2=A0	fc->sb_flags	|=3D SB_NOUSER;
> -	fc->s_iflags	|=3D SB_I_NOEXEC | SB_I_NODEV;
> +	fc_init_pseudo(fc);
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0

