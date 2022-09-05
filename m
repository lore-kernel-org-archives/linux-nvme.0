Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B85A1ECAAD5
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Sep 2022 19:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=Pvhgs1h+PvMJveeDLssxFeE0Rw
	dB6Pb2zdOGF8buJP0xHHIHbEU9BCOV5+67aVwfQn3/2q20fMgpNOfMsC9ISO3mHOvugjuZA7Vfgwp
	ycPQ99uKIUC+6ExnXtJ6JpAb3PuLxEDqhjAii17WCpV+13PLQFo1UCxgAiATjNSIUBqPMXUH6PpnI
	Q6+2AAH7v+6k3FillMQpJdrDiLjuu18u8o0PjAsAd/WApPGldSQAgbN43VPMHV20NnU/5ltDdGcRA
	dWjLfL/NLQJOSKGlZg6ZI4sKnOiujI24n07ImnIt75f75mYmLA4K5occpuupwqZH1wtj55SijVyf9
	tlWoPCTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVHMk-008uCb-1D; Mon, 05 Sep 2022 19:02:38 +0000
Received: from desiato.infradead.org ([90.155.92.199])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVDIF-004dTn-VF
	for linux-nvme@bombadil.infradead.org; Mon, 05 Sep 2022 14:41:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=Y5M4IwhE9YSpo0ABPHKRss4JUo
	HBUs7qMqssf7U8HOf7Xu7bY36+JlKB6VWomewOaQu1gTZDKZtXgrlzZf69Qq/hfM+4pW+c7wa+ODr
	En8DSE3n3PxX+Ea0A2z7VJv9zIh6TB+do/D0lTV71yJ9vGxY+AX58rsVQwbIGjJmxnNDj3yzAP5Jf
	qX3M+ZNY5uDXnhy112R8tdjY46ipHqifM2Zqh3V0AuV3+2jIRIo9qEh7k0OzuLRBvH3GAg0xJ94mv
	CRqQp5fgxTvDRC632IYJXeioEAC4gJ5Xm4aZT7O7SQqArXPwpZwAYCA2MGoA1PWyc/N/l0XrS8VVe
	21VvRJuQ==;
Received: from verein.lst.de ([213.95.11.211])
	by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVDBA-009iIG-IL
	for linux-nvme@lists.infradead.org; Mon, 05 Sep 2022 14:34:26 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1AF9D68BEB; Mon,  5 Sep 2022 16:34:20 +0200 (CEST)
Date: Mon, 5 Sep 2022 16:34:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	John Hubbard <jhubbard@nvidia.com>, Don Dutile <ddutile@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Minturn Dave B <dave.b.minturn@intel.com>,
	Jason Ekstrand <jason@jlekstrand.net>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Xiong Jianxin <jianxin.xiong@intel.com>,
	Bjorn Helgaas <helgaas@kernel.org>, Ira Weiny <ira.weiny@intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Martin Oliveira <martin.oliveira@eideticom.com>,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
	Ralph Campbell <rcampbell@nvidia.com>,
	Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH v9 4/8] lib/scatterlist: add check when merging zone
 device pages
Message-ID: <20220905143419.GC5813@lst.de>
References: <20220825152425.6296-1-logang@deltatee.com> <20220825152425.6296-5-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825152425.6296-5-logang@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220905_153424_785605_DB26E090 
X-CRM114-Status: UNSURE (   9.62  )
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

