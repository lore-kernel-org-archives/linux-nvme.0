Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24FE7CCF9F8
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Oct 2025 09:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ji/7nk5D06UQnZCk2ZJFRagWqwoN7+vE2MgnSiA2CsY=; b=3CQ3n1zJuAKnPzurLuzgestfq5
	3zzwSZuNE24k9gI5Zeb0NxV9ulgVrR/E45+uKpF3lWu/kqfhfMoi3sI23JTc1QiL+XOUVoA3uD+85
	BpjzWiOSks6eiWsM3FLfq2hEeNSzujNp9+l4f0o0SkrwZPoHRkWzVrzXfrVnsFghvL8mGRMJaT2RS
	JSUfMekQIDo39pNmyN1ihSa5wpiUlZKgLFdLMO0lGG2vjTNW1CABihYyoO4Rs6/TszD2dqnYxOaA1
	CWKeFXDj5RX5km4+O7iC3eBnQgZxrfFtWX6i2c5s1Xxy4qm2kNMphs8nBFZ0YTSX/1GO/nD6+Ra8R
	ZkZoEJ7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vElu3-00000005qP6-1pLU;
	Fri, 31 Oct 2025 09:58:39 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vElu1-00000005qOe-09ze
	for linux-nvme@lists.infradead.org;
	Fri, 31 Oct 2025 09:58:38 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8E2D5227A88; Fri, 31 Oct 2025 10:58:31 +0100 (CET)
Date: Fri, 31 Oct 2025 10:58:31 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de,
	Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCHv2] nvme: fixup nvme auth host/target dependency
Message-ID: <20251031095830.GA10293@lst.de>
References: <20251031002655.2999568-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031002655.2999568-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251031_025837_271905_95C2FF6B 
X-CRM114-Status: GOOD (  11.54  )
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

On Thu, Oct 30, 2025 at 05:26:55PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Converge the enabling of nvme-auth for both host or target into a single
> selection and implementation. The selection must inherit the strongest
> config selection of either target or host, so some Kconfig trickery is
> used to make that happen.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Let's see if the buildbot agrees :)


