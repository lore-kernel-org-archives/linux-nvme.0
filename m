Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA87606A327
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2026 19:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Fl++uMOg;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=goncA3zZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=/ZNAGjGCHSUHK/hbpNrctHFuArQcFUaSPHFuYTd8W2k=; b=Fl++uMOgey4MC/xLDYDtAZ05z7
	yj8wVNfWdaUso94Qk8jBhJIU3bjow0QUSjGf3nSlP7Y4tjNIzM20Vx8Cva6OWWVJJrm9VA30vMAIL
	Ygwu+tQ3qe+cagaidddX/XPZ741pAoiItT7W4GqAiAU8UDOeJWyX87H0E23NZhoep7HTS4IbC6RTe
	jOOWyJtNN+e7MwYJwMlyDYsvgbbPTb6MC8Ee2aFrK6ETtv8nUoDLD1LSeWT2HX4DudEzdwLLNi+Fu
	i3XZIdh7Mc01S5umQ2R+88Xmuw9W383hGwYgj3cqT86dsZ0jQDomqfkvyVOolErloVBS3MW5doYO/
	thry1dhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRx3Q-0000000ECrL-08Vr;
	Fri, 13 Nov 2026 19:35:20 +0000
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRoA6-0000000CIa0-1rH0
	for linux-nvme@lists.infradead.org;
	Fri, 13 Nov 2026 10:05:39 +0000
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-c5075fa7ed0so161294766b.2
        for <linux-nvme@lists.infradead.org>; Fri, 13 Nov 2026 02:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564336; x=1795169136; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=/ZNAGjGCHSUHK/hbpNrctHFuArQcFUaSPHFuYTd8W2k=;
        b=goncA3zZVe3QiwXxSPXbQp6NTjvJ2a76z3s1fqLv/nVCnKKPOpZAO6o+uWrcmTXxqW
         COFGXUNqBnxLxvaykdDfLThsockAG+1ue6i1sSL+lkg72i9DC7i7DuDitG3CC1P0pbn9
         iZUGWbpDydDiLKF5vQpnD+3wa3tPULJcm0pvZSmXooaBQNfnPTBHM4KqUmkdqMt2v10w
         exolhoCfkc0rUNREVU9M0z3jea2ew2lXBhlLOOGTwJYNF1WRDnY5sQgQgrLWDInAVG2+
         zTuarQTv6FRPqzyhQlGAzX8w9k4FaWaVL/DJFnY1+eglMFBnLD7Lq3SgEFS4vGNg2ybA
         OK7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564336; x=1795169136;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/ZNAGjGCHSUHK/hbpNrctHFuArQcFUaSPHFuYTd8W2k=;
        b=r4EHVB2wnuv1hSfxB+UBcF70IqvMA9Pgt4l8mKbaBYmfUDGFTksChlq6h0GMop5T7n
         qC60UqOQwgFiGsIxSNziz0dG6kGZ8YeIkN/2swE0iIvsOEffM1HP1z7iQ4M13O5atFsz
         JUqpGBjh/LM4rXp3q9yZf7HRiSH+wKEFe16aeuEbPo8SoL0Ur8oh9zMfzIc4VorKVgZy
         dT+474q5Ta2iEEQeqt9r8N4OVuKaAqctS5SqyDt99TTALBPf+qNYDCK5iSY54aARuWDh
         UMHU0A+Ev7SEMz29z6iASf5A19moJFiotK6PVBJVdOsjioRUXXOmFOwYxpL0WVqT68c8
         F7kg==
X-Forwarded-Encrypted: i=1; AL+hErHAZNgUopdzmaIEgAsIqhD6MkuidfXqa2GuptRmrMFP0P667QHQgPoKLjIB4YTbXt+YWhNAwI2wSBVt@lists.infradead.org
X-Gm-Message-State: APuU4Z/YfWdpLvayj0ijirfXckaOegCbNbVwL6SWs51tGV3wd8+Nj23d
	LBYX4lZjOgAsk5pO1cbrMeqtc1JYuSdtvwq3B2LdM7JTC1ERoN/9GvbaRImyQ1Hpy1Xg
X-Gm-Gg: AYBFou179sqpUsKIbNSoefDU3dAt4vDmZjK0VJykowwNLJYmsDuFzFyVTPFqelagVVW
	HtLqvB3J2wQDntXqin1NgmiCOzrMutIzxCMbPzFuEEymJjhaaGMHCpKiukEpAf1REKm7XI6qO6P
	iOMXdO3q9QTpsmLGWdnXEqg7qGF/8zmV2+Jc+HDL+sq0wyERFKrAcQ61+OBSJj8bCLGuQ/GuD7h
	GmVn8eLfYDjnGEEFTl5gsWT12J4ug3jgTIrnVW7weB//5wDCmk2l2GQ2lXuAuPtSzl73fm+gVD1
	pDHNJHxIc55dR+TME0DH7JP+GGJRA4seJKCWZhg1+BH8WmoefQc8QUErdRyVEomrH/yf1zkGEb/
	2qY7r+K0dyzMuGp3I1fo5AW8bLZtPsumvQfjeyuyP0EFj7+qO2CJ3pFP44Qp/xHQlJyecNYWINP
	MaQyN2to7nJJLGRPUJ87GY3ukka8GCn16Y+LfqL7OGxLmzj5vnS1mU1WQhrpSawNjkoEipZm3E4
	RcRQW4jWyZoO3gwss/OCB163K9OEH5xilIQcQkU++1bHQIstQN3xNBy8PvaICKXfuBREtEeM4+V
	Qj0GFC81ujbL2P1ZqSZTqSyk6y+awoDnibASMsjH6JLo6EePUZWqTK7aJPWyDGM=
X-Received: by 2002:a17:907:94cb:b0:c2e:3a72:ffbd with SMTP id a640c23a62f3a-c5096389759mr162937766b.41.1794564336347;
        Fri, 13 Nov 2026 02:05:36 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095a5b93csm75365566b.5.2026.11.13.02.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:05:35 -0800 (PST)
Message-ID: <8f532a01f6cc2eb73582864343e25be4ec990919.camel@amutable.com>
Subject: Re: [PATCH RFC 14/41] debugfs: use fc_init_pseudo()
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
Date: Fri, 13 Nov 2026 11:05:34 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-14-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-14-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261113_020538_498246_8C81A438 
X-CRM114-Status: GOOD (  12.20  )
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
> Initialize debugfs as a pseudo filesystem. This raises SB_I_PSEUDO
> and
> also SB_I_NOEXEC and SB_I_NODEV. debugfs never holds executables or
> device nodes.
>=20
> SB_I_NOEXEC also refuses PROT_EXEC mappings. The debugfs files that
> can be mapped, kcov, relay channels and powernv's memtrace, map data.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0fs/debugfs/inode.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
> index b4915551ad31..f163f0bc5703 100644
> --- a/fs/debugfs/inode.c
> +++ b/fs/debugfs/inode.c
> @@ -15,6 +15,7 @@
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/fs_parser.h>
> =C2=A0#include <linux/pagemap.h>
> =C2=A0#include <linux/init.h>
> @@ -317,6 +318,7 @@ static int debugfs_init_fs_context(struct
> fs_context *fc)
> =C2=A0	fsi->mode =3D DEBUGFS_DEFAULT_MODE;
> =C2=A0
> =C2=A0	fc->s_fs_info =3D fsi;
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &debugfs_context_ops;
> =C2=A0	return 0;
> =C2=A0}

