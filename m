Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52C81C982DA
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Sep 2026 12:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JqBuDqShCoY7ZIh67UgJ+xVMnWDakmWbLYGJaohGKTY=; b=BiU+Q+NL5RRFin/HfY15APF9NJ
	SQp1Eei7Z14CLQNd7KWyi+YrcqDzFNAv5On9wPXZ7uyU+e0ANnK3nTCcCdy7V/gYiDTK8nJUTYmM8
	W0tOX5I8OKwv8eci0hsNcaVQU+57wo4aLwUadLxSM8zVPodQa2V1is98pwbAHOXPBrhSbNS2w4gks
	IdzRDhlbVhEhnsZ6BUM//sUPuHsP1p31IEgkiCLHTc9sTpKEXa/h5ThF/f1ylDYdWMzKsj+X3gMan
	Mq5K5+/4jZnlYhv//KF52/JeroMWuxJXzIn8S34RHNDESScJAyU5Yui5GkZkksjONc1S0JURp/oUv
	ve2hjuyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7XLI-0000000EJvS-1B5C;
	Fri, 18 Sep 2026 12:05:24 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7XLF-0000000EJti-19jx
	for linux-nvme@lists.infradead.org;
	Fri, 18 Sep 2026 12:05:23 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5585168BEB; Fri, 18 Sep 2026 14:05:11 +0200 (CEST)
Date: Fri, 18 Sep 2026 14:05:11 +0200
From: Christoph Hellwig <hch@lst.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>, Daniel Wagner <dwagner@suse.de>,
	John Garry <john.g.garry@oracle.com>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/2] nvmet: return Invalid Field for invalid NSIDs in
 Set Features 82h
Message-ID: <20260918120511.GA16425@lst.de>
References: <20260918033932.3864965-1-kanie@linux.alibaba.com> <20260918033932.3864965-2-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918033932.3864965-2-kanie@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260918_050521_469060_49B3462F 
X-CRM114-Status: GOOD (  15.28  )
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

On Fri, Sep 18, 2026 at 11:39:31AM +0800, Guixin Liu wrote:
> -		if (status)
> +		if (status) {
> +			/* 82h is Invalid Field for invalid NSIDs, not Invalid NS */

Overly long line, but I don't this comment is very helpful as-is anyway.
For one mentioning the value while the code uses symbolic names is
confusing, but otherwise it also doesn't really say why we care.
IMHO we can just drop it?

> +			if (status == (NVME_SC_INVALID_NS | NVME_STATUS_DNR))

no need for the braces.

> +				status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;

Another overly long line.  Easily fixed by just directly returning:

				return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;


