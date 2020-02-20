Return-Path: <SRS0=sGEd=4I=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D3EC11D00
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Feb 2020 08:35:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10CA0208C4
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Feb 2020 08:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XJWggeyr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10CA0208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=aTCX6JvOV76Dyyl4BY+N/O5tu43h2U0ceGSXpc6Jqqc=; b=XJWggeyrS3AyEJ6f8F3agu3MG
	tptIQ5Hu5EjzRD0hKwx+5PfEyoVubOLUrBfy79yJpLSBkH3Zo21DXXVK7K7E9iaLs4M5pSEHKB4aH
	dcyjdQZX/c8RPoMsphh6kQozvOHLS1fyOQdVbvcaeVwmxIVF1+ZziBOFCytn0JyibMIBgzeGdG9gx
	HR0O35T1m/ZvJG/5txM5MwFQP0Hox1ljBqsFNjlhbyKwu0Y1ukbE+D3F27+zmdAcyHjl5xZbvFJAI
	wWFIi38k5NYcoHNvu6EIrbILW5Zz8B9uZtDmZytt/sCrVkGo+T5RNcqgIq0waCjbPnPrPAdv7fwGE
	eoNtdQbVQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j4hIQ-0007D0-EP; Thu, 20 Feb 2020 08:34:58 +0000
Received: from mail-pl1-f195.google.com ([209.85.214.195])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j4hIM-0007CZ-El
 for linux-nvme@lists.infradead.org; Thu, 20 Feb 2020 08:34:57 +0000
Received: by mail-pl1-f195.google.com with SMTP id e8so1264262plt.9
 for <linux-nvme@lists.infradead.org>; Thu, 20 Feb 2020 00:34:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=E8S1UlJIWhyhkhEqwL1UfPHfV1cX3lJU2StBU1XD4qo=;
 b=SlW02nOo6Og1svTUEkn8I0HeKGI74+BeazYfFgAWzXoqi1daSvy0SmdqTZQM1ZAHtP
 ysy37IWyXkWJoqKLms+JpPcBGuLORcJYBxG+67wDeLL1+/McPbQblES2A7y4tl50kJRh
 wuYDr6lyZ9/rFiSNPUwMizcGkukNO//ztmhDytHfCn/PjaTmN7Sn2PnQoxmlmRF5sgIT
 vpWT/mF9ry+jDDVOV/7uMK+ZXdUnYewgkL1XYBFmosjkJ8JpqvtS86LLmX/+VWv7Ja3K
 6Y1OvrYXX9utCYXTV2hxeD8Zpegx++hicPPRIVoAng4kwh5MkvQmXT8qdvALSApzpuf0
 bC4g==
X-Gm-Message-State: APjAAAWKWvR6h5s5wkf6RwY9k1OcqT9qIj+AKkHNhCBtiVUcd4EfpaC7
 6VrGJ1+irjwFR0LjSE+5m0U=
X-Google-Smtp-Source: APXvYqxT1oubQSnbMr1QIkbaDLIZuEI69lAJ3Ub3sno5ya7K5Ia4Kq2vpaON9Y9iq9cNzN/oRWwHcA==
X-Received: by 2002:a17:90a:191:: with SMTP id 17mr2325083pjc.88.1582187693558; 
 Thu, 20 Feb 2020 00:34:53 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:3910:5e55:b19d:2395?
 ([2601:647:4802:9070:3910:5e55:b19d:2395])
 by smtp.gmail.com with ESMTPSA id f1sm2246643pjq.31.2020.02.20.00.34.52
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Feb 2020 00:34:52 -0800 (PST)
Subject: Re: [PATCH v3] nvme-fabrics: reject I/O to offline device
To: Christoph Hellwig <hch@infradead.org>,
 Victor Gladkov <Victor.Gladkov@kioxia.com>
References: <2d77d20698b14aa6ae261a71d239c50b@kioxia.com>
 <20200219152849.GB13942@infradead.org>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <7ac74c23-db96-56e0-ad6e-24bb4df1934b@grimberg.me>
Date: Thu, 20 Feb 2020 00:34:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200219152849.GB13942@infradead.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200220_003454_758370_C5B9E86B 
X-CRM114-Status: GOOD (  14.64  )
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
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 James Smart <james.smart@broadcom.com>, Mike Snitzer <snitzer@redhat.com>,
 Hannes Reinecke <hare@suse.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> +static void nvme_failfast_work(struct work_struct *work)
>> +{
>> +	struct nvme_ctrl *ctrl = container_of(to_delayed_work(work),
>> +			struct nvme_ctrl, failfast_work);
>> +
>> +	spin_lock_irq(&ctrl->lock);
>> +	if (ctrl->state == NVME_CTRL_CONNECTING) {
>> +		set_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags);
>> +		dev_info(ctrl->device, "failfast expired set for controller %s\n", ctrl->opts->subsysnqn);
> 
> Please break up the line.
> 
> But looking at the use of NVME_CTRL_FAILFAST_EXPIRED, it almost seems
> like this is another controller state?

It actually is a controller state. this is just adding another state
without really fitting it into the state machine. I'd personally
would want that to happen, but I know James had some rejects on
this.

If this does end up as a first class controller state we need
to define the transitions.. Maybe something like this:
--
digraph nvme_host {
         node [shape = doublecircle]; new deleting;
         node [shape = circle];

         new;
         connecting;
         live
         resetting;
         failfast;
         deleting;
         dead;

         new -> connecting               [ label = 
"connecting\ncontroller" ]
         connecting -> live              [ label = "controller\nconnected" ]
         live -> resetting               [ label = "error detected\nor 
user initiated" ]
         resetting -> connecting         [ label = 
"reconnecting\ncontroller" ]
         connecting -> live              [ label = "reconnected 
controller\nreconnect_delay <= fast_fail_tmo" ]
         connecting -> failfast          [ label = "reconnect_delay > 
fast_fail_tmo" ]
         connecting -> deleting          [ label = "disconnected 
controller\nctrl_loss_tmo <= fast_fail_tmo\nor user initiated" ]
         failfast -> live                [ label = 
"controller\nreconnected" ]
         failfast -> deleting            [ label = "disconnected 
controller\nctrl_loss_tmo > fast_fail_tmo" ]
         deleting -> dead                [ label = "controller 
died\nduring deletion" ]
}
--

Note: for graphic display put this in a file named f.dot
and view with: dot f.dot -Tsvg | display


Also, I still say that its default changes the existing behavior which
is something we want to avoid.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
