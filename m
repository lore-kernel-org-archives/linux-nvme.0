Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88CE8C001DB
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Aug 2023 14:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lqPfjKBh4fEn5Wj87LjUhKggel2I0g0zW4XnW9s14SU=; b=dBHxiIQ/SxLMnxCrCC6IlUVu8y
	e6ZN1+otK45J4WcTVpUsSPmgFY8eWmJQTRJPZUdC4jSub5V0nUd3DbX+LICkXb9hiQuncwhfNvOsT
	0B2Wz2zHRIxiF/wActblYzuNchO1lFgpjUmlnhX0sTnLeyLZ9CcZU1cHJ/VOW+xM+NONDAha5aYZL
	eO7gHEyLwHZhBu+B/nhTsd4llVgweh2Gqb9zE7YlEcVxaFV2O9EteBntmgWpLQHdrGD9pmYKv0ztc
	YigsVn1hG61HRKskR/PHVVEmSwUVpwN6JVdRggmL0ih2hq5WhoX3Z0wcZCh236dqr49lvKpehRYlV
	9TcjsQNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qVYWy-00HKvZ-18;
	Mon, 14 Aug 2023 14:26:52 +0000
Received: from mail-pf1-f182.google.com ([209.85.210.182])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qVYWv-00HKtW-2I
	for linux-nvme@lists.infradead.org;
	Mon, 14 Aug 2023 14:26:50 +0000
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-686ea67195dso2875721b3a.2
        for <linux-nvme@lists.infradead.org>; Mon, 14 Aug 2023 07:26:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692023207; x=1692628007;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lqPfjKBh4fEn5Wj87LjUhKggel2I0g0zW4XnW9s14SU=;
        b=hW9LlHgEsUGZL5GPWyzdOdszkypw0said+dWaL/W13T9LzTlTviEDHtvaKI8n28cbJ
         TeWazXz0KLrsVNtdxj4whc0qbrz8Qhihw5TMnvimlu/B2iI9qeTjFVu6D0eoyx6Uwiu6
         XdG9dGVO6XoOd2lvqb3Lo7hP+n6eUEOraxbYnoR7IOulT6mOleKrpzlMUu8p5tXjWAUZ
         v2uG8ghkzmbXq6FW4WoFVUhlKLs4GfQfasosk2HZp+rZACJI3iL0cdoUKIjqET0sHTPS
         KRZ3/FyPHOR76nMCJyEW6uzGVJlk2Q0SlWhH6u+ORw3hWC+QYpKCa8njLFpgIRvmnBNJ
         rxbg==
X-Gm-Message-State: AOJu0Yw3IoEvQczeMzx9KgU1qgnZB870r05z65q8c4LB9YfXu7YfBB+g
	yevIsiIU0NSpelQ8hREtJLk=
X-Google-Smtp-Source: AGHT+IHOmH/CPfbHjiPSRAabws5WhG05U7tv659QbNd/xn288gX5HmehFp2dEtU52oDRt4xSfXpfVg==
X-Received: by 2002:a05:6a21:7985:b0:135:2f12:7662 with SMTP id bh5-20020a056a21798500b001352f127662mr8501008pzc.33.1692023206792;
        Mon, 14 Aug 2023 07:26:46 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:e105:59a6:229c:65de? ([2620:15c:211:201:e105:59a6:229c:65de])
        by smtp.gmail.com with ESMTPSA id x17-20020aa79191000000b006874c47e918sm7977606pfa.124.2023.08.14.07.26.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 07:26:46 -0700 (PDT)
Message-ID: <abad92af-d8b2-0488-cc75-01a3f4e8e270@acm.org>
Date: Mon, 14 Aug 2023 07:26:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [dm-devel] [PATCH v14 02/11] Add infrastructure for copy offload
 in block and request layer.
Content-Language: en-US
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 dm-devel@redhat.com, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 martin.petersen@oracle.com, linux-doc@vger.kernel.org, gost.dev@samsung.com,
 Anuj Gupta <anuj20.g@samsung.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 mcgrof@kernel.org, dlemoal@kernel.org, linux-fsdevel@vger.kernel.org
References: <20230811105300.15889-1-nj.shetty@samsung.com>
 <CGME20230811105648epcas5p3ae8b8f6ed341e2aa253e8b4de8920a4d@epcas5p3.samsung.com>
 <20230811105300.15889-3-nj.shetty@samsung.com>
 <3b1da341-1c7f-e28f-d6aa-cecb83188f34@acm.org>
 <20230814121853.ms4acxwr56etf3ph@green245>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230814121853.ms4acxwr56etf3ph@green245>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230814_072649_747137_BACD6486 
X-CRM114-Status: GOOD (  14.75  )
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

On 8/14/23 05:18, Nitesh Shetty wrote:
> On 23/08/11 02:25PM, Bart Van Assche wrote:
>> On 8/11/23 03:52, Nitesh Shetty wrote:
>>> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
>>> index 0bad62cca3d0..de0ad7a0d571 100644
>>> +static inline bool op_is_copy(blk_opf_t op)
>>> +{
>>> +    return ((op & REQ_OP_MASK) == REQ_OP_COPY_SRC ||
>>> +        (op & REQ_OP_MASK) == REQ_OP_COPY_DST);
>>> +}
>>> +
>>
>> The above function should be moved into include/linux/blk-mq.h below the
>> definition of req_op() such that it can use req_op() instead of 
>> open-coding it.
>>
> We use this later for dm patches(patch 9) as well, and we don't have 
> request at
> that time.

My understanding is that include/linux/blk_types.h should only contain
data types and constants and hence that inline functions like
op_is_copy() should be moved elsewhere.

Bart.


