Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B627C4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Dec 2023 15:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eCfNy8EqMA/JyCZH91JO84dVzkMRC3iFbJaqdV8e5xs=; b=cuiXVdejyLovXM/pBDQuyDd5ea
	GBB1bm9IBa8pLqVX+YTil+p8p4XJwP46RoJqJWQ2zUgZlYczaEcP14vykT+jOiklGDOWN2wt8iS7o
	c6NvkUsn+97OKt+CHHcT59M85t/HgnW2n9aua1dzS9P3hf7tkYDzBxwfyGY5PPkfqnbYmHhoR6ffn
	CdkF86po6D1BoT3EKs4iRNwKJfE3sUWxXP56FR7+LnqtdT71MbDYIXmSZJg79uGLTL3NqQGhCIOjt
	oTml4fAnAPBeepOgM2bMO+/WLVw3t6u0R5FMicevem8iT8SSCW38O0dSP3Nta/RSaCb4hEKnmv3+X
	lk93TR6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDQjr-00F80r-0G;
	Wed, 13 Dec 2023 15:01:31 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDPfM-00EuDe-21
	for linux-nvme@bombadil.infradead.org;
	Wed, 13 Dec 2023 13:52:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=eCfNy8EqMA/JyCZH91JO84dVzkMRC3iFbJaqdV8e5xs=; b=vIFJwLI9V13DvK5W6gw7/sajfP
	+7fAlEWXX0uta+JRuSP4+98JWiA3Aqx2u8Q9GyMxmB53DoNCKFI3eTT4N3iBSGa6CX+efa1Vu++Ln
	Eiul8HpN6TFgCZ9ifWyhs6ULELns1cmx32J9j8qtLE5uZbzhleOcbw7mnvHhBRJeYJhf0Y7Ph2Tsh
	nOS0Ba7ZOttfgLcZdi/E7B59tC/QnmCD53BKUhtzJ+nS0j4WnDLpr5OWY6JqxVnwFZultaxrrYjUg
	QTQHG5syPn7phnPejIZfWYc5Xl7MRzgSHIgslpUyD4N9c7Nwj3Zo1rEiHMUTYXCruO2cq8HXtOUdy
	t7fLmpzA==;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
	by casper.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rDPfI-001u8O-2x
	for linux-nvme@lists.infradead.org; Wed, 13 Dec 2023 13:52:47 +0000
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40c495ab68cso5935375e9.0
        for <linux-nvme@lists.infradead.org>; Wed, 13 Dec 2023 05:52:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702475563; x=1703080363;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eCfNy8EqMA/JyCZH91JO84dVzkMRC3iFbJaqdV8e5xs=;
        b=rjXW9TF0cLtD+4IW5KgRJ1jI5+anS7gpclnQr7xG+9Mc3TsVL+oKQDUIXey3yiUhM/
         LvqPmrc4X4kty1srcaSBrnMPeq5LKWn/SCxKwDMPnimLGs3fL8v6TReW6DUEt2cEKflj
         M3hlGI4LvofaARsQkjrwWdvBG+nTE42FOPk5UYT0ZJ5/k6rFRUyr9diBeqDytPUNW4jT
         8D+vOBwu3boa6V/NqwGW5/ofd1GvRg621y088nRqAFfmoOisywevQoEHNv6cARmEqJSq
         OnqizQoaaQqmLYsGCIgrbnL51cuIdYTDWsGiZ96Q3mk1jtjY9QsYEHjQvN1GmsfxJXWi
         HoVg==
X-Gm-Message-State: AOJu0YzGDIQ/hdOh/8z+nEKBT7v2mnFPFNENJjP4tz0cBkUOmfxFT7Di
	s2hAYyZPrno+Hxfr3jyWS3Q=
X-Google-Smtp-Source: AGHT+IE75a0gzkRVFIWYqPWL/OTO1sBqXhvJLokHvdmsJjyz/Bvo4mMr86oWPd7eX4aiOzI1LnTkjg==
X-Received: by 2002:a05:6000:4026:b0:333:4ae7:b3d1 with SMTP id cp38-20020a056000402600b003334ae7b3d1mr8878453wrb.7.1702475562991;
        Wed, 13 Dec 2023 05:52:42 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id t4-20020a5d4604000000b0033642a9a1eesm674707wrq.21.2023.12.13.05.52.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 05:52:42 -0800 (PST)
Message-ID: <0b4a826a-72a2-4736-90b4-f14963054319@grimberg.me>
Date: Wed, 13 Dec 2023 15:52:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] nvmet: return invalid filed when check fctype fails
Content-Language: en-US
To: Guixin Liu <kanie@linux.alibaba.com>, Christoph Hellwig <hch@lst.de>
Cc: kch@nvidia.com, linux-nvme@lists.infradead.org
References: <1702449172-8920-1-git-send-email-kanie@linux.alibaba.com>
 <1702449172-8920-6-git-send-email-kanie@linux.alibaba.com>
 <20231213084835.GF6184@lst.de>
 <b35be92b-d6a8-43a5-a542-2083f191ccfe@linux.alibaba.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <b35be92b-d6a8-43a5-a542-2083f191ccfe@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231213_135245_313341_14281F10 
X-CRM114-Status: UNSURE (   6.49  )
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


>>> Return invalid filed status code when check fctype fails in
>>> nvmet_parse_connect_cmd().
>> Hmm, the fabrics command type really is part of the opcode.  What is the
>> reason for you to prefer one error over the other?
>>
>> Also s/filed/field/g or better 'Invalid Field in Command'
> Agree, by the way, should return invalid opcode in 
> nvmet_rdma_map_sgl_inline() if nvme_is_write() check fails?

I think that in that case the invalid part is the sgl, not the
opcode.

