Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15A06C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Feb 2022 15:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2BQAQrgnY+ZjEcPbeOm+3aZRepsY8CLjtYSHxUYHEQ0=; b=thUlm9RZnoZT8uqEsxxAGW5/ZT
	eqdd9tSvwyhXoTa89itKazZaS8SugI7LDawNHJM44+y4iuYcf9FPndkh3FTpzCCX4TERE3KGTRwVp
	+qT5Ouh97i/pLpHK3PxotpaLWuw0/hj4LxfqkiUj51w6+YquMsEFA8wQ5Jn6meULdLvlupkil7f75
	uw1+Rmb6mrf3QncscLZOty6xARosIc97lQ+7AXRXfZ8EpSEVU+kPlCGmg1TUHhirhgqfoypiHXX9L
	xrX6xNrhhmy7xhPulHtK6fZnbcnFGS7q9xcTLx9/t8xGkGqdB0JcnoltRvm5lrzPsz3WR8akcDgVG
	/Bd70LNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nKM6U-007TlA-Ja; Wed, 16 Feb 2022 15:20:26 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nKM6R-007Tk5-Hd
 for linux-nvme@lists.infradead.org; Wed, 16 Feb 2022 15:20:24 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id D43FE68B05; Wed, 16 Feb 2022 16:20:19 +0100 (CET)
Date: Wed, 16 Feb 2022 16:20:19 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, kbusch@kernel.org,
 markus.bloechl@ipetronik.com, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] block: skip the fsync_bdev call in del_gendisk for
 surprise removals
Message-ID: <20220216152019.GA19002@lst.de>
References: <20220216150901.4166235-1-hch@lst.de>
 <20220216150901.4166235-2-hch@lst.de>
 <4f29d9a3-021c-f2f0-b452-e682fa1db459@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f29d9a3-021c-f2f0-b452-e682fa1db459@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220216_072023_758476_6C6DCB01 
X-CRM114-Status: GOOD (  13.06  )
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

On Wed, Feb 16, 2022 at 04:18:43PM +0100, Hannes Reinecke wrote:
> My turn to be picky:
> In the previous patch you use 'set_bit()' for GD_DEAD, which to my 
> knowledge doesn't imply a memory barrier.
> Yet here you rely on that for the 'test_bit()' to return the correct/most 
> recent value.
> Don't we need a memory barrier here somewhere?

Well, we only do the test to skip useless work.  A race is not a
problem here.

