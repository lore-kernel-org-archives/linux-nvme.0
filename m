Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7E17CD37B2
	for <linux-nvme@archiver.kernel.org>; Sun, 10 May 2026 20:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VLYz3PsJEw1z0p3c8VMwO91J31B1AX6m4xBk4CoNNvM=; b=iRu7WpPSk57IoM2cAmzQBbXgTn
	4forkCLRBZmXTO+6piIuQGhcdsZScJ6E9Dp580v2K+QOcWseI5qujP8H+X5V5rsWHvNOsUpiykKSD
	I8yIzqNxfZv3lagNjrzLGoENapIJjxMc2TuGFM4GIAEOw0kU20iTCtjBDHzQO6hG7xAhMwT2LV9p1
	+QhtRmc99Wk6HpRj/tBJqv0EW3PH/OobZrb6ENhOJNL/EZa93TY5ywVvgHKE2si+0Htuj9qYGHoBS
	Hmkh5WUlfkpsJYSBtQu4VXXwfcevPvgdYwxit5Q5KEfZoiN0O+ePaBjKNcoRJPxRYVbmpmLuK/OI1
	9ZFYA/tw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMAzG-0000000Bas7-3zuT;
	Sun, 10 May 2026 20:42:54 +0000
Received: from mail-wm1-f48.google.com ([209.85.128.48])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMAzE-0000000BarN-2Bag
	for linux-nvme@lists.infradead.org;
	Sun, 10 May 2026 20:42:53 +0000
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso34389835e9.2
        for <linux-nvme@lists.infradead.org>; Sun, 10 May 2026 13:42:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778445770; x=1779050570;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VLYz3PsJEw1z0p3c8VMwO91J31B1AX6m4xBk4CoNNvM=;
        b=J+eOkRFax5dvdSd99Kpodqd97pMa+trgiLbx2LqDXdNLACjSm1oRi5vzZvr7vGrWqN
         Q40Je4Ld0yYYBQn3+wxoQou+R1RnMFuOSgc1TI28rDfqudHTBDhR9FGhOMZ2VquZlz6q
         qcexvp6Fyc3frBLTC1SuAvSuZtoCjpnCC8Hvpd2KHzOtmxN8bV6evNbaAqnp9F+a7wzD
         dVLnow8pDrWxrx2oSdyuYW2RYqOZ0gs9pzrG6eKNbLGeTIpdaBEGCnR3ta+LvcJqMxOw
         3wskBxU+M6SjDY7JYVyy7enNry3aBotSVTbZKEYyxPppLGor+ECmnajgyRg0plWN5kHT
         ZTTw==
X-Forwarded-Encrypted: i=1; AFNElJ/vNkFxVoTJY7ymEFiDjXuQschn5Szq8/jNrdLmQWlpMx7ulgqacxSs5tg48amebBVjXWm1MF7X+Y85@lists.infradead.org
X-Gm-Message-State: AOJu0Ywd+2tOHCZ3N6phtgzq+CGVTLqhyXx5YRssL1f/78VA0KYlAkWp
	4lxJaGWMKv9YWi80M2C10tvo3ERnoagCfNP3DpqWuczrJffJz/pQ3jlM
X-Gm-Gg: Acq92OHiRmlSDpajnVEFg1hLnpvmMjOv/O7g8it4pNvGK6LgxqQT3EQrJPs0QbGioMA
	a/oKZ7IWNfxHgNKEMXO6SdshiR0GVgVb64nJGq4XZUVOtHLmSx+biFnEDR2yqsrldJkp1s3MzbS
	RnDrguzsMjptW/vWCabNeDIMGvoAnyTwIQfWPfaF0/xixsEXv+bB+nvBdZ5OcWnoNXkh4WpLmJw
	3Rxf34jugfnsZrpeOxVbNmnxGoDm1ZI3wwz/P9LIcLfJUAdrC2697Hk4CeYIRl5MixN0tly2afC
	MWxHBTW6BkBTorSgNUsiEi6YuSKBglaSYD9UVjlZQhy58QjGCJEbfsU59B3U3L1t6fddnqgzixq
	LhJrnb2v121kJIIQFrAUowVk7e2tnrjFmVT1/DBePUYcMmzTicRiAIAkn3fwTnMRGfCrTN3UYqc
	memSK0bzNhM9BzFZoFtIU=
X-Received: by 2002:a05:600c:3548:b0:488:c40b:c8a4 with SMTP id 5b1f17b1804b1-48e51e097a2mr335388065e9.1.1778445770167;
        Sun, 10 May 2026 13:42:50 -0700 (PDT)
