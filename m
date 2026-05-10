Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25AC9CD3427
	for <linux-nvme@archiver.kernel.org>; Sun, 10 May 2026 22:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=iUj8S3wjzYoOyPFt3Kla2f42Eu
	u56oU2US2iLV9YZ0XSfFVR+9FymmPU6bDmkZstMPXoNIg/GCkMROc4/qdgZFx4n7aNkdux06gAn+u
	IzxvAhOUp0z9RWeqiuIbNkZ5tOqGDm74Ui74TcE2uWhHVf2WTHyDsDF3/Mu0I6iVgG1ZFaFVZ9IGh
	6nZ0ORIIcRB3vQXmCMh7D413OhE+HukyBW2MGrd8soBrkFT23mSNqsGc0Ax5GeQ/tx1JYhMBnH0gp
	HDLq93cXNP43CNB6ftcZhvGJxhm/Jk0V/ahM1CrmB3Bb2Kgj9m+ZUzznLGk828A/h/vgxRpWYB7pp
	8/DDlqUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMCS1-0000000Bk06-0uCO;
	Sun, 10 May 2026 22:16:41 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMCRy-0000000Bjz9-2kPj
	for linux-nvme@lists.infradead.org;
	Sun, 10 May 2026 22:16:39 +0000
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4891f625344so35233665e9.0
        for <linux-nvme@lists.infradead.org>; Sun, 10 May 2026 15:16:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778451397; x=1779056197;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=dNBiBfEZGvEsCGhD3J+faEMCaPYwWxq1hcjCcM2k11gsIkEvSLCXpc+OX2IcjcSKY1
         45Pvd+KD3lU9hYI6H2NSWAcUKE3nhQxZ0nAqYGjKJNWPnJfEMQ6V0O9sWYrS5a4C09IL
         79ZoitPd9jexAlENthkqishTUGP82OZL3OWYxLjQan7WXopptpeBNGxMlmxtcjKn9HdT
         nHI/4Ec1mhINUVvj5OOnXZG3CR5zYt5zSSS248XGyElbcXPalyTZhD68qer930yBFZi/
         LeouUmmF4atgOuIbBXiS2YulNOh7r6kM6yB+gUeF0yIoyDhEIv+GsYIBrGGz3xt+FYlj
         SL0w==
X-Forwarded-Encrypted: i=1; AFNElJ+jk8s1Xh1zo6q7je8eNtcBYBDNxtp+uGPYhlKCGbb/zWIIDq+tEHsNpeJwAGHuGV5SxilokDAgK+bX@lists.infradead.org
X-Gm-Message-State: AOJu0YxzQqtPbF/z4XcNWu0dSbIzSgDK814U+UT55B89xHiurRwTyUQF
	BBI9mATCifCTVuVDLyjlmEn5V7ac7mS0aLZR46uuHzUKu0b9QFYDDcnw
X-Gm-Gg: Acq92OE8v51pmgyJztEV7sUUbFTCljt8DXYXvAsFjfpWYqMVAxzIHrU73jy3j4lH1vw
	x1xD7e/HSaPxeEl2dsIzTPB0QRZzwE8muGS0Gr0aPZFn7Z4n/YQp8pKWadrgLM12IRnKtD3BA0d
	e7pmusIWqVNyvWkDg/yQvncmzxSEknXG+5sXARQ0eKkXGWdR8Vt6I0Jfjb8Us6ljcI9tYqZkyqH
	A/79yTVp0BDyOKgInqdf/MwgtucNAXhcWHQ3rlmBVdSHSzIM6qrIdvN+YfN3m5nPRBEEjfJywUH
	2L6PMoVfuqJaWUlF/lToVMEceDZGIaL2baxfCMAN0KjDGqmFJ64JBMTHh/D4zGi/6uagtQPbZqH
	XaY/CroDchu+RoUt41Y4TXQdUhtrAXjdwLuyKuPih0ErktrV+Yjb0IhXto3zHxrrB0eKKorT+lt
	+p+WQjcvSXHvYutj8iE6F5NQQrwG/H2w==
X-Received: by 2002:a05:600c:630f:b0:486:f893:56c6 with SMTP id 5b1f17b1804b1-48e5dffab3dmr253829435e9.10.1778451396619;
        Sun, 10 May 2026 15:16:36 -0700 (PDT)
Received: from [10.100.102.74] ([89.138.75.0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548ec6c79fsm22229920f8f.15.2026.05.10.15.16.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 May 2026 15:16:36 -0700 (PDT)
Message-ID: <920bc437-7690-419c-a1f6-d2bc1f5c0bd5@grimberg.me>
Date: Mon, 11 May 2026 01:16:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 9/9] nvme-core: warn on allocating admin tag set with
 existing queue
To: Maurizio Lombardi <mlombard@redhat.com>, kbusch@kernel.org
Cc: mheyne@amazon.de, emilne@redhat.com, jmeneghi@redhat.com,
 linux-nvme@lists.infradead.org, dwagner@suse.de, mlombard@arkamax.eu,
 mkhalfella@purestorage.com, chaitanyak@nvidia.com, hare@kernel.org,
 hch@lst.de
References: <20260508133335.98612-1-mlombard@redhat.com>
 <20260508133335.98612-10-mlombard@redhat.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260508133335.98612-10-mlombard@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260510_151638_694201_E17B8342 
X-CRM114-Status: UNSURE (   3.52  )
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

