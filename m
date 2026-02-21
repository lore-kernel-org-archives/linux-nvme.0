Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 101D6C61DFC
	for <linux-nvme@archiver.kernel.org>; Sat, 21 Feb 2026 17:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XEDdppogwEP+4ij8Z1PfmxwFwT2NC0q+nxUKdPU0S8g=; b=dxYrgsOCZdFojRfjr6l1Cn2rGT
	n70iKas6imr+YsKphpf+G40SJNHLjQQykBO6wMT9hoBdlhMkOoO7cZiji9CvWSnCqBE1XcnojBdJs
	tAlD6Z2YAUpLlvknt/eGqmcH82P7nX1Ru0764NHuyN5nq2uIE65cZzvGrNDzzo3op/JPOSdaECZhn
	Symcb50VkDM0PoJ8yi4EnvVC4pkD8caCjRB3YvcViagDbdikxr7Ypiu8W3Z4y7nvrvyoaChr9hp6g
	F1Nr4ivbSKhuwh3xPIDP4l0VhmY7Em0HQsh3Dy7517EEAmLjcvjYbSbPuRSb1e2ahIX2Nwb3lHc/Z
	MUd+FDZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtr5I-0000000GDYx-0Mgr;
	Sat, 21 Feb 2026 17:48:04 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtr5F-0000000GDYa-0bJf
	for linux-nvme@lists.infradead.org;
	Sat, 21 Feb 2026 17:48:02 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 0B91840A1F;
	Sat, 21 Feb 2026 17:48:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 937F9C4CEF7;
	Sat, 21 Feb 2026 17:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771696079;
	bh=4kSvkddoRLlf4Sl9dPi1cbg858c6h700l6Keq7+pJZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lyhNHW29F+qYJ6yM4kxO0Dtu4K2ATWMw7JnFkeMoP5Ic1t8PdhhuJtV2Y+Dus2060
	 vVmaq/YSoyLzz1WB38ozkHHuGhgZenl9IHa9LEwYWQaM8AjPv8oBSqanAScb+MadEH
	 UP7DWxkUFdASJ5aeyyIhCuFDE2Vgaz3g8TNlEOAGe1yv+rcsnYsGNE6Cl5MVdjPTyG
	 z2JmOUT4x7cES1clgR961FQB1ci3CjDrAZuXamjZVVxbniVBeG+2xbTa2ExhLSej44
	 P/tGWYFVGqnOePLY4YQcpNoDeK6e1ijxCDOG/fClW398hmoqMslbAWkM+S2hpgGJPS
	 0nkyKP0bkJj/A==
Date: Sat, 21 Feb 2026 12:47:58 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: John Garry <john.g.garry@oracle.com>, lsf-pc@lists.linux-foundation.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Native SCSI multipath support
Message-ID: <aZnvzhCrt-2kgyfb@kernel.org>
References: <69349b51-72c2-47f9-948f-f89843af62e4@oracle.com>
 <b598c5c9-6732-4661-85b2-7ab10a0830d4@suse.de>
 <dbf5fbdd-8894-40b7-b574-0c6385995ec2@oracle.com>
 <a5a0aa42-33e4-401f-ad94-8104cff9368c@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5a0aa42-33e4-401f-ad94-8104cff9368c@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260221_094801_226575_522D43CB 
X-CRM114-Status: GOOD (  32.20  )
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

On Mon, Feb 16, 2026 at 05:32:04PM +0100, Hannes Reinecke wrote:
> On 2/14/26 10:42, John Garry wrote:
> > On 13/02/2026 17:21, Hannes Reinecke wrote:
> > > > At ALPSS 25 I presented a proposal for Native SCSI multipath
> > > > support. Let's discuss this topic at LSFMM.
> > > > 
> > > > The idea for this is that SCSI could natively support multipath,
> > > > like how NVMe host driver does today. It is intended as an
> > > > alternative to dm- multipath support.
> > > > 
> > > > I have been working on the implementation and I plan to post
> > > > patches in the next cycle. I am looking at a 3-stage approach:
> > > > a. create a driver-agnostic multipath library, very heavily
> > > > based on NVMe host multipath support.
> > > > The library would support features such as path management, path
> > > > selection/iopolicy, failover recovery, PR, delayed removal,
> > > > gendisk management etc.
> > > > b. switch NVMe over to use this library
> > > > c. add native SCSI multipath support based on this common library
> > > > 
> > > Go for it, John!
> > > 
> > > I'd be very interested in that.
> > 
> > cheers, in the meantime, I have some comments:
> > 
> > - I need to test PRs for both NVMe and SCSI, any advice on that would be
> > good. I don't think that blktests covers it. I did see Christoph mention
> > a testsuite at: https://lore.kernel.org/linux-nvme/1438672271-11309-1-
> > git-send-email-hch@lst.de/ - I can check that.
> > 
> Well, you might have seen the discussion on the device-mapper list, where
> stefanha is implementing generic PRs for dm-multipathing.
> Or rather, trying to. We might need to revisit that and see what we
> could be doing on the SCSI side.
> Maybe we should be having a session about PRs at LSF?
> 
> > - I am still not sure on whether we require a multipath version of sg.
> > We can still have per-path sg. NVMe does have a multipath nvme-generic
> > dev, but that just handles IOCTLs/uring cmd, and nothing like sg read/
> > write fops
> > 
> 'sg' is primarily for testing 'raw' SCSI commands. (And dastardly complex to
> boot). I really would keep it in it's current form, and not
> try to mimick something with SCSI multipathing.
> 
> > - I have not tried to detangle ALUA support from SCSI DH, so no ALUA
> > support yet
> > 
> Ouch. But that is the key point of the implementation; ALUA provides
> _all_ the information required for multipathing, so how can you _not_
> have support for it?

Exactly: no ALUA support makes, whatever this is, completely useless.

