Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CB9ECCFA00
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Oct 2025 08:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZUqkjtoIW3hp8lRoAOI5OGd1VuUEKVnLM6PGV7OsI+8=; b=GHP2uCl61skT/UkkXv+XHow4ET
	+4t5GCmR4SsZ4F80O6miudyEcK3KJYJk1hms23ZIUVtKTdrRg05BS33GM9H35818GIMTo/JXOxJF6
	kFvXxsfC6cqqU8bUnhB3xUOCuztxwDMG1gPDleeLTVOVaL3NaN9u06r5cjpnJ//GyvmfEyUUJG3pQ
	nH9y4oErwLZfmhm2VW4xShLhmI1rAOkHCM/GxjcgQViZA99QgZyEd/fnoANy8WRNW2+xXNoJu9hbx
	qDUaf8UucqVlTdcCuS5N8LbGiJNzHGzHPzW5cjQou9XmeOajoBmvRonkGvtwRheCAEvrBLTkIyd6I
	KlNZXghw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEkuv-00000005idU-00dL;
	Fri, 31 Oct 2025 08:55:29 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEkur-00000005ibo-3d8m
	for linux-nvme@lists.infradead.org;
	Fri, 31 Oct 2025 08:55:27 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 133DE227A88; Fri, 31 Oct 2025 09:55:22 +0100 (CET)
Date: Fri, 31 Oct 2025 09:55:21 +0100
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
Subject: Re: [PATCH 13/13] xfs: use blkdev_report_zones_cached()
Message-ID: <20251031085521.GE9041@lst.de>
References: <20251031061307.185513-1-dlemoal@kernel.org> <20251031061307.185513-14-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031061307.185513-14-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251031_015526_065087_83B9E32B 
X-CRM114-Status: GOOD (  10.82  )
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

(and with a more exhaustive change to remove the callbacks this should
get even better soon).


