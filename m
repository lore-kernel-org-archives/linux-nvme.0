Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 548DEC47258
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Jan 2024 13:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M24qdktBCWms7N+u3HGEzgnuVeUu5Cf1GLX4tcIHPDg=; b=y2w2FFKN5aajd6LS/apmoipMFO
	ElIo9bIeNtDW18ouXlqtGtVppAcd8v/ZO480x3n2np0/Ch07bwtv0x7zvm8f91st+3GsCPaYdWma0
	kOmZZ1Ybz5wpM+HXUdMGtB1zGlZjVWy9Srb8JPiKcDEWVlX46VRO8zrvwvERIaKXaAZTtvc+h0Pvu
	DCnUs3ZhXkq0ilZH6GJFAw+VyBvZCYWZlD8gXTTuZH1sXA06GVtOz7CNoowwr5VBvFdcZwO3FbpTC
	Yzhjb/GXidcvvD2uHey9Y9oFFJowkzjZ1Q6VMr9grY5NYXFWSGP0qEJePhGHiGNXMVPoQsEM0ol8M
	kneUVBYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVAMX-00000003Y8M-48rT;
	Wed, 31 Jan 2024 13:10:45 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVAMV-00000003Y7m-3QrR
	for linux-nvme@lists.infradead.org;
	Wed, 31 Jan 2024 13:10:45 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id D1D5168AFE; Wed, 31 Jan 2024 14:10:38 +0100 (CET)
Date: Wed, 31 Jan 2024 14:10:38 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, Christoph Hellwig <hch@lst.de>,
	kbusch@kernel.org, linux-nvme@lists.infradead.org, oren@nvidia.com,
	israelr@nvidia.com, dwagner@suse.de, oevron@nvidia.com
Subject: Re: [PATCH 5/8] nvme: sync the namespace scanning during ctrl start
Message-ID: <20240131131038.GA25685@lst.de>
References: <20240122145659.5574-6-mgurtovoy@nvidia.com> <20240123090231.GD30773@lst.de> <f168e3d8-ddec-46cd-a032-2ca771b6cd23@nvidia.com> <20240124094832.GA31289@lst.de> <1315cf2b-038a-4830-87ac-5ac1fbd5a1e9@nvidia.com> <20240125144130.GA18804@lst.de> <d8f4c989-00a2-4545-87de-a70da312beff@nvidia.com> <c7b2670c-416e-4451-9c29-439595df5213@grimberg.me> <8d3c4f09-a1be-45b6-9452-7a14609a62d1@nvidia.com> <e1ae39e7-5c82-4cd4-aa7b-eb6718827d67@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1ae39e7-5c82-4cd4-aa7b-eb6718827d67@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240131_051044_021966_CDF5F505 
X-CRM114-Status: GOOD (  20.42  )
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

On Wed, Jan 31, 2024 at 02:40:07PM +0200, Sagi Grimberg wrote:
> Max, I mentioned that I don't think it is a good idea to change the
> existing behavior, because of time, because its preventing forward
> progress, because it doesn't fix an existing issue, etc.
> I also don't think its needed.
>
> I think the original intent of this as made in discussions in the past was 
> to simply fail upon PI mismatch when nvme_init_ns_head and
> nvme_validate_ns.

Yes.

>> I think that AEN and reset flows are a bit different. The controller is 
>> free to be modified at any time (even when no Admin queue is opened from 
>> the host). It may have out-of-band management interface (for example the 
>> nvmet cli) and may not have any association (AQ) to the host to notify on 
>> changes.
>
> Fundamentally things can change before the host knows about it, hence
> I don't get the claim that somehow the host violates the spec.
>
> Do others think that now namespace scanning should block
> nvme_ctrl_start ? I personally don't but I'm open to justification
> for why it is the right thing to do.

Hell no.

