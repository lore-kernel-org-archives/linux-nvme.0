Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227A3606A323
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 20:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=DIAshzao;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xnnd98xT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=EZDAQV8yhgMyPQgwR3U/5djFDS4+SZxlS+9+Esw/bYc=; b=DIAshzaoKWwijD
	pL268f9a8AqHb5nvMrM/eys7bhD5iIZauEukcrBECsGKuf6vwoToGYELX+UrGw8agZSHSWZTvzrQM
	6wwz4ZXPV+Pg7XY2u0vyXreMmdkvAjHG9VGHb4XfesvPwJ4yB8yDaEum/MB8EkBYu551lk9QYyEp0
	nXoyZgTeP+DfSBxqm5HZtvjMJR0k0JO5+R25w8rdeTZx/uBW8YW86/lmkvw+xAQxkDAUFgUKuaGzh
	VUlJyXgW5sukRnK8QtJxqCB/fqoHy9w3eWiRS5WQwMdbjSAGCPfbBQRIGh4dgq7fSnEBmK7Qm0hrT
	Zi9lFIe605rCjomso1Ow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xT2zF-00000003pjO-0hsK;
	Mon, 16 Nov 2026 20:07:33 +0000
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xT2z8-00000003pij-1IrI
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 20:07:27 +0000
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-4bb72b44a97so9382345e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 16 Nov 2026 12:07:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794859644; cv=none;
        d=google.com; s=arc-20260327;
        b=V6BNsti3O7D5SUm5Qv1IH0KjRJPp9E4z4XGdFurzm+xawpux8Q5u2SUI2Waub0nWqb
         YTF8rcsuWa1LUCNeDMt7S+lI94401mje85UWVT9AKoQTFBkXLjyvb1pZMBuzn7w3Qz7K
         /BDy0Me9J42mIJbwxzfv4rBusmPd0M7jtL4tYoqegeCUgMyWwFyvpvjNxHIfd+mpY0O6
         +/rxooh708w8ra4fausO8PDcdEbUz7LL/iTRp0DdYnS+uFpg7C/OfnmnHWSwqxXkLUsq
         jQ8rg0GoJDs/yT4HR7XyapVnG+lbjBmWuHMi2qxU+lYQMWIz3FrJy3S6/t8FnFNp9GeT
         TIQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EZDAQV8yhgMyPQgwR3U/5djFDS4+SZxlS+9+Esw/bYc=;
        fh=x9ss2P0bK0n+oMO0+knuJWA/LJQrMPj6aS3se1EisrE=;
        b=cGn2Mkaltld/d+ejA9SlyIM8rmMoFAaDUkKDOAFtLPJAmgBqFxW7WZPQD/bkXvX4c9
         d2n2lv6+GIN2n4oBxaXhqeeJjhbnVU7yGLwxNjohhMtiBBUE5uVx+aq2j4h8UAdW+84k
         k3l0Cyup0LgAYu57J1Mq5A9QVx3hVEUZyjL3RGA60J15scZW6nVCw9QBdbJxG8k8WDRP
         GiPM0L73Kr0xHO0Pt86XqAXSm1Xf9DhGFm/Ha5mFjAOrlQXDJty3A2TkXR+BCOOPboij
         XP5uhDhNIKdio4pbF2r6nwDyRSQz2mXbEbSOZxLHyaVsv1E1c533X/hW9P/jppyB9cvo
         9zJA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794859644; x=1795464444; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EZDAQV8yhgMyPQgwR3U/5djFDS4+SZxlS+9+Esw/bYc=;
        b=xnnd98xT7EPlyqvgG4QjhjmMlgcQLqrC3NgNLhohprkb17iECCSD1ttSxGl+DLs/Iw
         uvzVS5nE94ijVQYt8QlzozYzWoC3erxloIU5tEibWrxDqKjJBLpQ+vERDVVaOWdNNGl7
         tPOYWv4P6p8X3ZAmg4TMwUigwuxr0eq02kYrNRO34CQvlgXjyNJLoDcFbSgu2rwahcl7
         hUqGBoD3nJChEcBiRgmhzYQ2TeqhVNzLTBs4JQkZMFk4bthWqEWr26DXFISN+E7jr3tK
         hFMMuCRusKAbZ+FkhmwLHpUXcR20LVw0uE1NNDQuG5QHYiVJJ1X00vfYUueNECXCyjLP
         PLCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794859644; x=1795464444;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EZDAQV8yhgMyPQgwR3U/5djFDS4+SZxlS+9+Esw/bYc=;
        b=n1TvIzYvJ3mW/MgalDreRa5kXNDH3Bp0wqqRSl8ZlUrLimy5sy4bEtqS/Gi3Rpyz2s
         Q9bYRhGboYc9MrFOYPoHiU3vJ66n8LSEL+Xo9XTh3IMLq+z74UCenuUPSIsFSAW12kIl
         1x6m4SxdF5SrHDGLBEOd3G6awLkO/oQXvp/UOREj6ltnfA0TDVzAef/oPVfh8NGaKP3n
         0yDNTSDZwwMulQVfm81nQ1YgSLYWU2Yy3yf7kJg9malS8O2CJIe0hs3CIOQcb69rLAS9
         U5KqY+cE/sAzln2FZ8pR+GiYCXQCri3/ZwO3hfMu11TDNHrr/Lp8Q8NyCFY4qzq1cJwu
         UdjA==
