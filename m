Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95BD5C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Sep 2022 13:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dq8um0VwptWS6RMSlFJsJbhn79YmhbFxSVLGzJlDDn8=; b=dJF7ln7MmHJ0MKfUYc1VE/NerQ
	Ss8ECzAxHyFGs4o+vW0V3yWC5ZLNnOUirvynMRYR3z7jR0C/hxGgQxu6dFaOkHDElfUXG+daNM1mZ
	YxXA9/EDiHUw8VuIzKHJcn7vNHmyyZfzoTC+njg1Rd4wvD4T85GMqMD2wE+u2F1KfZl/p8ceJQekR
	FiPL12WFIybXuH22O140U+Vhz0voNL+EEjajXI3maoRi6PqZ1z/Eyy3fS3TlJXCgl4wI2a+kedzqX
	n2llZV+8MqQuSoDGyS+z9P6Ljoxghb9qvbnz+muDJh95IsKKCWTqQK1oJ9HBdjPxhkwyGxgTcPvoF
	5rheSNTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odtb0-003HLj-QK; Thu, 29 Sep 2022 13:28:58 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odtax-003HKb-Rx
	for linux-nvme@lists.infradead.org; Thu, 29 Sep 2022 13:28:57 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 12BD568BFE; Thu, 29 Sep 2022 15:28:53 +0200 (CEST)
Date: Thu, 29 Sep 2022 15:28:52 +0200
From: Christoph Hellwig <hch@lst.de>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	linux-scsi@vger.kernel.org
Subject: Re: [PATCH for-next v11 12/13] scsi: Use blk_rq_map_user_io helper
Message-ID: <20220929132852.GF27768@lst.de>
References: <20220929120632.64749-1-anuj20.g@samsung.com> <CGME20220929121713epcas5p1824ed0c48c9e9ceeb18954d9c23564ed@epcas5p1.samsung.com> <20220929120632.64749-13-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929120632.64749-13-anuj20.g@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220929_062856_074801_EA7836F9 
X-CRM114-Status: UNSURE (   9.53  )
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

On Thu, Sep 29, 2022 at 05:36:31PM +0530, Anuj Gupta wrote:
> Use the new blk_rq_map_user_io helper instead of duplicating code at
> various places.

Additionally this also takes advantage of the on-stack iov fast path
which should be mentined here.

Othewise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

