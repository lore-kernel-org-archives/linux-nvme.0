Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1230DC47DB3
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jan 2024 14:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=jh3VgpAv/MCSHzScBGjN8Fm7FC
	fmB1cP2uozcms/rrgMuIsyxTMbPsJiroE9CYdbtdVDTNheo55g3ogu+wUhrKQfpC39IkUg7W2ttJ6
	gF6clpxzxClT+Z7JBPJEQDg7mHQkOxUOeThDYajPFQoTfXnQsZWyEIgKTB/F0eqHcKQYmuMn3bxNp
	8Ba1rRWnZzhz6mPRATVTm+dgexAlpwWPAqNu3iurM5PfkMF7zrU5Wf8rx0fSntUxwx3KDbqOZPiEp
	J3S/rIPGMyPAt0ULslQzErzjaqHRF9wOkxczb+73GDJtFAzScHtCFT3kGaQTe9pGBPt/2y56o8BUJ
	o43hix+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUSUJ-0000000D2fi-2g69;
	Mon, 29 Jan 2024 14:19:51 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUSUH-0000000D2eX-0mGB
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jan 2024 14:19:50 +0000
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40e60d74b81so5111305e9.1
        for <linux-nvme@lists.infradead.org>; Mon, 29 Jan 2024 06:19:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706537987; x=1707142787;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=TAZEiJO/dYVX9Y8kGamnsyR9TbZszcuWxxQc9WUeyvE/ALQ6m0N0AAlTZeVS1LE/as
         xAuKV4lkHqBzpcJlNKqsFa6t8WqL+ACyxLdq0ZNOtOI62iJhacogiFzpi6yt84GLUUIi
         7ZbUg/SqDNe0XgSUzicBj437D2ao+NPxkAaYNzAaCqnY/ABdVdRgZQftRTWL3rWEeQ36
         /7V5TcTVhwaGe/S6IeX24K3vX8A2faLoFPw3u9fxRmcf9Gog+PQMkeXcuUsZRBhDkF8M
         KquCDSRBORW6BghHtnBFEDhZph0+2jki1gO+7H0sQgbQbj1i9UbbiYCo5pcTTOgf3gm7
         unaQ==
X-Forwarded-Encrypted: i=0; AJvYcCXOwsKi5GYPEY3rtDZnUA8CDJUKjr69Vv2JJqXQwX05V7cF3Oy3p0yGO3MqLgXw8KFeH8Td9k8TEsjY/G78vdbcZjPKNSuXXDjNHs7Mook=
X-Gm-Message-State: AOJu0YwhgKQHE/PpVYHOXXeh4HhPSubqb3r7fDgbAheSCMhz16mbq32a
	2jA9Y/Tp2QNnEN1981W+F+JHgNQtInRRZHkqcMjozO/2oTEjFW9hj1bFybaD
X-Google-Smtp-Source: AGHT+IGiJy8zCxQlf4AeiJcz+tm5lqnbAs5OMQKj4AHShJSb8sKsJWL0Kl5SczQTr05hIIObZ1LrWA==
X-Received: by 2002:a05:600c:1e10:b0:40e:fa05:c9e with SMTP id ay16-20020a05600c1e1000b0040efa050c9emr1310527wmb.3.1706537986880;
        Mon, 29 Jan 2024 06:19:46 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id je16-20020a05600c1f9000b0040ec66021a7sm10395092wmb.1.2024.01.29.06.19.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 06:19:46 -0800 (PST)
Message-ID: <fee602c8-9c6a-4a75-ac0c-09860ca99f4f@grimberg.me>
Date: Mon, 29 Jan 2024 16:19:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] nvme-auth: open-code single-use macros
Content-Language: en-US
To: hare@kernel.org, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
References: <20240127093746.40246-1-hare@kernel.org>
 <20240127093746.40246-2-hare@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240127093746.40246-2-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240129_061949_334618_443C16E4 
X-CRM114-Status: UNSURE (   5.16  )
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

