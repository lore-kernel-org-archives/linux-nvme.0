Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1DA8F55434
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Feb 2026 00:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wu6e7y6744AKrfSalZoNneCouriwnPLCWnCIppXtUnk=; b=nVwYhuAH4+VbqHnLuACJdgoxs9
	j5RInM0EXGkfzA/XzJiNKc9OLnsXEGruetj8/18oxvh0QrmpqzN6E6yAdRyw7kLsKRX7sBXOsBfR9
	2oPgx0cW8xDrZPopN2BGLuqjpaJGfSS558p7qbF1GGbrAX/BRMgKrBtRtpIaA3agQWITuGXygBzf6
	F4qBnXQ2nTj9Ea1aDFoAHPmnR73bpU3MbaA9kGVoQ64iDK9EvdwxPNQkmn61bGukgTHguMM8bg3ki
	S29ZsnzLDnJvjw2oPl3RHLIdMepHeFCLjlcOBIpRs2SrRUBq1tQ8Y9QJJKz3T1rvslEtRhhcqAWQ7
	BGcz/ETQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vv34l-000000030Hw-2i7W;
	Wed, 25 Feb 2026 00:48:27 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vv34h-000000030HZ-3Vlo
	for linux-nvme@lists.infradead.org;
	Wed, 25 Feb 2026 00:48:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771980502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wu6e7y6744AKrfSalZoNneCouriwnPLCWnCIppXtUnk=;
	b=QM/fRb+nyU371HGB7hOp6TMuCoxfS4ZpisSf8ke11JKVb4HRab6A7bFeS+OLbHrCAvfhDy
	onk/i+q0IfFovpAnmJQ3IXso5zkz3MdH74IzeowuWnZMiwq8vJbgitaMb3a2ClyNIzfEhW
	iz/NEL2ITfyNZkdwu3eldEHxOtuNwOY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-4PJYxqWAM6iAB9Q5q0qJVQ-1; Tue,
 24 Feb 2026 19:46:41 -0500
X-MC-Unique: 4PJYxqWAM6iAB9Q5q0qJVQ-1
X-Mimecast-MFC-AGG-ID: 4PJYxqWAM6iAB9Q5q0qJVQ_1771980400
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1B5AD1956052;
	Wed, 25 Feb 2026 00:46:40 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (unknown [10.6.23.247])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 266451800348;
	Wed, 25 Feb 2026 00:46:39 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.17.1) with ESMTPS id 61P0kbjW1637572
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Feb 2026 19:46:38 -0500
Received: (from bmarzins@localhost)
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.18.1/Submit) id 61P0kbXS1637571;
	Tue, 24 Feb 2026 19:46:37 -0500
Date: Tue, 24 Feb 2026 19:46:37 -0500
From: Benjamin Marzinski <bmarzins@redhat.com>
To: Mike Snitzer <snitzer@kernel.org>
Cc: John Garry <john.g.garry@oracle.com>, lsf-pc@lists.linux-foundation.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, dm-devel@lists.linux.dev
Subject: Re: [LSF/MM/BPF TOPIC] Native SCSI multipath support
Message-ID: <aZ5GbVxDT3gcS6WE@redhat.com>
References: <69349b51-72c2-47f9-948f-f89843af62e4@oracle.com>
 <aZnuSC0qYfw0hiwM@kernel.org>
MIME-Version: 1.0
In-Reply-To: <aZnuSC0qYfw0hiwM@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: SqfY6oh21KmsddsYbfAk8Ckj8lwdZpeMcYsTMn4-b5s_1771980400
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260224_164823_951676_F7F1A356 
X-CRM114-Status: GOOD (  26.02  )
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

On Sat, Feb 21, 2026 at 12:41:28PM -0500, Mike Snitzer wrote:
> On Fri, Feb 13, 2026 at 02:19:11PM +0000, John Garry wrote:
> > At ALPSS 25 I presented a proposal for Native SCSI multipath support. Let's
> > discuss this topic at LSFMM.
> > 
> > The idea for this is that SCSI could natively support multipath, like how
> > NVMe host driver does today. It is intended as an alternative to
> > dm-multipath support.
> > 
> > I have been working on the implementation and I plan to post patches in the
> > next cycle. I am looking at a 3-stage approach:
> > a. create a driver-agnostic multipath library, very heavily based on NVMe
> > host multipath support.
> > The library would support features such as path management, path
> > selection/iopolicy, failover recovery, PR, delayed removal, gendisk
> > management etc.
> > b. switch NVMe over to use this library
> 
> I can appreciate that the kernel to userspace interface of DM
> multipath is clearly unwanted (hence NVMe multipath and now SCSI
> multipath).
> 
> But you should really be switching DM-multipath over to using it too;
> or at least detailing _why_ the core of DM multipath
> (drivers/md/dm-mpath.c) cannot be updated to use this common backend
> library.
> 
> This line of work makes little sense to me if it just ignores
> dm-multipath.
> 
> Mike

Thinking about this work from a DM multipath perspective, I'm more
interested in how much it plans to handle the more annoying niche cases
of dealing with SCSI devices, like paths that confidently report that
they are able to accept IO, only to fail all IO sent to them. Also, I
wonder how/if this is planning on handling Persistent Reservations. The
arrays, I assume, are still going to see this as a collection of I_T
Nexuses (some of which may be down and unable to accept commands at any
given time, and to which new ones my be added) instead of a single one.

I also think this would be useful to talk about at LSF.

-Ben

> 
> > c. add native SCSI multipath support based on this common library
> > 
> > Thanks,
> > John
> > 
> > 
> > 


