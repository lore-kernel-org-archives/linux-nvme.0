Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12544C5320E
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Aug 2024 08:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=CYtL15CB4QP7oK3wJjs6ymtuqJ
	kTx0pyK85XLEUJB2IbhGF9kINkor3KWKSIH8FQOVFDmY4MFoZ405F5pgG4erNmujF0kDdN7tKoMq/
	lEY0clsLB/+fQBt5xNBar04fVeJoAG/f36aEpJCVA432Sx3kPAZ+gKXb8Aq7b2sVn/wKmrB8BZX05
	R5IaFJfPVn751dK2UOafHo1kjTuybnPonDBbUEV2eALlfUb+KEEvLG9cPN5DQQecq29DCLUsR2qcC
	wfbyTJ5sucdxzZXchIranmNmTs7GaxgBjNIIZTYLMA8tWrmMWY1D7Muyn34uBdcBB81CDqMadsMwv
	x9gdF7pQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sirKC-0000000AMMU-0EIA;
	Tue, 27 Aug 2024 08:13:12 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sirKA-0000000AMM6-23cF
	for linux-nvme@bombadil.infradead.org;
	Tue, 27 Aug 2024 08:13:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=kRjBtGeUELnEAvTe9st1xr2qnb
	ib29KZxdsPkgXSP5/D3GCPI/F7E8a1eqWWGFskd5GjSuO2PIb5m13zp9p1TSH+0r1WVUz6gBSRvyb
	IUrQ7yB0yQ1rSFOnjG+rzSH2cZ2j6lNwWj1Mu2gBeWCJ+hFMnCAPrNJbc7DqeO3Nf6FTPfSNtCMek
	Lq1B96zWBMa1VWQspKx/8gSBbVaY2MSnlwRYg1M3lyM+RrRodk/nCZ4OjBRGTW4gLpr0SNkBQfcQj
	RNGTXnoxbGCWT72CpdK+BcKFElMySXxENk2VEEhw/PeTtiZXWwH+VOHZseMFkwpIEeepDx+eQlfUt
	OGhG3ZmQ==;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sirK7-0000000Ap8K-1X3K
	for linux-nvme@lists.infradead.org;
	Tue, 27 Aug 2024 08:13:09 +0000
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-371b2e95c34so3000322f8f.3
        for <linux-nvme@lists.infradead.org>; Tue, 27 Aug 2024 01:13:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724746384; x=1725351184;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=VsT955y/pFG/fI/KEfm1WmT+R4Roz1xCoGOomYNJVXCmms7TCK5+J+LWhjEyNrCbm2
         i43Prarv0N4wg2hoHhrNuC0cMe0vTLcmbzZ7EDQPICubjXrhEI+wULjv+/WOlVyI9G2r
         OiTGdz4xqa819mfHLyKR16H0BU64r4W+icG2Du3S0xP32hCGUkMKw1w6uPUP4OmgKmsV
         2bwBVqoVhHzhFwWBvKHlojl/+yoOJjYZ26T+/aNRJ6LLbjo5X48/UjVQUjbMNnWGwygh
         X5Y/WPFXcz56e1xN/A0twYvL0dhqttT7UimSs3cUMdFIOLwx7IMD1rfhZWuTEzk56F/L
         ftdA==
X-Forwarded-Encrypted: i=1; AJvYcCXKhXYTVD6lJundjHX1Y4OpxrOTeWKfJneA9reGggR/4TzpDw5n/m05YTXOO/vV9XNo2JrWu4nwAXco@lists.infradead.org
X-Gm-Message-State: AOJu0Yy+irFBOyjRnqzkKIXNPtssUnl/xAfpFc2+jgcWek3ssj1O+XG5
	F29Pjtq/4fgU2gRVwRfRUtFBN1ZMO1QDsLDLHg/JaU2koJ13vqPj
X-Google-Smtp-Source: AGHT+IF0eIxsc0cBjsQcTB5YRVuRvKOF6dJfut//BEYJyKy/JMKXtxtUQ4GbC5IXEv0tMgSuhAhwNA==
X-Received: by 2002:adf:b31c:0:b0:371:8eea:24b1 with SMTP id ffacd0b85a97d-3748c826b00mr1468920f8f.59.1724746383350;
        Tue, 27 Aug 2024 01:13:03 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42b9d945144sm14320415e9.0.2024.08.27.01.13.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 01:13:03 -0700 (PDT)
Message-ID: <708fd373-d66f-4934-a7c2-5f3c37743d55@grimberg.me>
Date: Tue, 27 Aug 2024 11:13:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-pci: allocate tagset on reset if necessary
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org, hch@lst.de
Cc: Keith Busch <kbusch@kernel.org>
References: <20240826182719.3830725-1-kbusch@meta.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240826182719.3830725-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240827_091307_612095_FEF505E2 
X-CRM114-Status: UNSURE (   5.18  )
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

