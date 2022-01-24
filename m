Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5674CC433FE
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Jan 2022 13:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V68Zlj2IT74Yk5KSjy44dwlM/Wu7dSvgyGm1cMDlpgY=; b=swQNll/whyNApwmd69FJYe60xA
	TJ/n5K45/Q8mu9QHhN2XS7fPmCxtAZqmEBlQtMS/+gsAIE9xeQnu0VHeH5z1AJ7/xHgoJkXbZijGw
	lc1qU75OZpLokC0VoPjFpwJi+lBCl0XRAlCZ6ui4/MDjtVRtniH9nJb5Ogcz4e7FOLMkDJC3Q/jxR
	CQP+LNW3dJfYlO79ot1/N7sSmEgllFSg/BQDdw7l641fPV7mtj0lrty4rklYVCUE4DR+wz/lub7mP
	7EgZWD/B0QebTvwKeLngj8Hg8Wdpmh+ciddjl5xdB/E9uyagp9dCCoZts9J2VQ0oInd75opy9rBM8
	E10UJCEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nByxG-003M11-Jb; Mon, 24 Jan 2022 13:00:18 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nByxE-003M02-8n
 for linux-nvme@lists.infradead.org; Mon, 24 Jan 2022 13:00:17 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 8D0ED68C4E; Mon, 24 Jan 2022 14:00:13 +0100 (CET)
Date: Mon, 24 Jan 2022 14:00:13 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org
Subject: Re: [PATCH V2 02/13] block: move initialization of q->blkg_list
 into blkcg_init_queue
Message-ID: <20220124130013.GB27269@lst.de>
References: <20220122111054.1126146-1-ming.lei@redhat.com>
 <20220122111054.1126146-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220122111054.1126146-3-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220124_050016_482569_D90E2487 
X-CRM114-Status: GOOD (  12.92  )
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

On Sat, Jan 22, 2022 at 07:10:43PM +0800, Ming Lei wrote:
> q->blkg_list is only used by blkcg code, so move it into
> blkcg_init_queue.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

