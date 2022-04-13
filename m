Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EB5BC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Apr 2022 18:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YvzIs9BEv5eEfyodPDl3/81QAr6FgCYIIF52vEruur8=; b=WEHIi1yvx07cpDBk7xNoFDFoCZ
	KhUtFYYxlopHFU71UKKtLzEyEDrsVjf8r7yFoYjF76BOVOEddXioGz4R+ACcUnPxgHLtSpRSKiVdb
	PJiteP9wxQvjDSv/VMDet/qqsWaiLPZKzHJQzA9x1+TAoshBJshqxkrkJc0K86UPwBUwusdX8uMM/
	Lj2W0BY/1uTb2J1Mq5XCkteKMFlwx98GKVHWZIG4Z5oOGeL1Z3R3w4kFjQYUC9yE8NBhbfcL1T0bg
	OE++snDFcxUDN/VQfN/0+xfm0L5yzO5XLdXVL5G8bHjr3TXZRDiCTttra1+QdxosOMh0nH56+j3bA
	8ZMwpWRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nehQF-0021wn-J1; Wed, 13 Apr 2022 18:08:55 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2
 (Red Hat Linux)) id 1nehQD-0021wa-LO; Wed, 13 Apr 2022 18:08:53 +0000
Date: Wed, 13 Apr 2022 11:08:53 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: yi.zhang@redhat.com, sagi@grimberg.me, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: Re: can't run nvme-mp blktests
Message-ID: <YlcRtVYmFJHaxzKG@bombadil.infradead.org>
References: <YlYYJC/WUEsnI9Im@bombadil.infradead.org>
 <6cd7ebd1-f069-7f95-62f5-e8b18d6b3e58@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cd7ebd1-f069-7f95-62f5-e8b18d6b3e58@acm.org>
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

On Tue, Apr 12, 2022 at 10:53:40PM -0700, Bart Van Assche wrote:
> On 4/12/22 17:24, Luis Chamberlain wrote:
> > I do have CONFIG_NVME_MULTIPATH=y but I also have:
> > 
> > cat /etc/modprobe.d/nvme.conf
> > options nvme_core multipath=N
> > 
> > And yet I always end up booting with:
> > 
> > cat /sys/module/nvme_core/parameters/multipath
> > Y
> 
> Is the nvme_core module loaded from the initial ramdisk or from
> /lib/modules? In the former case, does the initial ramdisk perhaps have to
> be regenerated?

No, no ramdisk, but I just had to use the /etc/default/grub file to set
nvme_core=N as the /etc/modprobe.d/nvme.conf was not being picked up
for whatever reason.

cat /etc/modprobe.d/nvme.conf 
options nvme_core multipath=N

Either way, from a test automation perspective this requirement is a
pain, as I can't do a change dynamically at run time. So for this test
I have to manually change a kernel boot param. Is doing the required
changes dynamic not possible in the future?

I take it that it does not make sense at all to have multipath=N for all
blktests tests.

  Luis

