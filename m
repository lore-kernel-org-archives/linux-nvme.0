Return-Path: <SRS0=xhFb=KI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0353C433B4
	for <linux-nvme@archiver.kernel.org>; Thu, 13 May 2021 19:23:55 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EEE260232
	for <linux-nvme@archiver.kernel.org>; Thu, 13 May 2021 19:23:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EEE260232
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:In-Reply-To:
	Subject:cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=m0hL/N4smP6nIxDFexb8D9vOO5rzlSpmhawQVLpcRhE=; b=m4FBDrW1Wf6gY0DS7zjDmuCm+
	Xl8CVMGKh3Tc2Uh5L9+4hS3zNdGwtb6vh30qaI3hUUQ8OW82uXM7kDE0yrYj9ERdO4HOFsMTvYKlo
	ywRpuBeL+ai6HaiLzmFVCNeSvx2cE2/m1HvOQWAuIDu+jOde9tOdZOLXahoFPtnTisloWfy+n2o3r
	dyWA4RfL9fkYPuTlCPpJ3qTrMPZX/gnhvQMWLSumPeE6Jm857PIvACo7n1PUWfFiqJibcl+3312M6
	sN6bEw2ZT2112Ap8DaqbVNZ6Lj/1Qo5OBIetA5t01vUrqjZUjPcbzvYVZfan2OL/VBUxD1OJFJUcc
	6+f7DFmhg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lhGvX-006GEr-BG; Thu, 13 May 2021 19:23:19 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhGv6-006GDX-E0
 for linux-nvme@desiato.infradead.org; Thu, 13 May 2021 19:22:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:References:
 Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=UChYrtJTiYVZT+Wv2GpTYs4oyHUTct1kWqfb8kWb1Kc=; b=EjLDB/UkwENZIoX4NevbixliR0
 QJhlZtg4ontO2PTHvQ/dI8HRt3m3hqI9nGwSbQi3P1tF31qTpYrr92F9v1SplC/IKPfGiGxJjDDJC
 5Z0iTTIKtsZgqrpc1OCWdBH284DLUc2UN3jxg+l9VwN8tkV4HYQgrxQ3YtQKI4GLmzrYbi+7MZ+Z5
 8+5Osuh3KaliWffvLHqMCHYgfStALH4ve1lJC39zkLnzHQPg8uptmqy21oMYqRbKALHb6cfMfb4fc
 LD1E7DqFsPHKe8KlCdkL7E4v6JPXcdDij81h0QPXAHE1RH40lMJK03KXLjVL96eettHkgW+R+a0hG
 z2frSjQQ==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhGv3-00BTRy-8C
 for linux-nvme@lists.infradead.org; Thu, 13 May 2021 19:22:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620933765;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UChYrtJTiYVZT+Wv2GpTYs4oyHUTct1kWqfb8kWb1Kc=;
 b=KcKwkTfTPLd5qQso4iOoIGQ6o8i/cYLVYgSE0Qx0VEcJ+zL4ZcDcaV5RkURErm9y3mpIl2
 e+jb+59bvh6wv1IR0KvdgoBi8URpENcCsq/EQp8qbwnpzv6pTHRgH7svbUzxI2V/9PeLPS
 RcaWNBbPy7YwGTCy8Y6EAQWSqpFOyCc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-oFdgpTWIM7yVaYjq-cClig-1; Thu, 13 May 2021 15:22:44 -0400
