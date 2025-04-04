Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 850E8C3601A
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Apr 2025 06:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uj8DvKyGo0sv+6pkvMRxkfPmdNRsjCq8Vl3p5Qw8h+c=; b=WszXBnEa1VS+PVKoYAbnC0vYqv
	XyVnJIGBgGs+e1kr3pXxnX0T8GyVCsVVnXLxdADVEDWkVipyxmEV8TP3qzkLlThwE2SVgUDR0IbuG
	FPzo/ZU7+fVmIqKkVhuUxx3/hzflFoixMwp7juOKRWo7VF3QTQWGIlmsRmEC0jgX7XEGc85E3F5Hg
	qhwsAK36tBKLrbx2c4ZkAItNBO0Mb7RhslL7Ihua0zTECsdmWcOGw9EPPrTJuQXBZpiOm6vI4Iv4y
	j+ML6KOnVn5hHbZzM980XaJVpYiVur81mboNUY2Cp2YAMQKQqUVnlmBdgpihy0tlVl8DFSWgXifvG
	6pLerZqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0aPg-0000000ArOY-3uEl;
	Fri, 04 Apr 2025 06:20:24 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0aN6-0000000Ar9d-3CD3
	for linux-nvme@lists.infradead.org;
	Fri, 04 Apr 2025 06:17:46 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0A67468B05; Fri,  4 Apr 2025 08:17:32 +0200 (CEST)
Date: Fri, 4 Apr 2025 08:17:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: shaopeijie@cestc.cn
Cc: kbusch@kernel.org, sagi@grimberg.me, axboe@kernel.dk, hch@lst.de,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	gechangzhong@cestc.cn, zhang.guanghui@cestc.cn
Subject: Re: [PATCH v2] nvme-tcp: Fix netns UAF introduced by commit
 1be52169c348
Message-ID: <20250404061731.GA31237@lst.de>
References: <bd5f2f8a-94f0-43b0-af02-565422d12032@cestc.cn> <20250403144748.3399661-1-shaopeijie@cestc.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403144748.3399661-1-shaopeijie@cestc.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250403_231744_944702_A69D2DAA 
X-CRM114-Status: GOOD (  32.14  )
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

I'll do another minor fixup for the comment formatting, but otherwise
this looks good.  I'll queue it up.

On Thu, Apr 03, 2025 at 10:47:48PM +0800, shaopeijie@cestc.cn wrote:
> From: Peijie Shao <shaopeijie@cestc.cn>
> 
> The patch is for nvme-tcp host side.
> 
> commit 1be52169c348
> ("nvme-tcp: fix selinux denied when calling sock_sendmsg")
> uses sock_create_kern instead of sock_create to solve SELinux
> problem, however sock_create_kern does not take a reference of
> the given netns, which results in a use-after-free when the
> non-init_net netns is destroyed before sock_release.
> 
> For example: a container not share with host's network namespace
> doing a 'nvme connect', and is stopped without 'nvme disconnect'.
> 
> The patch changes parameter current->nsproxy->net_ns to init_net,
> makes the socket always belongs to the host. It also naturally
> avoids changing sock's netns from previous creator's netns to
> init_net when sock is re-created by nvme recovery path
> (workqueue is in init_net namespace).
> 
> Signed-off-by: Peijie Shao <shaopeijie@cestc.cn>

> ---
> 
> Changes in v2:
>     1. Fix style problems reviewed by Christoph Hellwig, thanks!
>     2. Add 'nvme-tcp:' prefix for the patch.
> 
> Version v1:
> Hi all,
> This is the v1 patch. Before this version, I tried to
> get_net(current->nsproxy->net_ns) in nvme_tcp_alloc_queue() to
> fix the issue, but failed to find a suitable placeto do
> put_net(). Because the socket is released by fput() internally.
> I think code like below:
>     nvme_tcp_free_queue() {
>         fput()
>         put_net()
>     }
> can not ensure the socket was released before put_net, since
> someone is still holding the file.
> 
> So I would like to use the 'init_net' net namespace.
> 
> ---
>  drivers/nvme/host/tcp.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 26c459f0198d..9b1d0ad18b77 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1789,8 +1789,14 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
>  		queue->cmnd_capsule_len = sizeof(struct nvme_command) +
>  						NVME_TCP_ADMIN_CCSZ;
>  
> -	ret = sock_create_kern(current->nsproxy->net_ns,
> -			ctrl->addr.ss_family, SOCK_STREAM,
> +	/*
> +	 * sock_create_kern() does not take a reference to
> +	 * current->nsproxy->net_ns, use init_net instead.
> +	 * This also avoid changing sock's netns from previous
> +	 * creator's netns to init_net when sock is re-created
> +	 * by nvme recovery path.
> +	 */
> +	ret = sock_create_kern(&init_net, ctrl->addr.ss_family, SOCK_STREAM,
>  			IPPROTO_TCP, &queue->sock);
>  	if (ret) {
>  		dev_err(nctrl->device,
> -- 
> 2.43.0
> 
> 
---end quoted text---

