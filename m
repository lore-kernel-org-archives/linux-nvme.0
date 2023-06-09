Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E21CC7EE29
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Jun 2023 15:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WX6Q3krLeXnyU1ErGKnaGEj0J5rvRDqnfROl5WFYUIc=; b=Pot/AUy0xAS4qi9337Ap849lwT
	uRUJYUpzPHiHmIzrzPICRSesFaccUOrBp3XaV/SXYh9vyIIrs8yScqAH0deIqgUkjmGnoeDwI2u6L
	Uvm2jysBrNMrx+VwJBat6HtKnAOWap6mWoLioFOzO/f7K98PMsAo8eKiyws5RzqyFTh3TU9B4xZGO
	2qjF9SuwykvlBsiTpgNh9kfxwsVMWdCmRlohCZeW0M97scSbf6nrGX+mm4hRhEIPfViiVvDtKLVE8
	XCzKuvAwiigtyguV9fzRVYKTblSBgHFEf8lLzBZpoEWEgvPV60oBha5gEuFYLkpgIyLrDyMKhsUry
	6hFRFN1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q7eCe-00DTl6-2l;
	Fri, 09 Jun 2023 15:39:04 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q7eCc-00DTjt-1T
	for linux-nvme@lists.infradead.org;
	Fri, 09 Jun 2023 15:39:03 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 72D42612ED;
	Fri,  9 Jun 2023 15:39:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5529CC433D2;
	Fri,  9 Jun 2023 15:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686325140;
	bh=WX6Q3krLeXnyU1ErGKnaGEj0J5rvRDqnfROl5WFYUIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=flADZZodBu9NjHeLs2ouwlix5tMqKkUsg7DiJrTJrOJIja4u5mhf5vV6yiagrWgC0
	 mYSBS6MvZ8mUOIq9c6qh52nIAUqBhJM7ZkkEshdNh5emH9rabLMduUCAXJ3pQ8FmJ8
	 MwLN1o/FwyRerPixF6VkEVz1mCZpT5VJYKrPtoF0F9ULICVlAA7FABBov2ZzM2SOxa
	 m2Rbto7MlMwGPYvbGgaA4ZTmZHG739PCH+DrJE7vttQMfMfZWyjNBs7PQIpEovkLig
	 wJQ9SI5ceS0CXB4KxU3qBu89r+wJHNQGphO1TDDto/KGYsGzvNxBJj7D8Zv7Zj2y92
	 JSlj8hzdrcc/A==
Date: Fri, 9 Jun 2023 09:38:58 -0600
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, kernel test robot <lkp@intel.com>,
	Julia Lawall <julia.lawall@inria.fr>
Subject: Re: [PATCH] nvme-fabrics: error out to unlock the mutex
Message-ID: <ZINHkqfJoKBMJ4+6@kbusch-mbp>
References: <20230602053713.43006-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602053713.43006-1-kch@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230609_083902_555696_D054626F 
X-CRM114-Status: UNSURE (   7.35  )
X-CRM114-Notice: Please train this message.
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

Thanks, applied for nvme-6.5.

