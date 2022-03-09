Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFCFDC433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Mar 2022 06:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C241Z/9adrX22NRVQpdMYJ5jQauQtAB5PDEIPe9rD1Y=; b=pp0wbllQuZK+Km4UaK2IxkQpkS
	pphciPw/PR4Z3fYJBCcBzDNgKNNTh0lhsUNYtzNvKdeouxYbiGvBi4FB8Adi+54hOebKq8BFB1BXy
	EX9Mw4Cj19EEUpTh7l/IgJCeMXtq1p27wBMqvlaJ4o5BD0vQNR0xzL+xiZVVkPizNUFJVdp01MRXL
	awMByyXyggU1VONtNOd2B+4NDM1Yt6qwOTuFXYU+KPwM/ZNpriEvSHiJaQgSNQePANQkdXSb4ku1G
	ilasvbFjXvMLvQmLH3UDK/jS08MpSfr8xv7FEZ8aCYz8WrdNxuuxFQdA803oXK3zhXKI52mmKXBS8
	SN3Tes9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nRpbv-007U0f-01; Wed, 09 Mar 2022 06:15:47 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRpbs-007Tzt-BH
 for linux-nvme@lists.infradead.org; Wed, 09 Mar 2022 06:15:45 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 9454468AFE; Wed,  9 Mar 2022 07:15:41 +0100 (CET)
Date: Wed, 9 Mar 2022 07:15:41 +0100
From: Christoph Hellwig <hch@lst.de>
To: Mingbao Sun <sunmingbao@tom.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, tyler.sun@dell.com, ping.gan@dell.com,
 yanxiu.cai@dell.com, libin.zhang@dell.com, ao.sun@dell.com
Subject: Re: [PATCH v2 1/2] nvmet-tcp: support specifying the
 congestion-control
Message-ID: <20220309061541.GB31316@lst.de>
References: <20220309053711.2561-1-sunmingbao@tom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309053711.2561-1-sunmingbao@tom.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220308_221544_575864_BD436B2B 
X-CRM114-Status: GOOD (  13.50  )
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

On Wed, Mar 09, 2022 at 01:37:11PM +0800, Mingbao Sun wrote:
> +		if (port->nport->tcp_congestion) {
> +			icsk_new = inet_csk(newsock->sk);
> +			if (icsk_new->icsk_ca_ops != icsk->icsk_ca_ops) {
> +				pr_warn("congestion abnormal: expected %s, actual %s.\n",
> +					icsk->icsk_ca_ops->name,
> +					icsk_new->icsk_ca_ops->name);
> +			}
> +		}

What is the point of having this code?

> +	if (nport->tcp_congestion) {
> +		strncpy(ca_name, nport->tcp_congestion, TCP_CA_NAME_MAX-1);
> +		optval = KERNEL_SOCKPTR(ca_name);
> +		ret = sock_common_setsockopt(port->sock, IPPROTO_TCP,
> +					     TCP_CONGESTION, optval,
> +					     strlen(ca_name));
> +		if (ret) {
> +			pr_err("failed to set port socket's congestion to %s: %d\n",
> +			       ca_name, ret);
> +			goto err_sock;
> +		}
> +	}

Same comment as for the host side.

