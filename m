Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA9ADC3DA70
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jul 2024 15:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kwRvQ6bNqy0ZhZnkxm5h8gWEVoNE63XpJpahPfs8m70=; b=yz6IwIhG1ZAXTkUvHDRVzQksxX
	lZ50IgQgTRrWg/coOAFLnXKj7XoJ2K2IPIav17cmLAwID0IFFogGWeUqEYtPrNvXl83qNCIByTb7o
	rcglQjGPCWuDjyKDzFkR58asz3zevdiWXEIOVkL/W7s/S6gci0wKDYyd9uejRAtGQWRLNcw2RNpUA
	lL3ux/ZohYKY+j/PxUz09SVycLwFj9O+ycVsJTcd387WQs57aF+mz9fECUAfHsYDcQYy/zUTP4c8y
	iFUL2yBFxMvd69WolIvlWFCuCS+c3vbZK4vo+fNagoPu5ksegyZyEKY0mWWXJEP/isb9hYMeu7dZL
	qe/BhTyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYoNW-0000000FZcq-2a1o;
	Tue, 30 Jul 2024 15:03:06 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYoNV-0000000FZcQ-05g4
	for linux-nvme@bombadil.infradead.org;
	Tue, 30 Jul 2024 15:03:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kwRvQ6bNqy0ZhZnkxm5h8gWEVoNE63XpJpahPfs8m70=; b=bJnRK1xnomNhvnws43NenLE84E
	pSDxGojIQ2n8dmBypywTUEh9+F4pvNO6q72HueNhXa4e2UChc9T9W9CgUKmRCFxnyYkBiZtKaSARa
	ccHHFICMIUtHfpHJOVIIJicxmI+CNYDQ/FyE7O+TXG5gY/P+eGdaQzhT2O1e9MwtB1NhsHZzRMSQe
	x+xHQxByp34qHtgCuWBq5TutFvNaLekxHkSt2CAoXu27fdZ/kLG4f0r14o2CKbxdHxqsfv2Q8maQZ
	ingR+/6uowmH9PG4xgPlKeUJ30guh6z1hRqAl09TzxDmsBLv4Awfswoh4hskmVDcmwjt54deBLUHM
	02j5JE8g==;
Received: from verein.lst.de ([213.95.11.211])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYoNR-000000051cs-3nGP
	for linux-nvme@lists.infradead.org;
	Tue, 30 Jul 2024 15:03:03 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id EB74D68AFE; Tue, 30 Jul 2024 17:02:51 +0200 (CEST)
Date: Tue, 30 Jul 2024 17:02:51 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/3] nvme: remove a field from nvme_ns_head
Message-ID: <20240730150251.GA29099@lst.de>
References: <20240730103138.66714-1-joshi.k@samsung.com> <CGME20240730103942epcas5p3aecd4ed3b49c99fa3e14b7b7e2d93ba5@epcas5p3.samsung.com> <20240730103138.66714-2-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730103138.66714-2-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240730_160302_017351_2AEDED12 
X-CRM114-Status: GOOD (  10.40  )
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

On Tue, Jul 30, 2024 at 04:01:36PM +0530, Kanchan Joshi wrote:
> pi_offset field is not required to be present in nvme_ns_head.

Maybe spell the field name out in the subject?  Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


