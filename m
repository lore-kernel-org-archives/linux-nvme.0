Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FCF0CD5BC9
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Sep 2024 14:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G5oxysNoWruEsSAXCh2tyAPkzw9jiZAlZ/alPTEVDu4=; b=08/K6h1MIQ+YkTw3ICIF6CoyRR
	EiZv1MQyDajRhhpnka94oCXYXFDzzlEj3uK2epptL5nROt83OQokUAeIHd6cy61TmivhFAO8dOW27
	EClG9dYPfwErwIW5QJI2il2Wo533dDm6kDNoW+VtbPr4B7LiSAlwg0aP1nLE1uIb6BQn46INUgglB
	zhTj7aQOPDsBKPjaFRDXaqR1i/+2hxZU8I4CuPY0uJMNRb7y9QQDT+i//lyvt6XH+oey3gttb9iLw
	jHweZHbcFrOC1zacFLfyeGCGKWteBH5+6BSVgOtHnmy0k1CnImUqv5gjcUPy2CYo/RWTy0pQdTq3d
	Mh5FGd0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smDlm-00000008ml7-1nN5;
	Thu, 05 Sep 2024 14:47:34 +0000
Received: from mail-io1-xd30.google.com ([2607:f8b0:4864:20::d30])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smDkw-00000008mXX-0T1g
	for linux-nvme@lists.infradead.org;
	Thu, 05 Sep 2024 14:46:43 +0000
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-82a8f3e7a10so19438039f.2
        for <linux-nvme@lists.infradead.org>; Thu, 05 Sep 2024 07:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725547601; x=1726152401; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G5oxysNoWruEsSAXCh2tyAPkzw9jiZAlZ/alPTEVDu4=;
        b=wQbiOlinThrHftwt5BWVqgRAIxcMhQsebN/JMCKwLaXI2THMmEEhUQN3902SBIFbCy
         2KDzCfkiRffQk6DGtYotKIMn2Af3mBMkIovXe+h7wMwfLEywd6/Fi9YcxwuLczvmlm7Q
         /z0GaYAjv6INLRn4xN/3Oqv1cJzqP2RIPFyFo6WHnQlmuX6zP3N/l9tgHMpo+t6rZn0g
         Up90+M/sp62bmLNpC/QknJnxjMzwWBbLRl/wOfUF9UR+pquDCeMJ5tiKp+IVQvNUUYn4
         CoYvNAjBEFb1bnL7kUCspC4eImr9H5bTYh0oBWnjz+Vq1BOy8f7tWqv7dPRwiXxsRtmL
         OCeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725547601; x=1726152401;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G5oxysNoWruEsSAXCh2tyAPkzw9jiZAlZ/alPTEVDu4=;
        b=g9gAU3XQmO4UWKhi+XoMMRKyeksT8VSz3zKwIij9QNTi/MNykIbxW12UwrrYx1eH3w
         RL3bfWvkdjoBAYmXm1FW2JfgXvKMysk8YHstQUL0WSxmk6wUpWKXrvAsisK+U0gCq/NY
         gyDNOIV054WDHagc9mkC04LDkXxRgT/CjhLznIVcJeynvZVpZBz+mKfVQbDZSIwoDwwS
         OaQ5OwXjG7J/JiCUr1GlqsceohUumlAuT9ULJ207PFwGBMWBhQom4qPVroAXq8Yf9scn
         ehUUA+MzcCMZFMgbCUoCnmD/++6ZlEiCX0mh7qz+QWXNg36Q+64/RCvH1787WSIH8lA/
         tn8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWKBmVcwv11K3nPxoMTNDyjkEOR3Z+7l4BzD3xkTskUnAJtBLWRFK2QTJC10W/GcoEeAQZclajTOrlZ@lists.infradead.org
X-Gm-Message-State: AOJu0YzFZnptOA5pKlI9E/wkGlhNDV9pMlJks9V4N/7oXRP4gpIoyyur
	jDujaSfy9Wq+fJNeVkc5b7lq+hQ7irMmxsZE5ED2+qkVUDeF/lMULHcpDZ7/m0Y=
X-Google-Smtp-Source: AGHT+IFmzxneSzwlpagWFxEo3SzsxloppAuoMBeIIvxI7zF83eNlgnM8ySVSCIrfD0FLnNubViYPgg==
X-Received: by 2002:a05:6602:2ccc:b0:829:e6c5:cb0b with SMTP id ca18e2360f4ac-82a5ed0d2ffmr1355519039f.13.1725547600723;
        Thu, 05 Sep 2024 07:46:40 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-82a1a43c09asm414440639f.28.2024.09.05.07.46.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 07:46:40 -0700 (PDT)
Message-ID: <d3c72088-e0da-4582-978a-5230c32af9e9@kernel.dk>
Date: Thu, 5 Sep 2024 08:46:39 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme fixes for Linux 6.11
To: Keith Busch <kbusch@kernel.org>
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org
References: <ZtnC_xT5S0X2ZuZB@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZtnC_xT5S0X2ZuZB@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240905_074642_287747_A14F0FC3 
X-CRM114-Status: GOOD (  10.71  )
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

On 9/5/24 8:41 AM, Keith Busch wrote:
> The following changes since commit e6b09a173870720e4d4c6fd755803970015ac043:
> 
>   Merge tag 'nvme-6.11-2024-08-22' of git://git.infradead.org/nvme into block-6.11 (2024-08-22 16:20:24 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.11-2024-09-05
> 
> for you to fetch changes up to 899d2e5a4e3d36689e8938e152f4b69a4bcc6b4d:
> 
>   nvmet: Identify-Active Namespace ID List command should reject invalid nsid (2024-09-03 10:05:40 -0700)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 6.11
> 
>  - Sparse fix on static symbol (Jinjie)
>  - Misleading warning message fix (Keith)
>  - TCP command allocation handling fix (Maurizio)
>  - PCI tagset allocation handling fix (Keith)
>  - Low-power quirk for Samsung (Georg)
>  - Queue limits fix for zone devices (Christoph)
>  - Target protocol behavior fix (Maurizio)

Pulled, thanks.

-- 
Jens Axboe



