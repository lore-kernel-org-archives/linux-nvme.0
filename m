Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C391D41D45
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2024 01:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0aZxHehuFin5Xrs40VllxGZ7a3/ahEo9jXemQX9Fay0=; b=Ge2/JIgj3BAZF6DpRALiwVzR7T
	CtL+D5UZmOqmLpX0l1mUHoksA91LFunCO/mxBuTsPUwt9jZmTYDfY1/d3I6sjaApE9bJojXtSVosm
	O2FvUpY80LfaH3ZX/AKBwJtlphiKxPDOeb005oGKRdnHEguEQBRYguFJfCaJxJCW0i7m330fArfP4
	aULjBJnXlF8AcdiU/4g0lL/Hljwo5q5PTxTI/xOqq8e0Jzb9xbKrJWs1O4UGOh29XOWI52fWtpV7V
	qsuH+2g2T/LjNNf4moO0Po1YFg1JpnUp77JV3WxKc/xIeP5jqUPcUq2qM7PBtOlAJCv5Gp5is7C3E
	9EviWMsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tAfKn-00000001p1X-0Iq4;
	Tue, 12 Nov 2024 01:04:45 +0000
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tAfA6-00000001n8g-3oNQ
	for linux-nvme@lists.infradead.org;
	Tue, 12 Nov 2024 00:53:44 +0000
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4315baec69eso44724425e9.2
        for <linux-nvme@lists.infradead.org>; Mon, 11 Nov 2024 16:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731372820; x=1731977620; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0aZxHehuFin5Xrs40VllxGZ7a3/ahEo9jXemQX9Fay0=;
        b=AGprt2VqHnxqz7ECKK+opX2nA8iVGVChWxZyqEzpcFM1hXPbD/WTRertagSqhtKmO6
         SR6vQ6vZydpepwdxODtqANWk+wbr3WEIra1eXq2ff3CGf/vbn4dBMGFjwbK1JLZdCyCx
         6RHCzr6PtzLkRcBPjq4NaVemsv3YAkOV6uRfxvUS4kPxpSzw2dKuFxFMs+tmWOPDLNnC
         ztUcLnKUukA8aVoHwpg/AfWg26epOdanA/+lPvT3PMdnOY+F3wC637uKpA7jtSUIffg0
         B3raZhu3ri7wiRKz15wednlfjTarBIr4dnS1JvrkEH9bsTPl12BMfQGgdCl7B28Uy+2/
         dhKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731372820; x=1731977620;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0aZxHehuFin5Xrs40VllxGZ7a3/ahEo9jXemQX9Fay0=;
        b=jc9HnMBXFLUnTNmPzItu0eNyRWmnu21Qaht8rPU1k1FVFZGFk0A2J4T1CkWZYhyq3x
         ZjM0UTpf9omSv7aepHIzE5ZjoD169Y2yEGeV4qziZeuAa0fic0tnru92zsn5/5F/iWgL
         h1Qi1dCKNcHepmfAY1DRbYLJVACaw+QwFWd7zTrwWj9pr8lNW6BulooHLkUYfdos/TZ9
         EdZ/EUGrjBRGTFrKJjuL59ILS6x0TbT6wVamRhQrTBo9KtULoYLXRzuk5m7K8fWsJO9K
         vM+65f2uK682+3SBaAp81fGqvcpA7bgt7p4c2EwEh+qhKxPbWgNRLE827qT8qL2vJrxt
         Edfg==
X-Forwarded-Encrypted: i=1; AJvYcCXJdTEBJqHJz/WbEmLDqzcoo62tb7E0JWrHdYW3wB2jo4TdV242llsmwr8PoYOHmxDkrSLzDgvTfQhF@lists.infradead.org
X-Gm-Message-State: AOJu0Yx8k84tCbLukBfw6OfR2zHMKGOptOCWHnFtXdB3F2FWj/qvYrk0
	dkLyNWQI5gDG9yAJ/v1i/EJdPZCafKb38VcA0VOM3vC7m+qhKngN
X-Google-Smtp-Source: AGHT+IGwHpsOMIYldPnZtYdi6bZCchFzKZKPBSbwlgWRj8qHSABPttz33F7Uj57ko9bJY5t4p4ocvw==
X-Received: by 2002:a05:600c:1d98:b0:42f:8229:a0a1 with SMTP id 5b1f17b1804b1-432b751dcb8mr122259075e9.33.1731372820008;
        Mon, 11 Nov 2024 16:53:40 -0800 (PST)
Received: from [192.168.42.75] ([85.255.234.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381eda137dbsm13779210f8f.110.2024.11.11.16.53.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 16:53:39 -0800 (PST)
Message-ID: <72bb4c21-e597-497f-b54b-d09c6f753d13@gmail.com>
Date: Tue, 12 Nov 2024 00:54:23 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 06/10] io_uring/rw: add support to send metadata along
 with read/write
To: Anuj gupta <anuj1072538@gmail.com>, Christoph Hellwig <hch@lst.de>
Cc: Anuj Gupta <anuj20.g@samsung.com>, axboe@kernel.dk, kbusch@kernel.org,
 martin.petersen@oracle.com, brauner@kernel.org, jack@suse.cz,
 viro@zeniv.linux.org.uk, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 gost.dev@samsung.com, linux-scsi@vger.kernel.org, vishak.g@samsung.com,
 linux-fsdevel@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>
References: <20241106121842.5004-1-anuj20.g@samsung.com>
 <CGME20241106122710epcas5p2b314c865f8333c890dd6f22cf2edbe2f@epcas5p2.samsung.com>
 <20241106121842.5004-7-anuj20.g@samsung.com> <20241107055542.GA2483@lst.de>
 <CACzX3As284BTyaJXbDUYeKB96Hy+JhgDXs+7qqP6Rq6sGNtEsw@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CACzX3As284BTyaJXbDUYeKB96Hy+JhgDXs+7qqP6Rq6sGNtEsw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241111_165342_989347_BEBC446C 
X-CRM114-Status: GOOD (  14.53  )
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

On 11/7/24 07:26, Anuj gupta wrote:
> On Thu, Nov 7, 2024 at 11:25 AM Christoph Hellwig <hch@lst.de> wrote:
...
>>
>> struct io_uring_sqe_ext {
>>          /*
>>           * Reservered for please tell me what and why it is in the beginning
>>           * and not the end:
>>           */
>>          __u64   rsvd0[4];
> 
> This space is reserved for extended capabilities that might be added down
> the line. It was at the end in the earlier versions, but it is moved
> to the beginning
> now to maintain contiguity with the free space (18b) available in the first SQE,
> based on previous discussions [1].
> 
> [1] https://lore.kernel.org/linux-block/ceb58d97-b2e3-4d36-898d-753ba69476be@samsung.com/

I don't believe it helps much anything, placing a structure on the
border between SQEs also feels a bit odd.

-- 
Pavel Begunkov

