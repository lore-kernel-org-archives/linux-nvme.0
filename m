Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36E99C5472C
	for <linux-nvme@archiver.kernel.org>; Sat, 24 Aug 2024 08:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=NoGJpzwYgGaRAzo/nrTNP0ZyiT
	VgxplT9OVXTWyxdFMa1MpCJ4I+wgliJk2VgmbGx5AgeJU5AjqUUBkLIc2rD03kEFLEiG12bz4upzB
	MsGlf6Ei+trQepA/fVPIGQtmuVbbXVsYyahQ34InqdBGeSxZcyBAIeFoFzTcJq29xt7TBxpSreA7+
	ECf0Zv+AwgbiJNobSqFTVo2Nk3Hixol5vCvme7pJ3UFa8/KVTP6qZeN00wRzacjZiaylRzHvyabFs
	/0VyUmuPh7DOkPnLNoA6NsbD32zpzCbFPxNP7j2ArLlWB1F5b6sX/Vo3zTIQyrAdhjEfc90rW5ULq
	VdsPLiQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shm4u-00000001pXZ-3XRE;
	Sat, 24 Aug 2024 08:24:56 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shm4s-00000001pWh-17EM
	for linux-nvme@lists.infradead.org;
	Sat, 24 Aug 2024 08:24:55 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C72F5227A87; Sat, 24 Aug 2024 10:24:50 +0200 (CEST)
Date: Sat, 24 Aug 2024 10:24:50 +0200
From: Christoph Hellwig <hch@lst.de>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	martin.petersen@oracle.com, asml.silence@gmail.com, krisman@suse.de,
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	linux-scsi@vger.kernel.org
Subject: Re: [PATCH v3 02/10] block: introduce a helper to determine
 metadata bytes from data iter
Message-ID: <20240824082450.GB8805@lst.de>
References: <20240823103811.2421-1-anuj20.g@samsung.com> <CGME20240823104618epcas5p4b9983678886dceed75edd9cbec9341b2@epcas5p4.samsung.com> <20240823103811.2421-3-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823103811.2421-3-anuj20.g@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240824_012454_508928_F1C06985 
X-CRM114-Status: UNSURE (   7.54  )
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


