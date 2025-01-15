Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 021B3C02183
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jan 2025 22:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GwNYBMLbzAbRpAKms/GYkNz/jlTd77izQq6GSO3U0B0=; b=Dk4t8bXH/JqBOufgjjlNImjsec
	woeoTSK7Qq5S10CWT6+HgGPb2kkr4AzCl8M+uHleSDNPv46o/6yk8DvbyA1w9FeZdsiErmzlSHfp5
	/UKZn65lT8AbCK2uS5aLLI9pwhQrU6OsECRjMFURtVxoJxobJxNSeFSA3OEevSJPTSM3z6JAfGWO1
	ZL+7hlFgWNdZHMVt1xALOBqLfHY10P59BSGelYFZQnTwth2vHf9pBo9faMUfq7dPhyMMbfrHXsHrT
	AAVm1UX5oOhtWBr5C6TQyUMO1AdZKIdVkJSwmQ3r9+3MYubI/OKaIrvmsZjFOgLyDwD58cRuvnhvw
	nSVUBw7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tYBxd-0000000DFs7-1Ep1;
	Wed, 15 Jan 2025 22:34:05 +0000
Received: from mail-il1-x130.google.com ([2607:f8b0:4864:20::130])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tYBxa-0000000DFrN-2gGW
	for linux-nvme@lists.infradead.org;
	Wed, 15 Jan 2025 22:34:03 +0000
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-3ce76b8d5bcso2391695ab.0
        for <linux-nvme@lists.infradead.org>; Wed, 15 Jan 2025 14:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1736980441; x=1737585241; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GwNYBMLbzAbRpAKms/GYkNz/jlTd77izQq6GSO3U0B0=;
        b=UJYe6y+9LbnRzoAv4wkiQ/6WZ+l3ZMe9Qp0QPgTW21H7Q2vd8+19DVB72D3dxkw/1o
         llsSo5ec0T5L9pMETDRbrMrE7gZd/qECDpTMrFyTLzmKbv47ZTpkmDl4y9K0XvZKRKBO
         I6WCSQmsTDVajGLQlt/0NZaSNB3ItRZng3o+yi+dBXNqE32HNq2iXiT5uDcKV1RtgtRi
         vl2xd1oTVwfWvV0fhvLYNkpPVkPz89OXPdIwkiZbyd8PPylUreDm1U9xgWBhUF73qqm1
         qjNcyTox9/8/IKnQDx4nKp+wYFVyx6uHn97UGjvUqmHLEPgi63POnVhBh/3TxJU9G8d3
         jyew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736980441; x=1737585241;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GwNYBMLbzAbRpAKms/GYkNz/jlTd77izQq6GSO3U0B0=;
        b=jXTJSPAX4YfZFbdS/Ji04pmsMSrvp9+XT/ygL5nVvxYkXN34YLZO7EMpfdJHSGRxQB
         BaqG6lDFx5Z3+1l3HLVuOxXF1aJqBntywgWgLOuE2ZBPC3WwTT+ids7nFYo7P3CI2exq
         O0awhLxWV9CouGCdS//Qkc8DTwKPaNVu2h27ATIrSujMpiwTHk3UZl9HMyqo5lYMv13r
         XhC0BotOO8sPe15WJ3UhC30dWbcoi60Cm1eU6qTV7iXlwowLcH2eJaZXsd6JJ8iZnJmI
         ukrdJYRms7y9RSdKHHM1U81Z1kbrerDtFCn5D79Is7QpMEgfd8bi31ajqRzZ2Vg9RiBu
         ggDw==
X-Forwarded-Encrypted: i=1; AJvYcCX9RwnpI38MVQCOWP9kay3JowzmgZkbbxwmBoDTaRmm09d80R0Olu9dPxgClXgDv0Erz9Cz6+m5HjKm@lists.infradead.org
X-Gm-Message-State: AOJu0YwLVQo5FTro2IL3EpFnY0fUf32tGk0EQDsiVNEcxwngMQNB30Kv
	zjemIylQYM3SSe72lKVfGtgAPayPDtderCgqSAexs/hraZTAGjOxMZmEgyQ+1vM=
