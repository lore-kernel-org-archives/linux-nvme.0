Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC4C4C7EE25
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jun 2023 12:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7tm9nEZi8PggEiWisRdrnJZs9/69aSw6wpFxpqYOeUc=; b=SQiGuz/FSRQMlfwodxVewfW7MP
	aBdbRIcPzPSFPNQUwY71lZlWmds6XhoD0UR/yqqi61GLP9zykbvR2kRDMQsgNhirzdCx06e+WL1ST
	qoQb/22GqVu1IyDa/Gnri/JGMkylFow0/SvBh/zbRVwd+RkGixtgem3SuzPehP4rm1EuYovtWafVr
	hwueehi+EH2gkoTGH53y7R3cs3rexleY1lobD7wOHVudNmJRDgxhCoYhLJZ+icgc0oQDbdtosTjz8
	2EpN9ITX7dw2OArMwUXo5dgjOqJwcQtewQdnbP0uqgT3Kd5CKViCf6b042aZNUTFMZZaUHTwwzBek
	22QUlWaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6sAy-005rJ6-2a;
	Wed, 07 Jun 2023 12:22:08 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6sAQ-005qyZ-28;
	Wed, 07 Jun 2023 12:21:38 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id EA6EB6732D; Wed,  7 Jun 2023 14:21:31 +0200 (CEST)
Date: Wed, 7 Jun 2023 14:21:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Richard Weinberger <richard@nod.at>,
	Josef Bacik <josef@toxicpanda.com>,
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>,
	Phillip Potter <phil@philpotter.co.uk>, Coly Li <colyli@suse.de>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
	linux-block@vger.kernel.org, linux-um@lists.infradead.org,
	linux-scsi@vger.kernel.org, linux-bcache@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
	linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 08/31] block: share code between
 disk_check_media_change and disk_force_media_change
Message-ID: <20230607122131.GB14579@lst.de>
References: <20230606073950.225178-1-hch@lst.de> <20230606073950.225178-9-hch@lst.de> <30183892-dce6-6946-2f7a-1bc693a657a2@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30183892-dce6-6946-2f7a-1bc693a657a2@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230607_052134_861857_6B45C78E 
X-CRM114-Status: GOOD (  12.78  )
X-Mailman-Approved-At: Wed, 07 Jun 2023 05:22:07 -0700
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

On Wed, Jun 07, 2023 at 02:19:00PM +0200, Hannes Reinecke wrote:
>> -	return true;
>> +	return __disk_check_media_change(disk,
>> +			disk_clear_events(disk, DISK_EVENT_MEDIA_CHANGE |
>> +						DISK_EVENT_EJECT_REQUEST));
>
> Can you move the call to disk_clear_events() out of the call to 
> __disk_check_media_change()?
> I find this pattern hard to read.

I suspect you've not done enough functional programming in your youth :)

