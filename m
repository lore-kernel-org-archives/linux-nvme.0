Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CFB3FED9E4
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Mar 2026 15:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z9AfF0VemgSmwxpwb9dI4A7eCs7Ptq/f7SKH3Mewwa8=; b=BNLxY6Qy60CZqCn1sbtot21iCl
	YRpUgDWV4RKPPPxYeDEdQt75Q+f37no3ZUKoWaDrv0AWa8eC5CZhUjSOBShoNaqG/JMRPgQgazGSM
	F01wx72TJJMIdroouJKEIEPSkl2ydaI8NlFLCWfrVqYw9lAwo/eVCioRitW5rKcEMCqaXx21MZ28v
	iPo0qm0XXVSmACKXP1xEc2tPe1wXGH2wy8yYT4I9r3D+VwZfTzXuh2gF9X7lLNSV65EIy5j8F7jzC
	4Fbfc92+fDn2F+PoDWhtkG51k/PhWcRbPmKVPspWMGg5rP0nc0iIEL5ocNCAL/LaJ/1JNHJFTkqQ0
	G2VhSbhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2W6l-00000006hfE-2OWA;
	Tue, 17 Mar 2026 15:13:23 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2W6j-00000006her-0cKD
	for linux-nvme@lists.infradead.org;
	Tue, 17 Mar 2026 15:13:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id CFF4944536;
	Tue, 17 Mar 2026 15:13:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64F0FC4CEF7;
	Tue, 17 Mar 2026 15:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773760399;
	bh=bfPj8erh9WTMxcZ1+PIES4PVpxiIRApG8OoR4KUOOT0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TbJrq093B95I5LUKTUHwH2c+aIJk4BESohMyTD0CzemcIwdGfftTvhJt4i0ssG1He
	 ATJrQRsKeZNOXwC357teJhCojha1GoCIllcXAVvgyMdBNLHv/bTtQPETXAWJfWY8G7
	 h4AZgW9Gg7yjKtyULHhgjnoJRxUt2kwIGCtYv55TgJ5FdWf+hfsv+lXAZb7S/wE/4L
	 bM/KyoSVbDZUcDYMH/0bzb5Yu2kiHF1dglhA44xqW11Ns4KtVphSLo3rBqlDII1We2
	 S6flCdZaiaaMLExMy/NtrGyuzOv2PuIy4IYTTsc/TKVJGKWqe/v/UEncx5qtYm1RML
	 lxxyb7149XbwQ==
Date: Tue, 17 Mar 2026 09:13:17 -0600
From: Keith Busch <kbusch@kernel.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: "Ballard, Curtis C (HPE Storage)" <curtis.ballard@hpe.com>,
	Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: libnvme API review
Message-ID: <ablvjTwvfkvZGXvu@kbusch-mbp>
References: <d5b9ca7f-8fd1-48ea-a883-79e92d92ec7e@flourine.local>
 <MW4PR84MB223598544C3E0EC5DA7FAAA09840A@MW4PR84MB2235.NAMPRD84.PROD.OUTLOOK.COM>
 <93520cef-9e3a-4832-9bfa-a0f2c36246e3@flourine.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93520cef-9e3a-4832-9bfa-a0f2c36246e3@flourine.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260317_081321_239109_06A94392 
X-CRM114-Status: GOOD (  10.64  )
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

On Tue, Mar 17, 2026 at 10:26:28AM +0100, Daniel Wagner wrote:
> > With spec and common use in mind, one proposed changed jumped out at me:
> > | `nvme_subsystem_reset`       | `nvme_reset_subsystem` |
> 
> This is from ioctl.h, which provides the interface for interacting with
> the kernel via ioctls. As outlined in the email, the proposal is to
> adopt the nvme_VERB_RESOURCE pattern, which more closely follows the
> kernel's naming scheme (at least within the NVMe subsystem). In this
> specific case, the NVME_IOCTL_SUBSYS_RESET ioctl is issued, which maps
> to

With "subsystem reset" being a specific thing, the pattern should want
something like "nvme_do_subsystem_reset".

