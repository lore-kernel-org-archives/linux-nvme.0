Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0DA8F433D1
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Apr 2026 05:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d4U/9tOl3k/gM6qkXlyEXQi8p1eCB9xI6XAgtnenMng=; b=f4AQYO2SkR/GcFgHgjR2oJNi6I
	Ww/khwRJtDtOY5n7iATLIhXEE5eV1cOPA1j/XAbh1UTUeYyeAew4A9SNZlZloiNdJOODInCYzjTRe
	Rn6JuyasTHRD+vYV1cxrFlRhXZqZE0y1IGak92v94px580yqhshM3Z57F8LKi62ZB4u+EuvZLR0uE
	5aEhbUZBMm8YvKg+hFgzzHgO0qGgaUyV111ZWUJle+zw1LmtI7n7aJPR8jZPFApsy5ePREDRGaik4
	7l09GErJ4OBel5FhYn6HV0QhW+LX3jDAlQ+qJkqsXGkcBU0skoaPUUKl/F5k4aHfGArdYhvu/jQnE
	EUE/oKbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDF4N-00000001ykg-0409;
	Thu, 16 Apr 2026 05:15:15 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDF4J-00000001ykA-1Jip
	for linux-nvme@lists.infradead.org;
	Thu, 16 Apr 2026 05:15:14 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 17EA16732A; Thu, 16 Apr 2026 07:14:59 +0200 (CEST)
Date: Thu, 16 Apr 2026 07:14:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: hch@lst.de, kbusch@kernel.org, nilay@linux.ibm.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-multipath: put module reference when delayed
 removal work is canceled
Message-ID: <20260416051459.GA14802@lst.de>
References: <20260415155358.1517871-1-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415155358.1517871-1-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260415_221511_495600_A704C4AE 
X-CRM114-Status: GOOD (  10.84  )
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

On Wed, Apr 15, 2026 at 03:53:58PM +0000, John Garry wrote:
> The delayed disk removal work is canceled when a NS (re)appears. However,
> we do not put the module reference grabbed in nvme_mpath_remove_disk(), so
> fix that.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


