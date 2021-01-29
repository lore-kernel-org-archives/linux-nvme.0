Return-Path: <SRS0=47LT=HA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7736CC433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 14:17:01 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E78EB64DEB
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 14:17:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E78EB64DEB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Date:To:From:
	Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3WtZ8EJ1ochflQssCHqGM7ezrYGvMFPN5H6YPtawMKY=; b=ErDnaY6iDGCP4IrXXYnHn6xIO
	6/2vFuCKwRnbeLGPk8w5G9OGRnzFzrpcILT/TPZp/lVbm2PeI0h7bITOC6/KFrgMyGfo92pxMATd3
	gRuBGjAZKNex1supkkIN7b7bjPHEY7DLDxe/8PehgwHYjNlJHhiM7RCOxQ/GRcZa7vGA/Px+61N41
	d2wmQ+5Mxv/Vpu/PIwfiKkELreaAMAZGU6lgcjwHcADUbaVVmyoj8JqDlXO01+CEoGYh0M700BSFC
	fx+QD3lckRkE9GE2NNtaAqgXoysRSwMEtjkUH9fM7w0mRhwqe922fxtt4T8zvoNdt/A//4UinBkGT
	91NomM3uA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l5UZw-0005wC-7W; Fri, 29 Jan 2021 14:16:52 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5UZq-0005vk-9t
 for linux-nvme@lists.infradead.org; Fri, 29 Jan 2021 14:16:49 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1611929802; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9kgukIpqoEPi63rRDb8upaAiMkJ1BN7Qk3fn4P39uh8=;
 b=l7RDf+29v+hge+YhlpSECtj9Qzl7945On6zcBYTAIkwYJJywBSXWuXHfDOS0hTVdb1vbCP
 t+Ova0u/HTElfNSFFFE4Htc1zWVVDn6A3+gcSbkD8yDW0XmAJJuna834i7Sv8b+B4FnLyS
 XzgNJsuiYLxiTK6kAI5vL9zDc7edbNA=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 08C36B16A;
 Fri, 29 Jan 2021 14:16:42 +0000 (UTC)
Message-ID: <f6d3cc4105475207eab760d1d2e1c1693f3c3e16.camel@suse.com>
Subject: Re: [PATCH 13/35] monitor: disable nvmf-autoconnect udev rules in
 autoconnect mode
From: Martin Wilck <mwilck@suse.com>
To: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org
Date: Fri, 29 Jan 2021 15:16:40 +0100
In-Reply-To: <8990bb65-fb2d-7ab1-82cd-210c4c4dba13@grimberg.me>
References: <20210126203324.23610-1-mwilck@suse.com>
 <20210126203324.23610-14-mwilck@suse.com>
 <8990bb65-fb2d-7ab1-82cd-210c4c4dba13@grimberg.me>
User-Agent: Evolution 3.38.2 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210129_091647_205466_70F46B94 
X-CRM114-Status: GOOD (  20.46  )
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

On Thu, 2021-01-28 at 17:52 -0800, Sagi Grimberg wrote:
> =

> =

> On 1/26/21 12:33 PM, mwilck@suse.com=A0wrote:
> > From: Martin Wilck <mwilck@suse.com>
> > =

> > If autoconnect is enabled, disable the respective udev rules
> > by symlinking /run/udev/rules.d to /dev/null, in order to avoid
> > the connections being set up by the monitor and the udev workers
> > at the same time. This is probably the preferred mode of operation
> > for the monitor.
> > =

> > Users can override this by copying 70-nvmf-autoconnect.rules
> > from /usr/lib/udev/rules.d to /etc/udev/rules.d (/etc/udev/rules.d
> > takes precedence over /run/udev/rules.d).
> > =

> > If the symlink can't be created for some reason, autoconnect will
> > be disabled. There is=A0 only one exception: If
> > /run/udev/rules.d/70-nvmf-autoconnect.rules already points to
> > /dev/null at startup, autoconnect can be left on, but the symlink
> > isn't removed on exit.
> =

> Can't we just document that just one should be enabled and skip
> the entire thing? Especially when its not critical if both run..

It's not critical, but it makes no sense to have the rules enabled when
the monitor runs. And having to mask/unmask them manually is a pain.=A0

It could be done in the systemd service file using ExecStartPre /
ExecStopPost, with small restrictions (we couldn't distinguish whether
the rules were already masked before we started). That would be more
transparent for users.

I'm ok with not doing it automatically if that's generally preferred.

Regards
Martin





_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