X-Gm-Gg: ASbGncuttEgNFPvhQezD1U/Xd/p9Y/bNkHHL19u0/5PxPU2GvDe6SGwimxNcREkfMnR
	/nnQ295OsIcKSYk2uuvYe51QMJaSi2fdPoBy0B48+OZrLScoeRslUAbbSaC6UoJxigpxHFSr9G5
	cBI5kmE275hMPGyIajnG93D2wayJ5ajBbr5nr+WjZVqjq3bVyD5JlNU/NPYEiey6uddrd6CTAAg
	pz6P+0ROaizkMXFioT30wWasRkuLUMSlnObvSz6H3bgxqwRiLy3uw==
X-Google-Smtp-Source: AGHT+IHauMAoxPlq+WGTc4WtWCelxsFWy6yXEk7hi9kHZ37F+UKUkwgkX1aSHGjr1KnoFDNPdhIJAA==
X-Received: by 2002:a05:6e02:16c7:b0:3a7:5cda:2769 with SMTP id e9e14a558f8ab-3ce3a88ac8fmr249640705ab.12.1736980441498;
        Wed, 15 Jan 2025 14:34:01 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ea1b718a29sm4368513173.87.2025.01.15.14.34.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2025 14:34:01 -0800 (PST)
Message-ID: <8901cba4-245b-4b02-832b-af02e5bb9cb8@kernel.dk>
Date: Wed, 15 Jan 2025 15:33:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] nvmet: fix compilation errors
To: Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, dlemoal@kernel.org,
 bvanassche@acm.org
References: <20250115221703.62861-1-kch@nvidia.com>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <20250115221703.62861-1-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250115_143402_687139_351DC4CC 
X-CRM114-Status: GOOD (  13.57  )
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

On 1/15/25 3:17 PM, Chaitanya Kulkarni wrote:
> nvmet_alloc_ctrl() only takes nvmet_alloc_ctrl_args. nvmet_alloc_ctrl
> doesn't have nvmet_req argument. In nvmet_alloc_ctrl nvmet_req is
> needed when setting up authentication capabilities since call to
> nvmet_setup_auth() requires nvmet_req argument which later uses req->sq
> to determnine if tls is enabled or not.
> 
> That leads to following compilation errors:-
> 
> target/fabrics-cmd.c: In function ?nvmet_execute_admin_connect?:
> target/fabrics-cmd.c:318:35: error: too few arguments to function ?nvmet_connect_result?
>       |                       ^~~~~~~~~~~
> target/fabrics-cmd.c:237:12: note: declared here
>   237 | static u32 nvmet_connect_result(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
>       |            ^~~~~~~~~~~~~~~~~~~~
> make[4]: *** [/mnt/data/nvme/scripts/Makefile.build:194: target/fabrics-cmd.o] Error 1
> make[4]: *** Waiting for unfinished jobs....
> target/core.c: In function ?nvmet_alloc_ctrl?:
> target/core.c:1527:37: error: ?struct nvmet_alloc_ctrl_args? has no member named ?req?
>  1527 |         struct nvmet_req *req = args->req;
>       |                                     ^~
> target/core.c:1635:25: error: too few arguments to function ?nvmet_setup_auth?
>  1635 |         dhchap_status = nvmet_setup_auth(ctrl);
>       |                         ^~~~~~~~~~~~~~~~
> In file included from target/trace.h:19,
>                  from target/core.c:16:
> target/nvmet.h:879:4: note: declared here
>   879 | u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_req *req);
>       |    ^~~~~~~~~~~~~~~~
> target/core.c:1654:17: error: too few arguments to function ?nvmet_has_auth?
>  1654 |                 nvmet_has_auth(ctrl) ? " with DH-HMAC-CHAP" : "");
>       |                 ^~~~~~~~~~~~~~
>   889 | static inline bool nvmet_has_auth(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
>       |                    ^~~~~~~~~~~~~~
> target/core.c:1527:27: warning: unused variable ?req? [-Wunused-variable]
>  1527 |         struct nvmet_req *req = args->req;
>       |                           ^~~
> 
> Fix these errors with addition of the nvmet_req *req parameter to
> nvmet_alloc_ctrl(), new prototype :-

I think that "what tree is this" applies to this as a whole. None of
this seems to make sense looking at my for-next tree...

-- 
Jens Axboe

