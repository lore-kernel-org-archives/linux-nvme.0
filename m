Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26E75D2D111
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Jan 2026 14:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tfuxnF5eA4o2hoE0e5MjV7YAHQFMCIYI54d1UQv901M=; b=XavSCrYsQ4VNEBIZCKk8ucxps+
	bUxpg0wBdKBuXOxxRocX7scKM9+s2jKJ19z7sc72Wa04wmpTFMv4wT4WjlQ+IVBn0vz8Sr9/TFD7z
	dU+Na2rxjuMtGSyhXB2kvkqlmTfTOcjOPknmDL5qLs2l3ZJUZspd2L+0vRAsu3P+LEnLXCScR/kSe
	Cd6u9GTshCnnmtUSEYGiS2sPYz02At1lPLD2ck5n1v8oPT8E52Yx2jDju9HlslxuD23jbvlSFkM9j
	Rc4Yw5YxDIAj9n1uWdZZh4bbgeLdeMm/KlNYkJOLenogHwTtJKX6O6+7IaZkNVBu07n6cZL6mHzCi
	uT7bD9xg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vffMd-00000007FkO-0fqO;
	Tue, 13 Jan 2026 14:27:19 +0000
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vffMW-00000007Fiz-10Rn
	for linux-nvme@lists.infradead.org;
	Tue, 13 Jan 2026 14:27:14 +0000
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-7c7545310b8so4319615a34.1
        for <linux-nvme@lists.infradead.org>; Tue, 13 Jan 2026 06:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1768314430; x=1768919230; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tfuxnF5eA4o2hoE0e5MjV7YAHQFMCIYI54d1UQv901M=;
        b=VPoc+y5TzZ6Duz8laXmwqjkuBgU2u7xYj6R8YHRN2naOPjqQ1vm7toZTeX+wRJixYU
         2r5Xpi4WpNO0Y7qteBirp79imy55OymUkQt4FoI5akki25wIv5y3c/YdSrF8ynxH3axq
         dsfj8XzSTX5PpM206aoHnFvDfCLtDzA3JcgFEsC3QSOKS4B9bD3GMnT35Kglyx0HrdiO
         zDJsnCDo5aikQNva/m0MYOxJ8NnyusgwygtJ01I8nNHQAziIUzzj8p2tsz3iR34/KiHW
         rH738VcWKlAlTP4pnD595CfXJwxKstkGHPu1OdtYHPBBeMRljTHhFo4MNCDsO9kwo56C
         H5Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768314430; x=1768919230;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tfuxnF5eA4o2hoE0e5MjV7YAHQFMCIYI54d1UQv901M=;
        b=XmthbCLHfClS5XfhwdS0pAOvAyvMCVNKRj8ZRjl8D//Fqx4rtb4KfEGfjusf8V5BwG
         L6MJUIaau7tbjRY+Vk8t8+rnQEfw9TRXn9GNGRLHZeUGy8LvfSDFRXAX4EmVKYg7jLod
         bC8+PvhCucpkDoGL5NIIEPCeSfzAe3yM9kbNP2SVu9rwmIMWPDQNaRSzI8jGsXQpK3ED
         lALS2D+xmK7Sdn2TDYokRZWVfayPjJrLmiF1kBxWbBxO0V7BFexQpwvrdxn8hlnVicqM
         A2u9Nw9CUvVXDhEdcDNs0o6T2vmOZoVC0nvMd8OE089NParG1MZ6V7cLMt65f156Z3A4
         a9PA==
X-Forwarded-Encrypted: i=1; AJvYcCWahY9JqMZDxzae99Zdja4vI6XkNdjZMLLWrb41EPExOBESmyursJcqjyeMZGl0GeiaMI/7Ur58RkEh@lists.infradead.org
X-Gm-Message-State: AOJu0YySxzYZtXkT1AkB2oZHQSkLQaAKxf3eFCFxWqw1CLdhMpmeYWQ3
	nWLn7r5n8lFYYODTYHHcVIAtKzMwVhCDEyreI7dhFVtZ2e+/Su1xnssb5tUqkc5GqZo=
X-Gm-Gg: AY/fxX5Hpdf8uegXY3TTa8P2Yfzr+mSrtzmmmxmryQQZIaK+c6eotGfVyTRPXPJwRll
	G3OLvfV6whA1jEWF85ANRYPh2Z0Q5r43C42SYQhPv3diFrMdR4b9vn5eSiQLT1b7Ux3PJAm2a/s
	J4vsFOIMPaurnDwPnmxOq4eSOOrfDw4EQZ+kSNqJM+0TtEmfo8oLkYhnT19go92Trs1gk1ZhRie
	DCrGLfiCStxW7lJvOZMMTrOeoD6HUY/3vAeqRMtQF1GLaV8NaIp9AnOJRP/92x/DUXi0PwypMI/
	zd6Psyn7I5QqDQF7akFxNCo+04Ut4ge9S1cJyF8nZlEPkDzEo6Bsp2ODns/RECcXmp7uXH9GDEL
	rmqMMFpa3snyU+IlyYNKcimu8UxHMa4Aj0INYGvXMiHOJvKHY5CFkqom/Nsq5LM+MFbuJ83l9hN
	aSJ1k=
X-Google-Smtp-Source: AGHT+IE52Ad54mXMSS1JD1lXqFjxduKzd+5RvyclXikoJMz3MbQ2fjeUupBP/ojmRFWD9r8fE9/ChA==
X-Received: by 2002:a05:6820:c086:b0:65c:fd25:f425 with SMTP id 006d021491bc7-65f54f0d8b3mr7635851eaf.34.1768314430421;
        Tue, 13 Jan 2026 06:27:10 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-403fa2058f5sm456126fac.13.2026.01.13.06.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 06:27:09 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Nitesh Shetty <nj.shetty@samsung.com>
Cc: nitheshshetty@gmail.com, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
In-Reply-To: <20260112143810.2046599-1-nj.shetty@samsung.com>
References: <CGME20260112144230epcas5p34403fd2f51e32c77ad4de7bac8c98a18@epcas5p3.samsung.com>
 <20260112143810.2046599-1-nj.shetty@samsung.com>
Subject: Re: [PATCH] block, nvme: remove unused dma_iova_state function
 parameter
Message-Id: <176831442891.313337.6561387582840780672.b4-ty@kernel.dk>
Date: Tue, 13 Jan 2026 07:27:08 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260113_062712_527079_771832F4 
X-CRM114-Status: UNSURE (   6.23  )
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


On Mon, 12 Jan 2026 20:08:08 +0530, Nitesh Shetty wrote:
> DMA IOVA state is not used inside blk_rq_dma_map_iter_next
> 
> 

Applied, thanks!

[1/1] block, nvme: remove unused dma_iova_state function parameter
      commit: 91e1c1bcf0f2376f40ac859cf17d0a64a605e662

Best regards,
-- 
Jens Axboe




