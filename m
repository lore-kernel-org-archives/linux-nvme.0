Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A1BFC7EE23
	for <linux-nvme@archiver.kernel.org>; Tue, 30 May 2023 02:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OvM0y6VNRliRPDVUSeg1QBMWNmNUv7Ud9dd+nfoUaE0=; b=K4aMtYIIj+plyY6O5FnnPx59S5
	BgmYZOeZhNuyyoUGW0S3iWc7ilGGU8UyESaR0UmP26jCPfgE2jjlTYx61+PltdVc8uOdNVia0+o5P
	t4kzsAxOXj2wuLZ1QR+v0KrxGyPXBYfsin6PqUTgugi/d71NGaBKoZ2DgVy6goHABm/i4JJPsvxnd
	ZGpBtRN2kGKZybTRpOf0OZMrsUhK6WVUFhYjvZ8yYU3ACH/ray8Z4sIfj5rRf/ScLl4C/v4injui5
	8nO2IkOU+2/nzzfr/kCI+iQ1hfjDHjWF45CAZS8zj5YVL7NZVmfhbQ9mjn1aDrkD+4TB66I3AI3fr
	bzhUs3ug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q3pQq-00CEjK-1m;
	Tue, 30 May 2023 02:49:56 +0000
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q3pQm-00CEhX-2I;
	Tue, 30 May 2023 02:49:54 +0000
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f3a873476bso4200069e87.1;
        Mon, 29 May 2023 19:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685414987; x=1688006987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OvM0y6VNRliRPDVUSeg1QBMWNmNUv7Ud9dd+nfoUaE0=;
        b=le0n9U0jpxczpwLhNAv68Y5WyqHzPFG3wGDw8gjr4YE57gf+MFqLu3KTSw+f9WtUu8
         7gCG/Tt7xKBtR+tq7O1qPk/TMukJVB/d+SRBNOvVR8Bi4RWk0gdFn5jhmvXaLdJzJQll
         mnXAKnVT4CnR080xsmKIhIDnKQ/reksgrLVqW//TvnrKIufM7vEh0d/HFDB1S2q2zGrr
         CTfGglXERMTtsrmtdbn27K7bFX8zgaLJV5kG0doVdaJt2B7o5ydm0L7K0E5e/mkLZeXQ
         hoxeA/B26ayOz0ZRyxlK4OrYJdnfbM6ZACj+z10HcJ0HGMWU4rUHpWwUUcKcRIUFL6q/
         1z/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685414987; x=1688006987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OvM0y6VNRliRPDVUSeg1QBMWNmNUv7Ud9dd+nfoUaE0=;
        b=WpDUSOyCk0zALDqy33wDwjBjVe6vwu2+3TJt8aNk/4XpJKSH+uHVS7ZPxbJhUZvNUb
         1wQAoKPpv7dqA9wIaqvVYox7z9X7PO431MPU+B1rEOesNAupigAw/Z8ZmhGs+hn7CI+X
         +RQ0oe/DiznDK8Kmx6opA/7LOQEsn/UOJ4MyXIYRzKuEbgfMW/4m+318j0LV0EgUnhsf
         5xqawxburRPT2ftlJJeNcAKgxNAcs5p6gyWYOFZ7q+Px1aG6QeLHpJ3xDE/ART532JNK
         3iynSVKkxlQoNvT90IJd8f5XBgDvUEFOGD9FzlQK8+GBMhM2Sr7a/kOnnEqJdJnw0Xrt
         goXg==
X-Gm-Message-State: AC+VfDzkHuaYlnAXj20YjrsO17ZikId8tdyTfhMaO0yTatSxBR2ELTpf
	ETJqxUUTBJ8zFNJjjvs/fkJ4MjLAVpO2mIoKjQ==
X-Google-Smtp-Source: ACHHUZ739/CeovCvPIhXrs4sB9knbUj4d0Hm3xMKoD6o96twxdpW9VkpLbxZyztTvA5/HFvlFuSiGvEXKZWks+gvsoI=
X-Received: by 2002:ac2:4c09:0:b0:4f3:a51f:54fb with SMTP id
 t9-20020ac24c09000000b004f3a51f54fbmr159241lfq.59.1685414987189; Mon, 29 May
 2023 19:49:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230530024120.17196-1-powen.kao@mediatek.com>
In-Reply-To: <20230530024120.17196-1-powen.kao@mediatek.com>
From: Stanley Chu <chu.stanley@gmail.com>
Date: Tue, 30 May 2023 10:49:35 +0800
Message-ID: <CAGaU9a85dmzuvozHMWj4n93gfwt4Xj1qoYi2oyY_3Tcc+bFg7g@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] nvme: complete directly for hctx with only one ctx mapping
To: Po-Wen Kao <powen.kao@mediatek.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, wsd_upstream@mediatek.com, 
	peter.wang@mediatek.com, stanley.chu@mediatek.com, alice.chao@mediatek.com, 
	naomi.chu@mediatek.com, chun-hung.wu@mediatek.com, cc.chou@mediatek.com, 
	eddie.huang@mediatek.com, Ed Tsai <ed.tsai@mediatek.com>, 
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230529_194952_752804_6B81F92A 
X-CRM114-Status: GOOD (  12.40  )
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

On Tue, May 30, 2023 at 10:45=E2=80=AFAM Po-Wen Kao <powen.kao@mediatek.com=
> wrote:
>
> From: Ed Tsai <ed.tsai@mediatek.com>
>
> Refer to
> commit f168420c62e7
> ("blk-mq: don't redirect completion for hctx withs only one ctx mapping")
> When nvme applies a 1:1 mapping of hctx and ctx, there will be no remote
> request.
>
> But for ufs, the submission and completion queue could be asymmetric.
> (e.g. Multiple SQs share one CQ) Therefore, 1:1 mapping of hctx and
> ctx won't complete request on the submission cpu. In this situation,
> put this condition in block layer could violate the
> QUEUE_FLAG_SAME_FORCE, as a result, move this back to nvme.
>
> Signed-off-by: Ed Tsai <ed.tsai@mediatek.com>
> Signed-off-by: Po-Wen Kao <powen.kao@mediatek.com>

Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>

