Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3333DE77188
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Dec 2024 11:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=yiHGrKgQsDnd33v8ybY0D9QWWo
	9uuQCoXyhnFpoemcszJRU11QJGJDFDbWJ6af3H0dCys96MU0eGsRHnEOo61cVUYmXanWf0WqXgz09
	DeCnjWWj9DCrSG/U+4m8ATsKFyc4l6ER88SdDVMWMXr/uiEsjAiPYRM57NdzvLj+KcJT68C1YS4Wo
	XRztITx/mbHO+3kdu6+sp4bigWRUpVvNAsSts+xSsWo2Rp0gJUUzWqEROSXYeQJH0flLYW0YQPQEJ
	PvJtqWTbdK+teqGURGwScHx5VuOOXPr2Y+CDO0RbchEALsk/+4aL5mIDC+/G1YbJAYhGAf7iM8pn1
	mDHRdG7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tQ3Ks-0000000BtA9-3ZRD;
	Tue, 24 Dec 2024 11:44:26 +0000
Received: from mail-wm1-f45.google.com ([209.85.128.45])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tQ3Kq-0000000Bt9m-42tz
	for linux-nvme@lists.infradead.org;
	Tue, 24 Dec 2024 11:44:26 +0000
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4361dc6322fso33141375e9.3
        for <linux-nvme@lists.infradead.org>; Tue, 24 Dec 2024 03:44:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735040663; x=1735645463;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=q8ns9mi73A8NP5zxTCpa+nf8HkPyV258XFhuLa+g957g+nv7bPb9p8HdV7fKBYpesk
         kSoe+r/X69VMjtiI4OFo2/a8c66MxGlie9UBpMCS2vZi+EYkWWqdMosgoVV3/cVB/tkr
         NtkVLQOGpZJzn2VPec+av8U6oh8e4CQfk13Wk0vf67p4y88u6/oR9ZiVbi/Qj+0ATR/+
         /xRXI5wof9Zx90JpAVzPTUydCZCyZGP6L7Mzk8DhjyylqffdVtL8actrhHChSlA3424Y
         ddBGkr8o+fYlKLzI05dePLzzyApuuJKiKQlXCvSTfR4brtGUdfXUyKMwro37mGVVcah+
         njdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWe87xIZzmX8DR7D5nWKdvYkLl+exhf/yTTlzrnrdP/Oiihx1ccMev6YrpjOJ1cp9q9dhGUGen4GUS@lists.infradead.org
X-Gm-Message-State: AOJu0YzR7Mq7wNapwRPzVUv2mUCWqFunuOTw1fryGDCM3xHQuwnkfWOa
	5p7kyTl53ln3BK7g8X2tQYVEoQ23CM0Bhb/f9ghpEyQzkPyPUDI7
X-Gm-Gg: ASbGnctHfczq0mww1W9f2z/cpPBfwoyVK2JWI9lqOMIWzSNUiVQkxVQo+ach8Vbriei
	omCnkP0+g5MHwf4Ub92NspdoTJKdg7HTeJl6xM4trkCaJtyNipOe4YmPF7Hf8OyPt5cXbxTSoXW
	SxZqCKe9rJmQLxDjEZOOYApD2nt9mJ8jS+lTsOF212ammV6HjM1oe31ATV42BHZkUb1aSGAo0CT
	NKCchQYD9O0O98UC9TxX8Ptf3dBoCuQSZg4HbT9zIZGDHxPcxM9u+inUHTaAz+900Q5KB5EDoag
	Pr9YtpneIQ5OAxZoyy90LaA=
X-Google-Smtp-Source: AGHT+IEKenX951wt4ppaePVV7AS/WeqKC7iv4mIRwSX5UXb14WPF8JFi3uoe1rc87S8v5PPTppLHtQ==
X-Received: by 2002:a05:600c:1d0c:b0:431:54d9:da57 with SMTP id 5b1f17b1804b1-43668b78e66mr147708345e9.30.1735040663096;
        Tue, 24 Dec 2024 03:44:23 -0800 (PST)
Received: from [10.50.4.206] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43661218f43sm166344565e9.19.2024.12.24.03.44.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Dec 2024 03:44:22 -0800 (PST)
Message-ID: <93f3d0c9-f6aa-44ae-8d86-df813af097f9@grimberg.me>
Date: Tue, 24 Dec 2024 13:44:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] nvme: always include <linux/key.h>
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Eric Biggers <ebiggers@kernel.org>, linux-crypto@vger.kernel.org
References: <20241203110238.128630-1-hare@kernel.org>
 <20241203110238.128630-8-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20241203110238.128630-8-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241224_034425_005773_26779230 
X-CRM114-Status: UNSURE (   4.69  )
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

