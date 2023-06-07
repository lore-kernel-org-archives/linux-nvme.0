Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A583AC7EE23
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jun 2023 12:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RJ1GSjR2F6lCrABgtv3NbFxnpIDYWRxGJMlZdi7mqNA=; b=4aQD1DGWvbcoqYeO4WP9SfJSkh
	phTWz+aNHUGvwPGjOuHbNXBrI8vsEkTybECBUaIVYJP7KoL8bWgLlero5wyVeWk5uAIceZD1HKjrT
	hYMSdYASKJZUGlLVzTE2KcxNqZ5bG6mJG/Mn/DTxnx1MYW5VSQydnF9P7L4IbV8UyJJwvTiasixdf
	jGbYKv2AbZuhV9ck4Oc2wiifJWrHvFkaDlIIR7bQ0auBnx9p6ZgOMfbbEVoMjR/hmtEuVJ4MF68g0
	bOabeTl4SOL3QNwVA+yAvF1D60ro+IPEFxNAEr8eMLPmrlaVfsYAqmvUjuHZ1Wk9I27SAwIw+KbIr
	dCaZlFPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6sAx-005rIT-2Y;
	Wed, 07 Jun 2023 12:22:07 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6s9d-005qUX-16;
	Wed, 07 Jun 2023 12:20:47 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C229F6732D; Wed,  7 Jun 2023 14:20:41 +0200 (CEST)
Date: Wed, 7 Jun 2023 14:20:41 +0200
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
Subject: Re: [PATCH 05/31] cdrom: track if a cdrom_device_info was opened
 for data
Message-ID: <20230607122041.GA14579@lst.de>
References: <20230606073950.225178-1-hch@lst.de> <20230606073950.225178-6-hch@lst.de> <a7524776-f4c3-147a-cfa5-da92d2f877bb@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7524776-f4c3-147a-cfa5-da92d2f877bb@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230607_052045_522238_A9C8A601 
X-CRM114-Status: GOOD (  13.63  )
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

On Wed, Jun 07, 2023 at 02:13:33PM +0200, Hannes Reinecke wrote:
>> +++ b/include/linux/cdrom.h
>> @@ -64,6 +64,7 @@ struct cdrom_device_info {
>>   	int (*exit)(struct cdrom_device_info *);
>>   	int mrw_mode_page;
>>   	__s64 last_media_change_ms;
>> +	bool opened_for_data;
>>   };
>>     struct cdrom_device_ops {
>
> Do we care about alignment here?
> integer followed by a 64 bit value followed by a bool seems
> like an automatic padding to me ...

I don't think the structure matter much here, but placing it before
last_media_change_ms still seems better.  I'll change it.


