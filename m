Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C597C3DA6E
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Jan 2024 17:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fwzzRBr0kjzKYEn+KKJ6U+9cs0DzAMtYBKAghitU+70=; b=CIr4Vx9riEp5N153GO4nXPq/ID
	8kKDkDvjYFM9tWV3Nr7wsDWoqFiMKz6Geukj2lXduQKdWl7qQV08wLzJNvq71QbS0BLjieY8InBhu
	s9w+jlzEwa+60SMfZ2J574yHO7yBGfQft0nOzfS4SumcGSiLx2shJ7Ud5LBMh7ZkWpfUyA4iF6QjB
	wPUhWVwafAWIJiHHFnWVhn/WwB4u0B3m7LJgqBwQfdHU9+nmbxcCFTAECMn+1b3UMTSOV+V/GsF52
	e7/XBlm6lnHQl6FN4DWpw4z8uRBdwE2Tcwtp9hwRfGBY9sXpvSftnuEmBkhn6jys/sPc3V4L7eLga
	TBwTEWGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rMtS9-005kwp-0J;
	Mon, 08 Jan 2024 17:30:21 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rMsIs-005bZ2-2R
	for linux-nvme@lists.infradead.org;
	Mon, 08 Jan 2024 16:16:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 4B80DCE12E3;
	Mon,  8 Jan 2024 16:16:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E7DBC433C8;
	Mon,  8 Jan 2024 16:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704730598;
	bh=9Dqsd2b/tQbITcvrrEjOkpWTLQfCO2iXtwsOMTpyFCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Npz6kshrOwVD5JoChv8U37Th8dzUVBRll3Tb2Rej2fgiQ2QKHSGnZiwIA+Zm8N6jA
	 fEO1O4+kxxpnBHP6ebT/82AWTjg9L4V5jNTwRiaHCB1I0CZ9lppx7nXVTrGIO96DAg
	 Va9vw8GqwlpyOISvhXjwlSxQzElHI01zPLAY/uU5d+K/NwEBybh2TeyjMvvUOy+TBK
	 aU2oWr1SnkHwC1OrA7ZxI8Ufnc4VFvwdRBW/m2OKMUd8CPTECaHxteArjdLQRHjwrw
	 wMBFxstdLX8NG91hMDcfrIuDOzo52KGR1Il42uxaeu2XahcTgK+h00WmmwwFTfYuq6
	 aRkAiSkHsaLZQ==
Date: Mon, 8 Jan 2024 09:16:35 -0700
From: Keith Busch <kbusch@kernel.org>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/2] nvme-rdma: enhance timeout kernel log
Message-ID: <ZZwf46jEVOxfiZtu@kbusch-mbp>
References: <20240107002950.6233-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240107002950.6233-1-mgurtovoy@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240108_081643_001728_D480D094 
X-CRM114-Status: UNSURE (   7.66  )
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

On Sun, Jan 07, 2024 at 02:29:49AM +0200, Max Gurtovoy wrote:
> Print the command_id along side blk-mq's tag to help match commands with
> protocol wire traces and logs.
> 
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>

Thanks, applied both to nvme-6.8.

