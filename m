Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00D81D12680
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2024 11:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wo1zgfGnEXM+JgIeRtdAg2C2V/ondOuwWv27eag6hiU=; b=Ui7t9Yk0jpZYPY5JB/14q75DTq
	NRHtAaF/6yzuFK1gKoYiuLOUHgBnnhIEa7OiCHUWBbtMhpWVjvt9BZt7kReaaYSRqC7yAkJnfDKH8
	MM/+LhbJUiVeNFSvucpjQEv+zZ/6Hg32C/C8v9JhwM9ftqxlLouFeBlhRkqqeXgSuKWVBoDw82vkn
	Pki9RbEfYKTHKcB+kBQN6iHFrP41RRTi9W9PqyQKp642keO9HvNpa55VekB3G2IhwDH7n5Ky/IK7x
	+1fMilkMDHRp+b0e4EBvE8k/LOAwgErlwKl4Qn0dZ2m+wHoH8kpAEPBxXWGkM2ivA/Ij4juL4b6wV
	/HoksIAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8HMc-0000000GmAH-0ybV;
	Tue, 05 Nov 2024 11:04:46 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8HMY-0000000Gm9G-3sjn
	for linux-nvme@lists.infradead.org;
	Tue, 05 Nov 2024 11:04:44 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1270F68CFE; Tue,  5 Nov 2024 12:04:36 +0100 (CET)
Date: Tue, 5 Nov 2024 12:04:35 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Matias =?iso-8859-1?Q?Bj=F8rling?= <m@bjorling.me>,
	dlemoal@kernel.org, cassel@kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, wangyugui@e16-tech.com,
	martin.petersen@oracle.com, hare@suse.de,
	Matias =?iso-8859-1?Q?Bj=F8rling?= <matias.bjorling@wdc.com>
Subject: Re: [PATCH 1/3 v2] nvme: make independent ns identify default
Message-ID: <20241105110435.GA1822@lst.de>
References: <20241010123951.1226105-1-m@bjorling.me> <20241010123951.1226105-2-m@bjorling.me> <20241011081452.GA3337@lst.de> <ZyVZ_T4HtnqSWTm0@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyVZ_T4HtnqSWTm0@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241105_030443_127231_434D427E 
X-CRM114-Status: GOOD (  14.38  )
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

On Fri, Nov 01, 2024 at 04:45:17PM -0600, Keith Busch wrote:
> I've got the rest of the required logs and identifications implemented
> in nvmet to support this.

Cool!

> There's one more issue, though, if we do
> restrict the identify to >= 2.0 or 2.1. nvmet reports 1.3, and I suspect
> there's a bit more work than just changing the value of NVMET_DEFAULT_VS
> in order to comply with claiming that version.

I don't think there were a lot of new mandatory requirements added that
we didn't already do, or already we already ignored anyway, but it is
worth a double check.

