Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFE9CC83F03
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Jul 2025 16:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uZ5dOYbYOkoWtAAYMytNtT+2qf4Eec58FQAQdPSVMHU=; b=rzVaXIFK0Hm9s7hxftTn6C0qzU
	fhxOAx/a8ElmSJ1dp+CPMZQvdzTtx6X29oPPacZfUV50RQ2XLrSxKcQGcLRE5JwlL6mXYIFD2TLO9
	0fY5J9FQBkXLXk4yOK7HqDPSnHxTJC4oohIl/c841yzvuEeKchFQZrQmytStgfuLTMmqYtME7eHse
	Iqe9TbSm8G87MdEgh+ayl0kUiwuPb0QuLMfOKheNUz1F3MXcJ/7fxurLM6iv7wvzsAZdOOynLZ7Sk
	3BD9jMVzutnPuYNv4Sz0phPEaXNe1unpweVxx7dbr1/No427VkkZ6PsLs5AzmEIfh34/OAKw1GKEH
	4DSCFBMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXjjm-0000000F2RW-0sjb;
	Fri, 04 Jul 2025 16:58:10 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXjFG-0000000ExCE-3fXp
	for linux-nvme@lists.infradead.org;
	Fri, 04 Jul 2025 16:26:40 +0000
Received: by mail-pf1-x444.google.com with SMTP id d2e1a72fcca58-7425bd5a83aso1115901b3a.0
        for <linux-nvme@lists.infradead.org>; Fri, 04 Jul 2025 09:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kerneltoast.com; s=google; t=1751646398; x=1752251198; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uZ5dOYbYOkoWtAAYMytNtT+2qf4Eec58FQAQdPSVMHU=;
        b=Oyi8MRZinX157JxXVZQORiUWo2BJidnXlFPsHnA0I43ectYRfZvgmSYNQwa4BsQ1Ya
         +py8YcbwDj7X9PGFF8RsVdYhAIbw8BjqSBds+mIx5qPOwHg3C8R2/e1x5BYquvYUgqKv
         YJFAr4W2/kckHmNGpk+JwlPAFMiuOCUi4HyVfRS8tPDo6ZREj6A3LqRvnJVsGY5kgThX
         dc49gtqeUN/Gcld9fc7E/Y9z4nnZ9tCnttMD/S1KI0qj+2KC5nv3FfF8SuX0kWKbggKs
         kk/K3znjzNC6gxIQ5A/qtuWJmXUGk8LyOzDSCyAm7IVlycjiL5OYVmWStNwUq7ZaJKzV
         3/LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751646398; x=1752251198;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uZ5dOYbYOkoWtAAYMytNtT+2qf4Eec58FQAQdPSVMHU=;
        b=g808nq/bEkoFWpScaRxIjtIuDhJfc3akwTuocSIJKXSpr05O1sOX36VjgPOkoXohYr
         4wrjqG2BVpJ94mUGzbyzXHGLjbkeqMaAaD9bPaG0zYvezZA5juBy0CbgFp4RgOXUja/6
         RXoMzC1ZGfX6gRnyAERPgFfpaSEJVmuMDrdRhtSzlhhZRA2F5mToeTw8MB2sO8rQeRwH
         4i8PFWO/hj7FzH2Ahbj6V9Icg4uhYmwERMOxcoUWuPlx/+9vnxcKfeUtKNvYMlsS1mPy
         UKvAFUhg13GtrO8NRyYVlFrUBzCqwtvb/suu8lBy3WzhquUBmph066Z28LNIyOiNd6bZ
         EAXg==
X-Forwarded-Encrypted: i=1; AJvYcCUpEj031DrsSpv7m0T44vcYpP59ISn1ISHLv9ezfw4smqo0QhGmSH1XqcPss0Yj7oirTm3654cz1BTr@lists.infradead.org
X-Gm-Message-State: AOJu0Ywa8NjBAczXPy/kPkFt4NKiCse3kay4vt+/4LRYcNi6FOiOB2Jk
	oFG7347sjP0oLGVjkkgBcyI8eX0DWM8RV/P+w4QPgZAelou+ALpKYG6nYnNgBzsBE0vL
