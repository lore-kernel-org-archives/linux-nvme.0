Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B04B606CED8
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Nov 2026 17:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=g2TWve+J;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z7DPc+YA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=otmJpmEHmTauhUXesVvvVXQLO4MKBcNR6LE31jcten4=; b=g2TWve+Jwd1jEd7HCfO+D+BuXp
	f44JuSlp+UBMzwdNuEm7kz+hqtMGojUSnKpy30tSUMT2cwBUouzSei+7TueFPIu+ProgkO60rmx+V
	F2HxXeOrgM+QuU6ULddL7uPn22y/Hkjhylh8uTbz1XASnPzoXnOc/LJgzQTW3WiD3Omud2Kp4QZRL
	KqyyXLhlgcAml5cFY64Ve7ocf2EfnvlDEcWMYG/TqPf2PpSlQV0XpvnvJR3sOwCb/hxOCixSsORy3
	seiJshiA+Htak+C3pSq2FWywNXeey4hTrlohqxZOr/tfAPOLf9orspAmRaKNRzINVkFJPFpml9zDu
	IgD20XEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNvoE-0000000HSAM-1zez;
	Mon, 02 Nov 2026 17:27:02 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNvoD-0000000HSAG-3NMr
	for linux-nvme@lists.infradead.org;
	Mon, 02 Nov 2026 17:27:01 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 072DC60621;
	Mon,  2 Nov 2026 17:27:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5056B1F00A16;
	Mon,  2 Nov 2026 17:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793640420;
	bh=otmJpmEHmTauhUXesVvvVXQLO4MKBcNR6LE31jcten4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Z7DPc+YAb8lDqhnqEyerQhjhBZnbVnndxaxSHlV7MesY1qY1PJzDtnlXwRBuGUYxf
	 cm/oadxTy+Lqr9HbVI3806axafz9tyOszVeMCFbyGHPSQYlczZ9bOLOJjL3vB0P+ar
	 l2+EYfbpC37xaGo/VuTnMnnN9GJOHKKvV47ChpU+M35rFc5nxjF45/mTynG2I5Ax6G
	 DLtmJ35NTLiE7GXqFm+a4aMJqIfK89SbR74N+/DeL0Fx/KfGUvM4n8Kuuj9cjKLKQZ
	 SR6ND2+YJ6Yjy1VHWBnI1ynTGFyJfFmExPwJtrWORy/F2ITAENEWLlrAXB4RAJT7mx
	 POejSaN3wKHQA==
Date: Mon, 2 Nov 2026 10:26:58 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>
Cc: linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, hare@kernel.org, nilay@linux.ibm.com,
	wagi@kernel.org, kanie@linux.alibaba.com,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] nvme-tcp: fix use-after-free in nvme_tcp_free_ctrl()
Message-ID: <aujH4ujBJUe5uFYZ@kbusch-mbp>
References: <20261030170151.49844-1-christian.aurichzm@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261030170151.49844-1-christian.aurichzm@gmail.com>
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

On Fri, Oct 30, 2026 at 02:01:51PM -0300, Christian Aurich Zanettini Martins wrote:
> nvme_tcp_free_ctrl() reads ctrl->ctrl.opts to know how many queue
> mutexes to destroy. When creating the controller fails,
> nvmf_create_ctrl() frees opts as soon as nvme_tcp_create_ctrl()
> returns, but a concurrent open of the character device can hold the
> last reference to the controller. With CONFIG_DEBUG_KOBJECT_RELEASE,
> which delays the release, every failed connect reads freed memory:
> 
>   BUG: KASAN: slab-use-after-free in nvme_tcp_free_ctrl+0x38b/0x430
>   Read of size 4 at addr ffff888005b93740 by task kworker/2:1/51
> 
> Keep the size of the queue array in the controller and use it instead.

Thanks, applied to nvme-7.4.

