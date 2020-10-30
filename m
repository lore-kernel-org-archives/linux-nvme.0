Return-Path: <SRS0=Q5cb=EF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2681C00A89
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Oct 2020 16:33:30 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D3042075E
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Oct 2020 16:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="j4ySbLeq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="W4nMhCgP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D3042075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=VQsH4qQlyVTKQpNmldA4vay1UCQq9GVFLCfqjy1bkow=; b=j4ySbLeqMt3ay+sgJvEo6P07C
	j/2+cGUvpB/O3RwF/3w78hb/RryHNXDIJoIEVydrnmbm600ff9SXMk41Qfh6SWVBvgcL383K1I+Y3
	syjfDAqQ+P4jjKzKEbrAZPQ7N0Eu5rzqmvL9Svc15o5pimFNR3Td+BseaXIMtWnryBaXa8JdQ+IoN
	6EX0Rc8OKOtTcjhLddwgr/fqiokaA1cy2KEm/dVwJmNKWDFKAKj/3gkpgAkQBAhI+jLfCPPSvO2EY
	erxn68AwcsIF7DMcfItVZ0oicdfRPaTqiEaQ0mKuHHD3bH6TMaY2OBmm5VR0V8fWnzji9o2/JOHqf
	qmXZAUijQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kYXKu-0002ss-1b; Fri, 30 Oct 2020 16:33:08 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kYWJn-0006Mm-V0
 for linux-nvme@lists.infradead.org; Fri, 30 Oct 2020 15:27:58 +0000
Received: from dhcp-10-100-145-180.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2AACD20725;
 Fri, 30 Oct 2020 15:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604071671;
 bh=DYJjFx6afEa9WD1FD9nTC1PBL+6Yk7HG6i0fCoXkpeY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=W4nMhCgPKjARPEuOBFveWZdSLK6UOe0YElqI2E8Wy8WHXD5C8FeCjtOa1La3ys2ng
 hl55POLeotsSvxiFTkllX6/5xyRquxwoinxa9+ClBtwSNtt7yqNCwhRtV7pL2QqlDy
 klNbXLYKNywgij9YZrFGW88egBw8ZDry+4E4HMqY=
Date: Fri, 30 Oct 2020 08:27:48 -0700
From: Keith Busch <kbusch@kernel.org>
To: "B.L. Jones" <brandon.gustav@googlemail.com>
Subject: Re: NVME controller issue prevents boot on Kernel versions >= 5.8 on
 MacBook 7,1 (MacBook Air 2015)
Message-ID: <20201030152748.GA1946804@dhcp-10-100-145-180.wdc.com>
References: <CA+ykBt3kGCOdupWSNNiCxQLduq8Bs_t4YN8CsUWYOOGEk884vw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+ykBt3kGCOdupWSNNiCxQLduq8Bs_t4YN8CsUWYOOGEk884vw@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201030_112756_324521_0EB66C49 
X-CRM114-Status: GOOD (  21.28  )
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
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Oct 29, 2020 at 09:31:12PM -0700, B.L. Jones wrote:
> Hello all,
> 
> This is my first time emailing any kernel mail list so I will do my
> best to furnish any information you may need regarding this.
> 
> To begin, I reported a boot issue against the kernel on the
> Fedora/RedHat Bugzilla last month here:
> https://bugzilla.redhat.com/show_bug.cgi?id=1878596
> 
> Essentially, booting any kernel greater than version 5.8 on my 2015
> MacBook Air would cause a soft freeze, with an error stating:
> 
> [   34.890739] f-air kernel: nvme nvme0: controller is down; will reset: CSTS=0x3, PCI_STATUS=0x10
> [   34.917820] f-air kernel: nvme nvme0: detected Apple NVMe controller, set queue depth=2 to work around controller resets
> 
> Another individual in the bugzilla thread took a look at the error
> logs and identified a potential commit that may have caused the issue:
> 
> commit 54b2fcee1db041a83b52b51752dade6090cf952f
> Author: Keith Busch <kbusch@kernel.org>
> Date:   Mon Apr 27 11:54:46 2020 -0700
> 
>     nvme-pci: remove last_sq_tail
> 
>     The nvme driver does not have enough tags to wrap the queue, and blk-mq
>     will no longer call commit_rqs() when there are no new submissions to
>     notify.
> 
>     Signed-off-by: Keith Busch <kbusch@kernel.org>

Thanks for the notice. I'll see if I can fix this, but I think a revert
may be necessary.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
