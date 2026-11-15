Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857AA606A31C
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 12:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=EOTgyBYv;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O5UCROmp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=dUUoDFkPJkBg6tiiX+gwUNqdlWB0vRGU4J1TlhHh7ZE=; b=EOTgyBYvme/VzR2hGhSOEuWIuY
	+5f3jEzQZNLwA/SuXbMV8ljT30TCCnAeqGQYUy7vpBVrNGtmzmyNG0OZ6tNBqKl6alFSVoVYD8aGq
	cJFqcWagrRDcwdevla7MlZgEbHeQWtpdK1inJ8Cf4DvzMcpQJuKxgedstoQjFz70L4aUcLKkuGyJZ
	kVMla5/V7096RngxAhvlXTTAEKdh8izY5swolYL0BS/V6lUGbEJjO1ZWkqTyl3xf05eCzLB2rXAZH
	HJH2oCB8OzDms4qDRagN8iIU1gZ8d+1qg+AIGx2knR1i+FBgv9lmdxod5qT+cVQbn7fi8Acnm/Xjj
	HCRXt3Zg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSvzW-00000002NiZ-2XZd;
	Mon, 16 Nov 2026 12:39:22 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSYi7-0000000HTmD-0onS
	for linux-nvme@lists.infradead.org;
	Sun, 15 Nov 2026 11:47:51 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A73F44567B;
	Sun, 15 Nov 2026 11:47:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FF671F000C4;
	Sun, 15 Nov 2026 11:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794743270;
	bh=dUUoDFkPJkBg6tiiX+gwUNqdlWB0vRGU4J1TlhHh7ZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=O5UCROmpYOxPof//EVMXlzhE8CwpBAuLxySuhjVJTwgdWIcUjDEHfxQDjag+uTRua
	 Z+qDIjnj4mqHBNrUw8Ko1zjkZMcqAeFq8ldvZlzCVbByFB+ptCuml13g6R68XiAcOc
	 tTmUPUcRTu4mDvyiHtXFi/q4pZoMhhtkVDTdv1WqLRxEzoDBelkcsk5jYXJt2EAUob
	 xjg6qsjtw4gR2WGGuYhHVN3Y9VjEoACQTHM3FtneMm5yNVilA99bE1xWageT1rHDiS
	 UNAqlNNFNjgatsQNOofsxEUu3m18tcJw6JldfrHIojxyBAVmlXl979klg5KOmmNJfI
	 Ivyq26TJMKVYg==
Date: Sun, 15 Nov 2026 12:47:41 +0100
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Chris Down <chris@chrisdown.name>, linux-fsdevel@vger.kernel.org, 
	Jann Horn <jannh@google.com>, Chris Mason <mason@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org, 
	target-devel@vger.kernel.org, driver-core@lists.linux.dev, linux-mm@kvack.org, 
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, 
	fuse-devel@lists.linux.dev, linux-efi@vger.kernel.org, xen-devel@lists.xenproject.org, 
	ocfs2-devel@lists.linux.dev, linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-usb@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC v2 33/42] fs: add file_check_backing()
Message-ID: <20261115-boxen-mundschutz-jacht-0ab871beca58@brauner>
References: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
 <20261114-work-loop-pseudo-v2-33-98639a2286fb@kernel.org>
 <20261114120557.4bc1eb6e57218cdc@chrisdown.name>
 <CAOQ4uxhGxpBtMZ5kfuzR1tQAewiecoX7UjXQRo91QjJHH9T_Yw@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxhGxpBtMZ5kfuzR1tQAewiecoX7UjXQRo91QjJHH9T_Yw@mail.gmail.com>
X-Mailman-Approved-At: Mon, 16 Nov 2026 04:39:20 -0800
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Nov 15, 2026 at 12:19:57AM +0100, Amir Goldstein wrote:
> On Sat, Nov 14, 2026 at 9:06 PM Chris Down <chris@chrisdown.name> wrote:
> >
> > Hi Christian,
> >
> > Christian Brauner writes:
> > >+      /* Look through stacking filesystems at the inode with the data. */
> > >+      if (d_real_inode(file->f_path.dentry)->i_sb->s_iflags & SB_I_PSEUDO)
> > >+              return -EINVAL;
> >
> > This looks good in general, but what the bots said about O_PATH files
> > here is real. With FMODE_PATH this is reached for a file that was never
> > opened, so on overlayfs nothing has been through ovl_open() to look up
> > the lowerdata of a metacopy file yet. ovl_d_real() then does the lookup
> > itself, and when that fails it hits the WARN(1) at its end and returns
> > the overlayfs dentry, so the check passes as well.
> >
> > Only fuse passes FMODE_PATH, so it takes CAP_SYS_ADMIN to get there, but
> > it's easy to trigger with that. From a quick test with a metacopy file
> > whose redirect into a data-only layer points at nothing, registering an
> > O_PATH fd of it with FUSE_DEV_IOC_BACKING_OPEN gives
> >
> >      ovl_d_real(/f, 0): real dentry not found
> >      WARNING: fs/overlayfs/super.c:79 at ovl_d_real+0xc9/0x210
> >      [...]
> >       file_check_backing+0x308/0x5e0
> >       fuse_backing_new+0x219/0x4a0
> >       fuse_backing_open+0xe8/0x390
> >       fuse_dev_ioctl+0x53a/0x7d0
> >
> > and the ioctl still succeeds. A normal open of that file fails with
> > ENOENT, so nothing could have used it as a backing file anyway, but with
> > panic_on_warn this is now a panic.
> >
> > Maybe ovl_d_real() should just stop warning when the lookup fails, now
> > that it has a caller that isn't trace_uprobe?
> 
> Yeh I guess that this needs to be a Fixes for lazy data lookup.

I have a fix for that.

> The correct fix would be to teach all the callers to deal with an error.

I've also implemented that. It wasn't that hard and it's also a bug. Not
a bad one but still.

> > The check would still pass
> > for an O_PATH file whose lowerdata couldn't be looked up at that point,
> > though.
> 
> One observation relevant to this patch set is that a datadir layer has no
> business being a pseudo fs and that can and should be blocked explicitly
> at overlayfs mount time.

I agree.

> The other observation is that fuse_passthrough_open() should probably
> check the backing_file that was opened for io in addition to checking
> in fuse_backing_open(), which could have different FMODE and specifically
> could be FMODE_PATH.

Sounds good.

