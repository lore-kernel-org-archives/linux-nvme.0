Return-Path: <SRS0=MLi/=DB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBFBC4346E
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Sep 2020 05:12:37 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 324072311A
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Sep 2020 05:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GB2CSnj2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gOkyX0xV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 324072311A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=BEhg/l1eJKWTm8dPFvmBebbY0ojVMS59UIN080vOD98=; b=GB2CSnj2ULSjsj9fKH5SaUPxD
	Or/4hKsgWZRzBj+bKFAS6J++6/7iEK7SzGQRjTdMqu6aX/yPGd5eEYxnErSfPl8gBwFAVxxd31R2N
	Oz8lFg42Rphhkfpd9fMkzvT9B42F7tlg+1iiFrhGZ4wObb3aBRzrNdiDpHSCDyrB4bwmS84Rgsca5
	DwDHulR3NqrfG9Hm+b6sU/NIFnWPQ0g6O8xSiWmvmJJzFcKZtUtVp3YBc+gkUjIR2edl43LQul0Hk
	I0V2zRjXOyrFI96vHCYKIGe0opxH5V+KV9TMUAa4+oTbYrCEX/D7F85aV3BPVGjXGLpHmMDuFphe8
	BmPzZTsuA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kLJYY-00040X-6u; Thu, 24 Sep 2020 05:12:34 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kLJYW-00040N-Gt
 for linux-nvme@merlin.infradead.org; Thu, 24 Sep 2020 05:12:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=FhHh+G15H3EFXAXqyT4rHyPGZXjFJazB5mfTPgGLTXg=; b=gOkyX0xVl//10MCLCUjNj9NJow
 FYlHAH2gLvbMq/HTRIqxQix7UVpfIr0h3xDky9x242ug0t9hKtxKeciWhDTAvAkyphYOPRgnC3KwZ
 +7E8sWKvsUntiEoNNkMzrQUuW0u29G0OEXkvHJKd4/NUWoYmoLqonv2v+xFy8t6uiqXxjJa07ui/v
 DAxnXtS0t5amXRgGHicMsfrmkmD5dtRTxPl+pEz+cUZsUIFkKkb4Q9iyDKTocF07T93ZiBLUlYe8r
 i7aU/s5cr1WF3SGPSYT9blXStGbITQcyO7dMpMAITBC/a0UOYOJ9MufzMQGmPR1VQPyNwJ7LxdU41
 22vzohNg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1kLJYU-0004Ke-Re; Thu, 24 Sep 2020 05:12:30 +0000
Date: Thu, 24 Sep 2020 06:12:30 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: kernel panics when hot removing U.2 nvme disk
Message-ID: <20200924051230.GA16433@infradead.org>
References: <BYAPR10MB24561C62C45813B7092E346BCB3F0@BYAPR10MB2456.namprd10.prod.outlook.com>
 <20200919014401.GE4030837@dhcp-10-100-145-180.wdl.wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200919014401.GE4030837@dhcp-10-100-145-180.wdl.wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: Meng Wang <meng@hcdatainc.com>, linux-ext4@vger.kernel.org,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Sep 18, 2020 at 06:44:01PM -0700, Keith Busch wrote:
> On Fri, Sep 18, 2020 at 11:47:27PM +0000, Meng Wang wrote:
> > Hi,
> > We found kernel panics today when doing test on hot remove U.2 nvme
> > disk. After hot remove the nvme disk (formatted as ext4), the system
> > freezes and all services stuck. Lot of kernel message flushed the
> > syslog, including the CPU soft lockup, ext4 NULL point er dereferece
> > and ib nic transmission timeout. The kernel panics and configuration
> > are shown below. The used kernel is 5.4.0-050400-generic and OS is
> > Ubuntu 16.04. Not sure whether it's a known bug or configuration
> > error. Any advise are welcome.
> 
> [cc'ing ext4 mailing list]
> 
> The NULL dereference occured before the soft lockup, so I'm guessing the
> Oops'ed process is holding the same lock the removal task wants.
> 
> Your kernel is a bit older, so it may be worth verifying if your
> observation still occurs on the current stable or current mainline, but
> the ext4 developers may have a better idea as this doesn't at least
> initially appear specific to nvme.

The problem is the crazy __invalidate_device stuff that calls into
file system eviction from all kinds of super critical block paths.
While I haven't debugged the root cause this kind of thing just causes
problems without really helping anyone.  I have a half-finished series
that kills this crap and instead allows the file system (or other
block device user) to pass shutdown and resize callbacks when the
exclusively open a block device.  That way the file system driver
can just mark the file system shutdown to prevent any further damage
without all this mess.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
