Return-Path: <SRS0=47LT=HA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9AC5C433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 01:52:37 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1825364DFB
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 01:52:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1825364DFB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=uuNS3ZRy4qg520tVDqbYkqmKNj6RPn2mH7ZqFORgF/E=; b=frzA7X07BqhMtyKang6N34Xu4
	iwvuW7johWEqbNAS+76k9ZnrnLm3afvPu2zzWNgcMOKW0DYruuUd7rMKqsE6XXsvo7eLRB3x3r/z1
	W7SEUh5jv13ECVFwDELBnCX1jqeJCm+tiXDVyV+zGdKc/b2WzRqmQaw7wiu/qLN/Vb0M9SZJmnB3M
	uUnDLK13EPwOjtU4sbENwtJCOIEuexD97hfI8m/axhPSLwdIiTNizZbMYJM9Liz5bE8o6NDdYrXDr
	rQfT06R6cGM3LqwKAkw8izOmKF9C35aPTdanWvpQGUa6RkpwDG6GfdmalseiFJ0vOHJimX2TvqG9q
	hnYixZ23A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l5Ixa-0002N4-Ed; Fri, 29 Jan 2021 01:52:30 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5IxX-0002Mh-OF
 for linux-nvme@lists.infradead.org; Fri, 29 Jan 2021 01:52:28 +0000
Received: by mail-wm1-f44.google.com with SMTP id 190so5703296wmz.0
 for <linux-nvme@lists.infradead.org>; Thu, 28 Jan 2021 17:52:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=s4DUTN68QnB8NqAj9ICsPKiBjgwv6A0KvXgFmj5hXoQ=;
 b=q4cOU1VAdCw56zh9NkQzqMQS44psC+tWgTHAtrQodnyFW8IDTMcFzRzbXalNyx5cSY
 baRaTrn6xRFaCGCVLukW4wEV9OEoTcInugv1A1uG1qQBB1fGb5lTXMyuzmVdTcMIdpjb
 +vgsRfNNb0gnAmos8uowNr9gMUDblN7DbhpEw9MVOrq+8NjHxii7vytLYYEcYMlvngJP
 nilGY6KOttKwkNgL870JO6KZBfws2ZUEFGBZHh5L4qGjS9g5Yech7XsHcNmyWo19Ftfj
 CMrwZ6cmECMzQAdKo0cnQYk8VSwjtH74EGjxS+OY9wwtLvloljNZ1fTnIaY0yBbH3sB0
 cuZQ==
X-Gm-Message-State: AOAM530hTkvsMY2jsgSk3nKRCd7hOhud9IcSOOpgjj3e9HX5lmTcG8q4
 unLn0ciC+8Gb5ikyWWwbzeI=
X-Google-Smtp-Source: ABdhPJx2IKfgA8sxKES0Yq+BKGh13H0WFtiHpOTIuxDpuRw/O4n7nmrrIC3GBpws6MFto1GlEDgcMQ==
X-Received: by 2002:a1c:bb46:: with SMTP id l67mr1604501wmf.111.1611885146673; 
 Thu, 28 Jan 2021 17:52:26 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:3d48:4849:d506:e578?
 ([2601:647:4802:9070:3d48:4849:d506:e578])
 by smtp.gmail.com with ESMTPSA id n16sm8880507wrj.26.2021.01.28.17.52.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Jan 2021 17:52:26 -0800 (PST)
Subject: Re: [PATCH 13/35] monitor: disable nvmf-autoconnect udev rules in
 autoconnect mode
To: mwilck@suse.com, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20210126203324.23610-1-mwilck@suse.com>
 <20210126203324.23610-14-mwilck@suse.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <8990bb65-fb2d-7ab1-82cd-210c4c4dba13@grimberg.me>
Date: Thu, 28 Jan 2021 17:52:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210126203324.23610-14-mwilck@suse.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210128_205227_842827_7C794E04 
X-CRM114-Status: GOOD (  16.29  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 1/26/21 12:33 PM, mwilck@suse.com wrote:
> From: Martin Wilck <mwilck@suse.com>
> 
> If autoconnect is enabled, disable the respective udev rules
> by symlinking /run/udev/rules.d to /dev/null, in order to avoid
> the connections being set up by the monitor and the udev workers
> at the same time. This is probably the preferred mode of operation
> for the monitor.
> 
> Users can override this by copying 70-nvmf-autoconnect.rules
> from /usr/lib/udev/rules.d to /etc/udev/rules.d (/etc/udev/rules.d
> takes precedence over /run/udev/rules.d).
> 
> If the symlink can't be created for some reason, autoconnect will
> be disabled. There is  only one exception: If
> /run/udev/rules.d/70-nvmf-autoconnect.rules already points to
> /dev/null at startup, autoconnect can be left on, but the symlink
> isn't removed on exit.

Can't we just document that just one should be enabled and skip
the entire thing? Especially when its not critical if both run..

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
