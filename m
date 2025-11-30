Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC1A9D111A8
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Nov 2025 22:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=N6i4ePDYVB3IIxRD2KwW8Xs408
	9WR2a6aXayxbWlgjtoMHeZn7JhIFfHINuhNQlarNpaMucX4gJlB7UxTFj4CoGG+2qbN4fJItuYZqO
	gJxFDlb/R6SFiLQKRbLxcRb0CmdQ7aLeJQD5GUD7/s7muTqTq38YRgMUmf55l9NBofB8H03cfKOSw
	DUHYpYs7pSFjWF9G+c58QDt1xd/behicRSH0ZK0+mKecR9Twow9Y3vILV8/GA/s8SRAmaB9r+ag8e
	CE2YTAp3Wo5Rtz33U4GYHP33BBQoJu/RKd+6r931QCSiFiw49ivAZKw2aWEgbYzqNGlSdgwHxGFIG
	Fhg5FYgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPqLN-00000002eQM-098h;
	Sun, 30 Nov 2025 22:56:37 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPqLI-00000002ePP-2MI3
	for linux-nvme@lists.infradead.org;
	Sun, 30 Nov 2025 22:56:34 +0000
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-477563e28a3so23529045e9.1
        for <linux-nvme@lists.infradead.org>; Sun, 30 Nov 2025 14:56:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764543391; x=1765148191;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=VOs+2CGt17PgtS/69+/7SiGri/X51TfC7fDuJsrsNTxfZ+WuQktBGc8YQd5S0Wny8d
         iWsHvHqj0B0weH8UEufB46l4ndUV++gaETtmAd/LaIs23ieyS0JWMGAfYZ3WiWryDyBd
         CEXmpAbm14vQ14AEJ+HXFtiIvq/r8lhQVTaUmvU+MYmnPFw7a5PHYVXRfmQA9YkmuuJS
         YWHBQWHZSHTR5H7gsfNNbKgejovcLUjGHlTFovZOND4lByqHCCyfR1xkuJZINHJy/7TZ
         Gb6M/ANNajmWnb9t/JoLIkCaelC15XA5mYRhYpFHIhJEkkRySbU73LQtkzsqf3NRRYwI
         R4Ng==
X-Forwarded-Encrypted: i=1; AJvYcCVy9bMSw/N8grO6K3GGgjAmaI02sNSHnJq0DlL9jyAbXFbUK0DwowIKTlIB/3VPXUe+ZjenhEe/AcAG@lists.infradead.org
X-Gm-Message-State: AOJu0Yy3sEeGQS68hiJRERawFKF9PpgwSEtajZv37zn8xZnyXyceykgr
	A7faOJUkspwOzrUPthBQDAEjnj3npDdJskVKqeDPHAmkwTrQ9Dxfv6H2
X-Gm-Gg: ASbGncuKk3bP6VttRJI8TdXnBEDY4QdDLVJYAc/pEximx1e0I9a6uzSZqUwMnJqDobn
	ApYpaJxCUTSrvm3RP2G1C9sNR2FLKIJt+gus/VK+1Yf53cXoqL0cme1xj++M6Z3lFgjc02QpWkF
	Tj4wiiyJ2i4h9p/fbTqT5Gexf0nlIxysNXLJJz2wseNkPcjDYY4qFkiiQLXU2r7g8MSAujaqG/H
	RUK6M28QxN+WTsA4RRa5+FK5dgBqkjtoL4r0diPE6EVJQu98jsP0DcOygInM8/9hEwnYDAA7f0H
	pKSaTw/8ccPOjKbZJM/xww+qynOqp1WPKvMHyJOjt/m/InPe0EE4XV+7EbSOpxsobjdXlXwVW10
	Tn6IctKn2jMY4IEVuTcH5En4JIuaBVg7mXTbkAbTX2LUCY0eAiGr50Bv0u8n6Fd+mi0cRHTNIqG
	Dr2BMQgRPHHzH2KSQxBnv6MVrOlq5FgsZrarUiDpTp
X-Google-Smtp-Source: AGHT+IF6boMOfrvVsz8rwHJepaN76f4KZPR55g+YUrBrfFSxA626ZDgFmDoBFAmK/Cu1G3WQQ0z5NQ==
X-Received: by 2002:a05:600c:35c6:b0:477:a219:cdc3 with SMTP id 5b1f17b1804b1-477c0513e47mr451409235e9.12.1764543390553;
        Sun, 30 Nov 2025 14:56:30 -0800 (PST)
Received: from [10.100.102.74] (89-138-71-2.bb.netvision.net.il. [89.138.71.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1caae37esm22371708f8f.40.2025.11.30.14.56.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Nov 2025 14:56:29 -0800 (PST)
Message-ID: <9c0ba878-8e86-4e00-a2f7-3ae92a821819@grimberg.me>
Date: Mon, 1 Dec 2025 00:56:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] nvme: Convert tag_list mutex to rwsemaphore to
 avoid deadlock
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: Casey Chen <cachen@purestorage.com>,
 Vikas Manocha <vmanocha@purestorage.com>,
 Yuanyuan Zhong <yzhong@purestorage.com>, Hannes Reinecke <hare@suse.de>,
 Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251117202414.4071380-1-mkhalfella@purestorage.com>
 <20251117202414.4071380-2-mkhalfella@purestorage.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20251117202414.4071380-2-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251130_145632_601097_F1843A9C 
X-CRM114-Status: UNSURE (   5.07  )
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

