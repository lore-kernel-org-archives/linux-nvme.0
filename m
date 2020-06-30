Return-Path: <SRS0=73dC=AL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3525C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jun 2020 13:21:04 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9685C206B6
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jun 2020 13:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G3mv+sSd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9685C206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kioxia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LudC7vdCUNwpZh+SENgJFCd2VmRBmmykcVdj78Vxu0Y=; b=G3mv+sSdYr9FQCCUANfIPivxn8
	PHhAHFVLAtqWUrJLRXwuftrslyMNkrN2WYK9a5WfLehHgNaU9knZkIKr2pkmX9NI6Ut8hO0Nn9bfv
	NXlhw5p4uuwQqOBEMOIWLuAiHWcwM6DR4BftzgWnQrOoT/3V+z6xgCycRBoA8/EbsbAd5tfGMPoao
	tvYwkT5lapKNdta5qQAYxZiABPu+jQcxUsjckLZdYEZRtK2XgYzS6+w4FwsgxFdOY/1GoGgAyyjRu
	kdnSgPfU/q+wtoQnHo+xHpG9Pf0Nq5pcoTXVFIbFcMut5PWnfp73vyTJHOLuLZttdcL251PenXfBG
	NCMBP3Lg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jqGC1-0002Gi-Rx; Tue, 30 Jun 2020 13:20:57 +0000
Received: from usmailhost21.kioxia.com ([12.0.68.226]
 helo=SJSMAIL01.us.kioxia.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqGBw-0002G9-RU
 for linux-nvme@lists.infradead.org; Tue, 30 Jun 2020 13:20:55 +0000
Received: from SJSMAIL01.us.kioxia.com (10.90.133.90) by
 SJSMAIL01.us.kioxia.com (10.90.133.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 30 Jun 2020 06:20:49 -0700
Received: from SJSMAIL01.us.kioxia.com ([fe80::39f9:a76d:ffe7:907a]) by
 SJSMAIL01.us.kioxia.com ([fe80::39f9:a76d:ffe7:907a%3]) with mapi id
 15.01.1779.004; Tue, 30 Jun 2020 06:20:49 -0700
From: Victor Gladkov <Victor.Gladkov@kioxia.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: RE: [PATCH V4] nvme-fabrics: reject I/O to offline device
Thread-Topic: [PATCH V4] nvme-fabrics: reject I/O to offline device
Thread-Index: AQHV8EL00Fj/6noqbUW6urzoMzTvMKhjpyAAgIw7YkCAAHeggIAAzl2AgACtlBA=
Date: Tue, 30 Jun 2020 13:20:49 +0000
Message-ID: <c3c61fdc2cfd4c6f894406679e4ef8e4@kioxia.com>
References: <20200302033004.19474-1-chaitanya.kulkarni@wdc.com>
 <CAOcd+r3VVcjM=deQxZYskw=E+qZN68PKAy6vL8yvyCc4FTxJgg@mail.gmail.com>
 <bb9948035bea461a8864a8cc88513e1b@kioxia.com>
 <c32f734c29e34ab6a419e2b1215e71ae@kioxia.com>
 <b9fca7a9-218f-ae62-9ecf-f56dff684a00@grimberg.me>
In-Reply-To: <b9fca7a9-218f-ae62-9ecf-f56dff684a00@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.93.66.127]
MIME-Version: 1.0
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Sagi.
Thank you for reviewing.
I'm going pull out new patch updated according to your comments.
In the meantime, see my comments below.

> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c index
set_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags);
> > +	dev_info(ctrl->device, "failfast expired set for controller %s\n",
> > +		ctrl->opts->subsysnqn);
> 
> What does the subsysnqn has to do with anything? just keep "failfast expired"[VG] 


[VG] I agree with you

> 
> > +	nvme_kick_requeue_lists(ctrl);
> > +out:
> > +	spin_unlock_irq(&ctrl->lock);
> 
> What is the lock protecting against? I don't see why this is needed.
> 

[VG]  You're right.

