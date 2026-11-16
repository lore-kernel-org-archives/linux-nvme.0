Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2726606A32A
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 23:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=UKXoPTi0;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LWj9kUC8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ED8m1EUNyZbVy60KlCH1nfmXFCVOvYy5WXRoQrkl9dY=; b=UKXoPTi018vHVcVO+f6CO/Wp67
	kP91RUC/QYliuaUA15KnjuAyAcHxPh2M23CH00X4DrZT64C8bkQZN8UjYJR0rgDI87KvJzlVrFkZn
	ZznCNSyRrW8V8qk/+DFE7Wh3oDy+YbxbJWpKtRpckv4dXJ6VLyZV4eFHvvhTrrJPiwx3eJncrRVpg
	EnpCNx9K4itQ1lrjnBSFowKmE0WERHDZ0FmBR+SR/Em9rg6Fh4eFyCqd/U6TmNcc+EEZW3YNeZGaX
	MLgGd0rZHvlNch/AXcX0P/wflOtOyjqVwQdnyi4yjUKam6trga85DZJfBXXk7zqRg0SJuw8K55Zna
	xh6bBTEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xT5oZ-000000047gh-0ui9;
	Mon, 16 Nov 2026 23:08:43 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xT0pY-00000003Rrm-27Rm
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 17:49:24 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A06146147C;
	Mon, 16 Nov 2026 17:49:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6A261F02813;
	Mon, 16 Nov 2026 17:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794851363;
	bh=ED8m1EUNyZbVy60KlCH1nfmXFCVOvYy5WXRoQrkl9dY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LWj9kUC8kQFC5SfD1vjbud2HBFDNnZqFBwsM7D7EkixcrkbHslvvXUPplnT67OEDa
	 Ojxvc/9bBfh+7M7IgMwLe0/MW3vEZ7MNK475jdjW9gzIKFiwKQYtp2o3epkEHr1OUY
	 ut8wZMtQ6WwDI4R/4NjZmngdKNKdP+t6PoX5HnYwVJTKEbOQrvDnGzw7NTHVCoa2iV
	 Az2pSjHFx32LhMnzCRrFLDjD1DXtR7qLBdQXkQEuVAl0z7iuGlB/eKvhfmNtzTqNut
	 eiuM63/QtPtS1+8sCvNSNotSJGDSOZKb/xcO1WCvyJtafHJlrptV+MYpMU1CW9c9N/
	 f6aB01Y3d7oMw==
Date: Mon, 16 Nov 2026 18:49:14 +0100
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, apparmor@lists.ubuntu.com, 
	linux-nfs@vger.kernel.org, netdev@vger.kernel.org, fuse-devel@lists.linux.dev, 
	linux-efi@vger.kernel.org, xen-devel@lists.xenproject.org, ocfs2-devel@lists.linux.dev, 
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-usb@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC v3 33/44] ovl: refuse data-only layers on pseudo
 filesystems
Message-ID: <20261116-kriterien-getoppt-kauern-5a0c1fba70cf@brauner>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
 <20261116-work-loop-pseudo-v3-33-8cbbea1cf34f@kernel.org>
 <CAOQ4uxgPerkkG4ie0SyHVXaBD9VZN2wYfQpEAEi4hytn=ara3A@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgPerkkG4ie0SyHVXaBD9VZN2wYfQpEAEi4hytn=ara3A@mail.gmail.com>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 16, 2026 at 06:37:16PM +0100, Amir Goldstein wrote:
> On Mon, Nov 16, 2026 at 12:10 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > The data of a metacopy file can live in a data-only layer. overlayfs
> > doesn't look that data up when it looks up the file. It only remembers
> > the absolute redirect and looks up the data lazily the first time
> > someone needs it. So until then nothing can tell which filesystem holds
> > the data of such a file.
> >
> > But a data-only layer has no business being a pseudo filesystem in the
> > first place. All it does is hold the data of metacopy files and the
> > regular files of a pseudo filesystem are kernel interfaces, not storage.
> > So let's refuse data-only layers on superblocks with SB_I_PSEUDO at
> > mount time.
> >
> > Data-only layers can be added via the "::" separator in "lowerdir=" and
> > via "datadir+" by path or by file descriptor. All of them end up at the
> > end of ctx->lower. So a single check in ovl_get_lowerstack() covers all
> > of them.
> >
> > Note that regular lower layers on pseudo filesystems are left alone.
> > Stacking overlayfs on top of sysfs keeps working.
> >
> > Suggested-by: Amir Goldstein <amir73il@gmail.com>
> > Link: https://lore.kernel.org/all/CAOQ4uxhGxpBtMZ5kfuzR1tQAewiecoX7UjXQRo91QjJHH9T_Yw@mail.gmail.com
> > Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> > ---
> >  fs/overlayfs/super.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> > index 39d4d57dec230..719c2569dfeaf 100644
> > --- a/fs/overlayfs/super.c
> > +++ b/fs/overlayfs/super.c
> > @@ -1237,6 +1237,14 @@ static struct ovl_entry *ovl_get_lowerstack(struct super_block *sb,
> >         for (i = 0; i < ctx->nr; i++) {
> >                 l = &ctx->lower[i];
> >
> > +               /* Pseudo filesystems don't hold data for metacopy files. */
> > +               if (i >= ctx->nr - ctx->nr_data &&
> > +                   (l->path.dentry->d_sb->s_iflags & SB_I_PSEUDO)) {
> > +                       pr_err("filesystem on %s not supported as data-only layer\n",
> > +                              l->name);
> > +                       return ERR_PTR(-EINVAL);
> > +               }
> > +
> 
> How about we make this just a tad more restrictive:
> 
>                 /* Pseudo filesystems don't belong in composefs setup */
>                 if (ctx->nr_data &&
>                     (l->path.dentry->d_sb->s_iflags & SB_I_PSEUDO)) {
>                         pr_err("filesystem on %s not supported along
> with data-only layers\n",
>                                l->name);
>                         return ERR_PTR(-EINVAL);
>                 }
> 
> I could send this as followup patch, but since this version is simpler
> there is no real reason to have the intermediate "only ban datadir" step.
> 
> Only the commit message needs a little more flexing to justify this.

Just sent me the diff on top of the series and I can fold it with the
commit message you want and slap your Co-developed-by and SoB on it,
please?

