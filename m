Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A626FC25B06
	for <linux-nvme@archiver.kernel.org>; Sun, 14 Aug 2022 11:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=E+KzZhh20MkTVlBkIlEldXL/FS
	RpbtjhnXyw3Y/+tqE0U1H1x57n+qGzuYQoTVaOYcgRoY+BonNoLV598Cba9fJXZ1QT1XyCRmbnaR4
	li+GGYJ47TYjGoxBK3lyWDJsyu0eumnNsE2otbAS7Uyf8HZJphU5uWGk6CnboueMTZ9j3KoM+u3xD
	tw+rpHKtEt1k8VPeAtwdPUf2ox20ZDYUDLkCk3TmhRlV3KdZ1rn2Ld3C1E+1+KJWfP7G0p/cY1l2c
	v7usBGtUhPC4avT50OIduT4EhQRsgat69RFOFxXSuk193KyqP/cAvAfn8qiEXAtJC4Hs0C9fxta9G
	EvmjWrbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oNC41-006Gnk-4c; Sun, 14 Aug 2022 11:45:53 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oNC3x-006Glw-PS
	for linux-nvme@lists.infradead.org; Sun, 14 Aug 2022 11:45:50 +0000
Received: by mail-wr1-f50.google.com with SMTP id p10so6095601wru.8
        for <linux-nvme@lists.infradead.org>; Sun, 14 Aug 2022 04:45:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=k0dw3n+a5WFxi2s0NfeCRiFPKBI3E+6Z+wEXIOAMPVD0QWilJujIasuhdREG8nWp/d
         Y3AKn+TP3IbxQAcAQl+Laoe92dX2YmMUv0FnpcKrNH857ir4IDv5robMdsgoLlxfbfVr
         ejwQnTZ6K3BbC7Nd7GkJ8ex0IO1d9k92WITCtvO/9lfDkgb2qs7USOQPvoNWUgeKqeyU
         +4iKF9QsimsLhGcjjexT2D/BegzP3zYs84BPW6PVfU2eAWceiqtNv9+/LHN7jx0dJk3J
         sxLDxixgTnbNIzJbxsOfts/8JeXzIobWXOjPq2EJhbG8I05inC7inScd7fc23VLJyQqE
         Cukg==
X-Gm-Message-State: ACgBeo1TYJ/9ouhYNMFb+oDEIOwj9EWTOPgkLMBovLQ2/7aqoDfrFMww
	e4QVCy7NjX+lu3kSKNMWcOg=
X-Google-Smtp-Source: AA6agR6jPxkW3ZAxKgoniTICJMz8wFAAwT1JJYhGVtb+YmW9o1kgvuJtszzZj4KzJG9Xj+FcOIuRpg==
X-Received: by 2002:adf:f985:0:b0:224:f788:ede1 with SMTP id f5-20020adff985000000b00224f788ede1mr2212252wrr.110.1660477548001;
        Sun, 14 Aug 2022 04:45:48 -0700 (PDT)
Received: from [10.100.102.14] (85.65.248.193.dynamic.barak-online.net. [85.65.248.193])
        by smtp.gmail.com with ESMTPSA id t9-20020a05600c198900b003a4f08495b7sm6154804wmq.34.2022.08.14.04.45.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Aug 2022 04:45:47 -0700 (PDT)
Message-ID: <3e677775-b602-6de2-359e-e9fa1991e175@grimberg.me>
Date: Sun, 14 Aug 2022 14:45:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] nvmet-auth: clean up with done_kfree
Content-Language: en-US
To: Jackie Liu <liu.yun@linux.dev>
Cc: hch@lst.de, hare@suse.de, linux-nvme@lists.infradead.org, kch@nvidia.com
References: <20220812031231.3386953-1-liu.yun@linux.dev>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220812031231.3386953-1-liu.yun@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220814_044549_858286_DA7D946E 
X-CRM114-Status: UNSURE (   5.65  )
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

