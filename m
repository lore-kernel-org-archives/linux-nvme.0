Return-Path: <SRS0=MVBk=JW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4115CC433B4
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Apr 2021 18:40:48 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7E34611ED
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Apr 2021 18:40:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7E34611ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=rHObTto/SY7ZpC4DVFP5L8U+8ebc0VE9N2qqNxXVO8Q=; b=YAf3weB7eYy7M0eDMVnIM8XLj
	S8Cr93IsD3TykO1KRjYGLg7/CorzmlDPFSvc75pgdN8+0HEJVEaa7LQzV42ABe1bElOptBUqnMX4Q
	MlGJL1YGyIjclJPW9QcUrmin4moXQZAXNdn0UPiQHE3TegtfGaVJD9usAty8UTe2mIWkG9J1wLYd9
	LxfNZWR+75EnNHPU5P5RIBjhLtF0EUjoWzlCu9vbxZnu3UXGJsEzWuiQ+pLZT0lcpz9BaU1R9e/qa
	sukh2qMkPZ5MSkFHOikGTd913o4Ju0clORYkufDqo7ZcoxPQa/QGqC+n+fB3c9FDf2+rLqHhHvzuT
	oo4LY7Atw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lajfd-00665O-U7; Sun, 25 Apr 2021 18:39:54 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lajfa-00665I-GV
 for linux-nvme@desiato.infradead.org; Sun, 25 Apr 2021 18:39:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=5YG2hPeM/Yx8k+iQC4Kx30pgH4bvBziMfztPYklA/YY=; b=rDXdf4DD/EKIF55yaw14cu+c7V
 QwRPxWLDww+oYBiBVj31MBf3Cb00HoGeGydUrw04j5vh2mBYQz9F+HCy47RH6wA5JqnXRnSOFUXLt
 xQR1Pj/9BN6tmO3rWaKmL/CHaPCkY2YusOMnvPVFC+pqP511Rv8V9heImkTalLQnD9rFSgWBpPg+2
 XkbC5ksnPyRQ0GcMHKlUE+uZO6m/YV4zPQRMl9qXXTqibZ6HKfGNV6YMdedtk1pIlwxWkDIfr5S2t
 r1fwBaXgSg+YjsT7LZZ+Wmct5yCbOjIXVR2xEY7ZX5qq1URXzeEJZ+o5lo69wpO0CBN1aN6kWkc56
 KnXX9Icw==;
Received: from mail-pl1-f169.google.com ([209.85.214.169])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lajfX-00FYBC-K9
 for linux-nvme@lists.infradead.org; Sun, 25 Apr 2021 18:39:49 +0000
Received: by mail-pl1-f169.google.com with SMTP id v13so14148827ple.9
 for <linux-nvme@lists.infradead.org>; Sun, 25 Apr 2021 11:39:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5YG2hPeM/Yx8k+iQC4Kx30pgH4bvBziMfztPYklA/YY=;
 b=Wn3SLt8rzGZqsDzzYtXR7UGw+7hk3q92yj+Dg9WfzrpxTMpCuk0uP9LgrhvM6yI3+Z
 kArCngc7zNShLI2qrk5RJL5khx8MiHddasRBEvsB8hGpCJ2PNXgfd1CI7T192qcT45mc
 NZuCdoeMs8ZhUIaVYFLQ4DZZK4AuJrlRRlnIRw8z2PmWe+bYdB+g3sa9Ea4B+TFchdaL
 Zk+Ie+eI/fjplpNu1sZsKJPhymPezl48tQ+vLJb7A8JOhs6WY8tPWcNWbFEuOqJ/7Jco
 vzD7dZ6g6dxW9KIgaSjaW5Y+5C1eXwG/7p+imimxRI6OZlzKZ4piZxZb546i4lqfNldo
 wjIg==
X-Gm-Message-State: AOAM531spXZvGsZVr6/cXxvVo0Y9aRWeWXvscgLFjt+UbUhgWXPH2lHW
 pdskXsoWWZHlPIFiv1j7L38=
X-Google-Smtp-Source: ABdhPJwN+teehJ1j2dpG2nmGQYgx83VbGPsxMT79+JYLw9zHjL66D4/ElzwmhTMnburTc0ZLaX5d8Q==
X-Received: by 2002:a17:902:ea05:b029:ed:3116:d65f with SMTP id
 s5-20020a170902ea05b02900ed3116d65fmr1002683plg.73.1619375985787; 
 Sun, 25 Apr 2021 11:39:45 -0700 (PDT)
Received: from [192.168.3.219] (c-73-241-217-19.hsd1.ca.comcast.net.
 [73.241.217.19])
 by smtp.gmail.com with ESMTPSA id g34sm9485942pgg.59.2021.04.25.11.39.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Apr 2021 11:39:45 -0700 (PDT)
Subject: Re: [PATCH 0/8] blk-mq: fix request UAF related with iterating over
 tagset requests
To: Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 linux-block@vger.kernel.org, "Martin K . Petersen"
 <martin.petersen@oracle.com>, Christoph Hellwig <hch@lst.de>
Cc: Khazhy Kumykov <khazhy@google.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Hannes Reinecke <hare@suse.de>, John Garry <john.garry@huawei.com>,
 David Jeffery <djeffery@redhat.com>
References: <20210425085753.2617424-1-ming.lei@redhat.com>
 <77cbc472-279e-5c9a-3428-b1a485b3f1b7@kernel.dk>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <f4d43e0d-cdd7-4a8c-9852-bbc99053fd81@acm.org>
Date: Sun, 25 Apr 2021 11:39:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <77cbc472-279e-5c9a-3428-b1a485b3f1b7@kernel.dk>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210425_113947_696230_1CDC381E 
X-CRM114-Status: GOOD (  15.60  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 4/25/21 9:17 AM, Jens Axboe wrote:
> I'm going to pull the UAF series for now so we don't need to do a series
> of reverts if we deem this a better approach. I'll take a further look
> at it tomorrow.

Please give me the time to post review comments. My opinion about this
series is that (a) the analysis on which some patches are based is wrong
and also (b) that some patches introduce new bugs that are worse than
the current state of the for-next branch and also make it worse than the
v5.11 kernel.

Bart.



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
