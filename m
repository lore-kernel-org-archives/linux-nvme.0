Return-Path: <SRS0=f1uU=ZY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D9FC432C0
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Dec 2019 18:07:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDA4920705
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Dec 2019 18:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MiGLAmUL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wvIUukHv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDA4920705
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ygrNGAqq7UjyEYr8f3j/v9fgKXdBQ+gRfXFj0oz2H84=; b=MiGLAmUL1gn2G/
	uWGZb0X9ivjsnZp2vMMM0NPyOBEqeFc3lFWjz1eDGtkbyHCHz5NnwNN+1Bz/VorNwNBSI7F9tJIzM
	65AAM5NAEhtJ4Bxz/6pBQSoUnarr6UlogRZi+0iV8fDlS+031Uzn3uRn0Cc4Z8GWsCf97PbhoK99t
	Y7jO/ElVxZVrS+h6XCKY1bxo4pzYjQTZo07JYBFPPU90Vs8v5hy3rj0EYEiNg91M4ALzm7sWuodgm
	4rF2TCvNrv0R+PJNd0qMOcJUSRs/4mgcmPTFhUEBT5pW9al/vvlbn2GC86E3H04G2PjQBQBzSIbOg
	Ltm7wnR3LptBkgIk1NbA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ibq6G-0007pc-SB; Mon, 02 Dec 2019 18:07:08 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ibq6E-0007p4-LB
 for linux-nvme@lists.infradead.org; Mon, 02 Dec 2019 18:07:07 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E9BA820665;
 Mon,  2 Dec 2019 18:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1575310026;
 bh=bUTFY7ec2C0NnhCMNEf4o1VNwUPetyVxCjLJigUgY60=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=wvIUukHvfS+NzqDZ47/+apxBMIo6rKVTH+MIwGvjIDQyin4rLUJ4Y6nF6n3KMpg5R
 fSGbsDX3+FKHeSSBNPTU1JgOsXAVijtGHhLmEXFaMsqjJNzirMgMZl2/2/3OS/Uql0
 04xs8ML9x2X+rePImdA+SHT+f/9aJh0UxkV7f6+g=
Date: Tue, 3 Dec 2019 03:06:59 +0900
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 0/4] nvme: Threaded interrupt handling improvements
Message-ID: <20191202180659.GB21650@redsun51.ssa.fujisawa.hgst.com>
References: <20191127175824.1929-1-kbusch@kernel.org>
 <20191129094640.6fq6wcxmfi4fwnlw@linutronix.de>
 <20191129162719.GA47681@C02WT3WMHTD6.lpcnextlight.net>
 <20191129170545.axnykbrabigzcghs@linutronix.de>
 <20191130170222.GA5273@redsun51.ssa.fujisawa.hgst.com>
 <20191202170538.juq745vddzsouufb@linutronix.de>
 <20191202171239.GA8547@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191202171239.GA8547@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191202_100706_717452_E2E82C73 
X-CRM114-Status: GOOD (  12.83  )
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
Cc: sagi@grimberg.me, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-nvme@lists.infradead.org, ming.lei@redhat.com, helgaas@kernel.org,
 tglx@linutronix.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Dec 02, 2019 at 06:12:39PM +0100, Christoph Hellwig wrote:
> That's why I had the previous idea of one irq thread per cpu that
> is assigned to the irq.  We'd have to encode a relative index into
> the hardirq handler return value which we get from bits encoded in
> the NVMe command ID, but that should be doable.  At that point we
> shouldn't need the cond_resched.  I can try to hack that up, but
> I'm not an expert on the irq thread code.

I'm curious how you intend to implement this. We can't have two threads
operating on the same CQ at the same time since they have to reap the
CQ sequentially, so the threads can't selectively choose which entries it
handles in a queue with mixed encoded CPUs.

Perhaps we can have just one completion thread call
smp_call_function_single_async() with the encoded CPU?

But sadly, I recall we've observed broken controllers break when a
command id exceeds the queue-depth, and encoding CPUs in the command id
would do that. Hardware ruins our purity...

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
