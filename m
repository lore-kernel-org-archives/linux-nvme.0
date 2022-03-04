Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C46CC433F5
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Mar 2022 16:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f9TfYFBy8x97IUX7Dm+UWlv/3E6eng4u8b2NHglQaA0=; b=SAZ3Z1rqIr7FoSLcU2uDEqSabG
	FtcezVXNfFfdWO94FZxlMUm7MT4oPmHNvAW7O7AuH72v6kbfMhVDFLpqGeDpPfQNairXCCE5wH5OT
	ZVL+5ThuUP7clVHwtN7gygE/pp2JIeza7pxiTDHf3chDxemkdRQXt02NXogglWNgS5iG2qy0Xtvuw
	FYlqiasyRAMKLp09IGB3Cz5mlFPtJmAJHXay4ThoGtXzl1ZpS0BfwA0jbg1cXokAV2m/HMFCEhD/9
	3uFIRDDxfW48gvTzZXge+ZyLzOEsXzURu2BZVN0MCCa3rEDb7VMLcoxucJ4e8H6WTV+5/Ts7Ytmtw
	q6sHRCzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nQAr6-00B4JP-Lm; Fri, 04 Mar 2022 16:32:36 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nQAfX-00Azye-5G
 for linux-nvme@lists.infradead.org; Fri, 04 Mar 2022 16:20:40 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 836D168AFE; Fri,  4 Mar 2022 17:20:32 +0100 (CET)
Date: Fri, 4 Mar 2022 17:20:32 +0100
From: Christoph Hellwig <hch@lst.de>
To: Mingbao Sun <sunmingbao@tom.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, tyler.sun@dell.com, ping.gan@dell.com,
 yanxiu.cai@dell.com, libin.zhang@dell.com, ao.sun@dell.com
Subject: Re: [PATCH 2/2] nvme-tcp: support specifying the congestion-control
Message-ID: <20220304162032.GA12250@lst.de>
References: <20220304092754.2721-1-sunmingbao@tom.com>
 <20220304092754.2721-3-sunmingbao@tom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304092754.2721-3-sunmingbao@tom.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220304_082039_405048_ADB4B4FB 
X-CRM114-Status: GOOD (  12.26  )
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

I'll let the NVMe/TCP maintainer comment on the actual functionality,
but:

> +			p = match_strdup(args);
> +			if (!p) {
> +				ret = -ENOMEM;
> +				goto out;
> +			}
> +
> +			key = tcp_ca_get_key_by_name(NULL, p, &ecn_ca);
> +			if (key == TCP_CA_UNSPEC) {
> +				pr_err("congestion control %s not found.\n",
> +				       p);
> +				ret = -EINVAL;
> +				kfree(p);
> +				goto out;
> +			}

We can't just call networking code from nvme-fabrics.ko

