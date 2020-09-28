Return-Path: <SRS0=ZZT4=DF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA31C2D0A8
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 15:03:50 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5F8B2078B
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 15:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sFR9gY/E";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="C44J497K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5F8B2078B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1GK3H358SEqVlrDeCB0aIFpG1NgKet0gUcqFZ4JygJk=; b=sFR9gY/EvJzEoEoupv3fmoAiB
	+kBf8bB4NxN28zxvbpmbRz+yXOF1rg/Pk6/O+V39gbUrX32ceqd2EMAnUYD1wpM5ZE3Q9Jaqxmvyi
	mZdrQPFqvao7Gg4v9gUsZ9OsP/32yIn8P0NQyTj7P/nKYMyyRAkCUUFvp/VkGyM9pRTCOfBnnGCjT
	s+1reRq3WAyE+0lZPGyVMG2hzrTu7rH6/mNx7i9yN1fW/B7yNx19t20uhrZ++pN2LBUYSDQ3dFzce
	haabBmDcUtcagSYtB+AQYsg1WLc/DvzV4liksqcuHhfzgcNE3IVUOOjPayB6MqveQEjB6JkQF9A8O
	WNU6IvVow==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kMugs-0003ei-Bn; Mon, 28 Sep 2020 15:03:46 +0000
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kMugq-0003d2-8L
 for linux-nvme@lists.infradead.org; Mon, 28 Sep 2020 15:03:45 +0000
Received: by mail-il1-x143.google.com with SMTP id t12so1562660ilh.3
 for <linux-nvme@lists.infradead.org>; Mon, 28 Sep 2020 08:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Xh1VP/VnNfBNF4YXtIYhq/tFvDo4NDnupoPdqgecyK0=;
 b=C44J497KcQDvfvdsBiKn3FKLvi7DWom6fq6+zvhppAhQO+2k3qW03pQuuBa9raLnyj
 XOsSohcs970v9YbXtchrMOvvMxjACSEwZN3qlonyK/qwpMK11YJxko8/WoE4398/Pomt
 Sb+nRjd4WIgBKG/4s5rV1ep5aVSds1ClLeTYgZvsKoWjq8r1e/sKVuHOwnhqkALOs/JK
 KzG3ZqDWvbANLj/yOlcEq2t1XN10KDS8U2SF/U6ASr6NxJW7wLrD6TQ6JcIAERf1oBMQ
 uO9Ml5btBlA/z7og3i4v+eXBFvghUTYa3D7On9l0nMo81cvJxGxd1W1z8btVhUsL7TBL
 DWmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Xh1VP/VnNfBNF4YXtIYhq/tFvDo4NDnupoPdqgecyK0=;
 b=jpPhIqokbmW3Xd4QHm3HrW2vuFNzV3GiwXrv3kFLESqLLCPk+Ao2xox4O5Iewfg+sI
 gu0OkOFv59jR6Y1gFx0eMDGkiLLRV+YmohGQQTMST/MIrGMR4mvqqZg3IjRPWdX/zhtO
 YvDN41KBuZ1QLpn1rAC0wskc+Xn7LQL9c/hebDja4OQgsi0X7bnNFcqq6ejEDmnxXMy3
 LjzTzdaMKJYhfRddkoyouInTjZLWJZ7yROFnKuqk9BIVGXEPPdEMrEqoQorTqMrq0NNs
 Zto48yfC8L3wqfZ9Iim2jAabgS6P3m+p14M4lYJA0OlWp+rJRfQeAxqwnAGtdiyY1uKe
 DhQA==
X-Gm-Message-State: AOAM533awlNVtTT+RfGzUhJ8NIEeO4ITB8f06aZfzptb211HhW22WL8M
 9bc6HfqCYpdDCNQvan1+3reuuLsWYm5I9g==
X-Google-Smtp-Source: ABdhPJxPxQcFv/QNjIea1RXUeViyDl6Wyoxfixl5JT0Sgq3nvWzkIMmovI+VTHNg143wGUAryHA0ng==
X-Received: by 2002:a05:6e02:1066:: with SMTP id
 q6mr1391611ilj.12.1601305420673; 
 Mon, 28 Sep 2020 08:03:40 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
 by smtp.gmail.com with ESMTPSA id m18sm736338ila.27.2020.09.28.08.03.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2020 08:03:39 -0700 (PDT)
Subject: Re: [GIT PULL] nvme updates for 5.10
To: Christoph Hellwig <hch@infradead.org>
References: <20200927072343.GA381603@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <f724198e-fd0b-765f-a089-2b03dab899cc@kernel.dk>
Date: Mon, 28 Sep 2020 09:03:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200927072343.GA381603@infradead.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200928_110344_319393_BCBD958A 
X-CRM114-Status: GOOD (  14.22  )
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
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/27/20 1:23 AM, Christoph Hellwig wrote:
> The following changes since commit 163090c14a42778c3ccfbdaf39133129bea68632:
> 
>   Merge branch 'md-next' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into for-5.10/drivers (2020-09-25 07:48:20 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.10-2020-09-27

Pulled, thanks.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
