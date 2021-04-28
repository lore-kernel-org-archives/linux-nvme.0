Return-Path: <SRS0=oNUT=JZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 798EDC433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Apr 2021 06:42:26 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFF6D600CC
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Apr 2021 06:42:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFF6D600CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Date:Cc:To:From:
	Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=kexOZRZNwoIH3N3m5bf0FlfIWRDaiiTRaZP5qtU+cSQ=; b=ONPiBDjCMc3uRsU0Fghni1sNd
	7D1n4RiHWlQmPU33qQasQfPgEoS+YpK/F2T2i5WtlJP+6neJwN/uve59hOPtIdNkevlUk0sxr7MBz
	c5pIBLe4j2qg7LXsR2OwI+hXJAX1KpHmq5z+vyvpixD9xZvV0iYK18lqMtULcgd1g5PpaBC9121Ql
	a0xb0s9NlM0SuNghPcwsdmfzaZQGbdlAV3/px9XekyJDrvn/CZdJ5JQMCothhsmULk2iS7cmpEUpP
	hWNJo4Dn2w3nFbzFfPU/Kjvnd7iOIgfyLYmCAaGneUA8b0SKHk18x5fa2Qih6y4fiQwuXnAE4IaJ8
	/+EFKmM+w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lbdtY-002wkZ-1l; Wed, 28 Apr 2021 06:42:02 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbdtU-002wkJ-Lq
 for linux-nvme@desiato.infradead.org; Wed, 28 Apr 2021 06:41:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:
 Message-ID:Sender:Reply-To:Content-ID:Content-Description;
 bh=F4FdOvCubsbTBu0KqUq1Ap6WR++r5iCZVkQWHkrgDOA=; b=TmRsD+/qBpxmu8BeBveFrMktR7
 bjZYoNm3PAboavoLw1vmwQw4H4yPJMIZLWbzbZZTJUndbZ4aV6hETDZUokVNGx/LOJSJWlrAMoQJc
 6axYbnTY6caFi1esuikZ5UCH4KloZg7bWWohaXNm+QMLCg/Wse2Ia3JakDxMzrjwxSLU/8JcYdaXw
 gNJjOwzxnaEXRy8mx5KBuwTpasbDuTL8EdaaqGGRMLGqK4L9mlOK/iA445ztE8e9SmXtaAWjJxrfX
 2P8DEcKkaBdKRwccF0paWXL30SW+157G5mVlG1UtMFswHlfDWfj4lVKuUU6lpkfSYyJho6w3Gi86i
 oR+ad35w==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbdtR-00HDj0-P4
 for linux-nvme@lists.infradead.org; Wed, 28 Apr 2021 06:41:55 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1619592112; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F4FdOvCubsbTBu0KqUq1Ap6WR++r5iCZVkQWHkrgDOA=;
 b=UV+kK7XOCBtVHI03BLSjo05mgzHXeN3AyB+HoLxIYLQ7XS9hPW8Y8qgWhAaWdz+/Y/+k+I
 RhbYYoITRNflKs8WuzdPxupwQes3MZh2NrVGSg/210J+1pNiNyJaO+4H8bnQw12bf8HkRb
 BzQBYb3c5K8uB9B9H01j2t4YfNsHE7Q=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 45208B0B6;
 Wed, 28 Apr 2021 06:41:52 +0000 (UTC)
Message-ID: <cc1236b8edab5010ef214cd59753907604302109.camel@suse.com>
Subject: Re: [PATCH v3] nvme: rdma/tcp: fix list corruption with anatt timer
From: Martin Wilck <mwilck@suse.com>
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, Chao
 Leng <lengchao@huawei.com>, Daniel Wagner <dwagner@suse.de>,
 linux-nvme@lists.infradead.org,  stable@vger.kernel.org
Date: Wed, 28 Apr 2021 08:41:51 +0200
In-Reply-To: <8b61d0f8-f47f-8e03-5385-c48b0e7be187@suse.de>
References: <20210427085246.13728-1-mwilck@suse.com>
 <0ff2dbc0-0182-f54d-b750-084feac53601@suse.de>
 <20210427162521.GA26528@lst.de>
 <f82b7f7c-ef12-27bb-1349-d23ea22e50a9@suse.de>
 <3a0b10f45ac75df3f744dd04ac874021488f42b1.camel@suse.com>
 <8b61d0f8-f47f-8e03-5385-c48b0e7be187@suse.de>
User-Agent: Evolution 3.38.4 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210427_234153_995577_78DBB609 
X-CRM114-Status: GOOD (  30.95  )
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

On Wed, 2021-04-28 at 08:35 +0200, Hannes Reinecke wrote:
> On 4/27/21 9:54 PM, Martin Wilck wrote:
> > On Tue, 2021-04-27 at 20:05 +0200, Hannes Reinecke wrote:
> > > On 4/27/21 6:25 PM, Christoph Hellwig wrote:
> > > > On Tue, Apr 27, 2021 at 11:33:04AM +0200, Hannes Reinecke
> > > > wrote:
> > > > > As indicated in my previous mail, please change the
> > > > > description.
> > > > > We have
> > > > > since established a actual reason (duplicate calls to
> > > > > add_timer()), so
> > > > > please list it here.
> > > > 
> > > > So what happens if the offending add_timer is changed to
> > > > mod_timer?
> > > > 
> > > I guess that should be fine, as the boilerplate said it can act
> > > as a safe version of add_timer.
> > > 
> > > But that would just solve the crash upon add_timer().
> > 
> > The code doesn't use add_timer(), only mod_timer() and
> > del_timer_sync(). And we didn't observe a crash upon add_timer().
> > What
> > we observed was that a timer had been enqueued multiple times, and
> > the
> > kernel crashes in expire_timers()->detach_timer(), when it
> > encounters
> > an already detached entry in the timer list.
> > 
> nvme_mpath_init() doesn't use add_timer, but it uses timer_setup().

Yes. The notion that this is wrong was the idea behind my patch.

> And
> calling that on an already pending timer is even worse :-)
> 
> And my point is that the anatt timer is not stopped at the end of
> nvme_init_identify() if any of the calls to
> 
> nvme_configure_apst()
> nvme_configure_timestamp()
> nvme_configure_directives()
> nvme_configure_acre()
> 
> returns with an error. If they do the controller is reset, causing
> eg nvme_tcp_configure_admin_queue() to be called, which will be
> calling timer_setup() with the original timer still running.
> If the (original) timer triggers _after_ that time we have the crash.

You are right. But afaics the problem doesn't have to originate in
these 4 function calls. The same applies even after
nvme_init_identify() has returned. Any error that would trigger the
error recovery work after the anatt timer has started would have this
effect.

Regards,
Martin



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
