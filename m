Return-Path: <SRS0=x9Yf=BX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C327C433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Aug 2020 19:04:01 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E15BF206B2
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Aug 2020 19:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="e1akVKtn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MFllnN10"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E15BF206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=a8/k7zJ6TEF2Nkqky528ViCaitA+g/vJgIxwIKGScYc=; b=e1akVKtnP9hWvFVG74C6gC05q
	ZqdxNya2BRJk8HoXJ6LVPx3Me3lU70v/futlFTey3g7Fljoos4E8nDECbH0MGJ+XN7XjdU+S7dayt
	dNyfKP8jhd+iMEiEeHp/i/nXUSh1R2abGjsZkNVaYV2Jwyj7LCWhOpvi6/4nIQbyAYMTepfhMp0oH
	0KxORoxW+SKXoistbsrhGAoyWnoavNEa/yIEoeBpes8tjG5jivy1O4OqIKES6H7G6otujNtixOs8a
	4C+VAxFBDe0IgNQfE+TZkjOQnAVBzJLEq2RyNxb4q09J8FMcXHfDFovxKJkpREPd1Pq0Y2xnBYdjx
	5PrHMNUVw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k6IW3-0004mK-HR; Thu, 13 Aug 2020 19:03:55 +0000
Received: from us-smtp-2.mimecast.com ([205.139.110.61]
 helo=us-smtp-delivery-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6IW0-0004l5-9k
 for linux-nvme@lists.infradead.org; Thu, 13 Aug 2020 19:03:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597345431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I+zVvv6CdoA6KJ7ARCfhXCJ5uADm3ZjX5bTQ/ewEwfo=;
 b=MFllnN10aBO7M119k/0V9FDbB/reDhbqre++aN3fhS2o5+w549jXhjamJtFJWiLWrWH9n3
 c4xudG8P9eBgAeqGJ5jC1JVAfunPmtitat+EhGEKvQmh5XEMN5DHcfikCQGR7n8Zn57zhZ
 taoYPsTrjYpkmLzXut5CO1Ul6emUk7s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-bNM0J8yLNpeNbFS0oF8i_Q-1; Thu, 13 Aug 2020 15:03:47 -0400
X-MC-Unique: bNM0J8yLNpeNbFS0oF8i_Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DDB74873088;
 Thu, 13 Aug 2020 19:03:45 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CD61F6F9C9;
 Thu, 13 Aug 2020 19:03:42 +0000 (UTC)
Date: Thu, 13 Aug 2020 15:03:42 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [RESEND PATCH] nvme: explicitly use normal NVMe error handling
 when appropriate
Message-ID: <20200813190342.GA6607@redhat.com>
References: <20200807000755.GA28957@redhat.com>
 <510f5aff-0437-b1ce-f7ab-c812edbea880@grimberg.me>
 <20200807045015.GA29737@redhat.com>
 <fec745aa-0091-ee1f-cb0f-da9e18cf0aa2@grimberg.me>
 <20200810143620.GA19127@redhat.com>
 <20200810172209.GA19535@redhat.com>
 <20200813144811.GA5452@redhat.com>
 <20200813153623.GA30905@infradead.org>
 <20200813174704.GA6137@redhat.com>
 <20200813184349.GA8191@infradead.org>
MIME-Version: 1.0
In-Reply-To: <20200813184349.GA8191@infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=msnitzer@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200813_150352_433602_62A6D06F 
X-CRM114-Status: GOOD (  20.06  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
 linux-nvme@lists.infradead.org, dm-devel@redhat.com,
 Ewan Milne <emilne@redhat.com>, Chao Leng <lengchao@huawei.com>,
 Keith Busch <kbusch@kernel.org>, "Meneghini, John" <John.Meneghini@netapp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Aug 13 2020 at  2:43pm -0400,
Christoph Hellwig <hch@infradead.org> wrote:

> On Thu, Aug 13, 2020 at 01:47:04PM -0400, Mike Snitzer wrote:
> > This is just a tweak to improve the high-level fault tree of core NVMe
> > error handling.  No functional change, but for such basic errors,
> > avoiding entering nvme_failover_req is meaningful on a code flow level.
> > Makes code to handle errors that need local retry clearer by being more
> > structured, less circuitous.
> > 
> > Allows NVMe core's handling of such errors to be more explicit and live
> > in core.c rather than multipath.c -- so things like ACRE handling can be
> > made explicitly part of core and not nested under nvme_failover_req's
> > relatively obscure failsafe that returns false for anything it doesn't
> > care about.
> 
> If we're going that way I'd rather do something like the (untested)
> patch below that adds a dispostion function with a function that
> decides it and then just switches on it:

YES!  That is such a huge improvement (certainly on a code clarity
level).  I haven't reviewed or tested the relative performance or
function of before vs after (will do) but I really like this approach.

Thanks,
Mike


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
