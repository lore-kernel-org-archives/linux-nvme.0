Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C351C4167B
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Nov 2023 18:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ljPY6c+ZVoDaRu9URPSlOl+hj7hixao53nDFvdkaFl0=; b=Qgh7otKmJ77K8ov0PVs65mRxge
	jm7CdZkh2MgcYFaB3tnzYY4jKASLL+VAgRHvFQQ6JmIKOzmiN3ACHTvEm14TuttLqmmEEv65x5BXE
	3AaE62JFghUtwsPZZOZ0C0v4l0p4oKCi6/RJFJmKl3romlya8JwS3QlwRH8LyjeISquwEj3CcP8zL
	/uuaDVbdRJTh74wo8tQaNMGhgEL0Yun8eOKW+UmnUOhkv3CV6h7AumEDzT7suPqF6PYgXQNmn54NX
	Nj0Y5OOfCa59pmX1psR8hcsy9RQ/Lwjlb3SbyiChYrpjWNiCdDU1ig9lDx77DlS3/EjKVQZMek9lK
	kbu+8hjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r7g0u-003Bx6-0Q;
	Mon, 27 Nov 2023 18:07:20 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r7g0q-003Bwk-1S
	for linux-nvme@lists.infradead.org;
	Mon, 27 Nov 2023 18:07:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id B7363612AB;
	Mon, 27 Nov 2023 18:07:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D53BDC433C7;
	Mon, 27 Nov 2023 18:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701108435;
	bh=C3iVJwmeksjG1jAgFK6vw2pYVe/zJA3lIfqMl4WWsac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fx2QF6SBm6idjn5TdulasO2joS/StL0OvmHxjqPckG9XbaDVKVQqLguxJ+olvY9fp
	 ACMHcwPPgjcKunryqyL9FtMNaOBb7xdAIRGon4eElaOX8Wxy63hBHFUB59+NXRjUyt
	 FL1l8BeDv907J+DzcvkrXFbWYeBc/0r6B4uYGno7EmzHMdX9ID3JJKWWm29+w2L3Ms
	 amjd+gzzB1JeYYEHBbzZg2OtWWizp6kalTUrh4Pa1HxKZiiTt/hKcqI3x17EMFBDMY
	 PTSVVm5b4at1yVXypqNr584qNxZRzsZaJAIU3u48Slb40iAqbUPch4eLPHGr/JWCPn
	 rS4hrjKDnJ7Kw==
Date: Mon, 27 Nov 2023 11:07:12 -0700
From: Keith Busch <kbusch@kernel.org>
To: Bitao Hu <yaoma@linux.alibaba.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	kanie@linux.alibaba.com
Subject: Re: [PATCH] nvme: fix deadlock between reset and scan
Message-ID: <ZWTa0DJmcLKHRWWC@kbusch-mbp.dhcp.thefacebook.com>
References: <1700737213-110685-1-git-send-email-yaoma@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1700737213-110685-1-git-send-email-yaoma@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231127_100716_578140_BB5A6A7B 
X-CRM114-Status: UNSURE (   8.86  )
X-CRM114-Notice: Please train this message.
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

On Thu, Nov 23, 2023 at 07:00:13PM +0800, Bitao Hu wrote:
> @@ -3631,6 +3631,11 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
>  		goto out_unlink_ns;
>  
>  	down_write(&ctrl->namespaces_rwsem);
> +	/* preventing adding ns during resetting */
> +	if (unlikely(ctrl->state != NVME_CTRL_LIVE)) {

We can't rely on ctrl->state for preventing deadlocks. Reading unlocked
ctrl->state is often used, but should be considered advisory-only since
the state could change immediatly after reading it.

> +		up_write(&ctrl->namespaces_rwsem);
> +		goto out_unlink_ns;
> +	}
>  	nvme_ns_add_to_ctrl_list(ns);
>  	up_write(&ctrl->namespaces_rwsem);
>  	nvme_get_ctrl(ctrl);

