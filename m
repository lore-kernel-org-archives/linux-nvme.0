Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E25C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Jan 2022 13:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PsaFZMU8JCwsRMyw2pQTtVSt9VOApZwlm4xaYZ/noP0=; b=kvzALoO45vzLk/BYGDrItE2mYV
	tvFUfTTZiGzHeNI5+cKKjxiAn8J2MJXqfpkHbancL0GxianKPECtV+8Xt+qVXWUB53M0qdIncRJg9
	sM6P5031rWtDqj0pgK/paBNPTfmzbU+1sVyOV7OOm8YR9x1BoPOx53MZajsuHKlRHZTEFjDD93jBx
	v58pMoJGwhbPqdmp41lR1qTGXMQ6IQEOdn38ZfmIfNG6vZZPgbKYpUV9HJGRi3U9EV/D3sN3uJuQy
	okeQEz37LT6cJ1814NTqXb3kvDY308FBSL3QbubZ2RFZB1QJOoU9umJJwqWlz/vMlqsvpdPn9a58R
	2yKSjYnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nBzZV-003WzB-7c; Mon, 24 Jan 2022 13:39:49 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nBzZS-003Wy2-7N
 for linux-nvme@lists.infradead.org; Mon, 24 Jan 2022 13:39:47 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 0B02768BEB; Mon, 24 Jan 2022 14:39:43 +0100 (CET)
Date: Mon, 24 Jan 2022 14:39:42 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org
Subject: Re: [PATCH V2 13/13] block: don't drain file system I/O on del_gendisk
Message-ID: <20220124133942.GB27997@lst.de>
References: <20220122111054.1126146-1-ming.lei@redhat.com>
 <20220122111054.1126146-14-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220122111054.1126146-14-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220124_053946_451108_5409B3EB 
X-CRM114-Status: GOOD (  13.34  )
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

On Sat, Jan 22, 2022 at 07:10:54PM +0800, Ming Lei wrote:
> So not necessary to drain FS I/O in del_gendisk() any more.

But this changes a few other things as well.

For example the early set GD_DEAD flag is very useful to stop I/O
ASAP when entering del_gendisk.  Also some other work here is moved
later as well that really should be part of del_gendisk.

