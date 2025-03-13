Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32146C28B2E
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Mar 2025 09:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U1SdJTezby+ox+za5MAJ8lvGYDeN4Mka3W3ZheXILGY=; b=vXU5XmUtzaLa5gm0FlG71npJF9
	IBlmceVUKMXZfOIzcdt9mCMq6aBcCip32bVFb4+xvTkSFWYAmesK+mWQMl56r/hmKtm/QbNd3BeSW
	2cl9ySTQiECjYUJXYBDYxxKv/f/POFUfDzyXKJzcUPjg6JVMXT6//iliGjEJnxBRi/ZW5CPtEEooc
	NS89/AYQz1aAOAe2jGs3wZCmedQ+w+QN8XfMM1uCLK8RAgZ+jTxJAPKgMHL2SktB7Fhn/v7D3NR9E
	Qucl4Mpi/fVR1uOD8ZsPJllB9EkmCDMl0tZt5dXlHYli6AYTn98sthyAfVmPG0Vlgy/zy6MkAK/Mn
	WN1m3SkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tsegp-0000000Ahfd-1lya;
	Thu, 13 Mar 2025 09:17:19 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tsefl-0000000AhNZ-2CP9
	for linux-nvme@lists.infradead.org;
	Thu, 13 Mar 2025 09:16:14 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 2352C5C0EDA;
	Thu, 13 Mar 2025 09:13:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E445C4CEDD;
	Thu, 13 Mar 2025 09:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741857372;
	bh=EveOz9BzqCWNDFQacYFRdY44+wrFRTKnPnOmJi+jXac=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WBkj0tkeeGRkOdQ92Bi4Fop54UxAH+yBeq7GFhdwsF7bDLgR434u8sYEt6fya67Lq
	 3M/FVO+peqFfKl+13tYh1n7nTUGgf1i8cOBKXlylSjBaVaJtYLRpiY5F0jBs0tenm1
	 wIbiI955QyNd8yADAC7Q5H9AQIbM/ddjNuiXMeLkHaF06cuVE8L7k9vampKRfTRaCh
	 MBCXZ8KC3rndUnI62+0IrA+4x5IY7fRFHrg4fzliQb9qJN0K3vf07mX885A0MRI9Zj
	 iUr2cArFS0Dy8HmVjJp+szltNqxCv4EXbuzSe5iQ9vjp40tQOv1abuhiATXOsLgbuH
	 U7a2i1yuTJ2Qw==
Message-ID: <574a8296-1bc5-403f-89fb-fd4cedb57c0f@kernel.org>
Date: Thu, 13 Mar 2025 18:16:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 03/11] nvmet: Add nvmet_fabrics_ops flag to indicate
 SGLs not supported
To: Christoph Hellwig <hch@lst.de>
Cc: Mike Christie <michael.christie@oracle.com>, chaitanyak@nvidia.com,
 kbusch@kernel.org, sagi@grimberg.me, joao.m.martins@oracle.com,
 linux-nvme@lists.infradead.org, kvm@vger.kernel.org, kwankhede@nvidia.com,
 alex.williamson@redhat.com, mlevitsk@redhat.com
References: <20250313052222.178524-1-michael.christie@oracle.com>
 <20250313052222.178524-4-michael.christie@oracle.com>
 <970e0d79-f338-4803-92c4-255156a8257e@kernel.org>
 <20250313091349.GA18939@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250313091349.GA18939@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250313_021613_622397_D74BAD9F 
X-CRM114-Status: GOOD (  11.69  )
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

On 3/13/25 18:13, Christoph Hellwig wrote:
> On Thu, Mar 13, 2025 at 06:02:29PM +0900, Damien Le Moal wrote:
>> On 3/13/25 14:18, Mike Christie wrote:
>>> The nvmet_mdev_pci driver does not initially support SGLs. In some
>>> prelim testing I don't think there will be a perf gain (the virt related
>>> interface may be the major bottleneck so I may not notice) so I wasn't
>>> sure if they will be required/needed. This adds a nvmet_fabrics_ops flag
>>> so we can tell nvmet core to tell the host we do not supports SGLS.
>>
>> That is a major spec violation as NVMe fabrics mandates SGL support.
> 
> But this is a PCIe controller implementation, not fabrics.

Ah ! yes !

> Fabrics does not support PRPs and has very different SGLs from the
> PCIe ones.  The fact that the spec conflates those in very confusing
> ways is one of the big mistakes in the spec.

Yes, and despite tripping on this several times with pci-epf, I did it again :)

pci-epf has code for handling both PCI PRPs and SGL. We probably can make that
common with mdev to facilitate SGL support.


-- 
Damien Le Moal
Western Digital Research

