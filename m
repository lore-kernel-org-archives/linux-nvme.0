Return-Path: <SRS0=jrCY=IV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1688C433C1
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Mar 2021 19:01:00 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 433AC6198C
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Mar 2021 19:01:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 433AC6198C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=FIIthnDX+LXw0ve08n60VoaJrTB69h2nhr6+nfMDQ6w=; b=TWf+S7xtC3K+iJvDxqJiUASzh
	m9V3H+VnNiaNrT9+5YKyAEqXEmAj8zS/OWMwjoSdFwhJlTKnTCC5C1u3Mz7H/fDhGDDiuhFxp4HsE
	0P5E+XwR7DQDQkE1HWJsZ7gNWxB8TxBpF3LFbglAK/JrgwilcOdGyUGffD2xMkN5YxA/s7F76UY6b
	RXWsc6K5TCu/s8K/1a3dJFOvK5xEcxHLnmWZcgo7kkrMhyeqErzMQNUoaTaMY3L75LTlWZMH7rHOF
	bLIhtGyA4vtidVsi0mh7c3oeDbzrRgBE0SqvZmK0WzCeAUrZwGarlTGmyONJqGetcPGgMCtfz0gZ3
	3f0BCOHRA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lOmGg-00FYvq-LO; Tue, 23 Mar 2021 19:00:42 +0000
Received: from mail-pj1-f42.google.com ([209.85.216.42])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lOmGd-00FYvU-26
 for linux-nvme@lists.infradead.org; Tue, 23 Mar 2021 19:00:40 +0000
Received: by mail-pj1-f42.google.com with SMTP id
 q6-20020a17090a4306b02900c42a012202so10522489pjg.5
 for <linux-nvme@lists.infradead.org>; Tue, 23 Mar 2021 12:00:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=O/3qn3sPLpLHnlktoBlJGBkI4ltpf5u7GjymR/6WLUg=;
 b=iLuvwktOYrIphbwIks3WrZpa3ISZh/7Ns7Pd8NPvrWSq6KC3ntbzfue3KwMpicrMZv
 9jAT4sBT7lvjh8uXS6Ha3E3vpTTt2B8PmnTGDSB21sX2ONJ03R0Z58xa9F5PbFqlSAxa
 1Dxz9ClS35VHAkN0Bu9xQYv38aElTw9UFacCredrzGromMCWcns8lNxphGZf/PLEuAdk
 cEpM4Bm868JVVVYtGRyBm7irA6F9wwPVwmL9Cmpy/1nogaBekR0lWDv73zZOrDfXXR5l
 2TBd9eg2QywmDV4vHRPhvDF0Cxw+vLQOZwbN5UGosw0oQcweKtLx+PjJMxZcuxbPfB1x
 85eQ==
X-Gm-Message-State: AOAM533O/9M+vlw7p8sgTgJo7CNEgGuG8rBwrIKczlZheY6A+QIiCtAY
 U8aQ9Arz9DT+u1TQn0ENEFUPvkHKmkc=
X-Google-Smtp-Source: ABdhPJxKGX6jlJBKXMP33WR+TIBDDDNJn54IG4rhNKR4rhZzSeIwabCSLlc4zSh+Nrn20AapJ3qC3w==
X-Received: by 2002:a17:90a:4604:: with SMTP id
 w4mr5797704pjg.56.1616526037254; 
 Tue, 23 Mar 2021 12:00:37 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:3b29:de57:36aa:67b9?
 ([2601:647:4802:9070:3b29:de57:36aa:67b9])
 by smtp.gmail.com with ESMTPSA id 22sm3599104pjl.31.2021.03.23.12.00.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Mar 2021 12:00:36 -0700 (PDT)
Subject: Re: [PATCH 2/2] nvme-multipath: don't block on blk_queue_enter of the
 underlying device
To: Christoph Hellwig <hch@lst.de>
Cc: Chao Leng <lengchao@huawei.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20210322073726.788347-1-hch@lst.de>
 <20210322073726.788347-3-hch@lst.de>
 <34e574dc-5e80-4afe-b858-71e6ff5014d6@grimberg.me>
 <33ec8b12-0b2b-e934-acb1-aae8d0259e2e@grimberg.me>
 <31e7f7f4-55fa-6b0c-426d-7f7e7638ab4b@huawei.com>
 <5d28226d-4619-74b6-1c73-c13ed57aa7ea@grimberg.me>
 <20210323161544.GA13402@lst.de>
 <162dc8f7-b46d-37ff-01e8-51d813e0a904@grimberg.me>
 <20210323182244.GA16649@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c4ceed19-cdc5-aeca-0c4b-ebed088e8b82@grimberg.me>
Date: Tue, 23 Mar 2021 12:00:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210323182244.GA16649@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210323_190039_206519_0DF5E2F8 
X-CRM114-Status: GOOD (  14.93  )
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


>> The deadlock in this patchset reproduces upstream. It is not possible to
>> update the kernel in the env in the original report.
>>
>> So IFF we assume that this does not reproduce in upstream (pending
>> proof), is there something that we can do with stable fixes? This will
>> probably go back to everything that is before 5.8...
> 
> The direct_make_request removal should be pretty easily backportable.

Umm, the direct_make_request removal is based on the submit_bio_noacct
rework you've done. Are you suggesting that we replace it with
generic_make_request for these kernels?

> In old kernels without the streamlined normal path it might cause minor
> performance degradations, but the actual change should be trivial.

That is better than getting stuck in I/O failover...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
