Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 116BDC77B76
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Apr 2023 15:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cD5YuHLFnPXiXV0O4WImDbbRBnTQXytqGKVi+DWNloQ=; b=VjLGcJRhR+t6x4bQVpuloe/Raj
	+LMMrzYSJ2VE7b6sxZiODfw1dU6gkbO8UGkr4pBFB+Q+/v++PX7wN6VqMDoU46Oo+SBU1O1jHKqOd
	AmWEUSk+36HnYn9yAt58EbKar7hFLLibKzKE03n/pG4C3zEY8GuKmwoDyMTTMlwIIEoIwMkGbdYAj
	+dfs/pX0IsTSNWa3yoBXPUB4IczUgLotFkSQcUaO53foPWjzEkHNUKfROIJwAjfktcKXKBIv4n2Yh
	3fA7l94iFtvSK/RJYq0voNb+EINVUYEjwZReLUQ9rsaWWGkOtikA5QEF810tHZDNIqfuklAtgi5+I
	vsTzgRsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poQiX-00Grle-1m;
	Mon, 17 Apr 2023 15:24:33 +0000
Received: from mail-wm1-f43.google.com ([209.85.128.43])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poQiU-00GrjV-0K
	for linux-nvme@lists.infradead.org;
	Mon, 17 Apr 2023 15:24:31 +0000
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-3f1754e6ac2so1323365e9.1
        for <linux-nvme@lists.infradead.org>; Mon, 17 Apr 2023 08:24:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681745067; x=1684337067;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cD5YuHLFnPXiXV0O4WImDbbRBnTQXytqGKVi+DWNloQ=;
        b=YPfK+03xn5GTV0mv4D5JgrKrgWBq5oqq/3U69bdx5xw7/NAFlLh22EwmyDLJfAiK/J
         mCEzAeK9ni1K7DwWUdFUFqXDOsIb4thvfNmlfPTfBNrEgMTTfj4StyMuajVD0GFupB1b
         KSUAU6BR3MAhVljmu1qlkxh2pOv3rRKtVtSxWae8b6aD94x108E64O9kn7Vk2I0ecX25
         pQL0ZGZ0YiaJIj1OhHM7p1dXPEbksOo6i3K9q+sOM9eCoz66ySLjZ4bf3NbwDbWXdrNG
         q24oNBbHMsKWutc21xOoDW9TgFst631Tg7c4Pre56Su8LTGqJw+5fWYyeRtUG6agtRhF
         FA8w==
X-Gm-Message-State: AAQBX9e7NNT7r0w1YAtFfCUtZszMvt1T8EhCE4cPHRopmLEC9j9dPcXk
	WlnxQUfT6P7RrhKmdqC3Hu8=
X-Google-Smtp-Source: AKy350aqbtb2el3U9SLZofrbvGvaafsgGq+srj5w6istFGn/4igSmNUUth+Z+P4wLIqazAsk8G3sAw==
X-Received: by 2002:a05:600c:450f:b0:3f1:714d:c40b with SMTP id t15-20020a05600c450f00b003f1714dc40bmr3809570wmo.3.1681745067377;
        Mon, 17 Apr 2023 08:24:27 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id p22-20020a05600c205600b003f16f362ae7sm6329802wmg.21.2023.04.17.08.24.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 08:24:27 -0700 (PDT)
Message-ID: <0752225c-a798-014c-25ca-eba2d4ad8de4@grimberg.me>
Date: Mon, 17 Apr 2023 18:24:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 12/18] nvme-tcp: control message handling for recvmsg()
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Chuck Lever <chuck.lever@oracle.com>,
 kernel-tls-handshake@lists.linux.dev
References: <20230417130302.86274-1-hare@suse.de>
 <20230417130302.86274-13-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230417130302.86274-13-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230417_082430_139214_E1DE02F5 
X-CRM114-Status: GOOD (  17.05  )
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



On 4/17/23 16:02, Hannes Reinecke wrote:
> kTLS is sending TLS ALERT messages as control messages for recvmsg().
> As we can't do anything sensible with it just abort the connection
> and let the userspace agent to a re-negotiation.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/host/tcp.c | 23 ++++++++++++++++++++++-
>   1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index b80bcc5fe447..eeb3f85fe259 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1352,6 +1352,11 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
>   {
>   	struct nvme_tcp_icreq_pdu *icreq;
>   	struct nvme_tcp_icresp_pdu *icresp;
> +#ifdef CONFIG_NVME_TCP_TLS

I don't think you need the ifdef(s) here, right?

