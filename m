Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82F49C433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Oct 2022 13:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2thhFCzMEWIWrj4xKNCjW7Ij35cNo2Mk5pOcDChl1FI=; b=16wifEdnayiaCfCIGlIvIvQ4VY
	0PFjrPQxnkOu0XAvcrrtJ+0QSBgd+7p7vLbcTSy3Jmfj+GtzfoA9VEmahB1tVD/mgAYFFgFj3aPLt
	z/YdIOUGPJIR/jUayt3/qp0Tt09+503VMuLAS8eKlkCzLJAvRQEZDmEeFfPL0TQposAtnW/heClqE
	REwdzpX2w1B9Y5MXNQko7repb8ghWdkum0F2t4pzv7Uw7+jSG3Lspybm+JrIx/pBiQtnw46gC55wd
	6YyUhRS2s5EZPi+MpFXpzIJW/rllHMKjhSMoGZCf6Koq3T2ONPJBFJWcJgXky7Vc1YdCgLo87LaE+
	sbz7P/vg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ong4b-009Md7-1t; Wed, 26 Oct 2022 13:03:57 +0000
Received: from mail-wr1-f47.google.com ([209.85.221.47])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ong4X-009McA-Mp
	for linux-nvme@lists.infradead.org; Wed, 26 Oct 2022 13:03:55 +0000
Received: by mail-wr1-f47.google.com with SMTP id w14so1935446wru.8
        for <linux-nvme@lists.infradead.org>; Wed, 26 Oct 2022 06:03:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2thhFCzMEWIWrj4xKNCjW7Ij35cNo2Mk5pOcDChl1FI=;
        b=iRHQf8XncHgRSlBve/NrRzy8SpJVhK02DoR+dNPiK45L3Kt8QK43KZgGNZu4Mkt47p
         5fs/hi957DNTN/5hQ8Il0yq23Igcvl5cTN90XDelq7W7oSgDwRWFlig0cpmcCq4kZcLI
         F0NN+li0niQcPYhC3Bo2Owpk1c0C5Ot7jHKaYI8RxG3MGeZyuFnCZ6TzcbbHFD0Adl3G
         LmOEu5XIBwz3Gw5pX4DvDfmpS+FsE80f2owRtZ+aNn1azTU1evYBIfkt9a4RRLzuKn6s
         xODP0EeTcqq/t2v7e0m+hu/TMHsJqX4/zlpUfmDhHvqhufQuI8VvaDg+TustsKUwjhOV
         qs1g==
X-Gm-Message-State: ACrzQf2fXdnp7b9MTHZAkQNu3r9wL3zR5Px7BzQR9UcJpHqvO031NZpQ
	qVoKklj3k+hob2cUGriPkJWXuVYVb+s=
X-Google-Smtp-Source: AMsMyM6teqXthzPYDw0Ww80AFPEwxUpOtkuWdveVt3JxZ93AOyVPVO5lVF+5a06eAvB4OJ/nTfxFBg==
X-Received: by 2002:a05:6000:24f:b0:236:76e8:33fd with SMTP id m15-20020a056000024f00b0023676e833fdmr9255292wrz.215.1666789410424;
        Wed, 26 Oct 2022 06:03:30 -0700 (PDT)
Received: from [192.168.64.94] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id ba21-20020a0560001c1500b002238ea5750csm6793449wrb.72.2022.10.26.06.03.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 06:03:28 -0700 (PDT)
Message-ID: <bc8a1130-3688-6bc5-067e-56a8d935f331@grimberg.me>
Date: Wed, 26 Oct 2022 16:03:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 17/17] nvme: use blk_mq_[un]quiesce_tagset
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Chao Leng <lengchao@huawei.com>
Cc: Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.de>
References: <20221025144020.260458-1-hch@lst.de>
 <20221025144020.260458-18-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221025144020.260458-18-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221026_060353_764395_E2643970 
X-CRM114-Status: UNSURE (   6.58  )
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

Looks great,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

