Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D61FC25B75
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Jun 2024 04:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uiJWfplOdW2QkaFLJ/ElQE8xFZx4JOfi2z88RjvdErQ=; b=1WYqfoIZVAxz7JQW36jFY5vqZe
	SSxEMNNvXXtT9iOa5/ayFLhboNvpSWF13Sdpyl6QFJGEwK4QJ1LAYBeJB5PWVYxFHg4C4+vLOi8Zp
	hZ5rQ4Ukpj0Ne7xjvaXxll3Q2r+RAZIqXiglyPGdfcaMCey1tbvKIre275NdE3c+km6xz1Iz+eQhl
	IiuxyljJcwXPwArklRpJdEra3+bBojaxFmhIPKOke+NACThCbt37Vbu9Ua0QUuElljE5CbXBBbXUg
	GgVHIoVk5WSHfF+HQQFxkd1K0enzWZsU6N3XRQoSRh6k2WcuJhvqEUohhKMXPcq/zVBG5gKGGDUKY
	Rs+kSGCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sF50L-00000008LIQ-2oPC;
	Thu, 06 Jun 2024 04:45:37 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sF50I-00000008LH0-2tBI
	for linux-nvme@lists.infradead.org;
	Thu, 06 Jun 2024 04:45:36 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6CF6268CFE; Thu,  6 Jun 2024 06:45:26 +0200 (CEST)
Date: Thu, 6 Jun 2024 06:45:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: Milan Broz <gmazyland@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>, Song Liu <song@kernel.org>,
	Yu Kuai <yukuai3@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-raid@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org
Subject: Re: [PATCH 01/12] dm-integrity: use the nop integrity profile
Message-ID: <20240606044525.GA8395@lst.de>
References: <20240605063031.3286655-1-hch@lst.de> <20240605063031.3286655-2-hch@lst.de> <a5570194-920c-45d8-98d5-da99db0d2f8d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5570194-920c-45d8-98d5-da99db0d2f8d@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240605_214534_889229_2624DE77 
X-CRM114-Status: GOOD (  15.61  )
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

On Wed, Jun 05, 2024 at 04:52:27PM +0200, Milan Broz wrote:
> On 6/5/24 8:28 AM, Christoph Hellwig wrote:
>> Use the block layer built-in nop profile instead of reinventing it.
>
> As this is my "invention", I am pretty sure that "nop" profile was
> not available at the time I was prototyping AEAD dmcrypt extension.
> (It was months before we submitted it upstream - and then nobody
> apparently fixed it.)

Looking at the history the nop profile was moved from nvme to common
code to also support btt in 2015, dm-integrity was added in 2017.
So maybe you just missed it.  Anyway, I'm also happy to tone this
down a bit, it sounds a bit too aggressive..


