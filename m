Return-Path: <SRS0=3vHZ=KJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D964BC433ED
	for <linux-nvme@archiver.kernel.org>; Fri, 14 May 2021 09:44:28 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5607F6140E
	for <linux-nvme@archiver.kernel.org>; Fri, 14 May 2021 09:44:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5607F6140E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:In-Reply-To:
	Subject:cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=xKn8ITTvGEEjxiXtd2Xgy10ixcNouRhr8B3O/ZC2+io=; b=lii3V5rqZWmJDmqcf7WOZsOPb
	qQuXeo1+2KeZTPrJohNFrjk+lCmse8gwbquY+aaZWfNrsZJwyrJi85HGTt5BXYX5glcsLBqlbgGT/
	yoT6bfqhK11+UVpGJx2t0RwuKgczxBO97eYyw1NIxXxN5/6tZIh50r0FeP9jgpcujZe21hPIKyM08
	yBIKDkhnNsLHLNdgJ6ecqnvT7VOJTJg6xl+ethd4fIida3olFVFhF2nMINNrGKNpqc2SSE+VNqFQb
	DAlEXjbQQDIbkrB1KRfTIDElOH1hnrIpMylwiN3hHafT+SlQSW38WDsYjJviLg+N+cO+qzH5fEq1b
	XrRKfk+Dw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lhUMY-007fjV-J7; Fri, 14 May 2021 09:44:06 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhUMU-007fjI-TT
 for linux-nvme@desiato.infradead.org; Fri, 14 May 2021 09:44:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:References:
 Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=05Af3bVZXrGJRy2+GfagSd6JI7OZwal3JL9/7JcdoT8=; b=NpCqdpjHTVu1HLpV9CyV4jJZhl
 E8Z9+Uvli2hQKvzq62goHrwp2UdOf9WXUxUT3q9k4oXyEyQbQ8aCBaCNZ+CcXWBfmo1uGWHYtrec2
 zAqP2YeDgSSeeeAICwBWK9caW1MsfSB/OiBBZ0kMIpbn6eA4nzD2EkL4+TvODen6jMTnd59V7kR2S
 gWe728hoShQL8iArZDC4OXOQ5Gj1dhLv1BnYstWTVcurgefbWdkpg60m9y1Ad8TYlWdZlqzZjsiYo
 /XEqUd0FgxMOPUGf00MIgIjOLGTI7UGTqj1IJfjVn04jwhabodmWWYsLG+GNoCiHOYRKnl6DfrWv8
 z9LLL/PA==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhUMS-00Bs5u-Ai
 for linux-nvme@lists.infradead.org; Fri, 14 May 2021 09:44:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620985435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=05Af3bVZXrGJRy2+GfagSd6JI7OZwal3JL9/7JcdoT8=;
 b=KvUmXo/qNh+Kh536ftgGLcl+OcTc7bh++Pl05Vzls1sOEr8P01QwTdrTdEcJFm7mbWQ0Tl
 8uxJSitqx8zlrKHkDlB3Wcx1fVKW0XjiPLncYHUjDlaHhY8qukbao5rStcymepZccThky9
 UjuamteRC5xQYzxFwnIZkL5OBSvDMNA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-WqmhRHU7PHCcJPYyjHCMaA-1; Fri, 14 May 2021 05:43:52 -0400
X-MC-Unique: WqmhRHU7PHCcJPYyjHCMaA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 203D61007480;
 Fri, 14 May 2021 09:43:50 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com
 (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A507F1971B;
 Fri, 14 May 2021 09:43:39 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
 by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id
 14E9hd7S022799; Fri, 14 May 2021 05:43:39 -0400
Received: from localhost (mpatocka@localhost)
 by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP
 id 14E9haED022795; Fri, 14 May 2021 05:43:36 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka
 owned process doing -bs
Date: Fri, 14 May 2021 05:43:36 -0400 (EDT)
From: Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To: Bart Van Assche <bvanassche@acm.org>
cc: Milan Broz <gmazyland@gmail.com>, "Theodore Ts'o" <tytso@mit.edu>,
 Changheun Lee <nanich.lee@samsung.com>, alex_y_xu@yahoo.ca,
 axboe@kernel.dk, bgoncalv@redhat.com, dm-crypt@saout.de, hch@lst.de,
 jaegeuk@kernel.org, linux-block@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, ming.lei@redhat.com,
 yi.zhang@redhat.com, dm-devel@redhat.com
Subject: Re: regression: data corruption with ext4 on LUKS on nvme with
 torvalds master
In-Reply-To: <fdee795d-7a4b-9506-b9ca-359b9bcbec34@acm.org>
Message-ID: <alpine.LRH.2.02.2105140514560.20018@file01.intranet.prod.int.rdu2.redhat.com>
References: <a01ab479-69e8-9395-7d24-9de1eec28aff@acm.org>
 <0e7b0b6e-e78c-f22d-af8d-d7bdcb597bea@gmail.com>
 <alpine.LRH.2.02.2105131510330.21927@file01.intranet.prod.int.rdu2.redhat.com>
 <fdee795d-7a4b-9506-b9ca-359b9bcbec34@acm.org>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210514_024400_463334_47CB63EF 
X-CRM114-Status: GOOD (  19.32  )
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



On Thu, 13 May 2021, Bart Van Assche wrote:

> On 5/13/21 12:22 PM, Mikulas Patocka wrote:
> > We already had problems with too large bios in dm-crypt and we fixed it by 
> > adding this piece of code:
> > 
> >         /*
> >          * Check if bio is too large, split as needed.
> >          */
> >         if (unlikely(bio->bi_iter.bi_size > (BIO_MAX_VECS << PAGE_SHIFT)) &&
> >             (bio_data_dir(bio) == WRITE || cc->on_disk_tag_size))
> >                 dm_accept_partial_bio(bio, ((BIO_MAX_VECS << PAGE_SHIFT) >> SECTOR_SHIFT));
> > 
> > It will ask the device mapper to split the bio if it is too large. So, 
> > crypt_alloc_buffer can't receive a bio that is larger than BIO_MAX_VECS << 
> > PAGE_SHIFT.
> 
> Hi Mikulas,
> 
> Are you perhaps referring to commit 4e870e948fba ("dm crypt: fix error
> with too large bios")? Did that commit go upstream before multi-page
> bvec support?

Yes. It's from 2016.

> Can larger bios be supported in case of two or more
> contiguous pages now that multi-page bvec support is upstream?

No - we need to allocate a buffer for the written data. The buffer size is 
limited to PAGE_SIZE * BIO_MAX_VECS.

> Thanks,
> 
> Bart.

Mikulas


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
