Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FAD6CCF9FF
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Oct 2025 08:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0plJzBJ8suu120gmNSRdQdzRp3afS8Z1Vm/UZ8T3ODI=; b=t+VNr5YQebM4BHa9HjCmJZ7geE
	mbmvrEkpBY1cn/QJyM5FT9j2nFk+yp1C+tILAiA0XXdXF1ZIE6k/y1CaRN/Cv8sh8K6Ew8CJp2ht+
	kiz0xW40JGqnwk4UFl+efLNSzPfTeWGyY7RzD7pkDadhl4QcTycOEk0uIzF6+w5+o5G6Ia3OAsa/g
	J6iYMniCX5MiIvOuxrzYcEnDAMp5Wy2Q5VVtFx8jLM+4E/LxMikqAGqTyDc9O0QdueEYk9v1gkQaT
	wGD3LvrvLuHuZgc9EuCvwHBhUGW/r04Qf2gHmxvEkg+b0C/CI2h695Zs+iqGM0ULQsH9r34U4DztF
	rSVPC3bA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEksb-00000005heX-1hL2;
	Fri, 31 Oct 2025 08:53:05 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEksX-00000005hdA-3r4h
	for linux-nvme@lists.infradead.org;
	Fri, 31 Oct 2025 08:53:03 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 493C5227A88; Fri, 31 Oct 2025 09:52:58 +0100 (CET)
Date: Fri, 31 Oct 2025 09:52:58 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, Keith Busch <keith.busch@wdc.com>,
	Christoph Hellwig <hch@lst.de>, dm-devel@lists.linux.dev,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
	Carlos Maiolino <cem@kernel.org>, linux-btrfs@vger.kernel.org,
	David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 08/13] block: introduce blkdev_get_zone_info()
Message-ID: <20251031085258.GA9041@lst.de>
References: <20251031061307.185513-1-dlemoal@kernel.org> <20251031061307.185513-9-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031061307.185513-9-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251031_015302_167966_E1D7A944 
X-CRM114-Status: GOOD (  12.40  )
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

On Fri, Oct 31, 2025 at 03:13:02PM +0900, Damien Le Moal wrote:
> In preparation for using blkdev_get_zone_info() in upcoming file systems
> changes, also export this function as a GPL symbol.

As FYI I asked for this an plan to make use of this in XFS to unwind the
callbacks.  But I'd rather do that a merge window later to minimize
cross-tree dependencies.

The patch looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

