Return-Path: <SRS0=N6Q+=ZR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A40C432C3
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Nov 2019 17:06:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 103BD20674
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Nov 2019 17:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SQWkTdru";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0IyFDmj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 103BD20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4U5dt5jPjfrG1vTbS+axskcviT1wdFZhyT4A6SlY7t8=; b=SQWkTdruugTdCA
	EzbDe3B7zBGXx6jOcdnZtM7e5cld1vCfRrLUdLrp/zV8XkPmRWuAkY+9L/beU3Rz+XZf4gFoVvUFp
	8DO7KsTRHcuLFUKMMBJjZRxjfoaA3MdUaDYWaeRnS3eUSL/T4iCQ+pSkjXE3/auUYK9dY5sbyNm37
	Gp0DO08/lF/07NAURT8zq0gJPUSa7qjHfDANaQXGypOGeG19HpDg8eVUTjXU3kFDTkWDPaMw8lZJm
	Vz7HutqhOoLdkeHOSw92RysnUWU8/Jrwwl6Ix2XpHesywmedykWJFXBAJCSk8+vCvrHnXBRqMRCNI
	bg1RDArNoEpGQj9ZF61Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iZHp9-0004WN-OY; Mon, 25 Nov 2019 17:06:55 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iZHp6-0004Vn-0D
 for linux-nvme@lists.infradead.org; Mon, 25 Nov 2019 17:06:53 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A2A9420674;
 Mon, 25 Nov 2019 17:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1574701611;
 bh=dV5N7lrWCRKuQXzgroS/IVAur0GfE8YVJPXWUztdY/w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Z0IyFDmjqOdkZh65moLEQKsGewhwh6m4bEwNfGd+/NhK3anfKCo/Hk9yzAgURdoe3
 Tj7xt4N0Ha5aALeX9GAMd7jGbuDcQIeiOMw9CpbJ/HR8wOfF927O9ioZPZYKowoEjf
 OUaBlGYPRcXRZyiDqgFQmrv6EmpMKNMgqUQ8Wjzc=
Date: Tue, 26 Nov 2019 02:06:44 +0900
From: Keith Busch <kbusch@kernel.org>
To: "Nadolski, Edmund" <edmund.nadolski@intel.com>
Subject: Re: [PATCH 1/2] nvme: remove unused return code from nvme_alloc_ns
Message-ID: <20191125170644.GA1639@redsun51.ssa.fujisawa.hgst.com>
References: <20191125160612.3542-1-edmund.nadolski@intel.com>
 <20191125160612.3542-2-edmund.nadolski@intel.com>
 <1ca1b4c3-8c42-c728-d987-18821f83088a@suse.de>
 <221e4352-7fab-abea-9f43-2cd1df60dbaa@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <221e4352-7fab-abea-9f43-2cd1df60dbaa@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191125_090652_080668_5A778FFF 
X-CRM114-Status: GOOD (  14.41  )
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
Cc: linux-nvme@lists.infradead.org, Johannes Thumshirn <jthumshirn@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Nov 25, 2019 at 09:46:08AM -0700, Nadolski, Edmund wrote:
> On 11/25/2019 9:09 AM, Johannes Thumshirn wrote:
> > On 25/11/2019 17:06, Edmund Nadolski wrote:
> > > The return code of nvme_alloc_ns is never used, so change it
> > > to void.
> > 
> > Oh no, please do it the other way round, check the return value of
> > nvme_alloc_ns() and handle error properly.
> > 
> > nvme_alloc_ns() is doing memory allocations and these can fail (although
> > less likely because of the GFP_KERNEL allocations).
> 
> I considered that, tho it looked to me like the caller (nvme_validate_ns)
> and its callers (nvme_scan_ns_list, nvme_scan_ns_sequential) don't really
> care, and intend simply to continue on regardless of memory alloc
> failure(s).
> 
> I can either add the -ENOMEM handling, or clarify the caller's intent w/some
> comments. Which is the way to go?

It would be informative to just log the error that occurred so we have
something indicating why an expected namespace wasn't created. Otherwise,
I can't think of anything else the caller should do in response to an
error in this path.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
