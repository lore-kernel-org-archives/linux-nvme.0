Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ECABC5DF97
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Aug 2026 09:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=EnkCu/iyxZB3iyzi9SRvA3ud/Q
	xL21B/dWRLNH6oTYVSuX/WHVIq2n0CuGcl3MzX21SKd2RekLlEIl2dTgA13XHvuXKpwQxJ8VZevax
	xJ1XcjqYUm/YzJWpeBu/Hc9M+E20Wxo6QoWFkdgB7ml1yziPqnhYV1cGFQXZKqFcie/v2+kermU8r
	Qw3SZmlA+aBfZDyPtt4C6SDSlUJZvJz+E+ckz3aEGAewVyTDtWMIV/MQfcJpIQevMi2SEVMoGZNtd
	ETBHjHqLjaRoKvVOV0MoafiZ5fpWPUYNlFQDzQS7WVigdb0C61v8qIAEl/Czl0eTJ8JjXKzosVmnk
	Ref3ZR8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wy4DH-0000000FCfU-2WfF;
	Sun, 23 Aug 2026 09:09:59 +0000
Received: from mail-ed1-f47.google.com ([209.85.208.47])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wy4DE-0000000FCey-1aJg
	for linux-nvme@lists.infradead.org;
	Sun, 23 Aug 2026 09:09:58 +0000
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6a0de062db5so4448193a12.1
        for <linux-nvme@lists.infradead.org>; Sun, 23 Aug 2026 02:09:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787476194; x=1788080994;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=GGjoi3NDLnJCGfWOlCDPBpf5jqUxqzF20wv8NjJVhsnTaPuqbxbo2z1qYoU0hTi9Yr
         bwg3dhkMNzYCCJQHHYfsBIWfOWDefU5wijQX9jXNudzK3Uz+uiQSNUki/t8ynYHdni4+
         5tquCiCau4O9gjwZb69HdWdlx3YXxSpvlJR6HGDaun17XKPCt8dyQoVr2UTPw9qT1akM
         o8UwPGxM+P8ZH/tLViPWShzeC75oJ9JAqY5VqX9BJ8sdpzbf24x1F62ILdgb5/4lDckw
         UHlbenBFEEoi/Z38KRfuJIbv6u4NIuOAkTPWY8nJzy5W+de5vKvxIer/d3rr+iEBGj7z
         YszA==
X-Forwarded-Encrypted: i=1; AHgh+RruS9BCQTGZgiBKa1QS6s9iofH1gpMWpVh6Qxl8YjvmL5Wl4EyTVgenNkEQRGEg3sOYIF79N5+8uqRw@lists.infradead.org
X-Gm-Message-State: AFuF++nQ+r801LAo3rdhceOK9Y0H3JyQYkooNfR8iWP8IzvBZHHOIRii
	k/d76g6cQlKnF9jlPr8KQylrO3H1m1itd9av2lmiFV3f1hddSm4HhR2i
X-Gm-Gg: AR+sD108N5OLIDY1f5VMqYGQvxohodbxfA1lBs3EIRg/U6LopHUsJ7FZKHgP8Y/pPVe
	Gn9dga2ukF796wJFt6AI1PGD41mZbjiiuUjzN0QFRqCnUCRkvfjN0DUUe2jB3LHZFBHieYIGQSt
	WXTC8yV8rRPAbqBL6hi7YQ+jzdbV+RsyLqtIc+YU8kfgQqAFXORAPZf81LZf8ydZRtvm+6hERNj
	vvBTtUCFlZpQIZH7cmeOawO3lO0uBlF443nPbsGxMToCvsZ0DnSpvrgqApTAP1Zb6ohdAsJNivm
	pHd6UiEFzVENxGkL/uLOtIW50EjliP78XNgFlglto/4QMv3ieo7zxtBoFLIW6OE11nK2esIjnmi
	3wMdsOivqYffpp9Cg2MF5rCd7qB+FzthNNw70fVoBW+RFmy4h5ETz34O5vbf+7TagX/sepQcAef
	AeozAVXUtK8Vnh251fvH/7x7uClXcKO3vGybVpKx8RIoA/3tUHl3TGicSe1yKROxtdE1zAjU/sI
	FzWmVmcAPCLWw5/XWKBRfegmz27iA==
X-Received: by 2002:a05:6402:444a:b0:698:351c:979c with SMTP id 4fb4d7f45d1cf-6a42f16f016mr22623575a12.2.1787476194451;
        Sun, 23 Aug 2026 02:09:54 -0700 (PDT)
Received: from [10.50.4.207] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e2d8ae9sm2326174a12.28.2026.08.23.02.09.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Aug 2026 02:09:53 -0700 (PDT)
Message-ID: <4daf6da6-e01a-4120-a9b8-d666fc67e21d@grimberg.me>
Date: Sun, 23 Aug 2026 12:09:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/5] blk-mq: fix status for unaligned bio
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
Cc: axboe@kernel.dk, hch@lst.de, tom.leiming@gmail.com, coshi036@gmail.com,
 Igor.Achkinazi@dell.com, dlemoal@kernel.org, Keith Busch <kbusch@kernel.org>
References: <20260519172326.3462354-1-kbusch@meta.com>
 <20260519172326.3462354-2-kbusch@meta.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260519172326.3462354-2-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260823_020957_398499_9EAA0DB0 
X-CRM114-Status: UNSURE (   4.39  )
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

