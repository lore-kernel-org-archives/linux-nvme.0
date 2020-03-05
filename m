Return-Path: <SRS0=uiYz=4W=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F34C3F2CD
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Mar 2020 15:15:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAC622070E
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Mar 2020 15:15:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KoDTHr07";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rtV+cSrB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAC622070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Di02vBPFzE5nCLOp34srhj8Ib+u0vwkuezyeBMvAOAE=; b=KoDTHr07X6erRx
	Fh0aPr31HGtIOakToYGeXRM/SDRNeivcrondwWcFs+MfNrcWrdzVLFdB27BPfTJhvMWD28uJ2bXuZ
	ubogCCKwvjibKW5EFlNMMKaS+SLVti8lHbUjbRiM7+qPZJ5G75pEC/oiA6795gdWaqL3LbPrqqjBF
	ZiIyFcM66E3EYvePsDqmZ92e5FZ3GTM8MQ2wBw/iHvzg3LZ5phcQqVsQOhGI2RqKYFsyad56vQnGU
	rMEC8efA8xK9mOhmOiJaaIRxAM747fy0HiB25URprVp9EtKf/G8F1yC+at8dhcCyKCJrzQgX4I4Qd
	BPm+bK1xy2kZvL6SnPag==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j9sDi-0000N8-Cy; Thu, 05 Mar 2020 15:15:30 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j9sDf-0000Mb-Gz
 for linux-nvme@lists.infradead.org; Thu, 05 Mar 2020 15:15:28 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id EFCD92070E;
 Thu,  5 Mar 2020 15:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1583421326;
 bh=ItX38qm1pswyptVVy91LZsyl5zmL/0WJQBmFJVkJaoI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=rtV+cSrBl1dF+ETv5i743nj08XLXvdU8UiMDY/nKX4KZrp2ra4/lcyU8axaJ+2Scq
 c4bgKeyKr9o3OEDe/kqVHJVhRo5vSKZBPyoU32cXSGJ6UY0jJ9KGCtfpuuu6gDxJdB
 uTAlI1KQ4bmHDQmtBfUAzQlLwWAmH0FJjlQM37CU=
Date: Fri, 6 Mar 2020 00:15:23 +0900
From: Keith Busch <kbusch@kernel.org>
To: Dongli Zhang <dongli.zhang@oracle.com>
Subject: Re: [PATCHv2 2/3] nvme-pci: Remove two-pass completions
Message-ID: <20200305151523.GA28317@redsun51.ssa.fujisawa.hgst.com>
References: <20200304181246.481835-1-kbusch@kernel.org>
 <20200304181246.481835-3-kbusch@kernel.org>
 <b25de82c-115f-50d3-6752-f4f91a5623ae@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b25de82c-115f-50d3-6752-f4f91a5623ae@oracle.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200305_071527_587769_3DD27E18 
X-CRM114-Status: GOOD (  12.34  )
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
Cc: bijan.mottahedeh@oracle.com, hch@lst.de, linux-nvme@lists.infradead.org,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Mar 05, 2020 at 01:50:58AM -0800, Dongli Zhang wrote:
> Hi Keith,
> 
> On 3/4/20 10:12 AM, Keith Busch wrote:
> > Completion handling had been done in two steps: find all new completions
> > under a lock, then handle those completions outside the lock. This was
> > done to make the locked section as short as possible so that other
> > threads using the same lock wait less time.
> > 
> > The driver no longer shares locks during completion, and is in fact
> > lockless for interrupt driven queues, so the optimization no longer
> 
> About "no longer shares locks", would you mind share is it a specific nvme
> driver commit, or the transition from sq to mq?

They're all nvme specific commits. For the record, nvme never
transitioned from 'sq' to 'mq'. We were bio-based before 'mq'
existed.

Commit splitting locks: 1ab0cd6966fc4a7e9dfbd7c6eda917ae9c977f42

Commit removing cq lock: 3a7afd8ee42a68d4f24ab9c947a4ef82d4d52375

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
