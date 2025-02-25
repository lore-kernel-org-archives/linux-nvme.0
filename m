Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 964B6C021B2
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Feb 2025 11:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=slnwLYhjfPuH3juNggrmH+DMU800QZbEDW6M5BetrvI=; b=14ot6/BRhlIyQShMPAebiThYs/
	r722cm6nsb7nDPFQjSahwVRUTXEyNaNJFM54JSA7g6dmOv//8C1kCWxPdBnBLLKHE1Xh4fxrPOHb3
	RoOC6sSoLyHqnxDQzf5fedZZjOBkCn2Osz09YbSiIl47JBHeTpdqsUeE49sROpfN3B5kJd9ZIo8F9
	6++vvbOr4bW8ycFDe/4p2PbA5mU8zjgz/Dp3MIN7Dk57s7RgVjecuIVVr54hi2hXQ2Wr1cSEMNhEv
	JoLH85gT2T3B1mfybF/nZT9kgsx4QtxemfZNfX5b3RSxIl37OkjiJGGgVqz6AgiiyEnsVAq5vW1Gc
	vMnsDtJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmsvg-0000000H00N-06MH;
	Tue, 25 Feb 2025 11:16:48 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmsOt-0000000GsAd-0Y3e
	for linux-nvme@lists.infradead.org;
	Tue, 25 Feb 2025 10:42:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740480174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=slnwLYhjfPuH3juNggrmH+DMU800QZbEDW6M5BetrvI=;
	b=Ek660cQ+/gcpEw/PzjFbBgiYVjCdrNWHK88VieSQxlXFlRN+wjNRQM13Kq8BOaeL9vMBlw
	gnilG18sHJht9ZrhvK3gRtVwQRsTsPKaIROJuxhRbtunTnh80vsKJPhE85T7Rmn17yvfv1
	B/NGcfXhMi3UJoumHZT3N+Ax8fwkjMw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-RZr0RHIiMNyJJWRvccJolQ-1; Tue, 25 Feb 2025 05:42:52 -0500
X-MC-Unique: RZr0RHIiMNyJJWRvccJolQ-1
X-Mimecast-MFC-AGG-ID: RZr0RHIiMNyJJWRvccJolQ_1740480171
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-38f37b4a72fso3049840f8f.1
        for <linux-nvme@lists.infradead.org>; Tue, 25 Feb 2025 02:42:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740480171; x=1741084971;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=slnwLYhjfPuH3juNggrmH+DMU800QZbEDW6M5BetrvI=;
        b=lmHEi1UG7BHF7OHar8fJK9qhfP+VN4mb7l5SYHw6wiAXCEGspTo1PbVfz1LEiFmNkM
         1NAqwrCNYmQoDpKxKCXZbB+W84+uFLAXOMgjVRoN0pjdxcZoFB74Bxag0RIE6a7J0uHl
         aGm0v1TPkLjw5BdoppigwGTG59Hc/Mmi3zjVMrFcEmlZTJD9xfzBCu21SzVmjCAZGy9f
         V4TSiPhDIo97aGF/J8LexKoeyhdTf6Vu3vbYgQrbx3DZaikyo30VLlY5j9gVzZ1iGFS/
         t102UO2lqF2wfo9IEEJIhK3SPDBfN463q5Efle2065TvoOLx1sg4dPVFVXQ/6LmXevWY
         GXiw==
X-Forwarded-Encrypted: i=1; AJvYcCVbQfQTIA06eFWfzNTD4ubaY0YyASNiOGQbjEBVd5XiacOdiy9Jd2Lh023G9n+1aTJEDFhovBJDLpyE@lists.infradead.org
X-Gm-Message-State: AOJu0Yxj9RLYNcTYh07x0ZHpsR2mKlqhD7H6NPiGjmZo7R2HB8vswK+R
	/ck63UTrHtswSF/RLkfVyj565DcQXl8e3ND79iy7ii5p8p5M+OQZza5HhyOKl9yqW9FYxGWyc0U
	brxneqUMFIjpGo8aY2p0mdS4d2G2COzVWmq9EQxlaxOHjLW5GXnTSGL9/wUVtE8bo
X-Gm-Gg: ASbGncsZ8FW9KM3JaCUy6Y4s4uymtylflgJlWCty1TQA4JmE0UocUXQ7/cpNq2e9jmI
	05+DMiNT9t8WAskRt6i6GRTiM6hooJ+zng36njOtho8uif6FQXdiALaREBTcOanaffgafb5xgIK
	ru4SoF/ZAjgWkgalF22PvDHFNdb6AFhObaGtrfMIV8k2ma2lbfaLNhsPDF02Loz6Ic09OIvwF9I
	lQS2+toyBGtP54lZcAdOM6qgndOx2UPnJRAp8D3/CYmWfM+gxMqbkDiRH+SWhq4twAp0UANDeaP
	aXBV0HR/Pc/XBwxUd0QChfwA8rWOvoNpQw+8EinUui0=
X-Received: by 2002:a5d:47cf:0:b0:38d:fede:54f8 with SMTP id ffacd0b85a97d-38f6f3dc975mr12246464f8f.16.1740480171023;
        Tue, 25 Feb 2025 02:42:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGuKgqrFpDbT8xU6HO5L6C2AxVLrtaD6KgRnXKGIn9SrQpJ6njoz3r81A64lnBaAx0BYOBngQ==
X-Received: by 2002:a5d:47cf:0:b0:38d:fede:54f8 with SMTP id ffacd0b85a97d-38f6f3dc975mr12246444f8f.16.1740480170681;
        Tue, 25 Feb 2025 02:42:50 -0800 (PST)
Received: from [192.168.88.253] (146-241-59-53.dyn.eolo.it. [146.241.59.53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd866ec7sm1807526f8f.3.2025.02.25.02.42.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 02:42:50 -0800 (PST)
Message-ID: <5d9340b1-02a5-4fa1-971e-a2a4baf77ef7@redhat.com>
Date: Tue, 25 Feb 2025 11:42:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v26 07/20] nvme-tcp: RX DDGST offload
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, sagi@grimberg.me, hch@lst.de, kbusch@kernel.org,
 axboe@fb.com, chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Yoray Zack <yorayz@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 borisp@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com
References: <20250221095225.2159-1-aaptel@nvidia.com>
 <20250221095225.2159-8-aaptel@nvidia.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250221095225.2159-8-aaptel@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lFVwbkjg6I6nziw3028r3-de4ofVBlcJwgE26mqIX74_1740480171
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250225_024255_241850_98E9195F 
X-CRM114-Status: UNSURE (   6.84  )
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

On 2/21/25 10:52 AM, Aurelien Aptel wrote:
> @@ -420,6 +422,46 @@ nvme_tcp_get_ddp_netdev_with_limits(struct nvme_tcp_ctrl *ctrl)
>  	return NULL;
>  }
>  
> +static inline bool nvme_tcp_ddp_ddgst_ok(struct nvme_tcp_queue *queue)

'inline' functions should be avoided in c files. Either drop the inline
keyword or move the definition to a (local) include file.

Thanks,

Paolo