X-MC-Unique: oFdgpTWIM7yVaYjq-cClig-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE173CC623;
 Thu, 13 May 2021 19:22:40 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com
 (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D2EAF19172;
 Thu, 13 May 2021 19:22:29 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
 by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id
 14DJMTP4022674; Thu, 13 May 2021 15:22:29 -0400
Received: from localhost (mpatocka@localhost)
 by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP
 id 14DJMPNw022669; Thu, 13 May 2021 15:22:25 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka
 owned process doing -bs
Date: Thu, 13 May 2021 15:22:25 -0400 (EDT)
From: Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To: Milan Broz <gmazyland@gmail.com>, Bart Van Assche <bvanassche@acm.org>,
 "Theodore Ts'o" <tytso@mit.edu>, Changheun Lee <nanich.lee@samsung.com>
cc: alex_y_xu@yahoo.ca, axboe@kernel.dk, bgoncalv@redhat.com,
 dm-crypt@saout.de, hch@lst.de, jaegeuk@kernel.org,
 linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 ming.lei@redhat.com, yi.zhang@redhat.com, dm-devel@redhat.com
Subject: Re: regression: data corruption with ext4 on LUKS on nvme with
 torvalds master
In-Reply-To: <0e7b0b6e-e78c-f22d-af8d-d7bdcb597bea@gmail.com>
Message-ID: <alpine.LRH.2.02.2105131510330.21927@file01.intranet.prod.int.rdu2.redhat.com>
References: <a01ab479-69e8-9395-7d24-9de1eec28aff@acm.org>
 <0e7b0b6e-e78c-f22d-af8d-d7bdcb597bea@gmail.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210513_122249_387847_C7C65199 
X-CRM114-Status: GOOD (  35.07  )
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



> On 5/13/21 7:15 AM, Theodore Ts'o wrote:
> > On Thu, May 13, 2021 at 06:42:22PM +0900, Changheun Lee wrote:
> >>
> >> Problem might be casued by exhausting of memory. And memory exhausting
> >> would be caused by setting of small bio_max_size. Actually it was not
> >> reproduced in my VM environment at first. But, I reproduced same problem
> >> when bio_max_size is set with 8KB forced. Too many bio allocation would
> >> be occurred by setting of 8KB bio_max_size.
> > 
> > Hmm... I'm not sure how to align your diagnosis with the symptoms in
> > the bug report.  If we were limited by memory, that should slow down
> > the I/O, but we should still be making forward progress, no?  And a
> > forced reboot should not result in data corruption, unless maybe there
> > was a missing check for a failed memory allocation, causing data to be
> > written to the wrong location, a missing error check leading to the
> > block or file system layer not noticing that a write had failed
> > (although again, memory exhaustion should not lead to failed writes;
> > it might slow us down, sure, but if writes are being failed, something
> > is Badly Going Wrong --- things like writes to the swap device or
> > writes by the page cleaner must succeed, or else Things Would Go Bad
> > In A Hurry).
> 
> After the LUKS data corruption issue was reported I decided to take a
> look at the dm-crypt code. In that code I found the following:
> 
> static void clone_init(struct dm_crypt_io *io, struct bio *clone)
> {
> 	struct crypt_config *cc = io->cc;
> 
> 	clone->bi_private = io;
> 	clone->bi_end_io  = crypt_endio;
> 	bio_set_dev(clone, cc->dev->bdev);
> 	clone->bi_opf	  = io->base_bio->bi_opf;
> }
> [ ... ]
> static struct bio *crypt_alloc_buffer(struct dm_crypt_io *io, unsigned size)
> {
> 	[ ... ]
> 	clone = bio_alloc_bioset(GFP_NOIO, nr_iovecs, &cc->bs);
> 	[ ... ]
> 	clone_init(io, clone);
> 	[ ... ]
> 	for (i = 0; i < nr_iovecs; i++) {
> 		[ ... ]
> 		bio_add_page(clone, page, len, 0);
> 
> 		remaining_size -= len;
> 	}
> 	[ ... ]
> }
> 
> My interpretation is that crypt_alloc_buffer() allocates a bio,
> associates it with the underlying device and clones a bio. The input bio
> may have a size up to UINT_MAX while the new limit for the size of the
> cloned bio is max_sectors * 512. That causes bio_add_page() to fail if
> the input bio is larger than max_sectors * 512, hence the data
> corruption. Please note that this is a guess only and that I'm not
> familiar with the dm-crypt code.
> 
> Bart.

We already had problems with too large bios in dm-crypt and we fixed it by 
adding this piece of code:

        /*
         * Check if bio is too large, split as needed.
         */
        if (unlikely(bio->bi_iter.bi_size > (BIO_MAX_VECS << PAGE_SHIFT)) &&
            (bio_data_dir(bio) == WRITE || cc->on_disk_tag_size))
                dm_accept_partial_bio(bio, ((BIO_MAX_VECS << PAGE_SHIFT) >> SECTOR_SHIFT));

It will ask the device mapper to split the bio if it is too large. So, 
crypt_alloc_buffer can't receive a bio that is larger than BIO_MAX_VECS << 
PAGE_SHIFT.

Mikulas


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
