Return-Path: <SRS0=yBWI=D6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B171C388F9
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Oct 2020 21:14:13 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ACF921D6C
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Oct 2020 21:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TjppFP7e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ACF921D6C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=K017MovktDuoG55PKDvESK5n2vFkbnnWW0vq46Qwk08=; b=TjppFP7e0qwsbNnJoJnzgYvyz
	qlangP0IawykwpOW9guUz16+Jy/oBkDgZrr3DQs5iZVrY/Bn89iUaxMOFOtrWwOydjx6MbZ9qS5+W
	fFlseHKByctfcZ84xovsWilboVXOztMPZAM+e5yiZhrz1wdoMamUzusxbcnw9qavfvcUDvSeqOZFO
	sU8CyeC1EwUo4sAYOiE5kWYOoAwiOpSPETUU27CG0C/XH0rTGgLj9jRorLBw7NATpamwaHRa6FpJY
	xOjYU5uUdIZJ9eQcYyFegWXZt5LlEowoPDCXSQv/8GTnulyXiEGCKi5HS5kL194rhAzYKa1pb3k84
	M4iDlt4Zg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kW4Nx-0001zb-CQ; Fri, 23 Oct 2020 21:14:05 +0000
Received: from mail-wm1-f66.google.com ([209.85.128.66])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kW4Nu-0001yl-IG
 for linux-nvme@lists.infradead.org; Fri, 23 Oct 2020 21:14:03 +0000
Received: by mail-wm1-f66.google.com with SMTP id 13so3289037wmf.0
 for <linux-nvme@lists.infradead.org>; Fri, 23 Oct 2020 14:14:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uVbXc1wC4xY22bpsrNPYZbj5jabxlaf77lO7iQyML3A=;
 b=a7yqowrMLfvoQpoUJkZFekulxCHbVmHoi04/HQy37L+pll/l3lWNerCkDXUye0wAw7
 SynovqkGdIiqPtDx6DxGznItGU2ju6J87L8MnhbMz2fNZS1+TkIOC4JCkEt6JOkYk7fS
 tRmhqucxDrZe99/OjFFDXO9Dd/a+zrsVM5E09GFdbfeqEPGRTcNj9TEAoUeizgtteB1q
 OQY9EYRQYDno5JDEpFIQ48e00NTFQw25odtZVSOg/tjsyvqPYp2yXkUdFY7NfY7vshe7
 Er2QYFeDAHtT8PuzilYzlI4+ykxYmzc3N+rK990+7LqnuTMuSw8M6xEFr756UCMHpTwn
 xFlg==
X-Gm-Message-State: AOAM533dNeJJRysCMkoQWjpgGF0d4BU4sWLEoKENc5ND8KjpLoGicJrb
 V0Z1eT1nfJIA9CDWtCcyRR/fzktNePI=
X-Google-Smtp-Source: ABdhPJxyrsO7jDcaz+OC67UDDa7taLPPTxO2QlnTPEkZRmmk4y2CYA2sNk/dGqFlywUb0ZjU6mIu2g==
X-Received: by 2002:a05:600c:28c1:: with SMTP id
 h1mr3550489wmd.30.1603487641410; 
 Fri, 23 Oct 2020 14:14:01 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:f912:ab69:c0c3:c2f7?
 ([2601:647:4802:9070:f912:ab69:c0c3:c2f7])
 by smtp.gmail.com with ESMTPSA id x10sm5603418wrp.62.2020.10.23.14.14.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2020 14:14:00 -0700 (PDT)
Subject: Re: [PATCH] nvme-cli: remove default ctrl_loss_tmo for connect
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20201023202521.9610-1-chaitanya.kulkarni@wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <58b2a430-4ea8-174e-ab7c-ce93d45c4bc2@grimberg.me>
Date: Fri, 23 Oct 2020 14:13:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201023202521.9610-1-chaitanya.kulkarni@wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201023_171402_650627_2F8C5DD0 
X-CRM114-Status: GOOD (  13.78  )
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
Cc: kbusch@kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Since nvme-cli adds a default ctrl_loss_tmo for connect command
> all the testcases in the blktests are failing. Thjs addition of
> the parameter breaks the nvme-cli command-line compatibility with older
> versions.
> 
> Remove the default ctrl loss tmo parameter addition for the connect
> command user can specify that from the command line.

Please CC the patch author that made ctrl_loss_tmo to be passed
by default, the patch description provided does not specify
a good reason why the patch was given.

Also, please add a Fixes: tag.

--
commit 4b607779af71d23bc5ff7fcc14a7e1fde8507ed7
Author: Aleksei Marov <alekseymmm@mail.ru>
Date:   Fri Jun 19 18:10:07 2020 +0300

     Allow 0 value of ctrl_loss_tmo.
--

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
