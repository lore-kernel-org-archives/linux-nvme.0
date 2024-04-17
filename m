Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C081C4345F
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Apr 2024 14:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OetGWae5gheFgj6r97Xe7TfNz9JNxM3V6YMpl/n4JAE=; b=VNht36xSM4drjWcaXIlaSZgfmM
	iPNLQbLLI3Au0TEy0C4WVvcJJg3vk4FOo0JXModfroKRjWHKNDfdDcyYXVrWrw8iQ54wy/InBNu2C
	wIO2jwofgI8ZXZu8OGCnj7BuxqxFhYhUg5ydY8Z7l+OBiz8U+yHqrAVU9bjOLSDrptwRIpooQ/6BM
	mhBe7NyNP8PeyzyMgPDLytwLPKQvXX6xnF4nSLTLTfoGTjvmr1nKvDtCHCf66ryjoTFLURMPThJaf
	waTspCvlC+sjfDT4AxuKOmwMlm6oZBorLtOVy5dGhvX9fsIcKCnLHFpfVYOZCPXiGztHfzMaBxnsH
	97/2ZMnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rx6Ex-0000000GKxP-0QHo;
	Wed, 17 Apr 2024 14:26:23 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rx6Et-0000000GKwF-0f20
	for linux-nvme@lists.infradead.org;
	Wed, 17 Apr 2024 14:26:21 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9B343227A88; Wed, 17 Apr 2024 16:26:10 +0200 (CEST)
Date: Wed, 17 Apr 2024 16:26:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>,
	Sebastian Brzezinka <sebastian.brzezinka@intel.com>,
	Tomasz Zawadzki <tomasz.zawadzki@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: nvme-cli spdk plugin
Message-ID: <20240417142610.GA31809@lst.de>
References: <xulnfwru3jfl2nooq27yym7nx3cdpxqslzqz5nvwnkymncapnt@pzascju2tmvf>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xulnfwru3jfl2nooq27yym7nx3cdpxqslzqz5nvwnkymncapnt@pzascju2tmvf>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240417_072619_441549_9D85B612 
X-CRM114-Status: GOOD (  15.90  )
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

On Wed, Apr 17, 2024 at 10:33:17AM +0200, Daniel Wagner wrote:
> There is a PR [1] pending, adding a spdk plugin for nvme-cli. The
> problem this new plugin tries to solve is, that with the recent change
> to use sysfs only for discovering the nvme subystem, nvme-cli
> lost support for spdk.
> 
> My question is, should we have a special plugin for 'list' and
> 'list-subsystem' or should we try to get this somehow integrated into
> the existing code? So that 'list' just works?

І don't think nvme-cli should deal with anything that is not driven
by the kernel nvme driver.


