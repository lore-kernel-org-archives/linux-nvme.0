Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66105EF8FEE
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Mar 2026 14:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uu+vIxcsCbnLTUOmEvwrBGcrqtuPEEX0C04Xt3YlVzw=; b=SkNlpuFqOyfQdf3grYL+IBqcnB
	6+Rz/hI840BhOaLEHYht/D0tQN/3JN9+MEo4BRbNEw8Upv9L6KZ4X0Ck+Fk2Gth+S4MS3qlkFIhBr
	rVk7id9GZAHrzEO7yb1I7T7fSumZRIJ8c05cyfFuthr6TVffmgoT9v4EWIrLK33J7PLVZcumpNfFj
	Jq/zb6fIptiZmu0oGf1sAEbQyuZzzTDfr2nzHNrKPcOSRA0hWPRXtpb811bOj8yKFLLfEtPeYhM58
	eC837SagbBvw4y0nlstms3y3Dq/JhWIhug4Rq9SqdFjTX+OPhUSBwAQ0YznAZBHlhBA6DzdHLxI7C
	3OdLAI/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxnb8-0000000HRts-3Ied;
	Wed, 04 Mar 2026 14:53:14 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxnb6-0000000HRtM-1SnO
	for linux-nvme@lists.infradead.org;
	Wed, 04 Mar 2026 14:53:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id A1BD84172E;
	Wed,  4 Mar 2026 14:53:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 099F0C4CEF7;
	Wed,  4 Mar 2026 14:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772635991;
	bh=qR4Jyeo55f9YkNdfG2oktiXoHot7nMXnhRYuZoesiR4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WnMHWONQ55fLh9k+qnGaurxcYhBXLcT1vqqIeuKsmJaeJqxBQxRwT+B+G1utbq55E
	 zuRn0D7VV1qfHXxVLzheMsPFERmSFD0u82RRJYLbXIVjlDP8dGdot8JBLXajVpQrGF
	 jR50kAj/m9e6U/JD9W105EjF3Ggrfvs3TnC+z8cCaZvojUSsuIFSGxXg67p33xRvSz
	 i94RbCEZdcesdpFkIqdpYqqk7VptP5IMoImSe3h7LCqdHSErnBoaknlONSi4McKoJi
	 Dt/iuqFgp62VPVRlIfiAScKHo3cynDRU/HAsOFdtsqebLFHVjgtQqGgA+K2E+qWGbC
	 LwE8nGPQGn2Bg==
Date: Wed, 4 Mar 2026 07:53:08 -0700
From: Keith Busch <kbusch@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@meta.com>,
	linux-nvme@lists.infradead.org, hch@lst.de, mlombard@redhat.com,
	jmeneghi@redhat.com
Subject: Re: [RFC-PATCH 2/2] nvme: use the namespace id for block device names
Message-ID: <aahHVAyi9CINoBUv@kbusch-mbp>
References: <20260302222532.3400786-1-kbusch@meta.com>
 <20260302222532.3400786-2-kbusch@meta.com>
 <c2ef8067-a5c9-4be7-8e2a-9d74610d446f@suse.de>
 <aacAzGpNJ2RXedvG@kbusch-mbp>
 <aacSCnD-ag9-Llfg@kbusch-mbp>
 <d2bc9d0e-dc9b-4c98-b07d-8c8f667b7c0e@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d2bc9d0e-dc9b-4c98-b07d-8c8f667b7c0e@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260304_065312_404379_DA357DDB 
X-CRM114-Status: GOOD (  16.92  )
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

On Wed, Mar 04, 2026 at 05:25:28PM +0530, Nilay Shroff wrote:
> I think we need to ensure that the head disk is fully removed from the
> system before a new head is created that may reuse the same NSID; otherwise
> we may run into name collisions. Since removal of the sysfs entries
> associated with the disk can be delayed, a namespace scan may attempt to
> create a new head with the same name while the previous one is still being
> torn down.
> 
> To avoid this, it might be better to defer removing head->entry from the
> subsys->nsheads list until after the head node´s gendisk has been removed in
> nvme_remove_head().
> 
> From your first patch in this series, I see that the removal of
> head->entry from subsys->nsheads was moved to the beginning of
> nvme_remove_head(). IMO, in addition to the change you proposed above, if we
> also move the removal of head->entry until after del_gendisk() is called,
> that should ensure the old disk is fully removed before a new head with the
> same NSID can be created.

Yeah, I'm really sure why it was done in two steps split across
different subsystem lock contexts.

I'll respin the series along with the last two patches from this one:

  https://lore.kernel.org/linux-nvme/20260226183216.2098584-1-kbusch@meta.com/

