Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3C20E77188
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jan 2025 00:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B2ow3WPU9nS00Hk+pQzwgzy+yTO/847uxs0UlW6oZME=; b=x4/djDDMBh0mLNRZZrqpQAcdI3
	KxzWd59IBQSCevDZcUAbAhKYpUTDqm7igkecIirsuUSaDc3McqmDc2ej4fmujLAkNNPDOrI5wuWs+
	pfXHDJjv0pjZJxiUnuhUzbTyUiImMc9Ji5fOMS5dHflw3PFceSJmi4m4BxrIBdsSHAp3JkZ5eUDd1
	TeZazwEfwaxfhUO7VkyT3u1A2Cmmnhw2WfGBftZ2wyowceDPJXYJXok/QCgBdi7zwmmHDuD7wzEjl
	ESzq5/n/bxzDAmvHn+8bIMfyfk8i/kmHg+ZDtsplOuenK6E1GgUwIQgX8ki2BYlNEeqcuyesapJeQ
	DkCtAVqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tUxiy-0000000343B-11k4;
	Tue, 07 Jan 2025 00:45:36 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tUxit-0000000342P-0R2v
	for linux-nvme@lists.infradead.org;
	Tue, 07 Jan 2025 00:45:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736210729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B2ow3WPU9nS00Hk+pQzwgzy+yTO/847uxs0UlW6oZME=;
	b=FAxPdJ1LOV1uGkteecqxt8PkYnCrxxYb1q1oyRKhzqFP1BXvRPYqgUq59U1QxLzWFZPTbX
	yeXdWnH/HK2O3Pc0E+r9Blk5rFVJRvlqEQialAbmPmdQKlJP0iqVq8IVAbd/9PPqTFnNKF
	p8RGyOIgRDmRcKuZ/s+ihQGK4xi2Clw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-487-57ER_xUgNEOOYM1u31EC0g-1; Mon,
 06 Jan 2025 19:45:26 -0500
X-MC-Unique: 57ER_xUgNEOOYM1u31EC0g-1
X-Mimecast-MFC-AGG-ID: 57ER_xUgNEOOYM1u31EC0g
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AEC8919560B2;
	Tue,  7 Jan 2025 00:45:23 +0000 (UTC)
Received: from fedora (unknown [10.72.116.43])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AC74519560A2;
	Tue,  7 Jan 2025 00:45:17 +0000 (UTC)
Date: Tue, 7 Jan 2025 08:45:11 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>
Subject: Re: [PATCH 1/3] block: Fix sysfs queue freeze and limits lock order
Message-ID: <Z3x5F3_GIkD4sxl7@fedora>
References: <20250104132522.247376-1-dlemoal@kernel.org>
 <20250104132522.247376-2-dlemoal@kernel.org>
 <Z3tOn4C5i096owJc@fedora>
 <20250106082902.GC18408@lst.de>
 <Z3u7Twc4UPWvlfJJ@fedora>
 <20250106152931.GC27431@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250106152931.GC27431@lst.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250106_164531_229008_DD60FF33 
X-CRM114-Status: GOOD (  21.33  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Jan 06, 2025 at 04:29:31PM +0100, Christoph Hellwig wrote:
> On Mon, Jan 06, 2025 at 07:15:27PM +0800, Ming Lei wrote:
> > On Mon, Jan 06, 2025 at 09:29:02AM +0100, Christoph Hellwig wrote:
> > > On Mon, Jan 06, 2025 at 11:31:43AM +0800, Ming Lei wrote:
> > > > As I mentioned in another thread, freezing queue may not be needed in
> > > > ->store(), so let's discuss and confirm if it is needed here first.
> > > > 
> > > > https://lore.kernel.org/linux-block/Z3tHozKiUqWr7gjO@fedora/
> > > 
> > > We do need the freezing.  What you're proposing is playing fast and loose
> > > which is going to get us in trouble.
> > 
> > It is just soft update from sysfs interface, and both the old and new limits
> > are correct from device viewpoint.
> > 
> > What is the trouble? We have run the .store() code without freezing for
> > more than 10 years, no one report issue in the area.
> 
> No, we had various bug reports due to it, including racing with other
> updates.  Let's stop trying to take shortcuts that will byte us again
> later and sort this out properly.

Can you share the bug reports? I am curious how it happen.


Thanks, 
Ming


