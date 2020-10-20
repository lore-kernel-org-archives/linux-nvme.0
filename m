Return-Path: <SRS0=uU0g=D3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63651C433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Oct 2020 09:44:47 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4C25206DC
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Oct 2020 09:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ASSrmSeD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Euj2GW9Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4C25206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=qERZ2Q/ZJrQJ2JerS8NHVDZmklckf9jxyaAZCRVCkKo=; b=ASSrmSeDtcOlu7Orn33qyY01x
	IUustjZBhZ9R4SDeg/LnZjH8L2YiLKm/0zoUCAvM1Ky+pc8hPSuxhi4gQRVc63WUdvQ5Ftj1UNKm2
	1ae+R8tKMX4cPTyGzkJb+BsZAsr1+umkXbvhmyxByGxwh2Gf5UXNQHPSQPwYt34wJe3ev/dZ37Z2F
	AdGPI3Y7G38JrZxK6+HYM8AjnuAcFNMOebfOpedNJIcyfVemeZSAy32Yc5XZ8UD3KZ0mYAylfo6Qj
	m8daBPjP9lhxDmQYsOwg9z7RKZJefGfKu0HNKqC5HxEGZuCtQPIAOWsZwQJLFQpCFguQwVMgfCICN
	lvhCvBvIg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kUoC9-0002an-CL; Tue, 20 Oct 2020 09:44:41 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kUoC6-0002aF-QE
 for linux-nvme@lists.infradead.org; Tue, 20 Oct 2020 09:44:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603187078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QXYs6egZBi1dDPtBtWTXxsg0s20RzV1tfBLOiwQO35Y=;
 b=Euj2GW9ZsiOF8yqxfdoi21xpgXHtGgV1MPVo8hLLy0CtTvniH7fYTCIkFf8SrVcs8vrjzY
 8hxkmdIpHWXJ8BlWEUcFucVsYlZjdmR7A4HMMEEgxsWUHefl7ShX1JgsExzdiukaFAiDaz
 p1IwqKvZ8z77PAVldmyboDldjPEGLJQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17--q8sY-yOPza9jAQy6bEoYg-1; Tue, 20 Oct 2020 05:44:36 -0400
X-MC-Unique: -q8sY-yOPza9jAQy6bEoYg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 72549640AC;
 Tue, 20 Oct 2020 09:44:34 +0000 (UTC)
Received: from T590 (ovpn-12-164.pek2.redhat.com [10.72.12.164])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9D8856198C;
 Tue, 20 Oct 2020 09:44:24 +0000 (UTC)
Date: Tue, 20 Oct 2020 17:44:20 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 3/4] nvme: tcp: fix race between timeout and normal
 completion
Message-ID: <20201020094420.GD1429635@T590>
References: <20201016142811.1262214-1-ming.lei@redhat.com>
 <20201016142811.1262214-4-ming.lei@redhat.com>
 <e9d2e28e-fb55-358c-3e8c-6f3e9dd91c25@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e9d2e28e-fb55-358c-3e8c-6f3e9dd91c25@grimberg.me>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201020_054438_898652_BB4B2010 
X-CRM114-Status: GOOD (  16.82  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Yi Zhang <yi.zhang@redhat.com>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Chao Leng <lengchao@huawei.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Oct 20, 2020 at 01:11:11AM -0700, Sagi Grimberg wrote:
> 
> > NVMe TCP timeout handler allows to abort request directly when the
> > controller isn't in LIVE state. nvme_tcp_error_recovery() updates
> > controller state as RESETTING, and schedule reset work function. If
> > new timeout comes before the work function is called, the new timedout
> > request will be aborted directly, however at that time, the controller
> > isn't shut down yet, then timeout abort vs. normal completion race
> > will be triggered.
> 
> This assertion is incorrect, the before completing the request from
> the timeout handler, we call nvme_tcp_stop_queue, which guarantees upon
> return that no more completions will be seen from this queue.

OK, then looks the issue can be fixed by patch 1 & 2 only.

Yi, can you test again and see if the issue can be fixed by patch 1 & 2?


Thanks,
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
