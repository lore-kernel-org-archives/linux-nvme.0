Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57BFBC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Apr 2022 16:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bRyETklSw8LVcp2ms89FmJQjX24nufimW7Qt69uRZvM=; b=R6WQPzpDUm+OTd8dNigVNuryof
	fVaEKIq8MXRSuZ0ypUu2M+YDikk4H6XbHhG7m4qCqxRtien6LyTQDjOfyRmxhwlH3HM2SERV8H58/
	fH1qgOHf/00K/DhcFrVcWud83Ti4yxnSqNzoioLPyEAioHNNp1bwCwQp2Ho98YTf+5vzfwp01f0KB
	YfUhP/dP15ZcuTbR4qyigU7ZDPakcdo7C+Cqf9ZTVXmoY8qI//g+E35HyEWBmdpfctP93BecNcYrN
	020mc5ARFSNEM68MARJK+d0n9HKtL3oTtvZK+ZOOSlqP06k30FkaBRgse9KJfYyIPwoERD4HeOLBL
	4UWfNwLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1negEW-001pJw-VD; Wed, 13 Apr 2022 16:52:44 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1negEU-001pJN-88
 for linux-nvme@lists.infradead.org; Wed, 13 Apr 2022 16:52:43 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 5AF2A68AFE; Wed, 13 Apr 2022 18:52:38 +0200 (CEST)
Date: Wed, 13 Apr 2022 18:52:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jonathan Derrick <jonathan.derrick@linux.dev>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
 hch@lst.de, sagi@grimberg.me, kbusch@kernel.org
Subject: Re: [PATCH 3/3] nvme-core: mark internal passthru req REQ_QUIET
Message-ID: <20220413165238.GA31786@lst.de>
References: <20220411031249.5158-1-kch@nvidia.com>
 <20220411031249.5158-4-kch@nvidia.com>
 <cf4534ec-c8d1-c020-2079-5636177ca1b5@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf4534ec-c8d1-c020-2079-5636177ca1b5@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220413_095242_471312_F6806459 
X-CRM114-Status: GOOD (  11.08  )
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

On Wed, Apr 13, 2022 at 10:49:33AM -0600, Jonathan Derrick wrote:
>>   +	req->rq_flags |= RQF_QUIET;
> Any reason to not make it a part of flags in the argument list and let the 
> block layer build the req with it?
>
> eg:
> flags |= REQ_QUIET;

Because there is not REQ_QUIET, just RQF_QUIET and BIO_QUIET, and their
relation isn't quite as straightforward as it seems.

