Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA009C61DD9
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Aug 2026 22:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KjwtFcUEzfpKYWKA7ptB92f8FX3uTX7SalDfIgZO2h4=; b=og6iIayi23bTDIrvS08CoxLm/g
	tKxLlVn3pPNDh7Sb+qA2KbKXq6Ejx3oz52x8fpMEWE6UUMX2t6w6T3tYT8kXIl+84dn4GyyvwLm5Y
	Mo2vrvZqcQkvt+arMvfVMhjFOlE1WRUW+9bL/HgrGUPOwZIdH1yuUSkuDHs3jgRV0uiGsJQpw/xsY
	A1bBI80J8iLF+2h9tuXfSAe7gFjc/4lBwX8v/nMd2Lx2wmNtLWjZyGCplU3pFFP2PIlFXNglAN5UN
	qtHf5IYjr76EIxdPQN5fltHumzVZrPhmize2TgWJRYtoh39ECy0NEGJWG4iC+xC1lmk6SPARm4GYx
	8InjY/sQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0oGV-00000008CB5-0qOL;
	Sun, 30 Aug 2026 22:44:39 +0000
Received: from mail-wr1-f54.google.com ([209.85.221.54])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0oGS-00000008CAk-2Iqn
	for linux-nvme@lists.infradead.org;
	Sun, 30 Aug 2026 22:44:37 +0000
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-484392e3d33so325404f8f.2
        for <linux-nvme@lists.infradead.org>; Sun, 30 Aug 2026 15:44:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788129874; x=1788734674;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KjwtFcUEzfpKYWKA7ptB92f8FX3uTX7SalDfIgZO2h4=;
        b=blOrsK/q4mvEHse9KTYANZ7iXqF2nmZ1aYCVhYbxvHx56yQZdXG0qRPsn9OPY8Ii5W
         lRnMB6js14/mu0JDbY72Z4oLNJyWass3XBPDKpB2bLNzUuOXq8toIa2lU//kktl7VvS5
         ecLbs95MiGh6sU4RcPckhXclKYeyubBB36LvOE/5VNCgnOA4HszEz5hSakOV++eNdq8e
         Ig5+I1bihT/fD3TNuWJnpCkOq7RrYHJ12K9r9GTfzP3BGJITy2wdF3zCJ4AI8ueFdjrW
         /ElBt6+XGv9GDI7PtQJP53yuzzXCNzzoQF/SfwGQFqctSJmV34jI8b8G+mXuaQWewbtG
         cb/Q==
X-Forwarded-Encrypted: i=1; AKwUvBx8eqvuGkjX9zDg9UAGQE7BBISZ2KL3L+6HuBHJbhG/mZV61NNXGQ/D2gu3FAt/Cy9BOMkxC81m7voy@lists.infradead.org
X-Gm-Message-State: AFuF++n81CcoJ07v8NqB3uDQ39DzawGVVnuLXxsh+2T+E60hQluyogtk
	cYBrORMPS4QXCalIA5rV4+D2gF0cmR9hkxIW3IldbiAJOv7k9kp3EKQn
X-Gm-Gg: AYBFou2aVF95WdKnwC8m86bU32dEBkg36H+rbiS9N6ag4YlrY6nfa1oONsqssWXbnaG
	CuzXfQuKLB++/C0LxhXBcoVP18UqMXi4fXXlVYSicWHE8vIH+VN5aXWbV3YXxkq4r2K/xRTnq3w
	rnqiyWnafUJFKrewBS3HY9IXhuVryFEnm8FcKiH+E+QcXUfWpOs/ckRrylgLVhTS4sRBMMbiYGx
	zpZ90Na/SQMEfu8KpyT5wR3vRWuIh6UiZyVStHbV/uu/xY4G+P0+MoaWEFeYiYBhmNQfSQBmG4d
	1cprEo968Rz0lUfz0L+0wKwMl6nx1w1ou/YBe1AYTsq1+jSOjQ7DD4i/vGFVrZcpgtefa8xjydK
	plXJPncigZb+k1o8BUgX0s4LLDJHlvbPt38yaBVjHqbPXj9tOAntcj5vaIqktWab2zPPntq+XpD
	FJ2UPJ+VEdA69S2fBZpUmvTCsC/9RUA+OnKhLoXMxPkqjjuxSvg4q4IqgVISpUSEvc1vnnBHhCY
	Q0A5kIz+x6YE7oZnXQlrA==
X-Received: by 2002:a5d:5f08:0:b0:481:3124:c71f with SMTP id ffacd0b85a97d-482f79df070mr34983055f8f.17.1788129874388;
        Sun, 30 Aug 2026 15:44:34 -0700 (PDT)
Received: from [10.100.102.74] (89-138-77-243.bb.netvision.net.il. [89.138.77.243])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482fbab3f16sm20507449f8f.1.2026.08.30.15.44.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Aug 2026 15:44:33 -0700 (PDT)
Message-ID: <4f2d2b60-56f9-4ae3-b38f-bba9754011df@grimberg.me>
Date: Mon, 31 Aug 2026 01:44:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] nvme-tcp: parallelize I/O queue allocation and
 startup
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Surabhi Gogte <sgogte@purestorage.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 randyj@purestorage.com, adailey@purestorage.com
References: <20260824225648.316962-1-sgogte@purestorage.com>
 <20260824225648.316962-3-sgogte@purestorage.com>
 <c98fe50c-172a-4e53-a30c-5416c40cb23f@grimberg.me>
 <20260830222558.GB1842415-mkhalfella@purestorage.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260830222558.GB1842415-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260830_154436_598844_46D5CC7E 
X-CRM114-Status: UNSURE (   9.55  )
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



On 31/08/2026 1:25, Mohamed Khalfella wrote:
> On Mon 2026-08-31 01:00:52 +0300, Sagi Grimberg wrote:
>>
>> On 25/08/2026 1:56, Surabhi Gogte wrote:
>>> -	ret = sock_create_kern(current->nsproxy->net_ns,
>>> +	ret = sock_create_kern(&init_net,
>> I don't think we can just change this...
> Why we can not change it? Today the error recovery code running in
> worker thread will be using init_net anyway, no?
See commit: 1be52169c3488ef98582ed553ab35cefa3978817

