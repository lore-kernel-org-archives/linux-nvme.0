Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B7DDF433E2
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Apr 2026 05:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=azpXoAenKIP8On2bXkvP2F3WqSe7DygqicGus0IvVBs=; b=pgCdKKv7tJsk8yBrQ3gdRFa7pR
	lmyQRmr3E5ssTHNcehha8n1CrNNnPtuyFgEW3DEqlp5ZkKX42wZzqW0fVXAbKMBKIR+BsI6hxwswP
	juAQ3Nm4x/ws8pB8wE3fODP5UAwie9GmeYusjZLTlqGnizs8WKyrb5Muq7HIjKrMY9M6DlMhb3eXh
	U1UN8Tnevir+Jc+zlBkgwIM9BDqZwHNwPKJ9YHipaccbaz2aW2DIWfdUAkgAjPZaVcEOzK9dLjFz/
	dRe4bzfcjl+pZhDxuNTXbndXVdUxaXUH/+RywGWdQj+IgIW9umMA4r4uGr0ZOeh9qGETtvh+thIDw
	miqJSjLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDF5c-00000001yxP-1Kcl;
	Thu, 16 Apr 2026 05:16:32 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDF5a-00000001ywk-1G1d
	for linux-nvme@lists.infradead.org;
	Thu, 16 Apr 2026 05:16:31 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7115B6732A; Thu, 16 Apr 2026 07:16:27 +0200 (CEST)
Date: Thu, 16 Apr 2026 07:16:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: alistair23@gmail.com
Cc: hare@suse.de, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, kch@nvidia.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v2] nvme-auth: Include SC_C in RVAL controller hash
Message-ID: <20260416051627.GC14802@lst.de>
References: <20260415230824.2790058-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415230824.2790058-1-alistair.francis@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260415_221630_476232_5FA9B4D7 
X-CRM114-Status: GOOD (  11.47  )
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

On Thu, Apr 16, 2026 at 09:08:24AM +1000, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> Section 8.3.4.5.5 of the NVMe Base Specification 2.1 describes what is
> included in the Response Value (RVAL) hash and SC_C should be included.
> Currently we are hardcoding 0 instead of using the correct SC_C value.
> 
> Update the host and target code to use the SC_C when calculating the
> RVAL instead of using 0.

This looks correct.  But I guess this breaks existing implementations
in the wild now?


