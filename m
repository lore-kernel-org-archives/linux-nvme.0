Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CD6CC36005
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Mar 2025 13:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oPJxOALUzRJxRqwO/dJ1oQ2Yu8yWnLQ9Qghb9Fdffx4=; b=nvcba4zQZcvZFdL2QQ2K1yxUmj
	gBsavSc4bryyZEVX36QBaEh1pX/55rrF0NC9pMqlNCxRlS8Z39TYDxqhDQEtdWBo4aJGMgkhETPHz
	Wk5HbHX6sWqF6H7im7e1Ic9CXiLAdcJOcN2XpN4nkc5m+ysj2tzI715tUaZMs164FAEI4oYlAw8rJ
	xPoQUy8XZrUayHqb5JZ8Uae7Mh2NnVVmBZG76dsLjEMhIGzfCCcXhlbAgpFfKdvqFiB40xF/wbTbL
	OBI7sdy/9s0SuF49bMRIp0b1EArhDfTOruZrWgIuU6t2YCCBD6tvZjpo3erKsQqaDEF8m9ua2jsOm
	iHjaI+DA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tx3wE-00000005xpd-499x;
	Tue, 25 Mar 2025 13:03:26 +0000
Received: from mail-qt1-x82a.google.com ([2607:f8b0:4864:20::82a])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tx3lI-00000005w0Y-1LRg
	for linux-nvme@lists.infradead.org;
	Tue, 25 Mar 2025 12:52:09 +0000
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-476ac73c76fso61638641cf.0
        for <linux-nvme@lists.infradead.org>; Tue, 25 Mar 2025 05:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1742907127; x=1743511927; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oPJxOALUzRJxRqwO/dJ1oQ2Yu8yWnLQ9Qghb9Fdffx4=;
        b=L9ccn61T9WxYLQ+tBe6CAb2b7bZzXirqdi4a+T1zVvTsfn6LudNniHwGJjOwqICRYd
         LC10ktBG94oQnUK1lwWGqpWNIJSJONjcqny0hB4/NMPl+5l8pW7t1Yg7mF/NJ60MQGc4
         cr83jL0KnihQM91Q+HvZBy8p1H/zZN2E6mcHxMnsY+YjhDbmO0xEN5IC8pD5pP8Bb2us
         ojcC41pX+pERQ22Hb8+B2C8z/1B53Xb3iECDYhoOtlIk/ByyIM8KrCoyktkO+tjXPqn0
         oZmKMPTh+hROxrQ8Tw4EhzHRsOQN/cP+jOcBlyqxUX+nWIaxKZMRzyIqlrEtxEdlV/IN
         Q5Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742907127; x=1743511927;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oPJxOALUzRJxRqwO/dJ1oQ2Yu8yWnLQ9Qghb9Fdffx4=;
        b=pAgVN+5a3oc5RcICTXp7raXwpqty9+tKzE+LnI4gtha7zS+azOjW89leqBpaw3B7Ld
         StvkELBsbH3/HdOacXtfBQXxxJPNl2mQOb130zitJLJsI+VA1Rde6J7gOn5ZlRNYzFVS
         odVSsg+oyrF/3gYDxgIa3H696rsetIvx5rK9qMAlkmwXraymgT50trn8kvgx133jwG0d
         jnnYh6mRUPFKp4o0dX0C0wrbPMhagIDeSbacwrdYesR9d9wDLx+jtd8k6AXl3vxtxkif
         QoNFcHwuJ3ExA8HypFJ+U/Rl7nu0aqYzNp7W1C9jXMA+2X5a1D2uH+1VS2kOzjtXd64v
         eWAQ==
X-Forwarded-Encrypted: i=1; AJvYcCULH1B9VuGy7o08bIceSsiS6hfNdfNJlCnEIxpkcwnwYOQLFKyT8R+P9KXsDnO5VbZBipYC0nmlFsoG@lists.infradead.org
X-Gm-Message-State: AOJu0YzblZ01B07g5zKKa7g1q0g1ECrwiuad0tvFv7sGPETkiYiPpYEa
	U2rBJi205Nu8+pDhkKa+tTVWrmYyAIQHmNO1GIxvXuxpmoHAyvkgvVL/hFhDPvM=
X-Gm-Gg: ASbGncv45iaP+j4qTE9hEEYCkBr0ad1QvcG/z+6L/ocK1uH25TvcU9OwIctzo4Dp/eA
	ymQ+XEfV+z/MYuHxys9uvLBn0pIKHLoATQj2YqJMgGutr/ZULpX8fhmTDJlkJPzdQ8jhXPnFxPg
	Q9OMfAh6h/67/eJUX3tw01FSd3Y5mzzL2tVa4eIqUizdVoFlLBaPWWCk+bzXQ5sFy3cbZbD1krv
	gZUju8IOgpT7QfN2zb6KR7c4ZOIDcdj0qeIgkmNWtsqpJWcEh8fyhf2dqD6EJabBaPBhlpChhHp
	mzmbfzkwje4ifjOLNM+vs1lo4yg5PXsG8mIukVqo2g==
X-Google-Smtp-Source: AGHT+IGqEToBEJbz0GNzaBV9LfDIy0nCojMJeT0B2Xje5qrSOLPVomFIE6YsCWtEQNR3KpSKRJwAJw==
X-Received: by 2002:a05:622a:2513:b0:471:b8dd:6411 with SMTP id d75a77b69052e-4771de62864mr302505941cf.47.1742907127141;
        Tue, 25 Mar 2025 05:52:07 -0700 (PDT)
Received: from [172.22.32.183] ([99.209.85.25])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4771d18f6a3sm59449381cf.38.2025.03.25.05.52.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 05:52:06 -0700 (PDT)
Message-ID: <bb7eb5db-6675-4e24-b08d-b48378ebbc88@kernel.dk>
Date: Tue, 25 Mar 2025 06:52:05 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] nvme/ioctl: move blk_mq_free_request() out of
 nvme_map_user_request()
To: Caleb Sander Mateos <csander@purestorage.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Pavel Begunkov <asml.silence@gmail.com>
Cc: Xinyu Zhang <xizhang@purestorage.com>, linux-nvme@lists.infradead.org,
 io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250324200540.910962-1-csander@purestorage.com>
 <20250324200540.910962-3-csander@purestorage.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250324200540.910962-3-csander@purestorage.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250325_055208_366075_11E10B36 
X-CRM114-Status: UNSURE (   6.15  )
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

Reviewed-by: Jens Axboe <axboe@kernel.dK>

-- 
Jens Axboe

