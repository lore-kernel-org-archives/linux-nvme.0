Return-Path: <SRS0=ldP/=42=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D8CC10DCE
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Mar 2020 01:55:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BEE420675
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Mar 2020 01:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SlQhLeEk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AAFWc+KT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BEE420675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Abp6U5/InEOzbcdJ+sL+TpTbn0bA0GFeQvfBXr/PgvY=; b=SlQhLeEk8giRnF
	PqO8bGHbJh1dba72nMQY9DUolreEcodM2tvWszS0JZtRHvLPXcCCf4+jfi+tFQER37vJCYRsIznEn
	cDMk0RUbmxamqt4mNy1boDGZlyBrIcoWHWl5CHhU0Xn9l8Ylx402fQX0yshb4vyr6Zus3Jfu1aZgl
	nk1hF9eNnD3Tvy/K8ccSiJ1KGSNmlHnmJGVrKAZ1oFuf5z4rW1mohw/J2vCkIP8iYEDHF6yH6scKj
	3O15fxK9Sakm0hDWPzeM1nrEeu2U2YQD4lGV5wBm7LdFXA0knkJxVeQERaLZfk8xVe2FSrMg+7OvP
	veuFXB5f5S51wtfmvYxg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jB7dm-00044N-SM; Mon, 09 Mar 2020 01:55:34 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jB7dk-000440-09
 for linux-nvme@lists.infradead.org; Mon, 09 Mar 2020 01:55:33 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7494120675;
 Mon,  9 Mar 2020 01:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1583718930;
 bh=3afrJU3Wci3AXT+z/g0aNnKfqyGY6C4fX7g3nW0oWbI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=AAFWc+KTFhdf4RDbW1RsRke+A5FhVBXi7zDuUC1B5jZPrDoAHkntyMuzV1w8GCCyl
 ifTK/HBEXLwJpI9dIhEMq75GOmUTiaxupLc44aWnfY1dGMsXjtLPPq7a7HLMUJ8fVs
 zL5MBIID9p2SKkOVjLcKkgXXpwpv5jNXfLpfb/yA=
Date: Mon, 9 Mar 2020 10:55:24 +0900
From: Keith Busch <kbusch@kernel.org>
To: Yaroslav Isakov <yaroslav.isakov@gmail.com>
Subject: Re: NVME is not using CPU0
Message-ID: <20200309015524.GA4567@redsun51.ssa.fujisawa.hgst.com>
References: <CADS+iDV5S+QyfhE4M+fSwXuczx4WCveU+UyhKpx7HY6pfHfc6A@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CADS+iDV5S+QyfhE4M+fSwXuczx4WCveU+UyhKpx7HY6pfHfc6A@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200308_185532_065479_EE0F39DD 
X-CRM114-Status: GOOD (  10.83  )
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
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Mar 09, 2020 at 12:46:24AM +0100, Yaroslav Isakov wrote:
> Hello! I found that my nvme disk is not assigning any queue on CPU0. I
> think, that maybe it could be a bug, related to admin queue. Function
> queue_irq_offset return 1 with note that this is for admin queue. But
> on my system, admin queue is on the same CPU as q2. Here is part of
> /proc/interrupts

All CPUs are assigned an nvme IO queue. Pin your IO process to CPU 0, it
will function just fine. Another way to confirm is run:

  # cat /sys/block/nvme0n1/mq/*/cpu_list

Every CPU should be accounted for in the output.

What you've observed is that your controller doesn't support enough IO
queues or MSI vectors (or both) to assign to each CPU. It just means that
a command you submit on the queue assigned to CPU 0 will get completed on
a different CPU.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
