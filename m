Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 268D6C44515
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jul 2026 14:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v1MLDJeyF/0CNDGrObVhLpgbboRpKunaOX6Afu/b0BQ=; b=ZTOn487h6DI2bFt1TdDx1vlEqQ
	J2BrltAer0E8uJW5E0ZgCPMfTgcNx5kHqYEfal5pTwsief/V8+lJ9eOt1aUSybBf9YPTcMWZTZwy3
	DDtioFpgJzH6ZmWC/kB0IVj5TRfoHvTMlrimqLq7lUBxBOeUqORgSkoIsvcERgdDA4NIuoG+O+6wj
	wG9a7ioIsGzMRfscdaEljFRT8vFZgKXiRFUmA/5JQZqISBNnX78oZOHgSfLVI76aGotkpLhz2iDm0
	IqlhZVtKilcts1nOg1cgZPdW5b13fpCPf3zRjm0z4gOJnZjChf0ubIs+sI+owMZSFJu881JgUyfRu
	LF4G1Zjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlpSx-000000073gP-2HLB;
	Mon, 20 Jul 2026 14:59:35 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlpSv-000000073fk-0f10
	for linux-nvme@lists.infradead.org;
	Mon, 20 Jul 2026 14:59:34 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4449468C7B; Mon, 20 Jul 2026 16:59:28 +0200 (CEST)
Date: Mon, 20 Jul 2026 16:59:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jun Zeng <jun1.zeng@intel.com>, kbusch@kernel.org, axboe@kernel.dk,
	hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
	gang.cao@intel.com, jun.i.jin@intel.com, yong.hu@intel.com
Subject: Re: [PATCH v1 0/1] nvme-pci: adaptive interrupt coalescing
Message-ID: <20260720145927.GA17986@lst.de>
References: <20260715075703.15578-1-jun1.zeng@intel.com> <3c29b8cb-906c-4c48-89cf-59c676900616@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c29b8cb-906c-4c48-89cf-59c676900616@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260720_075933_350500_083096DB 
X-CRM114-Status: GOOD (  11.54  )
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

On Fri, Jul 17, 2026 at 10:06:24AM -0700, Bart Van Assche wrote:
>> Monitor the IOPS and average queue depth of inflight IO periodically
>> on each NVMe drive and enable/disable interrupt coalescing
>> automatically without user intervention. This feature is enabled by
>> default and can be disabled/enabled through debugfs during runtime.
>
> An algorithm like the above can be implemented more efficiently in NVMe
> controller hardware than in software, isn't it?

There is a lot of discussion on interrupt coalescing in the NVMe
technical working group right now.  I would suggest everyone working
for a member company (and that should be everyone one the cc list
here) to check that out before rushing anything.


