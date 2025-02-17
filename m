Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49834C021A4
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Feb 2025 07:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HfFlznV0nBxoLPm5hCaDqxRmAugufTREXGTkETPmjNQ=; b=w0BDpg1jUs/xl6lkg44w+RUkKl
	L+7Muw6UPwexTT3Qc51W7r5MsHyIesAajzC1Z1CRIIWOqvSZkmBEoeyI85R+9cotUwgJeCjcGRkVV
	IABqRaOK+UneenSMP04Go8c2CVXYj2z5Ud7YWsb2Kopn7IoXK2mgzjJiAZ/uCo3Me73b4K5zLb90z
	BHRPjKE6rKS+pIa1YK72SBtv6qc9Upft0tPjjzLUh82ferLB2IMU2s7m3u7utk0/quhhygB4aXl6W
	BSGVLVMWZgcjPxo6Vg/Rn6Hnz9BZJGIcLHPiL3VHfzFVYfVp3H8MkDZF9nt0MX8Fxto8PGBeEoABe
	cGP/ebOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tjvI3-00000003Z7X-2nbQ;
	Mon, 17 Feb 2025 07:11:39 +0000
Received: from mail-wr1-f45.google.com ([209.85.221.45])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tjvI0-00000003Z7D-3kgW
	for linux-nvme@lists.infradead.org;
	Mon, 17 Feb 2025 07:11:37 +0000
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38f26a82d1dso1760118f8f.2
        for <linux-nvme@lists.infradead.org>; Sun, 16 Feb 2025 23:11:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739776295; x=1740381095;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HfFlznV0nBxoLPm5hCaDqxRmAugufTREXGTkETPmjNQ=;
        b=F9aEViS9J2oUMNKlHk7ZUSYfsx+ODnkNWoA5Izpk3kQdGOpdl1mBJ6YkSKOr2fK0b3
         ++dHoZzvdzVJyeW7VJgjjm+PudGeSP36zbUVVx2vgX1vkB+j6p3K7rjHgVMNoQabkerP
         UoFruUQBUxUFQDFhESf/uLnrykItzxESY179ChSKbfMMdnGrl2up+ACTSxirmWd5R7/r
         mSyyO+C0pAg8qLEGA+iDzRa1RJE07hjPRv3LUUhKIYfB/hnNN5Avo95eypYFHFGXzFUa
         FH3DvacrCWbTsYa8EU0yH8zMz9Wga2JsjSytMo8u80Ud3CGt3nyCvsJnBZwWMmzx3Uqj
         Wlfw==
X-Forwarded-Encrypted: i=1; AJvYcCUqFb10rk7/Zn1gVZo22jM0rJtAm14QV9BEePpXDP+fRgTabS799f6MUMKkPvDRPQ/Iof//MZ5BcZCP@lists.infradead.org
X-Gm-Message-State: AOJu0YzFtz9tKz5BDydKlhqEwRwjcFYWabA+OZipvwCR3JhGlqi4uNY2
	zM0ygUjmgh3PQzZ5YFu0rGyxhCAFiJCMmcvJ/Is6rZR/VpC6x/S9
X-Gm-Gg: ASbGnctgFlx7BUozB/TZDw6aQyvfyRZfGYDj7Ek0Caq+aYRRkeFtZMCQN60PbN9H7Ed
	CY0kS6Uz1fM2+uMCqmBOGXxlvgSxKunprDfPd/GKiMJ36B4DlW7poQene6C7H05s1lFWnvJjGLx
	UcbUy3lbfDYs1KmTTYmYGt2nHpAlXLR2vSMtA7iLKmYgXik5rbMy2QdUgrkjzmSo7c6PH7AISMv
	b4U+fkP8pBJ1pRcz7Y1gMGuUCmKR2AdLj1sclfymy1A/yfDfW8L3Uh5TXXgQs4nJbcPkpmkB2SB
	IdBhcTIxIJq+/VA3H8AVnXF034s4LgQDLYkmYj2m7cihHdqnLKdbxLMVNA==
X-Google-Smtp-Source: AGHT+IGBf7m9jJ8orGHtq7A3pyZr+hSkuDb8hp74BO/+yVf2IY+GcYDHhiDbWgtrJSrqMucrs83p3A==
X-Received: by 2002:a5d:5f4e:0:b0:38d:ce70:8bc8 with SMTP id ffacd0b85a97d-38f33f119d1mr6992192f8f.9.1739776294470;
        Sun, 16 Feb 2025 23:11:34 -0800 (PST)
Received: from [10.50.4.206] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258dd5acsm11580225f8f.35.2025.02.16.23.11.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Feb 2025 23:11:34 -0800 (PST)
Message-ID: <dda59c66-2868-45fe-b943-2c7cf6d99893@grimberg.me>
Date: Mon, 17 Feb 2025 09:11:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] nvme-tcp: fix connect failure on receiving partial
 ICResp PDU
To: Caleb Sander <csander@purestorage.com>, Hannes Reinecke <hare@suse.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Maurizio Lombardi <mlombard@redhat.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250124184311.1642797-1-csander@purestorage.com>
 <9ea74200-7cbc-4a30-9503-864dcec9b45d@suse.de>
 <CADUfDZoT7JW+d+j6YNmWJ3CKZ45gbvcUSsE6boZwE1C3iXw2_g@mail.gmail.com>
 <f75c62ce-04a7-4bc0-ae77-8ed80842bf37@suse.de>
 <CADUfDZrvHmYQgqu5GiQDrAg_MOEiRigCLCmBSO6jeyd1z+Q-JQ@mail.gmail.com>
 <3bcc6e3f-5172-40d4-a4d4-b0f914b9406b@grimberg.me>
 <CADUfDZq3ZqpP9hZhgG1gzyyggG6SCQiHqHdgbm95TU2oZ5QFUQ@mail.gmail.com>
 <17d0b30a-758c-4a84-9879-0a070656f15e@suse.de>
 <CADUfDZqy4tO5DxWejvBN7-xBVfCfKae4PDq70NYsgMhU+kkJ-A@mail.gmail.com>
 <CADUfDZp5E-oc+ikHQxvFyR7nLPWiOjqKQudC04roarn5ps9w1A@mail.gmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CADUfDZp5E-oc+ikHQxvFyR7nLPWiOjqKQudC04roarn5ps9w1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250216_231136_938146_2173C5E8 
X-CRM114-Status: UNSURE (   6.55  )
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




On 10/02/2025 19:24, Caleb Sander wrote:
> Gentle ping on this patch. Sagi reviewed it, and I don't hear any
> additional comments from Hannes.

Caleb, lets resend it with review tags from me and Hannes.

