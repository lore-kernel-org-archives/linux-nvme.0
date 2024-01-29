Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 926C2C47DDB
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jan 2024 15:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uVabQCyMvSGTHoEdj2Gw9dOwWOACyG1u08uWcphW994=; b=sa7ROihgM1pLf+BpdTlPdA2dZM
	0+Afr/t6rV4zRnGKAayqIlICsT/X3Cy2fTLGMM3uj5uKjqZvBrJksMofd4P0EQ7vux44v2RgbR4Dp
	NO2zMDEzH2Um7N7iNdamjvdHuTVX1U7dgsEFwWYVl/gSFLMi8zstKxzhBM3Qsb4UoDwHStR79LdtE
	xQm92YMIAOC/pN18H6J3/Vl30iPo5sli27lEZGZz1l7JqiTdRvp0CW2F0u/7SH1+UwZnIjk1fh380
	ptNQIl0HYHou+3IGfzYxBzxXHvqBlmJEcdfp6QQ1AMQ7QX97Q9CJFK974VTTUZvjdh+s1b2TWM+Vy
	8JrU2i7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUTKV-0000000DDYS-0b3Z;
	Mon, 29 Jan 2024 15:13:47 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUTKT-0000000DDXo-1QKC
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jan 2024 15:13:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id CFAEC6215C;
	Mon, 29 Jan 2024 15:13:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25566C433C7;
	Mon, 29 Jan 2024 15:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706541224;
	bh=fTWd4CygEUdqi4/GkYhUtppfaaN82BqDvJYhgDq3438=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JyS3AHhvNOliAbca9Vok4SsMMEPwPw/UJ5NYXYh4lLHATvDdwTEKKYSD1yeF2NSPj
	 PI07QOF25QYdWJ4mOX9nY2gEnlcpDcn+MDEgTvybxFE6Pw0h7gBheOEQAJvnq1Jbwx
	 yxfJxZUWhPZrwTHhu6681MNNU86zgLWMqG8Q9g8RRprKx20QnUuXlNJrr1p/n/mN4V
	 HS8FdKf0+Q0CelknXuYD+w0nye49qjs4Leksc2a9y2dPkTxOJv6+QsF3FEelkfrDC3
	 FzxvrZ4OwZ1vRkSouvCr518plK2wnp0jLylOIb60LjLISj8B70yWex8fRl8dSkk8+t
	 8SkL3aJW2MbYg==
Date: Mon, 29 Jan 2024 08:13:42 -0700
From: Keith Busch <kbusch@kernel.org>
To: hare@kernel.org
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 1/3] nvme-auth: open-code single-use macros
Message-ID: <ZbfApnvCAQVw_vMD@kbusch-mbp>
References: <20240127093746.40246-1-hare@kernel.org>
 <20240127093746.40246-2-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240127093746.40246-2-hare@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240129_071345_443495_4D6DE326 
X-CRM114-Status: UNSURE (   8.28  )
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

On Sat, Jan 27, 2024 at 10:37:44AM +0100, hare@kernel.org wrote:
> From: Hannes Reinecke <hare@suse.de>
> 
> No point in having macros just for a single function nvme_auth_submit().
> Open-code them into the caller.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>

Thanks, applied for nvme-6.8.

