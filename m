Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 158CEC47258
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jan 2024 09:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QALTs9Kmp7/UA20WGIBltJ6GBQ535ozOlG0OfWcQk6A=; b=kItjIuVOs0htDIMWp2bOf2wXZX
	5lXSDtm5f8KxQW3LjSVoLdBqy4NkAFaugXFoc4S6KkKap7C7wiCl5P+3sej/Nxs4JqoGe9UaiECyx
	qY8frQdYt8C1aMmC8t+flG8gbIIDTcWi1OVVl50/rz9tMnQwr++gxYhG9ScOLL6MECOjs7JOFXzjh
	IUW5zAWltP6+1wQF+jdw2O2/Kwi1R3L02kDQA6HD1ryFQj37+HskvCmnEzZnqHWruMvdmAfF5sAdd
	Zdxr80sq9cXZFVODXhFD/jSdCrFHJYA/q5PtR+3GDWGiYUC2BXCBHiviuABvP55ld3D0W4HF7Wqcs
	/3W79lDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSCfl-00FgLJ-2v;
	Tue, 23 Jan 2024 09:02:21 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSCfj-00FgKf-1z
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jan 2024 09:02:20 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0A3B668BEB; Tue, 23 Jan 2024 10:02:17 +0100 (CET)
Date: Tue, 23 Jan 2024 10:02:16 +0100
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, oren@nvidia.com, israelr@nvidia.com,
	dwagner@suse.de, oevron@nvidia.com
Subject: Re: [PATCH 3/8] nvme: allocate a new namespace if validation fail
Message-ID: <20240123090216.GC30773@lst.de>
References: <20240122145659.5574-1-mgurtovoy@nvidia.com> <20240122145659.5574-4-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122145659.5574-4-mgurtovoy@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240123_010219_801106_E284DC0D 
X-CRM114-Status: GOOD (  11.48  )
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

On Mon, Jan 22, 2024 at 04:56:54PM +0200, Max Gurtovoy wrote:
> Namespace validation can fail in case some of the namespace identifiers
> were changed. In this case, we will give up and remove the namespace.
> Add a mechanism to retry the allocation of a new namespace instance that
> will be setup according to the new namespace identifiers.

Can you come up with a testcase for blktests to exercise this path?


