Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD29CCCA468
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Sep 2025 12:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JFSdzGGlnx8OxZJugDctiWEqKskJx/IHlfdBARlHdNY=; b=EW2aL8Pvk14/Qz760TeTXELCzq
	vC66infsU4VPT860fN2SAxn4hkJpPeHK+sUg4JE2qQ/5DbvQHv05s4+vdurtZxE8kNEgmE+Nc59Gu
	vWA/sn/0hnglVfU83GOwDnG7MUj6T8qIydIQF+7XmJbic/Ua2Pza7Z1hUThVEI9ViLiB8gB2yROdf
	pL8snzOlQFNmD7OysnLSecm+Mq97vDkNEFtVoOe7+d3Qjrn8DT+g6Hxlh99e3ElfLT+blSHK6v/u0
	qQOaGPJ5DnvYsaOf4Jf6/gaos8rNfJHKrLW+ABuQBmEXFQvpdpe50ieDYFXzl5xd/hANpwvNjsiHl
	pWl50zdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3ZRm-00000005G8m-3Xon;
	Tue, 30 Sep 2025 12:27:10 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3ZRj-00000005G7s-2TAb
	for linux-nvme@lists.infradead.org;
	Tue, 30 Sep 2025 12:27:08 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id BDB2943C6A;
	Tue, 30 Sep 2025 12:27:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B76CC4CEF0;
	Tue, 30 Sep 2025 12:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759235226;
	bh=Q7D3Sg/loyYXhkJkf5uJW+io+iBtSPozb+AM2qPQ4z0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DEojbuSmx5ZSZQPYhbee+hKjYMRHgFRJXkBDIlgmz3tsPX/hK0lFK9iZY6FZhYeAs
	 oRCaetz20mll5yGr4lvMYfp05nfZQMzkHGc6h6HGfJahYHn0T7J4xh20RZwtW/ECAN
	 Zuixyk704ataftTb4J8zIfFJmj19V6IJxXUi63esZx+NO8vOlDMCNP7UAd0CDwBZvK
	 bRbtIcp7HL4P2MyJkrK84Pxlh0pffdRBj7cPGmeDjmSH6fyvWLB63edfIT5atp3pQL
	 4bZG/dK0tzu+d838KJgAjZEbtVRTlDPjd2GfDtdN4X8Xj7nU6pqJ8/eZlMh5WoEMLB
	 yd1ocZa+JZqdg==
Date: Tue, 30 Sep 2025 14:27:01 +0200
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCHv2 0/9] nvme-auth: switch to use the kernel keyring
Message-ID: <aNvMleCjK1RsTjjQ@kbusch-mbp>
References: <20250528140517.3284-1-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528140517.3284-1-hare@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250930_052707_651959_F9C8F4D2 
X-CRM114-Status: GOOD (  18.37  )
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

> 
> the current NVMe authentication code is using a hand-crafted key
> structure; idea was to have the initial implementation with a minimal
> set of dependencies.
> (And me not having a good grasp on how to use the kernel keyring :-)
> That had the drawback that keys always had to be specified on the
> nvme-cli commandline, which is far from ideal from a security standpoint.
> 
> So this patchset switches the authentication code over to use the
> kernel keyring. User-facing interface (namely argument to 'nvme
> connect') remain the same, but the key data is converted into keys
> which are stored as a new key type 'dhchap' with a random UUID as
> description in the kernel keyring.
> 
> With this I have updated the dhchap arguments to 'nvme connect' and
> the configfs interface to either be the keydata (ie the original
> interface) _or_ a key description referring to a pre-populated dhchap
> key in the kernel keyring. This allows for easier provisioning of keys
> and avoids the security risk from having to specify the key data on
> the kernel commandline.

Thanks, applied to nvme-6.18.

