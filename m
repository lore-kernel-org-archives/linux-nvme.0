Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50085C46CD2
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jan 2024 17:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5j45GbGnu5wmpEwE/qeCWOFbiMDqrmOQZ+In2X9KLC0=; b=UyYvK8pNcqYRY4gq2NgxpfZlKb
	jaRKfdauSpu6giQztu7FH4JAmOZBb7Y5jrC+Xrn4E2m3cpRDHUkJ8rzOxvX5UtEcNSNdVH8xqacT6
	wf3BldpGsxMHSQSAfr39nVniAhGghLL2rW4Ei4iIiQWDYJsua/9W3eGxBD+/56qYdMwcaplgpqDRk
	5Bj69T1QGTMdzM6RdTdqVreBdL4e2u47ONb8FvOGOvz661R2mjrMqz/n75YdkldD/QoZVl9tKy0fg
	uZtXrMO3DX5i0jRFAL656kB+F7mL1OuZ6J1lq/4Hu7YApX63oYgbRMZ/rf6RIQzDeKWxON0yuE2dD
	IvvUTJJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rShP5-004ZPV-1d;
	Wed, 24 Jan 2024 17:51:11 +0000
Received: from gentwo.org ([2a02:4780:10:3cd9::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rShP1-004ZNL-1Q
	for linux-nvme@lists.infradead.org;
	Wed, 24 Jan 2024 17:51:09 +0000
Received: by gentwo.org (Postfix, from userid 1003)
	id 854D340A94; Wed, 24 Jan 2024 09:51:02 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 838C840787;
	Wed, 24 Jan 2024 09:51:02 -0800 (PST)
Date: Wed, 24 Jan 2024 09:51:02 -0800 (PST)
From: "Christoph Lameter (Ampere)" <cl@linux.com>
To: Matthew Wilcox <willy@infradead.org>
cc: David Rientjes <rientjes@google.com>, Pasha Tatashin <tatashin@google.com>, 
    Sourav Panda <souravpanda@google.com>, lsf-pc@lists.linux-foundation.org, 
    linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
    linux-block@vger.kernel.org, linux-ide@vger.kernel.org, 
    linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org, 
    bpf@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] State Of The Page
In-Reply-To: <Za2lS-jG1s-HCqbx@casper.infradead.org>
Message-ID: <aa94b8fe-fc08-2838-50b5-d1c98058b1e0@linux.com>
References: <ZaqiPSj1wMrTMdHa@casper.infradead.org> <b04b65df-b25f-4457-8952-018dd4479651@google.com> <Za2lS-jG1s-HCqbx@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240124_095107_531773_1AF3DE5A 
X-CRM114-Status: UNSURE (   9.16  )
X-CRM114-Notice: Please train this message.
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

On Sun, 21 Jan 2024, Matthew Wilcox wrote:

>
> I'd like to keep this topic relevant to as many people as possible.
> I can add a proposal for a topic on both the PCP and Buddy allocators
> (I have a series of Thoughts on how the PCP allocator works in a memdesc
> world that I haven't written down & sent out yet).

Well the PCP cache's  (I would not call it an allocator) intent is to 
provide cache hot / tlb hot pages. In some ways this is like the SLAB/SLUB 
situation. I.e. lists of objects vs. service objects that are 
locally related.

Can we come up with a design that uses a huge page (or some 
arbitrary page size) and the breaks out portions of the large page? That 
way potentially TLB use can be reduced (multiple sections of a large page 
use the same TLB) and defragmentation occurs because allocs and frees 
focus on a selection of large memory sections.

This is rougly equivalent to a per cpu page (folio?) in SLUB where cache 
hot objects can be served from a single memory section and also freed back 
without too much interaction with higher level more expensive components 
of the allocator.

