Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24CD2C433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Mar 2022 11:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GUZHD55ormpmSzwUuEoo6eqzLyeLZWYhvmkFhDN4P3o=; b=lca6pcmgZkwYuOrGx0TXEVALup
	GkMyXSRDu31d/xzPkI38GAn6IASW1uavHN5fhTLPTuc2hvdkSvv0MykbLELmf8I/rLsmAy+14wlN1
	APX1dAcJE2BArk2x3ox7pHHrXb9O5XQuhRSnGHmQ7TzXvQAPkwcGCRNf/9+zB5IjtTMqDrCJWfTgY
	JCNiIFKv9kvgVRWr1DZX8NOngfEsxv9ArEnTFqwKWeU+Q7LMhVY2WwlGEvBrOzrLSd4Ivl/5PIrU0
	RUatJqggH2xQDV/W/Jn4ERJ4ErHvoYQ13g+kX837OPK8oobJp06zyJ/mZUIPsTtAbK/0VjC2/kvD4
	x/g9NUVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nP0dN-00GQ55-NA; Tue, 01 Mar 2022 11:25:37 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nP0dI-00GQ2I-SG
 for linux-nvme@lists.infradead.org; Tue, 01 Mar 2022 11:25:34 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 652BA68AFE; Tue,  1 Mar 2022 12:25:27 +0100 (CET)
Date: Tue, 1 Mar 2022 12:25:27 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 damien.lemoal@wdc.com, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCH 1/1] block: move sector bio member into blk_next_bio()
Message-ID: <20220301112527.GA2567@lst.de>
References: <20220301022310.8579-1-kch@nvidia.com>
 <20220301022310.8579-2-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220301022310.8579-2-kch@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220301_032533_099145_D9C064A3 
X-CRM114-Status: GOOD (  11.12  )
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

It would be nice to just calculate the sector from the previous
bio using bio_end_sector, but that doesn't really work with the
current blk_next_bio pattern.  It might make sense to just take the
initial allocation case out of blk_next_bio and do that manually now
that the bio_alloc interface makes a lot more sense.

