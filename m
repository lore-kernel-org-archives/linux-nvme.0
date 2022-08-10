Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 134B0C00140
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Aug 2022 14:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KXEbkddkqywZOsohimQAqo6J6buaMb4+XJO/Py/zKnQ=; b=H5lBM2Uyu4a8yNHW2SUcS8z7oV
	5Nvf6Vymynow52rdD7aekMnFbKeKGuMrBZKAkQ9fsRcBykzsK3BoRwjRjkowiwHU/USYWEVqKhmVU
	M5cFYc1sYe8zu/mLbjWElrNR6O3TGi770pX9NyxLwyGwD1LXa4WUQlzJpy0nC1qJBP7I09+fiHlwS
	owe5shqG45aH9Om9xHqI3q0XNi02jEaWpZ376OUbjxVPYEjx1FJSs8e4Tk739LHEKTICcGviCZ5tq
	TGrHTTdsGlhhtR09jiwDkBvCtTx+nQ1WFw1rwcUtF5vdGEkYWJf07n2QHqpMESQfrgF1OWm7i8WSR
	8lw7AngQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLmcn-00CHFL-Fp; Wed, 10 Aug 2022 14:23:57 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLmck-00CHDS-0d
	for linux-nvme@lists.infradead.org; Wed, 10 Aug 2022 14:23:55 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5893B68AA6; Wed, 10 Aug 2022 16:23:51 +0200 (CEST)
Date: Wed, 10 Aug 2022 16:23:51 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"Ewan D . Milne" <emilne@redhat.com>,
	James Smart <jsmart2021@gmail.com>,
	Muneendra Kumar M <muneendra.kumar@broadcom.com>
Subject: Re: [PATCH] nvme-fc: fix the fc_appid_store return value
Message-ID: <20220810142351.GC25801@lst.de>
References: <20220806083228.3826126-1-hch@lst.de> <d6867d59-9e1b-78c7-6832-3157bc0fda61@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6867d59-9e1b-78c7-6832-3157bc0fda61@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220810_072354_217448_10AAAB3E 
X-CRM114-Status: GOOD (  10.99  )
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

On Sun, Aug 07, 2022 at 09:23:27AM +0000, Chaitanya Kulkarni wrote:
> while we are at it perhaps we should consider fixing following ?

Yes, please send a separate patch.  Please also remove the various
pointless braces in the hunk that you are touching.

