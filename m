Return-Path: <SRS0=wYSH=CI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD12CC433E2
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Aug 2020 10:23:53 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87A3220738
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Aug 2020 10:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tfiWyo8U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87A3220738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5aqBQPoUkBTonn+85aBg0bBCxb0ITjYG0Baj+2ZQtlE=; b=tfiWyo8U3gCYrgBfKSpoBxsjg
	857vV7GNbw9KIRseXZHq0dAvgSVbh6ENDaUpTdxv9dYmeZouM4nM0ltpnSatSn8oO4Kl688PznvxH
	jH8IeixATtIqzsmtF8hVqwlOvDglHe078miLsLjh7WAZBkOk6NOpQhSEnN6WyRMnecyyPvxNHJXIm
	zpsWalSqq8FTwZp3R+3hKglH0JzW7APjci/fElCTwBHDfhY8CmQQbwXPBVf/54f2Jv+7Na5k3V2+f
	B26HytM0xFZgUVzjhsdx7LB4vkQ/R7lLqi6k/cd5OgdThR8EXPbdYa5OzszKx3OMSM7dl/jUcezIJ
	SvbQRpBkg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kCKV1-0004Ok-2s; Sun, 30 Aug 2020 10:23:47 +0000
Received: from mail-pl1-f182.google.com ([209.85.214.182])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kCKUy-0004OD-Sj
 for linux-nvme@lists.infradead.org; Sun, 30 Aug 2020 10:23:46 +0000
Received: by mail-pl1-f182.google.com with SMTP id h2so1687170plr.0
 for <linux-nvme@lists.infradead.org>; Sun, 30 Aug 2020 03:23:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IXZCGHGRFnaeWsgRrshQlWtmfEgzeVg0SXdtn9KGpxU=;
 b=IgoALoFAHunzTeuDyAOB9uLB8H3gns9mvqvpIj1q0Bxvfbnndp7fuQRSuMNlG+8y4k
 pZgYFfp8MrVYEPaOP/DlmS6s6am9WsxKRqb5pCCzsFhON4iQ7Ud2EQWzj8PeXLbbzE0q
 RL23diSxdrqoNRt8TbpDE9CqytCRb3J8zZ4slujJ9/4qdaY9dF5Db0r7YvhLTd2sCNrG
 VQmxpTz5pvqAq2lIOQ0J0dbWZvlLs4JNJI2QJuU4zX4ePn8YILeZ8gUovgAmfzGfgiLv
 m9OV/BSMIdAe/LLKkLkf/SxU6WSVugppEjx4ImlPkUIYma/VuA0QDlUxNqbNQrE3TxBI
 qD1w==
X-Gm-Message-State: AOAM530PPjnP2CLqOsUi18gCHQBV8JMlWV2VtbKpWKN171EcwsQ+gXMN
 p+3pAjc5HhZ4P67feF+KxhA=
X-Google-Smtp-Source: ABdhPJyrDyA5GQu7ffy0iWOE/cPTtyshaBWaSc9LLlgXI+9vvMtl6QmMTEwtapJgyiyCmyspIg7f4g==
X-Received: by 2002:a17:90a:aa8e:: with SMTP id
 l14mr6535431pjq.67.1598783020980; 
 Sun, 30 Aug 2020 03:23:40 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:cc5c:f2a5:487:1dba?
 ([2601:647:4802:9070:cc5c:f2a5:487:1dba])
 by smtp.gmail.com with ESMTPSA id e65sm4069788pjk.45.2020.08.30.03.23.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Aug 2020 03:23:40 -0700 (PDT)
Subject: Re: [GIT PULL] nvme fixes for 5.9 next rc
To: Jens Axboe <axboe@kernel.dk>
References: <20200829153243.324252-1-sagi@grimberg.me>
 <18fdb68f-8747-6f44-de0d-390a3fbd41c3@kernel.dk>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c904c8f6-15bd-41a6-aa3b-a17a73f052c5@grimberg.me>
Date: Sun, 30 Aug 2020 03:23:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <18fdb68f-8747-6f44-de0d-390a3fbd41c3@kernel.dk>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200830_062344_984726_D37E2949 
X-CRM114-Status: GOOD (  15.16  )
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
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> Hey Jens,
>>
>> Some more nvme fixes:
>> - instance leak and io boundary fixes from Keith
>> - fc locking fix from Christophe
>> - various tcp/rdma reset during traffic fixes from Me
>> - pci use-after-free fix from Tong
>> - tcp target null deref fix from Ziye
>>
>> Please pull.
>>
>> The following changes since commit a433d7217feab712ff69ef5cc2a86f95ed1aca40:
>>
>>    Merge branch 'md-fixes' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into block-5.9 (2020-08-28 07:52:02 -0600)
>>
>> are available in the Git repository at:
>>
>>    ssh://git.infradead.org/var/lib/git/nvme.git nvme-5.9-rc
> 
> This doesn't look right... I pulled from the usual spot, diffstat and
> changes match up.

Rrr, sorry forgot to fixup this line.

> BTW, in the future, can you switch to signed tags? They are nice to use
> in general, but particularly for git repos that are outside the kernel.org
> infrastructure.

We'll look into that.

Thanks Jens!

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
