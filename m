Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C0C6CFC277
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Oct 2024 15:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JE7jUSYpAl5eJW2cBAXYHdKgWUa734x8JbXgQmFl80Y=; b=YPORUUI3YvRUyKA3I3R0L5/vL4
	uLSUYFCUyJvlJvlTzQsZeLWAYvqJ8h3nqd3ejxo6FKRIiWRS3/0x8OPUAk11UwedaPDet+ijQ5tIg
	+b9JCr8gGitCSzkF2SujrhNGvcPSbTb1cIMOAjxvAzBybs0i0zYH2/k4kaEaOtsJop7jO3D4upBbV
	f66pIrFHQIj1vnw0s7Sxfa+b8BRPk8yKy+AGbt6iKLvRu9oSAy2YpPJGe6HxR+tfax5cQICb55KZx
	rHVN2nQ3IUUSx9HLpGhP5Cp6maQ8645o8YLNEOnJjGn83pFVpSP/Rq5UIGjhCrMEipowcLV5oA1Ig
	1TEcXxLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0jC3-00000008eUB-1Xm1;
	Tue, 15 Oct 2024 15:10:39 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0jBw-00000008eTF-1QR7
	for linux-nvme@lists.infradead.org;
	Tue, 15 Oct 2024 15:10:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 15D325C5B8A;
	Tue, 15 Oct 2024 15:10:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0903C4CEC6;
	Tue, 15 Oct 2024 15:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729005031;
	bh=MNeF9PMSZDi/pHIc/9DZVWvRHqtREzdib05DtkyKXlU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EIcGDzUpQApcmNjRII+9ppHFY9I1VvtuFBUOHAU+oa0r+MAn0eZ+VKBDMtehczUGV
	 inEpCdh7Eln2U2SBq50iuJV/IPnXd9HyuAHqt8rOjKVNE4VSdJyBPqh+7VJQvPpRlS
	 hbrLiI+hmGgInbG+gydsDoNaLA+BCxdCXaJGM7hdWzDqjJd8GxnPoKU3E5jMmjCCWn
	 q+RtVPH8MkTL8kFXrGG0Co6SKE8+FmPJHohj/f0rNdbhyTY8cgrEPP9WC8VQ8uE/l0
	 vSdW8DZIbPrljlFbF6yUPxnyMEhRpfhod7zgyxJug+QYB1E+tAejeUJfy7LVmcCi2z
	 5h47DBBQ3XGOA==
Date: Tue, 15 Oct 2024 09:10:28 -0600
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/3] nvme-multipath: cannot disconnect controller on
 stuck partition scan
Message-ID: <Zw6F5LN6YuVVqFux@kbusch-mbp>
References: <20241007100134.21104-1-hare@kernel.org>
 <20241007100134.21104-3-hare@kernel.org>
 <ZwQmK6dZ_goSQ4Cg@kbusch-mbp>
 <47968bf9-2b98-4e5e-9040-2db6f15d86a6@suse.de>
 <ZwWY8d3vOLUaYaJ6@kbusch-mbp>
 <3b8ff898-9529-4506-8c5d-0fcf3423730f@suse.de>
 <Zwa-MBS6wn_dGxge@kbusch-mbp>
 <b7ffdbbb-0b4e-4215-bf2b-b5c2f9a2dc08@suse.de>
 <Zw59LxZ3cngO17_f@kbusch-mbp>
 <4478f837-b504-44dd-8f5b-facab6aa8161@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4478f837-b504-44dd-8f5b-facab6aa8161@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241015_081032_440998_856E81E7 
X-CRM114-Status: GOOD (  14.32  )
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

On Tue, Oct 15, 2024 at 04:56:08PM +0200, Hannes Reinecke wrote:
> On 10/15/24 16:33, Keith Busch wrote:
> > Is that actually happening for you? I don't think it's supposed to
> > happen because mpath_shutdwon_disk only happens if the head is detached
> > from the subsystem, so no other thread should be able to possibly
> > attempt to access that head's disk for a different controller path. That
> > new controller should have to allocate an entirely new head.
> 
> Na, forget it. Not only doesn't it happen, but we need the
> 'test_and_set_bit()' at the start otherwise we can't abort I/O.
> So all's fine with your patch, and it even survives my testcase.
> 
> (The first to do so even after several runs, I might add :-)
> 
> Care to send an official patch?

Should be in your mailbox. Here's the link:

  https://lore.kernel.org/linux-nvme/20241015143136.810779-1-kbusch@meta.com/T/#u

