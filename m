Return-Path: <SRS0=47LT=HA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED211C433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 01:54:42 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F78964DD8
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 01:54:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F78964DD8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=tw21/HnMEYDO2+ePXt58Ei3XkeXnuxk9jTVCFzfd9MA=; b=FZ1CzDJ7/ruaVxAZgG58wyPtQ
	2LQiuej2JQcHg/EDgnz2KV0YTwHA4vqt3WKkNkVL4jmRmLYNWlcVs6wdjZixv9OYJpjo1wnwSjy1z
	6OJEd7dWm3d+S1wUzzIJoCtherZsEJWSVvJQlzh+ZPhtApdVXuGShME34X8x3fdLVANWbDIXfLBDc
	ZQyH4BgUoJbZTKxdkZG0faBJuy32tXYr0LklPuD/ZQnFqMUangyH6oj9a4YEUjtd8/bdmZhE2+V09
	QCGyNN46MwOr74Qa2rL/cz9ikwwqsn+p/jgdYK6rzvoKczbIvwzqXcH1a58kK5wIio//MAiPZdsSw
	clHCDO7iA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l5Izf-0002gP-7C; Fri, 29 Jan 2021 01:54:39 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5Izc-0002fR-UH
 for linux-nvme@lists.infradead.org; Fri, 29 Jan 2021 01:54:37 +0000
Received: by mail-wr1-f51.google.com with SMTP id 6so7306971wri.3
 for <linux-nvme@lists.infradead.org>; Thu, 28 Jan 2021 17:54:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NOYfGCxZbNpzIpw9lpSoa7XU1YjWos3pUqioNCSVAaA=;
 b=qWJGfmYShGllRCQrIg+yDqfGElkDi8vhKRAtWLWyP9pyf8dIUlPkrX6jIUeN92t39Y
 ZgPN49n2JkkPL8USmkvcDbFqmt5u5ZcgYfuBp5rPBFjiE9KhOM/7xJ47C5oKMIJLZ98N
 P2nHS2erE+l/dVt2xy+xVSQ6rhIMSFNm/wWHZOA13cKgjS0JL05tiliVhT6bd2zw5cZJ
 tV7yAvW6WVMTgPzlkECuTwrHVamCaQVxWyuxNYEM75T/S1wFcbzu4I1hy9CMaVvHZ9f8
 S7pfAb2yk9mYnrR8ivo58Q9uJT/sWQG1rH7KElvGCuPwgRECXp2A82Bl99Gh42JOmoMr
 a/XA==
X-Gm-Message-State: AOAM533GV0PAVUJMMLKXTS5AzFpk+Le8jC0LmZjHd/WpoJ8aDSXd8Omx
 0hnb87duMHtIe0mqwi+j9YQ=
X-Google-Smtp-Source: ABdhPJySL5tYOMcMIC0RsJNhKbwt+kbvRcuoyQIqnRA+Oz4vDIJ0UZH3S1PUuoamRhTmTLgreJWYmQ==
X-Received: by 2002:a5d:4b46:: with SMTP id w6mr1891143wrs.346.1611885275009; 
 Thu, 28 Jan 2021 17:54:35 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:3d48:4849:d506:e578?
 ([2601:647:4802:9070:3d48:4849:d506:e578])
 by smtp.gmail.com with ESMTPSA id f13sm3875303wmf.1.2021.01.28.17.54.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Jan 2021 17:54:34 -0800 (PST)
Subject: Re: [PATCH 17/35] monitor: handle SIGCHLD for terminated child
 processes
To: mwilck@suse.com, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20210126203324.23610-1-mwilck@suse.com>
 <20210126203324.23610-18-mwilck@suse.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e1a56fb5-8aeb-d929-caff-3b7c5000b55c@grimberg.me>
Date: Thu, 28 Jan 2021 17:54:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210126203324.23610-18-mwilck@suse.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210128_205437_281553_639ACB47 
X-CRM114-Status: GOOD (  21.94  )
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
Cc: Hannes Reinecke <hare@suse.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

No commit message?
> Signed-off-by: Martin Wilck <mwilck@suse.com>
> ---
>   monitor.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 48 insertions(+), 2 deletions(-)
> 
> diff --git a/monitor.c b/monitor.c
> index 9375a14..8db40e6 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -26,6 +26,8 @@
>   #include <limits.h>
>   #include <syslog.h>
>   #include <sys/stat.h>
> +#include <sys/types.h>
> +#include <sys/wait.h>
>   #include <sys/epoll.h>
>   
>   #include "common.h"
> @@ -100,6 +102,13 @@ static void monitor_int_handler(int sig)
>   	must_exit = 1;
>   }
>   
> +static sig_atomic_t got_sigchld;
> +
> +static void monitor_chld_handler(int sig)
> +{
> +	got_sigchld = 1;
> +}
> +
>   static sigset_t orig_sigmask;
>   
>   static int monitor_init_signals(void)
> @@ -118,6 +127,9 @@ static int monitor_init_signals(void)
>   		return -errno;
>   	if (sigaction(SIGINT, &sa, NULL) == -1)
>   		return -errno;
> +	sa.sa_handler = monitor_chld_handler;
> +	if (sigaction(SIGCHLD, &sa, NULL) == -1)
> +		return -errno;
>   	return 0;
>   }
>   
> @@ -336,6 +348,34 @@ static void monitor_handle_uevents(struct udev_monitor *monitor)
>   	}
>   }
>   
> +static void handle_sigchld(void)
> +{
> +	while (true) {
> +		int wstatus;
> +		pid_t pid;
> +
> +		pid = waitpid(-1, &wstatus, WNOHANG);
> +		switch(pid) {
> +		case -1:
> +			if (errno != ECHILD)
> +				log(LOG_ERR, "error in waitpid: %m\n");
> +			return;
> +		case 0:
> +			return;
> +		default:
> +			break;
> +		}
> +		if (!WIFEXITED(wstatus))
> +			log(LOG_WARNING, "child %ld didn't exit normally\n",
> +			    (long)pid);
> +		else if (WEXITSTATUS(wstatus) != 0)
> +			log(LOG_NOTICE, "child %ld exited with status \"%s\"\n",
> +			    (long)pid, strerror(WEXITSTATUS(wstatus)));
> +		else
> +			log(LOG_DEBUG, "child %ld exited normally\n", (long)pid);
> +	};
> +}
> +
>   #define MAX_EVENTS 1
>   static int monitor_main_loop(struct udev_monitor *monitor)
>   {
> @@ -357,13 +397,19 @@ static int monitor_main_loop(struct udev_monitor *monitor)
>   	sigfillset(&ep_mask);
>   	sigdelset(&ep_mask, SIGTERM);
>   	sigdelset(&ep_mask, SIGINT);
> +	sigdelset(&ep_mask, SIGCHLD);
>   	while (1) {
>   		int rc, i;
>   
>   		rc = epoll_pwait(ep_fd, events, MAX_EVENTS, -1, &ep_mask);
>   		if (rc == -1 && errno == EINTR) {
> -			log(LOG_NOTICE, "monitor: exit signal received\n");
> -			return 0;
> +			if (must_exit) {
> +				log(LOG_NOTICE, "monitor: exit signal received\n");
> +				return 0;
> +			} else if (got_sigchld) {
> +				got_sigchld = 0;
> +				handle_sigchld();
> +			}
>   		} else if (rc == -1) {
>   			log(LOG_ERR, "monitor: epoll_wait: %m\n");
>   			return -errno;
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
