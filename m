Return-Path: <SRS0=YrQE=HG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96AC8C433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Feb 2021 09:21:20 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DBBA64F47
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Feb 2021 09:21:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DBBA64F47
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Date:To:From:
	Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=x1A7oJrRCwDam/Z0BceRopqYRTvxzyenuO88Zkxj1lI=; b=baVODJ8ODOqLcuc0UMT0GLYrE
	yf0tBDerAI2Pu0mtFfIOdOdmYuKcXa4tL33+mlmEdTPE9YMy7IsrXutHmVV/Ob1G7e5etJhWYhjOt
	UCxmk7r3IP1YM5qczjXhWJfIKRlnilhiHqMlLKOlPLlDPxAdnz1X+MLdXBiB7KsgEHpIdFrYSTH+p
	Yq9y9NLs1Dfbt5HXo57mhdKa3oqdDpW3MTCpwGCWnd5bm8wk6zKKhgSe9/lJ+TUBpArzgmhRoDo+k
	4pYWpD0XXMrsNePou96XIkjpW1i7ELjDWysdEYRyjZ8/IqpAXQHYURDFcpQ+UYdmmSgnSpYAOLxxV
	Quny7JuZQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l7apA-0008ED-NC; Thu, 04 Feb 2021 09:21:16 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7ap8-0008Df-7d
 for linux-nvme@lists.infradead.org; Thu, 04 Feb 2021 09:21:14 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1612430473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bFW0tgEDiaoMUVeCxpg8wVb0ftDrVrU3PJLkrW20go8=;
 b=XHxhQfvDiBS97ePKJe2C9EZjqcJuRK9r8d2VOZY35svhaaD+MFbgjp2apK34W6yPjvS/jK
 FX0eZP64S/5uEfVbdBI832IR93si39CAeuecSnv0o4AvOQwXCNfpckKTQahvvfl2lOCfdL
 jCGaAzcfqKzqQXPe6H52WPL6LXTtM/w=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 0BC58AFFD;
 Thu,  4 Feb 2021 09:21:13 +0000 (UTC)
Message-ID: <17afdd6d41a9e7294157c11567dee797752a21e3.camel@suse.com>
Subject: Re: [PATCH 10/35] fabrics: export do_discover(), build_options()
 and config
From: Martin Wilck <mwilck@suse.com>
To: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org
Date: Thu, 04 Feb 2021 10:21:12 +0100
In-Reply-To: <5572e869-cd25-15ca-e95b-b4304e19d83b@suse.de>
References: <20210126203324.23610-1-mwilck@suse.com>
 <20210126203324.23610-11-mwilck@suse.com>
 <5572e869-cd25-15ca-e95b-b4304e19d83b@suse.de>
User-Agent: Evolution 3.38.2 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210204_042114_394004_A5D1873E 
X-CRM114-Status: GOOD (  13.50  )
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

On Thu, 2021-02-04 at 08:09 +0100, Hannes Reinecke wrote:
> On 1/26/21 9:32 PM, mwilck@suse.com=A0wrote:
> > =A0 =

> > +/* Symbols used by monitor.c */
> > +
> > +struct config {
> > +=A0=A0=A0=A0=A0=A0=A0char *nqn;
> > +=A0=A0=A0=A0=A0=A0=A0char *transport;
> > +=A0=A0=A0=A0=A0=A0=A0char *traddr;
> > +=A0=A0=A0=A0=A0=A0=A0char *trsvcid;
> > +=A0=A0=A0=A0=A0=A0=A0char *host_traddr;
> > +=A0=A0=A0=A0=A0=A0=A0char *hostnqn;
> > +=A0=A0=A0=A0=A0=A0=A0char *hostid;
> > +=A0=A0=A0=A0=A0=A0=A0int=A0 nr_io_queues;
> > +=A0=A0=A0=A0=A0=A0=A0int=A0 nr_write_queues;
> > +=A0=A0=A0=A0=A0=A0=A0int=A0 nr_poll_queues;
> > +=A0=A0=A0=A0=A0=A0=A0int=A0 queue_size;
> > +=A0=A0=A0=A0=A0=A0=A0int=A0 keep_alive_tmo;
> > +=A0=A0=A0=A0=A0=A0=A0int=A0 reconnect_delay;
> > +=A0=A0=A0=A0=A0=A0=A0int=A0 ctrl_loss_tmo;
> > +=A0=A0=A0=A0=A0=A0=A0int=A0 tos;
> > +=A0=A0=A0=A0=A0=A0=A0char *raw;
> > +=A0=A0=A0=A0=A0=A0=A0char *device;
> > +=A0=A0=A0=A0=A0=A0=A0int=A0 duplicate_connect;
> > +=A0=A0=A0=A0=A0=A0=A0int=A0 disable_sqflow;
> > +=A0=A0=A0=A0=A0=A0=A0int=A0 hdr_digest;
> > +=A0=A0=A0=A0=A0=A0=A0int=A0 data_digest;
> > +=A0=A0=A0=A0=A0=A0=A0bool persistent;
> > +=A0=A0=A0=A0=A0=A0=A0bool matching_only;
> > +};
> > +extern struct config cfg;
> > +
> > +#define BUF_SIZE 4096
> > +
> > +int build_options(char *argstr, int max_len, bool discover);
> > +int do_discover(char *argstr, bool connect);
> > +
> > =A0 #endif
> > =

> =

> Please name is 'struct config fabrics_cfg'. 'cfg' is used as a
> generic =

> name throughout the code, and using the same name in a header might
> lead to an accidental name clash.

Will do (the reason I didn't in the first place was that I wanted to
minimize changes of existing code, but you're right of course).

Thanks,
Martin



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
