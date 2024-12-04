Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30CB7E7716D
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Dec 2024 18:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b49O+l9C4wQIH3G6dPMCa47Lsdo6M7Y0NHPZTUXt1RQ=; b=jflhvp2AXJEw6kcG110S+AkTaI
	ypLnLZpjzsf8A7j48wP2xG80MQTyONMJq0NOkyj3gM2jntqMAzQtMMqIM4hNv5c9m8Ol2VliWIS+0
	Q+IKE0lGBSyP3sPCQYvHALCGokrBi9ADE8HNXX/d6ml5pLPNneLAIawXszCYzYG7uIUyTV0qIxjfA
	SJp2ri6HhETsV8Ooz1Uf8KkwvE3Ixw8fbmckpCpHp8fZTpZDY7d+eMMSs2RgoxU41JCzY23MeMgoR
	9qcxhcDR0yeeTPo4exUoXFmi1LcIBuW88++BHwBBdX0raLytzYOc3uz5OALc5hs8PUiXLM0+KSHtJ
	QyfYynPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tItza-0000000DW5H-3KUK;
	Wed, 04 Dec 2024 18:20:54 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tItzY-0000000DW4c-3m6t
	for linux-nvme@lists.infradead.org;
	Wed, 04 Dec 2024 18:20:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 6CF325C6E77;
	Wed,  4 Dec 2024 18:20:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9A8BC4CECD;
	Wed,  4 Dec 2024 18:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733336452;
	bh=vTfYTgZ2HhDd4sDtskxxkSPUDGOGE1J5hwe4gG5aidY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=czlmAW6m49YwIa0dmF44ABJYMThfiWonKWE4fH4ajYEVKHWTqq5afkrnCeCf5t1zT
	 WpErwprZJhloUtz0eTzBPL9l20imOZUAQ6ls/+xrBbODwRrFD6FMvb2N2uuKBn+m+b
	 GTvxffUFtylKZXDUVaUcRPKuGcszM+56t8/Emr387fWGWlio6GE2oK8tmwEwxHCdVS
	 MRSA3/B5pAvj5+59TZj83MLkWSXT4t1o/+WmcRmDY11cq6Ii/IhcJ37iWEajzkCFmr
	 mZ+L2FpuaQ7ZKFP2w6dHuHR7QKvHqPMJJsiL2rr5olTRvGKWaGPARE4QF3WhgLEob0
	 SUrHcj+euDzgA==
Date: Wed, 4 Dec 2024 10:20:49 -0800
From: Keith Busch <kbusch@kernel.org>
To: "brookxu.cn" <brookxu.cn@gmail.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	hare@suse.de, lengchao@huawei.com
Subject: Re: [PATCH v3 0/4] nvme: various bugs fix & code cleanup
Message-ID: <Z1CdgbZr9a8WbW1b@kbusch-mbp>
References: <cover.1733196360.git.chunguang.xu@shopee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1733196360.git.chunguang.xu@shopee.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241204_102052_978919_ABEF81DD 
X-CRM114-Status: UNSURE (   8.21  )
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

On Tue, Dec 03, 2024 at 11:34:39AM +0800, brookxu.cn wrote:
> From: "Chunguang.xu" <chunguang.xu@shopee.com>
> 
> Here try to fix the hang issue of nvme-rdma, memory leak issue of
> nvme-tcp, and cleanup the relative code of nvme-tcp.

Thanks, applied to nvme-6.13.

