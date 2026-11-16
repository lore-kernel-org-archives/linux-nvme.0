Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBE4606A323
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 23:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=PBf27tRg;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MtQzGS8u
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=ASqD7yYrxwRTXpvky24aSldHzEJHTNv4OUWKJ01NHN8=; b=PBf27tRgdjGphV
	e/9QJN1f+n6bf6fmuC89FHKwB84oCw46QpvcqpNBi1yIXu78LQaayvMJ8Fr1A+W81PVaTxN94LE/7
	+R1yLoVMXoBj15QG98c3SCsif/w0fj5RrKyjwwLejRzbuY3x19XiMTtouRUyywUwFA+dv2QEeTw1H
	kIYj0rY8+U2A7NxN61TWSdfD8GzChSHEQtUisswTCLir1Bt5di75lJ7am+5/GxbUIa/qnXYYom3bH
	AqYEgATvocsSb3av45PVJtRZomZnuZeBznC3kNwEqDwBvESQb4uJdhEnjR3HLnAy/N8lKg9iUSKL1
	n7XYfZfc/R1EqWthUcUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xT5oZ-000000047ga-0Qve;
	Mon, 16 Nov 2026 23:08:43 +0000
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xT0e1-00000003QMD-2XDG
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 17:37:32 +0000
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-6b81214ab40so218683a12.0
        for <linux-nvme@lists.infradead.org>; Mon, 16 Nov 2026 09:37:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794850648; cv=none;
        d=google.com; s=arc-20260327;
        b=RrYypSnF9s6JOB7+SAT4+kMXfMUCW4I3tDTFMN5TmHydee2BS7fSE2bD/UxsuzqvJo
         PLcFbPaH+O6f8bsxmDFF2twjntLA+xCTlThcCr2OC442rD7bgpUdr1es9bqvvVJqDgAh
         CHXspG4RlleVeOQ9RDXWmklRD2XyV70MOOZ53PIxw8sANOh84EF2y7cP4clU/qFisVws
         8unXDI+Jofj9A9/PbQie1Hz5qjrgf4SiaOF2JDh2k76FKKry9hQ6iWKR0vQwiraxUvz2
         tV557IWv3VwnDFjrvQDmpRhaTSNerb86d1VjWT9TTtrW3GKKSPxAnZOLRnyOKcORtyyo
         SzxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ASqD7yYrxwRTXpvky24aSldHzEJHTNv4OUWKJ01NHN8=;
        fh=zhjIqh5efMASGdiod9J6vVq0wVHVpAQUl83SY9vmYFg=;
        b=MehcgOtXL7TiOrVmi0oBzGMrAfTxoXNSpw43dGGA2mJDmhB7h2rH5J0rArf1tKGHpD
         +//ujMlOqqWQijBT23UcMhVjg3wDTo5Kjn/2LtYIdjm4ySvtduHyq9DjndlEi9odr0g3
         ma9rNDR4MqENZfewsUqPcPmJ/XgzfwPIRQ751UPQyd5kSVHEfErunNq/kKwOj+Ax6/fS
         BFy0E+q1ayL2EhHm1khX3lhRkTwrPvkTeL0InIt0aAmaXbisD4JMXKoHjM+TLzOV90RI
         Rb5fzUs6bv2C3XdN7kbypUgY29W4sUmVg48Ks4+LWCEhuIdb+Ak1CvuXO1h3RYLwu0Mk
         i8Yg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794850648; x=1795455448; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ASqD7yYrxwRTXpvky24aSldHzEJHTNv4OUWKJ01NHN8=;
        b=MtQzGS8urU7+e4iMQ17zK7L23QY2Vuzv8pWO6MT1oPQgV10O38WYGOXcckv8bgI96Q
         QlUtwtra03xXk8ti59owi57WwZo15J0DG4ISGL0PEtiXsmZzU0rGlu6IW9oCwlzA5765
         pdCMg+o3ktLkC/6dPSRvyqdOQKiplHmp2+LXSZ8wAij5PJrrkYE1+js306WGCO8AQpOs
         ao/FguQ4uIME+KuKYhvvXrmb8JaJJDNtcQ/m9t5VidzRpjuCG34gI0bUzS4JLdoLA9Nx
         ZCH+sjZUhtUyzhqq+PurYfLLm2h+TGkdpBGFhpBgVIVPjpLw54n2/bl1ghi5zcRmSgHe
         ynmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794850648; x=1795455448;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ASqD7yYrxwRTXpvky24aSldHzEJHTNv4OUWKJ01NHN8=;
        b=jlloQ1Hw/IVufOtdpURoNdWCaWVl+C13C1XEEpewwLr1e6/iANivLPnEouH/RDDtlM
         fnVyms5ifHpr2n4OgLCbir9yWoD+p7kcHQkR5GCnQgW587EfdsznumglsGAgVCHKOGSR
         4M8RzFyX4ykxUnUzcymD8Jb74Aqd41InJm50taViBWODAGidq1+2azFyAwUjYJ/PHpSr
         JVxpvv3zgun8UQXTgjvdOgOzYIw7LVofD9qq0v/YJ0wY5WinJFDpLNroQAy1IWTpAzxq
         5Z4baFfSA93wTMJABXOuHck7f3xD4Qz2M6Uw4+lb4OtvM5FytHNKysAVN35DZSKpyw18
         Ju/w==
