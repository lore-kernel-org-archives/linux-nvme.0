Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 223DDC02181
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Jan 2025 08:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=15sjdkXN56VmFX8zx8k/dEM2VE
	m8xvm1gzbU7b3CyxCEafXz+A7VmSe3Zcs4dpMwmWYZHi8RfMFZfkVW4/pYLhXlEyo+9o2BKxEZxLG
	gGp9m55FEGSpnDQNtRMJ7B/PLNV7XEzV5Qklr+LIhBXWcLTbd3kL05BH3HbsPhbykATwsC1T8wTUh
	Ddwr3R62B11yGcCDqTEeX+TA//3x42+vXGrFW0sE6Lbe0orhvfc8qmJ6uqgrcAKn3hq0i5m39zsQD
	qVQpFARoL7H8XQujWTD1oDfWsguP2o1L5V8+ALIEbfSC8OsPh3an5LCCTYQSFAVYYa2Wwd7owH2a/
	/L4lgEZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tbxZw-0000000HEUE-1znG;
	Sun, 26 Jan 2025 08:01:12 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tbxZr-0000000HETw-03Zo
	for linux-nvme@lists.infradead.org;
	Sun, 26 Jan 2025 08:01:10 +0000
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43624b2d453so36845385e9.2
        for <linux-nvme@lists.infradead.org>; Sun, 26 Jan 2025 00:01:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737878465; x=1738483265;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=lWb6DRPNBArPi98lwjU8oxRsFHoQZomsll4cCiLePukkvL3awf32MpGf6kyt4f7CoP
         xlykod+Xf/xXuXVF8Sez8lRemeZBcz5lX1MTYNwAis15BvUfSbWaE7yQeO2EaZSu6BWI
         OZWWV9tYFY7M1ZR+fFLvhFNrYfpC+GVca0evH4WVSg2inyZpFuQp/1mHv6q3FEroVJ0S
         fLZvPyggkz8+BAQwfBbN48st1ZjNUCM2Bx2E4yb5XKii+ofShvqD/UU2G4/VhTFCM+uF
         j7iq1LBXYgIPO9Dj6c1E5oIXY25w1a8uvqAZna+t7xP9nmNUWHCX5OKK+V/XlXve2cHl
         VZgA==
X-Forwarded-Encrypted: i=1; AJvYcCVPXNRNrnx6x19iVFgWSzNCDBEwO8U7/1wEsaJpXF0XQJv1Jm7nxAdoAeQyOg+hKXnaOXl3wAgMbdfu@lists.infradead.org
X-Gm-Message-State: AOJu0YyO2zCDUCQeEg6jn9suqBziXBOSZ8khwWGfBYgvYDCRpr7yUl/I
	5GvdEUWumltnIsMDy+BUh0CcJk64ei/b7tR1niZ62EgJan0do9TA
X-Gm-Gg: ASbGncvoOC3wGaEQxOErO1mnvpykqs0N3SinZ1t1dNn/hrG5TxA120Loe30/B4VRskW
	oG7r/RaZugsxm76ffMXgJnEw652YWWKQizDbkSRcLV9o2l79FdUYoqVEb6taoUfHtz+aQaoMlqz
	4LMKSnP/o7K3iRfeznp+Il2uN2ZiabAjRVeOhu8J1ww2+XmNAhz/SbuRGN2IkVEKVlgIO4/+edL
	EI1DgKqXB7P5YkTb4mRx0QyM7vCBaqfgqrNqLSVsm1k0FjqfhDWHQCsrn/Aqwwlh27fqi5RSWSr
	p0ZiYwoPc/xfDXtK+ia5F3RU6jp3Y8xsJ7xNniUzIkotTZI=
X-Google-Smtp-Source: AGHT+IEOZW//6NOLjCgnrxoS06WqMEKT4GIokrWa5nqNKrKVCnan25JevsTGH1ZpaPazSNAH1A4/Sw==
X-Received: by 2002:a05:600c:1386:b0:434:f739:7cd9 with SMTP id 5b1f17b1804b1-438913cf349mr309920235e9.9.1737878464559;
        Sun, 26 Jan 2025 00:01:04 -0800 (PST)
Received: from [10.50.4.206] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd4900e2sm86668455e9.24.2025.01.26.00.01.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jan 2025 00:01:03 -0800 (PST)
Message-ID: <cddade6e-4ccf-4100-8705-ac5db7dfb946@grimberg.me>
Date: Sun, 26 Jan 2025 10:01:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] nvme-tcp: fix connect failure on receiving partial
 ICResp PDU
To: Caleb Sander Mateos <csander@purestorage.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>
Cc: Maurizio Lombardi <mlombard@redhat.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250124184311.1642797-1-csander@purestorage.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250124184311.1642797-1-csander@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250126_000107_050305_931F3D4B 
X-CRM114-Status: UNSURE (   5.81  )
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