> > +}
> > +
> > +static inline void nvme_start_failfast_work(struct nvme_ctrl *ctrl) {
> > +	if (!ctrl->opts || ctrl->opts->fast_io_fail_tmo == 0)
> 
> the timeout disabled should be -1, 0 is to fail I/O right away.
> 
> Maybe also add "off" string as a -1 equivalent.
> 

[VG]  It's ok to me. I'll add "off" string option.

> > diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> > index 2a6c819..3a39714 100644
> > --- a/drivers/nvme/host/fabrics.c
> > +++ b/drivers/nvme/host/fabrics.c
> > @@ -631,6 +633,7 @@ static int nvmf_parse_options(struct
> nvmf_ctrl_options *opts,
> >   	opts->reconnect_delay = NVMF_DEF_RECONNECT_DELAY;
> >   	opts->kato = NVME_DEFAULT_KATO;
> >   	opts->duplicate_connect = false;
> > +	opts->fast_io_fail_tmo = NVMF_DEF_FAIL_FAST_TMO;
> >   	opts->hdr_digest = false;
> >   	opts->data_digest = false;
> >   	opts->tos = -1; /* < 0 == use transport default */ @@ -751,6
> > +754,19 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
> >   				pr_warn("ctrl_loss_tmo < 0 will reconnect
> forever\n");
> >   			ctrl_loss_tmo = token;
> >   			break;
> > +		case NVMF_OPT_FAIL_FAST_TMO:
> > +			if (match_int(args, &token)) {
> > +				ret = -EINVAL;
> > +				goto out;
> > +			}
> > +
> > +			if (token)
> > +				pr_warn("fail_fast_tmo != 0, I/O will fail on"
> > +					" reconnect controller after %d sec\n",
> > +					token);
> > +
> > +			opts->fast_io_fail_tmo = token;
> > +			break;
> 
> Again, -1 should disable, not 0.

[VG] You're right.

> 
> >   		case NVMF_OPT_HOSTNQN:
> >   			if (opts->host) {
> >   				pr_err("hostnqn already user-assigned: %s\n", @@ -
> 881,11 +897,14
> > @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
> >   		opts->nr_poll_queues = 0;
> >   		opts->duplicate_connect = true;
> >   	}
> > -	if (ctrl_loss_tmo < 0)
> > +	if (ctrl_loss_tmo < 0) {
> >   		opts->max_reconnects = -1;
> > -	else
> > -		opts->max_reconnects = DIV_ROUND_UP(ctrl_loss_tmo,
> > -						opts->reconnect_delay);
> > +	} else {
> > +		if (ctrl_loss_tmo < opts->fast_io_fail_tmo)
> > +			pr_warn("failfast tmo (%d) larger than controller "
> > +				"loss tmo (%d)\n",
> > +				opts->fast_io_fail_tmo, ctrl_loss_tmo);
> > +	}
> 
> it can be that ctrl_loss_tmo=-1 which means reconnect forever.

 [VG] OK

> > diff --git a/drivers/nvme/host/multipath.c
> > b/drivers/nvme/host/multipath.c index 54603bd..4b66504 100644
> > --- a/drivers/nvme/host/multipath.c
> > +++ b/drivers/nvme/host/multipath.c
> > @@ -278,9 +278,13 @@ static bool nvme_available_path(struct
> > nvme_ns_head *head)
> >
> >   	list_for_each_entry_rcu(ns, &head->list, siblings) {
> >   		switch (ns->ctrl->state) {
> > +		case NVME_CTRL_CONNECTING:
> > +			if (test_bit(NVME_CTRL_FAILFAST_EXPIRED,
> > +				     &ns->ctrl->flags))
> > +				break;
> > +			/* fallthru */
> 
> I absolutely don't see why this needs to happen. this setting is on a controller,
> so this absolutely should not affect the mpath device node. so nak on this.

[VG] In case of multipath is enabled we need announce the path as unavailable,
 otherwise the command will requeue but not aborted.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
