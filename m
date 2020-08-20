Return-Path: <SRS0=ANWg=B6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A464C433E1
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 16:58:59 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46E612072D
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 16:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ARG12/ly"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46E612072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=v3TBq1b+ohd+FRmd7HwOL5dYtYVno9glyUKWJ0mg+Kw=; b=ARG12/ly/1MqfOEdazxoS1OtP
	gNmjHk0f4mjTcbmSOq03SoqOPVJ2EWQBSeUDIuRCgKButP2RW7II3kX8u9mLc2QqnJ3cFT24wCaCf
	h6kAowWS3SjwmuehMgJYqgj+ac5327VgT6Fax4ImkTXyxznCZl/nlFjin+egYkMUJmspTzdKAmlD7
	eHredWRVkyo7HqqHYPTGZzTGEC32TwD2CetT30SPlVk3InEt2iwlsXyVh/bsJx7KQjkNmXnZx19Nj
	FXpmg8QgDWZN2UwWfVVl6lAEIJyc7h63r5ERiVn2mstplZ6lcSdZlj1NXbfWJJH07hn4K5bLNpbfS
	iz8yjM+IQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8ntw-0004Ej-Ql; Thu, 20 Aug 2020 16:58:56 +0000
Received: from mail-pg1-f195.google.com ([209.85.215.195])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8ntv-0004De-8I
 for linux-nvme@lists.infradead.org; Thu, 20 Aug 2020 16:58:56 +0000
Received: by mail-pg1-f195.google.com with SMTP id d19so1414920pgl.10
 for <linux-nvme@lists.infradead.org>; Thu, 20 Aug 2020 09:58:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=p6BQ4B8xenZ9dMrpQ7qOCJQ36LlHR6UM0+AXR3vGaHM=;
 b=WqY5BXFjOt/PlGl81lTkMUcPWyrExGtpXL6tYvykWJNyZXNFZ19f6nsFwAwTgo89Vh
 UG1uAFG2WcFgXKGqQ2Q/AVPkzjJfEFJJRTYCfC5OmDfSG9FzVai/L/jVCUnV/499+n2u
 Irv8TQNMjX3GZFI792I41a3a5Emmz0AlItm9RBY3E1I2jgnQlPXbsHw/tQrmdRcRXqKy
 PvIYIa5ICmnylME4BjJnezow04khDOACkJ/yV6V5lp+OxsPWjR0/I3nvowDxMFEWiS7D
 vEkA74k2aKTclAYvqY9uyp/c6nU69KLujRnLYI0oBasjX2abukoLg9TpGQGjY1FU+uR1
 wRJA==
X-Gm-Message-State: AOAM531EXS+sojOvkeFFwi3O3E6CSeiFQjNI1GQl4+h45PDVe/RAm/Sn
 LB3yFsDRZISf9n5HUJ6WXU4=
X-Google-Smtp-Source: ABdhPJxNnWd8EXvl9hVix61pLbQ+g3h1v5nOywmn7utOGgMxF/1AByrXJpRvJyb5Zl+iSeckzLl9Nw==
X-Received: by 2002:a63:9853:: with SMTP id l19mr2977223pgo.98.1597942733721; 
 Thu, 20 Aug 2020 09:58:53 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:7ced:8569:4373:1bd3?
 ([2601:647:4802:9070:7ced:8569:4373:1bd3])
 by smtp.gmail.com with ESMTPSA id js19sm2740449pjb.33.2020.08.20.09.58.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2020 09:58:53 -0700 (PDT)
Subject: Re: [PATCH v3 2/9] nvme-fabrics: allow to queue requests for live
 queues
To: Christoph Hellwig <hch@lst.de>
References: <20200820053651.197057-1-sagi@grimberg.me>
 <20200820053651.197057-3-sagi@grimberg.me> <20200820060941.GB6188@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <813bbd6c-3353-2c40-da48-bdbbdf89690c@grimberg.me>
