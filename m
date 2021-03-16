Return-Path: <SRS0=15Zf=IO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 736C5C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 17:44:41 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AE2C65125
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 17:44:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AE2C65125
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=LCKvTfyR+1gmEhvppEAIsCF7Z
	fCN1RdQKIFA1uhNiN8EcSh2cBzxiWKVZHTWQEp3bDzq8ydSp/SPGfL13a/Bc7O7dW8oS6yxpb7BL2
	4/Jz8lOH4YF+aj1YvLHDLeKJrVkKrm8lED602saVHXaLRO7RIqWeYrfnkf0EAW05U0L/kL1gR6MUu
	Xn0bGeiY/NeBMC4F2QQ810KxQqhvg53o6ZM+wR5XhmITHNKTniS/GIHf86+/tmJBy5jAe6+YSble4
	KE4suVzwT3xJlYwKLJjgQt7DBDQVTcL0BMkQ9Umd38f5ZCMEuJHyYbjEBTHGjh3IGpYwkbF9RF96X
	tfg6BZZkA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMDk3-001QcD-Ox; Tue, 16 Mar 2021 17:44:27 +0000
Received: from mail-pf1-f182.google.com ([209.85.210.182])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMDjz-001Qbo-3j
 for linux-nvme@lists.infradead.org; Tue, 16 Mar 2021 17:44:25 +0000
Received: by mail-pf1-f182.google.com with SMTP id o3so4659343pfh.11
 for <linux-nvme@lists.infradead.org>; Tue, 16 Mar 2021 10:44:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=OoW9rIUl5nob4Y6c0q9skzQ2zndL7t6RjJSI5eHFtszRhc42gBMuJAUhqbDF5cfoj3
 y6hEtAX9ohef4VSKDmiwrP4SQssyq4n4GLIF00H7Tp/K+bjqPg0TcSrkWDFF8LvV7S1g
 MAUdN2N3fG4vchjvDiJOes9NbWH61rjWVt5fgeGlP0yAWzAU90HozqFoqRDB/8dAhM/B
 MZRjK22BY1L8QOVUaaJqfLaZ7OSBnPt1cNeC7z7AlScxCJQz2sdBeJMa8jROK/fXt2qR
 ZHHDbRGkvJtOZsoVv5OmJoI9tE7S9VlJW9VEMwrsOzQLoQAcYnMZIvBzUZIPBWXNFHF8
 AGxw==
X-Gm-Message-State: AOAM532vHfbMYjLasguZknDsEZD19ccBHR9FhFPCUdReGZN05YS5Pm4x
 uMNr2WvID76KIc0FN3Z+5cKi1NnLucg=
X-Google-Smtp-Source: ABdhPJxWRcwAhEqF0Ssd9Sz2+R9QvDDCtKWI733gJqj1i7+wxTXV6IJu51yCBTqgdKN8mMyQJavboQ==
X-Received: by 2002:a63:1026:: with SMTP id f38mr757727pgl.142.1615916661873; 
 Tue, 16 Mar 2021 10:44:21 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:52e4:89ef:d916:a3a6?
 ([2601:647:4802:9070:52e4:89ef:d916:a3a6])
 by smtp.gmail.com with ESMTPSA id u24sm17797159pfm.214.2021.03.16.10.44.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Mar 2021 10:44:21 -0700 (PDT)
Subject: Re: [PATCH 1/2] nvme-pci: allocate nvme_command within driver pdu
To: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 hch@lst.de, Kanchan Joshi <joshi.k@samsung.com>
References: <20210316170632.4161183-1-kbusch@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <55b4b085-6297-1d35-6524-444590d810e1@grimberg.me>
Date: Tue, 16 Mar 2021 10:44:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210316170632.4161183-1-kbusch@kernel.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210316_174424_126650_AC9E52F5 
X-CRM114-Status: UNSURE (   8.02  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
