Return-Path: <SRS0=rw3x=BR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B892C433DF
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 13:49:58 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C6AC221E2
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 13:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tBIeY67b";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hTE8TKGf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C6AC221E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=i44otb6WRVreQHKCdzuRhN4hW/Gl6zg49r0oH0dHdu0=; b=tBIeY67bIpa+2UIzkkrcQoha+
	snWhTNht8gcQIWhx4FYuCFwIg9bhag0t5fXJ5nqLnKocrD4GXkV45t8jmhOy3+Um91lkUPwgk48/t
	dDAPi7LNPG1rCxKwZy2D3Zb2CGHLwuGFOObZnzyeLVAi5iuHRkPFenBSVxEpGcGNp0jZZyTF5vSYA
	VOEJliMx0IXkMDI66ehCFeMPaslnNIvDJuzGK+EmLri3TDmev/k/XhWM+Qdqix1dVp3bcHvqIvCe2
	iclTEUzNipOwQC5OLDsS+2vpQ3numXQVmN/ytVtO7fTIsyqoYj24V44+xPvzFRyG79JEsnyESRf33
	MG+rLpiqw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k42kp-00045f-O7; Fri, 07 Aug 2020 13:49:51 +0000
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]
 helo=us-smtp-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k42km-00045H-Rb
 for linux-nvme@lists.infradead.org; Fri, 07 Aug 2020 13:49:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596808188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AxKhj+gkO/EgGki1oR3mHYFMo4D2Y/mcsgmgyosbzNM=;
 b=hTE8TKGfJ3cCjl7RH3X0ZiWAzGpsrlq42kPTRMBy88REisEvvSpI6NO4hGsR6Z48cT4G+d
 N7UprgvYPHe2xp7LFJ7nBs80yC1dzXhTKy8KnUM81iMNiolppdb1ZJM61Z5J88MPCs7AWN
 4N6grEIR8m68Xd3wRfAXN45Sj9oN0/0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-uNIENScWM26AP91v3UsCoQ-1; Fri, 07 Aug 2020 09:49:46 -0400
X-MC-Unique: uNIENScWM26AP91v3UsCoQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8301379EEC;
 Fri,  7 Aug 2020 13:49:44 +0000 (UTC)
Received: from T590 (ovpn-12-80.pek2.redhat.com [10.72.12.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 707876FEDC;
 Fri,  7 Aug 2020 13:49:37 +0000 (UTC)
Date: Fri, 7 Aug 2020 21:49:32 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Chao Leng <lengchao@huawei.com>
Subject: Re: [PATCH v2 0/3] reduce quiesce time for lots of name spaces
Message-ID: <20200807134932.GA2122627@T590>
References: <20200807090559.29582-1-lengchao@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200807090559.29582-1-lengchao@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200807_094948_983158_0E0A13DE 
X-CRM114-Status: GOOD (  11.64  )
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
Cc: axboe@fb.com, sagi@grimberg.me, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, kbusch@kernel.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Aug 07, 2020 at 05:05:59PM +0800, Chao Leng wrote:
> nvme_stop_queues quiesce queues for all name spaces, now quiesce one by
> one, if there is lots of name spaces, sync wait long time(more than 10s).
> Multipath can not fail over to retry quickly, cause io pause long time.
> This is not expected.
> To reduce quiesce time, we introduce async mechanism for sync SRCUs
> and quiesce queue.
> 

Frankly speaking, I prefer to replace SRCU with percpu_refcount:

- percpu_refcount has much less memory footprint than SRCU, so we can simply
move percpu_refcount into request_queue, instead of adding more bytes
into each hctx by this patch

- percpu_ref_get()/percpu_ref_put() isn't slower than srcu_read_lock()/srcu_read_unlock().

- with percpu_refcount, we can remove 'srcu_idx' from hctx_lock/hctx_unlock()

Thanks,
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
