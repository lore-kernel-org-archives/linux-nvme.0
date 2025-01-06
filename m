Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BE23E77188
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jan 2025 12:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lEgqGUmmdHlI+KexeqkKfc5uGqdJkewykFHtwS7IbqQ=; b=kmHzwKMlzsVVksilgycCDVALW3
	UcqzGqnnJm45slTNS+5OeMF78DR8w2cw8IN2Nhk5TClw11VMMDi8AvGLtPPd+VYjDPx5R+ToBETii
	BBUnC71KFl7w1IpTzarf++aKFZNhItqbotWGUasgh4QyFMeNumraOq8BLC76vy+UT+1Z+SZYCUl7K
	oSux8YOhTB0IHwQAFP66mH5E2IziWQWOs5ZZD5rVcwhcYCBYnh3VwAevybIxFMkrKO32q2ZkZP5qt
	NZ67gZVKqwJFOo36Wl6dOHG08buLjg8wmG2hLwvslFAmf17f+QJJCcx8dbxlbOatnlKPAvC7+T8W/
	o4ZfgAaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tUm7A-00000001CFW-0qy5;
	Mon, 06 Jan 2025 12:21:48 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tUl5E-000000010WV-0psI
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jan 2025 11:15:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736162143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lEgqGUmmdHlI+KexeqkKfc5uGqdJkewykFHtwS7IbqQ=;
	b=Lr1iDgWSenrmgoKuHk5vjKrS8o6BS2/8fDikWoXIReIfaAnMCkLSo9XsbMkxbaT+GgvGfr
	85bixVpm4DepuH44yP8UUJBxALy/Hq/8gOncaPb5mt84Kzz0KOGLf6lGuN0QAmEOqzB7pp
	Zn9ewts0Q3CzPN2ULqJq1TTVLpHt+dc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-277-ramjuIovO8u7SQJZqBradQ-1; Mon,
 06 Jan 2025 06:15:39 -0500
X-MC-Unique: ramjuIovO8u7SQJZqBradQ-1
X-Mimecast-MFC-AGG-ID: ramjuIovO8u7SQJZqBradQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2D39319560A2;
	Mon,  6 Jan 2025 11:15:38 +0000 (UTC)
Received: from fedora (unknown [10.72.116.180])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B979D195608A;
	Mon,  6 Jan 2025 11:15:32 +0000 (UTC)
Date: Mon, 6 Jan 2025 19:15:27 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>
Subject: Re: [PATCH 1/3] block: Fix sysfs queue freeze and limits lock order
Message-ID: <Z3u7Twc4UPWvlfJJ@fedora>
References: <20250104132522.247376-1-dlemoal@kernel.org>
 <20250104132522.247376-2-dlemoal@kernel.org>
 <Z3tOn4C5i096owJc@fedora>
 <20250106082902.GC18408@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250106082902.GC18408@lst.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250106_031544_317376_188745D1 
X-CRM114-Status: GOOD (  18.09  )
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

On Mon, Jan 06, 2025 at 09:29:02AM +0100, Christoph Hellwig wrote:
> On Mon, Jan 06, 2025 at 11:31:43AM +0800, Ming Lei wrote:
> > As I mentioned in another thread, freezing queue may not be needed in
> > ->store(), so let's discuss and confirm if it is needed here first.
> > 
> > https://lore.kernel.org/linux-block/Z3tHozKiUqWr7gjO@fedora/
> 
> We do need the freezing.  What you're proposing is playing fast and loose
> which is going to get us in trouble.

It is just soft update from sysfs interface, and both the old and new limits
are correct from device viewpoint.

What is the trouble? We have run the .store() code without freezing for
more than 10 years, no one report issue in the area.


> While most (all?) limits are simple
> scalars, you often can't update just one without the others without
> having coherent state.  Having coherent state was the entire point of
> the atomic queue limit updates.

We am talking all the update in block queue sysfs store(), in each
interface just one scalar number is updated in atomic way.

The atomic update API is still applied, I meant queue freeze can be
removed.


Thank,s
Ming


