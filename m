Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F6B606A33E
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2026 19:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=sufCrObw;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=k2TKQaXd
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=8oHy35ptJ0fLQb2YrI1vdssfNtJpVRQvJ6BVJKFTHRg=; b=sufCrObwHwKwjpAuXZxXM59a1E
	MQhzZmyS2b7rn7eMNNL0dj9ntwCD/J2FtKQOaQ6753hV6VFvY6ewt4K4HQmFzgq8pxkxouUO26Y3d
	kR5xRN8ZgVbIpJ0Zz59Zy46D9jedGOhzJDw+m8RVXgpoi4eq5efqwWT3XwD1vkL9ZPZc2knbpbNcQ
	malBzH4q0lhSB09Bot8uVR7L+j+JLpbEJ67FuQmP081RZ4h8fbVaFk2tMFnQOdZRFbIst7+ekSL8r
	ddA/2TLyxxNiLcih/Vyu+Vt1tsIkkoY6DTTjewfSQE00E89ki5m3mhJPGFs6p8cqqd2h0aOmA3vyf
	fxUKTJAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRx3I-0000000ECgI-1ls8;
	Fri, 13 Nov 2026 19:35:12 +0000
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRo7F-0000000CIAN-0qnK
	for linux-nvme@lists.infradead.org;
	Fri, 13 Nov 2026 10:02:42 +0000
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-c5067a2411bso135633866b.2
        for <linux-nvme@lists.infradead.org>; Fri, 13 Nov 2026 02:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564159; x=1795168959; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=8oHy35ptJ0fLQb2YrI1vdssfNtJpVRQvJ6BVJKFTHRg=;
        b=k2TKQaXd0NqbLquOFQ+tbz6tqww0PprOQVQ0rGz/Ey0uwIEJo/2lhAoca5mpDT2fpR
         +MT028yWwaCr1zXpJ40lutJtukmnrxIWHVHQiSGE5i6+2uou+reAxblSEU2n8V0Sr4zY
         YEuJNSamIiDaQNxk/LL/tWanpXAC1JAXP+IZtyEjuDD5SUbhm9EHtCpF+Zjpnn6NxiFo
         npdmjuYU4M38dyft9pnqWBlqqL7VpHSWy4H0zmDn5svggRSkmYr8SnMzIg3zYKV5qnac
         P3MaH2PaeFx0C1oJ4PYljBH5ad4YjbarOOWo7ZIrLC+Xc9q0tb9o7DT9D7tDZzHMTffW
         Gq9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564159; x=1795168959;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8oHy35ptJ0fLQb2YrI1vdssfNtJpVRQvJ6BVJKFTHRg=;
        b=NFbengM28AhhUKUus4ayEVujI7p8ikCJO0dujuxcUj18ChaBs9U0GmYjFbr/HTK/qi
         In281KnfhSSc4/UsKRE38rMt9Xf2zvb+J/AxQCABPt9nPE1SPaRGXnmx4elVX4qF4wgI
         10YsnEf1SoXw0e/iGzNNrSZRWSF1Zm7d8wVz3/e67zpHVG3wB/M/KyhngpozQFOVUEa8
         +RDaXRwEWmrqTfftCYV4UwCYDoOLNB6VBgMP0Bnot+xk8AvhezFq34vyOYAQJ/17hJaG
         XCTuXJBMimcMDwywNrntuh15Rw/wSkKAYFgIkUfYYSoBqzCXQwLzjvW556GfCCbpQ5gG
         MXyw==
X-Forwarded-Encrypted: i=1; AL+hErF/2nvd1ER+zxbjv+WztReQd6YsHKdliLdWZz5TFQgn+sJB8hWFuPxY+9U95W0gB8e932IxoYFuueVm@lists.infradead.org
X-Gm-Message-State: APuU4Z/lfBNWa5rJfjNGf5nhWP5dMKur+w4avrzbndI5amsuacoNVfms
	mHYm0lqzTIBWIZRW2UFbwoJV91qvKgrNFzjlcBL36DF09y2Wr0r6R6tHlYtr5mvd4xem
