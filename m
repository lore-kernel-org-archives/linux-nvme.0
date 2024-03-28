Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBF13C54E67
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Mar 2024 08:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7Wl5yWEo3pqVsPtCk0mjqeyFJD1Fs3+jijA35pcILQo=; b=w49zILTUvojCWjZY1+SAgvHqyA
	6Zr9bYkyOQDvZwAzabQ3Q5D+oaWhal4yjo86Ft4Ba91ipTOyYPHWes9bc8ohDXKhOg5WR1Syfar+I
	j41bALQXKPCtsZo49Fc7veDDRVFtdhMHm79HjwkUjAHSMvz0jfY4UlRrPTdF3Xbzm2Q/q50jr9Qzr
	QIRMCsBACV7wDWxxx+/DWv7mFwxArIZsehT54Qinx7kh4h3zSsO78IvD9lmcwLz7R2+HZsx27fDbH
	9mDv1g3zMZGXGdPimc1Q1rKzoBD/q3kaxOoko35BB3Op4axl6VORtdfq9hCRu9T3XitsA0sfWqJhv
	vw1cjmVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpkja-0000000Czv9-1iGJ;
	Thu, 28 Mar 2024 08:03:38 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpjc3-0000000Clgz-0m3g
	for linux-nvme@lists.infradead.org;
	Thu, 28 Mar 2024 06:51:48 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2025C68D17; Thu, 28 Mar 2024 07:51:39 +0100 (CET)
Date: Thu, 28 Mar 2024 07:51:38 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	dm-devel@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
	linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v3 30/30] block: Do not special-case plugging of zone
 write operations
Message-ID: <20240328065138.GA17890@lst.de>
References: <20240328004409.594888-1-dlemoal@kernel.org> <20240328004409.594888-31-dlemoal@kernel.org> <20240328045430.GN14113@lst.de> <6035bad8-b157-4705-8ec1-80cc003fa646@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6035bad8-b157-4705-8ec1-80cc003fa646@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240327_235147_385978_5DD06C1C 
X-CRM114-Status: GOOD (  15.33  )
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

On Thu, Mar 28, 2024 at 03:43:02PM +0900, Damien Le Moal wrote:
> That is indeed not great, but irrelevant for zone writes as the regular BIO plug
> is after the zone write plugging. So the regular BIO plug can only see at most
> one write request per zone. Even if that order changes, that will not result in
> unaligned write errors like before. But the reordering may still be bad for
> performance though, especially on HDD, so yes, we should definitely look into this.

Irrelevant is not how I would frame it.  Yes, it will not affect
correctness.  But it will affect performance not just for the write
itself, but also in the long run as it affects the on-disk extent
layout.


