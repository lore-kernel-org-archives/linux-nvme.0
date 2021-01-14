Return-Path: <SRS0=kiw1=GR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D1FC433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 00:35:30 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BD4723343
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 00:35:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BD4723343
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=aTbJNjWj+ol3nj+jzeZ3+QBf3mjdJcPxtikFkr0SGIE=; b=eTIXDo3ijEydY/RSnSvkDcYhX
	IUq1jlO7VsTROkEND4zD+eoh3QwTOx07ep5qyyMD5U5dJxvYDWgP1PzexF5fYU4wxOAaRmcf5iNhV
	2Z9CcIBG5s9vhLiCwG7zCHNDw+qevzzUXJ6QUl4yVwO0UPVQk9VMSQdjCKewXYzjyYlx9qb6MOsK1
	oxhOSAbLRulgsZpqUNm4rCABjszeJGfTZLqr250Ya417kcg3DQA5J1+xW7DuVt9Y9e9dNmw94eD8z
	eKuJQ0xzOhfddBLh/J5Lda1Uf5dwvTR+alE5q5nON6SDCr6TcXN2sze58mObA8ku8UWgjQFZcN0Zz
	RIgoIi6Tw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzqbL-0008NV-Ih; Thu, 14 Jan 2021 00:34:59 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzqbJ-0008Mi-0Z
 for linux-nvme@lists.infradead.org; Thu, 14 Jan 2021 00:34:57 +0000
Received: by mail-wm1-f50.google.com with SMTP id y187so3216523wmd.3
 for <linux-nvme@lists.infradead.org>; Wed, 13 Jan 2021 16:34:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KCStWJHaEgbwHGhuW3LRg151KKy4FgI98wrG7g8q94g=;
 b=ZcnynV899D+ASvb6d5dGLdAYJzXwN94qkLtroUvIXCdGoNDoNjv95XuvqwSLNeb9/8
 649jLUaJSzXhRolXfLxZsKcWFucSDa7pJqYYuWwbuiIaEgPtj4E0yNCdma+y9Uhnqiqn
 Gs7ZnlCDEqDoMn2+c+haH/HFZbU8R5B1rOWrNXLJGGQlE5WB6k/PrTunq+l7PrvUI3SL
 PYwectU9j5PQNHGVaa6hBeCXAqG0M+McZqTGk6ZJnhpgVY9ntOehmvOgfCom+jSPmOum
 yBRc3qRMjhreP3B6i7/uRyFIDwGhYSf2cMikhz91fQKqP2zu/ts+o60XhCDyUO5mGi6Z
 sdbA==
X-Gm-Message-State: AOAM531mTcYQ3gfIOtHQ7niLS5lulgx2+rceftvWBGhW37RaTxsqHJvf
 PmezXD95KYyp2mMvZ3gEpxc=
X-Google-Smtp-Source: ABdhPJxnvuP11cNInnAVZ4F77M75KcWnwla/1dL/yJFgOSkO9gv1+ejbiXHNGjwEFgxy/GHWO+5Akg==
X-Received: by 2002:a05:600c:22c9:: with SMTP id 9mr165210wmg.45.1610584495831; 
 Wed, 13 Jan 2021 16:34:55 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:e70c:620a:4d8a:b988?
 ([2601:647:4802:9070:e70c:620a:4d8a:b988])
 by smtp.gmail.com with ESMTPSA id h29sm6754301wrc.68.2021.01.13.16.34.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Jan 2021 16:34:55 -0800 (PST)
Subject: Re: fabrics connect cmd with a non-zero reserved value
To: "Engel, Amit" <Amit.Engel@Dell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <SN6PR1901MB202957C808A7D493E252D873EED00@SN6PR1901MB2029.namprd19.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <6e271be1-088b-5a23-0eec-23578f707c28@grimberg.me>
Date: Wed, 13 Jan 2021 16:34:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <SN6PR1901MB202957C808A7D493E252D873EED00@SN6PR1901MB2029.namprd19.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210113_193457_101755_8C75512B 
X-CRM114-Status: GOOD (  14.87  )
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
Cc: "Anner, Ran" <Ran.Anner@dell.com>, "Grupi, Elad" <Elad.Grupi@dell.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Hello,
> We see that when executing nvme connect cmd (Opcode: 0x7f Fabric Cmd)
> The host is submitting the cmd with reserved filed set to non-zero value - which is out of spec.
> Seems like this issue is not only for connect but also for other fabrics cmds.
> 
> Here is a packet capture for nvme connect :
> 
>      NVM Express Fabrics (Cmd)
>          Opcode: 0x7f Fabric Cmd
>          [Fabric Cqe in: 302]
>          Reserved: 0x40
>          Command ID: 0x0000
>          Fabric Cmd Type: Connect (0x01)
>          Reserved: 00000000000000000000000000000000000000
>          SGL1
>          Record Format: 0x0000
>          Queue ID: 0x0000
>          SQ Size: 0x001f
>          Connect Attributes: 0x00
>          Reserved: 00
>          Keep Alive Timeout: 15000ms
>          Reserved: 000000000000000000000000
>      Data
>          Host Identifier: f1aa9784-195b-4814-893d-44f90a6a92d9
>          Controller ID: 0xffff
>          Reserved: 000000000000000000000000000000000000000000000000000000000000000000000000...
>          Subsystem NQN: nqn.2015-10.com.dell:dellemc-powerstore-23b5145591975EDFF2FE
>          Host NQN: nqn.2014-08.org.nvmexpress:uuid:nc5199007
>          Reserved: 000000000000000000000000000000000000000000000000000000000000000000000000...
> 
> 0x40 value is corresponding to PSDT, in a normal (non-fabric) nvme cmd, PSDT field exists.
> Do we expect for the same for fabric cmd?
> If so, the spec can't mark the second byte of connect cmd as reserved.
> Based on nvme spec:
> "A reserved bit, byte, word, field, or register shall be cleared to 0h, or in accordance with a future extension to this specification"
> 
> Is this a real bug or a spec bug?

We shouldn't be setting reserved bits. But from what I see, we zero the 
nvme commands before setting it so this is strange to me..

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
