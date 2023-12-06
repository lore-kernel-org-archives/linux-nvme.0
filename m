Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 983D8C4167B
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Dec 2023 03:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JJlJspfrBuALAvTn0p2X3IEh4nGAcAADWiZo61JlgsA=; b=mhrSrIXfTsJtDbRCqEStZVRdOQ
	AaxKKDj2jOFDJWBma8xnIB0qR8gyYmyJlrRmZ8W0LxCrbJXEKqpLzVBbhQibmH7Zwk8u7zIG/Z+Re
	/7AeZAk3f1P51DzxMyLyZj2+ouMqM5rfUTWpOZ0i4DLl9uNls08gg1Cp/jUgYiSmvMGjJiD7XROXB
	ZHaWSlQ4JLrGQ83iphGgdZZBPwD8ugGJobAJmYWJ4ygaOaA8slb3ASjm5ocKsxIWMieLcCsiduWJ/
	DJbFzO1qc95ZKm1vq8aDkFSbgH0eO+B+JphgXE43J+VePiTlC1dqheqgslrYbi/iFzbUOU5Faqoys
	Cq6D9rHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rAiHC-008vv4-0B;
	Wed, 06 Dec 2023 03:08:42 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rAiH8-008vuX-2P
	for linux-nvme@lists.infradead.org;
	Wed, 06 Dec 2023 03:08:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701832117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JJlJspfrBuALAvTn0p2X3IEh4nGAcAADWiZo61JlgsA=;
	b=DtRYbOA4pYyff0dqWYC/3DE10NSy0NUvcqLh+rlla+G0vnjqLbE3ZHw2sbyc+Ek0oXUPtP
	+h84mZoUb4EG3D20DRf+vpJWajrFK7QPXUialDJTVqWa7Ds/RKWLGJwrZBzXVlevmSMINB
	GESN4j4pu1EKnf+Oab1bYklqmdlTGTI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-222-Uj0iBqCaNJiZCR-08QATHg-1; Tue,
 05 Dec 2023 22:08:31 -0500
X-MC-Unique: Uj0iBqCaNJiZCR-08QATHg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 37B2629AB3F1;
	Wed,  6 Dec 2023 03:08:31 +0000 (UTC)
Received: from fedora (unknown [10.72.120.3])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 21E512026D66;
	Wed,  6 Dec 2023 03:08:23 +0000 (UTC)
Date: Wed, 6 Dec 2023 11:08:17 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Jeff Moyer <jmoyer@redhat.com>, Keith Busch <kbusch@meta.com>,
	linux-nvme@lists.infradead.org, io-uring@vger.kernel.org,
	axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	asml.silence@gmail.com, linux-security-module@vger.kernel.org,
	Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH 1/2] iouring: one capable call per iouring instance
Message-ID: <ZW/loVJu0+11+boh@fedora>
References: <20231204175342.3418422-1-kbusch@meta.com>
 <x49zfypstdx.fsf@segfault.usersys.redhat.com>
 <ZW4hM0H6pjbCpIg9@kbusch-mbp>
 <ZW6jjiq9wXHm5d10@fedora>
 <ZW6nmR2ytIBApXE0@kbusch-mbp>
 <ZW60WPf/hmAUoxPv@fedora>
 <ZW9FhsBXdPlN6qrU@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZW9FhsBXdPlN6qrU@kbusch-mbp>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231205_190838_856702_9B0449C5 
X-CRM114-Status: GOOD (  29.83  )
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

On Tue, Dec 05, 2023 at 08:45:10AM -0700, Keith Busch wrote:
> On Tue, Dec 05, 2023 at 01:25:44PM +0800, Ming Lei wrote:
> > On Mon, Dec 04, 2023 at 09:31:21PM -0700, Keith Busch wrote:
> > > Good question. The "capable" check had always been first so even with
> > > the relaxed permissions, it was still paying the price. I have changed
> > > that order in commit staged here (not yet upstream):
> > > 
> > >   http://git.infradead.org/nvme.git/commitdiff/7be866b1cf0bf1dfa74480fe8097daeceda68622
> > 
> > With this change, I guess you shouldn't see the following big gap, right?
> 
> Correct.
>  
> > > Before: 970k IOPs
> > > After: 1750k IOPs
>  
> > > Note that only prevents the costly capable() check if the inexpensive
> > > checks could make a determination. That's still not solving the problem
> > > long term since we aim for forward compatibility where we have no idea
> > > which opcodes, admin identifications, or vendor specifics could be
> > > deemed "safe" for non-root users in the future, so those conditions
> > > would always fall back to the more expensive check that this patch was
> > > trying to mitigate for admin processes.
> > 
> > Not sure I get the idea, it is related with nvme's permission model for
> > user pt command, and:
> > 
> > 1) it should be always checked in entry of nvme user pt command
> > 
> > 2) only the following two types of commands require ADMIN, per commit
> > 855b7717f44b ("nvme: fine-granular CAP_SYS_ADMIN for nvme io commands")
> > 
> >     - any admin-cmd is not allowed
> >     - vendor-specific and fabric commmand are not allowed
> > 
> > Can you provide more details why the expensive check can't be avoided for
> > fast read/write user IO commands?
> 
> It's not necessarily about the read/write passthrough commands. It's for
> commands we don't know about today. Do we want to revisit this problem
> every time spec provides another operation? Are vendor unique solutions
> not allowed to get high IOPs access?

Except for read/write, what other commands are performance sensitive?

> 
> Secondly, some people have rediscovered you can abuse this interface to
> corrupt kernel memory, so there are considerations to restricting this

Just wondering why ADMIN won't corrupt kernel memory, and only normal
user can, looks it is kernel bug instead of permission related issue.

> to CAP_SYS_ADMIN anyway, so there's no cheap check available today if we
> have to go that route.

If capable(CAP_SYS_ADMIN) is really slow, I am wondering why not
optimize it in task_struct?


Thanks, 
Ming


