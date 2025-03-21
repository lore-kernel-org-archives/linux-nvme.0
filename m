Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97196C36004
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Mar 2025 06:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7lqnKFjLFsDlLL1dJDti4t8+vdjAf4Xn7/vC7rQhEtI=; b=4ACVIG5Y36hyfpGWddodYTf1NY
	MCPHwyKJH7e4ceRGjjF9eSiutABF/LUX0Usb3orxzKs031PHaO574Qw/4rRg1bW3yZItw7bxC7A8D
	k7BHQzkA5VBLZk3Z14sMV/VwltOBY61w3LUeTZBUc7B6X8CY+FsTU3IJG1S5Qn+gGfE7uVMc05d58
	FNfuFkwZiw6YN2lUxliajWL1HHgg6ZY97se+vnmo74x7ClHtHQLrOuvWFkVM1uIjmiCrK1MFg9Ryl
	0UTD9Oyzd5Lo/u0O3cwBtrW2rMNMXRByCz/6LhAAMaT4N3aCgQsML3Hdyi0be9gdONHx7ml0V673b
	dEQUyGtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvVfo-0000000Dy7U-2zl4;
	Fri, 21 Mar 2025 06:16:04 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tvVfL-0000000Dy3A-2hxN
	for linux-nvme@lists.infradead.org;
	Fri, 21 Mar 2025 06:15:36 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5945F68AA6; Fri, 21 Mar 2025 07:15:32 +0100 (CET)
Date: Fri, 21 Mar 2025 07:15:31 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <wagi@kernel.org>
Cc: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 12/18] nvmet-fc: inline nvmet_fc_free_hostport
Message-ID: <20250321061531.GD3198@lst.de>
References: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org> <20250318-nvmet-fcloop-v3-12-05fec0fc02f6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318-nvmet-fcloop-v3-12-05fec0fc02f6@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250320_231535_821310_761A3E13 
X-CRM114-Status: GOOD (  13.53  )
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

On Tue, Mar 18, 2025 at 11:40:06AM +0100, Daniel Wagner wrote:
> No need for this tiny helper with only one user, let's inline it.
> 
> And since the hostport ref counter needs to stay in sync, it's not
> optional anymore to give back the reference.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Btw, given that the series keeps growing and needs at least another
iteration maybe just send out the trivial cleanups and fully reviewed
simply refcounting changes ASAP to make it easier to review?


