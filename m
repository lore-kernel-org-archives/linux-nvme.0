Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53730EC1451
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Mar 2026 14:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hpscGlqtT0S5hsz/lvyVjD4lT80PmJ0j11LCHkWNSX8=; b=Yj/hbMGq6Phzsvpij2PY1+X6fO
	0Wo8vD1DYF/HC/V9EYWeyiyv2pSK8q6EFNpBJJDVRZzZ0VpwwhUd3upf9w92iaEnHeHEI8xLI3gwQ
	yianW9HJKM+HOGxXeLrUVfZOhdYKjVzWYbt5ZZyl9IuaKAiWVYrRoEPNK9T0O+m+Y5uLx1dcmUxs6
	80Vz562XcG8PXMpc2lb/pj7A40HDwDSfz37KYhgYrBslxUhZmRFpNL13pliGXj+b7zkzdbwejzOjM
	9bIim+LItOJ1Po6nJ0GVfEoXAo1gxXc0O/TNi7ra5ezrQdIZKo/tE93mv1x1vTUAh2EP2dJYISFQh
	gUwOuAvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxQcN-0000000FJg0-0Q5y;
	Tue, 03 Mar 2026 14:20:59 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxQcL-0000000FJdy-04wc
	for linux-nvme@lists.infradead.org;
	Tue, 03 Mar 2026 14:20:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772547655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hpscGlqtT0S5hsz/lvyVjD4lT80PmJ0j11LCHkWNSX8=;
	b=CUvUYXgigXubGNHGgiMATtQquc0X01JXnse/JSrxcs75h86ojlpnE98WkSqQPWSqm3YTiD
	tsbqQXlkeW31ttRZBvvvUBjsxoRN3vVTu9BNfKStS6PH91j6nT20FExk11cKHg9Wi/Wfvj
	glFXogcxpuW2rDe9vzR7sE+wniPCx0M=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-127-3ehT5qksMqaYvuvFq6SAhg-1; Tue,
 03 Mar 2026 09:20:52 -0500
X-MC-Unique: 3ehT5qksMqaYvuvFq6SAhg-1
X-Mimecast-MFC-AGG-ID: 3ehT5qksMqaYvuvFq6SAhg_1772547649
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B940B1956095;
	Tue,  3 Mar 2026 14:20:48 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (unknown [10.6.23.247])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 632EE1800590;
	Tue,  3 Mar 2026 14:20:47 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.17.1) with ESMTPS id 623EKkZo1889507
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 3 Mar 2026 09:20:46 -0500
Received: (from bmarzins@localhost)
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.18.1/Submit) id 623EKibS1889506;
	Tue, 3 Mar 2026 09:20:44 -0500
Date: Tue, 3 Mar 2026 09:20:44 -0500
From: Benjamin Marzinski <bmarzins@redhat.com>
To: Hannes Reinecke <hare@suse.de>
Cc: John Garry <john.g.garry@oracle.com>, hch@lst.de, kbusch@kernel.org,
        sagi@grimberg.me, axboe@fb.com, martin.petersen@oracle.com,
        james.bottomley@hansenpartnership.com, hare@suse.com,
        jmeneghi@redhat.com, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, michael.christie@oracle.com,
        snitzer@kernel.org, dm-devel@lists.linux.dev,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/24] scsi-multipath: introduce basic SCSI device support
Message-ID: <aabuPClNgSC6uO93@redhat.com>
References: <20260225153627.1032500-1-john.g.garry@oracle.com>
 <20260225153627.1032500-3-john.g.garry@oracle.com>
 <aaT0Taxs6WgX6m-j@redhat.com>
 <784abca8-9dc1-4fca-b72f-62d55b4cc3f1@oracle.com>
 <aaZ0Kf9n79QF4gbR@redhat.com>
 <003612c1-ff07-466c-93e8-d7766a9ec2db@suse.de>
MIME-Version: 1.0
In-Reply-To: <003612c1-ff07-466c-93e8-d7766a9ec2db@suse.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: n2g8ABzWUscBIxlcQIIWP2-PPtfoeRU5E1PLA_Tcb64_1772547649
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260303_062057_137187_52BAF67E 
X-CRM114-Status: GOOD (  29.58  )
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

On Tue, Mar 03, 2026 at 09:01:04AM +0100, Hannes Reinecke wrote:
> On 3/3/26 06:39, Benjamin Marzinski wrote:
> > On Mon, Mar 02, 2026 at 11:39:28AM +0000, John Garry wrote:
> > > On 02/03/2026 02:22, Benjamin Marzinski wrote:
> > > > > diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
> > > > > index 19d0884479a24..cfab7ad1e3c2c 100644
> > > > > --- a/drivers/scsi/Kconfig
> > > > > +++ b/drivers/scsi/Kconfig
> > > > > @@ -76,6 +76,16 @@ config SCSI_LIB_KUNIT_TEST
> > > > >    	  If unsure say N.
> > > > > +config SCSI_MULTIPATH
> > > > > +	bool "SCSI multipath support"
> > > > At least until this supports ALUA, it should probably be marked
> > > > EXPERIMENTAL, just so people trying it out aren't surprised if it
> > > > doesn't multipath their device in the way they expect.
> > > 
> > > I think that ALUA support will be mainline acceptance criteria, and I am
> > > looking to add it now.
> > > 
> > > BTW, Hannes suggested to not use the DH ALUA support, so that means to
> > > separate out the core ALUA support from the DH stuff. So you have any
> > > opinion on that approach?
> > 
> > I would (perhaps naively) have thought that the device handlers would be
> > a useful abstraction for dealing with ALUA devices. But, Hannes knows
> > this code much better than me. like I said before, I'm no scsi expert.
> > 
> The main point of the device handlers was to inject a 'start' command
> whenever paths needed to be switched (Like you need to do for some
> active/passive arrays).
> But that really caused quite some issues with complexity, as you easily
> can get into array path ping-pong on path failure with no I/O being
> transmitted.
> 
> So for this implementation I would stick with implicit ALUA
> (most modern implementations have done so already anyway), and
> then there's no need using the device handlers.

That makes sense. Limiting support to implicit ALUA significantly lowers
the bar for getting ALUA working. AFAICS, It should just require getting
the path selecting code right.

-Ben

> 
> Cheers,
> 
> Hannes
> -- 
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
> HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


