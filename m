Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8B13C4167B
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Dec 2023 16:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RWOFC6IBNyaY+k69wH5pBEtEPXyyRGXMkoHVwyv4/m4=; b=0HjJ8glTuaIO9f/WzDfrcnt+8f
	iJQ9U1uKhvrK6K4LNxBRavcLNtrd5Try8HQ/0EEucm1GtA6kmnRFvTbwsoqhYJcBRR5gPKaAFqoZY
	ZlINocy/JcSy2Qedhr0Vf69mgu/pL3M0V/SFJkYGo4Zxktq32uSc7ZpEuivEWPd9svqtliqQL2e2K
	8dJC4BEqzrlqFQOGh7oRkh5AaCzjxSt4FskOg6bOQN/jJMA55PWya8fiuOdoSw3cl5yvM5sbFd+CZ
	nMN7So1X/wWKBSk0YJH+vNhnEZV+FYKpdzVz2SlzOglE9ITzGip9qUBrOALvH8nx3cnSghlGge/KC
	7FLs1X3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rBHUm-00DRCY-2s;
	Thu, 07 Dec 2023 16:45:04 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rBHUk-00DRBp-0K
	for linux-nvme@lists.infradead.org;
	Thu, 07 Dec 2023 16:45:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 5720661D5F;
	Thu,  7 Dec 2023 16:45:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85FEDC433C7;
	Thu,  7 Dec 2023 16:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701967501;
	bh=r+2jjC0f0ebNBy1BCSaTbfdEHy6BgmMv/wALzLuGFfI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O56R/5dxnNuijI23Fdx2eClph/7XUdaH7+xQVKceIHKqtHIUa8zQ3HuzXiQxzW/Cn
	 l+66bW9N17S2w5Tx9CeE8OfpgcfehGmlSYAtcF1/NNoEvCQ2ErSUDrJGPsxiQZ/XDv
	 i+kSR00V0rPvGaZqdv5iy9d4a9xTQFEb2I56bxvg4POZz2R9ZvVLeoApwmqgE0Fb5X
	 BvZXqy9c2cF5A9I1R0UBVSeqZWiuzyxnRHpWChxNzv9A+5nuzQeUYtnU5W1yyDy0Mc
	 5NEZFKc0baTll7ZqT8PgeEoGoP1X1EWkwREJswtHCIdMn7PqIhvhdMymJppy0wKYQo
	 zgFY37u9FLN/Q==
Date: Thu, 7 Dec 2023 09:44:58 -0700
From: Keith Busch <kbusch@kernel.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v4 3/4] nvme: add csi, ms and nuse to sysfs
Message-ID: <ZXH2is7F56nRlGqd@kbusch-mbp>
References: <20231207123624.29959-1-dwagner@suse.de>
 <20231207123624.29959-4-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207123624.29959-4-dwagner@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231207_084502_198171_2FFE4356 
X-CRM114-Status: UNSURE (   8.62  )
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

On Thu, Dec 07, 2023 at 01:36:23PM +0100, Daniel Wagner wrote:
> @@ -3418,6 +3419,7 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
>  	head->ns_id = info->nsid;
>  	head->ids = info->ids;
>  	head->shared = info->is_shared;
> +	ratelimit_state_init(&head->rs_nuse, 5 * HZ, 1);
>  	kref_init(&head->ref);

I think we need to add:

	ratelimit_set_flags(&head->rs_nuse, RATELIMIT_MSG_ON_RELEASE);	

So that we don't get periodic messages like:

	[   60.469730] ns_head_update_nuse: 39 callbacks suppressed
	[  159.532901] ns_head_update_nuse: 1999 callbacks suppressed

