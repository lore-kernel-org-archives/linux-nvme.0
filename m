Return-Path: <SRS0=XnCc=GP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17411C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 11:28:33 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B389523109
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 11:28:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B389523109
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=x4jF0/HYNVJ1FbxrEMf6VZP6k6Z2sj8pAyjRvLuwQTA=; b=tuC2rgzXVz29D4GCeFnHRCqlc
	FjaDT+YilTV0/M9DnKTWZS0Obg8FSMspu8k3e/8KDHvRj5mnLOL5nE9dGpFUSdyGJXIfvS6d6zaOF
	RJKpTD8ElHyo0FlfkVAopDkJTJn6uhEBioHIKhH+5jeXSu1NQ6iw/PLAnEyV9R/i3CZKpi59Tf0TL
	l7gFK3t4NUE44mb+5+6RmWAtifBk3/1UtCMKjb5vQpBCsfUa3K1Rqw2TUQVSewTYBgjMzaMGejvqQ
	REY20zVvFwaDSZAKODc7+tec+OYv2MDhjkANoPocn9XZSu9cdcodkC5y1Dk48q/KEkKiVllZT2aVR
	V5Se5UHHA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzHqd-0007Kp-IF; Tue, 12 Jan 2021 11:28:27 +0000
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzHqa-0007JE-7j
 for linux-nvme@lists.infradead.org; Tue, 12 Jan 2021 11:28:25 +0000
Received: by mail-pf1-x435.google.com with SMTP id q20so1209205pfu.8
 for <linux-nvme@lists.infradead.org>; Tue, 12 Jan 2021 03:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=19yjSs2tQ/bM/BDowJQe6LBdRNNNQ7XP0IBpNGHHaSU=;
 b=N6PaEQsCts8XnJGBQICigXlAsz2kur05c3q/jFVAu0atVoGCUB2ufhpzV5LQlNukTk
 ubgLr2LZLXi8vLXYc0FGJBowEFHR01W+LMP1EWmat4sgtH40EIhf2o9W4Yshcul7ayYE
 V+JTv8v56/SyTziZK8SgiHnS4EhEEWd1mWps7ngj00eWrne9loz1OLaPmcXEZrxC92BH
 aMkChu5mDG0ne3BAJ7+V7+O2HVS9bZDf/jAnlmhdu4snWXR16RnvbqqzcNkaos3zLf6l
 nhe/IkwHmT4icxiGN78lLJkvSYYw7Xe4ejuZlCJTD0uvPvhW+N6a9Fb8oJ1CDUKiutp4
 HIcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=19yjSs2tQ/bM/BDowJQe6LBdRNNNQ7XP0IBpNGHHaSU=;
 b=dkfCXfsEOhHo3Xk9Tea7XFP2q3K2d11cQdgHyx4/7gDoj4Vun+ll7e8Pwq8qYHeLNW
 zN9YW3mWov3Gc/KtYeZ8NSOzhY+Ben/RCm8oiOf8FjG2UfAjJGjEIBrhh8zOwKfhQpb0
 PRFPIA24ZTwEZfH2VTkhTwOJ6n8fWyzHeGNRnqO+PPSX29s36eRPDWUKPIQoQIK3ZV+T
 s3XTnYpY+dAcPsZRcWLG7J4pYGhfb8xVhJTOTwHIE4dkA/jwpT7goxx1yTwObmIv/LyN
 7YB3thgdQtuI65ZjMzS5ApmJI+j+S+rTmzLWbXnJWBJA8OKKvqbAuTwuKVLJHnMM/GqO
 Y5sw==
X-Gm-Message-State: AOAM533fU6cKLVOggy9zv2omnRMVG63QkvotxaNWcpjNzALH9QaFIF9Q
 rMaGxszlmQB4kFIfgQsWymg=
X-Google-Smtp-Source: ABdhPJy1tkYeNqtoMXn57uvZnpEYAnG3Q+P//4gd/hCwk7maunw1751TMCUXrbc3ksFoyQaCvIK4oQ==
X-Received: by 2002:a63:f64c:: with SMTP id u12mr4343027pgj.98.1610450901761; 
 Tue, 12 Jan 2021 03:28:21 -0800 (PST)
