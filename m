Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7370AC05027
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Feb 2023 01:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jK+knAbJAXpkt+InZU28kKdcwPhjlvtEuGvjvHMBiN8=; b=Lw7D4wdJl/57pyi3CjzWzFb6tP
	0HdfFZiAauIlII0rxxFtXiO+TOymAf+mu9hm3gK0TN14RjXqRzeHW81Ga3iCM5pb8IGQi+MAQU/yf
	wloO/f3iFtvmP6laX5TxSZcIRL/jXsbHGG8/cdNImFmS0Jw5Jsxg/ZuNcgFeKuSxya9oMCmrbQ/Gm
	Cscfxv1rA7b18w62kbW7GvPqVqRc2dCboxy9SZhfYMcXWTfO5m8FsB9PBC9Zt+y7MYq2nZo3hoIj9
	aY54PdkfNkRJNWM5jYl6TAEcXgh2uYZvOJpvKOh+Jct1ojKVVIV6dXkk9MxOYKE47FLfjzsRUXnmg
	uaiYTfmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pS6M2-004BHP-89; Wed, 15 Feb 2023 01:13:02 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pS6L3-004Ath-PP
	for linux-nvme@lists.infradead.org; Wed, 15 Feb 2023 01:12:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1676423519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jK+knAbJAXpkt+InZU28kKdcwPhjlvtEuGvjvHMBiN8=;
	b=B5XR6R3dfqA+bm1UbEXr+MD9qM+4+ycbjGKZfCETYxIUfgHxIY4sJp+R/D9u8eTiztjmTS
	7mcgkhSw1quR9sZDVjSqos62UKlDedf6qb0EUuGQQzC8bTdHeGl4dDic/x57fDYN/OjF5E
	PYbUqINHJZ2il9hgXhC1rItrhNxh7hE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-523-Q0GESWw5MMuiyXvxIRkXUw-1; Tue, 14 Feb 2023 20:11:56 -0500
X-MC-Unique: Q0GESWw5MMuiyXvxIRkXUw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B747985A588;
	Wed, 15 Feb 2023 01:11:55 +0000 (UTC)
Received: from T590 (ovpn-8-18.pek2.redhat.com [10.72.8.18])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B1FF6492B15;
	Wed, 15 Feb 2023 01:11:50 +0000 (UTC)
Date: Wed, 15 Feb 2023 09:11:45 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@infradead.org>,
	John Meneghini <jmeneghi@redhat.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	ming.lei@redhat.com
Subject: Re: nvme/pcie hot plug results in /dev name change
Message-ID: <Y+wxUf6TAbEVNL+8@T590>
References: <Y8uN4V8uW2qS+xHR@infradead.org>
 <Y9ZKNb4UKwg5zF4j@T590>
 <Y9lEF7oY+aQw2POp@kbusch-mbp.dhcp.thefacebook.com>
 <Y9nPa2ZBc80g2LcA@T590>
 <Y9oGTKCFlOscbPc2@infradead.org>
 <Y9qT45LPnkeL8fkH@kbusch-mbp.dhcp.thefacebook.com>
 <2205fb9d-f887-dedc-04c1-06190dc51413@grimberg.me>
 <Y+pmI52Ahfn/hF6m@kbusch-mbp>
 <Y+rQBgZTklub++cx@T590>
 <Y+u0CtrjWBWL9aeB@kbusch-mbp>
MIME-Version: 1.0
In-Reply-To: <Y+u0CtrjWBWL9aeB@kbusch-mbp>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230214_171201_979367_622CECE3 
X-CRM114-Status: GOOD (  29.15  )
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

On Tue, Feb 14, 2023 at 09:17:15AM -0700, Keith Busch wrote:
> On Tue, Feb 14, 2023 at 08:04:22AM +0800, Ming Lei wrote:
> > On Mon, Feb 13, 2023 at 09:32:35AM -0700, Keith Busch wrote:
> > > On Mon, Feb 13, 2023 at 04:01:03PM +0200, Sagi Grimberg wrote:
> > > > > Also not sure if this is going to work out, but it looks like a good start to
> > > > > me.
> > > > > 
> > > > > Instead of user pinning the virtual device so that it never goes away though, I
> > > > > considered a user tunable "device missing delay" parameter to debounce link
> > > > > events. New IOs would be deferred to the requeue_list while the timer is
> > > > > active, and then EIO'ed if the timer expires without a successful LIVE
> > > > > controller attachment. The use cases I'm considering are short bounces from
> > > > > transient link resets, so I'd expect timers to be from a few seconds to maybe a
> > > > > minute.
> > > > 
> > > > Isn't this equivalent to dm-mpath queue_if_no_path or no_path_timeout ?
> > > 
> > > Similiar, but generic to non-multipath devices.
> > >  
> > > > We can keep the mpath device around, but if not, what is the desired
> > > > behavior from the upper layers?
> > > 
> > > I don't think we're looking for any behavioral changes in the upper layers.
> >  
> > That also means no matter if the nvme mpath layer is added or not, upper
> > layer still has to handle this kind of failure, so what is the
> > difference made from the added nvme-mpath?
> 
> I don't understand. There's no difference here for the upper layers. It's just
> a different timing from when a disconnect starts failing IO. The upper layers

If that isn't real disconnect, probably it is better to solve it
in nvme error handling, and device removal should be done as the
last straw.

> can keep doing what they're already doing in either case.

Because any device(include the to-be-invented mpath device) may be gone and
back, userspace needs to take measures to cover them if persistent
device name is required.


Thanks,
Ming


