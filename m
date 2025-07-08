Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA132C83F09
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jul 2025 22:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qKXk1db6biREjlZvqs5QtrQaNwXkFG+6GDi1WibA3ro=; b=Y/W/xI0DLOLoA4U3WEn6ocbO7C
	dUBXZ9Bnf54sqRl0Lw0K2v4WynGxpUvKQWF/Wsdrb0hDHfYn3ooQwfbqOEO2XCTlXHCbdqPo6RQfm
	Liu5FZfd75QhoXhdwDJSoGu5tHKOireFYC5HjBL38w1JmWlOgAEjWXbIlKjdoBwh3LKDarIOJy7IQ
	FaEWQCbHQH6K+WbnjVfFdc2t86KBO3NqBQlgPmlg94Iu0bLSVcyh3SCiH5TncACnBIRfOd8mp8g2Y
	wyveWQim1QY28VqGpta/4ao9bnMaEmM5HCHMZsZWxOXhmbwSONgNTmV6Pt/kfGTI/95WXrJ/JkRTV
	HRfScN4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZGd1-00000006kqQ-0CoU;
	Tue, 08 Jul 2025 22:17:31 +0000
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZGcy-00000006kq3-1dG4
	for linux-nvme@lists.infradead.org;
	Tue, 08 Jul 2025 22:17:29 +0000
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-748f5a4a423so2877076b3a.1
        for <linux-nvme@lists.infradead.org>; Tue, 08 Jul 2025 15:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kerneltoast.com; s=google; t=1752013047; x=1752617847; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qKXk1db6biREjlZvqs5QtrQaNwXkFG+6GDi1WibA3ro=;
        b=MmrGL/8zdu0VMEzvpvRe7zmfiXwfMR67tNz8etopZAjfism5YtxjJ0DrAuZ/NA+9Zi
         aOpsG1sMpQOmiMNOC4Z2ira/PEOx9SKIGfukZaI44Kxbn5mUPLuEdz3uX0QvBpKGtyM0
         SLliP5F5gJo9hzRwDvdyUw4v78dLYgd2hGraycb46JglRW0JnFfVvRAeG/zo/OZV4N5z
         5cdiYVhW1QwXSG8fmDr6wBMxJH31ywT22Ta2XO81a8nCI1gGLvaKLeeMe+iRhvptjc/q
         Q4FJtER2lE+2Pda7+RSeVrGFnmFAtqmqn+j3nTJ2HMgoCUsEEUHjI5VaMQPjtP3KLPWt
         YDKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752013047; x=1752617847;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qKXk1db6biREjlZvqs5QtrQaNwXkFG+6GDi1WibA3ro=;
        b=QhqIHlTfFo2ircf8ny1BTJFbkpxcrlrJkm4d2UomldAqRsuU/XaQOS3KTh4XnWSNd/
         7N+MdpRgCsjS0s3MzARN0cE9JRyp4IGi6aSqYhfIV2mEKLI4r6kA12EnxA6iSsswWKYe
         c1IFk4AKY9P8/AwgbQ5gP6/7CEO+Yg99y1AiPeHlIwMcRaRDPWbXlTt1gN8H/MqqRyWL
         oCpuwS+fxYRkmyZe7zPAGKLEE/rrHLGdyiMSUUOvc1L230RRhRLrJvpZkJ53x2hMifq3
         BRAaWxccJwY7Lzv0hTW4lj8Sw741TAT51JL26t527/AYfd3dFxaqac1Tn75REZxqU9D7
         2TDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEj5/doF6j+6aO6WIZZfDdLniUh66QJvEuXgYW21R4cBZg6/0TN4gyvb0VqkLQpMTSPBH/HaVx7iNQ@lists.infradead.org
X-Gm-Message-State: AOJu0YzELKU+Mu11auCXQe0kuHISdnEkS/DJcoOrOMI5HQ1xDXc9vwks
	vra9WFCcSYKIaDzny5CFAHB1g+zkkPK475DL9tDhCVQT1otRX9GoNbzM4LJhMz1ESSVX
X-Gm-Gg: ASbGncsrjD6jjjnw4jahN5UTq1YolAs8FYiZdyMsF9Pbi5n4iXgy46FiiGpIVy9JKUL
	RcopZaASPvrzMmGoh5rrUIkUWe4pH4TmiXQZ5pJqTlvynsa5n4lzzSqQr9ajVf4r7nNBsVckERi
	NvxmiHjLA/Og+feK1/vPSVtI+jgFOsMfTNERtUJIu9mWTM3aznkuQ+DfXV9phG08TJ9cVRDQ+KF
	LsFzGgH7AZelNorfB1u+zwV2XpT/O4Kt7a1tjPwh3JU4vGso5m6haYyzPGznUvLAjMPyIoDrSAt
	b847bb0uFsk/yykoalr9K1soclJz+P5P8AF3K2Afj76VYgoxkugVF+FISNHpbfT9
X-Google-Smtp-Source: AGHT+IFrdLI7zE62JzRTcm8R+nfJf9KUyF1VAbRhM4J+cUdpeivJAHC78io6XrTAM4cJnrpP4SgnAg==
X-Received: by 2002:a05:6a00:2d0c:b0:74c:efae:ffae with SMTP id d2e1a72fcca58-74ea63e3dbfmr342284b3a.5.1752013047402;
        Tue, 08 Jul 2025 15:17:27 -0700 (PDT)
