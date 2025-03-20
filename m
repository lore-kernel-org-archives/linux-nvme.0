Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3ABBC28B30
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Mar 2025 20:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=90/kSq6rqO4UN0FYHV4y8W3qdbXpKowicC+b6P9M5mw=; b=0bDiSvywVGvWr4rgPsnnjKEdiV
	97WiwDYWlgKPzZ0LM4AXAgiCJ6pGOYnmO3719mI85j6HvpedWMdKXKWKHPM5L5N/3rsCFnQDIoveY
	HE9f6NpY7Ghqa3/j4bhAm3a7yuWBJdsOkrWxky8jtNFcYzuObtOy2CLmYF4FYKvVWFXyFm5AECons
	wb1ubzRu7xEczMVdyi3hxmfzcLqkeI4o0dBv9AgYwT23YzYTeKnzYbQrR//QwXs93yPsyhIjxfzkq
	Pk6udWDVtLypn2QAXY90YtDqXxqicdqDp8MX+JkGwToyeh3Fq2cMnFFh7Z0mJ3pgCZrVmYxsUN3W3
	HITsRrZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvMIV-0000000D9OF-1kX9;
	Thu, 20 Mar 2025 20:15:23 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tvMIU-0000000D9O6-2bzH
	for linux-nvme@lists.infradead.org;
	Thu, 20 Mar 2025 20:15:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 5424561145;
	Thu, 20 Mar 2025 20:15:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A8FDC4CEDD;
	Thu, 20 Mar 2025 20:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742501721;
	bh=WDbvPSqBjTg7wYfVhWLiaIXXqOk4KLK0lv+0872ZAFU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ftQosuKTgM76TyOQYBZ/KsAh7vIyb9Zx2X6EqH5Lpyparu8AEOF3uflOm/CrUKEaf
	 9JG5e362bwVtFtRgy2JtLKEZDeL4fB1DZOxQE4RUN+I/fEmclGtLba8PvGt7wgEJWK
	 CDMzhMUPYNN/Ymu4pSB6UwNy4+eNb0Mb1Y/AwS1jyEuEo3d1/VtAynV/DV+VyDNsmK
	 H5lsvGxNh7914G+Ewpm2HCFZvVVkWIXKBpf1pqS4C7uW5xMaUL1VpnqZYzTYnvmkzR
	 Eqt1Wop94OINiRiHN4N3cgUSigLbUil7twsBKA8kE7uUGg/FkLlQNiUaYOrWlHs2NM
	 AthmzkeRfj7gw==
Date: Thu, 20 Mar 2025 14:15:19 -0600
From: Keith Busch <kbusch@kernel.org>
To: shaopeijie@cestc.cn
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	zhang.guanghui@cestc.cn, gechangzhong@cestc.cn
Subject: Re: [PATCH] nvme-tcp: fix selinux denied when calling sock_sendmsg
Message-ID: <Z9x3V_mp4VcZgJOD@kbusch-mbp.dhcp.thefacebook.com>
References: <20250320063523.2201926-1-shaopeijie@cestc.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320063523.2201926-1-shaopeijie@cestc.cn>
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Mar 20, 2025 at 02:35:23PM +0800, shaopeijie@cestc.cn wrote:
> From: Peijie Shao <shaopeijie@cestc.cn>
> 
> In a SELinux enabled kernel, socket_create() initializes the
> security label of the socket using the security label of the
> calling process, this typically works well.
> 
> However, in a containerized environment like Kubernetes,
> problem arises when a privileged container(domain spc_t)
> connects to an NVMe target and mounts the NVMe as persistent
> storage for unprivileged containers(domain container_t).
> 
> This is because the container_t domain cannot access
> resources labeled with spc_t, resulting in socket_sendmsg
> returning -EACCES.
> 
> The solution is to use socket_create_kern() instead of
> socket_create(), which labels the socket context to kernel_t.
> Access control will then be handled by the VFS layer rather
> than the socket itself.

Thanks, applied to nvme-6.15.

