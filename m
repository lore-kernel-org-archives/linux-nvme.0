Return-Path: <SRS0=jFtc=XP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A16AC3A5A2
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Sep 2019 17:55:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D83CB2086A
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Sep 2019 17:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="B6LEEPAu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RnWKj25U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D83CB2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RDtVGda3h/aG2eSwzYWma7h4Jhn9zMX2EY6ZTsyiuKY=; b=B6LEEPAuQSkt+D
	0+HM7QT6h6R2139NSxUiSZeTc/t985XKwwjigwgRsaM482gGLJEikD7EixKVk88jsnUMiA0uC2VUH
	mWbqKWxbo/u4l7g/gLzMalGWORyrkf8Tvx8WuayIg3DUWFLqEANIVlT7oC4llFC+GGT4nD+cmvAXo
	rVIoipha9XQr4F6dutjEl6QR9nINxqjg9q7YBB5PXbevnZR8PWW1P4Fih8/vKwghePPNU/ShOsqDO
	9yZwH2Mdx/8+EaV/lAJJX0igU05v/YM3F4z6M+SeWrjUqvGIbog524Ho4kJOHgG2IcHXpAhpknbvj
	/og0my4ixb515zT7m3kg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iBN7T-00068n-3P; Fri, 20 Sep 2019 17:54:59 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iBN7Q-00068P-ES
 for linux-nvme@lists.infradead.org; Fri, 20 Sep 2019 17:54:58 +0000
Received: from C02WT3WMHTD6 (unknown [8.36.226.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DD0C02086A;
 Fri, 20 Sep 2019 17:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1569002096;
 bh=yZCO4v4fZBAhBf7cVRwNF01joLuaJE574y7iX8J0JJs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RnWKj25UsgwTdXYFlyTq2usMl72gTEGncJhkbdYeJOCMtPamyrATkPNbbCUWaquoC
 vOYAtlVmO0kVSXoKloiKsd6hCrfRvQdAQ/sNTH0kecbBBslAuHXxkC0HHwV/BrN9yb
 RpDb+Zam0i9aGflefPFNfCyGjBHm1YaPeHDJm3AI=
Date: Fri, 20 Sep 2019 11:54:54 -0600
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCHv2 0/6] nvme: double reset prevention
Message-ID: <20190920175454.GB97854@C02WT3WMHTD6>
References: <20190919213431.7864-1-kbusch@kernel.org>
 <6f31bc09-95d3-bf11-7846-e57d8600462d@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6f31bc09-95d3-bf11-7846-e57d8600462d@grimberg.me>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190920_105456_504010_2A915510 
X-CRM114-Status: GOOD (  12.91  )
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
Cc: Edmund Nadolski <edmund.nadolski@intel.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, James Smart <james.smart@broadcom.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Sep 20, 2019 at 10:51:52AM -0700, Sagi Grimberg wrote:
> 
> > The main objective of this series is to prevent double resets. This sort
> > of thing is known to have happened if a timeout occurs at roughly the same time
> > as a user intiated reset, like through through PCIe's FLR.
> > 
> > The double reset could happen because the controller disabling had been
> > occuring outside of the RESETTING state when we can't schedule the
> > reset_work, which is to occur later. When another reset schedules in
> > between these events, the controller ends up in the wrong state.
> > 
> > The end result of this series is simply to block subsequent resets by
> > initializing the controller state to RESETTING without actually
> > scheduling the reset_work. The first patches in this series are simply
> 
> are simply what?

Oops, cut off my message.

Simply fixing issues discovered while testing the changes.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
