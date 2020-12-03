Return-Path: <SRS0=Kbn9=FH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A90C6369E
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Dec 2020 00:51:06 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18E92221F7
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Dec 2020 00:51:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18E92221F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ftEuRLPYG3Zev6nKgcpzH9YAEtd1+c28ZNjp+sLUNDc=; b=RFndJwrIK5GJpREE6Jf3kduMe
	LCD0oKuSbDEXZnuklyqzJWw7Uw3hXjvzrDtZdeUbQy0uFqGOLMwweGpfWZan9un00sDDgvqUF7Kyb
	dfP1dS5hMy9Z9eU/3/twUCa9a66EJOVHqhcNgoh3rT/r0X7/NZ8xPhy2vklTf9WgJxgOEAKy+WCXD
	7g3bVDZQWmQEVEq4J3MwSZraOspAwxvmxwCiZr+tgWOX4EzTBa7+iTumz1kZ+PqE5/O/DfxvKljED
	giwFFz/9KTUdxaeWm9ff9xxo2ntj51hqQmph/YW6bDrAv+BGDMmSm8SBZ+OMOHcP2BaFq1IX9cerz
	o/vkeS/Kg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kkcpm-0001YV-UR; Thu, 03 Dec 2020 00:50:58 +0000
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kkcph-0001Y5-If
 for linux-nvme@lists.infradead.org; Thu, 03 Dec 2020 00:50:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606956652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DRUzegjIlcBkY7wWtZr/BEsqwEEPB0u0Zdc6QykZL38=;
 b=Xq8GGVv9xZxkkNnMBw80ygSo3j69ST6sfZh5gnXdfiYFEi/33r9JiYmoT4MGJS7VS4dk/Z
 AJnyzrZ/FuHXuAguQ80mYn/xSqE7V3Vjnpey9zsGcpe7+M7js/ROuGl3YtThq/xt1c1PyJ
 hPf4NdZw9P8pbm8IKuaIhGdGgS9+15k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-14TkWJ0XPBeI6k_Y0kducA-1; Wed, 02 Dec 2020 19:50:49 -0500
X-MC-Unique: 14TkWJ0XPBeI6k_Y0kducA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A2E518C8C00;
 Thu,  3 Dec 2020 00:50:48 +0000 (UTC)
Received: from T590 (ovpn-12-87.pek2.redhat.com [10.72.12.87])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C712F5C1B4;
 Thu,  3 Dec 2020 00:50:39 +0000 (UTC)
Date: Thu, 3 Dec 2020 08:50:35 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Qian Cai <qcai@redhat.com>
Subject: Re: [PATCH 0/3] blk-mq/nvme-loop: use nvme-loop's lock class for
 addressing lockdep false positive warning
Message-ID: <20201203005035.GA540033@T590>
References: <20201112075526.947079-1-ming.lei@redhat.com>
 <20201130023606.GC230145@T590>
 <b70f46b855858a28b0e77ee7efbb2dbffbb56490.camel@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b70f46b855858a28b0e77ee7efbb2dbffbb56490.camel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201202_195053_651671_B9427D42 
X-CRM114-Status: GOOD (  14.51  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
 John Garry <john.garry@huawei.com>, linux-nvme@lists.infradead.org,
 Kashyap Desai <kashyap.desai@broadcom.com>, linux-block@vger.kernel.org,
 Sumit Saxena <sumit.saxena@broadcom.com>, Hannes Reinecke <hare@suse.de>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Dec 02, 2020 at 02:07:08PM -0500, Qian Cai wrote:
> On Mon, 2020-11-30 at 10:36 +0800, Ming Lei wrote:
> > Any chance to take a look? And this issue has been reported several
> > times in RH internal test.
> 
> I suppose that you will need to rebase as it does not apply cleanly on today's
> linux-next.
> 

I just apply the three patches against for-5.11/block, and they can be
done cleanly.


Thanks,
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
