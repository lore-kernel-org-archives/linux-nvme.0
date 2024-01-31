Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87614C47DB3
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Jan 2024 20:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=KlXCH0CGC4zzmpGMfp4pZ0v298
	4VEQT0EofZGhG7bWJs1iAX87SxcB0N7i/9Ufxe4T7GUPtoJYRC1q9K+miOhXaZngLNukcTpVU3mO7
	mGfOtAQWP0RM4boIoFBzIp4tNP/OGR6sEe82MzRA7FXC/yDtO9BUVFL4qu1X5kI5BBprJD75eCdor
	mR/jqVuX8iT6sESSxZC0BiKONcBewz8xMgy9mMmPan6hqFmCe/7rEDgOcewoaO7CNUYiqNfhfaawh
	01Aro0nl93fqcHWtwW77CPM/DXBWnvlQZhGH7gYI2XSaFt8aFtZF+Mg0b0rEvMhmEXW02pOgz+XP/
	OMB6Yv9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVHbu-00000005P53-0MaK;
	Wed, 31 Jan 2024 20:55:06 +0000
Received: from mail-wm1-f48.google.com ([209.85.128.48])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVHbs-00000005P41-0oYe
	for linux-nvme@lists.infradead.org;
	Wed, 31 Jan 2024 20:55:05 +0000
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40ef107b38aso105495e9.0
        for <linux-nvme@lists.infradead.org>; Wed, 31 Jan 2024 12:55:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706734502; x=1707339302;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=D0x6iBG1THoujlXdYE2zn1TrszEcKMu+WS6DudzOezhfQh2fNUBWxSWR4CrRjde2m3
         MLrghAh4FSQuInBrFyEpDx+r4LUgSfhfiTYKi+7IPUMn8aa6slBJpemLGzocUuqgl4Rf
         xOPQYcbwaLJntF56VwInp9tUGBbCcIuyMo+0lbnnjtXYXGPrnzjhKKcZ3Eqgpml7ZBHn
         o02GzjUWjvmadXtXWxHWDpBIMtDU81uvp1q2fLf/6HSsVGHTDfX5nswAs0KBUDUE4UbU
         7pT2B1szpHhauGuyS4wNztQIQvUlHmiphCQvSdaIHkZGZuoiKg5WMmTwy9+9AAYy7FKI
         /REw==
X-Gm-Message-State: AOJu0YxmnhqROJW1ZIb5ovrYjKKqgGTfjs5mHR4lVqiszunAlplMRAqU
	C23fnSlvMQYSW7wkiBa4wf5rjxXgJu7CZPJHD2uCDVXxvrK31mVB
X-Google-Smtp-Source: AGHT+IGejgRFki+jvarf7KTgknnRoV9fTLVY0IuoVgP4fHNkqSivw9bbzWUe2VsM+HoWqsGFewkpUg==
X-Received: by 2002:a05:600c:1e87:b0:40f:afd7:47e0 with SMTP id be7-20020a05600c1e8700b0040fafd747e0mr525682wmb.4.1706734502316;
        Wed, 31 Jan 2024 12:55:02 -0800 (PST)
Received: from [10.100.102.14] (46-117-114-124.bb.netvision.net.il. [46.117.114.124])
        by smtp.gmail.com with ESMTPSA id u17-20020adff891000000b0033ae55db108sm11746897wrp.20.2024.01.31.12.55.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 12:55:02 -0800 (PST)
Message-ID: <414da498-06c7-4345-a3d3-06e1ad36a4ce@grimberg.me>
Date: Wed, 31 Jan 2024 22:55:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] nvme: take const cmd pointer in read-only helpers
Content-Language: en-US
To: Caleb Sander <csander@purestorage.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 James Smart <james.smart@broadcom.com>, linux-nvme@lists.infradead.org
References: <20240131164315.160042-1-csander@purestorage.com>
 <20240131164315.160042-3-csander@purestorage.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240131164315.160042-3-csander@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240131_125504_245065_63724172 
X-CRM114-Status: UNSURE (   6.09  )
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