Date: Thu, 20 Aug 2020 09:58:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200820060941.GB6188@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200820_125855_353572_CBFFA88A 
X-CRM114-Status: GOOD (  25.46  )
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
Cc: Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>,
 linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> Right now we are failing requests based on the controller state (which
>> is checked inline in nvmf_check_ready) however we should definitely
>> accept requests if the queue is live.
>>
>> When entering controller reset, we transition the controller into
>> NVME_CTRL_RESETTING, and then return BLK_STS_RESOURCE for non-mpath
>> requests (have blk_noretry_request set).
>>
>> This is also the case for NVME_REQ_USER for the wrong reason. There
>> shouldn't be any reason for us to reject this I/O in a controller reset.
>> We do want to prevent passthru commands on the admin queue because we
>> need the controller to fully initialize first before we let user passthru
>> admin commands to be issued.
>>
>> In a non-mpath setup, this means that the requests will simply be
>> requeued over and over forever not allowing the q_usage_counter to drop
>> its final reference, causing controller reset to hang if running
>> concurrently with heavy I/O.
> 
> I'm still rather bothered with the admin queue exception.  And given that
> the q_usage_counter problem should only really be an issue for file system
> requests, as passthrough requests do not automatically get retried why
> can't we just reject all user command to be symetric and straight forward?
> The callers in userspace need to be able to cope with retryable errors
> anyway.

Looking at the code again, I think we can kill it as well.

The concern is we may issue user generated admin commands before
the controller is enabled (generating an unforced error just because
we queued to early). That used to be the case when the admin connect
used the admin_q which meant we needed to unquiesce before, but
now that the admin connect uses the fabrics_q, that should no
longer be an issue.

in nvme-tcp we unquiesce after we enable the ctrl:
--
         error = nvme_tcp_start_queue(ctrl, 0);
         if (error)
                 goto out_cleanup_queue;

         error = nvme_enable_ctrl(ctrl);
         if (error)
                 goto out_stop_queue;

         blk_mq_unquiesce_queue(ctrl->admin_q);
--

Also in nvme-rdma:
--
         error = nvme_rdma_start_queue(ctrl, 0);
         if (error)
                 goto out_cleanup_queue;

         error = nvme_enable_ctrl(&ctrl->ctrl);
         if (error)
                 goto out_stop_queue;

         ctrl->ctrl.max_segments = ctrl->max_fr_pages;
         ctrl->ctrl.max_hw_sectors = ctrl->max_fr_pages << (ilog2(SZ_4K) 
- 9);
         if (pi_capable)
                 ctrl->ctrl.max_integrity_segments = ctrl->max_fr_pages;
         else
                 ctrl->ctrl.max_integrity_segments = 0;

         blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
--

And also in nvme-fc:
--
         ret = nvmf_connect_admin_queue(&ctrl->ctrl);
         if (ret)
                 goto out_disconnect_admin_queue;

         set_bit(NVME_FC_Q_LIVE, &ctrl->queues[0].flags);

         /*
          * Check controller capabilities
          *
          * todo:- add code to check if ctrl attributes changed from
          * prior connection values
          */

         ret = nvme_enable_ctrl(&ctrl->ctrl);
         if (ret)
                 goto out_disconnect_admin_queue;

         ctrl->ctrl.max_segments = ctrl->lport->ops->max_sgl_segments;
         ctrl->ctrl.max_hw_sectors = ctrl->ctrl.max_segments <<
                                                 (ilog2(SZ_4K) - 9);

         blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
--

James, can you please have a look if this is still an issue?

>>   	/*
>> +	 * currently we have a problem sending passthru commands
>> +	 * on the admin_q if the controller is not LIVE because we can't
>> +	 * make sure that they are going out after the admin connect,
>> +	 * controller enable and/or other commands in the initialization
>> +	 * sequence. until the controller will be LIVE, fail with
>> +	 * BLK_STS_RESOURCE so that they will be rescheduled.
>>   	 */
> 
> Nit: please start multi-line comments with a capital letter.  Also I
> think some of the lines do not nearly use up the 80 characters available.

Will fix.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
