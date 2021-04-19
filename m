Return-Path: <SRS0=6U9w=JQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B227C433ED
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Apr 2021 12:53:21 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1FDA61003
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Apr 2021 12:53:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1FDA61003
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:In-Reply-To:
	Subject:cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Fp0o1F3C5HgETA4CAGeiM/W0LjumcffLyU/fn69KT9c=; b=ICzf540iUV7b7yGirEnaFpdoU
	Sr0RtmOWpSk5EFH3eGUdyWdKl4GpmbrvsX8/bSBoeJJSyyl4LaQl3x3JMvGPs4RYtXf/ujnHCfGjO
	fTYdKSo+4Y5V9nlKO/3ojmpP2YrRvRxPGNYWSvDRYTmLZOfI5i6Bc2at2zXOYpyLMViBXuVbFTq6P
	+lFpxaKVx5YQ3WyTig6nB4oVv6J16o0Tl792CE9jhbkbdZ4VrwJnRyTieNTlKEhgNFir6awzhRfoL
	nGEsbsCzoFemxrZ5dEqyjZKeCfvkBr0akNUIimDt4i7n1dVN/I8JIz21QQhkSwVsqv43gEfthy18v
	SDY+GMfBQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lYTOh-009t8H-0a; Mon, 19 Apr 2021 12:53:03 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYTOa-009t76-5H
 for linux-nvme@lists.infradead.org; Mon, 19 Apr 2021 12:53:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618836763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cMIsYl9JvtnAIFAwpGAulW8Mqzm/WRykKCV3iabQuYA=;
 b=WfFIggJGxHooR1OZLRQ8Gm+uz7ykzi42dNTzZiRuwH6koHqaFOygOSThCaqMZCJWmvixQk
 t4+jf+0au9L8RaY5Bfr89n9nwLzvGpvsKz/zFpwql2ype+W/KNDw2CYoUZIUg3xU2DwdNg
 s3zrMKUh6A+nzToI9Q46GV63TEhEjzg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618836773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cMIsYl9JvtnAIFAwpGAulW8Mqzm/WRykKCV3iabQuYA=;
 b=P1T3qNiMJF2e9b4LLusu4VnqmgIMWVm1yjAqfSER+LyT1J0HCdFlJ/EDWgkpzOkoAUV+CP
 dnSsjJ51FbOiZJGzQKV8eECzPwMi4lu8HcCkCeURbo2gQKMakftQVLSiLvV//VdpQrv668
 UuxYz1L1s6CsAZUDP3W8sFXzA61ZlqU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-XHAJf3tbOJG7OvIp5qe1Ig-1; Mon, 19 Apr 2021 08:52:41 -0400
X-MC-Unique: XHAJf3tbOJG7OvIp5qe1Ig-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C96011922025;
 Mon, 19 Apr 2021 12:52:39 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com
 (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0717A10016F4;
 Mon, 19 Apr 2021 12:52:32 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
 by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id
 13JCqW6V010975; Mon, 19 Apr 2021 08:52:32 -0400
Received: from localhost (mpatocka@localhost)
 by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP
 id 13JCqVuW010967; Mon, 19 Apr 2021 08:52:31 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka
 owned process doing -bs
Date: Mon, 19 Apr 2021 08:52:31 -0400 (EDT)
From: Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To: Damien Le Moal <damien.lemoal@wdc.com>
cc: dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
 linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-fsdevel@vger.kernel.org,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [dm-devel] [PATCH v2 0/3] Fix dm-crypt zoned block device support
In-Reply-To: <20210417023323.852530-1-damien.lemoal@wdc.com>
Message-ID: <alpine.LRH.2.02.2104190840310.9677@file01.intranet.prod.int.rdu2.redhat.com>
References: <20210417023323.852530-1-damien.lemoal@wdc.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210419_135256_534380_AD7C6527 
X-CRM114-Status: GOOD (  19.53  )
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



On Sat, 17 Apr 2021, Damien Le Moal wrote:

> Mike,
> 
> Zone append BIOs (REQ_OP_ZONE_APPEND) always specify the start sector
> of the zone to be written instead of the actual location sector to
> write. The write location is determined by the device and returned to
> the host upon completion of the operation.

I'd like to ask what's the reason for this semantics? Why can't users of 
the zoned device supply real sector numbers?

> This interface, while simple and efficient for writing into sequential
> zones of a zoned block device, is incompatible with the use of sector
> values to calculate a cypher block IV. All data written in a zone is
> encrypted using an IV calculated from the first sectors of the zone,
> but read operation will specify any sector within the zone, resulting
> in an IV mismatch between encryption and decryption. Reads fail in that
> case.

I would say that it is incompatible with all dm targets - even the linear 
target is changing the sector number and so it may redirect the write 
outside of the range specified in dm-table and cause corruption.

Instead of complicating device mapper with imperfect support, I would just 
disable REQ_OP_ZONE_APPEND on device mapper at all.

Mikulas


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
