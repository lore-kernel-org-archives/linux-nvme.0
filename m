Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A286DCA0EE6
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Aug 2025 19:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2PIjZ+DdmvuLwnrpTYlLbFeMpxoFxo/PTXBFZfTSGBg=; b=JfNWSnTzz14EIYleuw0KrB/+5g
	H54hLavMtVT7UGrEhuIQq4d8oSxcImw35UGHJ1052ajLotkGfWfSqhi28Xa7KjnDrNfuoAg3YPcYZ
	cLd0dkxQzG2qxkmq9aB1GLszik2TRU8Kbz3YukdCkaXtf4WnTaC5zsFfX6uf7I2lmA6VGW7mJJqcP
	SIfy7QpFsRyxD7V5zdNXs4WvOIcJkzWZRtoNmEKwz1Xl8D+nJ627WOiM+HB+hAhWqnPjqehGld85D
	3ccCXS7BPxR1PbB51KW2We9wb4W483lDyLVGs0W99UlEn/HlaQKBoLYg4HAV72i/lareuZ6OtwpGb
	5AsziMUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoRvA-0000000BOlV-2vNg;
	Tue, 19 Aug 2025 19:23:00 +0000
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoP6A-0000000B0E7-06vw;
	Tue, 19 Aug 2025 16:22:11 +0000
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-76e2eb20a64so5935838b3a.3;
        Tue, 19 Aug 2025 09:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755620529; x=1756225329; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2PIjZ+DdmvuLwnrpTYlLbFeMpxoFxo/PTXBFZfTSGBg=;
        b=SC49yUJq3zSCugfEnQ5MS4dXmectgAv/hijJ1kCXrH2u7QuIWVfi2q4Yd+PkIxX7MA
         AAbbDYirrvl11yhQpJv1+sDDCp1W5wWiaYUboOJdFYNfvgzMnkzaxrwK7alCdoIbBU7k
         3FBo/FbTiU+Ljqu2XE1xCiSkyXxyu3BdphcJIEy2nGTN3X0Lrt6nzHlpH0QNMIcqkH7l
         g3F+yuj/f1Byu2RjGNerjM6HisT3a+RmOkCTZ5OZsMVrZqrHoloaSj/+5kj9G6nljE71
         LR/UCCOZNOs8PsXGCVz83Yz8RtH+vg/wYAja/X5kyoSOcdQKyhwGz4FlbQLWtZ+VsSxq
         CdUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755620529; x=1756225329;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2PIjZ+DdmvuLwnrpTYlLbFeMpxoFxo/PTXBFZfTSGBg=;
        b=qsL4Ej/V4+10/Lii4JQHsHphsMFodzl8CizoTwOLMNC/MPeWoUSAubhnZcf3+rFhUH
         qM6rMly7UWB9nyWtDkaHjarAiiikXQ/2UxfPDeseL3suAdrPrf6f7f/LBVQIxYEM9FPu
         2oZTjXs/SnSlWkpHgCOx4HBcUSWk6gMnjn5/uwhWUm67BpHgvYa+QwyFph8GYNTuWQUT
         VnKdTbC0QWeltQDo55rZ+eQLTFE2El+LJ+gYjTTBh1w+l/UUdo6mfNOK4FHfyGPPjelW
         vF589HFBAxdFiponVfyMx1CptA2C/sC0oJXUh77oCQ/9xp1ucLsW+ToM9ob3T+DXRxzs
         X7Yg==
X-Forwarded-Encrypted: i=1; AJvYcCUF7J0Sy9Ali7R6kVfb3vJ/YvAFWg74KWcc4SmL2aWjYG+hpyyPvckuTQfdL/jG1gYimR6g6YQni7N//T6+Lxjf@lists.infradead.org, AJvYcCWwaOhGP7mWHTO7pn17LV7MwCbgDhIWFXs18ZMujlgrRho6hNhiAl4ndrwPOJtcNeC+O3pvU6VqqbQ5Dw==@lists.infradead.org
X-Gm-Message-State: AOJu0YyHZiraq8uoV8G+lHQwc6PXZnGw1Wgw6jPBR2MamwafAyZ+jYok
	GL3RE46X8AF2AwAPqe5Gdw1QkPn40pqdXjnUVTJ9lOvdsTUaaQZTfvEC
