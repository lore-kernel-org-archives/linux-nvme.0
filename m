Return-Path: <SRS0=47LT=HA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D675BC433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 21:13:10 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 661A764E02
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 21:13:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 661A764E02
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Date:To:From:
	Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=cxX0DpN9PKimIaIAlwCiKdrbYanVr38vhv6/ShDTMsc=; b=W0zFbdyjI29P7JBxFc45Pa/Cp
	PBkMsGqrK85Sc6CJQzrmoexs7yPmVDfQW9PfaJqL+xMrD0FaHlpbGIb0GKRg1346mPn5AR93IEN4d
	r6Y3lNHb8TxIHcM/dItNpAkmqHkXM8oEijBswSN1VjGRZcyG5qinr6GmE4mYepL+7c+GOdj3pfHKs
	8Lt/DK4xKoX/4M05FlusuwpcXeG6IMGNbB7UjaQY19FlQxg84Gy6BHv3mqO2daSaI7UCrc6V/1DkG
	cCtB4vfnsMCdkZs/jgDVm1nWCZ4vaPtJU5OPsGM4XQkPM7NKpLhFG7payGqdWZMWVPntoZfnURea1
	KS9uahNdA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l5b4l-0005h4-PQ; Fri, 29 Jan 2021 21:13:07 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5b4g-0005gB-O5
 for linux-nvme@lists.infradead.org; Fri, 29 Jan 2021 21:13:06 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1611954781; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ELziyxRxq0os75bZWDj0WSlkCPd3A4jJ0sXaouLtA0c=;
 b=e286cP4eB58xzy24GhggW+jUUZ5VU8I7CQOWC1D/L1rviYdasSvbol+rPMKd3OW4SrEwwv
 G8AsY4dyNSJkSUzQ50hpOhmAm7RYTkkk6h5uNPZeQXykSmXlp7h54hSLTtytOMUiPb3Kh3
 RWnT0BrbGYFdIkJY8PWKqQq1CT3Q3I8=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 8F7BBAE74;
 Fri, 29 Jan 2021 21:13:01 +0000 (UTC)
Message-ID: <0c56ef14e84354f9601dbe694c7550d77d990f54.camel@suse.com>
Subject: Re: [PATCH 26/35] monitor: implement starting discovery controllers
 on startup
From: Martin Wilck <mwilck@suse.com>
To: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org
Date: Fri, 29 Jan 2021 22:13:00 +0100
In-Reply-To: <18970cbc-1c58-9529-3bb5-919249e97b5c@grimberg.me>
References: <20210126203324.23610-1-mwilck@suse.com>
 <20210126203324.23610-27-mwilck@suse.com>
 <18970cbc-1c58-9529-3bb5-919249e97b5c@grimberg.me>
User-Agent: Evolution 3.38.2 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210129_161302_934297_F1AAE452 
X-CRM114-Status: GOOD (  18.68  )
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
Cc: Hannes Reinecke <hare@suse.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, 2021-01-29 at 13:06 -0800, Sagi Grimberg wrote:
> =

> > If the -U/--startup option is used, nvme monitor looks for exsiting
> > nvme controllers on startup, and runs a discovery on the associated
> > transport address (connection); i.e. tries to connect to a
> > discovery
> > subsystem on the same address, retrieve the discovery log pages,
> > and (if --autoconnect is given) connect all listed controllers.
> =

> Oh no no no no... This is a completely wrong assumption to make.
> Nothing
> suggest that an nvme controller will have a discovery controller on
> the
> same port.
> =

> There is a discovery controller and an NVM controller, the only
> connection between the two is that a discovery controller can
> refer to an nvme controller (or a different discovery controller).
> =

> Information about discovery controllers may be obtained in different
> ways, but it absolutely cannot be obtained by any nvme controller.
> =

> Now I understand a bit more on the --keep discussion. The monitor
> should today get discovery controller endpoints from a conf file
> (maybe discovery.conf) and in the future by any other automatic
> way, not even looking into the currently connected nvme controllers.
> =


I hear you. I'll drop this in the next version, no problem.=A0

I didn't expect that probing for a discovery controller was a problem.
IIUC, if we get an fc_udev_device event for a NVMe remote port, we
can't be sure that that remote port offers a discovery controller,
either. We try to connect, and give up if it fails.

Martin



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
