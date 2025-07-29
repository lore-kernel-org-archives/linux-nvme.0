Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F3E5C83F26
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Jul 2025 15:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ii4FWIu74YKkDvpVcHUcW7v5zdke4bfoXONzF6nlr60=; b=RrGywx4YnB4ElObXPe5mBnM0du
	6dF/Z2CWI/Vr6EuWCwba7qNdQZn+u1Jd6MTTKIzSSGZ2GKMFDc9lGMIdJgE5wm7pdSTaPDXM4pgEG
	VwgU45rOb4xogWLpJejAAGV8WkacTejX+xe23G3uObIzTmxQrlNJbq/XHyt7oVII3pmEyS6acitLg
	JKtTH7VbeSDF1/8FmIPIXDfrF0kWRkaZDuJ4CHasddv7XolMXWA4np6DZRleSjUXTAe/n3prFZdj8
	gWEtFVl7LRRZR9JgTrklTOIyV7DgzOmH6YpFPltbYxck2A30KNLOPRusTWDHSnCM2bMVlj7F42ra3
	Nlwt7o8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uh94T-00000001sV9-2IsO;
	Wed, 30 Jul 2025 15:50:25 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugfSU-0000000GDWj-0ccN
	for linux-nvme@lists.infradead.org;
	Tue, 29 Jul 2025 08:13:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 78BB5A5205F;
	Tue, 29 Jul 2025 08:13:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4287C4CEEF;
	Tue, 29 Jul 2025 08:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753776793;
	bh=iau6CFRPvo+1rErnYbUShzPk5E8wZpMfdzXyHGYM0go=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TCUlRsbw4eKHsMvwqqMw0QZp5VHfQ1kjTeMRX270ZFQs7lZR0DACV5S2YM21RYIw6
	 D5ZAYt74Qv7QNAHQjNoe8zrC+B1dpE8tzyAbn6hTCnx0TFaJK7FYvrUNhpBrs8RRvU
	 nsc0c3zSvuS3MANsYjJX2X/QxQwNa5zuqLLs6lIEbFjFHGi6k1h6Cb/W1hH815Fqx4
	 ZYKfp2VbzN0toadJ7p3gvmOnUpA8orp5eVtqUc3CHyTpX5W/IBimOkLaBSUswjlIER
	 yPJRM7FY5MxuiKYcdpcwAAG3Bs0UtRij6a4BCXV+6Q+dfS9wmoj63b+JF84L/8Yshk
	 q7lYQ9pkvbx8g==
Message-ID: <8ce2c9ce-9636-4888-8d63-2169441addcb@kernel.org>
Date: Tue, 29 Jul 2025 17:13:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/4] net/tls/tls_sw: use the record size limit specified
To: Wilfred Mallawa <wilfred.opensource@gmail.com>, alistair.francis@wdc.com,
 chuck.lever@oracle.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 donald.hunter@gmail.com, corbet@lwn.net, kbusch@kernel.org, axboe@kernel.dk,
 hch@lst.de, sagi@grimberg.me, kch@nvidia.com, borisp@nvidia.com,
 john.fastabend@gmail.com, jlayton@kernel.org, neil@brown.name,
 okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com, trondmy@kernel.org,
 anna@kernel.org, kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>
References: <20250729024150.222513-2-wilfred.opensource@gmail.com>
 <20250729024150.222513-5-wilfred.opensource@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250729024150.222513-5-wilfred.opensource@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250729_011314_256532_DADA3441 
X-CRM114-Status: GOOD (  14.42  )
X-Mailman-Approved-At: Wed, 30 Jul 2025 08:35:22 -0700
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

On 7/29/25 11:41, Wilfred Mallawa wrote:
> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> 
> Currently, for tls_sw, the kernel uses the default 16K
> TLS_MAX_PAYLOAD_SIZE for records. However, if an endpoint has specified
> a record size much lower than that, it is currently not respected.

Remove "much". Lower is lower and we have to respect it, even if it is 1B.

> This patch adds support to using the record size limit specified by an
> endpoint if it has been set.

s/to using/for using

> 
> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>

> @@ -1045,6 +1046,13 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
>  		}
>  	}
>  
> +	if (tls_ctx->tls_record_size_limit > 0) {
> +		tls_record_size_limit = min(tls_ctx->tls_record_size_limit,
> +					    TLS_MAX_PAYLOAD_SIZE);
> +	} else {
> +		tls_record_size_limit = TLS_MAX_PAYLOAD_SIZE;
> +	}

You can simplify this with:

	tls_record_size_limit =
		min_not_zero(tls_ctx->tls_record_size_limit,
			     TLS_MAX_PAYLOAD_SIZE);

> +
>  	while (msg_data_left(msg)) {
>  		if (sk->sk_err) {
>  			ret = -sk->sk_err;
> @@ -1066,7 +1074,7 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
>  		orig_size = msg_pl->sg.size;
>  		full_record = false;
>  		try_to_copy = msg_data_left(msg);
> -		record_room = TLS_MAX_PAYLOAD_SIZE - msg_pl->sg.size;
> +		record_room = tls_record_size_limit - msg_pl->sg.size;
>  		if (try_to_copy >= record_room) {
>  			try_to_copy = record_room;
>  			full_record = true;


-- 
Damien Le Moal
Western Digital Research

