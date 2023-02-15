Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5A81C05027
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Feb 2023 01:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J+jyTgACnWeJ0m2iw/Kuyp1LrbJ+I6+9aIidVeRfNto=; b=tu5cib/JsYEE8+x0KfFiYHnVso
	HPYmcmvKiKt/ACZ9rlNjAT6soe3Rr2QGpDnVMaVgRZ5d2fSjM+v9gHeRK9seIaoG4APJg5cybseBE
	UaovjAviQq2CqUOwHDWIYtqTiTP66leMNGfEfR3u6WLfWtHYgUlTBYTORl2K8mLhYuXrxOaH0KqAy
	7SVjTZ+VfywixLkFgUsDIfQczG6AAO7yKaV5c9RU1FwAAG4zm7Sr3pTojqYCDTJ9/AmLsIIxWJz7s
	GRmLRU1Jeqd+ourYZkl5ipFOTW4yqj2w0SZMzVorPJilDPRVviTzvtO+7b/qK7KPMnbWxKUPJ8Ub7
	TmEx8e/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pS6EE-0048Rx-RM; Wed, 15 Feb 2023 01:04:58 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pS6EC-0048Py-6O
	for linux-nvme@lists.infradead.org; Wed, 15 Feb 2023 01:04:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1676423094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J+jyTgACnWeJ0m2iw/Kuyp1LrbJ+I6+9aIidVeRfNto=;
	b=Cw1aVQNagqhGqiuXaaQbr7stPW910TZl3+X4zTzo62dhoENDILriERYNm9KXB+y+uCI/qi
	1CCqTVipBzQxDYAiY08afXgPZKC/61sWT3p7a7r4hcYXFSHgNO4OkBiMov0+IKh9u6aYh8
	nR14ztyVN035RYo3JIHuWgk3uIB3cgM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-148-zuN098erMmq827KaolvAjw-1; Tue, 14 Feb 2023 20:04:50 -0500
X-MC-Unique: zuN098erMmq827KaolvAjw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9A7FB800B24;
	Wed, 15 Feb 2023 01:04:50 +0000 (UTC)
Received: from T590 (ovpn-8-18.pek2.redhat.com [10.72.8.18])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 92F5A2166B26;
	Wed, 15 Feb 2023 01:04:45 +0000 (UTC)
Date: Wed, 15 Feb 2023 09:04:38 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@infradead.org>,
	John Meneghini <jmeneghi@redhat.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	ming.lei@redhat.com
Subject: Re: nvme/pcie hot plug results in /dev name change
Message-ID: <Y+wvpmh12G+jLgOS@T590>
References: <Y8uN4V8uW2qS+xHR@infradead.org>
 <Y9ZKNb4UKwg5zF4j@T590>
 <Y9lEF7oY+aQw2POp@kbusch-mbp.dhcp.thefacebook.com>
 <Y9nPa2ZBc80g2LcA@T590>
 <Y9oGTKCFlOscbPc2@infradead.org>
 <Y9qT45LPnkeL8fkH@kbusch-mbp.dhcp.thefacebook.com>
 <2205fb9d-f887-dedc-04c1-06190dc51413@grimberg.me>
 <Y+pmI52Ahfn/hF6m@kbusch-mbp>
 <Y+rQBgZTklub++cx@T590>
 <eeac5e24-a9f0-e6d4-0eda-0706d5ceb28c@grimberg.me>
MIME-Version: 1.0
In-Reply-To: <eeac5e24-a9f0-e6d4-0eda-0706d5ceb28c@grimberg.me>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230214_170456_337764_A5AB4541 
X-CRM114-Status: GOOD (  28.90  )
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

On Tue, Feb 14, 2023 at 11:18:20AM +0200, Sagi Grimberg wrote:
> 
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
> > > > We can keep the mpath device around, but if not, what is the desired
> > > > behavior from the upper layers?
> > > 
> > > I don't think we're looking for any behavioral changes in the upper layers.
> > That also means no matter if the nvme mpath layer is added or not, upper
> > layer still has to handle this kind of failure, so what is the
> > difference made from the added nvme-mpath?
> 
> What do you expect from the upper layer? The device went away...

From developer viewpoint, FS has to be re-configured(re-mount after
new device comes back).

> 
> The suggestion is that when the device comes back the upper layer will
> detect it and reconfigure it (restore it to a raid/dm or remount the
> FS)?

I understand userspace is capable of recognizing if same device comes
back, and userspace can get notified with device add/del. Why bother kernel
to do that?

Also suppose the mpath device is invented for this purpose, we can't
guarantee that the mapth dev won't be gone and back, so userspace has
to deal with the situation, right?

Also the issue isn't nvme unique, and it shouldn't be implemented in
nvme-mpath suppose agreement is reached to solve it in kernel.

Thanks,
Ming


