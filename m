Return-Path: <SRS0=B93q=GO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF11CC433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Jan 2021 12:28:04 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F180222F9
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Jan 2021 12:28:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F180222F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=JVCrGzEvbvmCRYHAgPE0qU23LiEqIBiOhkeniv2zbYk=; b=dHYERHI3Qy2osmse1LNIIzbnm
	B8R/ZhQ7icePdKpAT6JoUV/ikKMcwIvwtzUwUXJyVBPnB/SmfES+Gvtqxn6CnnlUGb+ynWXc7t7y9
	2/LlDwhNZD9mb8SFwwmk62tit/2XPumF53Cybig6rSO5cUbTCAYjMDdK1LbUumR+NV1Kpx53L7cYZ
	pabaH4aN7OhIr5EetHM8O45ND5pMnnOAvDkkHPncnXYZvO8ifIdmPpdpCk335GYjYJhb2HFA82Jvj
	D6nGezKqDzzB9VDSEO22H0fnyiVUGxxLSelY9DKgrtp5JAAAZ+OFfrdaPcDyf55P9iqhLyq21C+OI
	FdrhF/96w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kywIf-0001kR-2p; Mon, 11 Jan 2021 12:27:57 +0000
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kywId-0001je-6c
 for linux-nvme@lists.infradead.org; Mon, 11 Jan 2021 12:27:56 +0000
Received: by mail-pl1-x633.google.com with SMTP id t6so9446596plq.1
 for <linux-nvme@lists.infradead.org>; Mon, 11 Jan 2021 04:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=AFQB3KvRtY2Z0yWWDcb9UFtXL25/GUNfZr3zcxo4lMc=;
 b=TIwxMfYW/3LGrRYtFQC5Rc6eQmLQ68X2/FimjW1xFlnUIZ3WOwlLb/Uyjt27x46o5w
 9OxJQTXZ4xIlz000fzg/yBhMxzATk0H9kpnskhtVl1CA19Xx6gs8M7rmrgf+W+BiLgt2
 WgS7b8j/5Eh9ke7ITtm/kpyP0b/dRo6G20R9exvV5VU76PMEDeso6zXw8uDpYKiw8WCJ
 DU6NIrwEbSzTrzRQbnwm/1WoKDZX1NWZTzNRLkYE8jr2SevMF6HK0HCYpeXQp/TjVWrg
 yvFcM2g6Jjvt0fqfvXeoMhr7aMKr5UhyRvj1s1aTgmcVnY20dXlUysPPXopAzyJj2YHK
 2obg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=AFQB3KvRtY2Z0yWWDcb9UFtXL25/GUNfZr3zcxo4lMc=;
 b=m7eIrgftZDYeyiwXoki2prGEdETK8KAQ0ktfECnEnemNwQcMLjtGCB6oZ5UCLVyLn4
 0+ynMz1fYWze/50ZGitgPUuA6RGx4jdYXS0B32ZxrMGxgPVqBCPD5Q1MWz4rHn6uHrp8
 qzIHeX8zWwoNa89gCbHmzv+BsKn9iVL8PvKsBxGJ+ltrs5bt0itCZVqXxgSQDaYXlqAi
 YOJ28nP+3wBPNE5hSeE5QfBINyuWKT0W0ZH2pimd77PLvcINPSR29QmZ2oI0jplCKAK/
 oNsASYmybMtYRjTjkLBsbJgSgf4MKA+ZyXCzEAiXh3ZwQUWjAE8RnAsK0zpCldSNsYgo
 kkag==
X-Gm-Message-State: AOAM5309ol/Zih+1DNbfviaUMoW5stBFVg8YreF4PxFq6/pjOvw9s6Mu
 T+EGq7GRy5RyJRM3SP3k7Xc=
X-Google-Smtp-Source: ABdhPJxcQv42C4axaj7zguLrPSXDNkU7OH5H/4kEY5O+AoN3AUipmSnulrPXFX/HfZZcI6x0u4EE1A==
X-Received: by 2002:a17:90a:2b88:: with SMTP id
 u8mr18017589pjd.161.1610368071280; 
 Mon, 11 Jan 2021 04:27:51 -0800 (PST)
Received: from localhost ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id d4sm18968377pfo.127.2021.01.11.04.27.50
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 11 Jan 2021 04:27:50 -0800 (PST)
Date: Mon, 11 Jan 2021 21:27:48 +0900
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Chao Leng <lengchao@huawei.com>
Subject: Re: [PATCH 3/3] nvme: add parameter command_retry to enable retry
Message-ID: <20210111122748.GA6831@localhost.localdomain>
References: <20210108144659.7126-1-minwoo.im.dev@gmail.com>
 <20210108144659.7126-4-minwoo.im.dev@gmail.com>
 <dfe59030-3eab-a178-7264-792f76dffe4c@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <dfe59030-3eab-a178-7264-792f76dffe4c@huawei.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210111_072755_268352_9B86190D 
X-CRM114-Status: GOOD (  27.38  )
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

On 21-01-11 11:47:56, Chao Leng wrote:
> 
> 
> On 2021/1/8 22:46, Minwoo Im wrote:
> > nvme_init_request() has set REQ_FAILFAST_DRIVER to make requests
> > non-retryable.  This command flag value is checked in
> > nvme_decide_disposition() to decide whether to RETRY or other
> > operations.  In that point, blk_noretry_request() macro will be used to
> > check if command flags have one of REQ_FAILFAST_*.  If so, it just
> > decides to complete the request without retrying.
> > 
> > This patch added a module parameter named command_retry to turn on the
> > command retry feature in this driver.  If turning it on,
> > REQ3_FAILFAST_DRIVER will not be set to requests so that retry can be
> > reached out to nvme_retry_req() based on the module parameter.
> > 
> > Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
> > ---
> >   drivers/nvme/host/core.c | 7 ++++++-
> >   1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index 6e428fdc25a8..e1836ca9956f 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -44,6 +44,10 @@ static unsigned char shutdown_timeout = 5;
> >   module_param(shutdown_timeout, byte, 0644);
> >   MODULE_PARM_DESC(shutdown_timeout, "timeout in seconds for controller shutdown");
> > +static bool command_retry;
> > +module_param(command_retry, bool, 0644);
> > +MODULE_PARM_DESC(command_retry, "retry commands up to nvme_max_retries");
> > +
> >   static u8 nvme_max_retries = 5;
> >   module_param_named(max_retries, nvme_max_retries, byte, 0644);
> >   MODULE_PARM_DESC(max_retries, "max number of retries a command may have");
> > @@ -560,7 +564,8 @@ static inline void nvme_init_request(struct request *req,
> >   	else /* no queuedata implies admin queue */
> >   		req->timeout = NVME_ADMIN_TIMEOUT;
> > -	req->cmd_flags |= REQ_FAILFAST_DRIVER;
> > +	if (!command_retry)
> > +		req->cmd_flags |= REQ_FAILFAST_DRIVER;
> In abnormal scenarios, such as request time out, connection process may takes long time or the admin command waits for long time.
> Retry only for non-host errors may be a better choice. Maybe we can make some optimizations in nvme_decide_disposition.

Thanks for your review!

Oh, I agreed that it might wait for so long time in connecting process.
Restricting some of commands that should be retried would be better as
you mentiond.

Do you mean that maybe we can check this module parameter in
nvme_decide_disposition()?  Like, even if blk_noretry_request(req) says
that it's non-retriable, if this module parameter is enabled, then we
can retry rather than failfast?

Thanks,

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
