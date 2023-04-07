Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2F6DC6FD1D
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Apr 2023 21:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=AudqzBQfRiONVJuik2UmadsPM6
	XBqBIEF4dfz+RZLpIFfORH36O5lFmTYLR+ZO74gUV6Uz5+bqfKbY6nS8GYd0k+9ejC77Nvwk2VsoM
	OOSby5ynkaI5LYoMUanS3OODgj6TIX4D3gv68U6aP3WPa+KhQ8bjlmDwQl8N4zeXWcQ5eIduN4FIL
	+PdDucGwggHGHCcOmAan1mtIGjvXTo+CrwW1FgH3H/yGCNoaEYEQrRyEX6oauy+GcFWIT6y8kjtE7
	iKzeMRVuY99mawqJbuQ0qDO77FScTvzthGZGWUBDK2oulIvUuGLW7GmMtH/ZlZyZS7AidMAmxTr30
	+aYHyraQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pkte6-00BAho-2h;
	Fri, 07 Apr 2023 21:29:22 +0000
Received: from mail-wm1-f45.google.com ([209.85.128.45])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pkte4-00BAhJ-0L
	for linux-nvme@lists.infradead.org;
	Fri, 07 Apr 2023 21:29:21 +0000
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-3f04eb5d1a7so1672375e9.1
        for <linux-nvme@lists.infradead.org>; Fri, 07 Apr 2023 14:29:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680902956; x=1683494956;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=WQmZ0Y6AXfEXVNGuWHDmofJyYSfNlWyaff3z7EiBGo3/1pXVN2QdnOE/1ZfNn1256C
         xWLOqQbk10RXfe5+MkhX4vLZx/UNvZ5oxgyPgD4L/Zsx5pGnudoRVVPnA3xe6sjZRmx5
         E1+55BWlr44xOnad2elFV7REh0MsqR5g7mB32U7OUv4iuPDQP97DXBXSQdARnymoC6Wv
         OlPz9iuscnIFKeQMF0h7gLfRu2u8WMOLxHfT2DUt9TLO5kegJAxw8z3pXfASFAh1bWGD
         OkYULMch6aVhpXSI56pFB/Unjt5O+0MijyeAtCnIcLa4dom4Fyv+9lIaHf6rUY/qIYza
         raog==
X-Gm-Message-State: AAQBX9dEjTKXMTKmnncMuKTZ0CODXiMsFyrInGZkn8CEH1ULh4PcBSiU
	hWF6vJUf/NczHMTYnPbeZtI=
X-Google-Smtp-Source: AKy350bcYKtr4Pih75NyTNfWKnLgJxgyL5bdIr4NCXAFf730hJ3N11OhONVvL+iqUAFSXySvnZwt3g==
X-Received: by 2002:a05:600c:35c2:b0:3ee:da0:cb85 with SMTP id r2-20020a05600c35c200b003ee0da0cb85mr2245987wmq.1.1680902955529;
        Fri, 07 Apr 2023 14:29:15 -0700 (PDT)
Received: from [10.100.102.14] (85.65.206.11.dynamic.barak-online.net. [85.65.206.11])
        by smtp.gmail.com with ESMTPSA id 16-20020a05600c029000b003ef71d541cbsm5805378wmk.1.2023.04.07.14.29.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Apr 2023 14:29:14 -0700 (PDT)
Message-ID: <ee97fd61-b276-2212-6c78-386905f6925f@grimberg.me>
Date: Sat, 8 Apr 2023 00:29:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] nvme: fix async event trace event
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org, hch@lst.de
Cc: Keith Busch <kbusch@kernel.org>, Nate Thornton
 <nate.thornton@samsung.com>, Chaitanya Kulkarni <kch@nvidia.com>
References: <20230405215720.2872579-1-kbusch@meta.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230405215720.2872579-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230407_142920_140277_63DDBAE3 
X-CRM114-Status: UNSURE (   5.81  )
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

