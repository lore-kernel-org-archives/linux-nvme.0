Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D490DC83030
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jul 2025 02:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DrYPhW9upjzk5P78SdEwMjAG/WbTXiFI741894VXTTw=; b=o3vj7GN+eLq1FDCWulizUHuBdr
	IejQdAt1pGya13efXN2uCVhJQWQNLZPWY00xy7zrFRK19lIIpzooCUhNhoaXAsoWvQX65+lW+0nj5
	416rh1UuuNs2TnO58UjvTck70sr+oZ8hmDtnPbgnLjBsx5uyYduKXtKA8gj5HppB61FesBvpTzaSK
	kAW5q7ysWh5W8NMWXeY3PrALZKz47DrhGcgRN3RegeUCCnW3mouxTiRe9SVdmANO8lihYIU/RXu9g
	zvfxkwG+4wRurFaiWYrb3wI+VObTo5HdcUnydVhYYrGr/+LYUziXTGAXw81r4CX5nCc/Qm+OCteK7
	5xgig1Qg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYyLi-0000000474D-0BNH;
	Tue, 08 Jul 2025 02:46:26 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYyLf-0000000473q-18QM
	for linux-nvme@lists.infradead.org;
	Tue, 08 Jul 2025 02:46:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751942782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DrYPhW9upjzk5P78SdEwMjAG/WbTXiFI741894VXTTw=;
	b=WRZdWurqBSYeEOnF7D2SqUxfiKEVH9smME3hIbIgWU7EIQBWpANKEuIEDmsycvIqR7xeSo
	6c0/x2+PkTO9I1bKhsGVa9QbUo/mFO1xxwVKGcW4zX2mXUHtfs4nU5K6N8OOoV59NaH2u4
	KnOs3Ksb+eoCEqcDc3TCufU0abVlqY0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-VY45ijIiPXSbmUrwZsAOpw-1; Mon,
 07 Jul 2025 22:46:18 -0400
X-MC-Unique: VY45ijIiPXSbmUrwZsAOpw-1
X-Mimecast-MFC-AGG-ID: VY45ijIiPXSbmUrwZsAOpw_1751942777
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A5481180029E;
	Tue,  8 Jul 2025 02:46:16 +0000 (UTC)
Received: from fedora (unknown [10.72.116.39])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 851B030002C0;
	Tue,  8 Jul 2025 02:46:11 +0000 (UTC)
Date: Tue, 8 Jul 2025 10:46:06 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Alan Adamson <alan.adamson@oracle.com>,
	John Garry <john.g.garry@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: What should we do about the nvme atomics mess?
Message-ID: <aGyGboLwcn2cXoRo@fedora>
References: <20250707141834.GA30198@lst.de>
 <aGxz6s9oUp2FkbyX@fedora>
 <aGyCH8TOQgVY3AP9@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGyCH8TOQgVY3AP9@kbusch-mbp>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250707_194623_435589_44D3582F 
X-CRM114-Status: GOOD (  25.36  )
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

On Mon, Jul 07, 2025 at 08:27:43PM -0600, Keith Busch wrote:
> On Tue, Jul 08, 2025 at 09:27:06AM +0800, Ming Lei wrote:
> > On Mon, Jul 07, 2025 at 04:18:34PM +0200, Christoph Hellwig wrote:
> > > Hi all,
> > > 
> > > I'm a bit lost on what to do about the sad state of NVMe atomic writes.
> > > 
> > > As a short reminder the main issues are:
> > > 
> > >  1) there is no flag on a command to request atomic (aka non-torn)
> > >     behavior, instead writes adhering to the atomicy requirements will
> > >     never be torn, and writes not adhering them can be torn any time.
> > >     This differs from SCSI where atomic writes have to be be explicitly
> > >     requested and fail when they can't be satisfied
> > >  2) the original way to indicate the main atomicy limit is the AWUPF
> > >     field, which is in Identify Controller, but specified in logical
> > >     blocks which only exist at a namespace layer.  This a) lead to
> > 
> > If controller-wide AWUPF is a must property, the length has to be aligned
> > with block size.
> 
> What block size? The controller doesn't have one. Block sizes are

It should be any NS format's block size.

> properties of namespaces, not controllers or subsystems. If you have 10
> namespaces with 10 different block formats, what does AUWPF mean? If the
> controller must report something, the only rational thing it could
> declare is reduced to the greatest common denominator, which is out of
> sync with the true value reported in the appropriately scoped NAUWPF
> value.

Yes, please see the words I quoted from NVMe spec, also `6.4 Atomic Operations`
mentioned: `NAWUPF >= AWUPF`.



Thanks,
Ming


