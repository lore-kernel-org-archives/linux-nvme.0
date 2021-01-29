Return-Path: <SRS0=47LT=HA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7B1C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 21:06:46 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C634964E0A
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 21:06:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C634964E0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=fhz2GWqR9E7BBmf8R82R6PBIx+ZSq2J3HmyywYE6U68=; b=fBb8RJms+O8a1fo3R4pmfmEta
	FVg2Ea63oTqZKkJbQQrNY9WvYTqug66pQ/tXUZtpEWie26Clmpmy5kppcS7dppwuXfM6PHeFCrxpY
	N3JCabHPUjfpX3UAQU3C6Ozs48QlWnIAlEpl3QIUpgrRJicju7vAIySXSF3Egxhf0+kJOP/bB3JMH
	MC5PoNKmKPKJ4f9PaysI/grGGqh6Dw3W8DySB7KrvOFZaxllQqz7phmfYLrJ1LtKegIcq4clNjHQ5
	H2yQW4wwauWFQVAA6eTItCHadiDQcScRkfMLYiSfuO3vK1Ixfihck+SBh23hqCiTP99S1DDOYn9Xi
	htR2AGkEQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l5ayW-00057s-Qq; Fri, 29 Jan 2021 21:06:40 +0000
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5ayT-00057N-O2
 for linux-nvme@lists.infradead.org; Fri, 29 Jan 2021 21:06:38 +0000
Received: by mail-wr1-f47.google.com with SMTP id 7so10207962wrz.0
 for <linux-nvme@lists.infradead.org>; Fri, 29 Jan 2021 13:06:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0QG8R7uTuNjWDTpLjpvv56B0imstxWRm4uNo5yPwxaM=;
 b=WsqyaunxXleObyecV7Nxat6SXoY+QoUPVJRovUSBikJZ+26QqUFCaV0nHiwno4rNGT
 z+7sX1d5RceyrpDAtpE2CtODaDF92R31PoqmLWLSMuMaRIzoUvOy5vYHZXQT+K26W29x
 aw3BL0DSSU4s6pA+8b3dBUcJ3lE9iSGBUuPUE3oZXI/c0QYCw155iVFGU9dd8wgtw04n
 FFBYBJezxs4wkO6LQu9fl4TfmVTryhCAeGWM+S6HZMkbEIO2q2Iwi3QqmVaG+Czktd3n
 TJRhN66nrh+9t7IZtgakRcq+eX5XCIhZGmZzSCKYGTkgELIIBQ2sDh6xBT9LRf1QXUgD
 CAwA==
X-Gm-Message-State: AOAM530ZmQS4rvQk3l+Aql4aO3VKG0AgBSl4KzXU2lM0BKAUv/BQbAHg
 AmpyT+umXDzYTaVt5t6mHvo=
X-Google-Smtp-Source: ABdhPJyJVNmf73FhnJJaczWRBWmlbD+zN8CJgBVs0xLlZX00WqiM92Ia/9d8+i90oNi6TkC7Lm+pag==
X-Received: by 2002:a05:6000:1372:: with SMTP id
 q18mr6458917wrz.280.1611954396442; 
 Fri, 29 Jan 2021 13:06:36 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:db7:4f5:6eca:f1ab?
 ([2601:647:4802:9070:db7:4f5:6eca:f1ab])
 by smtp.gmail.com with ESMTPSA id e11sm13964643wrt.35.2021.01.29.13.06.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Jan 2021 13:06:35 -0800 (PST)
Subject: Re: [PATCH 26/35] monitor: implement starting discovery controllers
 on startup
To: mwilck@suse.com, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20210126203324.23610-1-mwilck@suse.com>
 <20210126203324.23610-27-mwilck@suse.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <18970cbc-1c58-9529-3bb5-919249e97b5c@grimberg.me>
Date: Fri, 29 Jan 2021 13:06:31 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210126203324.23610-27-mwilck@suse.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210129_160637_849193_DEB1194C 
X-CRM114-Status: GOOD (  15.31  )
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


> If the -U/--startup option is used, nvme monitor looks for exsiting
> nvme controllers on startup, and runs a discovery on the associated
> transport address (connection); i.e. tries to connect to a discovery
> subsystem on the same address, retrieve the discovery log pages,
> and (if --autoconnect is given) connect all listed controllers.

Oh no no no no... This is a completely wrong assumption to make. Nothing
suggest that an nvme controller will have a discovery controller on the
same port.

There is a discovery controller and an NVM controller, the only
connection between the two is that a discovery controller can
refer to an nvme controller (or a different discovery controller).

Information about discovery controllers may be obtained in different
ways, but it absolutely cannot be obtained by any nvme controller.

Now I understand a bit more on the --keep discussion. The monitor
should today get discovery controller endpoints from a conf file
(maybe discovery.conf) and in the future by any other automatic
way, not even looking into the currently connected nvme controllers.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
