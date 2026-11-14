Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF5D606A31C
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 12:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=YgRt2IHQ;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FIy92zB+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=MU5XNgGhJm4qGtdrFglh8iv5ciWWvcUh9TpKkyBJYjo=; b=YgRt2IHQE0nTnL1D4XLe6xo1wR
	7EleFH7SeGmcfKeXpXWGiXg8ELxBHhNTyiK8yexrhJtM7RJCdG09aTPdjoASY/YIiyQeER4f0MtmR
	1z97QTACsqIAPJ0CAjQNwOrbfhTjVZmgUBghy0sYjC5l1YHGenKwd8AwxpZKc15Y6tmcUdXvnPacJ
	FVjJU2y8JtpAKyp3Dmy5eMuQ5vF2CT+rCmLeuGPiBUnxI2rOPeLLAS8gV7B2Y/VJr0V3x4dbbKr0p
	5pY4WiWiHPeBJ1LOE4sbq47r33BQDUNZHRNBljSMEVRbLOnUvk8tKAwLte4pigDGk90tSab0seS5F
	P5KSPOgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSvzW-00000002NiM-1eME;
	Mon, 16 Nov 2026 12:39:22 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSLhz-0000000Go74-2Fzg
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 21:54:51 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E15E0447B9;
	Sat, 14 Nov 2026 21:54:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BCA71F000C4;
	Sat, 14 Nov 2026 21:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794693290;
	bh=MU5XNgGhJm4qGtdrFglh8iv5ciWWvcUh9TpKkyBJYjo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FIy92zB+Q6XXV11Bx9r1d6hblgiehsd1O2WYa4ANqHuoaMNzzpTo/kyfrrl5vWJqU
	 ntQlUQLehZaQBgb5PHB5XgsgvcpzvDKacjzaPI1D0mhsgTUlE44bsX7wUuFZlbKEVy
	 2bf9iGRkxrODGLkzXesChHlOpfKM10Ar21sYj0wFzavx9W02CRh/nVciBf1lbn33of
	 RFNAI7U3T2zGoe8QK8NctZ4IPimWP2/h2Wjo3dajkFGo7hKnMdTyDdQrkd/NIOxJeq
	 4KueXIk2XzkN6Oe+3U49dByhB2/gIMk6xuZPod2J7aymfou+3hjeBLx6QqpqyydE14
	 fsnMkL8jCu8lw==
Date: Sat, 14 Nov 2026 22:54:42 +0100
From: Christian Brauner <brauner@kernel.org>
To: Chris Down <chris@chrisdown.name>
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
	Amir Goldstein <amir73il@gmail.com>, linux-erofs@lists.ozlabs.org, linux-kselftest@vger.kernel.org, 
	Alexander Mikhalitsyn <alex@amutable.com>
Subject: Re: [PATCH RFC v2 17/42] securityfs: use fc_init_pseudo()
Message-ID: <20261114-wohnprojekt-rational-ersetzbar-b338c88cba70@brauner>
References: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
 <20261114-work-loop-pseudo-v2-17-98639a2286fb@kernel.org>
 <20261114120555.cbfaf8ab8a92fb25@chrisdown.name>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261114120555.cbfaf8ab8a92fb25@chrisdown.name>
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

On Sat, Nov 14, 2026 at 12:05:55PM -0800, Chris Down wrote:
> Not a big deal, but userspace can see that node too, as
> /sys/kernel/security/apparmor/.null. Opening it by path works in current
> kernels and fails with EACCES after this patch. Now, I don't know of
> anything that does that, but selinuxfs gets SB_I_NODEV cleared again in
> the next patch for the same kind of node, so I think we should do the
> same thing here. If not, it would be good to have a line in the
> changelog saying that opening it by path is meant to stop working.

Yeah, seems fine. Though, afaict aa refuses every read and write on
.null in aa_file_perm(). So this change only moves the EACCES from
read()/write() to open(). But I guess open() failing might be an issue,
idk.

I really really dislike this device node abuse on for both lsms. It's
sketchy as hell.

