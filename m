Return-Path: <SRS0=ANVZ=BC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD58C433E3
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Jul 2020 16:03:35 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0E0F2071A
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Jul 2020 16:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jNuQkwCT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0E0F2071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=9mcic1ghi+Wd0vvi1PdmjkLZousvfP6Ju4R7Tmqq0/g=; b=jNuQkwCTu5vir8dGljxGy59ZD
	APZQWXgBNYYd4ulsRjnZulmlnBcrfk078p1eCPxmAJ82WVB94rJPXbsbYUlVaiSLG5WkdJnFJ2MVV
	LVQzYVi4AGK7OiF+GDMe0wkuA6NgSiXQeb9vkc70vK6XWmy759DE3F2FxkVKHfeD08HzN1S97ocjh
	jb8Op5dVQNlWf+cZopRU+R3tD7C0f+BgTwB6RXvtBLOv86HV0YMWi3EUuqZXfCkB9WVfjgBbGbWdg
	SUbED5nsnbyaQm9OLqp6K6N/viNQRWvwImoaI4O3YzTp+L+rGkG9/AocNkrLHm1PfvRXDf8SoAzC4
	tdW6pCLFA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jydgy-0000VH-7S; Thu, 23 Jul 2020 16:03:32 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jydgv-0000U0-5T
 for linux-nvme@lists.infradead.org; Thu, 23 Jul 2020 16:03:30 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 071B168AFE; Thu, 23 Jul 2020 18:03:25 +0200 (CEST)
Date: Thu, 23 Jul 2020 18:03:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH v2] nvme/pci: Add new quirk for SK hynix PC400 NLB
 off-by-one bug
Message-ID: <20200723160325.GA17996@lst.de>
References: <20200417083641.28205-1-kai.heng.feng@canonical.com>
 <20200723155731.22313-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200723155731.22313-1-kai.heng.feng@canonical.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200723_120329_364237_DEC8185E 
X-CRM114-Status: GOOD (  13.25  )
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
Cc: sagi@grimberg.me, open list <linux-kernel@vger.kernel.org>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, axboe@fb.com,
 kbusch@kernel.org, kyounghwan sohn <kyounghwan.sohn@sk.com>, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Jul 23, 2020 at 11:57:31PM +0800, Kai-Heng Feng wrote:
> After commit 6e02318eaea5 ("nvme: add support for the Write Zeroes
> command"), SK hynix PC400 becomes very slow with the following error
> message:
> [  224.567695] blk_update_request: operation not supported error, dev nvme1n1, sector 499384320 op 0x9:(WRITE_ZEROES) flags 0x1000000 phys_seg 0 prio class 0]
> 
> SK Hynix PC400 has a buggy firmware that treats NLB as max value instead
> of a range, so the NLB passed isn't a valid value to the firmware.
> 
> According to SK hynix there are three commands are affected:
> - Write Zeroes
> - Compare
> - Write Uncorrectable
> 
> Write Uncorrectable isn't implemented yet, so add a new quirk to
> workaround the former two commands.

compare isn't implemented either in the kernel, and we certainly
aren't going to do these quirks for passthrough.  So I think we really
want a "write zeroes is buggy" quirk and just disable issuing that
command from the driver.

> 
> BugLink: https://bugs.launchpad.net/bugs/1872383
> Cc: kyounghwan sohn <kyounghwan.sohn@sk.com>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v2:
> - SK hynix found the root cause so change the approach accordingly.
> - lspci is wrong, the device is PC400 instead of SC300.

I don't remember seing a v1..

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
