Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6858EFCE58
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Mar 2026 02:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yBUhNsBoeECXQ2g42ZbRUoURW/9mr3wjydrCeND0ozI=; b=SYQkAkI+ArbQCvSy/KwOyenUB2
	0a0zs2afxdvtGjcPH7jRn3u49YjGRZNMX/TB5eAMbkl47O6HAnOIIM8P7vMwD2+34WNjigbvADcWy
	6fH/bgAMKw6w4S+5mXILuARZxDDhYCH5wDhASgeJtMTWu3ir3o95aJNrQPTfiYvmGCPWZA/kyvHpF
	aT3RYsIHUtyVQaNzuMSjTNBPTp2/4PouJfsU+jZA1T4uElUMDl3eEx2/98ibiWTQ7MWmhV1WHyuID
	07derWT/AZYtcM+N04FG31tLVG+LrLmSNvngonjOUJqUJrZwG3369TuY88grTlpndIPG/mpvaUPpM
	uPsPC++Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxyam-00000000nGv-1EiV;
	Thu, 05 Mar 2026 02:37:36 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxyai-00000000nG5-2F1a
	for linux-nvme@lists.infradead.org;
	Thu, 05 Mar 2026 02:37:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772678250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yBUhNsBoeECXQ2g42ZbRUoURW/9mr3wjydrCeND0ozI=;
	b=KobrVl5FqHEc6W6QcqHB7jfoApopxRvvfVGJGfAqkxZIkCmBwymKP5pa6etg+5MYbNUGUG
	GqSwLxxYH6/DQ14BKbu+Ih+20y5kWnC6V2JVWIM/tI95gBnryWdpjgAvwC0CON05Aj0lW1
	g6Ku+RHIhYp2aO1otjJM7Q7ZXAx8qPw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-408-gnIwOrr_MGynkDKdRAbF8A-1; Wed,
 04 Mar 2026 21:37:26 -0500
X-MC-Unique: gnIwOrr_MGynkDKdRAbF8A-1
X-Mimecast-MFC-AGG-ID: gnIwOrr_MGynkDKdRAbF8A_1772678244
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 19BF119560A5;
	Thu,  5 Mar 2026 02:37:23 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (unknown [10.6.23.247])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DEF321800671;
	Thu,  5 Mar 2026 02:37:21 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.17.1) with ESMTPS id 6252bKqD1952898
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 4 Mar 2026 21:37:20 -0500
Received: (from bmarzins@localhost)
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.18.1/Submit) id 6252bIIF1952897;
	Wed, 4 Mar 2026 21:37:18 -0500
Date: Wed, 4 Mar 2026 21:37:18 -0500
From: Benjamin Marzinski <bmarzins@redhat.com>
To: John Garry <john.g.garry@oracle.com>
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
        martin.petersen@oracle.com, james.bottomley@hansenpartnership.com,
        hare@suse.com, jmeneghi@redhat.com, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, michael.christie@oracle.com,
        snitzer@kernel.org, dm-devel@lists.linux.dev,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/24] scsi-multipath: add
 scsi_mpath_{start,end}_request()
Message-ID: <aajsXqau3gHFIqVG@redhat.com>
References: <20260225153627.1032500-1-john.g.garry@oracle.com>
 <20260225153627.1032500-11-john.g.garry@oracle.com>
 <aafNnO6o2yoeLjPs@redhat.com>
 <93752514-3225-4cdf-b9a5-e0964d693b5b@oracle.com>
MIME-Version: 1.0
In-Reply-To: <93752514-3225-4cdf-b9a5-e0964d693b5b@oracle.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: 3UonBy_n3PacPtmSUjjUtcsPsX3N0rSDt91Qt39WaBA_1772678244
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260304_183732_992330_9CA85C8F 
X-CRM114-Status: GOOD (  18.91  )
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

On Wed, Mar 04, 2026 at 11:11:08AM +0000, John Garry wrote:
> On 04/03/2026 06:13, Benjamin Marzinski wrote:
> > > +	scsi_mpath_end_request(req);
> > > +
> > >   	/*
> > >   	 * In the MQ case the command gets freed by __blk_mq_end_request,
> > >   	 * so we have to do all cleanup that depends on it earlier.
> > This looks wrong. We start accounting in scsi_queue_rq(), and we need to
> > end it whenever we complete or requeue the request, otherwise the
> > accounting will get off. But not all requests go through
> > scsi_end_request(). scsi_mpath_failover_req(), for instance, calls
> > blk_mq_end_request() directly, and other functions, like
> > scsi_queue_insert() call blk_mq_requeue_request(). I'm pretty sure that
> > this should go in scsi_complete(), as well in the error path of
> > scsi_queue_rq().
> 
> ok, let me check that further.
> 

I think I was a little hasty here. Looking at sd_mpath_start_command()
and sd_mpath_end_command() in patch 17, I can see that they protect
against repeat calls, so requeueing the request should be o.k. There's
still a problem when scsi_mpath_failover_req() calls blk_mq_end_request()
directly, and when scsi_queue_rq() exits with a failure where the
request won't requeued (all the returns except BLK_STS_OK,
BLK_STS_RESOURCE, and BLK_STS_DEV_RESOURCE).

-Ben

> Thanks for the notice.


