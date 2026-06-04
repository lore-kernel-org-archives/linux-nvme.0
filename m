Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E51CBCD6E6E
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Jun 2026 21:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Vb0PKiPDb20MUl1crj7pmHeG9nUWBSMcJDTWQZL/tzI=; b=2k+HZYTJzCB3RoEL+SljvoP8GL
	b01E+zcrA5RL8FOpggpiDXFfZrHNmIs+yxLRmRljNkAzIDsoLVT9wWBRRoADWWdh17DLqL7TAXb5t
	JI28etaV+vwa+XAPUiOx/vKbOQ9RDh+iUHbVYMVFTqLL9uu0kgactS81NYyusUMskyMErU4Yd6PnM
	XvKZsredwnaMz7Wvf9091nyGOLPpZkH3SSVUrlAs+kdILcPX5MLU0NS4iZFBWgavn6h61GWcSesFx
	RAnH4uQYQWKVGG7eTpwvv92ZkxdoGuhP4y/Me7mnMBM+ZrvKjfXel4AZLPGQs3k431aQluneazZzx
	t/a1Veqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVFhE-0000000HLbQ-32xe;
	Thu, 04 Jun 2026 21:33:48 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVFhD-0000000HLb5-1nZZ
	for linux-nvme@lists.infradead.org;
	Thu, 04 Jun 2026 21:33:47 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8E10F6001A;
	Thu,  4 Jun 2026 21:33:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44D481F00898;
	Thu,  4 Jun 2026 21:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780608826;
	bh=Vb0PKiPDb20MUl1crj7pmHeG9nUWBSMcJDTWQZL/tzI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WF/35e+Wvzmi4Z3hqcSp57qOZbeEaIqcfyUIUKe9MxVyd5dCcogzd7Awm6sdIKt47
	 LOJjy4X6h/rgu09cNDOmwFizInc7q5ZI9WRLsUNsrbV9A7gHBUqINIw2n8dwg6MTLG
	 FDBWCsiDBGO9tqHNr/F8NxmGzALXnz5F0M97QpRwsEEqUBHSc0oDJBpkMcxTyG/wx9
	 BeVIzp/6z0nhkzYbdrO981sY3J8WwfRvJ4TxOlp9JIap5ASI5m18mYC95DemmEEWLc
	 +itH+gJuNSVSiz5WYhHWnYmSsDSrr5UGggo5aErI3CkubnkC2Fd3H3TjlPyCjAEwHn
	 KnHJZgz4c6rAg==
Date: Thu, 4 Jun 2026 22:33:42 +0100
From: Keith Busch <kbusch@kernel.org>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: hch@lst.de, linux-nvme@lists.infradead.org, dwagner@suse.de,
	mlombard@arkamax.eu
Subject: Re: [PATCH RFC] nvme: fix crash due to invalid cdev teardown
Message-ID: <aiHvNvqHTprJmzRO@kbusch-mbp>
References: <20260604134308.192478-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604134308.192478-1-mlombard@redhat.com>
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

On Thu, Jun 04, 2026 at 03:43:08PM +0200, Maurizio Lombardi wrote:
> In the NVMe multipath code, if nvme_add_ns_head_cdev() fails during
> nvme_mpath_set_live(), the error is completely ignored. However, during
> teardown, nvme_remove_head() unconditionally calls nvme_cdev_del().
> This teardown asymmetry leads to a kernel panic if the character device
> was never successfully initialized, which might happen in very rare
> circumstances.

Yeah, we need symmetry here, so no argument on that. Your patch is a bit
odd, though, in that you're treating multipath cdev failure differently
than non-multipath. I honestly hadn't considered this extremely unlikely
scenario. I guess we should proceed with just the gendisk in all cases,
but I know of several important uses that definitely need the generic
cdev handle here, so I think we need a clear error message that this
error event happened.

