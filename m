Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF3F2CD128A
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Apr 2024 13:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=3OJVuf99nvJ0ECwtzJZMx2nS+v
	hQc53tILrGpyptYExA8t09s9kt6jEFL2K17nfgtpt5lqRLRuF5m8MKbyi447i3vhAR7tBUpP2H3CO
	HrxIYWqOr6ttbz0H7mt5hNKu0q9tCIP+QYLnRpqc5igtk5rUJiEzBDuJ2IDKnRqqfZYxrEOBmmwk6
	y48KR3Yh9/P8uejnmiAzpJNDFNs8UuS9V/m2zc6wjd9Sj7ePctsq4E+DBayX+KJuEaxlOzN/VWL56
	5ggaDxOfox/5LaRc0rpuwGjOWS8dheNM9XZtZgEGhrToarlrQo7KVJj0kDdbo8Y+F5tbOi5DtqnBn
	NLCIIvHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruYSL-00000007K9U-2LhG;
	Wed, 10 Apr 2024 13:57:41 +0000
Received: from mail-wm1-f48.google.com ([209.85.128.48])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruYSH-00000007K5x-34Fl
	for linux-nvme@lists.infradead.org;
	Wed, 10 Apr 2024 13:57:39 +0000
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-417bfd4418aso214655e9.1
        for <linux-nvme@lists.infradead.org>; Wed, 10 Apr 2024 06:57:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712757455; x=1713362255;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=EEqL0QMITZ167Mess692z74Hfz8adqbXTtn/KqjUJMgA/jFYcVzZWLxm96EF9PPGGN
         8p4dlsojajom3AZ1zDMQP1OuvhYw385grbWWyw++04YtzfIjHRxe6/Ipvp6o9Q9etGjT
         gXjx6f2DJJXCG/SyEhH5n6iNpbD9qkwuC+7Py/G+E2BJXgkmDavisgilvGZawl8mqAc4
         eDixyZ9DGNYGS3Go57L7E9+yBejCam9y3WSak5tShJdTCG7vJ/XJ8wwRQEInQknGcoKF
         6N7to4x3MWvuTCnzGRkiZUk4YWbLdYKvQfxO3GvPAd040bFNYmr6glp+xz/ZMjPKA+b8
         xQXw==
X-Forwarded-Encrypted: i=1; AJvYcCVeNuLOV9LYG+4WfVhwdlB/Y5E4fSx7m0V6vmmZMqS6sNSss+hR+0BLuiCTj9iGNASjdoy6TSWkP3X3f83qdTY3VzJIwLE+5uyhtcaoLmE=
X-Gm-Message-State: AOJu0YyfZ8Fg7eOJLNLsR1jmBNFH645Dw17UFZ9amsv6BJZpzy8ZqBZ3
	GotXTbnL+ir7288Cf7mkqz/VnR2hRJgr8rMz5FG/10L+P/VGDSf3
X-Google-Smtp-Source: AGHT+IGfTXGttjQZRVH1qNqxszs7zzLilUkqDNDQJreOJCrGN2lgSJ8+GufVJzFH1DF2S2A/hq89GA==
X-Received: by 2002:a05:600c:3b9c:b0:417:4ff3:3876 with SMTP id n28-20020a05600c3b9c00b004174ff33876mr1173698wms.2.1712757454867;
        Wed, 10 Apr 2024 06:57:34 -0700 (PDT)
Received: from [10.50.4.160] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id fc18-20020a05600c525200b0041563096e15sm2379120wmb.5.2024.04.10.06.57.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 06:57:34 -0700 (PDT)
Message-ID: <de904aa7-dd7e-4e4e-b4a4-ea83b72365e8@grimberg.me>
Date: Wed, 10 Apr 2024 16:57:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvmet-auth: return the error code to the
 nvmet_auth_host_hash() callers
To: Maurizio Lombardi <mlombard@redhat.com>, kbusch@kernel.org
Cc: hare@suse.de, dwagner@suse.de, linux-nvme@lists.infradead.org
References: <20240410094842.370170-1-mlombard@redhat.com>
 <20240410094842.370170-2-mlombard@redhat.com>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240410094842.370170-2-mlombard@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240410_065737_801266_FE8E1EC6 
X-CRM114-Status: UNSURE (   5.12  )
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

