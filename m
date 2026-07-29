Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14EFAC54F51
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2026 11:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JfhWQUqUPdz6kV8dxaF6B8xA/Xo/klLW1FjvnEGZscw=; b=E4CpbA7gpLyKkEAyZAG/n7vz8r
	oqXXySjHFI5MwNN2i/hLMNjncqXWQQVy3WhqB0K9bqt8l2EgdZZzNvO8V88zrlHpapVwadESbbeq0
	EjAE8NUbWNnBh2Bv2t/pFr7sGJgq7nJ843KU1ZzMrSj/ggBARyVuQpv03mX+yjOggMGAtOkbz03JM
	Cvsub/214tmm3RxuBj6x62Sa2CQZIflN2weiJQFtxzzoKTDUSng1INTggZ5oTz7zPQbLTy3auo+9k
	hVWKDUTYyM6hc80n/bpMQTkoaScr6g2ynYRSqA4l3ZjxmQQNswQTOHhZmXavYO/hNtowB60dCdUIC
	PkY5R7cw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp2Wc-00000007jfa-3Gz2;
	Wed, 29 Jul 2026 11:32:38 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp2Wa-00000007jdv-143h
	for linux-nvme@lists.infradead.org;
	Wed, 29 Jul 2026 11:32:37 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7A76468BEB; Wed, 29 Jul 2026 13:32:32 +0200 (CEST)
Date: Wed, 29 Jul 2026 13:32:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/4] nvmet: fix return status of RMI log page on
 allocation failure
Message-ID: <20260729113231.GA31402@lst.de>
References: <20260729105607.1398478-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729105607.1398478-1-kanie@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260729_043236_439748_55BF09EE 
X-CRM114-Status: GOOD (  14.30  )
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

On Wed, Jul 29, 2026 at 06:56:07PM +0800, Guixin Liu wrote:
> nvmet_execute_get_log_page_rmi() leaves 'status' holding NVME_SC_SUCCESS
> (set by the successful nvmet_req_find_ns() call) when the kzalloc() for
> the log buffer fails. It then jumps to the out label and completes the
> request with a success status, so the host is told the command succeeded
> while no data was transferred.
> 
> Initialize 'status' to NVME_SC_INTERNAL, matching the smart log handler,
> so an allocation failure is reported as an internal error.
> 
> Fixes: 5fd075cdaf36 ("nvmet: implement rotational media information log")
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


