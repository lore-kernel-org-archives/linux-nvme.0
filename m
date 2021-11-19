Return-Path: <SRS0=7/ZJ=QG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94EF6C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Nov 2021 17:02:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CC0A61A3A
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Nov 2021 17:02:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0CC0A61A3A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=smBfvudkzuHXKhc2e8b26eGJ1k1BzoyU3GOz/4bE0Cc=; b=NoXK1o1bKWXa4/2ZpPY3JFqfcb
	8EInM8A4U6McCIVIjYewq0fcG69H46Bal8laxJ4FDHG2e1om37CvgZZcV5xOjWX1b/xOhb+Ks2gG5
	e5EIqzR+Mbc73UNhrSjKe6TJDryKNCuB6FhFanA/7nGXBhjRJ2NfHJOzlcuuWKeajEPI3J1uHBIx1
	JG/Rnz6/3EBWmKAgU156aBKP1ITWQkPMzSJgfR7x6RkYe2mBmUPAmOVt5CihCKL4jUJBOD3QAcr2E
	OJFMqH4As0S6nIv7tJM/n/ewjdU4TOFNiEBUi1gsfO2+cVscX6yHng+y7554TZbLsjo/2M0xzUa85
	/F67VSZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mo7Hg-00B93m-TX; Fri, 19 Nov 2021 17:02:44 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mo7Hd-00B92p-C1
 for linux-nvme@lists.infradead.org; Fri, 19 Nov 2021 17:02:43 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id D038568AFE; Fri, 19 Nov 2021 18:02:33 +0100 (CET)
Date: Fri, 19 Nov 2021 18:02:33 +0100
From: Christoph Hellwig <hch@lst.de>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: kch@nvidia.com, linux-nvme@lists.infradead.org, sagi@grimberg.me,
 hch@lst.de
Subject: Re: [PATCH RFC] nvmet: fix tmpfs-based backstores support
Message-ID: <20211119170233.GB15360@lst.de>
References: <20211117152454.122014-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211117152454.122014-1-mlombard@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211119_090241_579989_EA067E13 
X-CRM114-Status: UNSURE (   9.01  )
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

The proper fix is to check if the file has FMODE_NOWAIT is set before
using FMODE_NOWAIT for reads or writes, not to blindly disable it for
reads.

