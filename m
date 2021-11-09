Return-Path: <SRS0=GOb3=P4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C9BFC433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Nov 2021 16:16:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02BAF604D7
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Nov 2021 16:16:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 02BAF604D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KGLu4qgQ5P+TptfDmpJj+NcJJIwzn2saVNBDVPYASCw=; b=4y/Ek46ayCfCy9vsNS7h8Qzgdo
	PBhaVsk9x8CN7NyYo6IVi7abgnWzmqtgbYdGSM1gHK1ZWqul6Tv2kKa11E8JLbmK2E8FvJokhlWTz
	9lefRLvFbIrE9s73A7Pyg2ui/Ts9ZWIP1IbzNEMoM2p+2TBY7NZTRjDQHIzuzVCIC/DNZK+D5GVr9
	UmhvyZbSNJN+lE4v8mR4WDfn+nH3TQju8vAkKAQ7fHqHF0Fw3jUNjb/ORDQpOQwUpSn6BTcu0dHwh
	HxZ/w9NtcG/ZtECCG3/DvMG2jzOhpG6wHt4P6G8072BRAT/uat8zG5lCUKhpB9W4wHDLCg0QsJe+S
	UNj9TjOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mkTmt-002eVH-E0; Tue, 09 Nov 2021 16:15:55 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mkTmq-002eUf-OF
 for linux-nvme@lists.infradead.org; Tue, 09 Nov 2021 16:15:53 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id B6E3A604D7;
 Tue,  9 Nov 2021 16:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1636474552;
 bh=KgGIsDjDda52BPXNkS18MC+GtkqOUfYLvRP98YQG1wA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hhzRXuK5Rs3fg6eLdL8T7iDoV3c6wJ45Ub8cypoiLt/WyjcgjQ35zpuaZy9epPxsH
 RkOnaiE2hq9GMRi3ahIfR/qKzoswu+LlQimT2cz1aI+NIXhMhpD15HxPrhtI0JKTZ+
 ljnohCciH8y8fyZavd/USSe7qcYtPyXNJGWPl9AEI7KE42MktHTXkqBD1KB5ycL1Jb
 i+rInBlvsB9SiAxm/tuWU6IKDClIikZ3La0HM4RlkFHI5KvqFoQSC+eqT8VG8YRSln
 XaVZE4+qbHL2qtadTZOEOY5uD2p5G18+0ofGL4Mteuo/7Arjb78zfhoD0l+Yj3V4xi
 dy9o9b/eDY6oQ==
Date: Tue, 9 Nov 2021 08:15:47 -0800
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, linux-nvme@lists.infradead.org,
 sagi@grimberg.me, chaitanyak@nvidia.com, oren@nvidia.com,
 benishay@nvidia.com, borisp@nvidia.com, aviadye@nvidia.com,
 idanb@nvidia.com, jsmart2021@gmail.com
Subject: Re: [PATCH v1 0/4] Add command id quirk for fabrics
Message-ID: <20211109161547.GC2660170@dhcp-10-100-145-180.wdc.com>
References: <20211108144703.7971-1-mgurtovoy@nvidia.com>
 <20211108164511.GA2660170@dhcp-10-100-145-180.wdc.com>
 <20211109080903.GA28785@lst.de>
 <6292cd43-c746-0316-1820-aa52ec85d375@nvidia.com>
 <20211109131510.GA19713@lst.de>
 <9c740227-8c98-5877-9a9a-ae17756e851c@nvidia.com>
 <20211109143102.GA25263@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109143102.GA25263@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211109_081552_850503_7C0A7CFF 
X-CRM114-Status: GOOD (  15.65  )
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

On Tue, Nov 09, 2021 at 03:31:02PM +0100, Christoph Hellwig wrote:
> On Tue, Nov 09, 2021 at 04:23:33PM +0200, Max Gurtovoy wrote:
> > On 11/9/2021 3:15 PM, Christoph Hellwig wrote:
> >> Max, if you can't point us to a broken target (and yes, it is broken)
> >> this will not go anywhere.
> >
> > Any target that uses Apple device as backend can be harmed.
> >
> > Most simple example is Linux PT target that copy the sqe as-is and passes 
> > it to the NVMe Apple drive.
> 
> Take another close look at how command_id are assigned my Linux driver.
> We obviously do not pass it through as that would be completely broken.

Also worth noting this driver has always defined the command id as a
__u16, not __le16, yet we don't have any bug reports from big-endian
hosts.

