Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEE55C83F09
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jul 2025 21:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=13tR6fzkt2bQ08ugXjACDh19YKyW3sNzP8lou+ZxAAk=; b=qT/SXKbpusMwBOuyMSXSizX1BA
	xe4gHVnzp2TOyM3HSqnv3F8BYl7CZy3lBQx6KPmhIz5IvpWd6rtz92vc1Gj15JVAMdzM+fuI1SIjU
	nbIaEggkgiR6Fkzu0cfXr44U0G60G5htwXkWQ7e7lJ8IFvjhxDQ8CCNPRdJ79W8jehmNbgn2R2+PM
	M3argssvZzb2UI9T4hBlthmsUL0RunxJrA6OyDXKYvqgOZt//ywR5CWtb1KZbrhkSERnL0msqg1Q3
	iknEysUBRMBZK4g2NKMYcxpJTUCP0mQ3C1qxXYiKjN3+YoG43tXr8YDO+p5Z191oGZ1+Gknz4eRXL
	+84BJr2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZG9d-00000006hO2-0wYB;
	Tue, 08 Jul 2025 21:47:09 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZG9b-00000006hNX-0Iiq
	for linux-nvme@lists.infradead.org;
	Tue, 08 Jul 2025 21:47:08 +0000
Received: by mail-pf1-x441.google.com with SMTP id d2e1a72fcca58-74b54af901bso3073668b3a.2
        for <linux-nvme@lists.infradead.org>; Tue, 08 Jul 2025 14:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kerneltoast.com; s=google; t=1752011226; x=1752616026; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=13tR6fzkt2bQ08ugXjACDh19YKyW3sNzP8lou+ZxAAk=;
        b=S/cBA5KBdciP7QHWrjV2kIH6BHuRZQrQDH07GuhxQZZECIAWLBrCHcmolpDyIqRDM0
         FtbDAffwBMx0/umQ9Krs5eVp+D49ryr75B6Azpp4EdC2kVJDmfMu64It66lBdEv8pzw8
         kWj5XFDI2PXsJr5v/lEO1qTgs9ifwhOvtfLb0jadxfB4sj5GCItMM+NK9Y40ilUBsPOC
         W18Qta576fUfQW64+fPAn8ukvx44RWf/7ZV1tGijmkvy1+o4RBNV0FTvLflclLcYrBpu
         vRTwPbuMpjpOwZnRZ0oH45cTZKBn9FPjY3n3z0C7aQIWMQNwKAd7BZ7fmregIr9CV409
         wniw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752011226; x=1752616026;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=13tR6fzkt2bQ08ugXjACDh19YKyW3sNzP8lou+ZxAAk=;
        b=W9/74kGMOKL/nmoVT9ym08PQ2ZRkwuO+hP7ipY3SEnlmv0iV4HWyKkQdEgxAaJtAkr
         LtRGNgQVYiQf7myHuzugc7lh+hD3x+OtaLcJmT46+BJ08jofscThwFE5rRNVv81Dmv8k
         5uZPBlQIq89TOvL+KRVGPwS7OEYNaaZFTA1NqoNArCxU3wLn4AElufOmQYpvYeHUykhW
         rgGqUf/1bazpPFTUFi8jiA4GxTliwYOGtyiTYoXqVzc0Jv9G0yHbsnm4SzM5Fzfz9gvB
         JBvcehoU97bP7wEfAeHgCtjXzuE/Ze5x38U2WAAKhGIbLDJ9EbM3IUDBr+K/bhQtcnqJ
         qGiA==
X-Forwarded-Encrypted: i=1; AJvYcCU5WcUhrvTEhGt2Y7RGWI6/5h9ZsSnfYwEfz5yZGDsmYbZO0BMsq4Mw839Pi1vicafVk+pNYB2iD20N@lists.infradead.org
X-Gm-Message-State: AOJu0YyTxixj8NFDChPfe91XlOnPz88rOSf9bXNTynaUcvpUdxfRAHMp
	cioqHJUyXU/nUOpxacirmUlpdLZg72r7DgV9EMJTeU4AYZ0N2Cpnacn9fdM20jpCqmwvdSjiYER
	2+vHsGivtR83mzQ==
