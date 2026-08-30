Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57CEAC61DD9
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Aug 2026 21:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=u/vJXt3jSiXjrwkbFqwT/C5Ais
	8sFkJvLHGlw/vDOqZBYlvZ9iByp4YGmu3w7Qc8jqzLB/YNaflYzNF7qnc/ClhrQHEwBfnaXjsIWnX
	kPBq1FqKMmeW63Ut8W0A/Sar/y+72dk/p3ZfAt8oq/lgU/vji5gi9zSWY5dDe7PcI0Tm1nGX/HoxS
	QEfXPGnzvNnydmvScLsvHHc1dX2VSbcyWaxW1qyxNhSWVbnTAZHlSgc+sdYuikCnOKmsJTAy/Um6H
	XAciyLM0Qu8Vzd00HnJSyneSVRHahb9VDTw9wC8PReCIZKjIviTE35/PH+Srrk5Eifjwql55umZVh
	2b01K62A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0mtz-000000086nR-49Co;
	Sun, 30 Aug 2026 21:17:19 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0mtx-000000086ms-2c9v
	for linux-nvme@lists.infradead.org;
	Sun, 30 Aug 2026 21:17:18 +0000
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-484392e3d33so307354f8f.2
        for <linux-nvme@lists.infradead.org>; Sun, 30 Aug 2026 14:17:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788124636; x=1788729436;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=qP38AGhnkXa4O7OD1L3iV2z0/kBfGJHA0hfCICg1YdB8NkK8FatF9jWpMrGk/cVw/8
         KZhFjsc8gpwstDgn+yr4rdKeW8pmetXJLXC/CRY96gEcDXJ8OhlFMGPTq6GTtkvACPXs
         qqon2RqrVr9NxtSLnA11DCzpEWILDIzKVc/2BjUOL6gobZbrXFRGZhHmqiZhzeO3vQjF
         k9X9WEYLQ8exhy7V6JbCq+ccxnr572ZJtvCXDA0Dsv8GYBRm8vXD/OWchJpXJl/VYDO0
         oLaNEpJH8Kgxhhpyg9b5lk945YQsoipcmiXiat1V/VyqdnEo585frcJcjz5cE/qnBVbn
         FP+w==
X-Forwarded-Encrypted: i=1; AKwUvBwzJq//A0K+m5c/e+Kd/dsR/vnyzFw4KjHV5qNCjzYBTYfuHa6/SL5RXizSfrPqU/KCPkqluQHUsirU@lists.infradead.org
X-Gm-Message-State: AFuF++mb3MlnnO4qfY8v/qvEIAG29DPsCOEUyErM5aNKD2cVWZ3+QgJL
	0l/JtTUsQgP+r5BFiEk756BWlUHZ5i4EqqBnRjzrtbpCkf1v8DQ6NXRU
X-Gm-Gg: AYBFou2WS/wD3glL4dSOAoWjjmcoPds66shTrhvhBBm/f5chLjtUc0nX1SsqNxH+Elj
	oc1yeFyJRmuuvmhd9QTObk7v1KeB47AjvS6SrxOhKirjk0+V2/STsigvV8tuVD3ycu6qF1QUTEL
	HomMOSKCGPz25DwwpkCFSuxaTSml83k7/kNaxJ3IA3yxU8Ru5rwuYo+XegxK3xb8YIbrLiTVp/s
	7KKjjeTrqSrEM/Dm9g6dkrMiclJHjmuWLAdaEWnSxu8owPL88tAo0CKu96PMDysJN/UAxDln3P7
	1IxDRWmdgUWUiJg7LxhpAgIGqCRmnHRwTxyUvlraWEvVCsnwOvYxAAEPfVf9EgohQH84pkrkMCB
	uAzvc+cHswEewjtsm9CbUzpsUcpduQzYIreSDHPl9rUsR6yiVZIectNZxR4y6Gw6iZaXW8vuBNZ
	d0zX6lZIK1llEdWvUzjuR+cOKjkIOIb2jCkCV0Z4ofWk5x9h6Ms+ceb/49Lmy3h631GCTFGDJ02
	F21dJLAVR3SmlaYuIzVWw==
X-Received: by 2002:a05:6000:41d5:b0:484:36e3:a427 with SMTP id ffacd0b85a97d-48436e3a5c3mr11060867f8f.2.1788124635719;
        Sun, 30 Aug 2026 14:17:15 -0700 (PDT)
Received: from [10.100.102.74] (89-138-77-243.bb.netvision.net.il. [89.138.77.243])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482fbb33d58sm15962156f8f.35.2026.08.30.14.17.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Aug 2026 14:17:15 -0700 (PDT)
Message-ID: <4897e209-7fc9-4421-9cd8-589e83e94436@grimberg.me>
Date: Mon, 31 Aug 2026 00:17:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH nvme-7.3 v2 2/4] nvme-fabrics: add helper for owned string
 options
To: raoxu <raoxu@uniontech.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
References: <0D24A9A3F19DBCF9+20260827125710.1381672-1-raoxu@uniontech.com>
 <92BDA706885092E8+20260827130340.1390531-1-raoxu@uniontech.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <92BDA706885092E8+20260827130340.1390531-1-raoxu@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260830_141717_664371_CA854FF1 
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

