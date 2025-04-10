Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0C2BC369B1
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Apr 2025 11:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oi08ZUj5nmzNApBuQkkZIOeXhhQ8NRPpEYlY/zuaL9k=; b=UoPQwosiGypdBxCZeAGMe9VNIK
	KzZWoz80oyrJk7GsaR1b86Ler57IPzIJBWlHERMtSktXh5CYJtRKQ56VA5lHWxD4R0ec1HNyjnHk6
	E32nGIR1QTWQnPRbZLQZQI9TXaMWDYsJ9QJI2s/PWMd3lnZWKFnTc2sY7GqdweLAqaoaAIjtbd60P
	Mw9caq/AR0BeCHWS5jafwnmHndD1UfcouFKDRDqOVUvO6PHcjx/phzKKjNx22Sp8DNxDZtXLZt3CQ
	sv/mtkiDRTlKlxHDF9ttf3cQDSyZj3ZVWDIaBgGe1fR5oLttPrPxMxq1L4eCOqxR0EUD1oezk8wIW
	XEZUsOJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2psl-0000000AB1U-0fT3;
	Thu, 10 Apr 2025 11:15:43 +0000
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2nlq-00000009qmW-11ph
	for linux-nvme@lists.infradead.org;
	Thu, 10 Apr 2025 09:00:27 +0000
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-223f4c06e9fso5608095ad.1
        for <linux-nvme@lists.infradead.org>; Thu, 10 Apr 2025 02:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744275625; x=1744880425; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oi08ZUj5nmzNApBuQkkZIOeXhhQ8NRPpEYlY/zuaL9k=;
        b=EbBzW9Dfpbci6nKAtD/8wfTnt6POC98VzXExe9cF1LQvn7BrsXKKkvZdT0vAw0cJc9
         Fwk0dlPf6O3Z4P5CYEPw+7gFokkz4aJ6PpD3o0e+5kMCKBCtjTkR5mDUG9i4+FCTdFj1
         hRdk51r7M0LmHn/YWbRNc6UCmf5Eo3u9quoLYvmNAnb/IOCoZEWo4FFCcPe0w5gGd0Y9
         j7vrGNOv+j41VWTZ0wn93YEOC5OZu0xE9nLCc0Zxt8Cznp4zRsHmdgzsvrGpmFHFNdVF
         Nd6xID1TNcikqdYKoIiG9tiR1b3XsjQ7ZsYiZvpy83eZlGwory+P2KLOLU9pmKvM/M95
         S5Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744275625; x=1744880425;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oi08ZUj5nmzNApBuQkkZIOeXhhQ8NRPpEYlY/zuaL9k=;
        b=g/0F2Pn13YP2co3FXMdxFx3Cw7+ptGfPbpsyv9UYJUGPxyLJgHp3xdws/5C9hhGPjh
         NPcO17pAwFgC+VY4SZoV8j8FiGK38F57moK5cEAfojGSdBgORK+S7IkqzRRv1B9v5lZ4
         m1zkhmf8SnUIfq24CN7Zc26f89VyUyOFIaT3Q5Nn9YPGL+jn6460xj8EoDMgRmE8Fs4W
         OI/7lyLxNR/46DkMGrVegKumgYUUiV7pR5qcBA9pgm+rsw7jI5cDwlg4ZL8QFq/YeQhV
         MsIFnOWa0dwh2w8V3jvGhJVdXNX0KJe4K62fH7nP2eYiD+Q2IR3n00boWuvN8++Ivphv
         pD7A==
X-Forwarded-Encrypted: i=1; AJvYcCXA0I4lhL2gh1GaIIy12k20R+EIkre6xiWl7uS63/eic1F8scAH8pZl2MppbR+fbTYFgRq3FcO0mVbo@lists.infradead.org
X-Gm-Message-State: AOJu0YxdVH7kqCudo/C2M1/nfQqYknVo5aKs5QmiRG2pLlOzhHZRYqLD
	uyOO3pxymAEttaBYInEc1/9xCPu+/va+8+mr2xfYQi+sOmyqXM3sapTRlN2YYyg=
