Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BF64CCF9F8
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Oct 2025 14:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fTsV/l1k8sdaYqmHiTe9Uv3fTj6nWJalIaDKBUggYIM=; b=SNDwbDukNSvQlhGTc0DyIw9Hmh
	jgYSXic5+2wcqmd7StL1H0x7+pgGpGZlykOKbfXv+JZpTf7kxfkhgqs8nsg675AXwZcJ/yPuvZ0/o
	VTGUyKsfw0f3tp2QYyXtzQ+XJOViJsNASFEAI5yiLpzy8kz6n/Zuk6hJNqeCOk/qJ0pauw6MD5VGn
	36jXZS2XpXLMKTilntVts6BGgLd1VlyrTO8n3mQ+zqzCBbFyDeRw1FyUe21JubBHoIpLLvcW6C5JN
	YALLAewuaBzpg032FbeQSWbD/iWeRXcEA8sO49/vcMg/4CvbQbUq1OnUrxso4Fu8H7wsyBLOLk2am
	F/JxCGQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEpip-00000006CB0-1wmE;
	Fri, 31 Oct 2025 14:03:19 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEpim-00000006CAU-1o2M
	for linux-nvme@lists.infradead.org;
	Fri, 31 Oct 2025 14:03:18 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E9B23227A88; Fri, 31 Oct 2025 15:03:10 +0100 (CET)
Date: Fri, 31 Oct 2025 15:03:10 +0100
From: Christoph Hellwig <hch@lst.de>
To: alistair23@gmail.com
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	hare@suse.de, kch@nvidia.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH 2/3] nvmet-tcp: Don't free SQ on authentication success
Message-ID: <20251031140310.GA17006@lst.de>
References: <20251030035114.16840-1-alistair.francis@wdc.com> <20251030035114.16840-3-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030035114.16840-3-alistair.francis@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251031_070316_632651_532FBEA1 
X-CRM114-Status: GOOD (  14.43  )
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

On Thu, Oct 30, 2025 at 01:51:13PM +1000, alistair23@gmail.com wrote:
> Curently after the host sends a REPLACETLSPSK we free the TLS keys as
> part of calling nvmet_auth_sq_free() on success. This means when the
> host sends a follow up REPLACETLSPSK we return CONCAT_MISMATCH as the
> check for !nvmet_queue_tls_keyid(req->sq) fails.
> 
> This patch ensures we don't free the TLS key on success as we might need
> it again in the future.

I initially though we'd now keep it around for the lifetime of the
queue, but I think we'll still free it from nvmet_execute_auth_send,
right?


