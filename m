Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C71606A326
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Oct 2026 12:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=lxSRAjni;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=JtnOwapk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=uNS2L2iMcOC4fIL5rjAO/7Q+oRPwueCBxvTT1iYaWfQ=; b=lxSRAjniYmhCU4Kx7JyuILGT8N
	X67sP+p4JTRFr2BhZHZH3BwKMxSe3ep3vgqCrGybUwuwfU23I9qMHTaX2JMZxb/wZQbW2ANxdBqna
	+SEJBuOfocRzsZTmOMz1zjFuNKzTUIHgIGwmvF5w8AAapCEJ0j4w5VrZYMhF6Qlav/ShtIh8x0/JE
	K0flf0B8a74vRz2nPX87q/HuG2T/o2/3YKQ7jEuGRoNGOIsQB8/ULlMP3DOJ9Isjpyoych9kFlJzo
	0BRTCK9Edxd+8FV7cd8nVIJktGgVKHyn8n1vJiXeIoen5yS7JgLjZaSMKSg0T/vzxV3V0Ad8Tph2N
	zs5xkT1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLgNa-00000004fgG-25qt;
	Tue, 27 Oct 2026 12:34:14 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLgNY-00000004ffY-1cZY
	for linux-nvme@lists.infradead.org;
	Tue, 27 Oct 2026 12:34:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uNS2L2iMcOC4fIL5rjAO/7Q+oRPwueCBxvTT1iYaWfQ=; b=JtnOwapkIsOlSiyUSlZyh6cLaG
	/VAvWk6wCuoGnUETa+XAr8pm/tUWPxsvxHqebStP9cpYAEVNiIO8IRSvRKkYGzWOnB3Yt5WYA7iX7
	8iw1/DwO/cSkLh5VWQyx/TVVLrDRSOyBx9D3aV/Yw95N6ag6+OElf+ZgLNZADytLLCFMkZq4/9vgR
	FMwT8/nAwQ6EdlqWl+VZWuq0QZ6Ztus7t4CNCwAGso0g9fPqNP/5hKVFe0jp+Ag42JuT2iv8Dsvot
	zbBlP++l5O068pHS60pB0AfPP26/nr8y/w1Nky1fFuBabarsColjBKLAaOP+dlDaP0AGK7QImTPcI
	9mNc5a2g==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xLgN8-001SUN-2W;
	Tue, 27 Oct 2026 12:33:46 +0000
Date: Tue, 27 Oct 2026 05:33:41 -0700
From: Breno Leitao <leitao@debian.org>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Christoph Hellwig <hch@lst.de>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Keith Busch <kbusch@kernel.org>, 
	Logan Gunthorpe <logang@deltatee.com>, "Martin K . Petersen" <mkp@kernel.org>, 
	Lee Duncan <lduncan@suse.com>, Hannes Reinecke <hare@suse.com>, 
	Nicholas Bellinger <nab@linux-iscsi.org>, linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, 
	target-devel@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: Re: [PATCH v7 1/4] fs: configfs: add helpers for opening
 non-configfs paths
Message-ID: <auCZ-EdCKGup3a-W@gmail.com>
References: <20260927082011.638723-1-runyu.xiao@seu.edu.cn>
 <20260927082011.638723-2-runyu.xiao@seu.edu.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260927082011.638723-2-runyu.xiao@seu.edu.cn>
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261027_053412_436603_4A512A69 
X-CRM114-Status: UNSURE (   8.96  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -4.4 (----)
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
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Sep 27, 2026 at 04:20:08PM +0800, Runyu Xiao wrote:
> Configfs store callbacks hold frag_sem while they run.  Reopening a path
> that resolves to configfs from such a callback can acquire the same
> non-recursive semaphore again.
> 
> Add configfs_file_open() for configured pathnames and configfs_open_root()
> for paths relative to a resolved root.  Reject configfs roots before using
> file_open_root() so the normal open checks remain in place.
> 
> Assisted-by: LLM Codex
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>

Acked-by: Breno Leitao <leitao@debian.or>

