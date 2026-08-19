Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2518FC5DF6D
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2026 05:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=4iaB3hEi6otXB4ns46Yjrvoi3M
	JmqrAR4KtVas/QCtt5K9Cf3MyZU38/u5uOTtT40D6/AXLIk8ojwfZWwSHkmOarRHeNm6wTJInn8JV
	+eVwqnTpNzHbeEL8FgSaFj4G3uJqWvkBPuQh1RJdUMLA7vcAXpM64ikyUUJFpnJOZX7CiVVDpIwNj
	A6e0UsjkptclZmPrPZSJjJXlrZSWo1p+KDlmmjUxDMXAVn3TEj4XhQSUscQuQF4ke8MAFfkNw1QIx
	YGFhFugpcHrjAAROJmTXZdZv0WuWXQPuoUsqvjCv1KIE4UpGyL6U38KkrCjiDczl6939zZJg7Gq7o
	nxlNOEyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwYyv-0000000926Y-2ZdP;
	Wed, 19 Aug 2026 05:36:57 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwYys-0000000925y-2QUY
	for linux-nvme@lists.infradead.org;
	Wed, 19 Aug 2026 05:36:56 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2D25068C7B; Wed, 19 Aug 2026 07:36:51 +0200 (CEST)
Date: Wed, 19 Aug 2026 07:36:50 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: kbusch@kernel.org, hch@lst.de, harimishal1@gmail.com, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, gregkh@linuxfoundation.org,
	gost.dev@samsung.com
Subject: Re: [PATCH v2 2/2] nvme: fix racy access to FDP placement id array
Message-ID: <20260819053650.GB32567@lst.de>
References: <20260818060253.4104-1-joshi.k@samsung.com> <CGME20260818060333epcas5p348cde01f8ce24cff3dd0de782f0bf48f@epcas5p3.samsung.com> <20260818060253.4104-3-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818060253.4104-3-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260818_223654_773490_B6928339 
X-CRM114-Status: UNSURE (   9.27  )
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