X-Forwarded-Encrypted: i=1; AL+hErFU5ASwGNRyNwtQTxCe0c3pr2qYoeGd2CG+hcMf2WvnXw9PJmg1zykDw2XfsXP2cDE3z+tCyBoLXZkC@lists.infradead.org
X-Gm-Message-State: APuU4Z/s/ZTMU5kQ5zbr8skteX7Nvlhhi34HcpKni+7HE9X29Byh2hbO
	lqE8rytBrYdhRCuGko6OGJfL8p3tIOGquwa0oEhgG8prFOpBmVvWqkcotTPkrssoPTP+La5H2aj
	NTJ5Oh6Ar/13zdz8CQrsHuR2VEVgWsVo=
X-Gm-Gg: AYBFou2XhrjDvQGan3VEIFQ4nRCaQu9rrpal+OD6JEVRJgou+xz16H9t5L2PCDrykFU
	qAE0bu1mHoeyVtgclBDkc2vBkK37g1iFp7cyGU/QnGMEH+81frkCELfXqTebagaqsxdKG0CZGEZ
	xlX6JXjUiZ86oXVck0ra8y84iNCU8KCQdKLx9qM/i4Tsbc6ShBapS4zu6XypLofqOLS75SxgvSB
	OAyVITVVwEh8hrCe31DCNmf0ZlaEeK6SOlN8sOMLFPK07qJVM5ivVMHGq8g7B5A4Rr19Ce5JQk0
	KJCQYzTMNXUKOOuu/B5TbHiv633KCHiRGueA/eKG8wBAOdNx/DI8nR8weD0FWy0LyxrTpusk5kf
	qAdaMwmit7CJ9SwaTL5SQkGyJNFQKJIibIJrdH9nkR1OlHnO4jSn5igpPOwM1NL2VVwoOaQ==
X-Received: by 2002:a05:6402:1598:b0:6b5:7250:d621 with SMTP id
 4fb4d7f45d1cf-6b859ae1a00mr134291a12.15.1794850647426; Mon, 16 Nov 2026
 09:37:27 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org> <20261116-work-loop-pseudo-v3-33-8cbbea1cf34f@kernel.org>
In-Reply-To: <20261116-work-loop-pseudo-v3-33-8cbbea1cf34f@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 16 Nov 2026 18:37:16 +0100
X-Gm-Features: AclHuK_sKnxFPAK3k65pZhjyZC94SJD4eZ9z2j_P12s3kyb9TMw6hurQcjyq55Q
Message-ID: <CAOQ4uxgPerkkG4ie0SyHVXaBD9VZN2wYfQpEAEi4hytn=ara3A@mail.gmail.com>
Subject: Re: [PATCH RFC v3 33/44] ovl: refuse data-only layers on pseudo filesystems
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
	linux-usb@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261116_093729_668484_59D0D303 
X-CRM114-Status: GOOD (  27.47  )
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

On Mon, Nov 16, 2026 at 12:10=E2=80=AFPM Christian Brauner <brauner@kernel.=
org> wrote:
>
> The data of a metacopy file can live in a data-only layer. overlayfs
> doesn't look that data up when it looks up the file. It only remembers
> the absolute redirect and looks up the data lazily the first time
> someone needs it. So until then nothing can tell which filesystem holds
> the data of such a file.
>
> But a data-only layer has no business being a pseudo filesystem in the
> first place. All it does is hold the data of metacopy files and the
> regular files of a pseudo filesystem are kernel interfaces, not storage.
> So let's refuse data-only layers on superblocks with SB_I_PSEUDO at
> mount time.
>
> Data-only layers can be added via the "::" separator in "lowerdir=3D" and
> via "datadir+" by path or by file descriptor. All of them end up at the
> end of ctx->lower. So a single check in ovl_get_lowerstack() covers all
> of them.
>
> Note that regular lower layers on pseudo filesystems are left alone.
> Stacking overlayfs on top of sysfs keeps working.
>
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Link: https://lore.kernel.org/all/CAOQ4uxhGxpBtMZ5kfuzR1tQAewiecoX7UjXQRo=
91QjJHH9T_Yw@mail.gmail.com
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  fs/overlayfs/super.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index 39d4d57dec230..719c2569dfeaf 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -1237,6 +1237,14 @@ static struct ovl_entry *ovl_get_lowerstack(struct=
 super_block *sb,
>         for (i =3D 0; i < ctx->nr; i++) {
>                 l =3D &ctx->lower[i];
>
> +               /* Pseudo filesystems don't hold data for metacopy files.=
 */
> +               if (i >=3D ctx->nr - ctx->nr_data &&
> +                   (l->path.dentry->d_sb->s_iflags & SB_I_PSEUDO)) {
> +                       pr_err("filesystem on %s not supported as data-on=
ly layer\n",
> +                              l->name);
> +                       return ERR_PTR(-EINVAL);
> +               }
> +

How about we make this just a tad more restrictive:

                /* Pseudo filesystems don't belong in composefs setup */
                if (ctx->nr_data &&
                    (l->path.dentry->d_sb->s_iflags & SB_I_PSEUDO)) {
                        pr_err("filesystem on %s not supported along
with data-only layers\n",
                               l->name);
                        return ERR_PTR(-EINVAL);
                }

I could send this as followup patch, but since this version is simpler
there is no real reason to have the intermediate "only ban datadir" step.

Only the commit message needs a little more flexing to justify this.

Thanks,
Amir.

