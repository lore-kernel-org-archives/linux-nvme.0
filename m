Return-Path: <SRS0=6U9w=JQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58531C43470
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Apr 2021 13:56:10 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE53361077
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Apr 2021 13:56:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE53361077
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:In-Reply-To:
	Subject:cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Wszw6r7tb3zV/+Fy35DLiKqF7053HHJ2P8NZV+7x/C0=; b=LgREBV4Jm8jaUFRJNohZQ1yfJ
	0FLfjSesabJdwiU9CY/AyimsmEbD7snfr8yoY1ZZ0e08ppuNVmjLkHcDZfa8fcEqxwiAnufJ8D0at
	Umi80KLWZ7vtEiybeFCLRmz677dXSEBtDq3cvX5MDdyArkXB6orsQTGcBRc9CsZsz9HFQGjw3GrpB
	b71KXTThV5WTyPB2oQak23cU4pkUzvS9SSdDk/oSRGHVg5LvFY+ZerjH9zdmPHUTc3ThXoku765U7
	6We0+nlr2IwpyH8qUauNXHn0r4sQJAPUwLjklXGbrTHeg5sAvdu1Kt2slprPcDTJr30/EWHK6hPo4
	xEZVq1qhw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lYUNF-00A24e-EA; Mon, 19 Apr 2021 13:55:37 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYUNB-00A24F-G6
 for linux-nvme@desiato.infradead.org; Mon, 19 Apr 2021 13:55:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:References:
 Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=WxdqbfoBJXaYxfD6rImyDUvIjZiF5Q3ecjdpEO3HnrU=; b=ZjoXMN9SqJuzBUu9scJADcZaXM
 ZTZj8kDfsxRAFm+yaoohQwTQi3bw5JnHX9jz6uYYEuT0BLL5YDUuk9H1tTSANtbXtftRtwPloFaBA
 Y+hIAStZYXR7K0Zl6cN+zWMqTV0idIE/OFPJJryAZj7BLAqHC03TUgbB+qwx9YT/AzG0q6Aj9UDTz
 9VYSGZONhSKYb8D77fuX3q4r40j2XkJANwi9SUyEpn4M9+LvvjH2e4MF1QuVfwdLPWA5PB/yBdpR7
 G3Gq8ht2kmBwIIn3La2aSLELNJu+va0K4Ev0b/R+vZkEgpcDHGd95eoDTVqRo4iwLY8XNsgxP9weM
 RagWgvMw==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYUN7-00BQEo-O4
 for linux-nvme@lists.infradead.org; Mon, 19 Apr 2021 13:55:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618840527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WxdqbfoBJXaYxfD6rImyDUvIjZiF5Q3ecjdpEO3HnrU=;
 b=ZCHwSLBVX90Q/e/qV9ttAFNtuYxFwbdNJVZhvxLbQYTItas5K5T5xOXJQhU1avUdU4RVl1
 Vo94a5AnCpCMhwgr64VB7mCNWn00RlPzzxVjYi1vFtVH6O0xv4NFfWh4emctUvdzeE6R1X
 ztRC4UAyjUAy2XdnBHrLyotupxr+JVI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-OjBtjruXOaaknhPs7HO74A-1; Mon, 19 Apr 2021 09:55:26 -0400
X-MC-Unique: OjBtjruXOaaknhPs7HO74A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C60D687A83C;
 Mon, 19 Apr 2021 13:55:24 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com
 (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2FB8E5D9CA;
 Mon, 19 Apr 2021 13:55:18 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
 by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id
 13JDtH4F018187; Mon, 19 Apr 2021 09:55:17 -0400
Received: from localhost (mpatocka@localhost)
 by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP
 id 13JDtHQu018179; Mon, 19 Apr 2021 09:55:17 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka
 owned process doing -bs
Date: Mon, 19 Apr 2021 09:55:17 -0400 (EDT)
From: Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To: Damien Le Moal <Damien.LeMoal@wdc.com>
cc: "dm-devel@redhat.com" <dm-devel@redhat.com>,
 Mike Snitzer <snitzer@redhat.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Jens Axboe <axboe@kernel.dk>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Milan Broz <mbroz@redhat.com>
Subject: Re: [dm-devel] [PATCH v2 0/3] Fix dm-crypt zoned block device support
In-Reply-To: <BL0PR04MB65147D94E7E30C3E1063A282E7499@BL0PR04MB6514.namprd04.prod.outlook.com>
Message-ID: <alpine.LRH.2.02.2104190951070.17565@file01.intranet.prod.int.rdu2.redhat.com>
References: <20210417023323.852530-1-damien.lemoal@wdc.com>
 <alpine.LRH.2.02.2104190840310.9677@file01.intranet.prod.int.rdu2.redhat.com>
 <BL0PR04MB65147D94E7E30C3E1063A282E7499@BL0PR04MB6514.namprd04.prod.outlook.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210419_065529_876026_C7D36FE7 
X-CRM114-Status: GOOD (  21.47  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On Mon, 19 Apr 2021, Damien Le Moal wrote:

> > I would say that it is incompatible with all dm targets - even the linear 
> > target is changing the sector number and so it may redirect the write 
> > outside of the range specified in dm-table and cause corruption.
> 
> DM remapping of BIO sectors is zone compatible because target entries must be
> zone aligned. In the case of zone append, the BIO sector always point to the
> start sector of the target zone. DM sector remapping will remap that to another
> zone start as all zones are the same size. No issue here. We extensively use
> dm-linear for various test environment to reduce the size of the device tested
> (to speed up tests). I am confident there are no problems there.
> 
> > Instead of complicating device mapper with imperfect support, I would just 
> > disable REQ_OP_ZONE_APPEND on device mapper at all.
> 
> That was my initial approach, but for dm-crypt only since other targets that
> support zoned devices are fine. However, this breaks zoned block device
> requirement that zone append be supported so that users are presented with a
> uniform interface for different devices. So while simple to do, disabling zone
> append is far from ideal.

So, we could enable it for the linear target and disable for all other 
targets?

I talked with Milan about it and he doesn't want to add more bloat to the 
crypt target. I agree with him.

Mikulas


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
