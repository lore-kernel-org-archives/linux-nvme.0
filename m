Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C88C4345F
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Apr 2024 09:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=jtU9jKftTvGSHSZwSzGCqGRFr0
	o0aDqJxSBeQdV5OJ//AO+vixhSZFAWZYmSEjGwIjxqncy9ZFXSuj7f/BczJTGUCXbrUoV59RrJRoR
	0RKaVhu99YrDbPn7bSFVUGWvlxl7BkMAuPfy/L2QrVq2QpHgFkKkMUJSAU0hoqqWi9c+DJHyQKceM
	7+gB4XIaQOdijD5yU99mnMBGiBVT9ePtm4pocOFEXTE5uaMgWMK0tFLCeFsFpVOh8hvZcEXdZVumj
	urtvLpNohRAhwgW0HLWYwhoANl5XeA5pcCJ5SxrE3jGpjpRwYg3ZMpihxLfG/gjuMNlpxZCQ8nO8w
	BFg4HEag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwfMH-0000000Be8Q-2AWe;
	Tue, 16 Apr 2024 09:44:09 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwfMD-0000000Be3W-2vea
	for linux-nvme@lists.infradead.org;
	Tue, 16 Apr 2024 09:44:08 +0000
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-343d32aba7eso1229261f8f.1
        for <linux-nvme@lists.infradead.org>; Tue, 16 Apr 2024 02:43:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713260629; x=1713865429;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=vLkWX5YwyYtT5JaJMnfT1Lbql7aLx/YfwZRZmXbIYVMGIR4FyEpbh6DitZcUVIIbRw
         Q+dle3JM4wjFJidFfQvnCsYSntkCc9LCQTRQx9A6xzs514DVFEuiu448HNElMSq3U6Y4
         KB0QGjctHvWVjUIiqNq8dcv0OcrKSIuqb7B3O+00vQgs6oqHxUBisEF0xXm1VRd1eex2
         N3XTguAyztN46aqzerDdLgf/Jjomr+OyCYGqCeOdAOSFTwqwdFcXvCDfn0E3M6BrpWIa
         +obtvOcjrceozq4EjwXOYAf0Ks5I4hkeHtd7yjtFgps5wXBKTCNPRLHZ04EQ0ZE6id/X
         mZZA==
X-Forwarded-Encrypted: i=1; AJvYcCVHzV4sWz9FVprRyKnFLWvQJTKSkTHVT01bjXNsd6/w3BjUyP7FDo7Z0okFMGb4AMceDSWZ6yo+FkVJvkibi0GNs6w7k8OCAwlkHL7yl+g=
X-Gm-Message-State: AOJu0YxJD/sTVPL6ZNuhI6nhRIN9uHRFemftoFCYpJfMwpcpPt3O2SWS
	0PV4QxzcW7FLKwe9oEHDwScuGQSMW8zpXHCE2Bs1e8fVWFOzTtoITN/4fw==
X-Google-Smtp-Source: AGHT+IHwwk+kA+/7Wf0dNiZcbnpiuAVy+gWzeYth2fWjSJ0W7vdRIt5drGONlGjG39+4Hk6rAbRptg==
X-Received: by 2002:a05:600c:3b1f:b0:416:7b2c:df05 with SMTP id m31-20020a05600c3b1f00b004167b2cdf05mr9132766wms.1.1713260628812;
        Tue, 16 Apr 2024 02:43:48 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id fm15-20020a05600c0c0f00b004186f979543sm5726800wmb.33.2024.04.16.02.43.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 02:43:48 -0700 (PDT)
Message-ID: <b56461dc-feb9-4fcb-bfe9-c2d7c8e987f9@grimberg.me>
Date: Tue, 16 Apr 2024 12:43:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3] nvme: find numa distance only if controller has valid
 numa id
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org, gjoyce@linux.ibm.com, axboe@fb.com,
 chaitanyak@nvidia.com
References: <20240416082102.914152-1-nilay@linux.ibm.com>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240416082102.914152-1-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240416_024405_752748_7E2862CB 
X-CRM114-Status: UNSURE (   4.20  )
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

