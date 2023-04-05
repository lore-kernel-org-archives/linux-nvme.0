Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4B49C77B6C
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Apr 2023 22:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X1kuOrA9nJYbPatnoXtCGcO+4VHfvGpXiE2TjfUJZWw=; b=0clfJ4mIulU6q9C40+SFY0MAA2
	o1fczIKTiqaTovh6McvQHiZmK9MmrKvsjG2CwKAL+pPI1H3/yoXFgMalMr9GGFmMM9QrinLZ4BkD6
	6OBW8JxfQRPio8RM/dFwxwwge2bVSigYk838gNLc9T6i+5isQrEr/BUllI0uJudzQSiJovkA40wmD
	CfeBHfEDTgbZzh5w9L/lJF+btQD22KHF9TfBdvA+uib1LJm5vRSsZQXFxgGCWHP3waPk9KjF6np+d
	jpW/FY2eHMwi/rpCsEHfxeOeP7jd2W8kNI56eG0REVkeG6hFFeb6ukRXgy6M4Pm1IvFTfrsw5Z02R
	EuZmy6AA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pkBaq-005qj7-1r;
	Wed, 05 Apr 2023 22:27:04 +0000
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pkBam-005qif-1V
	for linux-nvme@lists.infradead.org;
	Wed, 05 Apr 2023 22:27:01 +0000
Received: by mail-pj1-x1032.google.com with SMTP id x15so35479037pjk.2
        for <linux-nvme@lists.infradead.org>; Wed, 05 Apr 2023 15:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680733616;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X1kuOrA9nJYbPatnoXtCGcO+4VHfvGpXiE2TjfUJZWw=;
        b=k993ki3T4DvPZ5JiNqBlwqGS9DZQAgrfBoJqj8wbHPQ0CGaJYKpU0eVc1OTRaBTIva
         Crj6YHHbHx2H8UQMLGemwMVKOFchxXmQSISj4o8yEbA+mqfd3LT3FIRYvjUT3ml6k3dw
         ObPzZgsp4DrYCtOaolcE5zHp1c9wDAL5najDIiT+Kc8XXj/bm3eUIXFTyx+EnW6MEhPE
         MW0wvigGxyOW17VEs1mYfYeEeivupBWjfO03A9w/y0CPPz281UOUPI9F0Fvr1YeuHZ98
         pWC7f8nRqMydxFArUfT56Iqgo+1smwi4q6FEvaYDecsST9tUbT2vF90yYlkrh9+ziRL4
         Jhxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680733616;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X1kuOrA9nJYbPatnoXtCGcO+4VHfvGpXiE2TjfUJZWw=;
        b=5vxOYCBD7CJRoSRVH9LzWW9qSq2+p9NcQ66P41v3d+P+az4B18A/dfyfuzbrEH66v3
         HTPte/8BQPDKhFENuxgDO2Ydhw8rs7qZlm2ryLOhdJ8nf7ir5/TAr+4a8RwHX+G2NI4T
         NaIlOSFQ1nQlNAFHvV4AaByDnocKMg0+o3YQEeSPdMPrEYpjLlpHzrXFKuscrtwtKyGW
         UAHJIt18raDs5vOaSYaj7aygUlHiS1T8Tz2rIfiCe/HxseL/ZJW4VYG9RtlHT+RVcu/c
         6aD2/4IucORzLLVLzzxcWx+KHYbfvRQiYnkSQDpd/YbirhDctDxpH3sF5U1vEDAEdWXZ
         dTgA==
X-Gm-Message-State: AAQBX9eUKm/p7dvD89vbLwvQId0BUVPspbIKM19YMWG2nVyaVLko3MGs
	PVefbCGZM8/7CD9lVl8xj6UZNZ0JlWw=
X-Google-Smtp-Source: AKy350Y4KS8Lj1DCLgHvhSv36gdUbizRUNvqfq98wMqB1YV76U37HLgnsHIMc1zMd5secEwaGC93WQ==
X-Received: by 2002:a17:902:da81:b0:1a2:8c7e:f301 with SMTP id j1-20020a170902da8100b001a28c7ef301mr9614120plx.45.1680733616189;
        Wed, 05 Apr 2023 15:26:56 -0700 (PDT)
Received: from ?IPv6:::1? ([2001:2d8:6c2d:921:1df1:3eae:1225:38a])
        by smtp.gmail.com with ESMTPSA id i2-20020a170902cf0200b0019edc1b421asm21307plg.163.2023.04.05.15.26.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 15:26:55 -0700 (PDT)
Date: Thu, 06 Apr 2023 07:26:48 +0900
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: linux-nvme@lists.infradead.org, Keith Busch <kbusch@meta.com>, hch@lst.de
CC: sagi@grimberg.me, Keith Busch <kbusch@kernel.org>,
 Nate Thornton <nate.thornton@samsung.com>,
 Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH] nvme: fix async event trace event
In-Reply-To: <20230405215720.2872579-1-kbusch@meta.com>
References: <20230405215720.2872579-1-kbusch@meta.com>
Message-ID: <7F0EC037-E952-4CA4-B1AA-FC0E0E87C1AB@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230405_152700_524591_B6198B9C 
X-CRM114-Status: UNSURE (   6.17  )
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

On April 6, 2023 6:57:20 AM GMT+09:00, Keith Busch <kbusch@meta=2Ecom> wrot=
e:
> From: Keith Busch <kbusch@kernel=2Eorg>
>=20
> Mixing AER Event Type and Event Info has masking clashes=2E Just print t=
he
> event type, but also include the event info of the AER result in the
> trace=2E
>=20
> Fixes: 09bd1ff4b15143b ("nvme-core: add async event trace helper")
> Reported-by: Nate Thornton <nate=2Ethornton@samsung=2Ecom>
> Cc: Chaitanya Kulkarni <kch@nvidia=2Ecom>
> Signed-off-by: Keith Busch <kbusch@kernel=2Eorg>


Reviewed-by: Minwoo Im <minwoo=2Eim@samsung=2Ecom>

