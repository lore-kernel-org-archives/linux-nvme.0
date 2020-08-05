Return-Path: <SRS0=ZkUF=BP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCED8C433DF
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Aug 2020 01:13:01 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D88420738
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Aug 2020 01:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TZVpNT3P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D88420738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=jSp2CnFbXZjhIZQqWd3yX/BZDTckfLjpc2j4bPo7RxA=; b=TZVpNT3PwmBmr4eAh2I8ZQ7/i
	8uXPCD/HE7fur311ZHEtSwoNNpevh/ZwysYhQcwbS/cbkN16ppEA5sKHRflg0DyjOakoEy971FP8W
	XV4sZmCl/mBEP0OE9GCrIPjLlCLHL3NWNoaBPzpKqf9P8gElW7fc6ALUQEOkoJqj2XTdn+X5aUNQe
	LiRL4Jafn9aVS16hqUxSwmTTFaSHhVhdu4+NriBpGMpUVzRAeT9SVPyagN5AsDWwe9ZG8EehLHiGU
	GRNahziVyn8QX6FnJGON9NR2MK6y2mCM4Aj3pTqdfU3Cfis1YK+9ncZbJHf3Pq7mV0+lQZZ/kj9Ly
	eJFP/hfpQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k37zG-0006Jp-RZ; Wed, 05 Aug 2020 01:12:58 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k37zF-0006JD-7O
 for linux-nvme@lists.infradead.org; Wed, 05 Aug 2020 01:12:57 +0000
Received: by mail-wm1-f47.google.com with SMTP id 3so4666713wmi.1
 for <linux-nvme@lists.infradead.org>; Tue, 04 Aug 2020 18:12:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pwja218xwpsLaaFTqhxzhtW6CEfT+QYaouBoez+QCZg=;
 b=ILKkH/0UUiaOoGAd7+IfybVSgWoDV6ygsNuWbi1liPoVOfHBI7L8DaW2R426NN8tzZ
 bNvgzm/lg+qfYxdzTAGA42L70mxImXJJmKE++EiUCej5wXrhX9/lSxcLbqd+JRvwTAt7
 Xlp+kcMMyHxFWdQ0g8lZzqtD2/PVDO+yqDv9EuP8LzBaef7iOs8Adk1ZrNrzBBJhvFhb
 bKUc025n88Puz0SKhgN/g+KBdiARXYZrDNQ4JJC28n9lbmctZKZVBhND8YlxXiKTKK3h
 Xx3rSt0QNOTWZIYV5SEuC6fDaue3ANpSjfprmRvM2rh6RAQUbavf8vhgz8b2MhDrlm21
 vAGA==
X-Gm-Message-State: AOAM530A5yephG3wm2Bp3jNIaUCCoyBcJD/90jG4LIqFl771TUgDn/vz
 o7xlU0nUR/4vVs4+DBjyTjw=
X-Google-Smtp-Source: ABdhPJzlm8BOufP8iTfChMi/mHK1lppaUZYBV9GHmgjg1Dps5WaaheTfDgKxzqykxp5RsQOZfyOYoQ==
X-Received: by 2002:a1c:5581:: with SMTP id j123mr877093wmb.75.1596589975887; 
 Tue, 04 Aug 2020 18:12:55 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:e1a8:cb16:c589:8b34?
 ([2601:647:4802:9070:e1a8:cb16:c589:8b34])
 by smtp.gmail.com with ESMTPSA id p8sm629041wrq.9.2020.08.04.18.12.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Aug 2020 18:12:55 -0700 (PDT)
Subject: Re: [PATCH 5/6] nvme-rdma: fix timeout handler
To: Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 James Smart <james.smart@broadcom.com>
References: <20200803065852.69987-1-sagi@grimberg.me>
 <20200803065852.69987-6-sagi@grimberg.me>
 <a918db0b-0979-c39f-aefa-e53de249beeb@huawei.com>
 <a05974ca-45cf-8baf-3f68-8c5e8e5ec5a1@grimberg.me>
 <d0b6e574-eee1-02db-e27d-e9c88e5b0c80@huawei.com>
 <938aa34b-b4db-f8ca-2478-0b48954899ea@grimberg.me>
 <85b3a7e5-5769-c1b2-eff5-318671c6850f@huawei.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <7250e072-c0f8-430e-3afe-d0837efe14ad@grimberg.me>
Date: Tue, 4 Aug 2020 18:12:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <85b3a7e5-5769-c1b2-eff5-318671c6850f@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200804_211257_298685_9B46D484 
X-CRM114-Status: GOOD (  16.96  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>> may interrupt by hard interrupt, and then timeout progress flush work
>>> at this time. Thus error recovery and nvme_rdma_complete_timed_out may
>>> concurrent to stop queue. will cause: error recovery may cancel request
>>> or nvme_rdma_complete_timed_out may complete request, but the queue may
>>> not be stoped. Thus will cause abnormal.
>>
>> We should be fine and safe to complete the I/O.
> 
> Complete request in nvme_rdma_timeout or cancel request in
> nvme_rdma_error_recovery_work or nvme_rdma_reset_ctrl_work is not safe.
> Because the queue may be not really stoped, it may just cleard the flag:
> NVME_RDMA_Q_ALLOCATED for the queue. Thus one request may concurrent
> treat by two progress, it is not allowed.

The request being timed out cannot be completed after the queue is
stopped, that is the point of nvme_rdma_stop_queue. if it is only
ALLOCATED, we did not yet connect hence there is zero chance for
any command to complete.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
