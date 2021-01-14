Return-Path: <SRS0=kiw1=GR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8976DC433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 02:08:12 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E67AC235E4
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 02:08:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E67AC235E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=2goZSBsK1y+DY+nm88M7Ccw6R
	stS0Q5hpgIYpWV0Q6voUTDr4hhvcdqjGO7cZwIjZ0mst5MJ+BFKHHn9F3PQkmavYrVkFDbgxEv6fg
	GWkalVAavLuhgraj4QtQvZTISzFAme65UDfj51DvsNJ9w//P8EzwhYWG9fr43RKjFPX8yg6JhQC/j
	XbQBrjNZ4sZz6OsDVC9Wq50Y11kdiZ7/qJEw49SSgQqp3Ba6kSaNqTqVkV5HFd2Mzug3ovdgQHJ7H
	+KAs48ZxhY3AnRvNyPW4YOgpSdEL+bhmRZzdCbi7pIP8sJFQfMIiPyZFR5z6wnd031ABBFC+vudSY
	8YeOVmOqQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzs2l-00025H-J1; Thu, 14 Jan 2021 02:07:23 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzs2U-0001wf-Ro
 for linux-nvme@lists.infradead.org; Thu, 14 Jan 2021 02:07:08 +0000
Received: by mail-wr1-f44.google.com with SMTP id c5so4156629wrp.6
 for <linux-nvme@lists.infradead.org>; Wed, 13 Jan 2021 18:07:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=XWJEgotoujZeDS+9YPa+uDEE0+aSpC+0YtpSij28Mx/BOLmH0e2G0NGwy6QYFlbGhC
 P7u7eXxMTCC+7IjGHBFa832r3rHM+si64DNgYBQ9dLzYP0BA+G/MQtwMdG0MraZ8Xjjw
 1C7KVm/ATwF3yM6zI8ik2Wq2SEuz8FkzJRfASlkVsJkKidA/SkT7m+UJVKinIZZ4vwQ3
 2DFolIhuuJTTLFeeGry77+HtDBVBKOzEbWBKHAldqbohhPqzo1PJkPH+bphR7TVMJ59J
 dtd3+F04qtNyN0MNq0lUoahZoW0+SkcYNjIKOIpfHxuumWE2LPcT96IpJE17Yy+/xipF
 ydOA==
X-Gm-Message-State: AOAM530snsRERM8oeMfnwvg9Epsm8AilYdd9+yNsoHiAgJ4QVZhf/XOH
 FqGqFy5Zs34DZIaFx9kH6WI=
X-Google-Smtp-Source: ABdhPJymuqoorONReyEv25gzREovCVCmlbX3v6n42g0Q1LkLEYNNL1O+d5qpKgT7Xy2XldrMCqxuXg==
X-Received: by 2002:adf:f681:: with SMTP id v1mr5275235wrp.133.1610590025790; 
 Wed, 13 Jan 2021 18:07:05 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:e70c:620a:4d8a:b988?
 ([2601:647:4802:9070:e70c:620a:4d8a:b988])
 by smtp.gmail.com with ESMTPSA id b200sm5184189wmb.10.2021.01.13.18.07.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Jan 2021 18:07:05 -0800 (PST)
Subject: Re: [PATCH V4 2/4] nvmet: remove extra variable in smart log nsid
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20210114013354.33946-1-chaitanya.kulkarni@wdc.com>
 <20210114013354.33946-3-chaitanya.kulkarni@wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <059a1245-954a-36ad-df35-8565b81f9529@grimberg.me>
Date: Wed, 13 Jan 2021 18:07:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210114013354.33946-3-chaitanya.kulkarni@wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210113_210707_276015_A3E48395 
X-CRM114-Status: UNSURE (   9.25  )
X-CRM114-Notice: Please train this message.
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
Cc: hch@lst.de
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
