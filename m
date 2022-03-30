Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 660B8C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Mar 2022 12:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=OfFdUHOONKtD0Xko8C9eZS7FXF
	IdijMg6TMfwRCQI5ZiPFi180tkV67x4QgigunvbpY1lU5LeZQ/2ykPRPWKCPMrv/s8WAtD35ZSxoh
	KNOPV2IMuZhkvN8Qbrtn5oDqTEuL3VD6dDSsBmG531QMleC/R37ACbw4ndTQML7p75i/awoKw3nmO
	nQTBlQ00x9fBBhnP8sIrSxjq0Q/JnRFfIYI2KG13Cn4zEhLBdZFVq82uDeOkho8TEVR3OYfPDrBov
	hOVm7g4qHOhhPoVq9B8sWBGQg8ddJ8pz1TuDK4mGowM7uSUP408KeEaUIiB4RtvA3/1ZVb5b0WTEF
	H77myCMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nZXtH-00Fv8j-Gl; Wed, 30 Mar 2022 12:57:35 +0000
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nZXVh-00Fk89-3M
 for linux-nvme@lists.infradead.org; Wed, 30 Mar 2022 12:33:14 +0000
Received: by mail-wr1-f49.google.com with SMTP id j18so29049970wrd.6
 for <linux-nvme@lists.infradead.org>; Wed, 30 Mar 2022 05:33:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=ODV2ei5gxqWQQ2WH1g3g/UwxEWjqH+tNPIoqWkm5Vme5Fn90JB9wfg1sVT59B2xTPA
 ip0yBevxdM6j3S3Q6ow2z8OBc3r5X8v+M16fO8pDhzmj6I9CSH5F7PKsVPJF0zMhL4kJ
 fyT6MuO6fNdEbID27n8Z0vUR0/imB4+ye+BZnG16hGSpRrub3zkSZeXS+ZiJpdBEFM9v
 zuK9aDz5x5k8UdDu3gaTLKIHw71NhJhh+iXJTWTia09gv5lc+8EcbScPqTb2r0ZiYs8v
 /ps6N+QrBsVbtafR6vkt9DpFj1xTNeJ9lviT1Q50WOjXbAzDK6x69oML67+M0HHN9liq
 EC6A==
X-Gm-Message-State: AOAM53130YVMUAg2ftKcloGXn51i7iTpnCjVZP4CjeCS1D6hyWsL3NUu
 Z6isLgY0PsTIyJbc5AY3PfZ72XsU1mI=
X-Google-Smtp-Source: ABdhPJwEs7l5Q02XBclN0KAsSNIAkzc9gr9LJGlZgowzsXfKRLIzRBXHnWq7DFb1EqeL6JJXJTAjVw==
X-Received: by 2002:adf:f4c7:0:b0:203:fb33:332f with SMTP id
 h7-20020adff4c7000000b00203fb33332fmr34980488wrp.280.1648643590045; 
 Wed, 30 Mar 2022 05:33:10 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90]) by smtp.gmail.com with ESMTPSA id
 l19-20020a05600c4f1300b0038cb924c3d7sm5021522wmq.45.2022.03.30.05.33.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Mar 2022 05:33:09 -0700 (PDT)
Message-ID: <61167656-68d3-77ae-fd74-679bcc6ff3d7@grimberg.me>
Date: Wed, 30 Mar 2022 15:33:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] nvmf: dno't duplicate the time out req completion
Content-Language: en-US
To: Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de
References: <20220330094032.23032-1-kch@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220330094032.23032-1-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220330_053313_193170_DE9357FA 
X-CRM114-Status: UNSURE (   6.04  )
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

