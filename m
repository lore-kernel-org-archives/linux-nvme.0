Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90DC606A323
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 23:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=VAAIaavk;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MhEMPzkS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Zwp/b2OseRP/BP0MRnYEMv10Xx5652k/ysAi77DyTUk=; b=VAAIaavk66JAl9qB4WWB7RP5WH
	SOaRAdFqkXYxgbwAXHBC9jUKay/0zATdmKBQFE/V/mjeQi5paoXO60UqjOlDGhaRdx2N54rKHTNaS
	BJzmT4+WVXV7P0/TV2YA9iqppJUqf3l3XGjDZRQG4L1v0kfAF0Ep0tZjNaXK9wS7zrPcIRCU/hgye
	Ii4pwbLsUyTHiaFoipNEKybOrx+AlF/TXCRuypYyq57a3AA4kYPGS3bFwK4Dv1jXOHIskYTs3Rbh5
	6SuyPKqSFb+YJaCSNCaXCVL5I0KfjRDCVBeWyO1v26K0HqHQh1C74ttaGOZ2Y/9zVMw8gbk7BoL8/
	r39iXLvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xT5oY-000000047gO-3N0H;
	Mon, 16 Nov 2026 23:08:42 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSwdm-00000002aTb-00mh
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 13:20:58 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 06B4A62A16;
	Mon, 16 Nov 2026 13:20:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 287C11F000C4;
	Mon, 16 Nov 2026 13:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794835256;
	bh=Zwp/b2OseRP/BP0MRnYEMv10Xx5652k/ysAi77DyTUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MhEMPzkS8ELyUuZJvWfSoeeWuf7By4IL/aj2kb/a2OV4l4EgVqKXjiioyUz2RieNk
	 XgpnwYQk+l7IQUQIb2TJG9rqwlNZZd2t4tSSz2FIOFgSK4qv3MUw+KnfbEysg8x4iS
	 RMX98jFDrMhGiTX7izqJwsUslncHgd0fLN7Yyo0X4gX89YKFy614i608nuofc5428F
	 SfK4Vb1AO45G7cvMjjgv1ixrvwKqD7DXpAnyYbrMZDnbnAmpR0a9mRVyF+s9eImB9m
	 jgQn4Dmx1KWjFDTc0G8bS5OCGFot8PkE1fqYZHJngkkRDFtxZNJw9/svWtFGNRWRiW
	 sc42i9H1mtjtg==
Date: Mon, 16 Nov 2026 14:20:45 +0100
From: Christian Brauner <brauner@kernel.org>
To: bot+bpf-ci@kernel.org, linux-fsdevel@vger.kernel.org
Cc: jannh@google.com, mason@kernel.org, josef@toxicpanda.com, hch@lst.de, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	viro@zeniv.linux.org.uk, jack@suse.cz, linux-scsi@vger.kernel.org, 
	target-devel@vger.kernel.org, driver-core@lists.linux.dev, linux-mm@kvack.org, 
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, 
	fuse-devel@lists.linux.dev, linux-efi@vger.kernel.org, xen-devel@lists.xenproject.org, 
	ocfs2-devel@lists.linux.dev, linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-usb@vger.kernel.org, amir73il@gmail.com, linux-erofs@lists.ozlabs.org, 
	linux-kselftest@vger.kernel.org, chris@chrisdown.name, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com, 
	yonghong.song@linux.dev, ihor.solodrai@linux.dev
Subject: Re: [PATCH RFC v3 38/44] nvmet: refuse files on pseudo filesystems
 as namespace backing files
Message-ID: <20261116-geplagt-gemein-zufrieden-72c3817de2c6@brauner>
References: <20261116-work-loop-pseudo-v3-38-8cbbea1cf34f@kernel.org>
 <cb28f09c85a473a23f14c9bd6ef135950197c9fbf966c1f7055d791977d29286@mail.kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cb28f09c85a473a23f14c9bd6ef135950197c9fbf966c1f7055d791977d29286@mail.kernel.org>
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 16, 2026 at 12:00:14PM +0000, bot+bpf-ci@kernel.org wrote:
> Is a prerequisite patch adding d_real_data_inode() missing from the series?

No. d_real_data_inode() comes from "fs: let d_real() fail" which is in
the base-commit of this series (vfs-7.5.lookup). This was applied to
bpf-next instead.

