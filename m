Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECE78C6FD20
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Mar 2023 19:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WAO/5GwchlA2AJz18rywbpJFlPrta6tK6eiphzZK2CU=; b=mLoJOOPQtZcTg+niTSbzGGSzOu
	OFNKGKxGjJ4LtrtB0/lJNM9vjHWJR/zrsttgPNk1eEc+VqvWKOFsBSzawkbx7Y7wY7w79cYSsIBx9
	aiB+PE7w0dtv+oOrn4w6gnoH77bjTg0SloV1d9zPOxnxrmB/RCrXas9LBbKSWvXIW1vSt9hwRX3QT
	rJm3HSizMCaVArcZEx8BsJku1OfhQ78MMv7JgbFMNJEBylRiZ6kO4zAFZKo0UYJ7ljq7SkdPbte9Q
	MLufQAqkY3dKveTX/E2uxHxMPL7+i51+AoHYqH6wnVWky9ZVNSjeiAjyMuMKbH8Vmcn5TP12vwZb8
	RxRVJgQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pfnBi-005Qun-0z;
	Fri, 24 Mar 2023 19:34:58 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pfnBg-005Qu5-0P
	for linux-nvme@lists.infradead.org;
	Fri, 24 Mar 2023 19:34:57 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id CBE6B62C87;
	Fri, 24 Mar 2023 19:34:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01481C433EF;
	Fri, 24 Mar 2023 19:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1679686494;
	bh=lTSPSgCNooTj6meceVlAqcpQDkNCQVSzWHhirTdjgjg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EKo0iCmsZc2Hjcrt6sF8tvIZ0k+pQRWm3PWZ88ZUdX/QKmX2Ix5ZZEwgLlNXn+XwN
	 S8spbAoxnZcyPyqkWufIDqY9qjr1byqK1vhKmhZjvcfpHoUzTNNZMhls7FbaGVMSB5
	 eyDmSmFz+h4ep9+Qj8WyLYoq8KvCqF/PnIYzU4XbSr4Rodxh66G4QKAG5b7RQq6F4I
	 TwPo2VHulWoew8WcmtShMt4TpvikrCJm18itu8eMrJAtvjjKU4DjSmtu4LcaX4wYXp
	 fLqO+IMqXhaPDC0x2lKaNFYfdqiSEKIR0Gmf5lm2Y58EeGa/xJGZFPDdPGRLcvBUtK
	 Up+1YjDg4LIkA==
Date: Fri, 24 Mar 2023 13:34:51 -0600
From: Keith Busch <kbusch@kernel.org>
To: Alexander Shumakovitch <shurik@jhu.edu>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: Read speed for a PCIe NVMe SSD is ridiculously slow on a
 multi-socket machine.
Message-ID: <ZB37W2dfqR4sgQWt@kbusch-mbp.dhcp.thefacebook.com>
References: <ZB1JgJ2DxyTMVUHB@hornet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZB1JgJ2DxyTMVUHB@hornet>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230324_123456_229609_36E6082F 
X-CRM114-Status: GOOD (  10.70  )
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

On Fri, Mar 24, 2023 at 06:56:03AM +0000, Alexander Shumakovitch wrote:
> physical CPU hdparm or dd is run on:
>       
>     # hdparm -t /dev/nvme0n1 
>     
>     /dev/nvme0n1:
>      Timing buffered disk reads: 510 MB in  3.01 seconds = 169.28 MB/sec
>     
>     # taskset -c 0-7 hdparm -t /dev/nvme0n1 
>     
>     /dev/nvme0n1:
>      Timing buffered disk reads: 5252 MB in  3.00 seconds = 1750.28 MB/sec
>     
>     # taskset -c 8-15 hdparm -t /dev/nvme0n1 
>     
>     /dev/nvme0n1:
>      Timing buffered disk reads: 496 MB in  3.01 seconds = 164.83 MB/sec
>     
>     # taskset -c 24-31 hdparm -t /dev/nvme0n1 
>     
>     /dev/nvme0n1:
>      Timing buffered disk reads: 520 MB in  3.01 seconds = 172.65 MB/sec
> 
> Even more mysteriously, the writing speeds are consistent across all the
> CPUs at about 800MB/sec (see the output of dd attached).

When writing host->dev, there is no cache coherency to consider so it'll always
be faster in NUMA situations. Reading dev->host does, and can have considerable
overhead, though 10x seems a bit high.

Retrying with Damien's O_DIRECT suggestion is a good idea.

Also, 'taskset' only pins the CPUs the process schedules on, but not the memory
node it allocates from. Try 'numactl' instead for local node allocations.

