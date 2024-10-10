Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BEB0CF07C3
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Oct 2024 08:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IOqFT4sEGUli4sTQXZ2LsrA/kEaen1ceoKNwlxemm8k=; b=dpq60vs94n3X8un6+C4NgWAV9N
	bLx1fuA+GwwzOgnWPn5FBoSYBdXnDM/Xj2LgVx8qvghYd3ov4CqtAm5hjALBxfQWUgrzD6mFwp9y9
	/2rwa0R+H6lRfwzHrLvia10OvMWJud6v7Ttudv9WfqovPQl5GLVMk6xqfJv8I8QsHbCKhr3kstnFE
	xdpO5g6NliqOgPsqHjwlICnl2JhQc9MMipcU0vPSg/4zmS/ecZP4AqO3w/a32H6nkicLO6mc2E29x
	yTBPYXZwUPVEFqfRaR6EU9/cEv2DIdJyiBlY10wCYWFmeXKqJD/hmMmWlKKEkAGjZeLr29PWtULNB
	wu8XVPHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1syoYw-0000000C0bQ-1QPD;
	Thu, 10 Oct 2024 08:30:22 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1syoWd-0000000Bzym-12i7
	for linux-nvme@lists.infradead.org;
	Thu, 10 Oct 2024 08:28:00 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2FE63227A8E; Thu, 10 Oct 2024 10:27:55 +0200 (CEST)
Date: Thu, 10 Oct 2024 10:27:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-pci@vger.kernel.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v1 1/5] nvmet: rename and move nvmet_get_log_page_len()
Message-ID: <20241010082754.GA8319@lst.de>
References: <20241007044351.157912-1-dlemoal@kernel.org> <20241007044351.157912-2-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007044351.157912-2-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241010_012759_450845_194DD33A 
X-CRM114-Status: GOOD (  13.02  )
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

On Mon, Oct 07, 2024 at 01:43:47PM +0900, Damien Le Moal wrote:
> The code for nvmet_get_log_page_len() has no pedendency on nvme target
> code and only depends on struct nvme_command. Move this helper function
> out of drivers/nvme/target/admin-cmd.c and inline it as part of the
> generic definitions in include/linux/nvme.h. Apply the same modification
> to nvmet_get_log_page_offset().
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

