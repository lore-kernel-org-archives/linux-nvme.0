Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03EA6C83030
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jul 2025 03:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dnopD1FhRzynW0zzFuLolvd4OyfdYAg2+eqiwCTe42c=; b=ydDMdLMSODNdDIq4luWf2HlYyG
	RwykZE7a91p6oLnz8acP77nMiAmzoLBOIxwtTNgY+ol8y+Li9XaKPbCWp4QelKL8wenRzsA9u74FT
	nuzzKxyf7QsMMdAPbNKJMBXJu6V627/e8bskRyToPCWpuRMiTJl2rvf9UlBKSGHMLE7/dywYLlQOA
	5Jvq9Kb8Rm05dHeEvqbkeoIHwwiJgk2pxAbudz2u0nylyAYZJE4aJnxFc1Tdw3N3D7yJ29o7IvDE5
	bD+Jsn+blZvYVDnKATF3yjuh0Jk62vY/0HUq7DF6d/ogRKV52In6lAWqPMFE8QWMxv1/tjK84HHE5
	cDnlFp+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYyqf-000000049kb-34bE;
	Tue, 08 Jul 2025 03:18:25 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYyqT-000000049gf-1UPP
	for linux-nvme@lists.infradead.org;
	Tue, 08 Jul 2025 03:18:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751944692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dnopD1FhRzynW0zzFuLolvd4OyfdYAg2+eqiwCTe42c=;
	b=G/eG3i1okpmjZZKW8mxFo4RFI3MzhgK0HPgziyGoYLqKLphtrl3l3RMLAWAQ8TUHmcmdwT
	Z213RXimPx1gp/vPjQEUFva/EZwGQyh+VE/ErcDMy1MfmSngm7EaYXRJEvGWnin2BLRJBQ
	JahBlfS+C8SD43/nGTBrBWQ6HwcpKzE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-461-8zwr5N74NfS8riI8N4qkxw-1; Mon,
 07 Jul 2025 23:18:06 -0400
X-MC-Unique: 8zwr5N74NfS8riI8N4qkxw-1
X-Mimecast-MFC-AGG-ID: 8zwr5N74NfS8riI8N4qkxw_1751944685
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EE3A81800289;
	Tue,  8 Jul 2025 03:18:04 +0000 (UTC)
Received: from fedora (unknown [10.72.116.39])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D90171956087;
	Tue,  8 Jul 2025 03:17:59 +0000 (UTC)
Date: Tue, 8 Jul 2025 11:17:54 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Alan Adamson <alan.adamson@oracle.com>,
	John Garry <john.g.garry@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: What should we do about the nvme atomics mess?
Message-ID: <aGyN4pOWyclgV6-H@fedora>
References: <20250707141834.GA30198@lst.de>
 <aGxz6s9oUp2FkbyX@fedora>
 <aGyCH8TOQgVY3AP9@kbusch-mbp>
 <aGyGboLwcn2cXoRo@fedora>
 <aGyI-sl68Y0klsJn@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGyI-sl68Y0klsJn@kbusch-mbp>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250707_201813_877240_EFDADF00 
X-CRM114-Status: GOOD (  31.30  )
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

On Mon, Jul 07, 2025 at 08:56:58PM -0600, Keith Busch wrote:
> On Tue, Jul 08, 2025 at 10:46:06AM +0800, Ming Lei wrote:
> > On Mon, Jul 07, 2025 at 08:27:43PM -0600, Keith Busch wrote:
> > > On Tue, Jul 08, 2025 at 09:27:06AM +0800, Ming Lei wrote:
> > > > On Mon, Jul 07, 2025 at 04:18:34PM +0200, Christoph Hellwig wrote:
> > > > > Hi all,
> > > > > 
> > > > > I'm a bit lost on what to do about the sad state of NVMe atomic writes.
> > > > > 
> > > > > As a short reminder the main issues are:
> > > > > 
> > > > >  1) there is no flag on a command to request atomic (aka non-torn)
> > > > >     behavior, instead writes adhering to the atomicy requirements will
> > > > >     never be torn, and writes not adhering them can be torn any time.
> > > > >     This differs from SCSI where atomic writes have to be be explicitly
> > > > >     requested and fail when they can't be satisfied
> > > > >  2) the original way to indicate the main atomicy limit is the AWUPF
> > > > >     field, which is in Identify Controller, but specified in logical
> > > > >     blocks which only exist at a namespace layer.  This a) lead to
> > > > 
> > > > If controller-wide AWUPF is a must property, the length has to be aligned
> > > > with block size.
> > > 
> > > What block size? The controller doesn't have one. Block sizes are
> > 
> > It should be any NS format's block size.
> 
> That requires an artificial reduction to a meaningless value.

Any value has to be 'block size' aligned.

> 
> > > properties of namespaces, not controllers or subsystems. If you have 10
> > > namespaces with 10 different block formats, what does AUWPF mean? If the
> > > controller must report something, the only rational thing it could
> > > declare is reduced to the greatest common denominator, which is out of
> > > sync with the true value reported in the appropriately scoped NAUWPF
> > > value.
> > 
> > Yes, please see the words I quoted from NVMe spec, also `6.4 Atomic Operations`
> > mentioned: `NAWUPF >= AWUPF`.
> 
> The problem is when Namespace X changes its format that then alters
> Namesace Y's reported atomic size. That's unacceptable for any
> filesystem utilizing this feature.

When X changes its format, FS has to be umount.

The actual length(byte unit) of atomic write does not changed for Y,
just the unit(block size) is changed, at least from Yi's report.


Thanks, 
Ming


