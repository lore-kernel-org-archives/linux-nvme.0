Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F207C25B75
	for <linux-nvme@archiver.kernel.org>; Fri, 31 May 2024 08:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OyLSK9YooqjNz5BN1EKMEmfBoz7Oae7ND9udwuZITag=; b=BwKGJiJ0WE4xHCYgXQyYm9x4pa
	SKUFmoxyzBvY3TQHiAFwtydnrrucve+9j3X7bcDJ9rv0JHK9SQd45KxSyU2X5i4wrSMlqmKIXb93z
	G6uSIQH9Kz7jTw4808dI65nwuAFLfIAaCJquE8JAkZJhS9ay/PXsoJM9OetidGCUhob9axMQU7nLk
	jZz8DuNTBiiPvfnlpDIgBolilOAWNrypOn6senH7+zDHrKVe0vf6s/bfiUY/2NN2ZzsikK1T9Pg/l
	d0coVKRfaGAL8H3Lteap00tKLtw2r5JSrAiYhVKQQzAJ/LnNqujZ9BnllYA+gzodotwvUwygeJ1Or
	0xq0nGCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCxRd-00000009aq2-2Idg;
	Fri, 31 May 2024 08:17:01 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCxRa-00000009ams-23ME
	for linux-nvme@lists.infradead.org;
	Fri, 31 May 2024 08:16:59 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 634E668BEB; Fri, 31 May 2024 10:16:50 +0200 (CEST)
Date: Fri, 31 May 2024 10:16:50 +0200
From: Christoph Hellwig <hch@lst.de>
To: Weiwen Hu <huweiwen@linux.alibaba.com>
Cc: linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Mike Christie <michael.christie@oracle.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] nvme: fix nvme_pr_* status code parsing
Message-ID: <20240531081650.GA19765@lst.de>
References: <20240530061646.52167-1-huweiwen@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530061646.52167-1-huweiwen@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240531_011658_694627_8AC286FD 
X-CRM114-Status: GOOD (  11.23  )
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

On Thu, May 30, 2024 at 02:16:46PM +0800, Weiwen Hu wrote:
> +	switch (nvme_sc & 0x7ff) {

Can you use the opportunity to add a NVME_SC_MASK symbolic
name for the magic 0x7ff?  We should have done this earlier
with already 5 occurrences, but better now than never.

Otherwise this looks good to me.


