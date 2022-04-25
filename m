Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE47C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Apr 2022 13:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fLDjMMr17b6gjXmcUt4YGEQgUN/6tw0n2nk0vRNthkg=; b=2RI7gZ2llADpY9gNWw5UGOmFUx
	o2Rf3ZydaSOmmiilyQLBDMhjVG133LhgbQbqK5i1Kp3TqP/MW3IFvZ60nwXNPANKK+vx9SfdkO0tY
	C6X5mWowjkDRsOkazmOt2IN+ySEDflCzvi44s7t4pl5qSUwqcaNSkSGHkSlcFAp3zL62+36n1bxQy
	zEkc21FvZ8N5zrdWV6LMnyLPKJqrIegplO1a7VwfebpOT+gk+ksK0wpMoX9mhey6WArtkX4EiKnMV
	V77EpJEmks9zGutnzJXcYjEE678Laf13/yklH6nZtD9c8IoJo2VxkkYO4q0Z3rR0shZzTKaVLRYa4
	UMC6WxKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nizAe-009n20-7v; Mon, 25 Apr 2022 13:54:32 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nizAS-009myg-Ry
 for linux-nvme@lists.infradead.org; Mon, 25 Apr 2022 13:54:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650894856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fLDjMMr17b6gjXmcUt4YGEQgUN/6tw0n2nk0vRNthkg=;
 b=BS6XpWIHIS3I3TE53SPr8z/vY7HLP6g4/HC4q7UsGLhwuP7aZeqpe3q8Y0G/osFYaYgM2S
 GFF3owO6R9oZGOxvgZFtDzgv2V+/U2w0qOksXs/mtpCfOAUFdVPKkFRGIkjueTLGW0GuYr
 +FmzgDzS6noovlY2j/FE5Ya3SFI8dTo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-457-2xn6oT34M66myQpVV5QgNg-1; Mon, 25 Apr 2022 09:54:13 -0400
X-MC-Unique: 2xn6oT34M66myQpVV5QgNg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8C84D1014A6C;
 Mon, 25 Apr 2022 13:54:12 +0000 (UTC)
Received: from ws.net.home (unknown [10.36.112.12])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6FCD7463E0B;
 Mon, 25 Apr 2022 13:54:11 +0000 (UTC)
Date: Mon, 25 Apr 2022 15:54:09 +0200
From: Karel Zak <kzak@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 util-linux@vger.kernel.org,
 Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Subject: Re: [PATCH] nvme: add namespace paths links
Message-ID: <20220425135409.zov6h63i76e2ljj6@ws.net.home>
References: <20220401092855.90652-1-hare@suse.de>
 <20220405054205.GA23466@lst.de>
 <289ee526-8f3f-9a2b-eef4-70816eb4f42e@suse.de>
 <20220405054836.GA23647@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405054836.GA23647@lst.de>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220425_065421_014100_4E2B9B73 
X-CRM114-Status: GOOD (  25.84  )
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

On Tue, Apr 05, 2022 at 07:48:36AM +0200, Christoph Hellwig wrote:
> On Tue, Apr 05, 2022 at 07:46:40AM +0200, Hannes Reinecke wrote:
> > On 4/5/22 07:42, Christoph Hellwig wrote:
> >> On Fri, Apr 01, 2022 at 11:28:55AM +0200, Hannes Reinecke wrote:
> >>> It is really annoying to always have to loop through the entire
> >>> /sys/block directory just to find the namespace path links for
> >>> a single namespace in libnvme/nvme-cli.
> >>> So provide links to the namespace paths for efficient lookup.
> >>
> >> I think having some form of links would be useful.  Quite a while ago
> >> Thadeu looked into adding some form of relationship for lsblk and
> >> friends.  Maybe it would be good to sync up and make sure whatever
> >> links we are adding would be useful for all users?
> >>
> > Care to elaborate?
> > Using the block device name is the most straightforward way here; we don't 
> > have a good enumeration to leverage as the paths are essentially just a 
> > linked list.
> >
> > We sure can have a subdirectory 'paths', and stick the links in there.
> > If that helps with lsblk ...
> 
> I personally don't care.  But I've added Thadeu and the util-linux list
> to get everyone on board.
 
lsblk internally can accept arbitrary relations between devices
(and libsmartcols can display it). If you introduce something new or
extend the current holders/slaves, it will probably be accessible for
lsblk to use it.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


