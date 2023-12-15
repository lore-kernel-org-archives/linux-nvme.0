Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B68C6C4332F
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Dec 2023 02:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AviTXl/afhNzVf/l/GH3Bxa40haso/vNmOCR0HrEamI=; b=Pwh5fdGO32Yf+c8kAjmyrvBD38
	uFIBOs8qc19I7oA8ruMp1PKYa8T7MLKTXiYX2/X7+FqPJzhSlAVBIeRhEF6emixqsBMVxQi8+crpU
	+lU5++lR6AahG5tY1dliP9d4QcN+Bvg6+CQNZ0kdLH5lTO1FgXzo7v8Llj/caxswM6JeSuQ+Qt1DG
	jrXmo852lXozYdjYfbY2mzUIGW9OWCpOahKX4i3Ek9loOE98zpU32xYWUK7RVTKYnrVR/VS9cUyHt
	9pVQWiwqYNFAX8dTQu/Yp5AGYBwX0461TArNy89Ar9CgoQSM4D33QI57XvkRddN0gGj0nIfAJMZCT
	Tcj0BCaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDxfw-001lRJ-2O;
	Fri, 15 Dec 2023 02:11:40 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDxft-001lQB-1R
	for linux-nvme@lists.infradead.org;
	Fri, 15 Dec 2023 02:11:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 1E8E0CE25C1;
	Fri, 15 Dec 2023 02:11:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DC35C433C8;
	Fri, 15 Dec 2023 02:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702606290;
	bh=gSlmGvXM7l3usEJEqGEgLaxe+8FR8knxzpms6VTa6JY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Zzr7Tp2D62n7lK7uX67SV+L29ZquMUZ1OddGbCy1WuAGxQzL9QCSnNgmbGvvIteez
	 4dmf6mfuAQO20ug44VL6IKvqgue4V8GZIlqnf9ip5wr0LODls4WiMX7+6tTRuYgBdp
	 J3DaSkvYzxJcjO2cDFmHlkIDlD0JNV07/RFD72Z18dlrZkVNSqSilhR4saSA1Bfzjw
	 oaJBdZ0KCzTgzweiAyMyuaxTtI9wgMjd+CNQ4SirBrOOBxtQBX254bQ/I/KM7mCp5H
	 dcvIkulWD7tcsttNuZL9/Xe490kP978uKPhy17M2Ex3EEforbfA/jXQ0eLWS+RzoPq
	 9WzR83k5H3mBQ==
Date: Thu, 14 Dec 2023 18:11:28 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 sagi@grimberg.me, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, borisp@nvidia.com, galshalom@nvidia.com,
 mgurtovoy@nvidia.com, edumazet@google.com, pabeni@redhat.com,
 john.fastabend@gmail.com, daniel@iogearbox.net
Subject: Re: [PATCH v21 04/20] net/tls,core: export get_netdev_for_sock
Message-ID: <20231214181128.63793cdc@kernel.org>
In-Reply-To: <20231214132623.119227-5-aaptel@nvidia.com>
References: <20231214132623.119227-1-aaptel@nvidia.com>
	<20231214132623.119227-5-aaptel@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231214_181137_673258_ABB6014D 
X-CRM114-Status: UNSURE (   8.02  )
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

On Thu, 14 Dec 2023 13:26:07 +0000 Aurelien Aptel wrote:
> -struct net_device *netdev_sk_get_lowest_dev(struct net_device *dev,
> -					    struct sock *sk)
> +struct net_device *get_netdev_for_sock(struct sock *sk)
>  {
> -	struct net_device *lower;
> +	struct dst_entry *dst = sk_dst_get(sk);
> +	struct net_device *dev, *lower;
>  
> -	lower = netdev_sk_get_lower_dev(dev, sk);
> -	while (lower) {
> +	if (unlikely(!dst))
> +		return NULL;
> +	dev = dst->dev;
> +	while ((lower = netdev_sk_get_lower_dev(dev, sk)))
>  		dev = lower;
> -		lower = netdev_sk_get_lower_dev(dev, sk);
> -	}
> -
> +	dev_hold(dev);
> +	dst_release(dst);
>  	return dev;
>  }
> -EXPORT_SYMBOL(netdev_sk_get_lowest_dev);
> +EXPORT_SYMBOL_GPL(get_netdev_for_sock);

Since the use of this helper is now spreading we should
switch it to netdev_hold and have the caller pass in a
netdevice_tracker.

