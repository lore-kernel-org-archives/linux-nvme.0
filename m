Return-Path: <SRS0=/SuC=JR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A28AC433B4
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Apr 2021 14:18:20 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 583E3613B4
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Apr 2021 14:18:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 583E3613B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=JsltQKqqaPGL+igMAxhfvk+7jQXIrMctjEiu/8f8ZI4=; b=iGWeSj64+dLvq1mKBsca0k+4+
	5KhcHveogOXL7tcJeYUb1cb9BUsWwS5kqN+bC2XDu+H84QhlYZgH9N5zI9JT9LJr7FDHsJBccyxtn
	29Q8XpxrXSACvTL9DPOyWJwyRyrTtS8dE4bAXZE4p8sUqrdqTKXwQBDB068UmyYGKaBRox8LXMbyS
	fMCkyDyADUJk72Mu7328GPv3ZqFB8o87KKJdNnJXdti6M3pQsCjvoAkaU/j6mWyY672KxHDSUuWIc
	5xcAUMfHULhxw3mhTQrXC8uaFcEV39r3UcQSBbalLeyBt+KIPMhU0OtfPKExpF4cnXi9oZ4xlzHW5
	rC/qOltUA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lYrCG-00CJrL-VO; Tue, 20 Apr 2021 14:17:49 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYrCF-00CJqy-4d
 for linux-nvme@desiato.infradead.org; Tue, 20 Apr 2021 14:17:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=zMvyKj25gjB0oXytYH0t3C8VbQ+294kybBDKJCOZKyo=; b=qtIMrMQ6mNL8ushGijn3KqBPYo
 A+o0WFiorZL9jBgMp+X1gf306PMBENdzu3iZmr6a95x7kuggVXxexOSBW1rlHOl0yzbL91gGf0z81
 zKpYv1Jswd4L71b2yhUZYMVjgqXKblGlYXBK0U3dplhUCknAhIGi+72rSZ5XRImDF0nffX8UAkVHG
 HGS3YJ6p05eJBbT2W/NU0QVdup5joBd3snN4JzMJwNgy3LQ9ZX9vo2IhjbWW6vNFcPS1PUuxAnWqU
 kRsHVj7RMBDbncAN5sGsKCT1ao5BdZcsZXxD3o6ceOOv1fUVYtJBDoX8oDkuBOGJsTK9+P/HRc/sO
 TCj1v9Og==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYrC9-00CBaU-Gz
 for linux-nvme@lists.infradead.org; Tue, 20 Apr 2021 14:17:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618928260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zMvyKj25gjB0oXytYH0t3C8VbQ+294kybBDKJCOZKyo=;
 b=ivj/i+B9ncOuJffoENn3AP2ApXT8co+biWgScxXI+wiqYX3rO+w3R8/s9MTRVEBT080bZt
 0y8VrClXaTes1HX1U4rfVn4cJ+AaDGL/DkX8Wfj/SrmRjx9szqiZV4ZB3N4OAHOzNgsX9Q
 pq5+qK0SSUQLH6IlZT9u2J9yKrnF3SA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-SB2yQHMNNICkIdFP3lYE2w-1; Tue, 20 Apr 2021 10:17:36 -0400
X-MC-Unique: SB2yQHMNNICkIdFP3lYE2w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 58C6E10CE782;
 Tue, 20 Apr 2021 14:17:35 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 268A26061F;
 Tue, 20 Apr 2021 14:17:35 +0000 (UTC)
Date: Tue, 20 Apr 2021 10:17:34 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, dm-devel@redhat.com,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v4 3/3] nvme: decouple basic ANA log page re-read support
 from native multipathing
Message-ID: <20210420141734.GA14523@redhat.com>
References: <20210416235329.49234-1-snitzer@redhat.com>
 <20210416235329.49234-4-snitzer@redhat.com>
 <20210420093453.GB28625@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210420093453.GB28625@lst.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210420_071741_659077_F1787F90 
X-CRM114-Status: GOOD (  16.80  )
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

On Tue, Apr 20 2021 at  5:34am -0400,
Christoph Hellwig <hch@lst.de> wrote:

> On Fri, Apr 16, 2021 at 07:53:29PM -0400, Mike Snitzer wrote:
> > Whether or not ANA is present is a choice of the target implementation;
> > the host (and whether it supports multipathing) has _zero_ influence on
> > this. If the target declares a path as 'inaccessible' the path _is_
> > inaccessible to the host. As such, ANA support should be functional
> > even if native multipathing is not.

As you well know, ANA is decoupled from multipathing in the NVMe spec.
This fix illustrates that the existing Linux NVMe ANA handling is too
tightly coupled with native NVMe multipathing. Unfortunately, you've
forced this as a means to impose your political position:

> NAK.  nvme-multipathing is the only supported option for subsystems with
> multiple controllers.

And while this is largely irrelevant to the technical review of my fix:
native nvme-multipath may be the only supported option in your world. In
mine that isn't true and never has been.

Your political posturing doesn't replace technical justification. You
don't have a compelling technical case to take the stance you do, yet
you guard it like you do. Just a really stark inconsistency in your
technical leadership that is repeatedly left unchecked by others.

Alas.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
