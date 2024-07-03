Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3CEEC2BD09
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jul 2024 05:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zZ5pRoj6ASiWQl43qED1aOsiR+0zmum+aKUxJ27/Rrc=; b=yIsyjgr3gzcbv3pkJGgxx9hqhT
	pSiDZujTE4erut4gCMsrj1xlI/YMr936hV4TStuSN+Sd1V7A4li7AxBsP9s7SewJRjKcfKTwIFak9
	8iGe46i88IYmfq9XX+bNJ/oKHv6dHew+O77qkbdyYebXPtSIA6kLCbyWzsYEj6261I1ouD9u6Yz3q
	xDD9kAdOjeDADYbS8YrxXRRQ1Nf5Om/DHPMEF8QxRNZVJn7dQ671IpqCqXR2sdU4LuJ3PBoancDPt
	DsNnMHN0ES4HQHRk9Q6zlvKkxMP9FOJtyqZsDdV8fCJtcva95WAq7THVW9SWWT9jHwsY2Z5k+cHAM
	kOSwbZzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOsTS-000000092hU-1m8i;
	Wed, 03 Jul 2024 05:24:10 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOsTP-000000092gw-1t5v
	for linux-nvme@lists.infradead.org;
	Wed, 03 Jul 2024 05:24:08 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1B5E6227A87; Wed,  3 Jul 2024 07:24:03 +0200 (CEST)
Date: Wed, 3 Jul 2024 07:24:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>,
	"Lawrence Troup (ltroup)" <ltroup@cisco.com>,
	Keith Busch <kbusch@kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Franck Baudin <fbaudin@redhat.com>
Subject: Re: [PATCH V3] nvme-pci: allow unmanaged interrupts
Message-ID: <20240703052403.GA25182@lst.de>
References: <20240702104112.4123810-1-ming.lei@redhat.com> <20240702115002.GA16219@lst.de> <ZoPum7MPTuA6/t7O@fedora> <MN0PR11MB6280284585EC79A329095CC6C0DC2@MN0PR11MB6280.namprd11.prod.outlook.com> <20240702152809.GA32373@lst.de> <ZoSwCeZZIiQqisYG@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoSwCeZZIiQqisYG@fedora>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240702_222407_654546_8476FC1D 
X-CRM114-Status: GOOD (  12.27  )
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

On Wed, Jul 03, 2024 at 09:57:29AM +0800, Ming Lei wrote:
> So far, most popular SCSI hosts support the option via module parameter, and
> the only remainder could be nvme-pci.

Until something new comes along and then we need to play this game again.

I might sound like a broken record but we need to fix this for real.


