Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43C2CC001DC
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Jul 2023 07:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TLUOrz2O7XtnlAMXY8aeUdPeNBXUAyTO1dE7whqT6mo=; b=b/Tj49LGdW45Nbc7TxH8V8/Sbd
	j8Bi/oHq4CwxH4B7Z1BmKG0SPcb9qWKqHPKKmCHwrkuYo5ouDH7Lbz6s5LbofCB9qHBNDySDUO4Ak
	Kp1VavBK31cQjIA0tDBX2l8zmtjBnC1alIccT7uKnxGKGgXaHj+RP3gQaIFGK3XNEqUiE+Y2cVt4e
	Aa+kdc9uzQkyC6MYCpSHBZNLChVhSOHvZLS6XMxhWHQtPtPOu3PGHU5bP81DjonKQpEoRS2rzYAFi
	ddajbw/35MnXsn3N+veo/g4mjMM/AeweaXLpBCrxswkPT98/pWuAoDzuW9McKVO/AZAjE+D/1gbq3
	pgLou86g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQN6i-00EHlr-1o;
	Mon, 31 Jul 2023 07:14:20 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qQN6f-00EHl6-2U
	for linux-nvme@lists.infradead.org;
	Mon, 31 Jul 2023 07:14:19 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 02FA567373; Mon, 31 Jul 2023 09:14:10 +0200 (CEST)
Date: Mon, 31 Jul 2023 09:14:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	linux-nvme@lists.infradead.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
	Wen Xiong <wenxiong@linux.ibm.com>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH V2 0/9] blk-mq: fix wrong queue mapping for kdump kernel
Message-ID: <20230731071409.GA31608@lst.de>
References: <20230726094027.535126-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726094027.535126-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230731_001417_952210_7268D040 
X-CRM114-Status: GOOD (  14.26  )
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

On Wed, Jul 26, 2023 at 05:40:18PM +0800, Ming Lei wrote:
> Hi,
> 
> On arm and ppc64, 'maxcpus=1' is required for kdump kernel,
> see `Documentation/admin-guide/kdump/kdump.rst`, so num_possible_cpus()
> still returns all CPUs because 'maxcpus=1' just bring up one single
> cpu core during booting.

Just as said last time:  Please drop the odd is_kdump_kernel checks
in blk_mq_update_queue_map and blk_mq_alloc_tag_set instead of sprinkling
this crap even further. 


