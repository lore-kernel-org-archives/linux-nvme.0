Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 164F4C3DA79
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Jan 2024 09:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=ksv01qn13TKhWc1sN3v2QfL/JK
	EIgXwbijFdtu19piEP699/3HaEmAOqmIdfCPuXwfvAXbtU78xNNLNm3Vvubif10MbewyKiHDdwdti
	32kMhMDCXshPm2sB10wTH/MOMKEOdZMgNnGqdtXjLew5wy+HLKM5N3+/ERZuVR3ME6ZECwn6qEsSG
	9TQ2j80pSh8LyqPMYUP7UTeIvyBA3LVB0AJORcxRiDhC43L2+4ff30md4uw2BAqZ+9gHAYqEgAW+6
	lxyuzDmGIgJzV2izVjKS35Ck7xyYCD+LLYWxf4cXN7HT34RS8RxbUvAVBSruv5WOR1MAi07VSmPKn
	+x0QPGHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rPIsE-008ME5-1o;
	Mon, 15 Jan 2024 09:03:14 +0000
Received: from mail-pl1-f180.google.com ([209.85.214.180])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rPIsB-008MB7-1w
	for linux-nvme@lists.infradead.org;
	Mon, 15 Jan 2024 09:03:13 +0000
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d5c0d58909so1806695ad.0
        for <linux-nvme@lists.infradead.org>; Mon, 15 Jan 2024 01:03:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705309385; x=1705914185;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=cisJIXdhkAH34LRhbdk0kK2gQuQnpeYZNDT5cv6hW99JkDk73DbcKL6jOmwBDZLzj0
         kUcWr3MUeqwmwJH4GlYLTvv4T0xq8mf80BoMtx/sourmBNqd4i6CQgVx8nxjPZPKo+7w
         Az/7gEdR6lkn9G2wOmSbcoAeKTWaMY5RuRjqJppXoDVwnLJY3A4c0+1t3NqdlLi6IQ+R
         nYIGdJL81a6FGHgS8Hl1xiCKvsVAw/6EKNSbiPsfmCxSQtUaUe38KORqtFhkrhMHPJSP
         vTVgY3r17ETDwLKcuX6TfUpN+KgaHwi/h1Hi0gkBcohGGVOyCx553cI7NLpp+ixoyEuR
         Vhog==
X-Gm-Message-State: AOJu0YwQffoCFW+vczJB4q8ycToyFJpmm0TnBIf38ngktvq7jOZ1KJME
	Pf4CO7upq9BKGVawC62a3d7Um+st0Pk=
X-Google-Smtp-Source: AGHT+IG7Gzg3/wBVUQKenN5elDBI2M9Au1Q0haIMIJ/1X+upOXQ6Qz42LIcR9VIDLgP6IWe2zXnr2A==
X-Received: by 2002:a17:902:db0b:b0:1d4:e308:cb0d with SMTP id m11-20020a170902db0b00b001d4e308cb0dmr10739546plx.5.1705309385461;
        Mon, 15 Jan 2024 01:03:05 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id g14-20020a170902868e00b001d5d4c24de3sm563956plo.165.2024.01.15.01.03.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jan 2024 01:03:05 -0800 (PST)
Message-ID: <30588b9b-0437-4939-81fa-169a74243060@grimberg.me>
Date: Mon, 15 Jan 2024 11:03:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/3] nvmet: unify aer type enum
Content-Language: en-US
To: Guixin Liu <kanie@linux.alibaba.com>, hch@lst.de, kch@nvidia.com,
 chaitanyak@nvidia.com
Cc: linux-nvme@lists.infradead.org
References: <20240114092314.63694-1-kanie@linux.alibaba.com>
 <20240114092314.63694-3-kanie@linux.alibaba.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240114092314.63694-3-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240115_010311_641265_4E25E74A 
X-CRM114-Status: UNSURE (   4.45  )
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