X-Gm-Gg: AYBFou0AOS6iwadsdCiY/nJatCAjuhuo0PvjpJKhpIbyHGaaDiC8BJaPVoMIyYoEUYs
	4YVfT8c3QlJuVRIuYgqc4ibFyst4QpAcAXiRl3sjH17Xj6KwUmIIhYo961KpH+BWvk2eSPG6qc1
	mUB4iEkEpAoE209qwqzmOwhmBqpsgk69rs6FS7Tw4W0Ub3pnJQGtvy+YtR9HZITal5PY/pKSUpk
	aCHgpgj/iw7eYCnS91749G663xLpTdUY2Keot7RX+UcDrycPY4Pyltt2BINXH9PmFuaoxhzQDLQ
	NyV2E3qqoD+7VhH2KcMzNVSai7O0HQPmnMkBnjbWSBq6NIFZM20Osvl94kIIoq0RsiTD9YFJ1BI
	0bm2vuqFAE6x7XA5ACrYcPo4KToKMK/mD+ovwT7OK1Oa7ey7mPqA/rNADQU6VuPPL11/n0OEmBb
	8ExzxRzBdCp7dbR3cx0PuT1QniNhdT8rRxUkCT4PYOI0eMeUXROYjiVp/DvMqyBkhzMah4zxuBo
	gkSMaUL8ci/TTkAfqOxZ+/LsfyqKozHbjrHwVAdj9JNnKEcM0UPjEI64l7OtIiEAQlZ4mB6dMZ5
	6iW7IG06tqjNFBYGmWihfAmWCsuIAib71mbv2OeXShy5UaKna3b2AEGTA8w3l7U=
X-Received: by 2002:a17:907:7b93:b0:c29:f5d5:5a9c with SMTP id a640c23a62f3a-c509654de57mr163595166b.38.1794564159104;
        Fri, 13 Nov 2026 02:02:39 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b23afdsm74417566b.13.2026.11.13.02.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:02:38 -0800 (PST)
Message-ID: <8c51aa1ad231dea30af06ecf761a971f5958d063.camel@amutable.com>
Subject: Re: [PATCH RFC 05/41] kernfs: use fc_init_pseudo()
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
Date: Fri, 13 Nov 2026 11:02:36 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-5-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-5-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261113_020241_273765_CFBD9169 
X-CRM114-Status: GOOD (  14.13  )
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
> Initialize all kernfs based filesystems as pseudo filesystems in
> kernfs_get_tree() instead of raising SB_I_NOEXEC and SB_I_NODEV by
> hand
> in kernfs_fill_super(). This adds SB_I_PSEUDO for sysfs, cgroupfs and
> resctrl.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0fs/kernfs/mount.c | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
> index a0be784bfb06..6b60d212b003 100644
> --- a/fs/kernfs/mount.c
> +++ b/fs/kernfs/mount.c
> @@ -8,6 +8,7 @@
> =C2=A0 */
> =C2=A0
> =C2=A0#include <linux/fs.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/mount.h>
> =C2=A0#include <linux/init.h>
> =C2=A0#include <linux/magic.h>
> @@ -298,8 +299,6 @@ static int kernfs_fill_super(struct super_block
> *sb, struct kernfs_fs_context *k
> =C2=A0	struct dentry *root;
> =C2=A0
> =C2=A0	info->sb =3D sb;
> -	/* Userspace would break if executables or devices appear on
> sysfs */
> -	sb->s_iflags |=3D SB_I_NOEXEC | SB_I_NODEV;
> =C2=A0	sb->s_blocksize =3D PAGE_SIZE;
> =C2=A0	sb->s_blocksize_bits =3D PAGE_SHIFT;
> =C2=A0	sb->s_magic =3D kfc->magic;
> @@ -388,6 +387,7 @@ int kernfs_get_tree(struct fs_context *fc)
> =C2=A0	info->ns =3D kfc->ns_tag;
> =C2=A0	INIT_LIST_HEAD(&info->node);
> =C2=A0
> +	fc_init_pseudo(fc);
> =C2=A0	fc->s_fs_info =3D info;
> =C2=A0	sb =3D sget_fc(fc, kernfs_test_super, kernfs_set_super);
> =C2=A0	if (IS_ERR(sb))

