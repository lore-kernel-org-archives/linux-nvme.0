Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F6BC4708C
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Dec 2022 12:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=IYcqkOKnZWDlgMP8Qw33m67HnG
	8wjattv9HCWIN6VT61yqb1EXAt65zubxWjkCgkHXwRZqi2+pMJY+8Aw6wvDvWMRt+ATgYjd0N7LmG
	32Gr6RL+HaC3yOIITifzffsAMacGZdGVwY0N2Xn583IViOcQ2i+qjMACwpFGFjrz8OcaCuiOBHudY
	5WAS9shztdk4dX5ckc+ig/6tvn7dcKFND80FhflbyloaNmmPaWZI4a59xt21RkqNMhd7qxjgcq5g7
	JiHuqGR9y2w142DTchshzz2uyXdi4rhRjb08OvPeInzHYXpY1tM1jCesmsNDtpo+mYtHqJbXtMHsg
	j0ul93Mw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2WxX-0092rf-3X; Tue, 06 Dec 2022 12:22:03 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2WxT-0092o9-Ex
	for linux-nvme@lists.infradead.org; Tue, 06 Dec 2022 12:22:01 +0000
Received: by mail-wm1-f50.google.com with SMTP id bg10so11056489wmb.1
        for <linux-nvme@lists.infradead.org>; Tue, 06 Dec 2022 04:21:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=kYOHLxKoUToo7Ie2MZxJ4DjuMyyG7+u64QmHZfAdPOxBFPd1UJqDBDVUNx709mPIDe
         T4md1HZ89VuTjSkasLX+sdMerQp9Vxo8jubX/yPSnJutW1nKnJ1l5RFaoPozhLEQSfzq
         NG+l2dRgtlWXpfaViMhcRJXRpxQ0Pc4+AyEqkmPW7ZClkwWf6ndQY8MP3tALudyvx8Mc
         4i2a+HTBbn9ilMlXpuNMLWPyScw0ksAz0MzdqU6pSIXiBWhxIacKcLdA2X4ENIrvUln8
         mPFsucKPm9rYPmN3xIyOA8RMP30i7pZIP1yX+3RQpmYJH7ZNecDY6zy80ERVlGiFbXDt
         sijg==
X-Gm-Message-State: ANoB5pn4JHE7nQj14H9lFoVs7BVcRGyAIIT73Q2QKQaR2eEN8fCE4Spk
	mYAt4FZlpTXkedCcChVj64s=
X-Google-Smtp-Source: AA0mqf68e+lFerscgOPTEuwnVJdgBwJ9UgxtDAQqa3B+6CVSqPeb4LFarfB/x6DgnRfbAiczlXhI/A==
X-Received: by 2002:a05:600c:43c5:b0:3d1:eea7:e13d with SMTP id f5-20020a05600c43c500b003d1eea7e13dmr1349437wmn.74.1670329316505;
        Tue, 06 Dec 2022 04:21:56 -0800 (PST)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id bi18-20020a05600c3d9200b003c65c9a36dfsm20497217wmb.48.2022.12.06.04.21.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Dec 2022 04:21:56 -0800 (PST)
Message-ID: <2d8804dd-def8-9599-4b57-4e2c3bb3a1f5@grimberg.me>
Date: Tue, 6 Dec 2022 14:21:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 8/9] nvme-pci: return early on ctrl state mismatch in
 nvme_reset_work
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: James Smart <james.smart@broadcom.com>,
 Chaitanya Kulkarni <kch@nvidia.com>, Hector Martin <marcan@marcan.st>,
 Sven Peter <sven@svenpeter.dev>, asahi@lists.linux.dev,
 linux-nvme@lists.infradead.org
References: <20221129132208.4337-1-hch@lst.de>
 <20221129132208.4337-9-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221129132208.4337-9-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221206_042159_509532_71D2AFA8 
X-CRM114-Status: UNSURE (   7.06  )
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

