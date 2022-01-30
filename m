Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A81FC433EF
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Jan 2022 09:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=xLr4WbtOJAn22u9w3+DVP4jgbh
	JCNH0bEPcajJjcof8abqEK3Tr7tSS1xyEdcaE+LEpt6M6q/d8Yfykms4a8X6aEwR9qj5+7l02rYHW
	yKLemhmqvbG5UchvfjlG13RDl+xwPpCe+/OsY3axDi3yDxiL96qVchaJ3BJ7DmI33TyXtEqkJdUtk
	KqPLpoJbmLNmOsuE/C4/VH8g9PNdV9LiGTpIxTRExFQSxMWoCdc5RpM+dqJw3M8taFAdSZ1aNCSKy
	g0wGUFuAH0uCYxRig08OhvvLBnoOyQ2VpeY29XNB808ljFzHBMy3tLyPHcSuzETlUPL6N/3K+gtwx
	97AQsQQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nE6lV-006HSv-L7; Sun, 30 Jan 2022 09:44:57 +0000
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nE6lJ-006HQA-FP
 for linux-nvme@lists.infradead.org; Sun, 30 Jan 2022 09:44:46 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 d138-20020a1c1d90000000b0034e043aaac7so8965311wmd.5
 for <linux-nvme@lists.infradead.org>; Sun, 30 Jan 2022 01:44:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=eQEr4MaEHfy9LpynVaeYwQUj2sCZSg5o57oSSagMY9WWZ9zHOqCfnYSMvSvvkUO1h5
 bV4KYnWVDEklCtSM0J3NObEk9LHcQFJdJNdIn0rEOlWlEOnTNxiw7f6dPrAu3j+iqb1V
 0jqblG1vPDWgw9uga3tnORFRigRC2ehzsewHkIw3i3bqvpYVQym8o67zfbmgNEbcIznG
 nlC/s9eYVm/owPs2ljlEio6mBaDiGudN9Q9CgnDBrkRLFyE1Th+ovNSByKBEsODBKq5+
 gd553qHOT3FxwT+HPquODJ/ZO0NC1GIH7LD+JpXBXRx4CoL62yyBDr8GIKJhWaAHuCMF
 50EA==
X-Gm-Message-State: AOAM5332rSBnNpLoq+6vNOqClRo0F7EjPPRmDfi4LGv/Ov94YVVYfLoX
 8n2vLORwwZqJ0gMdPhiGLfo=
X-Google-Smtp-Source: ABdhPJwlgpAJsXGWz/vj8dttEsJa/KHUpjyNGkPe7DTxjL3Bec90wi10gwcXos2cgubvbi5W5lZMSg==
X-Received: by 2002:a1c:3bc3:: with SMTP id i186mr13744203wma.11.1643535884045; 
 Sun, 30 Jan 2022 01:44:44 -0800 (PST)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id v5sm5991960wmh.19.2022.01.30.01.44.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Jan 2022 01:44:43 -0800 (PST)
Message-ID: <eee1f97e-a806-502f-448c-868b1a7a608a@grimberg.me>
Date: Sun, 30 Jan 2022 11:44:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 4/9] nvme-loop: use helper to initialize connect_q
Content-Language: en-US
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org, Chaitanya Kulkarni <kch@nvidia.com>
References: <20220128092015.19289-1-chaitanyak@nvidia.com>
 <20220128092015.19289-5-chaitanyak@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220128092015.19289-5-chaitanyak@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220130_014445_531895_DFCD4397 
X-CRM114-Status: UNSURE (   5.42  )
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

