Return-Path: <SRS0=15CP=IN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B07C433DB
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 17:27:41 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F20A64EB3
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 17:27:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F20A64EB3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=OU9j1z0CzkSrrQcaOWcf4e9GWKdlKPPlY3eC/nVnREQ=; b=dC6xrlVmiOyO/kzHuJ+PKu6dJ
	HvZEAvv9YeKRBSkUiJAYSn4jHHcwlKNfCHnTr28LBU6ft7KiwDo8SOdKvhxXH/CJiQ/cNC2GxvJaO
	2DRwLXpBnyR2rJtQbNLlc6uLHDACeMGyJwnWF9va3MUE3h2R3q1za95FTemUOR6KBQ/1uo0KTld8l
	SNseJgP2RL4f80wE7UAoEw+imihXAfXcbK3nGssLXfYqfNDp8oQq9gKLoGQwMe+DUd1MTrRIJS8n9
	Nya3dLoORRWfkS26sI5g7lOvPdheU3JQ2Cqzvu//ML0IcIyef/AdtjctlgjR2V7vblFeotQeZ64Z1
	7esPnSevg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lLr01-00GVfu-5q; Mon, 15 Mar 2021 17:27:25 +0000
Received: from mail-pj1-f45.google.com ([209.85.216.45])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lLqzu-00GVea-Md
 for linux-nvme@lists.infradead.org; Mon, 15 Mar 2021 17:27:21 +0000
Received: by mail-pj1-f45.google.com with SMTP id w8so9171404pjf.4
 for <linux-nvme@lists.infradead.org>; Mon, 15 Mar 2021 10:27:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Rug3gWvP3xmcq+KnfyNYKhL+F8EeyoCbsh5qJeAjdTc=;
 b=GCyvTL87lE1mphJKI3htyLTVb5Ru3ELH/be0w2QO9ZtgPlnp1Vh8AosnKJsContHcd
 spDODgsxv7qf/CTad7na7OaiHCp0K50/opluCINjh0m4kU+NT5uQdloq3LaSp3Db5D0Q
 eVvkiEtUYuCWsQ8SetKTtPt1meoROJKle6c8jJzQmeEgHLTHaMZng3RIiONyRxG/A/z3
 T8Edu/bwgaTi9CIHNoDArYitoN3AZsXrixPkGKerRmynITIbjPT8BOESlS0Jlpb1eVIH
 1B1UIs1ieMQ5haNa23440e1W15FjGMUvDv6uVPRArdVYToMdKUaYAdOe2JkZQ74ngYG5
 nuBQ==
X-Gm-Message-State: AOAM533Ik0l6OMWYiKgRcBYoHesLB2ZR786gPRAp1zKMk+1l13DqSfEN
 +B/UV2e9F62J0T/g8Pp/G6nAfDuxxoU=
X-Google-Smtp-Source: ABdhPJwBrMs3Pc7ktSUXv90nWm5KiIZePu9r3GVCIrSY/nX6TafxpDgoBizpyWWrMkVWr0LbWVSkYQ==
X-Received: by 2002:a17:902:7407:b029:e4:9645:fdf6 with SMTP id
 g7-20020a1709027407b02900e49645fdf6mr13041297pll.19.1615829236672; 
 Mon, 15 Mar 2021 10:27:16 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4faf:1598:b15b:7e86?
 ([2601:647:4802:9070:4faf:1598:b15b:7e86])
 by smtp.gmail.com with ESMTPSA id b23sm13232666pfo.164.2021.03.15.10.27.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Mar 2021 10:27:16 -0700 (PDT)
Subject: Re: [PATCH] nvme: Do not detach nshead when a namespace is removed
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
References: <20210311155454.7845-1-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <3cefc08c-6d47-b137-e646-cec87bf8dfe9@grimberg.me>
Date: Mon, 15 Mar 2021 10:27:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210311155454.7845-1-hare@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210315_172718_888899_FD91DC1C 
X-CRM114-Status: GOOD (  20.00  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> 'struct nshead' and 'struct ns' have different lifetimes; the nshead
> can (and occasionally will) stay around even if no namespaces are
> connected, as it will only be finally removed once the last
> opener is gone.
> Once the system enters this state it becomes very hard to recover,
> as the only way to remove a namespace is to disconnect the controller,
> but the nshead is precisely _not_ related to a controller. This leads
> to the very annoying behaviour that a subsequent 'nvme connect' call
> will establish a _different_ nshead, _and_ the previous nshead will
> stay around:
> 
>> nvme list
> /dev/nvme0n1     9329c4c4af01db2c     Linux \
>      1          17.18  GB /  17.18  GB      4 KiB +  0 B   5.3.18-4
>> nvme disconnect -d /dev/nvme0
>> nvme list
> /dev/nvme0n1                                \
>      -1          0.00   B /   0.00   B      1   B +  0 B   n1
>> nvme connect
>> nvme list
> /dev/nvme0n1     9329c4c4af01db2c     Linux \
>      -1          0.00   B /   0.00   B      1   B +  0 B   5.3.18-4
> /dev/nvme0n2     9329c4c4af01db2c     Linux \
>      1          17.18  GB /  17.18  GB      4 KiB +  0 B   5.3.18-4
> 
> This patch fixes the situation by only removing the nshead from the
> internal lists once it's being finally removed.

I'd say that we should remove the nshead exactly when the last
lower ns was removed? Why should it still occupy sysfs and ida
resources if it is going away soon?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
