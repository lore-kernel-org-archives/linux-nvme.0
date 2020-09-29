Return-Path: <SRS0=g+aI=DG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4ACAC4727C
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 18:16:39 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06DA0208B8
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 18:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GeF+VMA5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06DA0208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ij3VXkXXp/VjTTjl+Rm42CUu/q9p1UTCUZWZdBapkJE=; b=GeF+VMA5KsVgn95u0RVXZcTps
	rTpv9IahMQEMn0zx5Os9I5r3hARSzLlTYuvyE4KzkJCRSBBsoYcHXe5gQXslT4KJtQY0OGB5GB1VV
	XlU5kvn7AdDAbJ32id9ReWrD7+uvmpz63zCsG+TMMVXWghUoJau/9IjqOr5V32gCYaTmeVMeMR72L
	BHYd0XXeJL799YCehAV7DbXL/eJYq3js58bKrgwHYKDqIrQ2Kg/I9xUhDuwDHPo8aup0PLGH7SEzH
	RfOnz50VeJPeuYI38oYACPGLnwMTeC56gOuQc4k8b9mjzg+JeZ97bb0SYrQOyz0OvnJuF1AJO1PS3
	xy6MTKckA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNKB1-0002Kr-H3; Tue, 29 Sep 2020 18:16:35 +0000
Received: from mail-pj1-f53.google.com ([209.85.216.53])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNKAz-0002KP-9R
 for linux-nvme@lists.infradead.org; Tue, 29 Sep 2020 18:16:33 +0000
Received: by mail-pj1-f53.google.com with SMTP id fa1so3116710pjb.0
 for <linux-nvme@lists.infradead.org>; Tue, 29 Sep 2020 11:16:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IRdBW3QSJvI1j0iJeyL1hAAsuiWlBuTvZwF+4Dokw/M=;
 b=J5fmAT2akS0D57aaKH9vra6AVOq2MGc8T01sdsBuJ0xj+rGJt4AVvW7Nf1j/i1DBhc
 QneuzEFgH+PBd9kywYkfclsDqdzXTPSGKsw2pU+2hYBAdXcvczup3lk6LpQNAcXnwILW
 Z5bYosReyNfROKi6R0WF731c6wk0y/U/CSMkV/aVO0H79UOsoVcV+d00lokRalWEyJjO
 4zYvCMv5FfxZiYHhcZhwwz81Kw2SDzjtGuvr+GZHVuVVPbf2hauHVsobT1XhC8CwUO2/
 whhHVjbxqK1n9lejmfW6ubf3zaz8DgIObwLJHqeP8Xi7iLTdIhFDvPf9CWRdYpRuALus
 kHOQ==
X-Gm-Message-State: AOAM530/SZeD493khVGxeQB1LM5pLut42jDUAmoP/PMcj8qq3itrHOLz
 69zOU5NY+1eZaaNha/hR88ppw9eIVrI=
X-Google-Smtp-Source: ABdhPJw6rICkkFCtFpS48TaJeYDan5fILKcesn30jHu50AqNWNgFkqDsld8TuqBhfmnelLFhgJsMyg==
X-Received: by 2002:a17:90a:6741:: with SMTP id c1mr4888729pjm.6.1601403391486; 
 Tue, 29 Sep 2020 11:16:31 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:8ff9:9348:1454:22ce?
 ([2601:647:4802:9070:8ff9:9348:1454:22ce])
 by smtp.gmail.com with ESMTPSA id j13sm5494487pjn.14.2020.09.29.11.16.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2020 11:16:30 -0700 (PDT)
Subject: Re: [RFC] nvme-mpath: delete disk after last connection
To: Christoph Hellwig <hch@lst.de>
References: <20200925213819.224198-1-kbusch@kernel.org>
 <f8fdd99f-84da-bf68-a07b-7a6200cc02ab@suse.de>
 <20200927060709.GA24024@lst.de>
 <20200928141106.GA227320@dhcp-10-100-145-180.wdl.wdc.com>
 <4af645fe-f513-22b5-2d28-3e8890cc8776@grimberg.me>
 <20200929180849.GB12546@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <3d2541d7-88b0-1e5b-89c0-13f101f10243@grimberg.me>
Date: Tue, 29 Sep 2020 11:16:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200929180849.GB12546@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200929_141633_358213_20FC3BD4 
X-CRM114-Status: GOOD (  15.34  )
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
Cc: Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>,
 linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> Something here is not clear to me, we are not really talking about "all
>> paths down" but rather "all paths lost", which should take the gendisk
>> down AFAIK.
>>
>> Keith, shouldn't we modify the gendisk reference manipulation in
>> nvme_mpath_remove_disk instead of moving it to the call sites?
>>
>> I'm still unsure why we need a timer for this. If a path is removed
>> (e.g. disconnected, we shouldn't keep the gendisk up).
> 
> True.  And I guess the right place to deal with timers is on how long
> we are going to keep retrying (or at least the underlying disks alive).

Which is orthogonal to this specific patch right?

As for timers, I wouldn't want to introduce a modparam for that. Perhaps
the correct way to do this is with what Victor suggested where mpath
fastfail is really the longest controller fastfail...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
