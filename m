Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95A13C77B75
	for <linux-nvme@archiver.kernel.org>; Wed,  3 May 2023 15:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6S7EwOZMzji0oStPoi09xXU7lTan6QleXidKsr4GbEU=; b=qgmBKx1ZWTVcPQAVlNXSPFsuhl
	f4tCuzEG9OkG6j0s6UnvYi2qE17gAty99kv4UWvAKSz+ghdr2yuJ9SRTwb5TK27FGaoDEaMpotGIt
	ZlarK//U/gTcfU2Bo5pSuB1hXtywOaoqZq4Diu2HyPgOeYwEHHSnJJxkXfGleXHvWXuL4ZocyVog/
	k3OXw2lzkB/XYhvnDpk2ycKOVTTEVIqC4X5fDvL5TGPctv0FJe6rxpw565m55JWz6OahP4q1kJ/+c
	NksiVbzCLuuwethJHhnMh9EY2SL7p19qZBLYQw4ecdas6CedQhS18yr4eGOWA3d4ERgyavnj0cd6N
	Wf/JKayQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1puEfN-0050hI-2j;
	Wed, 03 May 2023 15:45:17 +0000
Received: from mail-il1-x12c.google.com ([2607:f8b0:4864:20::12c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1puEfL-0050gJ-1L
	for linux-nvme@lists.infradead.org;
	Wed, 03 May 2023 15:45:16 +0000
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-32b625939d4so1255665ab.1
        for <linux-nvme@lists.infradead.org>; Wed, 03 May 2023 08:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1683128713; x=1685720713;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6S7EwOZMzji0oStPoi09xXU7lTan6QleXidKsr4GbEU=;
        b=H3AX32DWmpWWbwKj16RmofIpPAFWhv8e+XN2d/1+1MKKsWSAycm2YLW81uv157BlqJ
         tyk+9vlrIoEuRZdJgOCZMhOaOEaN1g5IUYbfVqvwdlUpCZc3AHK0+BB8RokATg2dngq+
         ynHICP1s3QlNQy2AMise4ScEyqRAz4TL9NkNz9fHyhDE0x/I0Grvdumk27ePNQ/fYK18
         8moiFTxTWrEKszRYoYG7h2LfERnp/xHNsBdhZHyAp1lRv81MoIIJijPWk3ViT6BZJw5S
         TCNDZduu3nkfEueaRKj/ev/qvHBmJ1+rjDEdZoN3Gg8r+w86z27Qn9HSYaJcPpSJPINW
         HDow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683128713; x=1685720713;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6S7EwOZMzji0oStPoi09xXU7lTan6QleXidKsr4GbEU=;
        b=axlwGfWpFiyr9vbG6//0tfGU+xpnlbs1IUSrnf0bn+itnKVhkYa4Ylyzv/LkfPj/ht
         /77+2NPz5ngqW+KiGMZzayvPvyY0j/IBPf7tPopNtRLJQD8phVZuMnAgLVyTC80zaota
         rC9k8vF5nByjg1ImsK4b9bCB6k85CFQGIUtR+CeG58vp2tDgBUDaKcgASqZ+WrJurm7H
         ayn9f1lTtiGa5I7FqnqMhk6N9I0oapkXFYX5klzHz8ns1BrAUFPVoHA8aBB4udTBNxML
         mZAk6qHv46x1mNPpzxdTU+ymLWrVepkPe0olbJf7Gn2za7HUEJ1Jj/uyPh3v2YJAuhFL
         uGEQ==
X-Gm-Message-State: AC+VfDznriPiKxmcLl6Tqclzwg58ziUV17DczJMwqaYNcyDe7gNseRfw
	ZcA9fahkhlrq7WavMfsJhKDEwA==
X-Google-Smtp-Source: ACHHUZ7jS47hYCyyTM8oiqv/Kx1au+YhYDjuyucfNtLBKdQabdtWIBX5cWh4rhdqga3x7WKsDwQdXg==
X-Received: by 2002:a92:7402:0:b0:330:a1eb:c5a4 with SMTP id p2-20020a927402000000b00330a1ebc5a4mr4057590ilc.1.1683128713535;
        Wed, 03 May 2023 08:45:13 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id w29-20020a056638379d00b00411bc1340c0sm7356319jal.8.2023.05.03.08.45.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 08:45:12 -0700 (PDT)
Message-ID: <b9688be8-fd92-99df-7083-c8a695e77377@kernel.dk>
Date: Wed, 3 May 2023 09:45:12 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] nvmet: dynamically allocate nvmet_ns->nguid
Content-Language: en-US
To: Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me
References: <20230502053051.14621-1-kch@nvidia.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230502053051.14621-1-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230503_084515_455766_E1C1BDA6 
X-CRM114-Status: GOOD (  18.65  )
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

On 5/1/23 11:30?PM, Chaitanya Kulkarni wrote:
> The nvmet_ns struct is critical to I/O operations in each backend bdev
> and file, but its static nguid array is not accessed in the fast path.
> This means that pulling all the memory for the array on each access
> is inefficient.
> 
> This patch dynamically allocates the nvmet_ns->nguid array, reducing the
> size of the nvmet_ns struct. This optimization should reduce unnecessary
> memory access in the fast path that is required for the array vs pointer.
> For allocation of nguid with kzalloc() use same policy GFP_KERNEL that is
> used to allocate nvmet_ns struct iself.

Replacing 16 bytes of embedded memory with 8 bytes and then alloc+free
seems like a poor tradeoff.

Why not just arrange it a bit more sanely, and also push the config
stuff out-of-line as that would not be used in the fast path. The below
30 second job takes it from 456 -> 440 bytes for me, and has a better
layout imho.
 

diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index dc60a22646f7..790d7513e442 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -61,29 +61,31 @@ struct nvmet_ns {
 	struct block_device	*bdev;
 	struct file		*file;
 	bool			readonly;
+	bool			buffered_io;
+	bool			enabled;
+	u8			csi;
 	u32			nsid;
 	u32			blksize_shift;
+	u32			anagrpid;
 	loff_t			size;
 	u8			nguid[16];
 	uuid_t			uuid;
-	u32			anagrpid;
 
-	bool			buffered_io;
-	bool			enabled;
 	struct nvmet_subsys	*subsys;
 	const char		*device_path;
 
-	struct config_group	device_group;
-	struct config_group	group;
-
 	struct completion	disable_done;
 	mempool_t		*bvec_pool;
 
-	int			use_p2pmem;
 	struct pci_dev		*p2p_dev;
+	int			use_p2pmem;
 	int			pi_type;
 	int			metadata_size;
-	u8			csi;
+
+	struct config_group	device_group;
+	struct config_group	group;
+
+
 };
 
 static inline struct nvmet_ns *to_nvmet_ns(struct config_item *item)

-- 
Jens Axboe


