Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A51DC5320E
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Aug 2024 07:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=4owq8vlf4ods1NLIdPzuTuJHJK
	8v80jeUlpNmEDlI1XIIXz78To6HZTezgHuDAPY1MmF4TgkkPS9xbnGypk03DHcauQH83zCko7tLGk
	+J06OZuSIjAQSzFyo4a8dF+8hIruOV3Jdw15quY0vRSx6UJlsiN+XySFNteUOKzSzPQbOe0BA8r4b
	cnSDWEVrCpLIikgxLrawFna1bSdRxWsv/v6zfS5XmZ2cELKfGll1DdM+HiVd0ku1/HSLzGH+i+UKm
	y+J4syuR8L3+rGe2eqgWvXHaViKxN78yAGdr+BmTV71uBlQnEosSgbdsdBMy+EMg1f8rvkFMUestV
	hGIF8ZBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1si899-00000003uk0-2rzx;
	Sun, 25 Aug 2024 07:58:47 +0000
Received: from mail-wm1-f48.google.com ([209.85.128.48])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1si896-00000003uj7-2buO
	for linux-nvme@lists.infradead.org;
	Sun, 25 Aug 2024 07:58:45 +0000
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42ab97465c8so27888435e9.1
        for <linux-nvme@lists.infradead.org>; Sun, 25 Aug 2024 00:58:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724572723; x=1725177523;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=C1LedSpUfz8CoTgt1dyWRcfLjhfz4GSy8M3SUvM7b/uidNhtqgU11n+U3dr4xdcNpE
         Ar55dxS3l+cnk9VrIA5kjCi+QYgCVcwuCPgI+F4iav0urGQGReqberGFS+X2dJFSiCn8
         C79jBn9eXP/ygFNAtniFp18A88t11fb0DtTiPR0ro5GjRaARxXpVd8SPzSE8OsFcYaHl
         CPjABspD0O3qrIrdW975KTexCUfvk68PSE97eiGhDc0WVQ3gbEzRZNIn+OsyNp9eB4Hr
         4cHWt6rA5/vmz/NvCPkhLopQhaqbW5ZhV1ilQv+8k5cHoyDHwjR8HgCGQO4VkfNmCUR+
         Bjeg==
X-Forwarded-Encrypted: i=1; AJvYcCVgDsCD0xo2cGgMn7up5KHZBBFSZE6nBDdW5iFtK95T4nrnRkRkanIRYXxTBYSpNNiIvfOLo0MAP6Fb@lists.infradead.org
X-Gm-Message-State: AOJu0YyJ2N6hkC7U+9NuRNaBe72uQEPpB017Jve2hEOtjafGE/n2LMAX
	4DBSVklIEqmAZKqzpXK0hXUU4RrFsG3WFsAxitwp1/49//WceDb2
X-Google-Smtp-Source: AGHT+IGtTeoBfZT6lbAkZDIeXitt56VKRpyvH5aeH5M3apynubxgt3T7VlOA3zjraj5lgF72ZPXBTQ==
X-Received: by 2002:a05:6000:108b:b0:371:8f32:557e with SMTP id ffacd0b85a97d-373118c883fmr3750921f8f.39.1724572722473;
        Sun, 25 Aug 2024 00:58:42 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730813c465sm8118438f8f.32.2024.08.25.00.58.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Aug 2024 00:58:42 -0700 (PDT)
Message-ID: <facec642-310d-4b74-a6a0-6b7f929e7465@grimberg.me>
Date: Sun, 25 Aug 2024 10:58:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/4] driver core: shut down devices asynchronously
To: Stuart Hayes <stuart.w.hayes@gmail.com>, linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Martin Belanger <Martin.Belanger@dell.com>,
 Oliver O'Halloran <oohall@gmail.com>, Daniel Wagner <dwagner@suse.de>,
 Keith Busch <kbusch@kernel.org>, Lukas Wunner <lukas@wunner.de>,
 David Jeffery <djeffery@redhat.com>, Jeremy Allison <jallison@ciq.com>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org
References: <20240822202805.6379-1-stuart.w.hayes@gmail.com>
 <20240822202805.6379-4-stuart.w.hayes@gmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240822202805.6379-4-stuart.w.hayes@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240825_005844_665781_774A6CBA 
X-CRM114-Status: UNSURE (   5.51  )
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

