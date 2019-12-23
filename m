Return-Path: <SRS0=n1R8=2N=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2EAC2D0C0
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Dec 2019 14:54:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D31420715
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Dec 2019 14:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LQRvFOmS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZHXsE+nW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D31420715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=caTSf0ERR9h5FOl07YQUKDCHdakrXGCcDXxuPlt9Wos=; b=LQRvFOmSXgiPRc
	MlHrXKbVaMSDde04NCRW/z9U4qftVonWhBJsbb0TTaX2ZpgGQ2vnyM8TFSlev3zez/xNRkOpn/XGb
	CiGoAvXwhpcmkttQY0/HzK127tbHR+uug1hSf0jKxVWvAf378gU+sl1X8qTdL/64n8/htpJnbPaLH
	vGN75KOoLWjwsM7OAXVlXBLMQHF5UDBl4sZ6Ok+iXxrnCl4r2AD22fklnBNdofdI9Q20OtoDBb79Q
	GTEXdIMWUPtiX2v0Xjq3s9EpF4tmCcQGkVl5TLvutG7j7GwT5CfKC+mL7SYEx7JskVZEx798gvumw
	VJ7A51rZHmQdAjgwElrQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ijP6S-0003b8-4Z; Mon, 23 Dec 2019 14:54:36 +0000
Received: from us-smtp-2.mimecast.com ([207.211.31.81]
 helo=us-smtp-delivery-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ijP6Q-0003ah-1L
 for linux-nvme@lists.infradead.org; Mon, 23 Dec 2019 14:54:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577112871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hMbiUif5UbxWkhO2vVafLHlX5jCtntrimEnOTTgtchs=;
 b=ZHXsE+nWEw+spK9tJSjJC9PlWdPX3MBLHlopr4jwcP+qEALIH6LsFJ0kXShloqPgXWDt4k
 S2IpbnyhxjkXPkQv9/qhfUeC7a5Fxi5CzAvuk7qEy/SDVVy0uLlP4Az+0gvhAAIABzfClz
 X89OLk9gNjZ4bB0rUySr+0hmF7PJZSY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-178-kt9gj-uCNM2G8rusGGwsSQ-1; Mon, 23 Dec 2019 09:52:30 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A0C4801E66;
 Mon, 23 Dec 2019 14:52:29 +0000 (UTC)
Received: from dhcp-4-209.tlv.redhat.com (dhcp-4-209.tlv.redhat.com
 [10.35.4.209])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9ACA11A7E3;
 Mon, 23 Dec 2019 14:52:25 +0000 (UTC)
Message-ID: <6facb151631957bb1c025f0c99ba9774bb909fa1.camel@redhat.com>
Subject: Re: A kernel warning when entering suspend
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ming Lei <ming.lei@redhat.com>
Date: Mon, 23 Dec 2019 16:52:24 +0200
In-Reply-To: <alpine.DEB.2.21.1904041312480.1685@nanos.tec.linutronix.de>
References: <AM6PR06MB50637026B0E7D87341BF47A3A1500@AM6PR06MB5063.eurprd06.prod.outlook.com>
 <20190404085524.GA24927@ming.t460p>
 <alpine.DEB.2.21.1904041312480.1685@nanos.tec.linutronix.de>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: kt9gj-uCNM2G8rusGGwsSQ-1
X-Mimecast-Spam-Score: 0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191223_065434_156103_DDE124D0 
X-CRM114-Status: GOOD (  18.49  )
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
Cc: fin4478 fin4478 <fin4478@hotmail.com>,
 "keith.busch@intel.com" <keith.busch@intel.com>, "axboe@fb.com" <axboe@fb.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, 2019-04-04 at 13:14 +0200, Thomas Gleixner wrote:
> On Thu, 4 Apr 2019, Ming Lei wrote:
> 
> > On Thu, Apr 04, 2019 at 08:23:59AM +0000, fin4478 fin4478 wrote:
> > > Hi,
> > > 
> > > I do not use suspend/resume but noticed this kernel warning when testing it. This warning is present in earlier kernels too. My system works fine after resume.
> > > If there is a patch to fix this, I can test it.
> > > 
> > > [   53.403033] PM: suspend entry (deep)
> > > [   53.403034] PM: Syncing filesystems ... done.
> > > [   53.404775] Freezing user space processes ... (elapsed 0.001 seconds) done.
> > > [   53.405972] OOM killer disabled.
> > > [   53.405973] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
> > > [   53.407036] printk: Suspending console(s) (use no_console_suspend to debug)
> > > [   53.407491] ACPI Debug:  "RRIO"
> > > [   53.407505] serial 00:03: disabled
> > > [   53.407560] r8169 0000:07:00.0 enp7s0: Link is Down
> > > [   53.415042] sd 5:0:0:0: [sda] Synchronizing SCSI cache
> > > [   53.415065] sd 5:0:0:0: [sda] Stopping disk
> > > [   53.428943] WARNING: CPU: 10 PID: 3127 at kernel/irq/chip.c:210 irq_startup+0xd6/0xe0
> > 
> > Looks the 'WARN_ON_ONCE(force)' in irq_startup() is a bit too strict.
> 
> Why?
> 
> > irq_build_affinity_masks() doesn't guarantee that each IRQ's affinity
> > can include at least one online CPU.
> 
> Then why is it tried to start up an interrupt which has no online cpu in
> the mask? I'm missing context obviously.

Hi!

The problem here is that recently an optimization was added to avoid taking a spinlock in
the interrupt handler in expense of enable_irq/disable_irq around the place where the race can happen.

The patch is https://patchwork.kernel.org/patch/10708055/

And the problem here is that indeed if nvme driver allocates more interrupts that number
of currently online cpus (which happens if number of possible cpus is larger that number of cpus
the system was booted with), then some of the nvme queues exist but effectively disabled (till relevant cpus
are plugged which can happen any time).

I think that this is a valid use case, and since other than that warning, enable_irq in this case doesn't
really enable it, maybe the warning should be removed?

We have a bug report about this issue, and I was told that the warning breaks up some QE scripts.
https://bugzilla.redhat.com/show_bug.cgi?id=1779247


Best regards,
	Maxim Levitsky


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
