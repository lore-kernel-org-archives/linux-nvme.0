Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91860C4332F
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Dec 2022 10:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=Qvivs2PhzEqJJ4MLj1PSIasQxf
	Akin3hCRuUeci88dB7CNZb5NIR6PnWQB7Xu28961oGw120id6a2uDEsHPjTH+xvZQUcHKOOSsddL9
	qFqQ+KcofCqkv0G8plyHr0Cb4/LxRHVy3I879Em54t10HK8gQbShF4SxL/QlmYZP3E8ZNonc+/lco
	8iV+rxS5JYkQ7IczDOqvJSJ6aOJDC68ku6YNc3dqMX+j6jD35gYbpFJOtpfLPo92yTl4OJlXa3mtk
	rxWPHfUwHBP7rkyTE/6fI2YZEkHzq6zBaSROpOfi6TnSXJxBES3GRVGt7Y0bdDSKpXZdFPxK0NuME
	5Wy2epRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p9O2S-009uA5-D5; Sun, 25 Dec 2022 10:15:28 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p9Mkb-009BlR-Br
	for linux-nvme@lists.infradead.org; Sun, 25 Dec 2022 08:53:01 +0000
Received: by mail-wm1-f44.google.com with SMTP id h12so4844519wmq.0
        for <linux-nvme@lists.infradead.org>; Sun, 25 Dec 2022 00:52:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=Bf8f2DI/LnHnNxuxfKkYCLyaHnrqZBQzrJvyWqfTGb6HHRyLOqEBUi6qqjEn4IZD+V
         7cY4dNiCAtb6pCbKYxjVldG4E9PyjXHYcGDVtuWgh6O9u5cRKOxoFF1GTVbKV+QgNpnI
         luhGpH1nT4yfiWs+jzEPRfunlc/JDWvPQ5j3kCKNPzuuw68t9fRfCxbIczJ7dtSx3b/q
         fx4wLeK/2Y5DDoonJycFRCX8aIbgp0D7l1Fkh6mt43yxjUaKnQfsqCzpHzXpNifTDqNm
         qEt9l9wwgotThhtdGDc+ekVASmiZB2g4j+8EFRRZ/9Zu/3VkG0H0YxirU6HPJVYbAWBJ
         ptmQ==
X-Gm-Message-State: AFqh2krTcs3thh51cc4fjJtqI8mQVBk38kJZzrjI1Ylz+vbMfQ/8nIxt
	G6t6prIMYiZR50rsobZqAPQ=
X-Google-Smtp-Source: AMrXdXvAb10nPFmPNftQ4ZRr5Y2bVUAXN6w86jV9BGq3rcvLwxqqLUp9ImShutMNJS6vULxurNO6hw==
X-Received: by 2002:a05:600c:2e54:b0:3cf:ceac:94d3 with SMTP id q20-20020a05600c2e5400b003cfceac94d3mr10868519wmf.13.1671958374620;
        Sun, 25 Dec 2022 00:52:54 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id p19-20020a1c5453000000b003d2157627a8sm14606219wmi.47.2022.12.25.00.52.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Dec 2022 00:52:53 -0800 (PST)
Message-ID: <c54e742d-86cb-af2c-b43e-c0f7c7550561@grimberg.me>
Date: Sun, 25 Dec 2022 10:52:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/2] nvme: add nvme_opcode_str function for all nvme cmd
 types
To: amit.engel@dell.com, linux-nvme@lists.infradead.org
References: <1670874036-3222795-1-git-send-email-amit.engel@dell.com>
 <1670874036-3222795-2-git-send-email-amit.engel@dell.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <1670874036-3222795-2-git-send-email-amit.engel@dell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221225_005257_467843_9F96609B 
X-CRM114-Status: UNSURE (   4.82  )
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

