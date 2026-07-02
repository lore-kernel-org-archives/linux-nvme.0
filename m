Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD95BC43458
	for <linux-nvme@archiver.kernel.org>; Sat,  4 Jul 2026 15:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PYV85AvFz4rVWO3U/hhUvMvhuqB8LpaELOR2jS/qchU=; b=RA9S0LhhtWHfp3OLTUpk2vnslo
	trEH/xqYUBFYOP+XNdWMzZY6XfDqWKIcVHRa1r4URuPxKqSX+guItnnhdLFJ8kT3HN/Rio0e6ll6l
	n9WlvFM1E+4r0WGTb9gULVg0Ncr2yXIJoqlRtUjFKu0IQePrDzaT1uBLEsF6YE3P3Al8tlqpmFOPp
	4M9ULYg+RcWNw+KmJIwoJ5hA8iY/HZdWw4hoUhDlypd60YYTuGMPSEvJU9mZk9w3/Ej6nhUYxScyB
	jzGz4ZZdv1RBr6Qt6K5p8fDSFG6x09XwB63QqDobrvryorIonNBOssgdOiSkA84qcx4jGQsjASPTL
	Z7rOBIKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wg21P-00000008Wql-0PVI;
	Sat, 04 Jul 2026 15:11:11 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfAWX-00000003cZ8-3vMg
	for linux-nvme@lists.infradead.org;
	Thu, 02 Jul 2026 06:03:47 +0000
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 3C67320B7169; Wed,  1 Jul 2026 23:03:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3C67320B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1782972223;
	bh=PYV85AvFz4rVWO3U/hhUvMvhuqB8LpaELOR2jS/qchU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YWiewduxaLuWS7rWYB1zlKBpG5aA+R24KUAH3I597I72uX/KPA1VykdQbrEWWP7Np
	 ZMXqOfd63PnLfEHvY9exzPQkrEBt5b65twR2m+gfSW+EACtewSCu18K92iq1eEb6eo
	 23jCh8m24d9IZdFNVnC3LvCe85f6mAfC0hsWpNZs=
Date: Wed, 1 Jul 2026 23:03:43 -0700
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	mkalderon@marvell.com, zyjzyj2000@gmail.com, sagi@grimberg.me,
	mgurtovoy@nvidia.com, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
	bvanassche@acm.org, kbusch@kernel.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, kch@nvidia.com, smfrench@gmail.com,
	linkinjeon@kernel.org, metze@samba.org, tom@talpey.com,
	trondmy@kernel.org, anna@kernel.org, chuck.lever@oracle.com,
	jlayton@kernel.org, neil@brown.name, okorniev@redhat.com,
	Dai.Ngo@oracle.com, achender@kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, kees@kernel.org, markzhang@nvidia.com,
	andriy.shevchenko@linux.intel.com, ebadger@purestorage.com,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	target-devel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
	linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
	rds-devel@oss.oracle.com
Cc: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH rdma-next v8] RDMA: Change capability fields in
 ib_device_attr from int to u32
Message-ID: <akX/P/0TiSQ38YdS@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260619203107.606359-1-ernis@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260619203107.606359-1-ernis@linux.microsoft.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260701_230346_002634_BF02AADE 
X-CRM114-Status: GOOD (  11.63  )
X-Mailman-Approved-At: Sat, 04 Jul 2026 08:11:05 -0700
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

On Fri, Jun 19, 2026 at 01:30:39PM -0700, Erni Sri Satya Vennela wrote:
> The capability counter fields in struct ib_device_attr are declared
> as signed int, but these values are inherently non-negative. Drivers
> maintain their cached caps as u32 and assign them directly into these
> int fields; if a cap exceeds INT_MAX the implicit narrowing yields a
> negative value visible to the IB core.
> 
> Change the signed int capability fields to u32 to match the
> underlying nature of the data. Also update consumers across the IB
> core, ULPs, NVMe-oF target, RDS, and NFS/RDMA so the new u32 values
> are not forced back through signed int or u8 via min()/min_t() or
> narrowing local variables.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> Acked-by: Stefan Metzmacher <metze@samba.org> # smbdirect


Hi,

Just a friendly follow-up on this patch. The Sashiko review mentioned a
low-priority item, and I'd appreciate any guidance on whether the change
is needed.

https://sashiko.dev/#/patchset/20260619203107.606359-1-ernis%40linux.microsoft.com

Thanks,
Vennela

