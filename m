Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFE9CE67A69
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Mar 2026 05:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wGDXpiZUgPV8wjM7a62PXYfnySDj7E1W1FYiXgU7gPk=; b=BF3dN+aLOsgXCcpTscWeiS13dq
	UbDEl4JA9U7pxEfEOCey7ZUmabxgyYfKs5fL981Vh+voBSVdALbRzfATFsHThi/nF5LzKx3URV6So
	oS92RU7dqpaZfSiNknEoRQcpY8vyR39QqNlfusf81iGCjTevyvA7aqYVUZpG/7o6A5+Q4/j446Y1q
	aHPqWEIs/EtrRqMO0UzE45e4aUOBykkv43UEK8ZYZ5P3anIJoccdwe8K58AkFZIgRRb9sH2oxztEf
	ZSvdl1S0fali4GsMqTJqJkZY1AILu69kwqxHZiGJH5YFk1+Blk/pAjt55n5EQN+5JiXg0fUAh2+FS
	PU+3HclA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxIUb-0000000EYlm-3HLT;
	Tue, 03 Mar 2026 05:40:25 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxIUY-0000000EYlM-2TXw
	for linux-nvme@lists.infradead.org;
	Tue, 03 Mar 2026 05:40:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772516419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wGDXpiZUgPV8wjM7a62PXYfnySDj7E1W1FYiXgU7gPk=;
	b=SWS3YZUjoThOjxIpu2S9PRIPpnoPxxMvuRXJEa7K6fFeJv0+sQL2p5UIt9qBjvQhIejAIm
	zI6L4WpB6ApYl+2N/LFkYsZn2Ugrm03jUoldiBQfwxXk2cPaGOjyC2iW6EdT0twLpTKD0V
	ALnlJIoQS83+YqwevUC9Z+E+UOJ7Vkk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-551-hkpAaKNIMXqbxBv1z2Y9jA-1; Tue,
 03 Mar 2026 00:40:08 -0500
X-MC-Unique: hkpAaKNIMXqbxBv1z2Y9jA-1
X-Mimecast-MFC-AGG-ID: hkpAaKNIMXqbxBv1z2Y9jA_1772516396
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A15D919560B2;
	Tue,  3 Mar 2026 05:39:55 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (unknown [10.6.23.247])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EBF8319560A2;
	Tue,  3 Mar 2026 05:39:54 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.17.1) with ESMTPS id 6235dr2b1875431
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 3 Mar 2026 00:39:53 -0500
Received: (from bmarzins@localhost)
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.18.1/Submit) id 6235drsg1875430;
	Tue, 3 Mar 2026 00:39:53 -0500
Date: Tue, 3 Mar 2026 00:39:53 -0500
From: Benjamin Marzinski <bmarzins@redhat.com>
To: John Garry <john.g.garry@oracle.com>
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
        martin.petersen@oracle.com, james.bottomley@hansenpartnership.com,
        hare@suse.com, jmeneghi@redhat.com, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, michael.christie@oracle.com,
        snitzer@kernel.org, dm-devel@lists.linux.dev,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/24] scsi-multipath: introduce basic SCSI device support
Message-ID: <aaZ0Kf9n79QF4gbR@redhat.com>
References: <20260225153627.1032500-1-john.g.garry@oracle.com>
 <20260225153627.1032500-3-john.g.garry@oracle.com>
 <aaT0Taxs6WgX6m-j@redhat.com>
 <784abca8-9dc1-4fca-b72f-62d55b4cc3f1@oracle.com>
MIME-Version: 1.0
In-Reply-To: <784abca8-9dc1-4fca-b72f-62d55b4cc3f1@oracle.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: NfnS4K-fwiz1QQMVdHlxpBnnJcEljsvmxlBb2WmogTo_1772516396
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260302_214022_708888_F9928129 
X-CRM114-Status: GOOD (  17.91  )
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

On Mon, Mar 02, 2026 at 11:39:28AM +0000, John Garry wrote:
> On 02/03/2026 02:22, Benjamin Marzinski wrote:
> > > diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
> > > index 19d0884479a24..cfab7ad1e3c2c 100644
> > > --- a/drivers/scsi/Kconfig
> > > +++ b/drivers/scsi/Kconfig
> > > @@ -76,6 +76,16 @@ config SCSI_LIB_KUNIT_TEST
> > >   	  If unsure say N.
> > > +config SCSI_MULTIPATH
> > > +	bool "SCSI multipath support"
> > At least until this supports ALUA, it should probably be marked
> > EXPERIMENTAL, just so people trying it out aren't surprised if it
> > doesn't multipath their device in the way they expect.
> 
> I think that ALUA support will be mainline acceptance criteria, and I am
> looking to add it now.
> 
> BTW, Hannes suggested to not use the DH ALUA support, so that means to
> separate out the core ALUA support from the DH stuff. So you have any
> opinion on that approach?

I would (perhaps naively) have thought that the device handlers would be
a useful abstraction for dealing with ALUA devices. But, Hannes knows
this code much better than me. like I said before, I'm no scsi expert.

-Ben

> 
> Thanks!


