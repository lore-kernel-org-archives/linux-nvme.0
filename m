Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28F31C636CC
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Feb 2023 00:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DToZBRv3t19GPVVdFMwp1iIAKMJ2B1Wx1nBc/wcaPzA=; b=iwbKfPvG2uqtFaoMOkoZ9GLjgt
	OyU0HD6ipCTQFr0OTkY0phWk1yWHKdQGqVezLIplT2bbTm40ZcWIZa27EzjXSTDFM1dczOxJ2ow0Q
	a0z8/3re0BdqOqlXzTCrAL1cy1ot+KKxhN6UyiFEeOxF1yGsfjeIExMnmPH8yLd1Ao1mvbMK9T3fq
	ojgUevQd4mq+XVDT6mJEZwQiX/n1aEZ3Ha7ndrA08Rs3ieaACpra4dWgM7AUmch3iXcxtrHHrnpk0
	wR1yp61vVtqd0N1mTNVRyMe3R7PLpnatvpDXY5/iq+EyJ3oigARCJLkH/rgJrSYqbbQpbPq50BKZd
	YFuOBXeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRioW-00GqzC-ER; Tue, 14 Feb 2023 00:04:52 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRioR-00Gqxw-LK
	for linux-nvme@lists.infradead.org; Tue, 14 Feb 2023 00:04:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1676333082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DToZBRv3t19GPVVdFMwp1iIAKMJ2B1Wx1nBc/wcaPzA=;
	b=Xa6DQ9uhqBXSkxuqGoh6qRZGjwrNlFHBNMrvVw7GVglYQO8EzG1EIAgDWDVG4MLJMX2fkQ
	5oLGfaYZF+rsZv2hXDzdn0Ir4/TXMQcy682c8SABO4ecLgfIXdpO+u5UxOrKYTytG18Ura
	ZcZ/NZ4rdEre+zkmvKmwVirIo7Q5zWg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-561-sAb4iFhEORej7dZCT0Wz8A-1; Mon, 13 Feb 2023 19:04:39 -0500
X-MC-Unique: sAb4iFhEORej7dZCT0Wz8A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 07259100F911;
	Tue, 14 Feb 2023 00:04:39 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0899140398A0;
	Tue, 14 Feb 2023 00:04:28 +0000 (UTC)
Date: Tue, 14 Feb 2023 08:04:22 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@infradead.org>,
	John Meneghini <jmeneghi@redhat.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	ming.lei@redhat.com
Subject: Re: nvme/pcie hot plug results in /dev name change
Message-ID: <Y+rQBgZTklub++cx@T590>
References: <472fe309-f0f9-65bf-1ad1-8a92a349e973@redhat.com>
 <Y8sKv7q+UEbz5ddD@kbusch-mbp.dhcp.thefacebook.com>
 <Y8uN4V8uW2qS+xHR@infradead.org>
 <Y9ZKNb4UKwg5zF4j@T590>
 <Y9lEF7oY+aQw2POp@kbusch-mbp.dhcp.thefacebook.com>
 <Y9nPa2ZBc80g2LcA@T590>
 <Y9oGTKCFlOscbPc2@infradead.org>
 <Y9qT45LPnkeL8fkH@kbusch-mbp.dhcp.thefacebook.com>
 <2205fb9d-f887-dedc-04c1-06190dc51413@grimberg.me>
 <Y+pmI52Ahfn/hF6m@kbusch-mbp>
MIME-Version: 1.0
In-Reply-To: <Y+pmI52Ahfn/hF6m@kbusch-mbp>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230213_160447_797967_D0BFEBC3 
X-CRM114-Status: GOOD (  22.59  )
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

On Mon, Feb 13, 2023 at 09:32:35AM -0700, Keith Busch wrote:
> On Mon, Feb 13, 2023 at 04:01:03PM +0200, Sagi Grimberg wrote:
> > > Also not sure if this is going to work out, but it looks like a good start to
> > > me.
> > > 
> > > Instead of user pinning the virtual device so that it never goes away though, I
> > > considered a user tunable "device missing delay" parameter to debounce link
> > > events. New IOs would be deferred to the requeue_list while the timer is
> > > active, and then EIO'ed if the timer expires without a successful LIVE
> > > controller attachment. The use cases I'm considering are short bounces from
> > > transient link resets, so I'd expect timers to be from a few seconds to maybe a
> > > minute.
> > 
> > Isn't this equivalent to dm-mpath queue_if_no_path or no_path_timeout ?
> 
> Similiar, but generic to non-multipath devices.
>  
> > We can keep the mpath device around, but if not, what is the desired
> > behavior from the upper layers?
> 
> I don't think we're looking for any behavioral changes in the upper layers.
 
That also means no matter if the nvme mpath layer is added or not, upper
layer still has to handle this kind of failure, so what is the
difference made from the added nvme-mpath?

Thanks, 
Ming


