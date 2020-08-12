Return-Path: <SRS0=KW74=BW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A967C433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Aug 2020 20:28:47 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB28A20781
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Aug 2020 20:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UlbzEpBJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Okp//CtX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB28A20781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=H5Ac7D2XAHxDjiqkC7bJB5m5XpvoyN4EoBGU/oLdaSo=; b=UlbzEpBJZpG2CfIOMlLYGItBL
	z60VHf6LvrT7d6MiKqZQvEJQyKffHz6e+CSq7WImTWZAO3Qh8vMbTQCVtxGrK2Ap1FpBeHidsdIrJ
	MotD+cL0Y9opOm/ZBQD0KVj0K04WNu2a2xhVY9GkbmYA4iNray3+AmHpB/FONVJl2RnXUhuuX6rCG
	C+Ds5wysYty+9tchAUGn1S41FJsLtwyeOAXEYjjgzoxEqrLUVKZE0oumr0jpyKa5IESWvYPH+W1ah
	luga0YDzES0Djr0Qm/LfVEoGPlp4aN/HbR2WzSaRMjQgz7/KnCFnh4NeBccnqFVaNVGuBQ7QwPs3y
	ecpWSZRkQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5xMW-0005Np-LA; Wed, 12 Aug 2020 20:28:40 +0000
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5xMV-0005N6-9C
 for linux-nvme@lists.infradead.org; Wed, 12 Aug 2020 20:28:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597264115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eJXYJZa0+jqjrR60z7t4R8Jwh4xDRotz1b/w46Emeyo=;
 b=Okp//CtXmifekOri3Yq5/rzg+y5jxsFaWF/r8J6MG9fXTgCjAAXlclgJwcW8Xegr/+cL0R
 47pQ9B5XQE/aH/S2vvCVpI97ebPafnab+UuKAGBUgpA/TCsS0DM5TexlpjqMwt0xn/Tc4t
 yoJAltbXK3xSY2XACxDikw/fcdRehYM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-554-N0dpFdX3Mkyf7NnFyJr_XA-1; Wed, 12 Aug 2020 16:28:33 -0400
X-MC-Unique: N0dpFdX3Mkyf7NnFyJr_XA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 427A181CAFA;
 Wed, 12 Aug 2020 20:28:32 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CD15519D71;
 Wed, 12 Aug 2020 20:28:30 +0000 (UTC)
Date: Wed, 12 Aug 2020 16:28:30 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/3] nvme-core: delete the dependency on blk status
Message-ID: <20200812202829.GA586@redhat.com>
References: <20200812081844.22224-1-lengchao@huawei.com>
 <20200812151035.GB29544@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200812151035.GB29544@lst.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200812_162839_371555_5EF470AF 
X-CRM114-Status: GOOD (  13.79  )
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
Cc: linux-block@vger.kernel.org, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, axboe@fb.com, Chao Leng <lengchao@huawei.com>,
 kbusch@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Aug 12 2020 at 11:10am -0400,
Christoph Hellwig <hch@lst.de> wrote:

> On Wed, Aug 12, 2020 at 04:18:44PM +0800, Chao Leng wrote:
> > nvme should not depend on blk status, just need check nvme status.
> > Just need do translating nvme status to blk status for returning error.
> 
> While this doesn't look wrong it also doesn't save us a single
> instruction and actually adds more lines of code.  Do you have a good
> reason for this change?

It certainly saves nvme_error_status(nvme_req(req)->status if
nvme_req_needs_retry().


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
