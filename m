Return-Path: <SRS0=Tdqk=DE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D2B8C4346E
	for <linux-nvme@archiver.kernel.org>; Sun, 27 Sep 2020 11:49:06 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55E5C2388B
	for <linux-nvme@archiver.kernel.org>; Sun, 27 Sep 2020 11:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ViBkl+Lv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55E5C2388B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kioxia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+beyVKr3hFVFxD4QfJO98uxgWXSqZsOzRnkUqxshcss=; b=ViBkl+LvyFJOJLEWYQDh+9X8F
	3h7gFeQiWc6B7i/UcN5mzcOV4INyk8UvwdPbIwF6TeVnY6xuUifcpJh7frdcuqz0dUEdoHri+IyfS
	Ick51zjVSD4lXlmbi6vrdZEO9PrflUrp0Mn7cAMl/sESHnekrPid3mjw0ffpZQfSNijhYr3TEKp/Y
	m+86pOBNIVs7PuqEuD9Tvj3jrVfwB6OFHBWyEvjYu9XNPwIxUlxAsEvDbKjsZFfzf16NqbsyMMYUu
	zCy4SQyXVGHgxweeJx71GK7QpvmXPbTzClHSabpGFJn+ZHzYMHBP6JDSoRV70/kcPOYaBBWbNdvsJ
	iwoIj0Adg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kMVAl-0007yy-4L; Sun, 27 Sep 2020 11:48:55 +0000
Received: from usmailhost21.kioxia.com ([12.0.68.226]
 helo=SJSMAIL01.us.kioxia.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kMVAh-0007y5-JQ
 for linux-nvme@lists.infradead.org; Sun, 27 Sep 2020 11:48:54 +0000
Received: from SJSMAIL01.us.kioxia.com (10.90.133.90) by
 SJSMAIL01.us.kioxia.com (10.90.133.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Sun, 27 Sep 2020 04:48:44 -0700
Received: from SJSMAIL01.us.kioxia.com ([fe80::60c4:7e85:9b22:956]) by
 SJSMAIL01.us.kioxia.com ([fe80::60c4:7e85:9b22:956%4]) with mapi id
 15.01.1779.007; Sun, 27 Sep 2020 04:48:44 -0700
From: Victor Gladkov <Victor.Gladkov@kioxia.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: RE: [PATCH v8] nvme-fabrics: reject I/O to offline device
Thread-Topic: [PATCH v8] nvme-fabrics: reject I/O to offline device
Thread-Index: AdaE3WJOPkx5atnISP62E9UfuahFiwJWQXMAAaJa5hA=
Date: Sun, 27 Sep 2020 11:48:44 +0000
Message-ID: <f9188630aec6471e8cf6ab9d3f1cf989@kioxia.com>
References: <0f73b032a39748c3beb8c1cb743f0783@kioxia.com>
 <52462339-084c-90ae-4ca7-62e2ae37dd7e@grimberg.me>
In-Reply-To: <52462339-084c-90ae-4ca7-62e2ae37dd7e@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.93.66.127]
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200927_074851_642742_6AFF9DB6 
X-CRM114-Status: GOOD (  27.89  )
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
Cc: James Smart <james.smart@broadcom.com>, "Ewan D. Milne" <emilne@redhat.com>,
 Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> On 9/18/20 11:39 PM, Sagi Grimberg wrote:
> 
> On 9/6/20 11:21 PM, Victor Gladkov wrote:
> > Commands get stuck while Host NVMe-oF controller is in reconnect
> > state. NVMe controller enters into reconnect state when it loses
> > connection with the target. It tries to reconnect every 10 seconds
> > (default) until successful reconnection or until reconnect time-out is
> > reached. The default reconnect time out is 10 minutes.
> >
> > Applications are expecting commands to complete with success or error
> > within a certain timeout (30 seconds by default).  The NVMe host is
> > enforcing that timeout while it is connected, never the less, during
> > reconnection, the timeout is not enforced and commands may get stuck
> > for a long period or even forever.
> >
> > To fix this long delay due to the default timeout we introduce new
> > session parameter "fast_io_fail_tmo". The timeout is measured in
> > seconds from the controller reconnect, any command beyond that timeout
> > is rejected. The new parameter value may be passed during 'connect'.
> > The default value of 0 means no timeout (similar to current behavior).
> 
> I think you mean here -1.

You right. It should be -1

> 
> >
> > We add a new controller NVME_CTRL_FAILFAST_EXPIRED and respective
> > delayed work that updates the NVME_CTRL_FAILFAST_EXPIRED flag.
> >
> > When the controller is entering the CONNECTING state, we schedule the
> > delayed_work based on failfast timeout value. If the transition is out
> > of CONNECTING, terminate delayed work item and ensure failfast_expired
> > is false. If delayed work item expires then set
> > "NVME_CTRL_FAILFAST_EXPIRED" flag to true.
> >
> > We also update nvmf_fail_nonready_command() and
> > nvme_available_path() functions with check the
> > "NVME_CTRL_FAILFAST_EXPIRED" controller flag.
> >
> >   /*
> > diff --git a/drivers/nvme/host/multipath.c
> > b/drivers/nvme/host/multipath.c index 54603bd..d8b7f45 100644
> > --- a/drivers/nvme/host/multipath.c
> > +++ b/drivers/nvme/host/multipath.c
> > @@ -278,9 +278,12 @@ static bool nvme_available_path(struct
> > nvme_ns_head *head)
> >
> >   	list_for_each_entry_rcu(ns, &head->list, siblings) {
> >   		switch (ns->ctrl->state) {
> > +		case NVME_CTRL_CONNECTING:
> > +			if (test_bit(NVME_CTRL_FAILFAST_EXPIRED,
> > +				     &ns->ctrl->flags))
> > +				break;
> >   		case NVME_CTRL_LIVE:
> >   		case NVME_CTRL_RESETTING:
> > -		case NVME_CTRL_CONNECTING:
> >   			/* fallthru */
> >   			return true;
> >   		default:
> 
> This is too subtle to not document.
> The parameter is a controller property, but here it will affect the mpath device
> node.
> 
> This is changing the behavior of "queue as long as we have an available path"
> to "queue until all our paths said to fail fast".
> 
> I guess that by default we will have the same behavior, and the behavior will
> change only if all the controller have failfast parameter tuned.
> 
> At the very least it is an important undocumented change that needs to be
> called in the change log.

The multipath may be stuck on reconnected controller even forever.
Moreover, all commands will be returned with error status,
but the path will not be switched.
And in this case, the presence of the additional path looks pointless.

I suggest use the failfast parameter for each path separately.
It can also serve as the priority of each path.

Regards,
Victor
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
