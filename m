Return-Path: <SRS0=YrQE=HG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 298DFC433DB
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Feb 2021 09:18:41 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CE6B64F4D
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Feb 2021 09:18:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CE6B64F4D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Date:To:From:
	Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=96Q+CWFgSIhd1X1kDSJz8zNna6y3gJW3yJJCoVOEc9w=; b=Qix+fHHgCb7097RB9fSfGmN+9
	+AW31z7/z21p5zYSk3HeLZiIPW5QIjJKqouHVReUlK6tsA8l98rteMevVq7BpOSLwxxYARFsax8iA
	qCB7WZC8Q2cHVYzBteKp28AcdYl8SNHXS6PfERXcw0pavjS6rrBE9lRqKI3HUFLRj7JkEssqa3wrb
	vA2NN+hSodHx6J+iYiORUye8mvcZBHV245LF4nu7j1sqw6nkmlV6+iQJ86c9bsgHuCW0/ok77ib/r
	JnhIfy/DMPVgB23fGj7DAFMoJJZnqCBvYeHksjTtxO/tbhk4wOyqQQhEeaPOr7ok5zBHo8yWb8gBa
	rtHx1WU0g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l7ama-0007sn-VZ; Thu, 04 Feb 2021 09:18:37 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7amZ-0007sO-6B
 for linux-nvme@lists.infradead.org; Thu, 04 Feb 2021 09:18:36 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1612430314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lYwQAnvNzDr9lX5UAcW3cj5HaSsjNai7eM2B+c6Me0s=;
 b=H8rnH6h1RAzEuGED1PFl9Ge9FTm0NZVTytGj+HW2T57KD8LgGqY6ZkxEMxv3CyN80SN7VX
 jxSSL5XhfQGsY7kwhrFb+nfLVdoeKZpLduaMLkH1DEu3LrhRSmPzmia+4wt+qvTtNh6yTV
 WGetkJOMjHV0+nvEna8PG610SGogNe8=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 07A4EAFFD;
 Thu,  4 Feb 2021 09:18:34 +0000 (UTC)
Message-ID: <d5bf9ad2b364ba7f07287b62f627e2263fc32458.camel@suse.com>
Subject: Re: [PATCH 08/35] monitor: add command line options to control logging
From: Martin Wilck <mwilck@suse.com>
To: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org
Date: Thu, 04 Feb 2021 10:18:33 +0100
In-Reply-To: <37259dc3-16f3-ef0c-fafa-d6a4749c5126@suse.de>
References: <20210126203324.23610-1-mwilck@suse.com>
 <20210126203324.23610-9-mwilck@suse.com>
 <37259dc3-16f3-ef0c-fafa-d6a4749c5126@suse.de>
User-Agent: Evolution 3.38.2 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210204_041835_445534_FF3B3EA5 
X-CRM114-Status: GOOD (  18.38  )
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
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, 2021-02-04 at 08:04 +0100, Hannes Reinecke wrote:
> On 1/26/21 9:32 PM, mwilck@suse.com=A0wrote:
> > From: Martin Wilck <mwilck@suse.com>
> > =

> > Standard syslog loglevels are used.
> > Options:
> > =

> > =A0 -S/--silent=A0=A0 to suppress LOG_NOTICE
> > =A0 -v/--verbose=A0 to enable LOG_INFO (overrides -S)
> > =A0 -D/--debug=A0=A0=A0 to enable LOG_DEBUG (overrides -S, -v)
> > =A0 -C/--clockstamps to enable time stamps on log messages.
> > =

> > I tried to use short options that don't conflict with options
> > from nvme connect-all, because many of those options might be
> > useful for the monitor, too.
> > =

> > Signed-off-by: Martin Wilck <mwilck@suse.com>
> > ---
> > =A0 monitor.c | 47 +++++++++++++++++++++++++++++++++++++++++------
> > =A0 1 file changed, 41 insertions(+), 6 deletions(-)
> > ... and if you had moved the logging functionality prior to the
> > monitor =

> code, this patch could be merged with the main monitor functionality,
> too.

I expected that reviewers preferred smaller chunks. If that's not the
case, fine with me, I'll change i

Thanks,
Martin



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
