Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D1EC35274
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Dec 2023 05:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UUXH1B0SukaVB7Ivk+IiTZ/ygtclQ3AjgdZg3muhjaQ=; b=gXM8zOPuP/NllnhdtYJBP9fQkA
	d7oMaYguGcqx5GBPHAZpJGu8GSnos7jJVJmj8lJUOd7nZudOm0uAxv3Wo60c2tIsSrrI1hLpiUlyA
	vIgwEr+7xvpEDW+r5yh2/KcxDI6Ek3MCokkkWXaUxfiUpDbpawkUxANoENn5QR14YUHnhzDCzsfXf
	zE1uTAOgkq86J1Owc2vwu/UjIUWZpf4qbGUe4BDZadfMT51EJLDJ6gMH2tg5qETL4aTnSEzAzaQOy
	Q+pfBKYWFFxw8d3XWRfKtvI1EJYMLqgOj5VuEp1r9o2Z3bf4d20m7GrW7rCv5VOkoAZrPTmYfXxj0
	DE6hn+JA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rF6cL-009ALB-02;
	Mon, 18 Dec 2023 05:56:41 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rF6cF-009AKo-37
	for linux-nvme@lists.infradead.org;
	Mon, 18 Dec 2023 05:56:37 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1890F68BFE; Mon, 18 Dec 2023 06:56:29 +0100 (CET)
Date: Mon, 18 Dec 2023 06:56:28 +0100
From: Christoph Hellwig <hch@lst.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: james.smart@broadcom.com, kbusch@kernel.org, axboe@kernel.dk,
	hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: validate maxcmd before use it
Message-ID: <20231218055628.GA16928@lst.de>
References: <1702629808-96718-1-git-send-email-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1702629808-96718-1-git-send-email-kanie@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231217_215636_151452_CDF4D3F0 
X-CRM114-Status: GOOD (  13.61  )
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

On Fri, Dec 15, 2023 at 04:43:28PM +0800, Guixin Liu wrote:
> According to the NVMe specification, if the 'maximum outstanding
> commands' (maxcmd) field is not utilized, it must be set to 0h.
> When a host connects to a target that does not employ the maxcmd
> field, the queue size (sqsize) gets set to an excessively large
> value due to the calculation (u16)(0 - 1) = 65535.
> As a result, such a misconfiguration leads to the failure of the
> connection establishment.

MAXCMD is mandatory for Fabrics.


