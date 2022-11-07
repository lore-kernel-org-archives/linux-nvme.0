Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 872E5C433FE
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Nov 2022 09:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gKU4VLSqmIJAsXqFAvSc1gGvagg/uy+enA7QbnUO+aU=; b=Bc1jvWdgJtvt+7O/d08DJHmGvj
	cnI5DW0cswJPw/k9Fzan/k7qWjxrC2wPXaiYqfT1U4ORYCypYD9B8/zYAkQzwixAFNU1l+vJZX/vs
	lXu/Rfm70iUyrKYXd9K2Em5nF96/E7GydLgA4Lofr3WOhHeqAQ9iQFFRxTyLZ5me51It0UquDIA7A
	/2Xl+CzmtfMKxD5bbOpDqmxUrqIi+Wxipu9tUlBvHFgSf1UABWxnv/X92We7WWE7V833qylhHIjIF
	7uEw8gD8zQvexqYn5a+mH4kLM7DkiQqL3AVxl6QD0+AEuW4z814QukvE0Di5YinrKMLeJJuxkpEas
	k1lRLlAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oryHd-00DCAY-Eb; Mon, 07 Nov 2022 09:19:09 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oryFC-00DB5Y-0t
	for linux-nvme@lists.infradead.org; Mon, 07 Nov 2022 09:16:39 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 50E4B67373; Mon,  7 Nov 2022 10:16:31 +0100 (CET)
Date: Mon, 7 Nov 2022 10:16:31 +0100
From: Christoph Hellwig <hch@lst.de>
To: Mike Christie <michael.christie@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, bvanassche@acm.org,
	martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
	james.bottomley@hansenpartnership.com, linux-block@vger.kernel.org,
	dm-devel@redhat.com, snitzer@kernel.org, axboe@kernel.dk,
	linux-nvme@lists.infradead.org, chaitanyak@nvidia.com,
	kbusch@kernel.org, target-devel@vger.kernel.org
Subject: Re: [PATCH v3 12/19] block,nvme,scsi,dm: Add blk_status to pr_ops
 callouts
Message-ID: <20221107091631.GA3663@lst.de>
References: <20221026231945.6609-1-michael.christie@oracle.com> <20221026231945.6609-13-michael.christie@oracle.com> <20221030082020.GC4774@lst.de> <a7e447b5-b26e-7aa0-ab6a-3463b8497d26@oracle.com> <20221101101511.GA13304@lst.de> <7762a877-9a5f-4dee-6dfc-c2e1fcb8a66a@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7762a877-9a5f-4dee-6dfc-c2e1fcb8a66a@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221107_011638_250282_5D553B0C 
X-CRM114-Status: GOOD (  12.58  )
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

On Sat, Nov 05, 2022 at 01:36:18PM -0500, Mike Christie wrote:
> Do you mean just doing this:

That would be the minimal fix.  We'd then still need to enumerate
the allowed positive return values and check noting else is returned.

I don't like the opt in in the other version.  The SCSI return values are
the defactor API, and we need to switch NVMe to align with it ASAP
instead of keeping the broken old version around.

