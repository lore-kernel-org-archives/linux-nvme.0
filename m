Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DAC8E77188
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Dec 2024 11:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=ngeyWBrpc4Uo+PKgvhOmqMEw7t
	fg1pTBwSabhkEeytM2NxYJaZ1iTtDoSDxoBhfYYe3tD2oZQxIPk3Vrg/fGbdDNj+cCJkTUEZmZryE
	2HIjIaj+s7Nl6oNL+l/gstTF76RrBgWb01pSCywATt0M4+iEEv4XXADoM0LWNiAiaihVaTNsIXZ/s
	PDZYZiaZg/ObFFmIj1K9/OBS0Jrywqgo+KNEWB6ui/TXOFRH+tFcX6DXKXoHcOY1mTOWP2R7ii6TE
	beFLXrlt5JKUDEiuPHS4KN0icxzTnSG2aokpRSpoOmtWCYc4Uuvx+K0CtUJn3tOPJlQNq4B/Y6gt2
	j8fvycfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tQ2vm-0000000BqVD-0152;
	Tue, 24 Dec 2024 11:18:30 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tQ2vj-0000000BqU4-0Y7b
	for linux-nvme@lists.infradead.org;
	Tue, 24 Dec 2024 11:18:28 +0000
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43622354a3eso34617645e9.1
        for <linux-nvme@lists.infradead.org>; Tue, 24 Dec 2024 03:18:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735039105; x=1735643905;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=PjyjAKzxbuedJaFqYRVlBRriJhaVeKJBMi+Egt8kO+kxD/MBELj0AMtUW3EjEdK3Q3
         af11KBH/NMrbNwrtGrBmP5W12f5NBjCU+lOuZIGANpPdlWTQwMkq5m6lb94Caxzhj+lX
         3Aki6ysIQQVzu4xT4V+1yU+mF/5TGhWbDd5QebWeK5M/RvMTWv2MAcBe0h5xIvTyAoaf
         AZdJ2DB697btulvGhhNMIthF1bJeNMFsfpwAvRgTGTgZZkobwsmVusCYiZCK2fEjZ4XK
         kZWm3lCuOlZPWORlh/ZchbPDlJmBaV0V8m/lhNGQghdnik4JXYTS+w0o/W8emc7gIiSi
         n3xQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKhzLg3oZ9LKhJPK7yMeSUua6rnCAfsq+MTrRzm7Mg129h8t7bQnqTlWDdV2Hm5NwmhT5ZDLyfV8aS@lists.infradead.org
X-Gm-Message-State: AOJu0Yww/kmRoAdVjB5xomkV/yLwPCGr+fikH/MiMLxq5sDuTahfvWQb
	S7xqPd8E/o0THt0C7+dKGsCiF8V8Bb0jKwq8pftwy5YmW7L558KY
X-Gm-Gg: ASbGnct0DTJQQvchxPNUwRIeBhfv1Yxxk8ZvbFP+wvdu19WOKPglcriMT0puNC1x1Wy
	oFhCP+YS6E9+XgTOkMlUvbTN4vKIxjtkF70k4gFt+OeXp2bh45KnkHLheiSnTZ/4BXWFvWYH1ak
	Oz/CUKLDhaEahjBaAD9O3UYNONdm5zP7tMwMj1jYmKalBPAPmdz2ZtO0xS5Xss86X/8WkhyBXBD
	YF2uyrMW3OTw/BOgUXFJyVMWiT2QthuqvsUYV4uj5bWQJOtIsktt4E/TldREQciIiPYBTdMBRBp
	T0I4BV72TELRfz/CIgSWVdA=
X-Google-Smtp-Source: AGHT+IFmpW45q4WLUDp+XLXOby5JCMdl4ynMZMAvJe/ztXi2FomLEPLhLsmNs/Hj/fcZB1PGTBw8NQ==
X-Received: by 2002:a05:600c:4586:b0:434:a902:97cd with SMTP id 5b1f17b1804b1-4366864364dmr146783515e9.12.1735039105321;
        Tue, 24 Dec 2024 03:18:25 -0800 (PST)
Received: from [10.50.4.206] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8472casm14184974f8f.45.2024.12.24.03.18.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Dec 2024 03:18:24 -0800 (PST)
Message-ID: <6bc9171b-62d4-4e53-9f34-b64b361eeb2c@grimberg.me>
Date: Tue, 24 Dec 2024 13:18:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv6 RFC 2/3] nvme-multipath: Add visibility for numa
 io-policy
To: Nilay Shroff <nilay@linux.ibm.com>, dwagner@suse.de, hare@suse.de
Cc: kbusch@kernel.org, hch@lst.de, axboe@fb.com, gjoyce@linux.ibm.com,
 linux-nvme@lists.infradead.org
References: <20241213041908.1381196-1-nilay@linux.ibm.com>
 <20241213041908.1381196-3-nilay@linux.ibm.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20241213041908.1381196-3-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241224_031827_162628_33CFCC48 
X-CRM114-Status: UNSURE (   4.12  )
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

