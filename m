Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91EE6E7718E
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Dec 2024 11:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=jagbo3OqyIyVoZ7UJdwHv0bZUh
	2c+Tk2jzNcHr893Mw6kSVsnnBYIYsK2wrzLMxJ5TUDJ/8RjexwFazVqd839QLOwWRDykk1M6QVAxO
	/uOkTZVtebPa/gBpnltggYaHcuTNOgPLHr4AwAUgsFKoSjpHyhrsg3d8rIIX5KLSm+K/t/y59D151
	yLrDsWo1lvsBZjBIqZ5cpgmuoyuaprjJj0HpHPMlfAD+5eleugiBWy66ZL7qJGoUFxLhhCeuyfWvj
	Q7p988UaLtFjOy9EUdAxwY5hm7FB1uw5uzackzsebU1mXWtgLLV71LCqwR1o7Ra1zxi51j5pvtknT
	5GMmMbhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tQ3NJ-0000000BtRS-0eVR;
	Tue, 24 Dec 2024 11:46:57 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tQ3NG-0000000BtQK-2ecs
	for linux-nvme@lists.infradead.org;
	Tue, 24 Dec 2024 11:46:55 +0000
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-388cae9eb9fso2833812f8f.3
        for <linux-nvme@lists.infradead.org>; Tue, 24 Dec 2024 03:46:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735040813; x=1735645613;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=ts3MtSchhh1ps70cmV6iVdP05exgyamYB3+uXI+sX/afPnJsdQL8WMDOv5qAuljQ1x
         tYkIjR09kb80tbSTlHKaU+k6nEMKq4vcbTvbZISzdjlp7M7Z5W1L0kDGmdz7sAxcbJ3m
         0oUWGDSbskFFImjljeOTQTamxCcOMmakiP+gfEco2leB9BuuDO2HBhWbCOd1lz8l0uB1
         BAF7d4z3jkpIuXtjg2Uml1QhZxVqLPPIlYbyhDNyjqtry7M3tQ8NMpcmAZkm0veGZYwl
         EKXt7ly7rZ11r6ZEAdXcp19l88TcUcNMFILa6iU5ri9+NwPBgbksH6LDEeb9tFfqVE1H
         9ysA==
X-Forwarded-Encrypted: i=1; AJvYcCW2eTbTRNYqWMgDh9kxPTE1SzjvuU45X25M8DHE3PQm20VO3sD8/HdytC9Xm725xtssKZuMct0NqSTJ@lists.infradead.org
X-Gm-Message-State: AOJu0Yz/lMVRJoZcQWNpSIBAMYPyyqRm593GBZ56Zw/Cdx72NPJ11Z7Z
	N++ndEgCDpiy2mv/fXTRYHP9UiQQpTyQtyQOM+S60NnoUGTUjYbL+Y9G5Q==
X-Gm-Gg: ASbGncsNtJlbEIoQPojXEagFO0+YvIWN9iZXQNp70rtDYiqJ8zhx9v0C2wsEOYX4CsD
	mex7Jy5zYWe6/urvAOe7cvIhEDMit7MA6qsdKiVimbCF9XxP32c5EuZ4Z12hV5og8t4XMjG34OB
	CvTapS42wLMHGDUkhfakRoezN+bZNi5GcSzttd3i09W6GLpZRr/X6n7Lv38zu3nWJg5qMcrXtvK
	hKqyYDcvxM50sLTe3HQ+Gkatpk3I47LpZwk9vb1zOD5pgVTqOLaFg8803+NE14liBpxY8TeU/Te
	tJcUfpJVzXnLLWv7darK3gs=
X-Google-Smtp-Source: AGHT+IHnznZ8IxV/crppyah3y6+Xkdi+9yR6gororlr7qVkgHMqD+A8FuOPob4cD+FXFTEwlgzsKUA==
X-Received: by 2002:a05:6000:480e:b0:386:39fd:5ec with SMTP id ffacd0b85a97d-38a22408c8cmr10928848f8f.57.1735040813117;
        Tue, 24 Dec 2024 03:46:53 -0800 (PST)
Received: from [10.50.4.206] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c84840asm13931504f8f.61.2024.12.24.03.46.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Dec 2024 03:46:52 -0800 (PST)
Message-ID: <344a701c-8086-47c3-8e83-c4666f338bd0@grimberg.me>
Date: Tue, 24 Dec 2024 13:46:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] nvmet: add tls_concat and tls_key debugfs entries
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Eric Biggers <ebiggers@kernel.org>, linux-crypto@vger.kernel.org
References: <20241203110238.128630-1-hare@kernel.org>
 <20241203110238.128630-12-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20241203110238.128630-12-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241224_034654_669105_12DD0E67 
X-CRM114-Status: UNSURE (   5.02  )
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

