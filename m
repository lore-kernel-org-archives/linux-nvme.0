Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80F39C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Apr 2022 14:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=icAYe7755ziAfnwMU6ue0rnI8E
	McatyXXBUJmQ+P9RdXLYuWT06hQg9QePVz1UoehL+DblOUVY6mEoGy4/XbEs29UQzTal2eV2pvkGl
	CYJC5+rxOSe8QB2qiU2JC2igf2OxUZqD2RHs1vx4ssfCsdg3tk7Myy8iFaklN/CzStDq8UE+B/UiO
	8GKL5FJrmLTxu1fYHkWckIwoTUPO0evEk4orVrICyBZUbPYqon6naTo/nveKJeUppwYw7qXncXKQR
	q+nEomLJv+vH3zxPXpxfXgXX5xRH3cfAqsjgyEOB2Sp+ESHW6XsByCPImtq1A2hNWq1nUxAC+Zm0m
	PmQUUokg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1njM6V-00EyqP-NK; Tue, 26 Apr 2022 14:23:47 +0000
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1njM6T-00EypQ-G3
 for linux-nvme@lists.infradead.org; Tue, 26 Apr 2022 14:23:46 +0000
Received: by mail-wr1-f41.google.com with SMTP id e2so19438244wrh.7
 for <linux-nvme@lists.infradead.org>; Tue, 26 Apr 2022 07:23:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:references:from:in-reply-to
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=meCzp3CkUdq7LJ3yT3Opfn3J9pIa4Klc7rrrXtDyJQvxTImhreHK4tAs4mpAWdcYxv
 4GiE04/GDsqzJ9xc5sAJjTbI/RKGdqdeuzK+uIANfwIJPQA/1b8CF21dBwHU9gqXPP2V
 im4jG8KlMonmWH+PSmo0KXxooTp2sHIU8FJm8ZCiGp45rmnvCpoz/ntV2jNJ6utBnuo2
 NME6ndDurkdku5FFs6DS5AZKo1KEv3lx7Si+nw/rM0p/mTzy7Mh4+V3P/FFulLnJZDgi
 vZR/1LN75hOZpAbG5K5eANUOw8NJGl+Gwke4hk6hbfOhbq5MDQMO8V8HYJrJjIH+9qf7
 mwmg==
X-Gm-Message-State: AOAM530Tgw0JirQ+lY9d+JAXPi8+1oXjT8qZNYNvWISYvsXw7k1hB08g
 o/DF+hRnFW9R+iqQGVMd/tyP0TDHJ+A=
X-Google-Smtp-Source: ABdhPJziYgYCjClIfL2FyRr5mPRkbCS21C+G0hUWf2UUU7SDgljQqtF4saRYm2Wr+JothtEd2J3EAQ==
X-Received: by 2002:adf:ea01:0:b0:20a:e059:2f69 with SMTP id
 q1-20020adfea01000000b0020ae0592f69mr5835811wrm.682.1650983023810; 
 Tue, 26 Apr 2022 07:23:43 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90]) by smtp.gmail.com with ESMTPSA id
 l10-20020a05600002aa00b0020a7cc29000sm13164877wry.75.2022.04.26.07.23.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Apr 2022 07:23:43 -0700 (PDT)
Message-ID: <cfc93e05-8115-ddf2-708b-7655d0593b39@grimberg.me>
Date: Tue, 26 Apr 2022 17:23:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] nvme: avoid NULL pointer dereference in admin queue
 initialization error path
Content-Language: en-US
To: "Smith, Kyle Miller (Nimble Kernel)" <kyles@hpe.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <DM4PR84MB1590DD85EEC2B30DF55C9578A0F79@DM4PR84MB1590.NAMPRD84.PROD.OUTLOOK.COM>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <DM4PR84MB1590DD85EEC2B30DF55C9578A0F79@DM4PR84MB1590.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220426_072345_560445_AC5D0EC9 
X-CRM114-Status: UNSURE (   6.35  )
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

