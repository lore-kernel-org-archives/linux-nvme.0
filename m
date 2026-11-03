Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF549606A33A
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2026 19:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=gZ8pWVLd;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Gfx/zu/H
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Ydjni9zb1eg48+F6fhT6E/9ItDiahQVxW0eKVWZs69g=; b=gZ8pWVLd/uAQM8
	8bXzU3fE/IQnIBBsnA0i10Z5EiXdFv1gyQthC2w6tP4DFSgr7gz4Z3WcNm33wbWE5x4f+PtoKKhjx
	XO26DFqhTu9i9wnk/VpXI7zjSDyAU5h/0I4WA1wV8J5Hi07GFLJj3GgOcl6KOSPwRhqZ0RDedaxai
	77Z6ff52XwSZtPiZlHqvcbl5tKufKb6bL8lkPmkO1fEjz+/gcTmYe8uapezjsx2gsIqi/KkTwDEFQ
	NhbgC70hiMhAwafSwHy+v3q6KTMGHWFRnLAt93DENtw11B0QJnQYIvT6GiPROov75mMkof2Mjb0uI
	dofV5PX22LwY3GUZtiiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOKTw-00000003YvN-0lTP;
	Tue, 03 Nov 2026 19:47:44 +0000
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOKTt-00000003Yv0-01LY
	for linux-nvme@lists.infradead.org;
	Tue, 03 Nov 2026 19:47:42 +0000
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-6dde81a6820so3340677eaf.2
        for <linux-nvme@lists.infradead.org>; Tue, 03 Nov 2026 11:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793735260; x=1794340060; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ydjni9zb1eg48+F6fhT6E/9ItDiahQVxW0eKVWZs69g=;
        b=Gfx/zu/HkbOQ8uFx+kyxNqLG2GPigRP51qUBRTzaIg5hOet5Ph8iRUPOfPKrIBfBhT
         z+RFVkLgz6KXIMzDbJ4pp9vJHUyMPN+CKZuIS6fza33sONTYF4YZJhPdzR7qVHYMWOH0
         QKuOFvQryR0Aoe6nMC6JcUna4MGlYC/GQt/Zqk463In7uLDFDjC68GdcGQUDBezILf8k
         pn1XSydNhzBCJlzSRVnOwc3F69rL8PHf2jQohm9eePDy7jeATrIXUxpgrUvShHNUsvTO
         wmYHrC/ZKVjty6JATXSy4CF7wwFSG0qyhgt4vhUdDCAFNd9pg89OawGggNyZDAHUEF3O
         G2jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793735260; x=1794340060;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ydjni9zb1eg48+F6fhT6E/9ItDiahQVxW0eKVWZs69g=;
        b=Sml8yeMJfsaXWyJ1g7Ny/oRZm0IptOzuwwbug50hZXkHj9SlI/XqslZPpMVipTo+FV
         LzkjfiZCGFEmMcVrwXW/mMP61ZwKJ02hVC4M+5A4rGwQbsIeLB81B02e/GePJCzQcwc0
         lQyVYIL1rFb3ooIZ5fmvkuOU+Bm/e/Bk/e1Kt/ZF3ueu1gFXk9ijvTEPzk/ipVnPd791
         bxQy6ipX3WDTV4aoCib4yPyiG/+t798LHhFvo7hzvSrt84PnrokHJD3BPmGF0CBh2JXN
         v0ExZSruarjtCJNzERhqmerrT/GDLZ8b6D4Wzwxs9cqKFTEPBXYMpUW1ljR+XRPNftL7
         RfrQ==
X-Forwarded-Encrypted: i=1; AKwUvBz4qrdpKMgMCmwJTJmsbvcq008QsaU9H3+B4HtFFRodycyF4u3ykvVjsd2zY3ZMA4fSLIdMh6YV2W1E@lists.infradead.org
X-Gm-Message-State: APuU4Z9h+GRmOKoEuQ0QVvIDsRKOtj/Oo699NwW6O2E+ojBiiXMG8SFZ
	m+T6MBW3vrVhP6QRR5W29J7R4ZgKYWK9eVlbBT03swFWsjzF1lpTup4OdASeD4CBpsExhL/KMN1
	pDJiMYog=
