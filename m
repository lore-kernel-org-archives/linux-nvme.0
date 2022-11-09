Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02100C433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Nov 2022 02:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DnSSI7Sa3yUVrWuYkjhNclnSAE5oHS/sxjCr/Bz2Dqw=; b=k280mvRNNSA++z3Kj/Lw2tMSOW
	zWu+bdRyXamv+mKIWMbKoB8Ha17HO5LOldtBIjsfynJ/d+aAwuNohmVfVeFP17Tz8FrXR6e0hnD18
	nhy/m4k51I17x5ANYsXlsORiX4BuzE0xhKNyPx0hYUeS0ESBuVxFD2shDWCv01TJlIttHxFi22Whv
	MhsJx0oUYjb49Z5wpM8Jw9FyHvjpntZJCr+Kvqg005ysH0lsj/TdpGd4WLwSfxEZXengqGVqxPhI+
	HlonY2k9qbRwnfCSTPJj5EXcEBd1/hAcYcZJi30b/oEWdlLMGRO//KH3hCP8SWxjJ0m3k/t4PcIdw
	u5aF+oNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osbGI-00A73h-Vo; Wed, 09 Nov 2022 02:56:22 +0000
Received: from mail-pj1-f45.google.com ([209.85.216.45])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osbFz-00A6yq-1G; Wed, 09 Nov 2022 02:56:04 +0000
Received: by mail-pj1-f45.google.com with SMTP id d13-20020a17090a3b0d00b00213519dfe4aso654747pjc.2;
        Tue, 08 Nov 2022 18:56:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DnSSI7Sa3yUVrWuYkjhNclnSAE5oHS/sxjCr/Bz2Dqw=;
        b=Zp8flpN2SO1C9wZPEJCGfXzk/Ey5mR7zFW5rZrYdMGPfMmLsfJiSZbURkR/OY7rfjG
         NCSrvCBK7clO4l80z9ogaXYcMt+EU5QZwpxy60OlTOMTngSxKk+s7+oRUfvNRZTWuJjy
         XB/iWJZQ3R9qk4u6Amp0D0jWN+tITV1sRQert8V8Qihn2PA9d8kivxBvW4al0/6c0gQL
         RcXkdFReYMLa+FHIB0vlFBldQb8/+W3TJIvmghV+MnSRAkvtlSTgvaIO5D/bEx30j6/W
         btsdCsmQjQrw6ec6c4SMWJu9U7YE9IqkOcIi666SqpsXuZ5t05qZIG2NV1DIQxp/U8Ji
         aeGA==
X-Gm-Message-State: ACrzQf3vfsypNbbeq0f/2QPH2PyWoKRXBzvSg3ZSCqI7F5Hy/vqhVItH
	+fuzZ1lx1V/2hUaxOoW9wY8=
X-Google-Smtp-Source: AMsMyM4Kox725PyRwAUjMB11xlnqnVStSsW52yU58jE+Nn8jz2ru/uQCLyCjQEBrBlnRtNrtwu9tow==
X-Received: by 2002:a17:902:ccc2:b0:178:29f9:5c5e with SMTP id z2-20020a170902ccc200b0017829f95c5emr56391951ple.21.1667962560904;
        Tue, 08 Nov 2022 18:56:00 -0800 (PST)
Received: from [172.20.3.206] (69-170-33-158.static-ip.telepacific.net. [69.170.33.158])
        by smtp.gmail.com with ESMTPSA id i4-20020a63cd04000000b0045751ef6423sm6484001pgg.87.2022.11.08.18.55.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 18:56:00 -0800 (PST)
Message-ID: <b469706e-19a6-1e34-0f2b-9a84eb473087@grimberg.me>
Date: Wed, 9 Nov 2022 04:55:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 02/12] nvme: move OPAL setup from PCIe to core
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, Gerd Bayer <gbayer@linux.ibm.com>,
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-nvme@lists.infradead.org
References: <20221108150252.2123727-1-hch@lst.de>
 <20221108150252.2123727-3-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221108150252.2123727-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221108_185603_100787_B7EB5D60 
X-CRM114-Status: UNSURE (   6.16  )
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

Nice

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

