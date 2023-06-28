Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF0EEB64DA
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Jun 2023 22:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IJY+GqcezBlL+xi5ObEwKu7LQjgnACic+SnpzDRi3ls=; b=P6e7fMWq9HCpvEz39vIhbJaDQY
	GESgwsvuZskjXg14yGbWjy+c1qlpmsmueWI/aF5vPwHkJd8DoCDWGLWiwX0N/zp0mRO8vSzUfWWjU
	qWZesXB1L5Oiz1l/y9F1m33ZG2eCX6O3mZLRHqnQASfwC8A7SdCKOuadWnEZHVqiAJIfT2Z3Mme5t
	mOdOnutytG4vo8kMow2WK3TPERnEQ8kDWYT1t/RgjF+QnnpwrVRLNR3LlfY4cmfH3SOXSLsi29A7i
	yeZ4HI9eCRV+GWC/iQdRwCWJu+16UQwZK9yTnIljmAo3AEtmInBs+pWp5/6sASAyxWvpUu3PX5hcr
	BHWzyHAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qEdPd-00GsLV-0x;
	Wed, 28 Jun 2023 22:13:21 +0000
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qEdPa-00GsKT-1M
	for linux-nvme@lists.infradead.org;
	Wed, 28 Jun 2023 22:13:20 +0000
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-25eabe8b5fcso7172a91.1
        for <linux-nvme@lists.infradead.org>; Wed, 28 Jun 2023 15:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1687990395; x=1690582395;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IJY+GqcezBlL+xi5ObEwKu7LQjgnACic+SnpzDRi3ls=;
        b=Bi6Dt05+MROdVg1CZIMxtAh3dNSQKtQtRZuiynlR82bus1SAnyCL8l8t0Iw3hT+vm4
         BxLZVyZCjNPDATS+TUyvQz+0cE8H5JEfIE0Lumk4Bn9PJA2TwQ0sdEJo63mdNBZJjpfO
         WPe7Vb+jCDjxiy/fLHymQjy7GhslWmf2wsK0kw9KELgRzGyvwACXqI+0AQCdExRDVVdQ
         JLeQqtCw3F/3mCswHjZGlzBXK68DU1KNAyq9Y3QDXHTtpvXr61En/fyUWcyPFc7d3nTC
         0J6TKV0obQW/I2ZgCN6ayTGmTQJstz08OpgfYQ2N8Z9zSzmfaz0GBIXfMttTq5lQyWO3
         s52g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687990395; x=1690582395;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IJY+GqcezBlL+xi5ObEwKu7LQjgnACic+SnpzDRi3ls=;
        b=SeTTklMFc2OIQ2ZGKb8Y86j4AK+nFEersMVVmhOtkZGCrnCiCCwVH6Vssm/OoMSPZb
         rYb0p3Z3t6QDybXvgoagowJ/KklCS595xu4WPK4Kx5gI5xpLwSEqOq9Az4X1ovjH0cYr
         To0TDN6i2GZQdNBDDiPnUBOjySyliBc8Y5ueZx/frdSrG7qLuAE90iWFVQ8Z3wKq4PL/
         UMkGcJxlWUO9hWl8d0nSykPkJMP24g9ZPqo2oC/xfadZkPikBmtjQhz3FzJm19aGDVMy
         y2u6mhPMJE+sNq5qPpmf85rwvYv3AeEU3SPTLiyyEhflQo9iqZf+cr+ylkjmx1UMWEs9
         6lEg==
X-Gm-Message-State: AC+VfDy+zcQe1NeVl0QkkKrWkYYAgVSV+D61CoRbG+oWpZF3/V2llg1h
	wqlU8fVhQpUXb5+R/qS1WfiojjlgVZRWC2rfInc=
X-Google-Smtp-Source: ACHHUZ7NDR0qNVF1yJ9FJ8h+ENri3Td2Iilzp/MG2qHL5P2KnxsfotwxKccN6VVV7K6RlCazgm8WBA==
X-Received: by 2002:a17:90b:3583:b0:263:2312:60c2 with SMTP id mm3-20020a17090b358300b00263231260c2mr5381891pjb.3.1687990395183;
        Wed, 28 Jun 2023 15:13:15 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id q14-20020a17090a1b0e00b0025e9519f9e7sm9036351pjq.15.2023.06.28.15.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 15:13:14 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, io-uring@vger.kernel.org, 
 linux-nvme@lists.infradead.org, hch@lst.de, Keith Busch <kbusch@meta.com>
Cc: sagi@grimberg.me, joshi.k@samsung.com, Keith Busch <kbusch@kernel.org>
In-Reply-To: <20230612190343.2087040-1-kbusch@meta.com>
References: <20230612190343.2087040-1-kbusch@meta.com>
Subject: Re: [PATCHv3 0/2] enhanced nvme uring command polling
Message-Id: <168799039388.1023490.11718140494575260778.b4-ty@kernel.dk>
Date: Wed, 28 Jun 2023 16:13:13 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230628_151318_688871_CBE00F96 
X-CRM114-Status: UNSURE (   6.59  )
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


On Mon, 12 Jun 2023 12:03:41 -0700, Keith Busch wrote:
> Changes from previous version:
> 
>   Fixex botched merge compiler bug (kernel test robot)
> 
>   Added reviews
> 
> Keith Busch (2):
>   block: add request polling helper
>   nvme: improved uring polling
> 
> [...]

Applied, thanks!

[1/2] block: add request polling helper
      commit: f6c80cffcd47a2d41943e3a41fbe9034d9f6d7b0
[2/2] nvme: improved uring polling
      commit: 9408d8a37e6cce8803681ab816383450a056c3a9

Best regards,
-- 
Jens Axboe




