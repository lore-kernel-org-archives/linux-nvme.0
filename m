Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CB61C54EBD
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Jan 2023 03:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XQxBkSM5Ol5mlGopd+p5ayDrPcZ/CmK4j6ce1DGQ480=; b=2pPQQz1ziiUGDcGpoYPQlnOSko
	oI3cZ99jfSH2vsTDh/tpZ84vEFmmpHKQ036aAr6VQT4ARSqzc/8aqLfNjNTEoNHwiiw99OFh8S7za
	FElcKOjeH6pIcGhmAJAwkD3iFJywWDz7CNtqh+j7eh0IJgbvovu2CgLECzzwj3DHu9obBSI7zRlUl
	LENjeSzXczco+HgJ3x/4c6YeULBLvsYlM5CIgE0zrcnkh+DTqn1AAkGYT+BmYJlRFS8b/izMaWfeW
	b6mFFBUIeYfR0hc/YOqyiTYrfyK3osURaqYKM9hbLyXqquPC59467vaE12I0W17b1noXlbJRxuldY
	eTU4SGiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pEisY-00H86w-00; Mon, 09 Jan 2023 03:31:18 +0000
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pEisU-00H85h-O8
	for linux-nvme@lists.infradead.org; Mon, 09 Jan 2023 03:31:15 +0000
Received: by mail-pf1-x433.google.com with SMTP id s3so2667024pfd.12
        for <linux-nvme@lists.infradead.org>; Sun, 08 Jan 2023 19:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XQxBkSM5Ol5mlGopd+p5ayDrPcZ/CmK4j6ce1DGQ480=;
        b=f3Cj2m4cGVvpgitPKdAkjnFuKtnGgNXKsfh7+iqGjyfOjkvk5E3vz5ZJAGmN2Ahj+j
         XEz1Hq65MYBYvOFdKGsgQlgqiGpMlDl/wlNDUOVO6OS6ic7XJiAjuwFVMnsNFWUZzIqZ
         L3YeVQDyHvELnklJb0o+Zyo/VfeYvDduXaFJpw7B8ZU3ZgW/LlVjl/Vu1/Xp3NcbYHaz
         VOzgx/ApV4oF83VXRZhNnN45X54hDvDHnKOy99Ks1aN9TweesJLOx6B/Fx0bExywKEc5
         MVcHyMrwJUJUhr1RaveBoHP8FxxXmun3x1nLR97GgYPGHyir/PZ6m0mJAjU2vRVyF47x
         S6wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XQxBkSM5Ol5mlGopd+p5ayDrPcZ/CmK4j6ce1DGQ480=;
        b=uBxgy5Hq/0bg0yhhafgUiF/dMkwRJ/9IXjlAFqrIaxCxSL+ib+JzPNB07FiYyafPM4
         wJSZiNVKnpUz7Eh+A7zqrlsH5znNs+bGY+C5m35rv/aFSV64uHuGkE3V+TrFOBLbeb8o
         JIccZFQ/P2ml4ZXfmRms1CLeTIYwMhxqke0hj7Q/fD9GcBu72DQ05c5odL81oHVQDjVt
         jdgxnt7CgcyWuc6sU6LkwAO1RJQKDRBb897CVD7h1pH5pcndg/fAwXCZpuIp73BaYDZQ
         37v5bZ6otyqau2a0KkuNJbDe0WHYx+uuaozE01KgP61K1WmNg3DhWMQQx1/ewnptn7WH
         gBMw==
X-Gm-Message-State: AFqh2krvOQrOU7Gx4vqDZJXB2GDq+rw0URsfQ5PxdSzIbVa9tnD1bxZF
	2ki/wAgSgBGbUDK8dX6anYkziw==
X-Google-Smtp-Source: AMrXdXuA4VuFWWwCaAC8X0K3A85YU99BNCgRKKk8LXpvxyQR5vMqoiYXgVIFUtm6HDr77S9wrodsdQ==
X-Received: by 2002:a05:6a00:781:b0:57f:d5d1:41d0 with SMTP id g1-20020a056a00078100b0057fd5d141d0mr14424248pfu.3.1673235067067;
        Sun, 08 Jan 2023 19:31:07 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 66-20020a620645000000b0056d98e31439sm5017042pfg.140.2023.01.08.19.31.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Jan 2023 19:31:06 -0800 (PST)
Message-ID: <0fd39164-aa71-62fe-a1f1-eafdc7a79e8c@kernel.dk>
Date: Sun, 8 Jan 2023 20:31:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] nvme: remove nvme_execute_passthru_rq
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, Chaitanya Kulkarni <kch@nvidia.com>
References: <20230108184546.396087-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230108184546.396087-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230108_193114_802251_C3EB814C 
X-CRM114-Status: UNSURE (   7.17  )
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

On 1/8/23 11:45 AM, Christoph Hellwig wrote:
> After moving the nvme_passthru_end call to the callers of
> nvme_execute_passthru_rq, this function has become pointless, so remove
> it.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe



