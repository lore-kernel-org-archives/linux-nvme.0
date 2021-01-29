Return-Path: <SRS0=47LT=HA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3353C433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 21:12:14 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3535F64E04
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 21:12:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3535F64E04
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Odmz4oaCto7H1LA6rRsu6o9U6bo6GiGvehpCG91tAPc=; b=DZ3i+cfdgVioPTho+6eNbt3C9
	IfBkoXDu6CxN2IpnJemotZcuWCM/8gGjI+OKy2NfC6+i35IfZFFrv6fwoWB159dt/gORcBh1aCYpw
	cwW+3zBPz2n6XwZMZxARrCO+ZfNQ85nl5dcx+2ijsremz1z9hfQ5/0znNDjwuCEEdRvZ5dI/+Xzaf
	Lo0Rel5NmE8va8bY57pZSX3P7pBkGMFQBbiYkKw682sjOAgfHY4rvZlPtXfERvsb+JhXtJFGcUDgs
	4KMNdxqoHBaq8pc3FvALJ47Ib9153qNbwdoeYA7KuyDg149t1p523JzlK2Q9Pa+SlT+OUK+n3KwG9
	/YKsextCQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l5b3n-0005bW-PN; Fri, 29 Jan 2021 21:12:07 +0000
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5b3k-0005b8-VF
 for linux-nvme@lists.infradead.org; Fri, 29 Jan 2021 21:12:05 +0000
Received: by mail-wr1-f54.google.com with SMTP id s7so7202260wru.5
 for <linux-nvme@lists.infradead.org>; Fri, 29 Jan 2021 13:12:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8xFr57aU/oUQPNVw04oYU4liMAQ/hwOtMjRm8vw0PoY=;
 b=QuqUPROMs9gT6N6Sa2f7YZ4uVKT1zKZvc+srpuYFSa4O18JeE/8mqaN0xfY7gC4pT7
 pyenn49R7aCdpci5S5zR6UoSZIEcPAOv3ykjIgCXXs9lWdzQgoIS5WbFcAxrqLGo6fYL
 6YpY+k14gbnb2wlMjTFwavI/siKxUrTRYPQpePuxX0ZeBB+cary1+tUCAskhMwtabdM1
 Mq3ium0qu0XW4nPLyqkPT6sp83U1QEW1vFYN4ciiW0Ct02DXkM0yeJDXYrtODV9AogKE
 ApbSGQysisRW0geiXLbFGi4WfYd50XEpRLlhf4GuNLWdSJNGvS2QdkfDKiMNDPDNcJB+
 9tFg==
X-Gm-Message-State: AOAM530bplcewswHN3BvjfCsTfxFkcfS2wZgG3ax0dSwTO8IUDlxqQd1
 rIDWnzsY6VSDC2V89WJ3hIs=
X-Google-Smtp-Source: ABdhPJx7OlecXuzNVce/CwIduQFMF3NApCnCm7sndYTVqixXhz8QGeYqKl7lTKwwX+p+H3Dj+NwO+w==
X-Received: by 2002:adf:9b8c:: with SMTP id d12mr6760806wrc.51.1611954723769; 
 Fri, 29 Jan 2021 13:12:03 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:db7:4f5:6eca:f1ab?
 ([2601:647:4802:9070:db7:4f5:6eca:f1ab])
 by smtp.gmail.com with ESMTPSA id u206sm1178822wme.12.2021.01.29.13.12.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Jan 2021 13:12:03 -0800 (PST)
Subject: Re: [PATCH 35/35] monitor: add option --keep/-K
To: Martin Wilck <mwilck@suse.com>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20210126203324.23610-1-mwilck@suse.com>
 <20210126203324.23610-36-mwilck@suse.com>
 <90145500-c2c5-023c-6d69-27db6ee600a7@grimberg.me>
 <12827c5f748bd2eff31450c47bbef1cfc7b73459.camel@suse.com>
 <400d4f5e-a578-e89f-ae45-7ed15d089a8d@grimberg.me>
 <b4b9a52011d17ef16cbc86d81ef3d19f7a517d93.camel@suse.com>
 <c127bde8-7cae-677c-4b8d-44cf757d05eb@grimberg.me>
 <2394e23e80f2bdcf0a95eb39e5eefcb00237d52f.camel@suse.com>
 <8cb1830e-b7f3-48ef-1190-0d917aa200bb@grimberg.me>
 <5623aeee6a57889123b8a3441ee6df7b97f76451.camel@suse.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <552cb65a-8f1b-e414-4de8-f53ff469e8a1@grimberg.me>
Date: Fri, 29 Jan 2021 13:11:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <5623aeee6a57889123b8a3441ee6df7b97f76451.camel@suse.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210129_161205_048648_EFD90191 
X-CRM114-Status: GOOD (  15.15  )
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


>>> If it does, it will recreate discovery controllers for every
>>> host_traddr/traddr/trsvcid tuple it finds. "--keep" semantics are
>>> only
>>> necessary for addresses on which no regular (non-discovery)
>>> connection
>>> exists.
>>
>> Wait, Maybe I'm missing something here, but are you saying that for
>> every traddr/trsvcid it finds (both nvm and discovery) it will
>> attempt
>> to connect a discovery controller?
>>
>> If so, this is absolutely wrong.
> 
> Currently, it tries to do that on startup, if (and only if) the
> --startup option is given. My expectation was that the connection
> attempts would simply fail if there was no discovery subsystem to
> connect to. Anyway, it's not the default behavior, and can be dropped
> completely if it's so bad that we shouldn't ever attempt to do it.

IMO it needs to be dropped. I didn't understand this at first because
it never even occurred to me that such an assumption can be even made.

> If the service is started early on during boot, and event-based
> discovery works (i.e. we also have the mDNS part in place), this won't
> be necessary of course.

This isn't necessary regardless. At best the discovery controller
endpoints should be obtained from discovery.conf or equivalent.

I don't even see how does this help in early boot anyways, how
do the existing controllers get connected?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
