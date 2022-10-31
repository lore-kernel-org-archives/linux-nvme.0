Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50BF3ECAAA1
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Oct 2022 14:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gAc/gKau9T3x5LEXQUx5+0+DwJE6djWWuTXSEpko+2Q=; b=CznF19OPstEG/KufvHaE4+eAZJ
	h4EbF57ZHBSzbn7FG7dbUdupEeW98RlzUhllz/c02ZH2ci6KEORKpbZ8WXaMC0p2Pj3DknMV4ZtA4
	t3SVi57ygoItikx/nX1xj7q8CqZND5zTW/nhhdejHk9ZBf1peRhO2nCbQvJMH4040ZANjEFh9TSiP
	Ad5v0lF9a4dmc13PUmk/jo/+SQoW6VSRY4AelNLhWXaudycUnalCzWUPDfAQ6oyZ0vi8d2khOS22O
	J8S/j07UiFAJZN5b/qoSgYeBvxzB6beeN5OkHdi4ihd8uSd30nbc9RpjL1xzZcbA7sHVX/GQtznlZ
	VEqZAbqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1opW0t-00CKwd-SI; Mon, 31 Oct 2022 14:43:43 +0000
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1opW0o-00CKuL-HC
	for linux-nvme@lists.infradead.org; Mon, 31 Oct 2022 14:43:39 +0000
Received: by mail-ej1-x630.google.com with SMTP id y14so29959151ejd.9
        for <linux-nvme@lists.infradead.org>; Mon, 31 Oct 2022 07:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gAc/gKau9T3x5LEXQUx5+0+DwJE6djWWuTXSEpko+2Q=;
        b=c7l0Y2Z9k/IlihObDcr8TkvkI5yzf4x9nFIg0pIRyLAx+L1scvtsLfwjWIMF7aTa7B
         z2VwvOF9Zc2XKkJfJHbj36VoA6uM2GVz3RYqHlukvVtCIOioDzfz4hwM6V+vZwci+8i/
         +q1+EfR95yexzfUcmetCCaugGQnrVKFiKU1n29w89zZfdE9/jFrd63t4ty9xXWLoH+vE
         zC2RY7mOoxrkNgKbd+zzkom/16AJF9bP3GV/qNT7EsM6D9TdBMKD02/y4yPH2pt6zMfU
         lEd66f5ai/G5BYc0b240SGBFNUkmhCeFQFtT2+KuEJ1nN2BdVUz6jNq18JYFfU9cQLTS
         UlPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gAc/gKau9T3x5LEXQUx5+0+DwJE6djWWuTXSEpko+2Q=;
        b=DcGWihTCwWWFBXPVTTGEkpEmJnJB+0nD1MvZ4Oh5DAEEIbq2PqRgvkWtAmojIujFnb
         inb0xSxisiad3wtYSbETXBq6CQDzRSFwrHg/9W57yQgzYc41ZTQ10mXtigr9r9492zy0
         6tQgVrV/7sh8qU1C+jhNKaN4Fxt0Sg6AS/ed2OLsjzWqHyworYC3aE8+Ybe6u7bJxler
         T4/1txpV/gbbU3X9/MPpz1a0wGCrrnaDRdKyNtDjD4In0SSvJjSJu88gZTAk2DwB3mZo
         nihtnEP+tp/rm643P95oZSswKFuFigCL8zyscTuiCDzxaFK6cmfw4mfmzP0uzMbVLtv+
         5ILg==
X-Gm-Message-State: ACrzQf2NJ7/bxl0uZFjYFxLrhp8ovcZlLyqwGklWrt3eN5kSkwNpVyQ9
	HenitpGBWvr4BG27nUYcZeDJn1JmYV3Xdg==
X-Google-Smtp-Source: AMsMyM58n3ON3Be/rfQU5/eDjZTcxt+4Oxb1++dBbikbOt1vjZ5gEVGrCcx8/bqZ1//U73y7onsWQA==
X-Received: by 2002:a17:907:b14:b0:7ad:c0d5:bdf6 with SMTP id h20-20020a1709070b1400b007adc0d5bdf6mr8492187ejl.222.1667227414166;
        Mon, 31 Oct 2022 07:43:34 -0700 (PDT)
Received: from localhost ([194.62.217.57])
        by smtp.gmail.com with ESMTPSA id u9-20020a1709061da900b0079800b81709sm3049828ejh.219.2022.10.31.07.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 07:43:32 -0700 (PDT)
Date: Mon, 31 Oct 2022 15:43:30 +0100
From: Pankaj Raghav <pankydev8@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH] nvme: implement the DEAC bit for the Write Zeroes command
Message-ID: <20221031144330.zv26u4g4sibzs66n@quentin>
References: <20221030162906.3390-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221030162906.3390-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221031_074338_611713_241468B8 
X-CRM114-Status: GOOD (  12.34  )
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

On Sun, Oct 30, 2022 at 05:29:06PM +0100, Christoph Hellwig wrote:
> While the specification allows devices to either deallocate data
> or to actually write zeroes on any Write Zeroes command, many SSDs
> only do the sensible thing and deallocate data when the DEAC bit
> is specific.  Set it when it is suppored and the caller doesn't
> explicitly opt out of deallocation.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good,
Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>

