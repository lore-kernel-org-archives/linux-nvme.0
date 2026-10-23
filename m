Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A03606A31A
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Oct 2026 22:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=R+DzpGOS;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nhxLb6eG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=8yA8pzC09OthcjSV+5j+RAsWByRh9zkzbIUKM5Wq9L8=; b=R+DzpGOSE8B2YlQBGnLYFxNbpP
	xuGO/C4ZQd9wgkSujgOQU6JVBJNphtWrDB7zR/v0Rv7Dyvi00hFkQ5Jf3kIULBVhaP696Uq3YkxHd
	7GYNcx2pph6YVbnzH4Dvr3HYVF4gWud+S74CRbRy+w6No1G/PkbUf3/vV4m3iklNIbJ76ueBlMLDl
	Y02+i5HnMwkVkmHGyZX2VgDUtTYpLrtVlKk+yYLhXFPeDoPyDNqoQ4QwtACXvV7u9QXUDDpoiitml
	7iHooEN7JnACL//RHCwR307Gpbjbm54rp/gXMoAfaTakq+rGKj6EvrQLM8pF0evNdJhWSGPjy2knC
	e7BBSVFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKO3G-0000000H4PQ-225B;
	Fri, 23 Oct 2026 22:47:54 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKO3D-0000000H4P9-1gym
	for linux-nvme@lists.infradead.org;
	Fri, 23 Oct 2026 22:47:52 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 7489C6022B;
	Fri, 23 Oct 2026 22:47:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E41771F01825;
	Fri, 23 Oct 2026 22:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792795670;
	bh=8yA8pzC09OthcjSV+5j+RAsWByRh9zkzbIUKM5Wq9L8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nhxLb6eGgpV2joxLw1rvC53hdHGq019sDwM0MUcUyl03NNpY2KOsajWznvpxNiIU8
	 nkSAboGLAYFXMt1/IX6z16NFIHUpZ83jWXwH6LKFc62p2Hrwr72rNcxgmToKxYV0V5
	 Q0g8vWgaMgx90AXqpABgJ8tacBPuFVlZa/2voYRQrh3OGbct5juBycOl+N7NlislMa
	 0G9jpzHX1F6f+dd2l6wuQCPugLsYAqDBQfkIuXQXP9pjxv5SD7fg0FfMz++XGwMrch
	 D5PRWNjxwAaDnlBCISyAO+fEMdemUuSxGS2Q2i3R6AHXs2BXv1S/ccfsfkXOLv+Gi5
	 Y3cj+nKG+qmAw==
Date: Fri, 23 Oct 2026 16:47:48 -0600
From: Keith Busch <kbusch@kernel.org>
To: Qing Zhang <diasyzhangqing@gmail.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	kch@nvidia.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet: protect nvmet_ports_list with nvmet_config_sem
Message-ID: <atvkFA4c70s1uJaA@kbusch-mbp>
References: <179275538809.275862.8334230595898232727@tencent.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179275538809.275862.8334230595898232727@tencent.com>
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
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 23, 2026 at 07:36:28PM +0800, Qing Zhang wrote:
> >From 554233f4165842a0a104896c30ed4d2e89c11931 Mon Sep 17 00:00:00 2001
> From: Qing Zhang <diasyzhang@tencent.com>
> Date: Fri, 23 Oct 2026 19:29:28 +0800
> Subject: [PATCH] nvmet: protect nvmet_ports_list with nvmet_config_sem
> 
> Readers of nvmet_ports_list (e.g. nvmet_subsys_disc_changed()) hold
> nvmet_config_sem and assert it via lockdep.  The writers --
> nvmet_ports_make() and nvmet_port_release() -- do not take the lock;
> they rely on the parent directory's VFS inode lock for serialization,
> which is an implementation detail of configfs and not a guaranteed
> contract.  Align the writers with the lock the readers already require.
> 
> Also move list_add() in nvmet_ports_make() to after the port is fully
> initialized: the old position published the port on the global list
> before INIT_LIST_HEAD(&port->subsystems), so a concurrent reader
> could traverse uninitialized list heads.
> 
> flush_workqueue() in nvmet_port_release() stays outside the semaphore
> to avoid a lock dependency on nvmet_wq.

Thanks, applied to nvme-7.4.

