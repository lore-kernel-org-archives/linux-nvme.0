Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08260C433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Feb 2022 08:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YktEoXRWuIqYOT0u99Sm2W1xzFHT6cN9Sf38k0K5wLI=; b=0ty577aZIriKSZzni302fC1usF
	3X7SBKbfeFMxA9SNweO4yNMUBZaQ4ABg8veepSGSFrJfTkvf/4vosU5tZuB/24hmEN8Kn+StTTfw2
	ZzffAoxgN7TgrnavsQM7sMLiqXnuUeT9COeen/5b11AcaepUil8lVn3kycjW4LHBitWT9a+kIRFki
	teFEPD8dsCbpEtNM6nLBLWJvXgUnW6JOb+ok5jisw5cKXn/0eQxcLwfSD+7DtHd0Ye5UTWnH7zTQh
	cJNY2+g22Tu/6LMYh5AMIJHCU6877TAgdiW+LPP36iVArnuSPS79Gtb7OKSc2zwQyNWJQQ1yRgFiN
	GpPIEyPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nEoFs-00BTUe-F7; Tue, 01 Feb 2022 08:11:12 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nEoFn-00BTSy-2n
 for linux-nvme@lists.infradead.org; Tue, 01 Feb 2022 08:11:11 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 5C0C568BEB; Tue,  1 Feb 2022 09:11:04 +0100 (CET)
Date: Tue, 1 Feb 2022 09:11:03 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org,
 sagi@grimberg.me, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH 5/9] nvme-fc: centralize admin tagset initialization
Message-ID: <20220201081103.GB29769@lst.de>
References: <20220128092015.19289-1-chaitanyak@nvidia.com>
 <20220128092015.19289-6-chaitanyak@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128092015.19289-6-chaitanyak@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220201_001107_293912_0E080B5D 
X-CRM114-Status: GOOD (  11.73  )
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

On Fri, Jan 28, 2022 at 01:20:11AM -0800, Chaitanya Kulkarni wrote:
> +	nvme_init_admin_tagset(&(ctrl->admin_tag_set), ctrl,

No need for the braceses.

> +			       ctrl->ctrl.numa_node, &nvme_fc_admin_mq_ops,
> +			       BLK_MQ_F_NO_SCHED, NVMF_RESERVED_TAGS);

But do we need all these args?  We should move the admin_tag_sert to the
generic nvme_ctrl and just pass that and the ops.  Everything else
should be same (I hope it currently is, otherwise we need to fix) or
easily derivable (e.g. the check if it is fabrics).

Then mve the helper out of line please and convert all callers in one
patch.


