Return-Path: <SRS0=YD4V=6H=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D061CC2BA19
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Apr 2020 08:20:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81AE0208E4
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Apr 2020 08:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Xv1swOPq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81AE0208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=s11h9gKFCGh57A9rAyeaZ9ZYayW+vcP2IvUQmyF6Q7U=; b=Xv1swOPqXsGRIYYNc5AB6eYJF
	NzZiFm3ju0eefYpKHNeVp+MWY6vh/BbKIYLFk/pOnZj06fMEZzMAuiH7/7n/YjeBMKYCnHSV+93jw
	nH7m8v0RhNezetMspS+HIrR1LYtYBOUKTC1LqtMknqkvGbEZiBLy4xYRaaB/x9EdWUlt/9kEoL6J5
	hZ9rMJvvdU8HMi4ygmKlGd+NEef6TZTXfALUKANvtQIWuoBxURGT8RwFhe5FTcc5DP95HEySg+iK7
	7C9x2eAppRvkQcMSEEmqPkiZKOoNsB8BiXeeB3HtwOC5Tu57N2oxwug96OTEnrZijgAtKqiQ/Rf/R
	wyrTXXENA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jRX60-0004cl-Tf; Thu, 23 Apr 2020 08:20:32 +0000
Received: from mail-pl1-f193.google.com ([209.85.214.193])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jRX5x-0004cO-1K
 for linux-nvme@lists.infradead.org; Thu, 23 Apr 2020 08:20:30 +0000
Received: by mail-pl1-f193.google.com with SMTP id s10so2088538plr.1
 for <linux-nvme@lists.infradead.org>; Thu, 23 Apr 2020 01:20:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VKj/cNd55CFlf2wKqmLw5I63Jki0F5KMCa0t+wOaLIw=;
 b=aF6frlwgWveZZ3PgyXbEua2HFajr0FcW/f310rItQPoZXg9+yUQuV6NZXbgOhTOJvc
 pqT9Me0xOGVYISsftaJSxX2EOi9wQVPNHEiPeiQGtrF7pP6Kkbbt7guXUd2Ya3IEbSV5
 exJWSr0UMIvnYiHhZkCZq4Dk1uehYY/ZuAOB3l3Y+4VQiWbdnwZjvg7vxOe8k4IpR5Yw
 E8ZnfSoh0Y555LfY+9XV0DQLO6MzXauw4apEw1Sz0pPMu3I1ZlAhxFWbW69fSSZWPbBz
 fdKHCrUsOeIMIQylt2d/9AalW8C3P84AHZMib/SfbIlG+JJV98KKHXqIUCOjZiaWFc+8
 x/Dw==
X-Gm-Message-State: AGi0Pub9D4YZiH1SH8FUe4v8U3FWvQkGmN20yWcoAyileUiCsYcZWs6n
 eo44iQ7CMsM80JTzJ8iReXckOan+
X-Google-Smtp-Source: APiQypLGCw42UaAWVfa9LIPRPnslKjXhwYxM/LXVMYN+zGb5wdo1GSw94Mb+2MGVuCRhaaurP45OAg==
X-Received: by 2002:a17:902:b711:: with SMTP id
 d17mr2674388pls.333.1587630027307; 
 Thu, 23 Apr 2020 01:20:27 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:ec9f:3a3e:8aef:64e5?
 ([2601:647:4802:9070:ec9f:3a3e:8aef:64e5])
 by smtp.gmail.com with ESMTPSA id y3sm1626971pjb.41.2020.04.23.01.20.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2020 01:20:26 -0700 (PDT)
Subject: Re: [PATCH V3 0/7] nvmet: add target ns revalidate support
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Christoph Hellwig <hch@lst.de>
References: <20200419234856.59901-1-chaitanya.kulkarni@wdc.com>
 <20200422081936.GA25035@lst.de>
 <BYAPR04MB4965850E7D094ED44D1C360786D30@BYAPR04MB4965.namprd04.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <3f112b29-91cc-620c-6262-de3e322a29fc@grimberg.me>
Date: Thu, 23 Apr 2020 01:20:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB4965850E7D094ED44D1C360786D30@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200423_012029_073022_8E01A70A 
X-CRM114-Status: GOOD (  18.53  )
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
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> A. Regarding host querying information :-
> 
> That means host needs to query id-ns periodically to have correct
> size for the block device, until then it will have wrong size
> (unless it calls ns-scan) which will break the host software assumption
> about block device mapped on the namespace. See [1].
> 
> Isn't calling id-ns for size validation also defeats the purpose of
> whole AEN mechanism that we have implemented for host/target and
> present in the spec ?
> 
> B. Regarding Overhead :-
> 
> Can you please explain what exactly the overhead is ?
> 
> With my understanding :-
> 
> As mentioned in the cover letter this design provides
> a mechanism (since it is a driver feature) and not the policy,
> so it doesn't force any particular behavior onto user, i.e.
> users can adjust tunables provided for this feature and use
> feature the way they want it or even disable it and rely on host
> based periodic id-ns-size-change-rescan sequence.
> 
> Overhead in terms of design :-
> We can change the current polling so that instead of scanning all the
> susbys/ns then sleep, we scan in batch (N namespaces) for each poll.
> 
> Overhead is in terms of code then we can :-
> 1. Move core.c maintenance thread related code into separate file,
>      (name suggestions are welcome).
> 2. Add Kconfig options to enable/disable this feature for target.
> 
> In case of performance :-
> 1. User should apply policy based on their requirement through
>      tuneables since different users can have different
>      machine/platforms/environment.

This is cumbersome in my mind... and the polling part is
kinda bothering me...

I still think that having this sit in userspace is so much more
elegant really.

A simple service that watches with inotify on the device_paths (files or
bdevs - which are also files) and trigger revalidate via configfs when
it gets an attrib event.

We can even have it watch configfs and automatically add watchers
when new namespaces are enabled and remove watchers when namespaces are
disabled, so it can be completely zero touch.

This can sit as a simple systemd service that nvmetcli installs.

I'd very much prefer this over the proposed approach...

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
