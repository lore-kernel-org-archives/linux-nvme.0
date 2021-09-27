Return-Path: <SRS0=w6YM=OR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96400C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Sep 2021 04:22:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A6F160F92
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Sep 2021 04:22:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1A6F160F92
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:
	In-Reply-To:Message-ID:Subject:Cc:From:To:Date:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=s5KAbZU+B5cetfAVdFo3T/T4ltmOO+5fK2waLVc5DFY=; b=Inj0nZvPuHtnhe
	ZfaGBZcYpR8ZacfVmE+sR2geXi9cT/3sLYLpma5fK8iXfd1/ogV/A9Yhye5FwOSuEm68vqpO05hWX
	GD+ISEc3XhJz9uX5nUJxUFBaIi0+0jyesQgjmqbgoVBWuu/BdUQiqsoyQUCVxtSKrd4WmAybf5mn7
	WZyBP3q0Q0lfIDpZQU4wWPrCNnOZiTTIlrEi8yDIQpVIStFD5luEbfygW4HlTL1ingdmfESed4Uvq
	MhXmPcC2pK+I0A48PtGKj96Z4ItYwgiiYr8jrVfMg7xR9c3hXrQz+rUGN7OvB8sGbMr9LKmnxkcqs
	gkhWJJJFUSur/ybOgYGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mUi9f-001Xiz-PG; Mon, 27 Sep 2021 04:22:15 +0000
Received: from mail-40140.protonmail.ch ([185.70.40.140])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mUi9c-001Xhq-2s
 for linux-nvme@lists.infradead.org; Mon, 27 Sep 2021 04:22:13 +0000
Date: Mon, 27 Sep 2021 04:22:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail; t=1632716526;
 bh=0KQC3UH/Oil+fYCXtnSPv7zcDj9qxOzq5y5CNs7SIPw=;
 h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
 b=a6+EivaBU0r1brTMGg+2pfMHxDa7GO9TS+5lvCTNM5L5g7Aglm2geqIjzK8UZN9Ho
 Ptnp9UCUClZRZdCp2UgaT+1morD5xUggHVlrtI3B2PQvewq77zCpplKauHRBQNDEHi
 lZYZmhBM/9wZRS4N8m29h3BWCepXuwI6vHpd47gc=
To: Sagi Grimberg <sagi@grimberg.me>, Aditya Garg <gargaditya08@live.com>,
 "kbusch@kernel.org" <kbusch@kernel.org>
From: Orlando Chamberlain <redecorating@protonmail.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
 "hare@suse.de" <hare@suse.de>, "dwagner@suse.de" <dwagner@suse.de>,
 "hch@lst.de" <hch@lst.de>
Subject: Re: [REGRESSION] nvme: code command_id with a genctr for
 use-after-free validation crashes apple T2 SSD
Message-ID: <31c4dc69-5d10-cc6a-4295-e42bbc0993d0@protonmail.com>
In-Reply-To: <d65ecc69-35c9-4400-8fb0-95aa04360b03@grimberg.me>
References: <cjJiSFV77WM51ciS8EuBcdeBcv9T83PUB-Kw3yi8PuC_LwrrUUnQ3w5RC1PbKvSYE72KryXp3wOJhv4Ov_WWIe2gKWOOo5uwuUjbbFA8HDM=@protonmail.com>
 <20210925171618.GA116968@dhcp-10-100-145-180.wdc.com>
 <fa9de055-c3b8-20d3-41e0-12e43d0c336a@protonmail.com>
 <20210926020839.GA96176@C02WT3WMHTD6>
 <1a6f5030-27d9-d1ae-aff4-0ed2a10dce6b@protonmail.com>
 <1b5d6bef-db6f-073f-8d24-4963f0df82ab@protonmail.com>
 <PNZPR01MB4415801C6084E8CFD068A84AB8A69@PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM>
 <d65ecc69-35c9-4400-8fb0-95aa04360b03@grimberg.me>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210926_212212_330986_BB66BC76 
X-CRM114-Status: GOOD (  11.28  )
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
Reply-To: Orlando Chamberlain <redecorating@protonmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 26/9/21 18:44, Sagi Grimberg wrote:
> 
>> I checked out the proposal sent by Orlando Chamberlain to replace NVME_QUIRK_SHARED_TAGS , by NVME_QUIRK_SHARED_TAGS | given in the patch on http://lists.infradead.org/pipermail/linux-nvme/2021-September/027665.html. The , still causes panics to the T2 as described before. In the case of |, the kernel boots correctly without panicking the T2, but in case we are having Linux on an External Drive, which is my case, then the internal SSD doesn't seem to be recognised at all. I've tested the patch on 5.14.7.
> 
> That sounds like a separate issue, because with this patch applied,
> all tags should be within the queue entry range (with generation
> set to 0 always).
> 
> Is it possible that the io_queue_depth is being set to something
> that exceeds NVME_PCI_MAX_QUEUE_SIZE (4095) ? the default is 1024
>
I've been able to reproduce it by using the same kernel Aditya is using:
https://github.com/AdityaGarg8/T2-Big-Sur-Ubuntu-Kernel/actions/runs/1275383460

From the initramfs:

# dmesg | grep nvme
nvme nvme0: pci function 0000:04:00.0
nvme nvme0: 1/0/0 default/read/poll queues
nvme nvme0: Identify NS List failed (status=0xb)
nvme nvme0: LightNVM init failure

It might be because this is 5.14.7, while I've been using 5.15-rc2. Additionally,
there are differences in kernel configs, I've put both configs in this gist
https://gist.github.com/Redecorating/c8cf574df969f9b4f626dfb9c6b2a758


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
