Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00F8CC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Jan 2022 13:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+vG5HOmOjw/nvh4l8J19ZMtjcAiZurSbY7Cok5pAoX0=; b=RofgiA+04IGG1hk9dBiWiyvK+4
	KN4c4h+gLUe3R07FPwHjAeQj2yREefP/dgLssJe5PsoqBnDKvTanzz+PUqtunaKBZDsdM3Xx4owY2
	/bzjoWP2BLDaohQwBlFNgLzxjttRiLSmsafBuXsNBLSCmG2gWZNUcbxEKnivkQPoA37XqN+VwQpu6
	cRIjAVbFq5QcGSZhA1hb/Kx5dKhR6dnGMZvOsBo3m1KQ5zEJo+UCd6mw1l7ebx5lPo0ATASXs3WAh
	DCXGZ4XSUkEJg1t9J5SAC/DpqaaAeNWAwFwxMeS3+bvDG5S8+dpXjePxgY/Yw14I0fbH85nBEa7/x
	J89QuTiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nBz63-003OOf-CH; Mon, 24 Jan 2022 13:09:23 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nBz60-003ONW-9j
 for linux-nvme@lists.infradead.org; Mon, 24 Jan 2022 13:09:21 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 2C14568BEB; Mon, 24 Jan 2022 14:09:17 +0100 (CET)
Date: Mon, 24 Jan 2022 14:09:17 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org
Subject: Re: [PATCH V2 07/13] block: move q_usage_counter release into
 blk_queue_release
Message-ID: <20220124130917.GF27269@lst.de>
References: <20220122111054.1126146-1-ming.lei@redhat.com>
 <20220122111054.1126146-8-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220122111054.1126146-8-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220124_050920_516332_8BDB3AA1 
X-CRM114-Status: GOOD (  13.86  )
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

On Sat, Jan 22, 2022 at 07:10:48PM +0800, Ming Lei wrote:
> After blk_cleanup_queue() returns, disk may not be released yet, so
> probably bio may still be submitted and ->q_usage_counter may be
> touched, so far this way seems safe, but not good from API's viewpoint.
> 
> Move the release ofq_usage_counter into blk_queue_release().

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

