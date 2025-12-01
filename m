Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B7C0CFD376
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Dec 2025 02:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9+/1o+9VIMQkz7uLQx3rrNKYhBslArlEWQEAso4I+Lk=; b=3n2S4lchjI25vuFZClk+olOBSV
	RV/5C+ILzA1cmK53RRQNyEraaSL9YQvl/U7YZ8oXt/t8Nxv260Tchxec8Xv861Syr9QEX3cBNbQuM
	GXKEf7LsDp/LOIlbHYY7H+gUKHEwK3IzsM9q1pyEPCUmU+TinkHfTi5ndRhq1vsFTfCKBx5POyk5u
	cm1tBtFp/Hk7YpERQZdiuAY8ZSsoMr9l5Pv9WnjveAKoh1xSQgGwkRaD9zxuLSUpNIXSvwOYBdGwU
	Vkyua6NKHaclMo5F+lXIohyHgYpJkrXsa56Y4WWPXcaKdKOXiskpKwtYhGi0jqiYIYdJrL4th+9qM
	Zsg5tGWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPtzs-00000002pu0-3Y04;
	Mon, 01 Dec 2025 02:50:40 +0000
Received: from mail-il1-x12d.google.com ([2607:f8b0:4864:20::12d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPtzp-00000002ptE-1oD1
	for linux-nvme@lists.infradead.org;
	Mon, 01 Dec 2025 02:50:39 +0000
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-4330ef18d8aso15128185ab.0
        for <linux-nvme@lists.infradead.org>; Sun, 30 Nov 2025 18:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1764557436; x=1765162236; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9+/1o+9VIMQkz7uLQx3rrNKYhBslArlEWQEAso4I+Lk=;
        b=K47gbu/d4KWcmz2mooAhe+T40L9iKV45RPqOCpIi/8hVzGtMhMqlpJebKLFglmWHD+
         /JwXyKQsFFMzg2SLg2tOlSGI2YDWzQssK8fs+vAiKkgj4AQ7i9amEeYbEJ9WoWoTzTkg
         OdjKHWhsoJ6+tadrdz0KdnL4oBy9s/98qIUQ1hdTC2F0kzJ7IgZmpJFkVZaxchLT016R
         MbQqRAHSYYkYgyjq9CeAtQxLMnuhG7flTBk/diMbfQ1kU2esHHzpzygnTnlc3vLt0wGf
         H7wXma4a/RktZf6bpSzg/K99UMM9BqBEA28keLCk0h7YbEckvx58pPLE2AV+XjkkQR8w
         UdOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764557436; x=1765162236;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9+/1o+9VIMQkz7uLQx3rrNKYhBslArlEWQEAso4I+Lk=;
        b=fyfpA5/EPt7Uq7jyfv/G/aHEon64obeE+tXYx+4pv8KTraPx6DQ5muTLHC6Qx3p9wl
         XhyHQgI44ycPaRb2F62Dg9MCZ3dxCtJ7BV+CkKdh/U0uTiGWV4bLTGZDm4vvVLCBu/Qw
         rR+Du2tqyXDT+HuDDQdXQvRGqO7wtJjqHtFLjBK+Yw/MGKG399BbLR+LhKHLt02Doywv
         nR9jF4ajPJIiAZpkiIRg4ITxgjVilZGQuDX4wAavLygdxbUSkfuq5pLCi5xTN5II/P6b
         U5YhtMQTJ7Xc3ChYl26YFyVkIG9loRXEgd9+IhiWiVGsetsC096eJlezPNh7xGMmj/4+
         4pNw==
X-Forwarded-Encrypted: i=1; AJvYcCXCYqURFNjnA8V7VHDO+cBPInVe5b9Zjy7i/d1SweZW1i3/eyubpTBcWcESDryZnkMmpKFtQq+o9npr@lists.infradead.org
X-Gm-Message-State: AOJu0YwgezE2zcngyjNZgXL7/afrf//+fat3C+ffsAHgLodc9KRPfPy8
	WFuHujaobu833P5aZEUToq8s+eHK0L6DF03pB4Ly4sK1zDQpXpMAuTaTu6s69A9n0lNOCoCEU+B
	yJxWZ
X-Gm-Gg: ASbGnctAuY/k/eS3xiT9CabKsV2ytZ2k934dl9HIrnq6opdqmKadt6pcn1Nn7oa6b7H
	sF7TT/78jpeFxqs77JyrKghXkILhpEbp6+6Hpo7/tMWIyZGTJmfJte3e+fo6jL8rEfyhCIEctVY
	Ku9M1skrO3eixeTr/oejvBKl1CsmCLDuTNPfxW1g+KdAhFg1yjJr2Ffii9B/QLf5xNrrpjPy90L
	g+GnwHbdk3nXbaesTo7ObU98/xdBuWcFMgQZsuk0+LK8R016PssjkoEu1ZttVToCwbYO7Uua2gB
	dAHHeIMi2ctZdX09gBeTrkWic4rhNswScwRhrBNZ8r3tL/hhckf/y8KcRyqZ2QEAmfkRb56rzGQ
	z7oLYN4JnxvvN2R3M708X4pFtvfxV2neihVxS0Um6IfbbzmRYbw2XMx0oSvHOkjdTh/SAQoezLm
	8vJVi//ry0
X-Google-Smtp-Source: AGHT+IERTo1jrLZ06qBryle/a1O2Lf9QepMt3lraKHUarGFdKcdPhN8siNqlrIDujVyGAYjAU4BM7A==
X-Received: by 2002:a05:6e02:2787:b0:433:7a94:6fcc with SMTP id e9e14a558f8ab-435b8c17ffamr308574535ab.2.1764557436053;
        Sun, 30 Nov 2025 18:50:36 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-436b85c5193sm59530935ab.25.2025.11.30.18.50.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Nov 2025 18:50:35 -0800 (PST)
Message-ID: <c79547eb-bbc5-41cc-8fa0-fe7ec951c988@kernel.dk>
Date: Sun, 30 Nov 2025 19:50:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] nvme: Convert tag_list mutex to rwsemaphore to
 avoid deadlock
To: Hillf Danton <hdanton@sina.com>,
 Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251117202414.4071380-1-mkhalfella@purestorage.com>
 <20251117202414.4071380-2-mkhalfella@purestorage.com>
 <aSPYT6JuQLCE3E7K@fedora> <20251201013625.9583-1-hdanton@sina.com>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <20251201013625.9583-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251130_185037_742907_9AB182EB 
X-CRM114-Status: UNSURE (   4.36  )
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

Hillf, if you have nothing constructive to add, please just keep quiet.

-- 
Jens Axboe

