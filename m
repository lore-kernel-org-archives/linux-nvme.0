Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD485E77188
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jan 2025 10:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N/uCwKzDh3FYyz82pEy5qH17CZSuAudkyQJKkNNoY34=; b=qZkLhF0WCd9zwhbWqW0SG+ntOS
	NZoI+Xa1IsrlJ5axTsdWS5judEEuxHabm5kV+i2wm6Y7u9Ifbk9sVIdtxGSTM6SSp42KSKPEHZTnc
	wCm4MHihMU+F6/0xFZ7u8FcU7JbliEeouMJp3n0k5ikCjtolvU0vBhvyaolaEeVK7pjgfnrzVTmxb
	USqkzPuStDlBuSAr46UMxLZyoZrFc6wrRzQUh+htPVuWS439iivEbMTcQciBmUKVUQY4XnHwRG4bE
	LqC8FQGz5+RGX+bKswS4nex2v5k6hlDoY+O/ncsML9QioGMaRQTIWtPr6hFtA5SPjZp3fkMMbT6tO
	D6l6LdZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVTmg-000000086Zd-3ZSp;
	Wed, 08 Jan 2025 10:59:34 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVTct-000000083Xg-3BZK
	for linux-nvme@lists.infradead.org;
	Wed, 08 Jan 2025 10:49:28 +0000
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-436202dd7f6so187330725e9.0
        for <linux-nvme@lists.infradead.org>; Wed, 08 Jan 2025 02:49:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736333366; x=1736938166;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N/uCwKzDh3FYyz82pEy5qH17CZSuAudkyQJKkNNoY34=;
        b=b7I5cBVXgiSSpKdIIKOamPK65nCM1/Xzwiz4/WsrO4Jwl8A4BUbSeBl1qsb88IT/n/
         IPkZNG2Hz5wmS4j/WdNAE5oBbIFCeRV25vr/DTD8Cbzt0Z6KDvPRYWezO8NG3F91B1OC
         Ds4bEizse9rklZ4LzrOL320aIqz8Efk+HLRiYRNE5qbhdxpcvcuU424sBsNQqlWcHd9U
         N88HG5R2mrCeioQGUKbKEkQP88NN55+SM4LITq3squ6jgLGjwDurc0DcoSoXwjWbxv7w
         oXQtgbuOHkApnpxPvSC6849Q0DYp82e0wad67vwy+Ugy0D+PXkRXK/Cv1xYaojbVoIEd
         GH6w==
X-Forwarded-Encrypted: i=1; AJvYcCXIAiQGU1NlfSm6657ed15gF2OgiS4nRFuu7TKs4x/vSGuiUBWcGUL74265UAMi74n9RD3tuT/6CocD@lists.infradead.org
X-Gm-Message-State: AOJu0YyjL0XMZnvuxJxRJg7Z1iFbbRKojf96My5NXmkHUMm8wNp9ZzIQ
	DG97VBhJwDmna4aAXScgxXEbJRvAejc8GgGq1+lGWG2gBi9LBm/I
X-Gm-Gg: ASbGncuCmD6U/OgvZTetmdmmuCiM+FaR6ovE8y2ign9i3aOjiE/nLYmFCz+mQWI0hGQ
	eEgj2V9/mpw1P2UlBYFlpoLsiGBR52jhS51tlgThfqaIAGZbXvMyS7x17/wbKaloLjubXAWbk9q
	bNNs3TJGYk8L9Ggl0mCRTzujReIPoqxnkcGcZT0ZTlG6AolqZn+DOIL/6b6dRiayNhoTgH3xHqi
	gfgG7tLR9N/9qFBxdelyqpNzQAff2+yp99ng0k1nf99YLAkGFKoPHVa/vheAxR+GUcWKRGx4KpD
	ldAd7mhcWSAjbi8fMHhgjUY=
X-Google-Smtp-Source: AGHT+IEMCL5Lie+DqWFci9jdcgMrq+A2UcmZYhzPpEdtapWqNj/qHyYzLdhw6meyZ7pMPJ4v3D2GIQ==
X-Received: by 2002:a05:600c:5491:b0:434:fddf:5bfa with SMTP id 5b1f17b1804b1-436e268626emr18447915e9.2.1736333365931;
        Wed, 08 Jan 2025 02:49:25 -0800 (PST)
Received: from [10.50.4.206] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2da74dasm16594815e9.2.2025.01.08.02.49.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 02:49:25 -0800 (PST)
Message-ID: <9cdb72d6-291f-46a1-8c80-45ceb75e2b8b@grimberg.me>
Date: Wed, 8 Jan 2025 12:49:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: Remove namespace when nvme_identify_ns_descs()
 failed
To: Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20241129140608.115282-1-hare@kernel.org>
 <f6229339-5b1f-47d5-8eb1-d11ed2fc2281@grimberg.me>
 <bb69b9b9-ad56-4c83-a848-a4b171896097@suse.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <bb69b9b9-ad56-4c83-a848-a4b171896097@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250108_024927_799435_E1EF51F9 
X-CRM114-Status: GOOD (  14.02  )
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




On 07/01/2025 10:11, Hannes Reinecke wrote:
> On 12/25/24 10:58, Sagi Grimberg wrote:
>>
>>
>>
>> On 29/11/2024 16:06, Hannes Reinecke wrote:
>>> When a namespace gets unmapped on the target during scanning
>>> nvme_identify_ns_descs() returns with a non-retryable error.
>>> With the currrent code we will ignore that error on the grounds
>>> that we failed to get information, and hence cannot make any
>>> decisions whether to keep or remove that namespace.
>>> But a non-retryable error implies that the namespace is _not_
>>> present as we cannot retry that command and will never get
>>> information about that namespace.
>>> And we need to remove the namespace during scanning, as otherwise
>>> the AEN informing us about a namespace change will find the NSID
>>> present, but nvme_validate_ns() will fail, and the namespace
>>> will never be updated with the correct information.
>>
>> Isn't that a bit harsh?
>> I would expect to see a specific status line NVME_SC_INVALID_NS or 
>> equivalent for a full removal of the namespace?
>
> Does it matter? If we get a DNR status back from 
> nvme_identify_ns_descs() we _cannot_ resend that command.
> Meaning we cannot get the namespace descriptors. As we
> rely on these descriptors to properly map the namespace
> we cannot correctly work with it, and we're better off
> to pretend the namespace is gone and wait for an AEN
> indicating that the namespace (or controller) state has changed.

I think it does matter. I don't think we should be removing the NS without
the controller telling us that it is actually removed.