Received: from sultan-box ([142.147.89.207])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce35cc13csm11567452b3a.47.2025.07.08.15.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 15:17:26 -0700 (PDT)
Date: Tue, 8 Jul 2025 15:17:23 -0700
From: Sultan Alsawaf <sultan@kerneltoast.com>
To: Stuart Hayes <stuart.w.hayes@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Martin Belanger <Martin.Belanger@dell.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, David Jeffery <djeffery@redhat.com>,
	Jeremy Allison <jallison@ciq.com>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Nathan Chancellor <nathan@kernel.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Bert Karwatzki <spasswolf@web.de>
Subject: Re: [PATCH v10 1/5] kernel/async: streamline cookie synchronization
Message-ID: <aG2Y8795VSeT75hH@sultan-box>
References: <20250625201853.84062-1-stuart.w.hayes@gmail.com>
 <20250625201853.84062-2-stuart.w.hayes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625201853.84062-2-stuart.w.hayes@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250708_151728_429086_FC13875A 
X-CRM114-Status: GOOD (  28.59  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Jun 25, 2025 at 03:18:49PM -0500, Stuart Hayes wrote:
> From: David Jeffery <djeffery@redhat.com>
> 
> To prevent a thundering herd effect, implement a custom wake function for
> the async shubsystem which will only wake waiters which have all their
> dependencies completed.
> 
> The async subsystem currently wakes all waiters on async_done when an async
> task completes. When there are many tasks trying to synchronize on differnt
> async values, this can create a thundering herd problem when an async task
> wakes up all waiters, most of whom go back to waiting after causing
> lock contention and wasting CPU.
> 
> Signed-off-by: David Jeffery <djeffery@redhat.com>
> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> ---
>  kernel/async.c | 42 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 41 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/async.c b/kernel/async.c
> index 4c3e6a44595f..ae327f29bac9 100644
> --- a/kernel/async.c
> +++ b/kernel/async.c
> @@ -76,6 +76,12 @@ struct async_entry {
>  	struct async_domain	*domain;
>  };
>  
> +struct async_wait_entry {
> +	wait_queue_entry_t wait;
> +	async_cookie_t cookie;
> +	struct async_domain *domain;
> +};
> +
>  static DECLARE_WAIT_QUEUE_HEAD(async_done);
>  
>  static atomic_t entry_count;
> @@ -298,6 +304,24 @@ void async_synchronize_full_domain(struct async_domain *domain)
>  }
>  EXPORT_SYMBOL_GPL(async_synchronize_full_domain);
>  
> +/**
> + * async_domain_wake_function - wait function for cooking synchronization
> + *
> + * Custom wait function for async_synchronize_cookie_domain to check cookie
> + * value.  This prevents waking up waiting threads unnecessarily.
> + */
> +static int async_domain_wake_function(struct wait_queue_entry *wait,
> +				      unsigned int mode, int sync, void *key)
> +{
> +	struct async_wait_entry *await =
> +		container_of(wait, struct async_wait_entry, wait);
> +
> +	if (lowest_in_progress(await->domain) < await->cookie)
> +		return 0;
> +
> +	return autoremove_wake_function(wait, mode, sync, key);
> +}
> +
>  /**
>   * async_synchronize_cookie_domain - synchronize asynchronous function calls within a certain domain with cookie checkpointing
>   * @cookie: async_cookie_t to use as checkpoint
> @@ -310,11 +334,27 @@ EXPORT_SYMBOL_GPL(async_synchronize_full_domain);
>  void async_synchronize_cookie_domain(async_cookie_t cookie, struct async_domain *domain)
>  {
>  	ktime_t starttime;
> +	struct async_wait_entry await = {
> +		.cookie = cookie,
> +		.domain = domain,
> +		.wait = {
> +			.func = async_domain_wake_function,
> +			.private = current,
> +			.flags = 0,
> +			.entry = LIST_HEAD_INIT(await.wait.entry),
> +		}};
>  
>  	pr_debug("async_waiting @ %i\n", task_pid_nr(current));
>  	starttime = ktime_get();
>  
> -	wait_event(async_done, lowest_in_progress(domain) >= cookie);
> +	for (;;) {
> +		prepare_to_wait(&async_done, &await.wait, TASK_UNINTERRUPTIBLE);
> +
> +		if (lowest_in_progress(domain) >= cookie)

This line introduces a bug on PREEMPT_RT because lowest_in_progress() may sleep
on PREEMPT_RT. If it does sleep, it'll corrupt the current task's state by
setting it to TASK_RUNNING after the sleep is over. IOW, the current task's
state might be TASK_RUNNING after lowest_in_progress() returns.

lowest_in_progress() may sleep on PREEMPT_RT because it locks a non-raw spin
lock (async_lock).

> +			break;
> +		schedule();
> +	}
> +	finish_wait(&async_done, &await.wait);
>  
>  	pr_debug("async_continuing @ %i after %lli usec\n", task_pid_nr(current),
>  		 microseconds_since(starttime));
> -- 
> 2.39.3
> 

Sultan

