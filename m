Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57AC6C83F09
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jul 2025 21:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vv8bVQli0FxG/x60urjN+lD1A8MWHKf0hpuLGEAS4zo=; b=fsJ31/D5aQe6a7XItr/EhrsUqp
	05tK+G3+uawQGryIDKMEH7ZdeOc7/7goUPdb/77QQzryyoVlgd1mJHEDGTZpogisWyBcZrbqTTkyv
	GO+79Shpo7WotBMJWArZyJbE6UHrW/7D9GAul54C657rEaL7sUaIfz+LM7tGR8wlbLGH0LAjN9YyB
	jLKih3QmtNj0S/bjOZfBjdFXGESt0rCuCO1CNaVX4+GTDPvp+1HqkhlyqyNUCGkniWlRIfH5NlxE8
	aT9O3cuTesKqAxoIpkFzhMWH5XYdJpFmLSQDRvhTD8EhDlBS2QqFC89PZdzXVxY7WfrKAFZch+YC5
	WvrzeSyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZG07-00000006gQD-3MG9;
	Tue, 08 Jul 2025 21:37:19 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZFuj-00000006fqj-05Oo
	for linux-nvme@lists.infradead.org;
	Tue, 08 Jul 2025 21:31:46 +0000
Received: by mail-pf1-x441.google.com with SMTP id d2e1a72fcca58-748e63d4b05so2653850b3a.2
        for <linux-nvme@lists.infradead.org>; Tue, 08 Jul 2025 14:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kerneltoast.com; s=google; t=1752010304; x=1752615104; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vv8bVQli0FxG/x60urjN+lD1A8MWHKf0hpuLGEAS4zo=;
        b=JB62kAnpb0oSHhgb1znFISXrkfv9wvpaTN5Ilh+9jUvLydv+fRS/Xf35vVinHuKFDz
         GMfzOK77Trjyo5zJfdrYte3BAoJwR2j71/6ZXnza+j+2VQ6HjH9YNig6OWXHwx2+gsZK
         PaT+CbVe2hgO2M2srzr8YAZVV1EXPM7ii9HoLPZ30wK8uX5H5+7MtxnRzrJM5x1xHhVD
         4Fhyw7lXtDbuO9Du1/Ni8FIho3T6F+ivIPRFjWRJxyBZ1POZyVJs1XXwUAb8JwCoNUr5
         N5nJz1WcjWssLXCEO3Rhyw2wfO1krQv6hamSv1/9pjf2GDBqfs0RBUA4AGOyhBuKCYqo
         ZwKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752010304; x=1752615104;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vv8bVQli0FxG/x60urjN+lD1A8MWHKf0hpuLGEAS4zo=;
        b=SK6BJ30ERlTjqLzr9zPfMxRE/ycfxuIplEkL6+m0cxPxklUqP+GBYiVsq7lhe61UHK
         Mn8QeYwyV1whI4zHqXkts/e8pmNPIGnOOrKsC2FZWmD7aFPK8qbzVl0ycdI1U3T2rkNC
         804U1gf9p5Nzfztpb+1o2lUnsHbUbGM7C1BD1Bl8Jd95XRWiaxT/sBc+ecmpq832MULM
         9S1nFkEXlPIdmpUC0lMUZXmW9jAGRHGIy9sd+IHq0X91EEHSGw8mrkaH/ROET0Yug6Nq
         1g4kuRyFXAg0Dr9qP9x1aoQtcTRtMGsv5WFJJNFHUc3v6AEQMErhsgXoHo+6eauEgD8M
         Y/+w==
X-Forwarded-Encrypted: i=1; AJvYcCUOw1i4onoSCxqFt7YUpczx5fy+e0d8rDjWOJFOz1Y3yZtfLzPh9/87g/EXqERXHwnYXb0f2StWpToi@lists.infradead.org
X-Gm-Message-State: AOJu0YxhA1rT187oKtWcdkuaWrlEedMeAmkzzoRlejU3caeE+xpl8HBb
	8/hM9izEnxwbk+d1jgC19iCBKEBtIMuy0na/JhzxFtf3n1Ospd9KK29MSxJ2cB3oHw00
X-Gm-Gg: ASbGncuWZMdcPgSEkMEhwiv5+v01lvDAiRkwq24CGwGOkoC5CbTwvp/LXv9qFGXLsWD
	ACoVyCVYd7K90WkNH2JWWnc1LmGSfO7kSnd9KbKMvJ8AiJeAh561DLrjANkMLf+jeLA0Qk0VuyO
	RXY0Ce1NdQzcNXrba4E5807ME+yiyyw/3OqMviiFjFKswxtAKBSOERBlN1YlkYB4hr7C6mRzAPO
	RBUoVx6g9WzpdiTJcdx/I99PpO+gaMrJWnIhfxF/Gxaa9j0dMK9QgkaPhr5FJUPHRZ/4X18j/dc
	Q9lTCGDvMtfW9mgVqjA+bdLEa+1UuGXFyIELEApIsTSAoIJeJzkJoReQeFVZZrqT
X-Google-Smtp-Source: AGHT+IGQtf7HMV5vqQ74P9l7ev3A5Dl/XSsOjm90Q34YEw8Cu0ZhOjMuNUH318xDdiC/AsjYN0mxWQ==
X-Received: by 2002:a05:6a00:a95:b0:748:2d1d:f7b3 with SMTP id d2e1a72fcca58-74ea66b0bf5mr161000b3a.22.1752010303895;
        Tue, 08 Jul 2025 14:31:43 -0700 (PDT)
