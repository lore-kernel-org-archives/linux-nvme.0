Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64CEEC433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Jan 2022 18:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=06V/h9PJwzzwxXhvqrqBEo8y7fctvgVpt81Y243zyNs=; b=3oMh7ZAs6PQr6nhMVDzzG6ITy2
	KFCl19f6JWtJPFQNzYyQzzVsxKbbTuIEtlMUq/PYU/wZVHwvqmDP+eER/7hCEnZRl9zyl30I+3meW
	3OARGeWB3S8lZDVEy06CR6IifNPzeTm0vorPka4vET1p2YnA8gGJCO+cQQHfP0IB1e5aUoUjWRK1V
	Z3wAftps6wyRyidHRPTwrRUELcDBKp2X0uS4p/2vu1RfVPvZCtuQV+JG+shTKae28atMikTodl4n7
	195EWsHTwVUx7IKfclTIr+b3aJfpWE+nTAWN8txTMyNRhh1jE2hO88nc40mJabZyYc5ZAOfaTuoDm
	vbXQickw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1n5As2-00Fa8g-6L; Wed, 05 Jan 2022 18:18:46 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n5Arz-00Fa8E-RV
 for linux-nvme@lists.infradead.org; Wed, 05 Jan 2022 18:18:45 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 2B56268AFE; Wed,  5 Jan 2022 19:18:41 +0100 (CET)
Date: Wed, 5 Jan 2022 19:18:40 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, mgurtovoy@nvidia.com
Subject: Re: [PATCHv3 3/4] block: introduce rq_list_move
Message-ID: <20220105181840.GB12168@lst.de>
References: <20220105170518.3181469-1-kbusch@kernel.org>
 <20220105170518.3181469-4-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105170518.3181469-4-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220105_101844_062485_6B73D0FB 
X-CRM114-Status: GOOD (  11.97  )
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

On Wed, Jan 05, 2022 at 09:05:17AM -0800, Keith Busch wrote:
> When iterating a list, a particular request may need to be moved for
> special handling. Provide a helper function to achieve that so drivers
> don't need to reimplement rqlist manipulation.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

