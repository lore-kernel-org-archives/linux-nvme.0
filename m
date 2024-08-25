Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5963C5320E
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Aug 2024 09:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=mALUUOD/t2YCgdX1jlvA8ZaunP
	s4V1sEm9bYXER//pkMZppWsy9G7PTS2Ibp0u/wchKwyIps2dtCEjLB4mhApzdnhIQyvS+5jg0+SIk
	cz4jNxmHvk2h14DOWENjtAba/+g09eDUbJJ5RLC5SlT/DE8dVkL8jUukr0T4ikl3lA/GfV5glLGGj
	H3zVV7uHFy9vTIynq91XpAXpX69qbzCE2nDL6Jy/qONJ3NbzoVpykPeslwIApC0UQP09INn+dhEpc
	cGOHug7HknzB30u6xTEP8SceD/bLUtulRG/2Gtq3+PwDNLW9YEX9HIHLYNcuD8RiHFx8DM04MbNFR
	PnawcOPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1si9BH-000000041na-1uur;
	Sun, 25 Aug 2024 09:05:03 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1si9BE-000000041mP-27gu
	for linux-nvme@lists.infradead.org;
	Sun, 25 Aug 2024 09:05:02 +0000
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42809d6e719so28499865e9.3
        for <linux-nvme@lists.infradead.org>; Sun, 25 Aug 2024 02:05:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724576699; x=1725181499;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=Gs63fvW5uBltRAyBi1bZfijprnFgKi+Xnmz/Wk5MF545LNAfYzt7eIr0/4buu7wRQD
         lW+Hvdrec+n/Fln3JumVZo8fu6hMyaeWEVPUfOUWqnvDVoZeaIgUnibjGT8v79SAN03K
         xz60MqO9uS8w3FlSyr4TUc6omeJTopz5D69byV1vkWHDj+xmmQ3JxffXxDHLMx4M345U
         rmPfJ9eUPhX4WU+nBrda3/1o37f5I5uOyMuxe4BoOOUexvbZ3GuDZRHYTxpPXbSo2Uu1
         vM2idzVhBTDitf19VP1Ud/o3eR1a67SV9ZFjzYXgOve0RZk8Qds5+K9tG0GYftmjOPON
         1uIw==
X-Forwarded-Encrypted: i=1; AJvYcCW5x3MFR5GoEpnDD76kRq5ozxZTvlZjcZFrPVYgco/MyOsIsHIS78rVyk/4p016nzOeSPFCCY37g6lW@lists.infradead.org
X-Gm-Message-State: AOJu0YysQKy2wA1w0cJ6KheImMlS2tjmdZmLvpn7gpDVCyhQ8tHJQcy1
	yYrjBZo6cL+sYzYCp2PPuovHbI8z60UaPibyGQtWJJnLFTh0mEHarWkPnQ==
X-Google-Smtp-Source: AGHT+IGzH4PC7AYmSsiLfM2zBa5/zac+BfX1F1eUtFLMRL7SMXBVtQzj1CwLEAzHJA6KVUOctKT3cw==
X-Received: by 2002:a5d:4404:0:b0:371:8a70:b10e with SMTP id ffacd0b85a97d-373118e9f6dmr4254122f8f.60.1724576698339;
        Sun, 25 Aug 2024 02:04:58 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730815b420sm8200136f8f.50.2024.08.25.02.04.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Aug 2024 02:04:57 -0700 (PDT)
Message-ID: <0785eb51-8fcc-416d-bc69-a30ee15c62a4@grimberg.me>
Date: Sun, 25 Aug 2024 12:04:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: use better description for async reset reason
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org, hch@lst.de
Cc: Keith Busch <kbusch@kernel.org>
References: <20240822152259.3896264-1-kbusch@meta.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240822152259.3896264-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240825_020500_550419_FCF9C371 
X-CRM114-Status: UNSURE (   4.78  )
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

