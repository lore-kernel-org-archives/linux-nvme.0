Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AA9EC6FD1F
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Mar 2024 12:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Gq1BhVLHADbJ2ziJml/AZo1N8iJXOTqiqyPBQ26fKps=; b=EFwuodVGxD+xczbfny0vlBVGR8
	P7uoMc8T4FHQmtabNA/EbqMqgrgBihuQEXWVf9Y3zbJMQs27m0giw1e3kzG2QQlCQ3sDfHpJGfejL
	cs04+4OP7wLJ+iIkLwgO7xWEUDEcwfeXMB/lQ3w7FKhTIV/20DAd9gu2YRAeOzrnDSk8zj2mSznaA
	v1zIyDvurkAb1O4ML0+4sZ0qbdmJjtCMVK33ywb2gCpMAnCeYR73i90E57kKYsaYWQifzvR887LQo
	Hscr10B91i2/M3RvJjib51fiE+JgndDY5KF1imBQ4Q1tiJ8jHFeC5W8SM1a/icXi6xuwxTXbpbt+j
	AToZR9LQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp5v5-00000004TRb-0E50;
	Tue, 26 Mar 2024 12:28:47 +0000
Received: from mail-wr1-f42.google.com ([209.85.221.42])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp5v1-00000004TLh-17Qu
	for linux-nvme@lists.infradead.org;
	Tue, 26 Mar 2024 12:28:44 +0000
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33ed6097ca0so1125973f8f.1
        for <linux-nvme@lists.infradead.org>; Tue, 26 Mar 2024 05:28:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711456114; x=1712060914;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gq1BhVLHADbJ2ziJml/AZo1N8iJXOTqiqyPBQ26fKps=;
        b=gpQG8JEoGtgqNLznWl1RpxKlbiaoHXEIy4GsYovriXzzmFDOS6FH7B1y5CRDDrGub6
         AhXHfk4tYbYVc10HWxjJbj5iLkjHUS3c5kgvBipdYTkCPX7FjuT9e0yTYzUx29V3Ez9p
         7RRnB2YPu85zqkgFQg6D5k93vjSd6HDJKraAIoKoC86HGDm7J/5EdtD9IW+e4awQVAy9
         wNk65OHRV+McdElgTZ+SHewg3sX0Y62d7blYB+RwTYZK6XuPhdEC5mgPii0n6vHGERiE
         mFvujoKsNCwL5TTMoIT2cFOikkPeQQOwjq9rkygjHnrHyLzk48OjJsmayZ9AJND5P0vK
         i3rw==
X-Forwarded-Encrypted: i=1; AJvYcCVM6aLx/8iWGmic0AlpZp0dj+OaYLtA2jJEzY9YZ2KZ/6BfCJcxVamQWJOIUuLUXJ4LmVk70v71Bv133rXJVBaGtkD6zeOaAEfv6FDuBvs=
X-Gm-Message-State: AOJu0Yx788Ye7lXdBZebPWykA4MCe2+hMlASbj25ne0w1ronM7Wq5/cm
	qcSpQXxhem7Gqu0djcH47bH6vOHb2j1CBsbXMn4EoY/yaBWO4g4P
X-Google-Smtp-Source: AGHT+IF/Y8THGRSJemk0vLiIZW+l2DvGbQnnFoBwrLOBHo2GLxcKNM58uk8LTS71NvrmUBfthzNVfw==
X-Received: by 2002:adf:e6d2:0:b0:33e:a016:faab with SMTP id y18-20020adfe6d2000000b0033ea016faabmr6917650wrm.6.1711456113431;
        Tue, 26 Mar 2024 05:28:33 -0700 (PDT)
Received: from [10.50.4.153] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id r25-20020adfa159000000b00341b69e9162sm11466712wrr.90.2024.03.26.05.28.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 05:28:33 -0700 (PDT)
Message-ID: <0ecd2a60-b52f-410f-b64f-10f4588153e4@grimberg.me>
Date: Tue, 26 Mar 2024 14:28:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv4 0/7] nvmet: debugfs support
Content-Language: he-IL, en-US
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240326120342.105740-1-hare@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240326120342.105740-1-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240326_052843_358528_4E1C923F 
X-CRM114-Status: UNSURE (   5.32  )
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

Series looks solid to me,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

