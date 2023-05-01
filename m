Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 014EBC77B73
	for <linux-nvme@archiver.kernel.org>; Mon,  1 May 2023 04:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5cz2+0p4eQcn4y1bOt2oQ7Xu0gnBM4y2AV3SN6I2FRQ=; b=dA7BHW4XnWNuJAn1Pr6lEJjyDT
	+fp+BrTXf3xNjEpf9JQVkBYK3DaZEcUlPPxxh7Vw6Ubavy9O2n4ShAzXW1f357oITaKDQxYbi+Hel
	4DJh92Swd+U74LdWVH3asVHlA9ec1YqhUfRcJAlXrfWsPa0qOnShDov7SXbLuXe16SVyYz0fpVEc3
	ujgq1WqN1s2FPB7KrCJ6fzASyIi8OsDVOyXm4g+DdVNHe4KAfa+86jKHPWUZou84QNyUOwVks24uy
	K87GxuwWiLMIx/wYKB179kuLo3l6z52K/skxVLw4ZeF78KMvKVHO9YvrOV169ZBPCHmNrGw+75sYr
	qjhkHfLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ptLCC-00FEhW-0T;
	Mon, 01 May 2023 04:31:28 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptLC9-00FEgd-2H
	for linux-nvme@lists.infradead.org;
	Mon, 01 May 2023 04:31:26 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id F3A6668B05; Mon,  1 May 2023 06:31:22 +0200 (CEST)
Date: Mon, 1 May 2023 06:31:22 +0200
From: Christoph Hellwig <hch@lst.de>
To: Breno Leitao <leitao@debian.org>
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	asml.silence@gmail.com, axboe@kernel.dk, ming.lei@redhat.com,
	leit@fb.com, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, sagi@grimberg.me, joshi.k@samsung.com,
	hch@lst.de, kbusch@kernel.org
Subject: Re: [PATCH v3 4/4] block: ublk_drv: Add a helper instead of casting
Message-ID: <20230501043122.GC19673@lst.de>
References: <20230430143532.605367-1-leitao@debian.org> <20230430143532.605367-5-leitao@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230430143532.605367-5-leitao@debian.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230430_213125_887179_56142908 
X-CRM114-Status: GOOD (  14.57  )
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

On Sun, Apr 30, 2023 at 07:35:32AM -0700, Breno Leitao wrote:
> ublk driver is using casts to get private data from uring cmd struct.
> Let's use a proper helper, as an interface that requires casts in all
> callers is one asking for bugs.
> 
> Suggested-by: Christoph Hellwig <hch@lst.de>

No, I've not suggested this.

> +static inline struct ublksrv_ctrl_cmd *ublk_uring_ctrl_cmd(
> +		struct io_uring_cmd *cmd)
> +{
> +	return (struct ublksrv_ctrl_cmd *)cmd->sqe->cmd;
> +}

I've two times explained we need a core io_uring helper to remove this
casting in the drivers, and I've explained how to do that and provided
the actual code for it.

