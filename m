Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1468DC41535
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Dec 2023 04:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tVUAD9PN1l93dwPW/CeQKBtrKU6CsGpn13H+RdpvzCA=; b=pKLdYs+PCWLIEajauB1oKQaSjc
	CUwlJHCg2AykvKd9UEFZ3lLUFElrfDco0wXCJEaqGFu+saH4gUSkd9r+gSqco3xK0/wxNgFqiNp7t
	OxcNyRxnvN17gh2L0m+sdu2oMxOZA3mHgtyz2sGXM0mo58WfgUtFCd3/kycR5i1qSa0hG1AmeU/kz
	7g6m9i3RUNn5l2jzsQWzK4HTUtLauxN2AkUD17q4bhds8j+Xe+iUgfVCLXQd8rUvZgd6BSb/iRdgu
	uM72aQjhxw/b4ZJIntCe8An23AdjsxlhwNdzNSiGVVJnUBp5efWmhf3KDVxZxPRz08y2wZYPA1ehs
	HHcSbiqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFRhT-00Cmgs-0F;
	Tue, 19 Dec 2023 04:27:23 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFRhQ-00CmgN-0P
	for linux-nvme@lists.infradead.org;
	Tue, 19 Dec 2023 04:27:21 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7CAE068AFE; Tue, 19 Dec 2023 05:27:17 +0100 (CET)
Date: Tue, 19 Dec 2023 05:27:17 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v3 01/16] nvmet: report ioccsz and iorcsz for disc ctrl
Message-ID: <20231219042717.GB30580@lst.de>
References: <20231218153105.12717-1-dwagner@suse.de> <20231218153105.12717-2-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218153105.12717-2-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_202720_315238_AA8A9160 
X-CRM114-Status: GOOD (  12.00  )
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

On Mon, Dec 18, 2023 at 04:30:49PM +0100, Daniel Wagner wrote:
> +	/*
> +	 * Max command capsule size is sqe + in-capsule data size.
> +	 * Disable in-capsule data for Metadata capable controllers.

A why on the disable would be useful here - the fact that it is disabled
is pretty obvious from the code.