Received: from [10.100.102.74] ([89.138.75.0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e702e5516sm205822225e9.7.2026.05.10.13.42.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 May 2026 13:42:49 -0700 (PDT)
Message-ID: <d06002f7-2da6-44bd-a0df-d9f2ef87a66c@grimberg.me>
Date: Sun, 10 May 2026 23:42:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] nvmet-tcp: set and enforce a default MDTS for TCP
 transport
To: Shivam Kumar <kumar.shivam43666@gmail.com>, hch@lst.de
Cc: mlombard@arkamax.eu, kch@nvidia.com, linux-nvme@lists.infradead.org,
 kbusch@kernel.org, gregkh@linuxfoundation.org, security@kernel.org
References: <DI4KADNWR1XG.ILIR3Q697X77@arkamax.eu>
 <20260508203912.320938-1-kumar.shivam43666@gmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260508203912.320938-1-kumar.shivam43666@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260510_134252_594639_7989FCEE 
X-CRM114-Status: GOOD (  21.71  )
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



On 08/05/2026 23:39, Shivam Kumar wrote:
> Unlike other fabrics transports, the TCP target does not set a default
> Maximum Data Transfer Size. With the configfs MDTS entry defaulting to 0
> (no limit), a remote attacker can send a CapsuleCmd with an arbitrarily
> large SGL length, causing sgl_alloc() in nvmet_tcp_map_data() to attempt
> an excessive kernel allocation that triggers the OOM killer.
>
> Set a default MDTS of 9 (2 MiB) for TCP. Enforce the limit server-side
> in nvmet_tcp_map_data() by rejecting commands whose SGL length exceeds
> the configured MDTS, returning NVME_SC_INVALID_FIELD as required by the
> NVMe specification. Admins can still adjust via the configfs mdts
> attribute if needed.
>
> Signed-off-by: Shivam Kumar <kumar.shivam43666@gmail.com>
> ---
>   drivers/nvme/target/tcp.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 164a564ba3b4..098cf877c358 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -25,6 +25,7 @@
>   #define NVMET_TCP_DEF_INLINE_DATA_SIZE	(4 * PAGE_SIZE)
>   #define NVMET_TCP_MAXH2CDATA		0x400000 /* 16M arbitrary limit */
>   #define NVMET_TCP_BACKLOG 128
> +#define NVMET_TCP_DEF_MDTS		9 /* 2 MiB (2^(12+9)) */
>   
>   static int param_store_val(const char *str, int *val, int min, int max)
>   {
> @@ -422,6 +423,13 @@ static int nvmet_tcp_map_data(struct nvmet_tcp_cmd *cmd)
>   	if (!len)
>   		return 0;
>   
> +	/* Enforce MDTS: abort commands exceeding the advertised limit */
> +	if (cmd->req.port->mdts) {
> +		u8 mdts = cmd->req.port->mdts;
> +		if (mdts < 20 && len > (1U << (12 + mdts)))
> +			return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
> +	}
> +
>   	if (sgl->type == ((NVME_SGL_FMT_DATA_DESC << 4) |
>   			  NVME_SGL_FMT_OFFSET)) {
>   		if (!nvme_is_write(cmd->req.cmd))
> @@ -2077,6 +2085,8 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
>   	INIT_WORK(&port->accept_work, nvmet_tcp_accept_work);
>   	if (port->nport->inline_data_size < 0)
>   		port->nport->inline_data_size = NVMET_TCP_DEF_INLINE_DATA_SIZE;
> +	if (nport->mdts < 0)
> +		nport->mdts = NVMET_TCP_DEF_MDTS;
>   
>   	ret = sock_create(port->addr.ss_family, SOCK_STREAM,
>   				IPPROTO_TCP, &port->sock);

Shivam,

I think what we want is to limit the tcp to a sane limit similar to the 
nvmet-rdma driver.
Also, we probably want it at least consistent with the (rather 
arbitrary) MAXH2CDATA...

e.g. something like:
--
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 20f150d17a96..32f33e5dbfdb 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -24,6 +24,7 @@

  #define NVMET_TCP_DEF_INLINE_DATA_SIZE (4 * PAGE_SIZE)
  #define NVMET_TCP_MAXH2CDATA           0x400000 /* 16M arbitrary limit */
+#define NVMET_TCP_MAX_MDTS             12
  #define NVMET_TCP_BACKLOG 128

  static int param_store_val(const char *str, int *val, int min, int max)
@@ -2220,6 +2221,11 @@ static ssize_t nvmet_tcp_host_port_addr(struct 
nvmet_ctrl *ctrl,
                         (struct sockaddr *)&queue->sockaddr_peer);
  }

+static u8 nvmet_tcp_get_mdts(const struct nvmet_ctrl *ctrl)
+{
+       return NVMET_TCP_MAX_MDTS;
+}
+
  static const struct nvmet_fabrics_ops nvmet_tcp_ops = {
         .owner                  = THIS_MODULE,
         .type                   = NVMF_TRTYPE_TCP,
@@ -2231,6 +2237,7 @@ static const struct nvmet_fabrics_ops 
nvmet_tcp_ops = {
         .install_queue          = nvmet_tcp_install_queue,
         .disc_traddr            = nvmet_tcp_disc_port_addr,
         .host_traddr            = nvmet_tcp_host_port_addr,
+       .get_mdts               = nvmet_tcp_get_mdts,
  };

  static int __init nvmet_tcp_init(void)
-- 

