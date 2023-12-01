Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96D23C4167B
	for <linux-nvme@archiver.kernel.org>; Fri,  1 Dec 2023 16:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w/gluQhDC+XWPt+o76s2TZeLugCA4A5lkimzSvF4U9A=; b=zLL1G1XqlrS7Yq5X9ZGc73eA7/
	QmVUR5Ja3mwbqCJPbEMSX1ij4C3U6yr4vKC+jKCrmazWCq/LfaTFPIAaOIMnU6r3nHfjybpgKUyMq
	bBdykyCLq7Sj/1z/ri0YK+UXt+daZycmy9Kl6DnLNRYY28wHv+bhdHH2HFTUy2bcUYsCjR63f5dQM
	yvNg2eig1ALtbx7Wz22W0R9lxWpkLp9+AfJobwxIxaAqkvrkEtC/KThEky8s/3eQQMd3zoq6s5O+0
	7vVwkM5+YSEWQ5GFJ6HV4wXTuM1xAdadRcmYRrCq+5FTSOZa8sIxtY/3iLM6oSunRZa9uzkl2S/aC
	hAiqH3+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r965W-00E7av-0v;
	Fri, 01 Dec 2023 16:09:58 +0000
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r965R-00E7Zo-2w
	for linux-nvme@lists.infradead.org;
	Fri, 01 Dec 2023 16:09:56 +0000
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1d056adf504so1633605ad.0
        for <linux-nvme@lists.infradead.org>; Fri, 01 Dec 2023 08:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1701446990; x=1702051790; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w/gluQhDC+XWPt+o76s2TZeLugCA4A5lkimzSvF4U9A=;
        b=u4YpfKnys+7WvZFHI+SpImU2NpbrnpOS3PLWUIruUu89kwZ5VZ6p3Xs+ZWUy/9Kfzw
         OEiUA/hRKdohxFziYitbONeLzD658e+ek+Kz5a5LLyOkEu4W5R+M0ZROWU8v3ppRc7L9
         r7OfpgGyGSN8WKzvYHBbCNiu2IqzHKYe30cqlewgSQ/1jL5cXqqX8e+i7sRb2FsLBI8Z
         pBTmfxpfZ4sIh3fUvkHjdAx5V49Od+dvk+S+iCkCueuajDnQJnqP3qU2XLj0Sxt7flu1
         6US8UCRGaoUBSfb/pWB1WQWtbP3CsMdRO2S8PevIdlmrVUB3kjb8wY9eFCdCGHY8mv90
         2zPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701446990; x=1702051790;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w/gluQhDC+XWPt+o76s2TZeLugCA4A5lkimzSvF4U9A=;
        b=pVU0Xj8L9dzIsUQmOYI284GF5NFshnm4du9cdGFAFC9tzh/5yyuQSoTqsSh/xsFl5V
         f/2k8eXLD/3dBNrEAj7nfBodJZzxcD9utAuwty3Of2fSNsZ6AVnjsfVIT+m1FBqHrxJx
         JVE223gsr/i2NitRo/nqu49Z3gFweUKBP4e3+6qxJ0qxQKPkSugcM/w5eRnQfSJwz79d
         4DvF+9DBmZj19M4pFx6h3QgrT180YIn4iFiH0QvV2K4qpYlyZkh79dVQ/IiHLparX60B
         QwXbzuZmUvD1g+QQrxM8W5BmTEbikZJ6EjUxM1yaTbHuxY3ZUirtqXXFtEJXuVVYbW+P
         h3MA==
X-Gm-Message-State: AOJu0YyJmEiOjtKssdGdGl/4d8H+/gIbkPyOa9iYQcHJBbc2off4oHwL
	TrHzFvNRW15VgBHPSbnou9vTzQ==
X-Google-Smtp-Source: AGHT+IF6q9DLOGUzoBLTstbr/9R+YWB6JmwLryMk/hTpyyHlfghMcy+42dcEq7JrtcX48XzNx/KIGA==
X-Received: by 2002:a17:90b:713:b0:283:5405:9e90 with SMTP id s19-20020a17090b071300b0028354059e90mr25441238pjz.3.1701446990331;
        Fri, 01 Dec 2023 08:09:50 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id 1-20020a17090a19c100b00280070a2613sm5681943pjj.51.2023.12.01.08.09.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Dec 2023 08:09:49 -0800 (PST)
Message-ID: <5d0261cd-8499-4c07-b4aa-13195f4c0d35@kernel.dk>
Date: Fri, 1 Dec 2023 09:09:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme fixes for Linux 6.7
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
References: <ZWoDiHfUgBs0riE6@kbusch-mbp>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZWoDiHfUgBs0riE6@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231201_080954_174408_460A3474 
X-CRM114-Status: UNSURE (   8.76  )
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

On 12/1/23 9:02 AM, Keith Busch wrote:
> The following changes since commit bb6cc253861bd5a7cf8439e2118659696df9619f:
> 
>   bcache: revert replacing IS_ERR_OR_NULL with IS_ERR (2023-11-24 09:39:03 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.7-2023-12-01
> 
> for you to fetch changes up to 74fbc88e161424b3b96a22b23a8e3e1edab9d05c:
> 
>   nvme-core: check for too small lba shift (2023-12-01 07:49:50 -0800)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 6.7
> 
>  - Invalid namespace identification error handling (Marizio, Ewan, Keith)
>  - Fabrics keep-alive tuning (Mark)

Pulled, thanks.

-- 
Jens Axboe



