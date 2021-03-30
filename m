Return-Path: <SRS0=nD3g=I4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF54C433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Mar 2021 16:19:52 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3771F61964
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Mar 2021 16:19:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3771F61964
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:Date:Cc:To:From:
	Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=FSA33OsZMx5kQMmoOkELU3Ijp/RBqC2cSZhRdvmhBPs=; b=OIljQ2/zWqjXkLaKRv251o9Vd
	xpfESx8LuE3gMiGOwkq2LYXnyEpNY1Or9yPbqP3Sll2Bm3dFuTGw57FXDSqc4C1inr2uv+pn0Zva6
	KTak9NC1iTZdYiY7dYgcNiESlK4tNxfG6FVPraMOCiH+gb8q6DSSNBbkqy3e5hJpSqTofv3r9Dph0
	vekfbHVPUemhHI2AbG85RX53kePeGkdoNyBWR3nK1GGG76QN/jKX+4Zasc66JrhM/5lA95b3/veyF
	8b+dkFlFxAM0osO78bUQrofeuCpKVVeZTXsx6tRaxC7tgTEUvVuJjk6XPlbtIIwGBfbS3+redG8dw
	JSda4d5dg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRH5c-004KWP-TW; Tue, 30 Mar 2021 16:19:37 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRH5W-004KUj-EG
 for linux-nvme@lists.infradead.org; Tue, 30 Mar 2021 16:19:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617121166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JFv1ahKTG3Hg+q8+rh0hBintBsqnTi45PnEj6YrihWg=;
 b=fh38Y1q6BSDPUTmsnCPzdU8eLgeAlMWduSsSQfShQQb21TYMw9FbMeIAM7dO5AOpCnSXGv
 eDlrJRMjcyetUqGXR+TAjpTgmlvyiWCDD2uo2cgwGdcABgstRI9YexHAazaZpO7CDBQP0W
 1nuhBizc1CoAhEDUfco6TjfFR9nUKsQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-iEFJhmOSM5eE0JPGdTRcog-1; Tue, 30 Mar 2021 12:19:22 -0400
X-MC-Unique: iEFJhmOSM5eE0JPGdTRcog-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1EAA91005D5A;
 Tue, 30 Mar 2021 16:19:20 +0000 (UTC)
Received: from ovpn-112-207.phx2.redhat.com (ovpn-112-207.phx2.redhat.com
 [10.3.112.207])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2C71D39A66;
 Tue, 30 Mar 2021 16:19:18 +0000 (UTC)
Message-ID: <2fc7a320c86f75507584453dd2fbd744de5c170d.camel@redhat.com>
Subject: Re: [PATCH v2] nvme-tcp: Check if request has started before
 processing it
From: "Ewan D. Milne" <emilne@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, Jens Axboe
 <axboe@fb.com>, Hannes Reinecke <hare@suse.de>, Keith Busch
 <kbusch@kernel.org>,  Christoph Hellwig <hch@lst.de>
Date: Tue, 30 Mar 2021 12:19:18 -0400
In-Reply-To: <70af5b02-10c1-ab0b-1dfc-5906216871b4@grimberg.me>
References: <20210301175601.116405-1-dwagner@suse.de>
 <6b51a989-5551-e243-abda-5872411ec3ff@grimberg.me>
 <20210311094345.ogm2lxqfuszktuhp@beryllium.lan>
 <70af5b02-10c1-ab0b-1dfc-5906216871b4@grimberg.me>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210330_171930_727689_7F2502C5 
X-CRM114-Status: GOOD (  28.67  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, 2021-03-15 at 10:16 -0700, Sagi Grimberg wrote:
> > Hi Sagi,
> > 
> > On Fri, Mar 05, 2021 at 11:57:30AM -0800, Sagi Grimberg wrote:
> > > Daniel, again, there is nothing specific about this to nvme-tcp,
> > > this is a safeguard against a funky controller (or a different
> > > bug that is hidden by this).
> > 
> > As far I can tell, the main difference between nvme-tcp and
> > FC/NVMe,
> > nvme-tcp has not a FW or a big driver which filter out some noise
> > from a
> > misbehaving controller. I haven't really checked the other
> > transports
> > but I wouldn't surprised they share the same properties as FC/NVMe.
> > 
> > > The same can happen in any other transport so I would suggest
> > > that if
> > > this is a safeguard we want to put in place, we should make it a
> > > generic one.
> > > 
> > > i.e. nvme_tag_to_rq() that _all_ transports call consistently.
> > 
> > Okay, I'll review all the relevant code and see what could made
> > more
> > generic and consistent.
> > 
> > Though I think nvme-tcp plays in a different league as it is
> > exposed to
> > normal networking traffic and this is a very hostile environment.
> 
> It is, but in this situation, the controller is sending a second
> completion that results in a use-after-free, which makes the
> transport irrelevant. Unless there is some other flow (which is
> unclear
> to me) that causes this which is a bug that needs to be fixed rather
> than hidden with a safeguard.
> 

The kernel should not crash regardless of any network traffic that is
sent to the system.  It should not be possible to either intentionally
of mistakenly contruct packets that will deny service in this way.

-Ewan




_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
