Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 276C9C4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Dec 2022 09:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=YusiEZ/BfCQlUUKxkmZffpwM5s
	yPXn1Ut5QtA6WrEMs1l0I+fp/segaDhsqjcudMh89pE02k62b4xizvpobv+WT+JtARXDbP9nxqZaK
	B1xNzeYOHW7FQ3Pjfw1RAnduVvEB0LuKmfgPmHNb6maQ7VLCdZZrhyijXYcQmZsD+ruqfAQXp4YSr
	XlRZGw+Vrc+RkOJkit5K+Y4gb2fDgmzHib4x0ycWkYdqbmIAhGNBvo/NBK7a5w3NSOJyuYxdeZNxe
	krrX1mYSHiZzP3NJzJYOEJFUjcTJnVXxVEQCG+1Wc+7XUr8hWOpuuLZt/VrUKtFy1nkVdme0gnNBw
	wQXuANKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5NgG-00EuWi-Ep; Wed, 14 Dec 2022 09:04:00 +0000
Received: from mail-wm1-f46.google.com ([209.85.128.46])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5NgE-00EuV9-1e
	for linux-nvme@lists.infradead.org; Wed, 14 Dec 2022 09:03:59 +0000
Received: by mail-wm1-f46.google.com with SMTP id m19so10699831wms.5
        for <linux-nvme@lists.infradead.org>; Wed, 14 Dec 2022 01:03:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=Qy10DEyWRGDb5fWPlwWZttVGvZ4kjIC+TB3P+M3SX1aWNUdaFimIq5Og3o/fiB3CRS
         baE/+tqrRAUvrURVJ/wpztG3Ej1bxdE7wAhjeZpXeeUt03ShNyt8gHRDxKKUzvpmzUis
         Xco0LDIkIftpmgPbDtYVqzcsJSxPlahrYf2QZgP9bWFnXLMuHuZtUEiwXVWuOUN2SRyn
         69cjqxUIu0R9jiULIvDnHjj8pTj2BtkEJKlOXoAh6SE4rBLuvDzPf5Qs3wNCWksrFeRF
         FfDvbf3Gi2HDdybyarMYFo9EbvywnLyntw7WmpcFKTbMbkteFdqfDB2KsX25N67+zDnd
         H5vw==
X-Gm-Message-State: ANoB5pnvnOYhAatUJRuYAQl/SqHqzOjJJYE2Gdl+VwAauWS/UJRM00Gi
	5g4UR77sv8hgmC86AL0GwdjECdsjlNs=
X-Google-Smtp-Source: AA0mqf4NdfyAwzWcBopUaRB1UmhjPNHNbHKITkSHsc15QqdZ+CujDzeqxiNDDChyuOMdi4KUUiWslQ==
X-Received: by 2002:a05:600c:1c90:b0:3d2:274d:be7c with SMTP id k16-20020a05600c1c9000b003d2274dbe7cmr7801372wms.19.1671008634498;
        Wed, 14 Dec 2022 01:03:54 -0800 (PST)
Received: from [192.168.64.178] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id m17-20020a05600c3b1100b003c6b7f5567csm7348110wms.0.2022.12.14.01.03.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 01:03:53 -0800 (PST)
Message-ID: <39b64f5e-667d-2611-4bab-2fd7f9171a9c@grimberg.me>
Date: Wed, 14 Dec 2022 11:03:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] nvme-auth: don't use NVMe status codes
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20221213190026.36036-1-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221213190026.36036-1-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221214_010358_117178_C1152015 
X-CRM114-Status: UNSURE (   6.44  )
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

