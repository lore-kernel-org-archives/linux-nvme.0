Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E5E0C6FD1C
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Mar 2023 07:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ozfpzcIw5bmzhI/c0N95WfSyN+rzsTrs2UI0Fge2fYg=; b=aI8BMhMWYYaWjdVThOM5536Awk
	Sa77rFoErptZMzzkK11+RIuPZKwlME6X0PsUI8duMlldA43t90sDLi3i/uRFPyQtb6we2zZKFSbnh
	90w/kAEyQSPyOjqIOJP69Emmu2jnH2Nz9RxUlyCkmD4sGFGIFk0q+6yQ0KOfSmnc/QyZV/zzB8pfZ
	RtPMePLR+rHenxoGZsD+Gc9eMqvKRqjMbO0HztKJISKAbA2vR9+ecbNi+Y/AynzfdrVzMGcTCPiat
	uB/t/q347JxlzwkveUiH4UrgHJ6r1LIC0BsUwDh6JFDEm9DznQKTkUjzWfN36UELWZpTX9GuWIoFT
	Az/26G5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1petAx-00F2xr-0D;
	Wed, 22 Mar 2023 07:46:27 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1petAv-00F2xW-32
	for linux-nvme@bombadil.infradead.org;
	Wed, 22 Mar 2023 07:46:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=ozfpzcIw5bmzhI/c0N95WfSyN+rzsTrs2UI0Fge2fYg=; b=X3UlAqAI1wzxenBmU0PKfpMcAY
	NltTobe+CutA8cbtariIHz38Nsy7TnkW9bc3wogr7tDVPWHOyqNEWYjA19ykh1FwUdmOlFzXsjuip
	C+amwYWl4Igwt1DBmDZWWRV1hWiiaPTW/8Ge0ZHC3dpZ74rlaswvin5WQ/d2u0VSwCMChfmZmOW/m
	B3BxSh+qkLll9HCq09xPDWhMel2aoGpQA4CRdbbR8uQ0Uyl3jhIaVGn8T+8PA+56CavC7/IgjskNK
	w9SftwJqBgxdhWiYNjYY6mMmjcMkyeNiqk1fBuy4kEHtuH/4JoO0Ex9Rc7qbCvuKHBH2geG2YY4xj
	TDjY/4hA==;
Received: from mail-wr1-f53.google.com ([209.85.221.53])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pesfF-004UsY-0S
	for linux-nvme@lists.infradead.org;
	Wed, 22 Mar 2023 07:13:43 +0000
Received: by mail-wr1-f53.google.com with SMTP id v1so9843050wrv.1
        for <linux-nvme@lists.infradead.org>; Wed, 22 Mar 2023 00:13:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679469211; x=1682061211;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ozfpzcIw5bmzhI/c0N95WfSyN+rzsTrs2UI0Fge2fYg=;
        b=1N/MBY/+HH2Z6a6mMj2KIV4EZuHwHuN88JIBxrC+mxu7ye9E/zItyefyiG8YLTYX+a
         UfxLd9QciaUD17WtlRUbYn52BoPMSchZOSzURdV8PDdF6gNsx60IxhHAtyzChQ88aXKO
         KFzyOtcwNEvkoevo9b7NaSycPodTwWQ8GXtITkHxElSCWobYteergWPOPlcrj4ks2S0z
         hUtWZIWdms8mFJWEpy6E2ksqDQ1vrLpdfICWQe2B40Jsgu5org1/LjK0CHUGalU3vwFv
         2YaHrf4ivFuwsUfuID+Ov/VcN/Y0LUttH4RQJzF93oXsOoNS+9l0mZLso2O3csMBzQP2
         549w==
X-Gm-Message-State: AO0yUKXFgPzZx4h7o1rGqu/Vt11O9+wkm16ox8l7fdXJV65pmUxAKevc
	edPLXPg8pQdun+C2DgKFZMYjuGh8YGE=
X-Google-Smtp-Source: AK7set9AyoVShpgF1Yq1JdYPDoOLAmu8AFbVC3HYM6J2LDzS8FpsbGT4WhjAbo93XwmTZgZQsgTFyw==
X-Received: by 2002:a5d:4c45:0:b0:2c7:8a6f:5568 with SMTP id n5-20020a5d4c45000000b002c78a6f5568mr3222915wrt.3.1679469211630;
        Wed, 22 Mar 2023 00:13:31 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id z15-20020a5d44cf000000b002ce9f0e4a8fsm13192372wrr.84.2023.03.22.00.13.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 00:13:31 -0700 (PDT)
Message-ID: <a44d2c1d-c700-4465-e1c0-251135388852@grimberg.me>
Date: Wed, 22 Mar 2023 09:13:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 1/1] nvme-tcp: fence TCP socket on receive error
Content-Language: en-US
To: Chris Leech <cleech@redhat.com>, linux-nvme@lists.infradead.org
Cc: John Meneghini <jmeneghi@redhat.com>
References: <20230320220947.3244247-1-cleech@redhat.com>
 <20230321163025.9437-1-cleech@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230321163025.9437-1-cleech@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_071341_604878_53B56FC8 
X-CRM114-Status: UNSURE (   6.76  )
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

Thanks Chris,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

