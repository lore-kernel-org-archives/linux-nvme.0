Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B34FC47DB3
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Jan 2024 20:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=nmw987Mu57zAgwsUnSmj9zOTEL
	9/HbGlSX2USpJdzg0Lcn5yoY/tF3GM/m+PHdkAbZBuheuZok9MWv9BaDubmg1hnkOFIIMdCiKeDrA
	1duZBS7MvXrZSnusHJlcZoJhzGbBUGA3kt8/2VuZKL0Sl9WVWyH500gGkJPGHO5z/9a24eEd5PLUU
	+pFLtW1mUB5asfGcYWhVfv5awnWPhh61OfhnSjdDDFVrmxJDnTePTSX8VW3dbIyuYHSBqzhrNJWrK
	xk+L5A7g2vlhgzjWbZ0yM6nnwdGoGZaqai1P2YPdyV0mi/N5iCo3hzxcSwzw0ZJN5xRAR7boW8OsA
	ImtYwdhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVHbc-00000005P0K-3V9i;
	Wed, 31 Jan 2024 20:54:48 +0000
Received: from mail-wr1-f48.google.com ([209.85.221.48])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVHba-00000005OzT-13d6
	for linux-nvme@lists.infradead.org;
	Wed, 31 Jan 2024 20:54:47 +0000
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33afc8000c4so3217f8f.1
        for <linux-nvme@lists.infradead.org>; Wed, 31 Jan 2024 12:54:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706734484; x=1707339284;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=TLU8EPjJlhKW+UcBAAya2lCSriip69XsNxGeXuazxi2xOhhaVvYiDb1oprJPp7wnrN
         a4SuYo4zDY00VmkmWHcMa8SggvTYTIdqC6m5UnlaTHTXxXBFAfisDaWO6ETL8oDqWv6r
         1C1EHP/O1595DP54qYT7XA6JCMtXca5JqpOAib9z5h0ux6S03W9aMzasig4EtkiYJ/kY
         4bQvYYpFHgl2+Ifb+ZbGUqxjefs1/TqbTb4PnT1kbYQTP3bSc2AltXE3jsCWZ7xc37OB
         cBfS1G6s+pFCMmSLqLCcQ5U+w2DuGiDDXZXp+MLRSXTzM/3ku/UD3JxdXlP6nNHBIHKa
         L0wg==
X-Gm-Message-State: AOJu0YxQbxMNt247uiH5lVSzQNOmrc40HfbmYspgEZ9jSLJebpj5VDMg
	9YOrerlnYJrQ+eX8tjePIEjP/WAGSXkF5s+wGSmaWbSN5kpwlKBl
X-Google-Smtp-Source: AGHT+IGypp5gMUDU8D8Z2BXW+EBB4UVeb62tD07i5lenSdzB7j0xkxrvSJOn9FlFv+mxEQ79htBcjA==
X-Received: by 2002:adf:e7c9:0:b0:33b:10ca:d85b with SMTP id e9-20020adfe7c9000000b0033b10cad85bmr428520wrn.5.1706734483235;
        Wed, 31 Jan 2024 12:54:43 -0800 (PST)
Received: from [10.100.102.14] (46-117-114-124.bb.netvision.net.il. [46.117.114.124])
        by smtp.gmail.com with ESMTPSA id u17-20020adff891000000b0033ae55db108sm11746897wrp.20.2024.01.31.12.54.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 12:54:42 -0800 (PST)
Message-ID: <517563a6-e4fd-4e94-869c-8a7e015449d0@grimberg.me>
Date: Wed, 31 Jan 2024 22:54:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] nvme: remove redundant status mask
Content-Language: en-US
To: Caleb Sander <csander@purestorage.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 James Smart <james.smart@broadcom.com>, linux-nvme@lists.infradead.org
References: <20240131164315.160042-1-csander@purestorage.com>
 <20240131164315.160042-2-csander@purestorage.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240131164315.160042-2-csander@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240131_125446_298806_10AFACD2 
X-CRM114-Status: UNSURE (   6.08  )
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

