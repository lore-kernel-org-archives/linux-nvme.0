Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF267CC6B12
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2026 15:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tE9O0wD4ieORvk2wvCbvHe7+pQf0HfxWA0qZ7034qBY=; b=iEsVN0m8LnNVUeKv+tdpbv8H1/
	EReWBU9tdBZJN1JoKSPSA+eWVXF4JG4+UP7FlGbs6bvD5eWE46a7FMcv2o4tcIUs+vJ+rUNEYQSeC
	BUAf6LcoYISrin5WPW4gKJ0qIAJ989UVQ1n0PFlaleG6+XVCFNfk8NrqV6wqDi1zhLkVs924JY1KN
	U9fGEtqMiLpDevyIHc9PlPOa48NDjZdLI1XQex9Gxtzd1A/BMEYnTqR3uLVOxqoHXhE9VmiyglViM
	Ah44uYAYiqDtX2lBLQM4bg3RdnE2TL7jR/4iylCNmy4a6jXjRTV/IW4W82Is+ZceYw8RBUOLi36ts
	K80Bgt5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGegZ-0000000DP5D-1fx5;
	Tue, 13 Oct 2026 15:45:03 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGegX-0000000DP4N-1fSi
	for linux-nvme@lists.infradead.org;
	Tue, 13 Oct 2026 15:45:02 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8F73860A52;
	Tue, 13 Oct 2026 15:45:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EFC41F00893;
	Tue, 13 Oct 2026 15:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791906300;
	bh=tE9O0wD4ieORvk2wvCbvHe7+pQf0HfxWA0qZ7034qBY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bwNCBvhJNa5y8ipkT8bwQF95HJ0Pihxt/RIvHdN61Ix5PuaULJCTHRRi5t4nsqjQ/
	 EIwy5eKl28TNbLFnrZqoHiB1nmz01z6ySc/LlVoqYehNx0FGj+2myHv6gMnWR5CO54
	 RSUZmhxqRbVWMuVOUxTDqDJ2RqdIoFRt4tEWmSuI3Ue13nRELUEpnJE6ApJpJayje1
	 OyBl0jkgqnCKuprOruRMCZ0jbfSgTskfY74QRf3XIDQ0g0R5Ayt86ImXeUiWsC50wT
	 hdts5OhdSxLIbP2MVwDoa81C3DUIySycxFPccwq7c6g9BMsgDdSiBcopjQCHTXXiu3
	 6yDrwmigf/RxQ==
Date: Tue, 13 Oct 2026 09:44:58 -0600
From: Keith Busch <kbusch@kernel.org>
To: Yao Sang <sangyao@kylinos.cn>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v2] nvme: pass partition flags to passthrough checks
Message-ID: <as5R-unUet33avke@kbusch-mbp>
References: <20261013075324.565535-1-sangyao@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013075324.565535-1-sangyao@kylinos.cn>
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

On Tue, Oct 13, 2026 at 03:53:24PM +0800, Yao Sang wrote:
> nvme_user_cmd() handles NVME_IOCTL_IO_CMD on namespace block devices,
> including partitions. It receives flags identifying a partition, but
> passes 0 to nvme_cmd_allowed(), bypassing the partition guard and
> allowing unprivileged passthrough commands to access sectors outside
> the partition.
> 
> Pass flags to the permission check, rejecting unprivileged commands on
> partitions.

Thanks, applied to nvme-7.4.

