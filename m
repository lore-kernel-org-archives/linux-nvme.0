Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3B72C54E67
	for <linux-nvme@archiver.kernel.org>; Sun, 17 Mar 2024 07:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AZfLsfK8a8pFrT4w+NHnvtDI0aHm7GlHr05kCtXLxCg=; b=VLb+z+rNLl5IITapKAqVRnKZoF
	uZJDcszdYtblTLtKL32SFvsS82/kIQVP8WQo9rDSu0PjIasdDHmyxTNRitGlh7f1/s161Sb6TzQmA
	HJs2c52m6sGYgzQkQXy6WO5p28PTbETYNrr1T2dT5pSKIifu6thX/hQx9lyUsRNmL6BDXWIb2Yg3o
	N4H37SP7i1wKsY8gJBpJhrDor7TZK1/eoAAJ8OY/sFuj33oraf049UAaS8Wz+V9hc6G/piCuJo3rr
	iBSmkB4xuOR5ePqW+fq955XZHXmeyDtAYaiE0W2mToDzXHdow91UR0ARvOojCQMV9yhdqj3DpNgKc
	FENwMX6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rlkzT-00000004ffC-0lEc;
	Sun, 17 Mar 2024 07:31:31 +0000
Received: from mail-wr1-f41.google.com ([209.85.221.41])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rlkzP-00000004feW-3QFr
	for linux-nvme@lists.infradead.org;
	Sun, 17 Mar 2024 07:31:29 +0000
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33ed7eb88d9so481663f8f.0
        for <linux-nvme@lists.infradead.org>; Sun, 17 Mar 2024 00:31:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710660685; x=1711265485;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AZfLsfK8a8pFrT4w+NHnvtDI0aHm7GlHr05kCtXLxCg=;
        b=QuAVCwhLhcvW4ZerjNGjFN7od3PylM8un7lVGejJmlUgip3BPlPDEMyOZsxqBgrmDS
         iRI4Yy2jmPL3E6KSvHcHUyCpTrTzUyC0t4Eth2uWOkkqH3qwErU4dzA9h+gNMCG781Wy
         MBZRkfg9upcZSeDH8AJxB2iO+Ya+DsNDjeJts92NczittDF5FkqUpEUh3dt/WEr+LVip
         pGvTp6FxGefuc12cBJ7PZe2WkW87gF2bDgpfQGyZ/fnolkGDfIpr040zIhccKUhje+XX
         DDMlPQ9bBqPPHiNaOS85jiuYG5cbkuEUvSnybfR9wjWxUywFz0BlDJx3Je5W76SY2wLj
         IEKA==
X-Forwarded-Encrypted: i=1; AJvYcCUkvme4vs7oyH8yl6ZdJBb1sMTGIM22dYgCp+MGbBIztDzxLibPoiTfRO1CfdW1sabPh9c/zhmFgoDMzR2JNAD4f07uX72E1qiYB36jMTg=
X-Gm-Message-State: AOJu0YyaW5l9C8kztUkY4qWOp4iWyB0/uH4gHqbSDMsJ200Eryed01kI
	TJuCrBC+lrTyu+yO1q+PIXXJrLXxvM7ue/lLXgCUNxPOpMYI+pJWEW7WYBtY
X-Google-Smtp-Source: AGHT+IHWpARUFyJxaLK5xOn0Slk1kvqbz1e2/yWi2b8p0mXc+jyHzyL1b7fURaWhh9a0QhfTRBK9oQ==
X-Received: by 2002:a05:600c:3b18:b0:414:225:38e0 with SMTP id m24-20020a05600c3b1800b00414022538e0mr4110906wms.3.1710660685569;
        Sun, 17 Mar 2024 00:31:25 -0700 (PDT)
Received: from [10.50.4.153] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id r11-20020a05600c35cb00b00414038162e1sm6341183wmq.23.2024.03.17.00.31.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Mar 2024 00:31:25 -0700 (PDT)
Message-ID: <096362ad-174e-4939-8296-e0d11f83a120@grimberg.me>
Date: Sun, 17 Mar 2024 09:31:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] nvme/tcp: Add wq_unbound modparam for nvme_tcp_wq
Content-Language: he-IL, en-US
To: Li Feng <fengli@smartx.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
Cc: Anton.Gavriliuk@hpe.ua
References: <20240313123816.625115-1-fengli@smartx.com>
 <20240313123816.625115-2-fengli@smartx.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240313123816.625115-2-fengli@smartx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240317_003127_883216_37AA31E8 
X-CRM114-Status: UNSURE (   6.28  )
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

Does this get you the functionality you want Li?

