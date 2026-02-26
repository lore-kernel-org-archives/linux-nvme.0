Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6090DFD9E10
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Feb 2026 21:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5V78a7KYBPGR18Kt/fv8iZJLlU3vIM61eFXQwGjiqmc=; b=zzFlS968vWtxySXeWWGl3JleGD
	T7cez+s1KrVxaSOh/aXSn1JgxdeIHWzmUVwRDxhv/Ls8WPq+Ftc830lFGLlPKBdDiB/oK/gzjwCVT
	hKjKPazJHJdfoDYWR+hwa1/0hqfuBwV31dV7g7VoRI8IxZ92dxlxzfZkPej61Gjs40joJzbjSQKpK
	MRGZcgallNmjVc8MIO7Ns/MeMg9pDItzRnLqYLD/+TTUYtKlMbcRhIDk1/QG9OeFOVIjFEPgbfckZ
	KlME1ERzTyeMe92FIUgNzQE5XnRI/x3NV1Bi7qfJvTMo2fJkwcsfrh6HGW5ltqpA/vvPfFUbNi0ZL
	HRZVMEiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vviVc-00000007C0w-0s9r;
	Thu, 26 Feb 2026 21:02:56 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vviVZ-00000007C0Z-3WEY
	for linux-nvme@lists.infradead.org;
	Thu, 26 Feb 2026 21:02:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 17EBE44027;
	Thu, 26 Feb 2026 21:02:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BEE9C116C6;
	Thu, 26 Feb 2026 21:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772139773;
	bh=MWLJMH0nzhlpF4A4AP+9+udjil156fiY6KfeNtsk5aM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QloXhuXFVxavvv3in9nXJWwIzP02qf6mgoA58Ob0pP+xm42F8ljAioBwjUxywf2DF
	 VvKddF45nI6l6RS/xPmEQnevZKtUBojXnB2aEuLrK6pGHfx2HmOY+TLblpdjVmKPZv
	 pd3Z4XfAvf79ez9OOrgGNR6crEq8Zga9fl6yKj6nwbjgLrReCT8YmoElQ2MDuKxZl6
	 vK2eMKGfMyIUeadOSRu1LazWf60d4s7YFlbdhBogFCBqifBC4rcINyBMkytLb7qN07
	 2qyEgd1W4AAj27iF0MeyjaJ80/uU6ExlF7ghADNxwqathfPe0NMPK4G2zDMx/fYiql
	 Q5CTbkmfe0O8Q==
Date: Thu, 26 Feb 2026 14:02:50 -0700
From: Keith Busch <kbusch@kernel.org>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/8] nvme: always issue I/O Command Set specific
 Identify Namespace
Message-ID: <aaC0-mfU4Q4im-yW@kbusch-mbp>
References: <20260226190416.297725-1-csander@purestorage.com>
 <20260226190416.297725-5-csander@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226190416.297725-5-csander@purestorage.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260226_130253_899864_5991A381 
X-CRM114-Status: GOOD (  10.46  )
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

On Thu, Feb 26, 2026 at 12:04:11PM -0700, Caleb Sander Mateos wrote:
> -	if (ns->ctrl->ctratt & NVME_CTRL_ATTR_ELBAS) {
> -		ret = nvme_identify_ns_nvm(ns->ctrl, info->nsid, &nvm);
> -		if (ret < 0)
> -			goto out;
> -	}
> +	ret = nvme_identify_ns_nvm(ns->ctrl, info->nsid, &nvm);
> +	if (ret < 0)
> +		goto out;

I don't think we can do this identify unconditionally. The controller
has to at least pass nvme_id_cns_ok().

