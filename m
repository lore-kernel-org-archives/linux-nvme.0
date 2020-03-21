Return-Path: <SRS0=c63/=5G=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D057DC43333
	for <linux-nvme@archiver.kernel.org>; Sat, 21 Mar 2020 04:02:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F8BB20658
	for <linux-nvme@archiver.kernel.org>; Sat, 21 Mar 2020 04:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="W1wAnHiX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F8BB20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chelsio.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pFezyDS6mFH9PZX3WzB6kvNLBwhL51Z+cfWodgJdDyI=; b=W1wAnHiXn6K63V
	iLj3lByqRNG5ay6TahkpwCMg/g23/H25abHru0Qkv3M61Ka0ra1L8L7j0ZthH484Ic2osCYX9Y08P
	+CZS1WDEJIJWTrp1zqUYMXcH8E89Og81GU2ndgmv7+Pn6ZjFPk7bsMZKLl4PtrFdfKg/FzvW8xS2g
	BXZ/9mhI9kIXERsJrmFDtGYgw83Is1pCjNFUIR+ifJ+9OO0qt58C6S92t1ud6u97X3l+/+GqpZGq/
	hevZAFmQB9sXWMmszvvgdczOZ83THOWYoFyMshEVd9T5U6Y8JlIRwlobFp6Wy6jlnhSw1/4kVdoHM
	JIJ1L+ycm5P0DrdnuGDQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jFVLM-0008ER-VS; Sat, 21 Mar 2020 04:02:40 +0000
Received: from stargate.chelsio.com ([12.32.117.8])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jFVLJ-0008E2-UW
 for linux-nvme@lists.infradead.org; Sat, 21 Mar 2020 04:02:39 +0000
Received: from localhost (pvp1.blr.asicdesigners.com [10.193.80.26])
 by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id 02L4290v019591;
 Fri, 20 Mar 2020 21:02:10 -0700
Date: Sat, 21 Mar 2020 09:32:09 +0530
From: Krishnamraju Eraparaju <krishna2@chelsio.com>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: broken CRCs at NVMeF target with SIW & NVMe/TCP transports
Message-ID: <20200321040207.GA11659@chelsio.com>
References: <20200316162008.GA7001@chelsio.com> <20200317124533.GB12316@lst.de>
 <OFB2589549.AD31F8B8-ON0025852E.005A969A-0025852E.005A96A3@notes.na.collabserv.com>
 <70b13212-faa6-d634-8beb-55ba39891d7f@grimberg.me>
 <20200317191743.GA22065@chelsio.com>
 <38f79fb7-841a-9faa-e1f8-2de4b9f21118@grimberg.me>
 <20200317203152.GA14946@chelsio.com>
 <3f42f881-0309-b86a-4b70-af23c58960fc@grimberg.me>
 <20200320143544.GA5539@chelsio.com>
 <87bfe03d-baad-1166-14a1-6eba1739fde4@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87bfe03d-baad-1166-14a1-6eba1739fde4@grimberg.me>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200320_210237_996768_A858A538 
X-CRM114-Status: GOOD (  14.02  )
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
Cc: linux-rdma@vger.kernel.org, Potnuri Bharat Teja <bharat@chelsio.com>,
 Nirranjan Kirubaharan <nirranjan@chelsio.com>, linux-nvme@lists.infradead.org,
 Bernard Metzler <BMT@zurich.ibm.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Friday, March 03/20/20, 2020 at 13:49:25 -0700, Sagi Grimberg wrote:
> 
> >>I assume this happens with iSCSI as well? There is nothing special
> >>we are doing with respect to digest.
> >
> >I don't see this issue with iscsi-tcp.
> >
> >May be blk-mq is causing this issue? I assume iscsi-tcp does not have
> >blk_mq support yet upstream to verify with blk_mq enabled.
> >I tried on Ubuntu 19.10(which is based on Linux kernel 5.3), note that
> >RHEL does not support DataDigest.
> >
> >The reason that I'm seeing this issue only with NVMe(tcp/softiwarp) &
> >iSER(softiwarp) is becuase of NVMeF&ISER using blk-mq?
> >
> >Anyhow, I see the content of the page is being updated by upper layers
> >while the tranport driver is computing CRC on that page content and
> >this needs a fix.
> 
> Krishna, do you happen to run with nvme multipath enabled?

Yes Sagi, issue occurs with nvme multipath enabled also..

dmesg at initiator:
[ +10.671996] EXT4-fs (nvme0n1): mounting ext3 file system using the
ext4 subsystem
[  +0.004643] EXT4-fs (nvme0n1): mounted filesystem with ordered data
mode. Opts: (null)
[ +15.955424] block nvme0n1: no usable path - requeuing I/O
[  +0.000142] block nvme0n1: no usable path - requeuing I/O
[  +0.000135] block nvme0n1: no usable path - requeuing I/O
[  +0.000119] block nvme0n1: no usable path - requeuing I/O
[  +0.000108] block nvme0n1: no usable path - requeuing I/O
[  +0.000111] block nvme0n1: no usable path - requeuing I/O
[  +0.000118] block nvme0n1: no usable path - requeuing I/O
[  +0.000158] block nvme0n1: no usable path - requeuing I/O
[  +0.000130] block nvme0n1: no usable path - requeuing I/O
[  +0.000138] block nvme0n1: no usable path - requeuing I/O
[  +0.011754] nvme nvme0: Reconnecting in 10 seconds...
[ +10.261223] nvme_ns_head_make_request: 5 callbacks suppressed
[  +0.000002] block nvme0n1: no usable path - requeuing I/O
[  +0.000240] block nvme0n1: no usable path - requeuing I/O
[  +0.000107] block nvme0n1: no usable path - requeuing I/O
[  +0.000107] block nvme0n1: no usable path - requeuing I/O
[  +0.000107] block nvme0n1: no usable path - requeuing I/O
[  +0.000108] block nvme0n1: no usable path - requeuing I/O
[  +0.000132] block nvme0n1: no usable path - requeuing I/O
[  +0.000010] nvme nvme0: creating 12 I/O queues.
[  +0.000110] block nvme0n1: no usable path - requeuing I/O
[  +0.000232] block nvme0n1: no usable path - requeuing I/O
[  +0.000122] block nvme0n1: no usable path - requeuing I/O
[  +0.008407] nvme nvme0: Successfully reconnected (1 attempt)

dmesg at target:
[Mar21 09:24] nvmet_tcp: queue 3: cmd 38 pdu (6) data digest error: recv
0x21e59730 expected 0x2b88fed0
[  +0.000029] nvmet: ctrl 1 fatal error occurred!
[ +10.280101] nvmet: creating controller 1 for subsystem nvme-ram0 for
NQN nqn.2014-08.org.nvmexpress.chelsio.


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