X-Gm-Gg: ASbGncuh06TLv7QAkCtru1CY0qeOelAxEo/3CZ6z/30IwiZe8JmijIOyCIsDV2Wv3NH
	eEEmMl/oMwKJGyoIJL/jXzdtUleRrMbVlhTpovS0u6YVvVjT1wUnjTKKTOrl7u40caJB20QT7/B
	t8CPAeDE/LGP2nlBxTKJ8+gu+LhKq95QiR1YkAo4U1LaByV0orkx6LUpRdU1lyQR75iK1ZwZUgl
	JS2UH8WjElvEpKvXydwLPi0kP+lwDPMBlWKWuYZqcPgP8/4U+L0UE/Bew8lp6wUtm4gYoRxehKT
	SJhZdSIc6oL5jIKPT7GUDTy0T14rDGZuaecntIWjQyxQSxI=
X-Google-Smtp-Source: AGHT+IHvhWnHATaAYKumHYbk0dW2labQ8ZJNKeRIo7kd5Qs5AD2+Hg6lM5xWwGK/Wyz/+ltT4oPazQ==
X-Received: by 2002:a17:902:ec84:b0:223:4d5e:7592 with SMTP id d9443c01a7336-22b7f91b908mr26302915ad.21.1744275625363;
        Thu, 10 Apr 2025 02:00:25 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([2601:640:8900:32c0::e120])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-22ac7ccb34fsm25299735ad.228.2025.04.10.02.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 02:00:24 -0700 (PDT)
Date: Thu, 10 Apr 2025 02:00:22 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Daniel Wagner <wagi@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>,
	John Meneghini <jmeneghi@redhat.com>, randyj@purestorage.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/3] nvmet: add command quiesce time
Message-ID: <20250410090022.GF1868505-mkhalfella@purestorage.com>
References: <20250324-tp4129-v1-0-95a747b4c33b@kernel.org>
 <20250324-tp4129-v1-1-95a747b4c33b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324-tp4129-v1-1-95a747b4c33b@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250410_020026_281608_9E3094C7 
X-CRM114-Status: GOOD (  24.44  )
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

On 2025-03-24 13:07:56 +0100, Daniel Wagner wrote:
> TP4129 introduces Command Quiesce Time (CQT) for coordinating the
> shutdown sequence when for example KATO expires.
> 
> Add support to nvmet but only report CQT is available but the controller
> doesn't need any additional time when shutting down. In this case the
> spec says nvmet should report a value of 1.
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>  drivers/nvme/target/admin-cmd.c | 6 ++++++
>  drivers/nvme/target/nvmet.h     | 1 +
>  include/linux/nvme.h            | 4 +++-
>  3 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> index e670dc185a967dc69c9b7d23930bb52bdcc3271a..09ac5a43f70dbe3889c1b404d6b59c0053337192 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -733,6 +733,12 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
>  	/* We support keep-alive timeout in granularity of seconds */
>  	id->kas = cpu_to_le16(NVMET_KAS);
>  
> +	/*
> +	 * Command Quiesce Time in milliseconds. If the controller is not
> +	 * need any quiencse time, the controller should set it to 1.
> +	 */
> +	id->cqt = cpu_to_le16(NVMET_CQT);
> +
>  	id->sqes = (0x6 << 4) | 0x6;
>  	id->cqes = (0x4 << 4) | 0x4;
>  
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index b540216c0c9a9138f0913f8df28fa5ae13c6397f..47ae8be6200054eaaad2dbacf23db080bf0c56c2 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -671,6 +671,7 @@ bool nvmet_subsys_nsid_exists(struct nvmet_subsys *subsys, u32 nsid);
>  
>  #define NVMET_KAS		10
>  #define NVMET_DISC_KATO_MS		120000
> +#define NVMET_CQT		1

Setting CQT to 1 is a promise to initiator that target will quiesce
pending requests in 1ms after it detects loss of kato traffic. For
initiator, it means these requests can be retried safely in 1m after
kato delay. Is this guaranteed by target?

I thought leaving the value 0 means CQT is not implemented, no?

>  
>  int __init nvmet_init_configfs(void);
>  void __exit nvmet_exit_configfs(void);
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index fe3b60818fdcfbb4baabce59f7499bc1fa07e855..983b047e7158dcb33da66a25c67684b8f1ef5a7e 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -335,7 +335,9 @@ struct nvme_id_ctrl {
>  	__u8			anacap;
>  	__le32			anagrpmax;
>  	__le32			nanagrpid;
> -	__u8			rsvd352[160];
> +	__u8			rsvd352[34];
> +	__u16			cqt;
> +	__u8			rsvd388[124];
>  	__u8			sqes;
>  	__u8			cqes;
>  	__le16			maxcmd;
> 
> -- 
> 2.48.1
> 

