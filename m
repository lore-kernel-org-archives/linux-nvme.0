Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AEC7C47258
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jan 2024 04:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/Gfdw7K+9a69TgeX8sgmnQQKT35P/vA2QZmn4VjqvAI=; b=J/03B4tFjTACdEmBkPyKXtw22v
	wMvNPLku3IgiIoUmBStECd2EQL0Dbtn1O82sfyaQ12IziW3NmxtUuDpPXLXYDNA5EF9IPuxGwTJ0e
	KogwUdwPwfpOf/k6wqKfM+pBToKwTMGsOD4WmIe222OHbGeL7qmqbNWuy6+R0kcc7PzOEEpvN5fgf
	tgSSKTTxmISKluK020C0ONLmUpwUvRXDnwRq+rKGeIyvtAoT8DyrwrjVhcZMRqFG7KbfdoF8hmrWg
	jSllzRxfFbRFsWl4SR7wsVsIv4oHXw+vpPigkBjzsW0l+sadGjSQwsuYqOYeKJAidFOIW0FEqv2gs
	ew3nPP6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSrHX-006Fne-0D;
	Thu, 25 Jan 2024 04:24:03 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSrHT-006Fki-0z
	for linux-nvme@lists.infradead.org;
	Thu, 25 Jan 2024 04:24:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706156636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/Gfdw7K+9a69TgeX8sgmnQQKT35P/vA2QZmn4VjqvAI=;
	b=gFFMecRPvWXhGpFN8oyAicyMfOkcyHUZ8KRpsSI1/E3bhQP7kW/YJLYwJ+tvMWEIGs5/yO
	gdhaFC9wkN/AhrX3tz5Xl82s+xvnTXmXgmkWI8AreVulesT02gsBvov8KGSbCqmU4n6oNh
	g1BORuF4U50YLSuwzAvbFKWYBwQ+uE8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-gs1EVHb9PH62IwHqZz6GnA-1; Wed, 24 Jan 2024 23:23:52 -0500
X-MC-Unique: gs1EVHb9PH62IwHqZz6GnA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AB509881EA3;
	Thu, 25 Jan 2024 04:23:51 +0000 (UTC)
Received: from fedora (unknown [10.72.116.54])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E0C9651D5;
	Thu, 25 Jan 2024 04:23:48 +0000 (UTC)
Date: Thu, 25 Jan 2024 12:23:44 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org
Subject: Re: [Report] requests are submitted to hardware in reverse order
 from nvme/virtio-blk queue_rqs()
Message-ID: <ZbHiOs3R8SgGClvN@fedora>
References: <ZbD7ups50ryrlJ/G@fedora>
 <ZbEvstiLSMwtFb8m@kbusch-mbp.dhcp.thefacebook.com>
 <772618f3-f4d3-470e-bf06-70d8ee66d7b0@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <772618f3-f4d3-470e-bf06-70d8ee66d7b0@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240124_202359_424127_CBD64B8D 
X-CRM114-Status: GOOD (  17.58  )
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

On Thu, Jan 25, 2024 at 07:32:37AM +0900, Damien Le Moal wrote:
> On 1/25/24 00:41, Keith Busch wrote:
> > On Wed, Jan 24, 2024 at 07:59:54PM +0800, Ming Lei wrote:
> >> Requests are added to plug list in reverse order, and both virtio-blk
> >> and nvme retrieves request from plug list in order, so finally requests
> >> are submitted to hardware in reverse order via nvme_queue_rqs() or
> >> virtio_queue_rqs, see:
> >>
> >> 	io_uring       submit_bio  vdb      6302096     4096
> >> 	io_uring       submit_bio  vdb     12235072     4096
> >> 	io_uring       submit_bio  vdb      7682280     4096
> >> 	io_uring       submit_bio  vdb     11912464     4096
> >> 	io_uring virtio_queue_rqs  vdb     11912464     4096
> >> 	io_uring virtio_queue_rqs  vdb      7682280     4096
> >> 	io_uring virtio_queue_rqs  vdb     12235072     4096
> >> 	io_uring virtio_queue_rqs  vdb      6302096     4096
> >>
> >>
> >> May this reorder be one problem for virtio-blk and nvme-pci?
> > 
> > For nvme, it depends. Usually it's probably not a problem, though some
> > pci ssd's have optimizations for sequential IO that might not work if
> > these get reordered.
> 
> ZNS and zoned virtio-blk drives... Cannot use io_uring at the moment. But I do
> not thing we reliably can anyway, unless the issuer is CPU/ring aware and always
> issue writes to a zone using the same ring.

It isn't related with io_uring.

What matters is plug & none & queue_rqs(). If none is applied, any IOs
in single batch will be added to plug list, then dispatched to hardware
in reversed order via queue_rqs().

Thanks,
Ming


