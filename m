Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00FD2C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Apr 2022 04:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e/0TrA6Xb2T/hiRqFbr3DIsyyeb8eW4T7g7FyK0xLMc=; b=etGjNpO57hwhXhWnLlZhZ4zBJr
	q2rzoepb5bdBmk41CsyCkQQFfcGSFOnxMTpYdEqZHWkqNlpZpRavLr8w5ft6MrYbZpA23PGRRjTxM
	bzfS7eEsv6pOaNIAOgcdmY2vJimxccHK0v+GDtRHv69STdFkSdN9Jj3SsJMJCFPneSbspAiDwfK+A
	W9ATmKgkIF8qRAPKv2sFbAz2RHQAcUGT7p+sPyrLZJnT6Z6C28i8kx5EWGfjq1wLcBls2XtNgROH/
	CM1TVX9LfGi5GLvOlHcKcNA43Ap6tEhbRF0Bqj6+jBLffdJ6dIAv1z0OESDSQNKJ8b/ca6e2/B/YY
	jPa76wqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1neV0D-00GmM3-8d; Wed, 13 Apr 2022 04:53:13 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1neV0C-00GmLq-NL; Wed, 13 Apr 2022 04:53:12 +0000
Date: Tue, 12 Apr 2022 21:53:12 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: bvanassche@acm.org, yi.zhang@redhat.com, sagi@grimberg.me,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: can't run nvme-mp blktests
Message-ID: <YlZXOC4VgmDrUGIP@infradead.org>
References: <YlYYJC/WUEsnI9Im@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlYYJC/WUEsnI9Im@bombadil.infradead.org>
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

On Tue, Apr 12, 2022 at 05:24:04PM -0700, Luis Chamberlain wrote:
> I do have CONFIG_NVME_MULTIPATH=y but I also have:

I'd suggest to ignore broken tests that require a deprecated option
that will eventually be removed.

