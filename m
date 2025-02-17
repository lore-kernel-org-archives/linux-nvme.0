Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5F8CC021A0
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Feb 2025 07:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=L7FJKldb6Xwh+5xtHOUls+31HC
	JxtrVt2ROyED/TYtfohMsg184wxcdsidw2+yu6RUMvz1akq4g3UQ6Obl/O3J45KVPIKth+y36ATx5
	W4vZcFX/jqlSxSAljTERX7VvEFUV7WdTmtv1HIA/Ut/zrgsn3ens1EBaic+popXYDQw6QKBaDHT8w
	OMNnbi9nBzPPyOx/iOZlOiLFNscmMaBcvwH6+nYZgs5fJGarQ5+SJudBEo1YJ9qR1UFOGTiq/EBzU
	XiY1TWNfJJr2jAeat2nRCQQCFNwwRa/0BIBhIxg5DWa15gLt29PgTAiSlIO+nEzdep3sT5+XobVfv
	/HTI5SZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tjvqz-00000003eZ3-20h5;
	Mon, 17 Feb 2025 07:47:45 +0000
Received: from mail-wr1-f48.google.com ([209.85.221.48])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tjvqw-00000003eXV-0wDM
	for linux-nvme@lists.infradead.org;
	Mon, 17 Feb 2025 07:47:43 +0000
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-38f26a82d1dso1776632f8f.2
        for <linux-nvme@lists.infradead.org>; Sun, 16 Feb 2025 23:47:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739778460; x=1740383260;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=oXL+hcMdqubONC2MBfyyAx2CJOR0G4qpJAY0WZQkPv+8FNGcXc8hxgmF5JrQXsLa9w
         b/tUQtPzAOPuhTGZN1W4QA8t1T3DIRsx8doW3UPFZIe2x3+2v4fAP276bZnLyJY2YSRu
         Aomawf5iN+/s7SqGrcQ9+IEmvMB/mXYhmxJE8L/pbp8UucKJ4NoCkHgMocjMa5HFTAv6
         F2FXR8+QjrWJmghHZnsOUcpci5TZ5st0yBCwT1Bj6u8Y7x/cVw605fv0AKT4jrt9Z1rB
         rcCULCKxjoORg+IXX6BH6gtQ079I9x2Bz/hYrmp/es4iEPFHmozxQJ+sDkPueeWS3dsr
         i7jw==
X-Forwarded-Encrypted: i=1; AJvYcCVX+aF3zVgl4bpPzR6qW8pbuc7K/8rzkTUB8ZBU6fWdLf4rA626ckmOTXldolAdQvMNk2N7qldEalQ1@lists.infradead.org
X-Gm-Message-State: AOJu0YyMR3fFCrx7QCHN9VKzquWOsBpHWCv121Oq6jEREr732WbFESW2
	RZqJiRNB7wHi279jbm2W70rjTYLlM/Y0w7R/WMps2O0jnW8Iy+qj2wR51w==
X-Gm-Gg: ASbGncsFh//AVMcjLcpzwmxlCWysyZRaaB0tfNVkTDGYceEUCHgtR/m2r41ERVJ0SaP
	qBMS4u7gVBn5qtwycWLEg8Oszl/zCOSYoR4T4BxxXp9MyMhXLKNfvSZX+LHbpzfal7TEwnuTBaJ
	2lF2fRv0bA4u2fEMJHRBXoASdlvDU8y1xgfDDw6m11fmAANSPcuhuDQHvroZodP9I83c6d4TbNn
	3RWNeeP40DzmwdR7tm0tPsF24owfFeecnOflpw2VFQDjrLq54TdnRgSuxzFuF8r5giK8CV3jwAR
	pDaRQvmWZYGAWf1+hAknOsS11eq2kio7S68KyS9hzZYYNkjGnJAcGHZPhA==
X-Google-Smtp-Source: AGHT+IHMa9fmqadssPBMph9dY+itVRu4xaBVcLAN5Y989tHycK6wqzSZTAV/7QmPKsAF3yrKxCC3ZQ==
X-Received: by 2002:a5d:64ec:0:b0:38f:47f0:e7b7 with SMTP id ffacd0b85a97d-38f47f0e871mr1444884f8f.16.1739778460381;
        Sun, 16 Feb 2025 23:47:40 -0800 (PST)
Received: from [10.50.4.206] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f25915146sm11659479f8f.56.2025.02.16.23.47.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Feb 2025 23:47:40 -0800 (PST)
Message-ID: <85fcd631-27cf-4202-a10f-93b6ecc04628@grimberg.me>
Date: Mon, 17 Feb 2025 09:47:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nvme: tcp: Fix compilation warning with W=1
To: Damien Le Moal <dlemoal@kernel.org>, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
References: <20250210002815.1744205-1-dlemoal@kernel.org>
 <20250210002815.1744205-4-dlemoal@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250210002815.1744205-4-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250216_234742_261779_978B08B8 
X-CRM114-Status: UNSURE (   5.06  )
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

