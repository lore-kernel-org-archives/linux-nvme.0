Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1ABAC0015E
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Aug 2023 21:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jkael3S2pdg/VfM2aJEaWso36Tz2Khr7pAvSvEHl94s=; b=tclFHE00n5RLUNX1xvhG9HHOGV
	3umOOuoTZ/d7pBOb2B43Nha9PbUE54g+1wogzWBDzznNwBpCPK4pWhsC7NLe3G5jLMp6I0+fCRtRI
	iaqbLbbA/mrhtpvNc2tzKBzoDNAhJ7vUvgCWA1K08vBDH/TlrmH72hu5BKCk3ZrGdNNGoG8JtxIdU
	CyiLmG5itkbiQmJuIG5w9pLWarpqOx/xXolgae6jSiUBwwtWWlBWwLDJ2t+Jibr7XPK0btfJcIiP7
	FZuXB5QDYN45I7hEie9cLUhfLL2+Sop+33HnRzSake6G6KJ8cfyEqHo8ErCYTAjGV1CntCQfw8lPZ
	IGQczG3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qUZe2-00BgdT-20;
	Fri, 11 Aug 2023 21:26:06 +0000
Received: from mail-pf1-f179.google.com ([209.85.210.179])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qUZdz-00BgcU-0K
	for linux-nvme@lists.infradead.org;
	Fri, 11 Aug 2023 21:26:04 +0000
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-686f38692b3so2215868b3a.2
        for <linux-nvme@lists.infradead.org>; Fri, 11 Aug 2023 14:26:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691789161; x=1692393961;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jkael3S2pdg/VfM2aJEaWso36Tz2Khr7pAvSvEHl94s=;
        b=N3u0lzwR/PzrByOywCeNoLcR0CSQuQdELg0DyDNr4WGHMFvBe4rW1f1ABwLYUeG6MP
         k7+z2s5c0O3L+WIt5NBBEVQ/weLUbNPCuSdUg+7tGSg4E2uuJdiIebS2oWZT0QufFrLO
         lYXQwDph7zHhljxtc9utLOK4MWKH7ZoPlSPqi5QZ4kYFEheVtOyb7UaAVfM/geXhAxOY
         ba66h763XGqjMNgLrI4MUfcTi2Id97S8OS3Iy4bvazObFplJjK3zwJ+ZNF5LhNAjTW2F
         iDOUxeMc4ruWwIbgnqQhssb+FFl2EH1pHQlARSV4Q08Lk6fi1Es6tZfSiMvao1orh84b
         jV1Q==
X-Gm-Message-State: AOJu0YyTbu4JJc3yFWbQ1Ypx8QHStHUnUJzfY9YvujlF16mmK8HmNBUJ
	A0e8mxrlDGg3AaUUcQfh6Vk=
X-Google-Smtp-Source: AGHT+IGvgfv1o9rzwDcunf/qZS4YYopLpr1rFa2hIc4fQs8fXgSIMEA6km+8Z6cMKCMBJqWea0/OGQ==
X-Received: by 2002:a17:90a:bd95:b0:26b:ab3:493a with SMTP id z21-20020a17090abd9500b0026b0ab3493amr2567330pjr.16.1691789161399;
        Fri, 11 Aug 2023 14:26:01 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:cdd8:4c3:2f3c:adea? ([2620:15c:211:201:cdd8:4c3:2f3c:adea])
        by smtp.gmail.com with ESMTPSA id e10-20020a170902b78a00b001bd41b70b60sm4386849pls.45.2023.08.11.14.25.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 14:26:00 -0700 (PDT)
Message-ID: <3b1da341-1c7f-e28f-d6aa-cecb83188f34@acm.org>
Date: Fri, 11 Aug 2023 14:25:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [dm-devel] [PATCH v14 02/11] Add infrastructure for copy offload
 in block and request layer.
Content-Language: en-US
To: Nitesh Shetty <nj.shetty@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 Jonathan Corbet <corbet@lwn.net>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>
Cc: martin.petersen@oracle.com, linux-doc@vger.kernel.org,
 gost.dev@samsung.com, Anuj Gupta <anuj20.g@samsung.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, mcgrof@kernel.org, dlemoal@kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20230811105300.15889-1-nj.shetty@samsung.com>
 <CGME20230811105648epcas5p3ae8b8f6ed341e2aa253e8b4de8920a4d@epcas5p3.samsung.com>
 <20230811105300.15889-3-nj.shetty@samsung.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230811105300.15889-3-nj.shetty@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230811_142603_139126_19ED65A8 
X-CRM114-Status: GOOD (  12.12  )
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

On 8/11/23 03:52, Nitesh Shetty wrote:
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index 0bad62cca3d0..de0ad7a0d571 100644
> +static inline bool op_is_copy(blk_opf_t op)
> +{
> +	return ((op & REQ_OP_MASK) == REQ_OP_COPY_SRC ||
> +		(op & REQ_OP_MASK) == REQ_OP_COPY_DST);
> +}
> +

The above function should be moved into include/linux/blk-mq.h below the
definition of req_op() such that it can use req_op() instead of 
open-coding it.

Thanks,

Bart.


