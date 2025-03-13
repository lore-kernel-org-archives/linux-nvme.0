Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61FD2C282DE
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Mar 2025 09:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J1CSL8MkKQdWfg0Y4QHdJPUDM32Tmee/m9tSlQwZ+V4=; b=nm+khOORcMo6nb3Dm+LyS6Rush
	jkF963CoehwC75WK9IUvifvvImWUqXLuCQnjsx6OXoi5qDDVrW/REH9lufgpQu/Ftncdalk3TUKR1
	V91jv0M6te0PPoYYncsys1cTsMEocWd0arlqR5+ach4GZk17E695GgIxST/nV89nk0wSbGKQXJrSs
	mcKYhUFg/XGpSGqv6kGUFqadbl138aPg9/DjDMnx4h3PfdHOchir4faK2wMcSA1jcqEeYm/tuOwgg
	RSs3QOg6liUoTsAb227+H5Vmu+RhLMUyx2dXmx6pshM/1xpskSDJvELnQZ2/C2uCjRGKPUafLpv4w
	JM4Nbd8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tsefB-0000000AhGM-3Luo;
	Thu, 13 Mar 2025 09:15:37 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tsedX-0000000AgwZ-0iJF
	for linux-nvme@lists.infradead.org;
	Thu, 13 Mar 2025 09:13:56 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3D72568AA6; Thu, 13 Mar 2025 10:13:49 +0100 (CET)
Date: Thu, 13 Mar 2025 10:13:49 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Mike Christie <michael.christie@oracle.com>, chaitanyak@nvidia.com,
	kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	joao.m.martins@oracle.com, linux-nvme@lists.infradead.org,
	kvm@vger.kernel.org, kwankhede@nvidia.com,
	alex.williamson@redhat.com, mlevitsk@redhat.com
Subject: Re: [PATCH RFC 03/11] nvmet: Add nvmet_fabrics_ops flag to
 indicate SGLs not supported
Message-ID: <20250313091349.GA18939@lst.de>
References: <20250313052222.178524-1-michael.christie@oracle.com> <20250313052222.178524-4-michael.christie@oracle.com> <970e0d79-f338-4803-92c4-255156a8257e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <970e0d79-f338-4803-92c4-255156a8257e@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250313_021355_353349_EEB7775C 
X-CRM114-Status: GOOD (  14.53  )
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

On Thu, Mar 13, 2025 at 06:02:29PM +0900, Damien Le Moal wrote:
> On 3/13/25 14:18, Mike Christie wrote:
> > The nvmet_mdev_pci driver does not initially support SGLs. In some
> > prelim testing I don't think there will be a perf gain (the virt related
> > interface may be the major bottleneck so I may not notice) so I wasn't
> > sure if they will be required/needed. This adds a nvmet_fabrics_ops flag
> > so we can tell nvmet core to tell the host we do not supports SGLS.
> 
> That is a major spec violation as NVMe fabrics mandates SGL support.

But this is a PCIe controller implementation, not fabrics.

Fabrics does not support PRPs and has very different SGLs from the
PCIe ones.  The fact that the spec conflates those in very confusing
ways is one of the big mistakes in the spec.


