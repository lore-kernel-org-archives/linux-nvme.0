Return-Path: <SRS0=47LT=HA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A4CC433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 21:18:27 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 945D864E00
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 21:18:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 945D864E00
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=yiMqOGmzqb2sOSLzGqlddotmAGrJLIci1O8FWGifTOk=; b=adp4oY1/Q2ddKaCA2jzOxJW+/
	mRTvJ+zoAC2TeBp47+ro2ThOQW9d53jETKs/HgMRusDwKRVOT2qBKO+jr8YhCnMI6HvjBBBQYCSh+
	86F56PnHt3kKdAQ0+a1GwSvjYw/L+hniD0IZgsUOIJqoIGpsVIfnSMyBS0I+nwXq/dNLgm3JhPqZ9
	bMvsxRBz0/fhzV7g3In8nN+EhjGuR5Vxtc3mPS/qXeolWSzlzfrOJdCEk/vmwjZOBBpzNRXAY1ONV
	j1Z2+sWoewEnK1aUSOosnNP+k9f6kJXGpg5HmPq4MaDp5FbqOTOLFgeQRDaQo3BPiyrZ4fTolHo0j
	l05TPyNOg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l5b9r-0006Na-Hz; Fri, 29 Jan 2021 21:18:23 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5b9p-0006MN-02
 for linux-nvme@lists.infradead.org; Fri, 29 Jan 2021 21:18:21 +0000
Received: by mail-wr1-f44.google.com with SMTP id z6so10152005wrq.10
 for <linux-nvme@lists.infradead.org>; Fri, 29 Jan 2021 13:18:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pKnGoZmP+ufYK/1dkCjnHW6V0mytsCRV5iBotLfg70I=;
 b=hcwLFqKYqVv2LGUHknn+k89aza0MewEenVRaiYJ/UGQGUxKC+pdt0rszISsvraDqhm
 3H1xRTwUmOmozsJneWK/38B2ZPCt3bfAVacwTGk/XibFytkwZd8bNk7lHxfyRn2DYth/
 gqi+EM+QUo6fNU5CDX+Z9pHCMio5rm6saGdwQ56/Xhd6YKmNoFz88+/ERggpyirDR/pf
 EcVRmcEvrDLP3wHPpzwwkr0EH5kUhMg0ZCMxoRRxLKmkmQnaSJMwfXUmKczi8V2DA8rl
 yIMlxkyW2DrkzxdsIcuTY2WoPbrsppNkAU+DtTScLQ8g6NbyzK54w97olDBCEvkhjG7A
 OrPA==
X-Gm-Message-State: AOAM530EpODAt1kMBDp2SiyHOd3oo6Q3PJJCOTSStCK0tlf7up69OQhq
 lvNdUTMKQz/R5KrIomQghbk=
X-Google-Smtp-Source: ABdhPJzXLkgYo3Ma21WRaxgQf2pC4+xJ+G3q1qVZYw7M5M+lKXujpBo2ShD3g7N+RRuxI4nqIPDV+Q==
X-Received: by 2002:a05:6000:12c8:: with SMTP id
 l8mr6461141wrx.81.1611955098467; 
 Fri, 29 Jan 2021 13:18:18 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:db7:4f5:6eca:f1ab?
 ([2601:647:4802:9070:db7:4f5:6eca:f1ab])
 by smtp.gmail.com with ESMTPSA id z14sm14314899wrm.5.2021.01.29.13.18.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Jan 2021 13:18:17 -0800 (PST)
Subject: Re: [PATCH 26/35] monitor: implement starting discovery controllers
 on startup
To: Martin Wilck <mwilck@suse.com>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20210126203324.23610-1-mwilck@suse.com>
 <20210126203324.23610-27-mwilck@suse.com>
 <18970cbc-1c58-9529-3bb5-919249e97b5c@grimberg.me>
 <0c56ef14e84354f9601dbe694c7550d77d990f54.camel@suse.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <809c3240-50d9-cc86-9ae8-878c62e49460@grimberg.me>
Date: Fri, 29 Jan 2021 13:18:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0c56ef14e84354f9601dbe694c7550d77d990f54.camel@suse.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210129_161821_087784_932BDAAE 
X-CRM114-Status: GOOD (  19.33  )
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


>>> If the -U/--startup option is used, nvme monitor looks for exsiting
>>> nvme controllers on startup, and runs a discovery on the associated
>>> transport address (connection); i.e. tries to connect to a
>>> discovery
>>> subsystem on the same address, retrieve the discovery log pages,
>>> and (if --autoconnect is given) connect all listed controllers.
>>
>> Oh no no no no... This is a completely wrong assumption to make.
>> Nothing
>> suggest that an nvme controller will have a discovery controller on
>> the
>> same port.
>>
>> There is a discovery controller and an NVM controller, the only
>> connection between the two is that a discovery controller can
>> refer to an nvme controller (or a different discovery controller).
>>
>> Information about discovery controllers may be obtained in different
>> ways, but it absolutely cannot be obtained by any nvme controller.
>>
>> Now I understand a bit more on the --keep discussion. The monitor
>> should today get discovery controller endpoints from a conf file
>> (maybe discovery.conf) and in the future by any other automatic
>> way, not even looking into the currently connected nvme controllers.
>>
> 
> I hear you. I'll drop this in the next version, no problem.
> 
> I didn't expect that probing for a discovery controller was a problem.

It's not a "problem" in the sense that nothing devastating will happen.
it's just wrong. One can also randomize a transport endpoint and attempt
to connect to it.

> IIUC, if we get an fc_udev_device event for a NVMe remote port, we
> can't be sure that that remote port offers a discovery controller,
> either. We try to connect, and give up if it fails.

I'm assuming that this is what the spec mandates the host should do,
which is not the case here.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