X-Forwarded-Encrypted: i=1; AL+hErHzSDMCVvMp1l8ilWZQr1/dboAFIcf03CUl8EBjanBMbgd+OM8ADawxI2IpOD9qS0JclVhSANci0mxs@lists.infradead.org
X-Gm-Message-State: APuU4Z+JItlW4efhjctWEncwaPtKEDFiaPOCnF/yZjVkLcdTKPj78D2b
	G80NnboREHOLMlHw2jjDBh6DL+U5KcIk13Y7xH1v6/tfWaiHthVFZoh3HhFXl1+GVmM/ckdA1jK
	sja8AL4w6JdpaU5UNX6pJ4MGQERIdi98=
X-Gm-Gg: AYBFou1+mkN9qoGi6E9yHbZsDMro8UGhWT8urpuVT+FDuwo5EeWncmSTCGXm/IBWc0D
	cx3SFOzK50K1lSAKRdUDvJZ7W8W6QDjA+SNIba/F3ML0SNBYYCKoLzE76UOY+2zHrZm11lci2nk
	kSWvgMjA+RxjjgyjIfKL843eLDFrrt9yYF4V6Mqin/8PPWfGrYUyu8wVloB7LhFDcn6g7WjnBJ8
	bHyNgo7ib1rAiF1QisGGCUL8J4ofFB7pW6+Z00LksiHSkLG3NoViDZ7XXR6Cy8UOLxyZs+YH9cr
	L1/Img8p0zNLOEX/p8wgBbXCTHMEykSE6nL1AvO7jRk3GAbiw2F6nUi6+JuKrPQbkuK59qllnuX
	1P0AoaD0eJ9JL+4mXWDqiRYTxjdeNNsjp/0Ee8phiP/VE28Se/Uwpi58lpAETbSGzh3xLJwpi1J
	Dygu2YLyFcvDa8hY2Oww==
X-Received: by 2002:a05:600c:506:b0:4a1:f377:5c6c with SMTP id
 5b1f17b1804b1-4bb55a5d6bbmr165067875e9.10.1794859644313; Mon, 16 Nov 2026
 12:07:24 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261116-work-fs-frozen_writes-v2-0-ecc4a2aac40e@kernel.org> <20261116-work-fs-frozen_writes-v2-13-ecc4a2aac40e@kernel.org>
In-Reply-To: <20261116-work-fs-frozen_writes-v2-13-ecc4a2aac40e@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 16 Nov 2026 12:07:13 -0800
X-Gm-Features: Aa3M54rpWiCplKeR8o5TX-NbYGDID_36BWk-3VAyUzdEoXSYZ7J-t8pfWvm9Fcc
Message-ID: <CAEf4BzYANM9vtQ8L9-rJPQC-tTcw3YUGsw=qnCaoym3+EU=DBg@mail.gmail.com>
Subject: Re: [PATCH v2 13/17] bpf: fs/xattr: take freeze protection in the
 xattr kfuncs
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, bpf@vger.kernel.org, linux-nfs@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261116_120726_406909_FFEBC571 
X-CRM114-Status: GOOD (  18.00  )
X-Spam-Score: -2.1 (--)
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 16, 2026 at 3:13=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> bpf_set_dentry_xattr() and bpf_remove_dentry_xattr() go through
> __vfs_setxattr() and __vfs_removexattr() which leave freeze protection
> to the caller. BPF LSM programs call them from sleepable hooks such as
> file_open where nobody holds it. So a program can modify a frozen
> filesystem.
>
> The hook may already hold freeze protection or locks a frozen
> filesystem would make us wait under. So don't wait for a thaw. Fail
> with -EBUSY if the filesystem is frozen.
>
> The _locked variants are only used from hooks that run inside setattr,
> setxattr, removexattr, unlink and rmdir. Their callers hold freeze
> protection already.
>
> Fixes: 56467292794b ("bpf: fs/xattr: Add BPF kfuncs to set and remove xat=
trs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  fs/bpf_fs_kfuncs.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>

LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> index 35ccd98a4de64..7f61e2efa08ba 100644
> --- a/fs/bpf_fs_kfuncs.c
> +++ b/fs/bpf_fs_kfuncs.c
> @@ -295,9 +295,13 @@ __bpf_kfunc int bpf_set_dentry_xattr(struct dentry *=
dentry, const char *name__st
>         if (!inode)
>                 return -EINVAL;
>
> +       /* The hook may hold locks or freeze protection already. */
> +       if (!sb_start_write_trylock(inode->i_sb))
> +               return -EBUSY;
>         inode_lock(inode);
>         ret =3D bpf_set_dentry_xattr_locked(dentry, name__str, value_p, f=
lags);
>         inode_unlock(inode);
> +       sb_end_write(inode->i_sb);
>         return ret;
>  }
>
> @@ -323,9 +327,13 @@ __bpf_kfunc int bpf_remove_dentry_xattr(struct dentr=
y *dentry, const char *name_
>         if (!inode)
>                 return -EINVAL;
>
> +       /* The hook may hold locks or freeze protection already. */
> +       if (!sb_start_write_trylock(inode->i_sb))
> +               return -EBUSY;
>         inode_lock(inode);
>         ret =3D bpf_remove_dentry_xattr_locked(dentry, name__str);
>         inode_unlock(inode);
> +       sb_end_write(inode->i_sb);
>         return ret;
>  }
>
>
> --
> 2.53.0
>
>

