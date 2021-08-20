Return-Path: <SRS0=THed=NL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CBD7C4338F
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Aug 2021 13:45:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B2C1610CC
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Aug 2021 13:45:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2B2C1610CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5LtXDLxSYF4e92vuaRyKso3V0V4czbUj0+wPMbbSNd0=; b=HmxKX+4orh4XQB
	Fo16hAyMou4DmEFdrsKEEfAA7KQf57YweXmIqcCvmPeUvAn+R+WBhqZ1kJZ1mxjEDk495TsVt/j6q
	9XTeLXvBYt3P1kga+J1FGpzsMPhbrojVAJwTrqiEdTpqjlMH+j2J07TkzyjpmGvXVKKyVIqzLBy1v
	AHqrsLdt8q3cNXw+Pz/7zz3TINJEGUOid42USwjHxkSWq+CgodfpUXnLHS3B8bOKLRO7IojqXywfY
	YvVNI/gTZD6IsLWA8PTxQowffwlkKkDu8YSYROI2Ums1UyDeY9c1xfMmwarYap9Cg6JhM1h2wtHln
	St8diPGlQKO/Or4rWU7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mH4pK-00BK1w-Py; Fri, 20 Aug 2021 13:44:54 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mH4pI-00BK12-BB
 for linux-nvme@lists.infradead.org; Fri, 20 Aug 2021 13:44:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629467090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a+ZiHy0S2JzjGTtry4ktJ98yuVUDhxplVu+BcUWdd38=;
 b=CcXCwajz8mWmteEy63fET0Xt0fRhxyL8tDRc0Kkwbx3bgABkQbwKRjpxGE5DvIWX/l1CGj
 7Ebl+srftwOk43KT42EtQv8R5sL9pgKlJejvNIfl3/1mFy0e1kl1oiKfYjwbff8CDPXUFk
 2iq2Yz/YFELuoORtA5UpNQtPDGBPxeE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-IPnf2KVKP76iHbEqplX-Sw-1; Fri, 20 Aug 2021 09:44:46 -0400
X-MC-Unique: IPnf2KVKP76iHbEqplX-Sw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C53F6192D785;
 Fri, 20 Aug 2021 13:44:44 +0000 (UTC)
Received: from T590 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D9D315D741;
 Fri, 20 Aug 2021 13:44:23 +0000 (UTC)
Date: Fri, 20 Aug 2021 21:42:58 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Stefan Haberland <sth@linux.ibm.com>,
 Jan Hoeppner <hoeppner@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Doug Gilbert <dgilbert@interlog.com>,
 Kai =?iso-8859-1?Q?M=E4kisara?= <Kai.Makisara@kolumbus.fi>,
 Luis Chamberlain <mcgrof@kernel.org>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, blankburian@uni-muenster.de
Subject: Re: [PATCH 8/9] block: hold a request_queue reference for the
 lifetime of struct gendisk
Message-ID: <YR+xYi3VX8MFilud@T590>
References: <20210816131910.615153-1-hch@lst.de>
 <20210816131910.615153-9-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210816131910.615153-9-hch@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210820_064452_489086_DB50252F 
X-CRM114-Status: GOOD (  15.53  )
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

On Mon, Aug 16, 2021 at 03:19:09PM +0200, Christoph Hellwig wrote:
> Acquire the queue ref dropped in disk_release in __blk_alloc_disk so any
> allocate gendisk always has a queue reference.

BTW, today Markus reported that request queue is released when the
disk is still live.

And looks it is triggered when running virtio-scsi hotplug from qemu
side, and the reason could be that we grab the request queue refcount
after disk is added to driver core, so there is small race window in
which the request queue is released before we grab it in __device_add_disk().

I guess this patch could fix the issue, but it is hard to verify
since it takes days to reproduce.


Thanks,
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
