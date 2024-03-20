Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB93BC54E67
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Mar 2024 22:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=zlqZEwPXzXIxGBW89B4TM3PdFh
	YbbKeLL9Ly5CQAk23uahu9rbQVPzqnXgIe+UP0vUkqotaL43DrQg2zJJQk/9sPUUZaOot1IHio23P
	XP+F4yGjDXfrdVdHEtju0og/EcpP18nd2yX3wFPYUxlCknVodUbJY5RcoBHv8o2YPT9T9/SmVlzW8
	abeyWtGjnsCOEJEyyuZKPStvV0emTjEsAUDGXvQnLxwdSCEKnsw/d3iKXrtRm013bZH5qsIi8LCRF
	gkhXj3g4a+hYOd5J8TXXVHSu/WsBDgfv4/Y1/IRyXr38UOCP7nOCzSOxy7YyYdUxe6OSRJ3XHlUXY
	rI5+FytA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rn4nJ-00000001Amt-1O5Y;
	Wed, 20 Mar 2024 22:52:25 +0000
Received: from mail-wr1-f42.google.com ([209.85.221.42])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rn4nG-00000001Alx-0YUq
	for linux-nvme@lists.infradead.org;
	Wed, 20 Mar 2024 22:52:24 +0000
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33ed7eb88d9so100006f8f.0
        for <linux-nvme@lists.infradead.org>; Wed, 20 Mar 2024 15:52:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710975140; x=1711579940;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=Sh3EAMVfpwNCavUu3fUeD20bBJR3z0L8yEIyqw9CGgvedl+1bZITshOWxBCsW3rl2u
         RDYiZqxVLOSh39fy+WlUsRRJRLhEoJt0SVIvvM5C1NTYGZzcr6Q8cfmW/7tYpG9LKvag
         eHvaVRDTYFETzQvzimRtcLp/6qaTIw/aJlEzo3d1LAi4ydrPsJRXSo3fTadJESoNMWqv
         muwQHrvyfQpjTVgQvt0H9OFXq5PvEgu9JPfl80mSjc8jgpROfH+R9dDrLwGjRH1B88ym
         /he11NSeQZT9+W7VyVESBtpZzaPTm5Uvi9SJUaVQRmKe1gaYPJ2DaubkUDA9w/6cF06Y
         qcUQ==
X-Gm-Message-State: AOJu0Yz+4WhKPsSmawAqHzCPhmM81eWWdvi2s4srGPWiQ8OAijdVymGz
	qsKbv5dAFkJ039jy/3lnk4Yd4CyQCI/BLCMsDFfGFZXe+sH+2uIlTurKYTrr
X-Google-Smtp-Source: AGHT+IFLg3hJUs7htSn9aM082Trz6DKfdNt/QC6/sFwqi5Pph6tGjT7P2EIMqDhiU4ALbnE0br2s+Q==
X-Received: by 2002:a05:600c:4fc1:b0:414:67d8:5c82 with SMTP id o1-20020a05600c4fc100b0041467d85c82mr3800416wmq.2.1710975140052;
        Wed, 20 Mar 2024 15:52:20 -0700 (PDT)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id iv11-20020a05600c548b00b0041463334822sm3591513wmb.26.2024.03.20.15.52.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 15:52:19 -0700 (PDT)
Message-ID: <316d2252-dbd0-4af6-9969-9cf5e1d3218d@grimberg.me>
Date: Thu, 21 Mar 2024 00:52:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvmet-rdma: remove NVMET_RDMA_REQ_INVALIDATE_RKEY flag
Content-Language: he-IL, en-US
To: Guixin Liu <kanie@linux.alibaba.com>, hch@lst.de, kch@nvidia.com
Cc: linux-nvme@lists.infradead.org
References: <20240320110821.60775-1-kanie@linux.alibaba.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240320110821.60775-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240320_155222_178769_C92086E4 
X-CRM114-Status: UNSURE (   4.76  )
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

