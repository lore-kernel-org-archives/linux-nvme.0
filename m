Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F21DC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Feb 2022 08:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y2vuLlJ0u9XqFSl5JjNdVQZxDavffKkRmWlyJtWWjwQ=; b=qURkEh0MIvEPEMlOH7nqKSuHpc
	4xMn2hJcQrFEKuvX8vC6Inf8GPDUpRNZZNSnPYeRAEFLN1yb7nSsxQqiHsuphJPA4tpYTxZz5VCQY
	IP6SYskqz5p29ugsGEADyM7+NlDH+nxNDALkT5PkBSCH4PMzlmC64ugcYmpRw0bABVWsjwshsMHbv
	mqFw+NlXazi1w+IAwVMyAHbTOOmGAAj1Hi7h50vwxEHcn2HyiFh/nbmx2q/HZTYiTmS57YpiPBhoK
	JIr1q/aBobfV5XJj61EhyO5E9ZsTIHAAyhyQdBovNxYbOcz8HpSziyam0AfCdHPFBLo3Dt1f5+TrA
	DKTMH1Zw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nKFFs-005yn6-Rt; Wed, 16 Feb 2022 08:01:40 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nKFFq-005ylF-AB
 for linux-nvme@lists.infradead.org; Wed, 16 Feb 2022 08:01:39 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 054F468B05; Wed, 16 Feb 2022 09:01:34 +0100 (CET)
Date: Wed, 16 Feb 2022 09:01:33 +0100
From: Christoph Hellwig <hch@lst.de>
To: Martin Belanger <nitram_67@hotmail.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, hare@suse.de,
 axboe@fb.com, hch@lst.de, sagi@grimberg.me, stuart_hayes@dell.com,
 charles_rose@dell.com, Martin Belanger <martin.belanger@dell.com>,
 Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCHv3 1/2] nvme: send uevent on connection up
Message-ID: <20220216080133.GB10554@lst.de>
References: <20220208193346.22580-1-nitram_67@hotmail.com>
 <BL0PR13MB4291421C8BC621EEA559A88D9C2D9@BL0PR13MB4291.namprd13.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL0PR13MB4291421C8BC621EEA559A88D9C2D9@BL0PR13MB4291.namprd13.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220216_000138_532059_875B71D5 
X-CRM114-Status: UNSURE (   8.47  )
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

Thanks,

applied patches 1 and 2 to nvme-5.18.

