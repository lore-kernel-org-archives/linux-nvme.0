Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F12FC02183
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Jan 2025 08:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LStVresoQ7JyeQVwixCqq0Bpv9GYtr4TRLfxkC8lyKs=; b=PrQl/+L0ctXDnvKMMMrgRziWk8
	pVTO2Q1lYbSjkUqln3F5KCwuRUsXpBc2yZOtnIY0NZu8AUXibH2o4UQHWgG5INI30pWUcy7XzA1NN
	F3YWetwYZ34E0LiyWNTdOBv0Gmm0kPj65VkQNI1632MA4Db5gOLLB6uPc4ByFyNQqySqu3nWiP6a2
	3w5uInHW6/yfaRnZ87RSkPgUEOLuA7W8oEiWz61/BFBPWvGPogphMuwNp7VRroIteACYaYRMrgl1G
	oQCsPA2K2hCB6kQVk2hjSaFvCwlbCxhjuw/hCRzUyhA8mYR61T9qcrqKj908Yjm9Ok5FlMG7WHSA1
	E1P6wkvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tYhlh-0000000HL7V-22Oz;
	Fri, 17 Jan 2025 08:31:53 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tYhlf-0000000HL78-0Mtp
	for linux-nvme@lists.infradead.org;
	Fri, 17 Jan 2025 08:31:52 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 65B3B68BFE; Fri, 17 Jan 2025 09:31:46 +0100 (CET)
Date: Fri, 17 Jan 2025 09:31:46 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
	sagi@grimberg.me
Subject: Re: [PATCH] nvme-core: decode the error on add disk()
Message-ID: <20250117083146.GA28767@lst.de>
References: <20250116201527.9252-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116201527.9252-1-kch@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250117_003151_279737_131D98E1 
X-CRM114-Status: GOOD (  10.81  )
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

On Thu, Jan 16, 2025 at 12:15:27PM -0800, Chaitanya Kulkarni wrote:
> While debugging the problem, it is important to know that what exact
> error returned by device_add_disk() along side the disk name. Print
> the error along with disk name when device_add_disk() fails when
> allocating the namespace.

Sounds like this would be better places in device_add_disk and not
in the drivers.


