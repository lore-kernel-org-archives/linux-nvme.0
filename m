Return-Path: <SRS0=tokg=44=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2105AC10DCE
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Mar 2020 01:29:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBDED205ED
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Mar 2020 01:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QM3zc4BC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJUXzjQb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBDED205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/zF5VsSeL6czFGkWnwvPoXqp6CeG8p23S0f4WVMWAaI=; b=QM3zc4BCxw97cv
	a/qr4ovSyL5DjTV5boAqSkv9VfyJqFVxKA0oRXgMOc5qTuoptdR0JeURXboPDT+oyO1Nyc2Ht2wQe
	ekqqQmfxsfvmdy1/MNKs1EPl+0AUHxH7riph32WfkrhW3ukvm4Nfr2qsdnPC3CkbOQ5C6i3zpO9l7
	FUQ8IkpLUjtXXqzOkNZ4u9uoPJb+/A3cjMnCgtcrIRC9/VKdPZAnynTOGIGZaaxE5hh2onSUCLi6h
	fWK8JfHHoGTSg/GiQXw6rBFNXMov9AQDc5fe8Km1z2mEK7FdRcPi7GKo4vfcDSt+4LbxCyBEt9cj9
	cqPe1srokIG6CSQukmHQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jBqBw-0008Hy-QA; Wed, 11 Mar 2020 01:29:48 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jBqBu-0008Hc-CW
 for linux-nvme@lists.infradead.org; Wed, 11 Mar 2020 01:29:47 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B8BC2205ED;
 Wed, 11 Mar 2020 01:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1583890186;
 bh=yfmshSjreKPUXRdit82xLS1XRCNjik2fguRiQIdONzI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZJUXzjQbF2gr64CWMrIXCr5Qu7JL2xpwIYv/pvq0qeFGhg7V4Nn60PLe+VwN4lyo2
 tAHWcMMS56qTBHPmYhrFzs31HLyxWrdfU8kv0bUADw5cebttEvPfoa3kFbW0gqgtCg
 JSBbqESPWSllynE088z8it49Elbqmd1U7zeJlQiE=
Date: Tue, 10 Mar 2020 18:29:43 -0700
From: Keith Busch <kbusch@kernel.org>
To: Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
Subject: Re: I/O performance with block sizes > 128k
Message-ID: <20200311012943.GA836703@dhcp-10-100-145-180.wdl.wdc.com>
References: <321f0a4b-8a75-8cae-2d77-34ad712225d3@oracle.com>
 <20200310170818.GA28008@infradead.org>
 <20200310194421.GB17237@redsun51.ssa.fujisawa.hgst.com>
 <3971720d-d05d-9a08-cb5e-6396df70a8b2@oracle.com>
 <20200311012701.GF604509@dhcp-10-100-145-180.wdl.wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200311012701.GF604509@dhcp-10-100-145-180.wdl.wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200310_182946_448119_5FDF42EF 
X-CRM114-Status: GOOD (  10.17  )
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
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Mar 10, 2020 at 06:27:01PM -0700, Keith Busch wrote:
> On Tue, Mar 10, 2020 at 05:52:02PM -0700, Bijan Mottahedeh wrote:
> > I had to kill the fio jobs and got a bunch of this output:
> > 
> > Jobs: 103 (f=103): [r(4),_(1),r(12),_(1),r(2),_(1),r(10),_(1),r(2),_(1),r(1),_(1),r(7),_(1),r(1),_(2),r(16),_(1),r(5),_(1),r(6),_(2),r(2),_(1),r(2),_(1),r(2),_(1),r(3),_(1),r(9),_(1),r(4),_(2),r(5),_(1),r(3),_(1),r(1),_(1),r(4),_(2),r(2)][0fio:
> > job 'fiotest' (state=5) hasn't exited in 300 seconds, it appears to be
> > stuck. Doing forceful exit of this job.
> > 
> > Hopefully Jens can comment what this means.
> 
> What kernel are you using? A bug observed with multiple threads polling
> the same queue was just fixed in the 5.6-rc5 release


Oops, I suppose you already know that ... you fixed it! :)

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
