Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 732C8C28B28
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Mar 2025 06:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z+M7T5+oesBRFEivtacNct45Um0/S+YIRwesyjMdhZ0=; b=2uqGx0fM5HFUUiI1plcuDyLL63
	qMB5qkl1SkAseL9e7y2OxS0ZYyhy5BihYlEgihuHnARVUePwix8MAnv+Bdc2IIQBU14Hb9YtoNGvH
	2Jx9LXAbt8e3yNASSlMpTEioeEZQu/wUfSaOQ1Q6cAFIXCRKJeM7dA0hHdB3AdzQh2Tws0/73Zi1n
	o4Pe4Dpc543U/fuwraAV5ll+y3CgeJwRwfElFiHb6lbqdmBLyhD/zHBX2v2bZQe2vcPSAgV5pRrQO
	ybGd/+zf2uAc0K7QvAMHkWWSu5QP7aypDIBAah8OuwAfZ3xLDfc2ebsnjxWT4zcEL5FWKVejpEnHK
	YJ4D+8qA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tscD8-0000000AEjq-43hn;
	Thu, 13 Mar 2025 06:38:30 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tscCD-0000000AEeG-3vmP
	for linux-nvme@lists.infradead.org;
	Thu, 13 Mar 2025 06:37:35 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9503D68C4E; Thu, 13 Mar 2025 07:37:30 +0100 (CET)
Date: Thu, 13 Mar 2025 07:37:30 +0100
From: Christoph Hellwig <hch@lst.de>
To: Mike Christie <michael.christie@oracle.com>
Cc: chaitanyak@nvidia.com, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	joao.m.martins@oracle.com, linux-nvme@lists.infradead.org,
	kvm@vger.kernel.org, kwankhede@nvidia.com,
	alex.williamson@redhat.com, mlevitsk@redhat.com
Subject: Re: [PATCH RFC 03/11] nvmet: Add nvmet_fabrics_ops flag to
 indicate SGLs not supported
Message-ID: <20250313063730.GC9967@lst.de>
References: <20250313052222.178524-1-michael.christie@oracle.com> <20250313052222.178524-4-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313052222.178524-4-michael.christie@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250312_233734_230519_3B7FAB86 
X-CRM114-Status: GOOD (  14.04  )
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

On Thu, Mar 13, 2025 at 12:18:04AM -0500, Mike Christie wrote:
> The nvmet_mdev_pci driver does not initially support SGLs. In some
> prelim testing I don't think there will be a perf gain (the virt related
> interface may be the major bottleneck so I may not notice) so I wasn't
> sure if they will be required/needed. This adds a nvmet_fabrics_ops flag
> so we can tell nvmet core to tell the host we do not supports SGLS.

I'd prefer to be able to support SGLs if we can, but if not I could
live with a flag of some sort.


