Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0BAFC4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Dec 2023 13:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3GpY0Sui/xdAtuYAxQCzYA4TDxdQVSm04ypmrZ12oNg=; b=XuUuyNn9rz2Rd2+j4VgkxFV7+A
	EToKLKafiNOLHP4U3IwVEPyDdCsIJJm5W9D1vp1dDwBiubSLhtS/vLunYhD63TVOEtWKQ9KSJTEH4
	d+yGZ/NaKYCXYNceMRs9UYYGima0Bzi4hTxiwWATHkAee2BjrJYMLTYnQwvs94HUy+cPfBcbrC3Dh
	7kWHxKP2dHid7c61dr9XVbZuf0BrNiBxo6Wthp3P8VGRNW3fgqYGIvzCVJeH5apbme9P35rovlgkA
	k779DO6wC2zLNSmPGuFJNJsw7rSdXQIc0RM08gmuJ66NVyVCFrIHxVKs3YS2eWGmjRof9nxPh4Bc0
	pSswjAqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDPIB-00EoA1-1S;
	Wed, 13 Dec 2023 13:28:51 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDPI8-00Eo9C-2n
	for linux-nvme@lists.infradead.org;
	Wed, 13 Dec 2023 13:28:49 +0000
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40c2655da63so10220205e9.1
        for <linux-nvme@lists.infradead.org>; Wed, 13 Dec 2023 05:28:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702474125; x=1703078925;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3GpY0Sui/xdAtuYAxQCzYA4TDxdQVSm04ypmrZ12oNg=;
        b=cQQJ0PMI2PfGbdmzxOahdLxulwLOWljgs7IjX1r9Aw5Na/QNVWaGdb66GbiIj+hQb4
         YEbn/ekcLeAmxtTWXa4ZEQdIYRckL9qYY8SX7XW08pJ8JZl0cwDP3h4hf9EImHADVhJG
         jrknLEY5j0/ErnzBanwpyXITWIqCr/CqutKxWt9JqF7JJJffD87NpyWwnztcanlIiJVB
         taxsljQ42jk1Ael1nIJMEGVCD7VF6dcR/p36njZb6VAc4B+rQI0kIJWkBaRF/skcUvo3
         tJg2FEp6eUTYF6PbzMhBEcOJP4yMGudE4DanSPdqIxL+MA1Z0XmhqXz2eWnmhIe4hP7B
         d9gA==
X-Gm-Message-State: AOJu0YwzpTCiL2oXT37nFvJwOnYk7f7MSB/S2tjj8jMnlHKMruWr9JC8
	7Ipd46tW+m3tTxF99JkjvVo=
X-Google-Smtp-Source: AGHT+IH6lOEW2PUSy+Pz9w6k9x6hHoNgKmh1Z+Gv16j8L0ACg4SEls3uKWjT/rH1rGxO3WlZ2zJP7w==
X-Received: by 2002:a05:600c:1c9d:b0:408:3836:525f with SMTP id k29-20020a05600c1c9d00b004083836525fmr9742267wms.1.1702474124959;
        Wed, 13 Dec 2023 05:28:44 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id bi11-20020a05600c3d8b00b0040c2963e5f3sm20289168wmb.38.2023.12.13.05.28.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 05:28:44 -0800 (PST)
Message-ID: <f50c8a61-7523-4750-b884-cb06bd59fe3e@grimberg.me>
Date: Wed, 13 Dec 2023 15:28:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/6] nvme: refactor ns info setup function
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
References: <20231208105337.23409-1-dwagner@suse.de>
 <20231208105337.23409-4-dwagner@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231208105337.23409-4-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231213_052848_902721_1ABB6DCE 
X-CRM114-Status: UNSURE (   4.75  )
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

Same on the PI comment.

Other than that,
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

