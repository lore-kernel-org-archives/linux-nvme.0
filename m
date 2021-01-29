Return-Path: <SRS0=47LT=HA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE85C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 19:10:15 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B34B564DFB
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 19:10:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B34B564DFB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=GCkBP3Mej5x3S22agyFsyLezsC0hTauzpibxXajDda4=; b=Fsg3SaGD6OYfFUow7OU8sGAZa
	uYdd82BVMPJU24KBf1e2HtSyvUBJo1KSsTm9KLXdDk2vXe5DjRJFOJ19g0A9TzT6IaRk9a6RqfRXc
	02ImVNE7WhYF2lKKSYiWXGCCXtIzpWJW2qjMhqk7a53lLBVqO7MDd/t8Rt5iER0V+0vDv1AxDv/UN
	nLAFKczhrD0yu3BS/C+caAMjzpi++2mYNY0GwZ2/oua5Ghoa0UrB3vsuF9Ua/5gSvUR+K7Rc551JL
	TS8N5zuXGmT+oXAORqMGWHlNZxId42ClwwmFbp0rkBmdPAILDjjjoOpmALlG+lVU1BrXyf8+1dTCM
	hTI2gkjqw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l5Z9m-0007Rr-Sl; Fri, 29 Jan 2021 19:10:10 +0000
Received: from mail-pl1-f181.google.com ([209.85.214.181])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5Z9k-0007R8-Oi
 for linux-nvme@lists.infradead.org; Fri, 29 Jan 2021 19:10:09 +0000
Received: by mail-pl1-f181.google.com with SMTP id s15so5773478plr.9
 for <linux-nvme@lists.infradead.org>; Fri, 29 Jan 2021 11:10:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+lrMWb7Oyx5jYevB2YBEqmj840Mrg+rzlPckth+vtuc=;
 b=Ao+YYsOMcutVvnVmtRX45vsenZQIHO3AU+RmtWubJwO2pz+FPg7fZeHAQqysyD8Agy
 YiXOQRTfcLJrKKAuOacA/KG8f969/WYuP+/eMEq4g//ctlCqhMhUd1PmFa0eUBoAZttj
 pl17NVxV3PrhOtEe9dAtgWBEzR7IhqAluCjZmxT98lR2DUh4K9L9pfUzxf/mOez2gy/C
 uouJEHUG6tFSoHOfOMUwOxWb9Jds8gdOB5sLvnlFO71gZC8JeZMVmmnjN/1yv33TBUsy
 EtRMBuSJ2ugjWJOA/SoCYy9jrxZ+iXqyLD/E7G3H2E8lOf80vYIAanW4F/F2XTf3hiMt
 1GXA==
X-Gm-Message-State: AOAM533JXb3TTOBomb3suRNU7JsvHW8hlgqQ1H2N3WRZEmLLNtv4sJCM
 FmxxPCAca5/VShn7R05evZU=
X-Google-Smtp-Source: ABdhPJx72l7BuzrjZsGvzOVzDngyR4XHaWVb+8fs5JKo4RpOq5ZKiakIEi6JD3umys7wZHSWG9tafg==
X-Received: by 2002:a17:90b:4905:: with SMTP id
 kr5mr6073030pjb.1.1611947407577; 
 Fri, 29 Jan 2021 11:10:07 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:db7:4f5:6eca:f1ab?
 ([2601:647:4802:9070:db7:4f5:6eca:f1ab])
 by smtp.gmail.com with ESMTPSA id b11sm8659343pjg.27.2021.01.29.11.10.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Jan 2021 11:10:07 -0800 (PST)
Subject: Re: [PATCH 35/35] monitor: add option --keep/-K
To: mwilck@suse.com, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20210126203324.23610-1-mwilck@suse.com>
 <20210126203324.23610-36-mwilck@suse.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <90145500-c2c5-023c-6d69-27db6ee600a7@grimberg.me>
Date: Fri, 29 Jan 2021 11:10:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210126203324.23610-36-mwilck@suse.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210129_141008_838576_EFC0E90E 
X-CRM114-Status: GOOD (  11.01  )
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


> From: Martin Wilck <mwilck@suse.com>
> 
> With this option, "nvme monitor" will keep created discovery controllers
> running even after it exits. If running in the initrd, this is will be
> done automatically. That has the advantage that the new monitor instance
> that will be started automatically after switching root can simply take
> over the already created discovery controllers.

Why not make it the default?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
