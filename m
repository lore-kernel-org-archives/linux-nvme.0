Return-Path: <SRS0=ulAu=GW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBEF7C433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Jan 2021 06:16:03 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2548922D71
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Jan 2021 06:16:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2548922D71
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=VglrxZPGRMptohNQIy73Fp61+Wk9gC1KQWMtzJ0jYrs=; b=ttadu+epgpqaPtLWqvFGcApV7
	CQcic88s/lRZFKmN/cKn25XserJN5207W4Hn/zZ0subZObhuFK9N9JT7KSjgKzsMEDW6lfq52My33
	M6rkVndlJ7kqFR8pW8IJa1cIUF6Fpf7C3rLxYLweHOUunidLm8GymfBO1EJfXjzhY7MU2ecb6yXiP
	Efm+MIU5JrJIYzW3Wl0YYhA2IQ/q35lMoybc84cjKTFTlZiHK8iCWL8ggfpmFs5JPqeqs8TOoItp3
	O8PbS0Ao81uYCuTPnEGlzPRAiXluk4MD0sQVxOP2zpzeu2LIHXlDOFXjPzZrnBUnv5G/lz4rEaDHs
	afxMhFqZQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l1kIm-0003o4-U8; Tue, 19 Jan 2021 06:15:41 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l1kIl-0003nX-3c
 for linux-nvme@lists.infradead.org; Tue, 19 Jan 2021 06:15:39 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id B5D076736F; Tue, 19 Jan 2021 07:15:36 +0100 (CET)
Date: Tue, 19 Jan 2021 07:15:36 +0100
From: "hch@lst.de" <hch@lst.de>
To: Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH V9 4/9] nvmet: add ZBD over ZNS backend support
Message-ID: <20210119061536.GB21250@lst.de>
References: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com>
 <20210112042623.6316-5-chaitanya.kulkarni@wdc.com>
 <20210112074805.GA24443@lst.de>
 <BL0PR04MB65145CE93F2AAF66158A3D71E7AA0@BL0PR04MB6514.namprd04.prod.outlook.com>
 <20210118182515.GC11082@lst.de>
 <2c3a1a515bd3913f46ecf81a157e35ff56a1fb70.camel@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2c3a1a515bd3913f46ecf81a157e35ff56a1fb70.camel@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210119_011539_270530_D6C8D4AB 
X-CRM114-Status: GOOD (  13.44  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>, Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jan 19, 2021 at 04:28:00AM +0000, Damien Le Moal wrote:
> What about something like this below to add to Chaitanya series ?
> This adds the queue limit zone_write_granularity which is set to the physical
> block size for scsi, and for NVMe/ZNS too since that value is limited to the
> atomic block size. Lightly tested with both 512e and 4kn SMR drives.

For ZNS it should just be the logic block size, the atomic size is not
the right thing use here.

> +	if (blk_queue_is_zoned(q)) {
> +		if (limits->zone_write_granularity < limits-
> >logical_block_size)

Overly long line here, and your mailer wrapped it as a punishment :)

That being said I don't think the normal path to set the block size
should affect it.  Just add the manual call and leave the non-zoned
path alone.

> +EXPORT_SYMBOL(blk_queue_zone_write_granularity);

EXPORT_SYMBOL_GPL for all zoned stuff.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
