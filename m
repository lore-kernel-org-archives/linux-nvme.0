Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4E45C3DA6E
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Dec 2023 06:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lT3zFbA+WicBMLWM2xeg+6NW2FW8YivWfWmcQK5Nw04=; b=Y/s0Tk5sTlWCWZ0e50Jgo/OMG0
	IdgdXOZyrnMmLG91OUCt6pD7ZgdS4jE+AS3CfDYv67oq/trd6Vw9xoRWS0IgpuuKR6Iy2jPMk7Qf/
	xi8CwcHYQh/JvH+H+udcukA/6bDsSN/j31EGWsJu7bdy7fpIOSEBvCCw/sWkAhGvskIK53WqjFHYh
	yqlhZO3wq8X2wunBPrRNN5foKPcc4m2f8XTT1R9Jw1i9B7w27qcDdkotTYlcbIa57hxE5RHQUTfcW
	pcArqWtQyd9NPnCW4IymEwmxqoTJleSeegIFyOe7qJYV6+EvpN5wPeN4yXhI4zjhMTHAxngjR0N9S
	w3dCr1lg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rIjhy-00GDZv-1U;
	Thu, 28 Dec 2023 06:17:30 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rIjhu-00GDYp-1Z
	for linux-nvme@lists.infradead.org;
	Thu, 28 Dec 2023 06:17:28 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E4E5D68C4E; Thu, 28 Dec 2023 07:17:16 +0100 (CET)
Date: Thu, 28 Dec 2023 07:17:16 +0100
From: Christoph Hellwig <hch@lst.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH V3] nvme: introduce nvme_disk_is_ns_head helper
Message-ID: <20231228061716.GA12379@lst.de>
References: <20231227093106.78551-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231227093106.78551-1-kanie@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231227_221726_668476_BF31C83A 
X-CRM114-Status: GOOD (  10.38  )
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

> +	if (nvme_disk_is_ns_head(disk))
>  		return disk->private_data;
> +	else
> +		return nvme_get_ns_from_dev(dev)->head;
>  }

Keith, maybe you can drop the superflous (pre-existing) else here when
applying.