X-Gm-Gg: ASbGncunJKHbZaTvRl14xyHVLbuEi0wHvOPQGJLdEkG+svbtXkFdCsqkktEdA0WNUJq
	e4POqSxMloPhZ1VKOBxkiI3XCn6ZZNVn+rb5u7RWlRuRDrv1mFnG1CFAggt0PtjeNDwQPcta3Rw
	Nrc1SpYfsYsTQa8AQvwn1kbzgtMqxJ0nGHfCNj6swHvcm3EUdpLguTkQftQnXDfFySUzTAylXI8
	Bg1XEXkjHlxLr1abvQPNLHASAmDDPJrKR8qF9sj1S93Smwgq/1W8UhEOaKbN/YuL864EnKd7I/v
	jLxsg8PK2+BllqKmQfQ5i12ENnDDV8kQ0WH0WWITAXCunqrOJXCwIaf2A8S7vIQt
X-Google-Smtp-Source: AGHT+IFmNX43fv12lDJwBxyke4slBPfKR27QIULjj2bFsUe07GNEU0S4nbmUu0opAKYqkv0SzWjoEQ==
X-Received: by 2002:a05:6a00:3e21:b0:749:8c3:873e with SMTP id d2e1a72fcca58-74ce8ad900emr3904971b3a.24.1751646397632;
        Fri, 04 Jul 2025 09:26:37 -0700 (PDT)
Received: from sultan-box ([142.147.89.203])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce42ce64esm2213704b3a.153.2025.07.04.09.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 09:26:37 -0700 (PDT)
Date: Fri, 4 Jul 2025 09:26:34 -0700
From: Sultan Alsawaf <sultan@kerneltoast.com>
To: David Jeffery <djeffery@redhat.com>
Cc: Jeremy Allison <jra@samba.org>, Christoph Hellwig <hch@lst.de>,
	Stuart Hayes <stuart.w.hayes@gmail.com>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Martin Belanger <Martin.Belanger@dell.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, Jeremy Allison <jallison@ciq.com>,
	Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Nathan Chancellor <nathan@kernel.org>,
	Jan Kiszka <jan.kiszka@seimens.com>,
	Bert Karwatzki <spasswolf@web.de>
Subject: Re: [PATCH v10 0/5] shut down devices asynchronously
Message-ID: <aGgAuje4tpIOveFc@sultan-box>
References: <20250625201853.84062-1-stuart.w.hayes@gmail.com>
 <20250703114656.GE17686@lst.de>
 <aGaklKejxefXTQB4@jeremy-HP-Z840-Workstation>
 <CA+-xHTFC6KTs6D8EdvmVe=buqw9oN5P7GJ-WWvam6M3SzeZF4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+-xHTFC6KTs6D8EdvmVe=buqw9oN5P7GJ-WWvam6M3SzeZF4g@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250704_092638_961255_16AB5847 
X-CRM114-Status: GOOD (  26.83  )
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

On Fri, Jul 04, 2025 at 09:45:44AM -0400, David Jeffery wrote:
> On Thu, Jul 3, 2025 at 12:13 PM Jeremy Allison <jra@samba.org> wrote:
> >
> > On Thu, Jul 03, 2025 at 01:46:56PM +0200, Christoph Hellwig wrote:
> > >On Wed, Jun 25, 2025 at 03:18:48PM -0500, Stuart Hayes wrote:
> > >> Address resource and timing issues when spawning a unique async thread
> > >> for every device during shutdown:
> > >>   * Make the asynchronous threads able to shut down multiple devices,
> > >>     instead of spawning a unique thread for every device.
> > >>   * Modify core kernel async code with a custom wake function so it
> > >>     doesn't wake up threads waiting to synchronize every time the cookie
> > >>     changes
> > >
> > >Given all these thread spawning issues, why can't we just go back
> > >to the approach that kicks off shutdown asynchronously and then waits
> > >for it without spawning all these threads?
> >
> > It isn't just an nvme issue. Red Hat found the same issue
> > with SCSI devices.
> >
> > My colleague Sultan Alsawaf posted a simpler fix for the
> > earlier patch here:
> >
> > https://lists.infradead.org/pipermail/linux-nvme/2025-January/053666.html
> >
> > Maybe this could be explored.
> >
> 
> Unfortunately, this approach looks flawed. If I am reading it right,
> it assumes async shutdown devices do not have dependencies on sync
> shutdown devices.

It does not make any such assumption. Dependency on a sync device is handled
through a combination of queue_device_async_shutdown() setting an async device's
shutdown_after and the synchronous shutdown loop dispatching an "async" shutdown
for a sync device when it encounters a sync device that has a downstream async
dependency.

> Maintaining all the dependencies is the core problem and source of the
> complexity of the async shutdown patches.

I am acutely aware. Please take a closer look at my patch.

Sultan