X-Gm-Gg: ASbGncuo1w/Or0kiObJLpywb6fsUP5M+h3gEfx5sB6T54a/eEGOAHNbmN7pRbz4DEst
	fHmWbAyjC7L4xc3CgmX4k92S0Lr463MC8DSjh26cy4pHkaVSMQ/tsF+1NtWqIlYJ1Cc0Ho5dlbA
	6PqkqVCtNsxQ7ZCNQ/uX+W61NKyLZbFvnRkBU7yeGtLBkXAse09RXyjHd6BEAsn7ZFkMvFquOWR
	Ko/NbaHbzwnJA7JAyykyr2tarA3nA9xNM9DND21bQ5F/bgeeafHN4J2SlbsTi9C77S0WPjao8fP
	FQwKxlbpub15ebo6kZOHCSZ8PdMrr6+R9HRJgWPI0FuTeRMTj3HEp9cE7KmOLPlH
X-Google-Smtp-Source: AGHT+IHwOCg52U3b95dIpK9iZs0O6N3hZ4b0tVdV9D3VixsumfIvhEFDrERlIPnFDdaIS9MRhpJJJg==
X-Received: by 2002:a05:6a00:1795:b0:742:3fb4:f992 with SMTP id d2e1a72fcca58-74ea64572dcmr257168b3a.10.1752011226208;
        Tue, 08 Jul 2025 14:47:06 -0700 (PDT)
Received: from sultan-box ([142.147.89.207])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce359df4bsm13146245b3a.21.2025.07.08.14.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 14:47:05 -0700 (PDT)
Date: Tue, 8 Jul 2025 14:47:02 -0700
From: Sultan Alsawaf <sultan@kerneltoast.com>
To: stuart hayes <stuart.w.hayes@gmail.com>,
	David Jeffery <djeffery@redhat.com>
Cc: Jeremy Allison <jra@samba.org>, Christoph Hellwig <hch@lst.de>,
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
	Jan Kiszka <jan.kiszka@siemens.com>,
	Bert Karwatzki <spasswolf@web.de>
Subject: Re: [PATCH v10 0/5] shut down devices asynchronously
Message-ID: <aG2R1lyniZxhYiSJ@sultan-box>
References: <20250625201853.84062-1-stuart.w.hayes@gmail.com>
 <20250703114656.GE17686@lst.de>
 <aGaklKejxefXTQB4@jeremy-HP-Z840-Workstation>
 <CA+-xHTFC6KTs6D8EdvmVe=buqw9oN5P7GJ-WWvam6M3SzeZF4g@mail.gmail.com>
 <aGgAuje4tpIOveFc@sultan-box>
 <CA+-xHTFNRwbxH=zNMM4kasB=kUAne0b6cxPM+sq5FyM32k8peg@mail.gmail.com>
 <fd941519-6f71-4286-9517-2dc861ee99a5@gmail.com>
 <aGxfoqccqot9t9SB@sultan-box>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aGxfoqccqot9t9SB@sultan-box>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250708_144707_114901_FC81B2E2 
X-CRM114-Status: GOOD (  54.73  )
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

