Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E5BC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Mar 2022 08:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Wf/VALAOMMPgO99Gdjfu7Za7zb3cdxWh7bM98PqUr/Y=; b=Rrp/w4nbR9VEYELpSbeSKLfKMK
	rrA373jjhPCVeu+VwmdBQ00ny3O5vC2n06fsrpAJysVI50ANOKsOYiZwrsBNzz9qKaNt11OU3TP27
	xoXlAuoUvYZIG8khnjuHVL04rgxI/M/nzqISEViJJfp/tsPrTYT7FM9dU0CfaYE6l4k5e/45NJ6fN
	/YFdoYMkR9mxigQ4Fr/bK9A4IS75/0FaX7gwSCZEw7hbJCAC4VrmDy/C98kT6PG5Iym5p1pN2kU5Z
	NRYh2GIgEq+Vrbz44oWYpFLPmSzp11RS1A7R8fhbUfJz/rx2ied20monjQY8z8xSZsYaSQ7/K6mjL
	jDD2V4pA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nUPDg-00CAgD-63; Wed, 16 Mar 2022 08:41:24 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nUPDA-00CAPW-A9
 for linux-nvme@lists.infradead.org; Wed, 16 Mar 2022 08:40:53 +0000
Received: by mail-wr1-f50.google.com with SMTP id t11so1872475wrm.5
 for <linux-nvme@lists.infradead.org>; Wed, 16 Mar 2022 01:40:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=Wf/VALAOMMPgO99Gdjfu7Za7zb3cdxWh7bM98PqUr/Y=;
 b=dWljYcwFi8eTB8jIV5WavOWC8wkURn/Q0TuKqbsmDTA4xWkr5AhinQJSzYutEMvd9I
 hRIeLRzvp/hjKRmFg1AciGTvBRJZlgyHU+gkOhuwPQqBILxCZPKvWb2b7Q0s5O37TU3J
 Nnhwew3yc0tVj/tengbsDFifk1TwtaKdZQH63hgQsg9luBsgD7Co3LWGHgneuJdwTii+
 2tN+wbQw2x/Pp5YErBF+0E7JLefCIouExDjgLOnbW0tv41PcA8YOlG27AsSyJkOMksZ0
 U0B4ZEvm0UNVluipHC1j549FAiIHzTvXRlIbx2A8xBRVBZ0pXxuZr0nogAxKcjYibIFN
 4n6g==
X-Gm-Message-State: AOAM532XfsesRfYT84EeQ/XoSTtu9PaZsJEa+8Ri33v7x7P87QoI7N9K
 A5b8AfbihwDC8YZOkMaVLn8=
X-Google-Smtp-Source: ABdhPJxTkbvQ5D6MyFOHwHw8U51Vq5VuBWAkfCzbExhllV8zcyvrwQatH+LfLxilYOeCNO+oviJKxA==
X-Received: by 2002:adf:edc3:0:b0:1ec:5f11:5415 with SMTP id
 v3-20020adfedc3000000b001ec5f115415mr22795891wro.317.1647420049477; 
 Wed, 16 Mar 2022 01:40:49 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90]) by smtp.gmail.com with ESMTPSA id
 w6-20020adfee46000000b001e4bf01bdfbsm1063384wro.46.2022.03.16.01.40.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Mar 2022 01:40:48 -0700 (PDT)
Message-ID: <c8c0ecf4-6848-3569-f2f3-9331854de788@grimberg.me>
Date: Wed, 16 Mar 2022 10:40:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] nvme: remove nvme_alloc_request and nvme_alloc_request_qid
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org
References: <20220315150222.2590959-1-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220315150222.2590959-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220316_014052_424407_1B455D54 
X-CRM114-Status: UNSURE (   6.89  )
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

Patch could have been broken up a bit, but not a real issue,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

