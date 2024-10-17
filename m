Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F31AD2F7FC
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Oct 2024 08:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=fkj3lqUa2ZtWvWG1NjGCNupkkp
	MaBLcLF0XXEv+eECtLOGQWpoNEnneNN1llok1LV8+bPvTmuZ+YSYnUHtFFuvz7xnx3BrtzTvJldc2
	WU2QufPoJVXttawwdo2PT5wZRRzcFEaS5kkfBZb14hKVlZ8+djIsL8XQv0IxvGDxO0TH8aDO4Gpma
	V0/CFI/f6WBPnvCpZhp0WmIZUGvMI/fVR3Vl+txV6cfJjNAqPCH2baOSz7DANfcIQBzyprzrFAN+e
	fcHQMExu24B5FCdokU5lxNIEA3rQDAk0f9zMdqDoCY3GlfhixnbYWzAoYfVh6IaDgHmr19sOnBQXW
	6KUgC4/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1Lhn-0000000E9AO-2S1z;
	Thu, 17 Oct 2024 08:17:59 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1Lff-0000000E84h-2vtQ
	for linux-nvme@lists.infradead.org;
	Thu, 17 Oct 2024 08:15:49 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 13E01227A87; Thu, 17 Oct 2024 10:15:45 +0200 (CEST)
Date: Thu, 17 Oct 2024 10:15:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	martin.petersen@oracle.com, asml.silence@gmail.com,
	anuj1072538@gmail.com, krisman@suse.de, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, linux-scsi@vger.kernel.org,
	vishak.g@samsung.com, Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v4 09/11] block: add support to pass user meta buffer
Message-ID: <20241017081544.GE27241@lst.de>
References: <20241016112912.63542-1-anuj20.g@samsung.com> <CGME20241016113752epcas5p4c365819fce1e5d498fd781ae2b309341@epcas5p4.samsung.com> <20241016112912.63542-10-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016112912.63542-10-anuj20.g@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241017_011547_905463_26B2DFD0 
X-CRM114-Status: UNSURE (   8.16  )
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

