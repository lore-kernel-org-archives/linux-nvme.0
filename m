Return-Path: <SRS0=Uv50=XV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79D0C352AB
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Sep 2019 20:10:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C054F2245D
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Sep 2019 20:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="puPG/lt6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C054F2245D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=n4rzc2GmbkOzKx1g+cENJumxVDJSuqhm+reD2zCCGcs=; b=puPG/lt6JCVeVHQl9MzNE5Vnn
	p3fVTxzebvz1dpSE6ogpVjVWDu84/eARA2OXCuQ8vOcSah3UnH2KnEx73//4YDiQrRm94NlMGmBqD
	LTbT9z1R7B09XWeZJKgxU9S1IVB6zCx23CC3QtweoV4eG+3Yzc96BhLkq/Qp7Q+jE5562qbIcGt/R
	Filtq2ToCezFWCXOHy+/GoUQTfTSahMcxPUabHSUH1QfqnHvFBlVWHsDth4l8Fd1cqfUu8nEf7tEg
	w+ZkGjkPGJnihgmeLFcN/Smg4L1avjFHMSkgLhHtVpIErKwGsHZRIk4iOfUGRdp6C1Rv0ixnIeTSu
	2KwaiKxxQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iDa5r-0001Py-JM; Thu, 26 Sep 2019 20:10:27 +0000
Received: from mail-oi1-f196.google.com ([209.85.167.196])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iDa5o-0001Pa-4Q
 for linux-nvme@lists.infradead.org; Thu, 26 Sep 2019 20:10:25 +0000
Received: by mail-oi1-f196.google.com with SMTP id i185so3218176oif.9
 for <linux-nvme@lists.infradead.org>; Thu, 26 Sep 2019 13:10:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=P3m6BetU4V1v+NiKN0GYYVen8IFpANn8ULsIugGU64E=;
 b=b/7jCjTD9FPKmXdp/JK9c2Wd5DXw2AKJS7Y63buHGNHtx3lRh3/npnI+ULQUFuRGhs
 CW6lkSuGcNiBPWWFEvE7C4f/u2h2GrkJNIcFwNV4nRHD37KX+sPqq0x/ybU+N01h5Kk7
 +xjKm+MuRoPLBrqMpDcqiBv0RvQ/GZ+ySTVu4IhOm5ZaPvPsg0iiYV5vFH4CC4XX4gXO
 wNyBfdhPmvIl8hwz2QhuI55AyPciZu4Q+u/DCK/AerbWrs40jGFK+z6LAPUSppDKd0jg
 Dg5O1awm1eiltBxDxIiZQznHFhOVa7hYhycQ10mX73nDd565C+pUoDZOeqY3iOKLrguL
 GuxA==
X-Gm-Message-State: APjAAAUgx4lOLkWmswOH1OOxajN3Be4sUu2vOsDyb2Q1k3S6ulHMwubO
 eMYPOIkcdKe6Gik+vG7c++T+PvFl
X-Google-Smtp-Source: APXvYqyd8bKvJN6kk4EO9A0c1ODyx61U/zSsbjg3TdcyEK64+LYWLQjw5nhOdZ1jGy7E+1quYn/V0g==
X-Received: by 2002:aca:3c55:: with SMTP id j82mr4173425oia.135.1569528622635; 
 Thu, 26 Sep 2019 13:10:22 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id j11sm105974otk.80.2019.09.26.13.10.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 26 Sep 2019 13:10:21 -0700 (PDT)
Subject: Re: [PATCH v2 rfc 1/2] nvmet-tcp: time based stop condition in io_work
To: "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "'linux-nvme@lists.infradead.org'" <linux-nvme@lists.infradead.org>
References: <B33B37937B7F3D4CB878107E305D4916D37CA2@ORSMSX104.amr.corp.intel.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <0695bebb-968f-36f2-c850-4974c100cbd7@grimberg.me>
Date: Thu, 26 Sep 2019 13:10:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <B33B37937B7F3D4CB878107E305D4916D37CA2@ORSMSX104.amr.corp.intel.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190926_131024_172942_1B0B51A5 
X-CRM114-Status: GOOD (  24.50  )
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



