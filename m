Return-Path: <SRS0=InZj=L7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95023C07E95
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jul 2021 15:07:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CD1661CB2
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jul 2021 15:07:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CD1661CB2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=B5z/jTD5iDN5Ls6qfglmyCLL0mgFo2hGqTSk1w+HiA0=; b=0p/avqB05OEBDs
	wmgaSXlLfDIF821jU/1mcRvUhur6G4JQktG/nicbSi2r3pcWR3KDL/rkOpaXnCHdirjk2TwTBcfS/
	+4GN20q86IpRfF8kr044vQL7Mr3E78UPh4kjx+wgnG4Wid7n8F9t7iEg2shqmieDc25Euhp/IMBWj
	2OTY9B0SFZdsEzL5lIgtV9pCkVJ6oVoIoGgGRV9syItBBON+yvCqKF+fPMUyugZxKG5Ze8Zl1PhDH
	xt9/fowGLsOnCe8lD5M7gtigouSd+PxMkyYp0WFkSG5XwRGk55to8fmABxWqVXnO67+TNPowHW0BA
	DqLV7+L4jxUeBbHCFgqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m199I-00F9wt-BW; Wed, 07 Jul 2021 15:07:40 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m199E-00F9wK-Q1
 for linux-nvme@lists.infradead.org; Wed, 07 Jul 2021 15:07:38 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 25DF561CC0;
 Wed,  7 Jul 2021 15:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1625670456;
 bh=r0GOY5oato2xU5cNCC5miYM+Iufy+s3Mq3VWsm/p45g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=oJJRdDSeepIpkrfoQ7zBjQurohKgpz+qtDZB8amiowWUI+E73/8wrwxjHL0lKc+WY
 UL4le9w8ofJpeKa4VSGelT2SPeg/wBHFfb96VcLGjLg7itgn7/U08FnQkchYmLg35f
 wkATWQc1cy8iccAY66V8d/7Yg4a1QhOkKmC8v6WNnAydfiXIPp0BhpEc7/gNhDqILq
 9NOpnqWfr07PzsbhiMlCYxr90NgooF/+Owbwrdv4eZ1ipt28l5FIHTzk/cv1+FW9NM
 nMPwpRW4zd/d/Z4qYg+/EhKxnY8OlPLlt7XEBoOtf5o/PqI+SlisZ55xgr1GQ0HBxx
 iaLqOjFzbxzRQ==
Date: Wed, 7 Jul 2021 08:07:33 -0700
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Prabhakar Kushwaha <pkushwaha@marvell.com>,
 linux-nvme@lists.infradead.org, sagi@grimberg.me, axboe@fb.com,
 davem@davemloft.net, kuba@kernel.org, smalin@marvell.com,
 aelior@marvell.com, mkalderon@marvell.com, okulkarni@marvell.com,
 prabhakar.pkin@gmail.com, malin1024@gmail.com
Subject: Re: [PATCH v4 00/20] NVMeTCP Offload ULP
Message-ID: <20210707150733.GA287883@dhcp-10-100-145-180.wdc.com>
References: <20210629124743.6898-1-pkushwaha@marvell.com>
 <20210701132307.GA18548@lst.de>
 <c19a9d80-0d12-1ad0-8dce-169997ba5364@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c19a9d80-0d12-1ad0-8dce-169997ba5364@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210707_080736_905498_F414A9F6 
X-CRM114-Status: GOOD (  14.17  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Jul 07, 2021 at 04:58:44PM +0200, Hannes Reinecke wrote:
> On 7/1/21 3:23 PM, Christoph Hellwig wrote:
> > I looked over it a bit (and will send some individual comments), and I
> > have to say I really dislike how this layer and how the hardware works.
> > 
> > The whole point of NVMe is that we have a nicely standardized PCIe
> > register level interface.  One that you can trivially hide a TCP offload
> > under with just a little control plane logic.  But instead we come up with
> > this gigant mess.
> > 
> I can't really see how this control plane logic should work; how would the
> entire NVMe-oF discovery be abstracted away to hide behind an NVMe-PCI
> device?

Devices are already doing this. The discovery setup is device specific,
though.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