X-Gm-Gg: AYBFou1Km+V6cSg/7a/kFGg+ObF0dn8ZW8NpkXIlX3dIAO2hnOPMw0Atb72jefGGMkH
	n1Q5DLz3GGOMzNXYrfRxWuEMijkRbrGupFMvvG44MXEvZsBDsxfbw8+ak4FxSD4EOurrbR4nj5r
	ofnEopQsp5sjZ9td/9InCScBs0N3bU7JRcHXnFP7PJK59ltf1PiJWejPA0ig4K+0l5c3VRzuXQ4
	RdEtGIx6v6BmWUwlykGNkHhrd/6B4IjoLqxpB26IwM+1dreBOCBNl6IkrIi2Dov0XAcaX1VRe5s
	Ef/Fk61TUVHB0uOD8WLAo0dCnUwnzvblLQIh8m9swbkezhdYLALpu+ClP0R9IEr2TftI02OXPsq
	3oV+dBkf4BqXdNoqx/CuALTlTHm3R4KFe1Zb4X+2T25aRf3+Nu3rGGQz24hvdTc8vl/Sii+ntV1
	kHtJVrw2NCPX22rIYWywRwWfNHzphD/4DzcZDVx1o4IirA/BqAXwMyNLZaVcIx5QrtxNKDkmX5E
	Yj4VKn22aENgtGVw7hmmnK/jN9j5XCBKYLDYnVdaB/PbsGW8FO+U0WyFwf+Q8NGQY/LekQcKxGW
	b6CohjRPc68zMPUU3ZhE4tVEBh0RWE2RTsPe6wYW+FSbITqwGjz/VJBZJ1+fmVXdYVyIZOwh//f
	7g+alEAn/Lxw6CB5bsVkJOl8PHbahgQ==
X-Received: by 2002:a05:6820:709c:20b0:6f8:92ab:bb53 with SMTP id 006d021491bc7-714f2489a3cmr5196705eaf.41.1793735259648;
        Tue, 03 Nov 2026 11:47:39 -0800 (PST)
Received: from [192.168.2.38] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-716c129a718sm30815eaf.6.2026.11.03.11.47.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 11:47:33 -0800 (PST)
Message-ID: <d48ad87c-9cec-4da1-a896-031b7480c117@kernel.dk>
Date: Tue, 3 Nov 2026 12:47:26 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: reject completions for requests that are not in
 flight
To: Keith Busch <kbusch@kernel.org>,
 Mauricio Faria de Oliveira <mfo@igalia.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chao Shi <coshi036@gmail.com>, kernel-dev@igalia.com,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261103-nvme-double-cmpl-uaf-blk-mq-v1-1-b10fea474423@igalia.com>
 <auo5a1kRTSWsAYtF@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <auo5a1kRTSWsAYtF@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261103_114741_215011_C30D395B 
X-CRM114-Status: GOOD (  15.16  )
X-Spam-Score: -1.9 (-)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/3/26 12:43 PM, Keith Busch wrote:
> On Tue, Nov 03, 2026 at 04:18:25PM -0300, Mauricio Faria de Oliveira wrote:
>> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
>> index 2d8f681079e85601a92624d196e77f1ba3ace34a..3ba0666da7be6a3de2e5f0fd50155af115b4e1f6 100644
>> --- a/drivers/nvme/host/nvme.h
>> +++ b/drivers/nvme/host/nvme.h
>> @@ -708,6 +708,11 @@ static inline struct request *nvme_find_rq(struct blk_mq_tags *tags,
>>  			tag, genctr, nvme_genctr_mask(nvme_req(rq)->genctr));
>>  		return NULL;
>>  	}
>> +	if (unlikely(blk_mq_rq_state(rq) != MQ_RQ_IN_FLIGHT)) {
>> +		dev_err(nvme_req(rq)->ctrl->device,
>> +			"completion for request %#x not in flight\n", tag);
>> +		return NULL;
>> +	}
>>  	return rq;
>>  }
> 
> Is there something special about the NVMe protocol that makes this
> problem unique to it? If not, why doesn't this check go into the generic
> block layer instead?

Pretty sure I've nak'ed this kind of thing before. So no, it
should not go into the block layer and bloat it there. If a driver
does double completions it's... a driver bug.

Bigger question is "why does this patch exist in the first place"?

-- 
Jens Axboe