On Mon, Jul 07, 2025 at 05:00:34PM -0700, Sultan Alsawaf wrote:
> On Mon, Jul 07, 2025 at 03:49:44PM -0500, stuart hayes wrote:
> > On 7/7/2025 10:34 AM, David Jeffery wrote:
> > > On Fri, Jul 4, 2025 at 12:26 PM Sultan Alsawaf <sultan@kerneltoast.com> wrote:
> > > > 
> > > > On Fri, Jul 04, 2025 at 09:45:44AM -0400, David Jeffery wrote:
> > > > > On Thu, Jul 3, 2025 at 12:13 PM Jeremy Allison <jra@samba.org> wrote:
> > > > > > 
> > > > > > On Thu, Jul 03, 2025 at 01:46:56PM +0200, Christoph Hellwig wrote:
> > > > > > > On Wed, Jun 25, 2025 at 03:18:48PM -0500, Stuart Hayes wrote:
> > > > > > > > Address resource and timing issues when spawning a unique async thread
> > > > > > > > for every device during shutdown:
> > > > > > > >    * Make the asynchronous threads able to shut down multiple devices,
> > > > > > > >      instead of spawning a unique thread for every device.
> > > > > > > >    * Modify core kernel async code with a custom wake function so it
> > > > > > > >      doesn't wake up threads waiting to synchronize every time the cookie
> > > > > > > >      changes
> > > > > > > 
> > > > > > > Given all these thread spawning issues, why can't we just go back
> > > > > > > to the approach that kicks off shutdown asynchronously and then waits
> > > > > > > for it without spawning all these threads?
> > > > > > 
> > > > > > It isn't just an nvme issue. Red Hat found the same issue
> > > > > > with SCSI devices.
> > > > > > 
> > > > > > My colleague Sultan Alsawaf posted a simpler fix for the
> > > > > > earlier patch here:
> > > > > > 
> > > > > > https://lists.infradead.org/pipermail/linux-nvme/2025-January/053666.html
> > > > > > 
> > > > > > Maybe this could be explored.
> > > > > > 
> > > > > 
> > > > > Unfortunately, this approach looks flawed. If I am reading it right,
> > > > > it assumes async shutdown devices do not have dependencies on sync
> > > > > shutdown devices.
> > > > 
> > > > It does not make any such assumption. Dependency on a sync device is handled
> > > > through a combination of queue_device_async_shutdown() setting an async device's
> > > > shutdown_after and the synchronous shutdown loop dispatching an "async" shutdown
> > > > for a sync device when it encounters a sync device that has a downstream async
> > > > dependency.
> > > > 
> > > 
> > > Yes, but not what I think fails. This handles a sync parent having an
> > > async child. It does not handle the reverse, a sync child having an
> > > async parent.
> > > 
> > > For example, take a system with 1 pci nvme device. The nvme device
> > > which is flagged for async shutdown can have sync shutdown children as
> > > well as a sync shutdown parent. The patch linked pulls the async
> > > device off the shutdown list into a separate async list, then starts
> > > this lone async device with queue_device_async_shutdown from being on
> > > the async list. The device then is passed to the async subsystem
> > > running shutdown_one_device_async where it will immediately do
> > > shutdown due to a zero value shutdown_after. The patch sets
> > > shutdown_after for its parent, but there is nothing connecting and
> > > ordering the async device to its sync children which will be shutdown
> > > later from the original device_shutdown task.
> > > 
> > > > > Maintaining all the dependencies is the core problem and source of the
> > > > > complexity of the async shutdown patches.
> > > > 
> > > > I am acutely aware. Please take a closer look at my patch.
> > > > 
> > > 
> > > I have, and it still looks incomplete to me.
> > > 
> > > David Jeffery
> > > 
> > 
> > Also, the way it is implemented, it could hang if there isn't enough memory
> > to queue up all of the async device shutdowns before starting the
> > synchronous shutdowns.
> > 
> > When you call async_schedule_domain() and there's not enough memory to
> > allocate an async_entry, the async function will be run immediately. If that
> > happens when queuing up the async shutdowns, it could easily hang if there
> > if there are any dependencies requiring an async device shutdown to have to
> > wait for a synchronous device to shutdown, since none of the synchronous
> > shutdown devices have been scheduled yet.
> 
> Understood. Thank you both for the clarifications.
> 
> Regarding an async device with a sync child: this case strikes me as odd. What
> exactly makes the child device require "synchronous" shutdown? Synchronous
> relative to what, specifically?
> 
> This also makes me question what, exactly, the criteria are for determining that
> a device is safe to shut down "async". I think that all children of an async
> shutdown device should be enrolled into async shutdown to isolate the entire
> async dependency chain. That way, the async shutdown devices don't need to wait
> for synchronous shutdown of unrelated devices. I'm happy to do this in a v3.
> 
> Regarding async_schedule_domain() running synchronously when async_entry
> allocation fails: this is a bothersome constraint of the async helpers. Although
> there is a lot of overlap between the async helpers and the requirements for
> async device shutdown, there are other annoying constraints that make the async
> helpers unfit as-is for async device shutdown (like the arbitrary MAX_WORK
> limit).
> 
> The async helpers also don't do exclusive wakes, which leads to the behavior you
> observed in "[PATCH v10 1/5] kernel/async: streamline cookie synchronization".
> We could use exclusive wakes by isolating async shutdown device dependency
> chains and creating a different async_domain for each chain, which is faster
> than calling TTWU on all async waiters and filtering out the wakeups ad hoc.

Correcting myself here: the custom wake function filters out wakeups _before_
TTWU, so what I said in this paragraph is incorrect and therefore exclusive
wakes aren't necessary or helpful. My apologies.

Sultan

