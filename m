Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03EC1CD8CB2
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Jun 2026 16:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BmnzHaguHtKrAa2TQW4hv2Uu6Zp1K1zLfEAoMbU81Ks=; b=mZ+v11Xm5yEGo5seLbDx9y+SD7
	uKDTIzqsp+2FdSgARaQUcM/pdb97j6i0zFUfwQ3rzjsbRsVUYj2/RvJsWdZ2JdPiHgR3znGWMdNwp
	Lr2C6BHbowTre6djVk1OBJT1hRHrWBk2ai63vkoQLbKR4bvqfMBIZ8Cb1vVPIlA5ZJ9dMZhsxqwgn
	hHUMs9W3Uqeyx9hvvw2ELDWfyQ1rv2BzghtChADcl38kfVbfaSBTfep1Yzds4THz0ypySy+dtMsnD
	EPnCySMuR0wyIb/3jMs24Q8cQP2068Sljw7DQV1K+hJFvQrf8nRDPdBp73fA9s1oNHDTHJV+iks48
	xiPJW7Sg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWzZ1-000000064we-0fDD;
	Tue, 09 Jun 2026 16:44:31 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWzZ0-000000064wS-3LeG
	for linux-nvme@lists.infradead.org;
	Tue, 09 Jun 2026 16:44:30 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 691746022D;
	Tue,  9 Jun 2026 16:44:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCC161F00898;
	Tue,  9 Jun 2026 16:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781023469;
	bh=BmnzHaguHtKrAa2TQW4hv2Uu6Zp1K1zLfEAoMbU81Ks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BorsVzHls2J/YBQteZWCZbMXAOp0n+Qm7iccO3JxCW2upxHeITtBNGeiFw1Ofp4zA
	 uzAc9n3mfmV1pOgaaqu9vsZw8LzSXwJBKOGwqjCh+fLy4OPAPEF81h9jWsaiPVrzXC
	 Q838Rm/Z1UerIKhtq+bb/MkVzY0J0YnnUP6ImtNVkUEnBsoLIDa2BV8Pb5x+G3YOWt
	 68KJ1GbUGGuQ0l8eLk+6nUMzctWfcznzn2+1XWIpKd4dH2AcAzItG7TCtX+5IwYfyw
	 4QubjMAYFFMkY14ihVLoWcx3wWEZJ84RTiIAbX/aDTdnC8Vn5oXLLL4imK58duWCvS
	 EGYNXHYFLlJFg==
Date: Tue, 9 Jun 2026 10:44:27 -0600
From: Keith Busch <kbusch@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] nvmet: fix refcount leak in nvmet_sq_create()
Message-ID: <aihC67cPlS_Y6vB0@kbusch-mbp>
References: <20260609095505.227496-1-vulab@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609095505.227496-1-vulab@iscas.ac.cn>
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

On Tue, Jun 09, 2026 at 09:55:05AM +0000, Wentao Liang wrote:
> In nvmet_sq_create(), a reference on the ctrl is taken
> via kref_get_unless_zero() before calling nvmet_check_sqid().
> If nvmet_check_sqid() fails, the function returns the error
> directly without releasing the reference, leading to a leak.
> 
> Fix this by jumping to the "ctrl_put" label, which already
> performs the necessary nvmet_ctrl_put(ctrl). This ensures the
> reference is properly released on this error path.

Thanks, applied to nvme-7.2.