Received: from sultan-box ([142.147.89.207])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce42cefccsm12475681b3a.156.2025.07.08.14.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 14:31:43 -0700 (PDT)
Date: Tue, 8 Jul 2025 14:31:39 -0700
From: Sultan Alsawaf <sultan@kerneltoast.com>
To: stuart hayes <stuart.w.hayes@gmail.com>
Cc: David Jeffery <djeffery@redhat.com>, Jeremy Allison <jra@samba.org>,
	Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Martin Belanger <Martin.Belanger@dell.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, Jeremy Allison <jallison@ciq.com>,
	Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Nathan Chancellor <nathan@kernel.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Bert Karwatzki <spasswolf@web.de>
Subject: Re: [PATCH v10 0/5] shut down devices asynchronously
Message-ID: <aG2OO3-KerXN8t3o@sultan-box>
References: <20250625201853.84062-1-stuart.w.hayes@gmail.com>
 <20250703114656.GE17686@lst.de>
 <aGaklKejxefXTQB4@jeremy-HP-Z840-Workstation>
 <CA+-xHTFC6KTs6D8EdvmVe=buqw9oN5P7GJ-WWvam6M3SzeZF4g@mail.gmail.com>
 <aGgAuje4tpIOveFc@sultan-box>
 <CA+-xHTFNRwbxH=zNMM4kasB=kUAne0b6cxPM+sq5FyM32k8peg@mail.gmail.com>
 <fd941519-6f71-4286-9517-2dc861ee99a5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fd941519-6f71-4286-9517-2dc861ee99a5@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250708_143145_132676_E9C35318 
X-CRM114-Status: GOOD (  45.34  )
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

On Mon, Jul 07, 2025 at 03:49:44PM -0500, stuart hayes wrote:
> On 7/7/2025 10:34 AM, David Jeffery wrote:
> > On Fri, Jul 4, 2025 at 12:26 PM Sultan Alsawaf <sultan@kerneltoast.com> wrote:
> > > 
> > > On Fri, Jul 04, 2025 at 09:45:44AM -0400, David Jeffery wrote:
> > > > On Thu, Jul 3, 2025 at 12:13 PM Jeremy Allison <jra@samba.org> wrote:
> > > > > 
> > > > > On Thu, Jul 03, 2025 at 01:46:56PM +0200, Christoph Hellwig wrote:
> > > > > > On Wed, Jun 25, 2025 at 03:18:48PM -0500, Stuart Hayes wrote:
> > > > > > > Address resource and timing issues when spawning a unique async thread
> > > > > > > for every device during shutdown:
> > > > > > >    * Make the asynchronous threads able to shut down multiple devices,
> > > > > > >      instead of spawning a unique thread for every device.
> > > > > > >    * Modify core kernel async code with a custom wake function so it
> > > > > > >      doesn't wake up threads waiting to synchronize every time the cookie
> > > > > > >      changes
> > > > > > 
> > > > > > Given all these thread spawning issues, why can't we just go back
> > > > > > to the approach that kicks off shutdown asynchronously and then waits
> > > > > > for it without spawning all these threads?
> > > > > 
> > > > > It isn't just an nvme issue. Red Hat found the same issue
> > > > > with SCSI devices.
> > > > > 
> > > > > My colleague Sultan Alsawaf posted a simpler fix for the
> > > > > earlier patch here:
> > > > > 
> > > > > https://lists.infradead.org/pipermail/linux-nvme/2025-January/053666.html
> > > > > 
> > > > > Maybe this could be explored.
> > > > > 
> > > > 
> > > > Unfortunately, this approach looks flawed. If I am reading it right,
> > > > it assumes async shutdown devices do not have dependencies on sync
> > > > shutdown devices.
> > > 
> > > It does not make any such assumption. Dependency on a sync device is handled
> > > through a combination of queue_device_async_shutdown() setting an async device's
> > > shutdown_after and the synchronous shutdown loop dispatching an "async" shutdown
> > > for a sync device when it encounters a sync device that has a downstream async
> > > dependency.
> > > 
> > 
> > Yes, but not what I think fails. This handles a sync parent having an
> > async child. It does not handle the reverse, a sync child having an
> > async parent.
> > 
> > For example, take a system with 1 pci nvme device. The nvme device
> > which is flagged for async shutdown can have sync shutdown children as
> > well as a sync shutdown parent. The patch linked pulls the async
> > device off the shutdown list into a separate async list, then starts
> > this lone async device with queue_device_async_shutdown from being on
> > the async list. The device then is passed to the async subsystem
> > running shutdown_one_device_async where it will immediately do
> > shutdown due to a zero value shutdown_after. The patch sets
> > shutdown_after for its parent, but there is nothing connecting and
> > ordering the async device to its sync children which will be shutdown
> > later from the original device_shutdown task.
> > 
> > > > Maintaining all the dependencies is the core problem and source of the
> > > > complexity of the async shutdown patches.
> > > 
> > > I am acutely aware. Please take a closer look at my patch.
> > > 
> > 
> > I have, and it still looks incomplete to me.
> > 
> > David Jeffery
> > 
> 
> Also, the way it is implemented, it could hang if there isn't enough memory
> to queue up all of the async device shutdowns before starting the
> synchronous shutdowns.
> 
> When you call async_schedule_domain() and there's not enough memory to
> allocate an async_entry, the async function will be run immediately. If that
> happens when queuing up the async shutdowns, it could easily hang if there
> if there are any dependencies requiring an async device shutdown to have to
> wait for a synchronous device to shutdown, since none of the synchronous
> shutdown devices have been scheduled yet.

FWIW, I did consider this scenario when I wrote my patch and this hang cannot
occur with the way I implemented async shutdown. The reason is because my patch
assumes that async devices never need to wait on synchronous devices to shut
down, as David pointed out. My patch only assumes that synchronous devices need
to wait for async devices, so any allocation failures in async_schedule_domain()
won't cause the hang you described.

Sultan