On 9/26/19 9:38 AM, Wunderlich, Mark wrote:
> Move to a do/while loop terminate condition in
> nvmet_tcp_io_work() that is time based that can be
> applicable for network interface that is in either
> interrupt or polling mode.  If a busy poll time period
> configuration setting (net.core.busy_read) not active
> then assume interrupt mode and default loop period to
> sufficient time period that would have satisfied previous
> default ops count of 64.
> 
> Preserve previous interrupt mode behavior in that do/while
> loop could exit early if at end of an iteration that 'pending'
> is false.
> 
> Outside loop add poll mode interpretation of 'pending',
> resetting it to true if any recv/send activity during
> complete loop time period.
> 
> Re-queue the work item if either mode determines that
> previous activity indicates there may be additional 'pending'
> to be processed.
> 
> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> Signed-off-by: Kiran Patil <kiran.patil@intel.com>
> Signed-off-by: Mark Wunderlich <mark.wunderlich@intel.com>
> ---
>   drivers/nvme/target/tcp.c |   29 +++++++++++++++++++++++++----
>   1 file changed, 25 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index bf4f034..8ec124a 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -21,7 +21,6 @@
>   
>   #define NVMET_TCP_RECV_BUDGET		8
>   #define NVMET_TCP_SEND_BUDGET		8
> -#define NVMET_TCP_IO_WORK_BUDGET	64
>   
>   enum nvmet_tcp_send_state {
>   	NVMET_TCP_SEND_DATA_PDU,
> @@ -1167,6 +1166,15 @@ static void nvmet_tcp_io_work(struct work_struct *w)
>   		container_of(w, struct nvmet_tcp_queue, io_work);
>   	bool pending;
>   	int ret, ops = 0;
> +	unsigned long deadline, bp_usec;
> +	bool interrupt_mode = false;
> +
> +	bp_usec = READ_ONCE(queue->sock->sk->sk_ll_usec);
> +	if (!bp_usec) {
> +		bp_usec = 1000; /* 1 msec default for interrupt mode */
> +		interrupt_mode = true;

Can't say I like the interrupt_mode variable...

> +	}
> +	deadline = jiffies + usecs_to_jiffies(bp_usec);
>   
>   	do {
>   		pending = false;
> @@ -1194,10 +1202,23 @@ static void nvmet_tcp_io_work(struct work_struct *w)
>   			return;
>   		}
>   
> -	} while (pending && ops < NVMET_TCP_IO_WORK_BUDGET);
> +		/* If in interrupt mode, exit loop if this
> +		 * time through there was no activity.
> +		 */
> +		if (interrupt_mode && !pending)
> +			break;

Why can't you break in the adq mode if you don't have any pending work?
This will mean that you don't get an interrupt?

I think we're lacking understanding of how this works, when does the
application get an interrupt and when it does not...

I would like to see some abstraction from the socket interface
that will tell us if we should poll more instead of becoming
aware of the interrupt vs. adq thing...

Overall the performance improvement is impressive with adq, does
this have any impact vs. a non-adq device?

>   
> -	/*
> -	 * We exahusted our budget, requeue our selves
> +	} while (!time_after(jiffies, deadline));
> +
> +	/* For poll mode, pending will be true if there was
> +	 * any completed operations during the complete loop
> +	 * period.
> +	 */
> +	if (!interrupt_mode && ops > 0)
> +		pending = true;
> +
> +	/* We exhausted our budget, requeue if pending indicates
> +	 * potential of more to process in either mode.
>   	 */
>   	if (pending)
>   		queue_work_on(queue->cpu, nvmet_tcp_wq, &queue->io_work);
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