X-Gm-Gg: ASbGnctNdt27GpzPiYuTkN6ow0dDe99ohJbAR0akut9paP7UKAG63eUXfxUmlYpgz+Y
	6gXM9QEwBGrFDsFDhIEg/v1PWR8UFJT1Vep7ayS2mWmqMlL+103qaWnIl0qgxkyC82xLHuctdq+
	+HfJLPqlzk1kgtrp2UudG/dxOxAMJZPbQ4Prk1EU6RpMv+f4L/5Nrkjt9DxJXHd1K/KN5fnuuGU
	bhW0kIyrKLskXvWipsxx2e9iLHoPA4Nk8SoOleRA2NpgrTZWuTkox5AfNlfhH7V/lH9W2W3VDYk
	sJ/hYzA35aGytsVz+Miz0vASZ/3ICOyjEfRsVB9FFj0z9GMlxsFTzLxfz6xDs60zUnEDaWyMG2O
	8TnfptW3FfQPLMqwj+PYkVGzp8/0DwSxhVrSb9Nc5oCIetldaDJCo1h9bcKP/J8Q=
X-Google-Smtp-Source: AGHT+IE1/3he44rcwmPwhGdP/2lEsUGbA2b74tOIcgVsabuA/J7rKhxfaf9z31Cj2VPPRLhP8RZaew==
X-Received: by 2002:a17:903:3804:b0:244:55b5:7cfc with SMTP id d9443c01a7336-245e047bc13mr43207695ad.37.1755620528713;
        Tue, 19 Aug 2025 09:22:08 -0700 (PDT)
Received: from [192.168.0.124] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed4cc807sm1323105ad.82.2025.08.19.09.22.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 09:22:08 -0700 (PDT)
Message-ID: <66ec7bd7-6b14-4766-97a1-3928d9129880@gmail.com>
Date: Wed, 20 Aug 2025 00:22:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/9] nvme: apple: Add Apple A11 support
To: Christoph Hellwig <hch@lst.de>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>,
 Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 iommu@lists.linux.dev, linux-nvme@lists.infradead.org
References: <20250818-t8015-nvme-v2-0-65648cd189e0@gmail.com>
 <20250818-t8015-nvme-v2-7-65648cd189e0@gmail.com>
 <20250819083038.GA1901@lst.de>
Content-Language: en-MW
From: Nick Chan <towinchenmi@gmail.com>
In-Reply-To: <20250819083038.GA1901@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250819_092210_070844_485A0C4B 
X-CRM114-Status: GOOD (  21.27  )
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



On 19/8/2025 16:30, Christoph Hellwig wrote:
> On Mon, Aug 18, 2025 at 04:43:00PM +0800, Nick Chan wrote:
>>  };
>>  
>> +struct apple_nvme_hw {
>> +	bool has_lsq_nvmmu;
>> +	u32 max_queue_depth;
>> +	void (*submit_cmd)(struct apple_nvme_queue *q, struct nvme_command *cmd);
> 
> Please stick to 80 character lines for the NVMe code.
> 
> Also I don't think an indirect call here is a good idea.  This is right
> in the command submission fast path.  A simple branch will be a lot
> faster.

Ack for both of these points will check the other codes that got more
indented as well.
> 
>> +
>> +	if (q->is_adminq)
>> +		memcpy(&q->sqes[tag], cmd, sizeof(*cmd));
>> +	else
>> +		memcpy((void *)q->sqes + (tag << APPLE_NVME_IOSQES), cmd, sizeof(*cmd));
> 
> This could use a helper and / or comment to make the calculation
> more obvious.

This part of the code could be further simplified and after that
it is similar to nvme_sq_copy_cmd() in pci.c:

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index f3999b8ef7ab..ff4c2f87770c 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -295,20 +295,17 @@ static void apple_nvme_submit_cmd_t8015(struct apple_nvme_queue *q,
 				  struct nvme_command *cmd)
 {
 	struct apple_nvme *anv = queue_to_apple_nvme(q);
-	u32 tag;
 
 	spin_lock_irq(&anv->lock);
 
-	tag = q->sq_tail;
-	q->sq_tail += 1;
-
-	if (q->sq_tail == anv->hw->max_queue_depth)
-		q->sq_tail = 0;
-
 	if (q->is_adminq)
-		memcpy(&q->sqes[tag], cmd, sizeof(*cmd));
+		memcpy(&q->sqes[q->sq_tail], cmd, sizeof(*cmd));
 	else
-		memcpy((void *)q->sqes + (tag << APPLE_NVME_IOSQES), cmd, sizeof(*cmd));
+		memcpy((void *)q->sqes + (q->sq_tail << APPLE_NVME_IOSQES),
+			cmd, sizeof(*cmd));
+
+	if (++q->sq_tail == anv->hw->max_queue_depth)
+		q->sq_tail = 0;
 
 	writel(q->sq_tail, q->sq_db);
 	spin_unlock_irq(&anv->lock);

And this seems obvious enough on its own, and should not need comments.

> 
>> +	anv->hw = (const struct apple_nvme_hw *)of_device_get_match_data(&pdev->dev);
> 
> Do we even need this cast?

Don't think so, will remove.

Best regards,
Nick Chan