Received: from localhost ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id 186sm2945431pfx.100.2021.01.12.03.28.20
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 12 Jan 2021 03:28:21 -0800 (PST)
Date: Tue, 12 Jan 2021 20:28:19 +0900
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Chao Leng <lengchao@huawei.com>
Subject: Re: [PATCH 3/3] nvme: add parameter command_retry to enable retry
Message-ID: <20210112112819.GB25093@localhost.localdomain>
References: <20210108144659.7126-1-minwoo.im.dev@gmail.com>
 <20210108144659.7126-4-minwoo.im.dev@gmail.com>
 <dfe59030-3eab-a178-7264-792f76dffe4c@huawei.com>
 <20210111122748.GA6831@localhost.localdomain>
 <aec841c9-d60c-4ccd-e9ca-731f20accb42@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aec841c9-d60c-4ccd-e9ca-731f20accb42@huawei.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210112_062824_516087_7B51348C 
X-CRM114-Status: GOOD (  34.96  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hello,

On 21-01-12 17:34:48, Chao Leng wrote:
> 
> 
> On 2021/1/11 20:27, Minwoo Im wrote:
> > Hello,
> > 
> > On 21-01-11 11:47:56, Chao Leng wrote:
> > > 
> > > 
> > > On 2021/1/8 22:46, Minwoo Im wrote:
> > > > nvme_init_request() has set REQ_FAILFAST_DRIVER to make requests
> > > > non-retryable.  This command flag value is checked in
> > > > nvme_decide_disposition() to decide whether to RETRY or other
> > > > operations.  In that point, blk_noretry_request() macro will be used to
> > > > check if command flags have one of REQ_FAILFAST_*.  If so, it just
> > > > decides to complete the request without retrying.
> > > > 
> > > > This patch added a module parameter named command_retry to turn on the
> > > > command retry feature in this driver.  If turning it on,
> > > > REQ3_FAILFAST_DRIVER will not be set to requests so that retry can be
> > > > reached out to nvme_retry_req() based on the module parameter.
> > > > 
> > > > Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
> > > > ---
> > > >    drivers/nvme/host/core.c | 7 ++++++-
> > > >    1 file changed, 6 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > > > index 6e428fdc25a8..e1836ca9956f 100644
> > > > --- a/drivers/nvme/host/core.c
> > > > +++ b/drivers/nvme/host/core.c
> > > > @@ -44,6 +44,10 @@ static unsigned char shutdown_timeout = 5;
> > > >    module_param(shutdown_timeout, byte, 0644);
> > > >    MODULE_PARM_DESC(shutdown_timeout, "timeout in seconds for controller shutdown");
> > > > +static bool command_retry;
> > > > +module_param(command_retry, bool, 0644);
> > > > +MODULE_PARM_DESC(command_retry, "retry commands up to nvme_max_retries");
> > > > +
> > > >    static u8 nvme_max_retries = 5;
> > > >    module_param_named(max_retries, nvme_max_retries, byte, 0644);
> > > >    MODULE_PARM_DESC(max_retries, "max number of retries a command may have");
> > > > @@ -560,7 +564,8 @@ static inline void nvme_init_request(struct request *req,
> > > >    	else /* no queuedata implies admin queue */
> > > >    		req->timeout = NVME_ADMIN_TIMEOUT;
> > > > -	req->cmd_flags |= REQ_FAILFAST_DRIVER;
> > > > +	if (!command_retry)
> > > > +		req->cmd_flags |= REQ_FAILFAST_DRIVER;
> > > In abnormal scenarios, such as request time out, connection process may takes long time or the admin command waits for long time.
> > > Retry only for non-host errors may be a better choice. Maybe we can make some optimizations in nvme_decide_disposition.
> > 
> > Thanks for your review!
> > 
> > Oh, I agreed that it might wait for so long time in connecting process.
> > Restricting some of commands that should be retried would be better as
> > you mentiond.
> > 
> > Do you mean that maybe we can check this module parameter in
> > nvme_decide_disposition()?  Like, even if blk_noretry_request(req) says
> > that it's non-retriable, if this module parameter is enabled, then we
> > can retry rather than failfast?
> No, I mean that add the local preferential retry which defined in the NVMe protocol.

Thanks for your suggestion, Chao.  I think this is much better idea than
module parameter.  Fixing the nvme_decide_disposition() would be better!
I think it's going to be also an answer for Christoph's question on this
patch.  Please let me prepare next pach series.

Thanks,

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
