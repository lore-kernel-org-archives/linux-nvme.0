Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88CEFC61DA4
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Mar 2023 13:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x2Jd6zSFIoownQG9D6Qz8nYT8sr84dkOy2Bsh4zyT94=; b=dHL1yocgaPUj4pFSdGeAPOiTph
	S+ACApYH6OpIyQzRyL4z165jR2avHKR4vWMXh9E7CwQlyB4DCWNodBEXu5bZk8RT7VerjDIS+fSmw
	4AvkXej7QBX9JVENcmTnJAdDCjyc9m/4KzQ0/prhQ/DnB9kD3Fdj4XI5cdv0VWOQpUbzoF3AZhQOw
	+W+eAS/YxjierQr6mdN1e4nkpRyOIIwUTxW8P9n0vKvCVaHb2DmNIAyQ7TN9fz4YlbKUAwQ5Wodc+
	bp2vC67jxPUOwKJNI8tRMmDskg512uSRZHL4HgZA05J1QtjzW7hdlt0vR2XzsZWs7vmExnkG/ewD3
	rJ5Z+ATQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pcRLK-00DTLw-1W;
	Wed, 15 Mar 2023 13:39:02 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pcRLI-00DTL3-04
	for linux-nvme@lists.infradead.org;
	Wed, 15 Mar 2023 13:39:01 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5427667373; Wed, 15 Mar 2023 14:38:57 +0100 (CET)
Date: Wed, 15 Mar 2023 14:38:57 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH 5/5] nvmet: Cleanup nvmet_execute_identify()
Message-ID: <20230315133857.GD24915@lst.de>
References: <20230315105939.305825-1-damien.lemoal@opensource.wdc.com> <20230315105939.305825-6-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315105939.305825-6-damien.lemoal@opensource.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230315_063900_198513_FC500048 
X-CRM114-Status: GOOD (  12.67  )
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

On Wed, Mar 15, 2023 at 07:59:39PM +0900, Damien Le Moal wrote:
> Change the order of the cases in nvmet_execute_identify() main
> switch-case to match the NVMe 2.0 specification order as defined in
> table 273. This is also the increasing order of CNS values.
> 
> While at it, for clarity, make it explicit that identify with cns set
> to NVME_ID_CNS_CS_NS does not support NVM command set specific data.

Looks sensible to me, thanks.

