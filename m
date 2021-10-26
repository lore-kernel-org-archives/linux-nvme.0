Return-Path: <SRS0=3UZ0=PO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F5AC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Oct 2021 13:24:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF64860FC2
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Oct 2021 13:24:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CF64860FC2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=Y8gbbNwZSGBo/pxcAi8Y/ZKUGr
	oGOy67IeRUzcg+BRwZG1+bERK1TxHbQYRc9kKSMDYqx04ahcjL8wUJcqH1p2PZvipkXnNLESInFtk
	L4+loY+cz7aLKWTf2GlZ/2obHOuNf4e7NnnMHrOnoG4nnC4AptPwxKb45fF7+tsDahZAJ96TJftQ6
	EmOAol2zyOEdv4Tl9cbB+kFe3qdXT/T6oAvWbYZC4e+aV29ZFVgOteJcJIZGVvfK11+aNO7ZkyaIP
	LqITX5aOAx5nr7zbnZDto2x5ihE+17KaPt3AlCjO9Y3+XuA/8vgxTFuxaa/765aGaHJTmouXw9twQ
	kbl46/ZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mfMRU-001sj6-Ey; Tue, 26 Oct 2021 13:24:40 +0000
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mfMRR-001siJ-KX
 for linux-nvme@lists.infradead.org; Tue, 26 Oct 2021 13:24:38 +0000
Received: by mail-wr1-f43.google.com with SMTP id d3so15086121wrh.8
 for <linux-nvme@lists.infradead.org>; Tue, 26 Oct 2021 06:24:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=Rh52f1e4iGnTGBHe+4kMedN+Rv+YcRcYGvILVoTdG0uMId1th9aduXkTyjXVOPFR46
 L/pnANwBHRq4rtu7xmnzR6j/ZIPm/IkuX6TGAlwWI2nvjdOOVrZsuRM5wxSQljP25bcO
 hR0u1UUGSvUJdb9HqbrrPyuSdXlhmXgZo3MlPmrWIRObJbCyYKRbwvfyACNQti3iPD3S
 TJTnQti76U/B+EsMrMyxzg556RWyNvJXnG6Z7x3YQDrp9pevcvucxTWqNmc3fRJd9E3A
 ZU91rDZl7i1W+41/ywfwpDRoKADqzPm03pidNGs/nPGy7JikUHfNIOAEu3Wt99sTenDU
 dd7w==
X-Gm-Message-State: AOAM532TzK6QUaYXqA8wR6xIfBzcb9EStJgBwIlLBF1kZ3NKQ46ot+d1
 4O4bIqC5UPJw5jE0oltFE+dwFB5xqZI=
X-Google-Smtp-Source: ABdhPJwgsLb2CybCI8OLOjxVenOMwc7c8a0zfMtK1YGYLn8LO/7VMN0eJ/b6IVxHlScTPUrUgcTQrw==
X-Received: by 2002:a05:6000:1849:: with SMTP id
 c9mr15673277wri.361.1635254675445; 
 Tue, 26 Oct 2021 06:24:35 -0700 (PDT)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id q18sm629532wmc.7.2021.10.26.06.24.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Oct 2021 06:24:35 -0700 (PDT)
Subject: Re: [PATCH] nvme-tcp: fix data digest pointer calculation
To: Varun Prakash <varun@chelsio.com>, hch@lst.de
Cc: linux-nvme@lists.infradead.org
References: <1635182250-4006-1-git-send-email-varun@chelsio.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <f9cfb1a1-e9ee-ed23-5c53-3c67cc8259f5@grimberg.me>
Date: Tue, 26 Oct 2021 16:24:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <1635182250-4006-1-git-send-email-varun@chelsio.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211026_062437_704880_41B03A27 
X-CRM114-Status: UNSURE (   8.50  )
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

