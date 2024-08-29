Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE9D4C7115D
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Aug 2024 04:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hzXRcdixpfEBeemDdct8VL2mz5xhJjAGL0eNMi1XrIw=; b=brZjCZLhM8/enQoDbNeN4x3nm3
	6oK/hKklAa5Mm+JURxVdM3tbSKD8wRGVP8Jdbdoi1nt2m0QkXxsdCw6rrjDrsh7Ou7MSXXbasi1OE
	5eqSgUKBGqs1PHMNNxh/IwkDahCyvu9ek+oMQQyU4ffunaMUqrO7vBRvdTSOf5fDq7Ai+9Ew4B5EC
	pDbiBTGq6azZBUBhG4IZPpdC3XmDYIfaGnbPqXPBaq68/KkeBnXvWVa4S9x0T3FyRxWPmzhRfz2Ko
	bhuiuaeM5FC0wxHVFyvDbV4TQd+MzO9gRccP9hO6Bl44FfG3J8LloOsmj7njlw+j9/HiHKrAzNQt2
	3Y3wdHsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjWQL-00000000RZO-1Ea6;
	Thu, 29 Aug 2024 04:06:17 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjWQI-00000000RYu-0s9b
	for linux-nvme@lists.infradead.org;
	Thu, 29 Aug 2024 04:06:15 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id CE6B068AA6; Thu, 29 Aug 2024 06:06:09 +0200 (CEST)
Date: Thu, 29 Aug 2024 06:06:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Anuj Gupta <anuj20.g@samsung.com>,
	axboe@kernel.dk, kbusch@kernel.org, martin.petersen@oracle.com,
	asml.silence@gmail.com, krisman@suse.de, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, linux-scsi@vger.kernel.org
Subject: Re: [PATCH v3 07/10] block: introduce
 BIP_CHECK_GUARD/REFTAG/APPTAG bip_flags
Message-ID: <20240829040609.GB4211@lst.de>
References: <20240823103811.2421-1-anuj20.g@samsung.com> <CGME20240823104629epcas5p3fea0cb7e66b0446ddacf7648c08c3ba8@epcas5p3.samsung.com> <20240823103811.2421-8-anuj20.g@samsung.com> <20240824083553.GF8805@lst.de> <fe85a641-c974-3fa7-43f1-eacbb7834210@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe85a641-c974-3fa7-43f1-eacbb7834210@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240828_210614_416296_F360B70F 
X-CRM114-Status: GOOD (  14.67  )
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

On Wed, Aug 28, 2024 at 07:12:22PM +0530, Kanchan Joshi wrote:
> On 8/24/2024 2:05 PM, Christoph Hellwig wrote:
> > How do we communicate what flags can be combined to the upper layer
> > and userspace given the SCSI limitations here?
> 
> Will adding a new read-only sysfs attribute (under the group [*]) that 
> publishes all valid combinations be fine?
> 

That's not a good application interface.  Finding the sysfs file is
already a pain for direct users of the block device, and almost
impossible when going through a file system.


