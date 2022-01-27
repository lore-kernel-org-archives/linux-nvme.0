Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4608CC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Jan 2022 13:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S6l5rdsmEt2Qr9ZcyNkghm+7xpa+C/OJTJzZmwQ+fKg=; b=eEgvmo1yjWDSzga1j6TVpourJp
	Vl0lflFuNBK3jaba3gaZVMsUWMQCCQfQ+DPYI0jPFqwYg1SQEb/tkN4rug/VLCBeL0PcrIQkqr6Jl
	HsjmRbf80Rwq1vYVk7BfJtt1S6XtzJkck7KYJlAPRrmNkl5DXzjMgQaO0m1DGZmbeB0I0n2QMr7L2
	vDUVrsc+OXvUlYzM01xQDTz1qG9lbCE65d6fc+TssULjvLn6l+jmYOymnuoWRxU0RuvyL0isH6Urn
	puxk9hO0Tk198ZgFq9L6ZfizqEWtokwQYT2vdPCTEweaB2yNYu/2ZHHnbzDs8ju6/3a5xNfNhvovV
	PuQGLr4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nD4hS-00FsUd-5c; Thu, 27 Jan 2022 13:20:30 +0000
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nD4hP-00FsTK-KA
 for linux-nvme@lists.infradead.org; Thu, 27 Jan 2022 13:20:28 +0000
Received: by mail-wm1-f45.google.com with SMTP id r7so1893635wmq.5
 for <linux-nvme@lists.infradead.org>; Thu, 27 Jan 2022 05:20:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=S6l5rdsmEt2Qr9ZcyNkghm+7xpa+C/OJTJzZmwQ+fKg=;
 b=Tt9xJE36KJt7O289ZAXaSfAF/HdsKi5vKqwpQQf2cDl9cKFIFOKpRnTlXqvLT7ymA3
 iI82kzuLIbEkVn5wsA0WElg8XBKtVYcxyOnag7D6spKULnupyNI4PTt3BIcZgq+BTdUk
 JLGdazAxDNnIOMQ5g6yDhmqx3Bg136byXSkOJxOYB/LuDatbQOZsajJZscnsWZLpRBtn
 81WEq1I/CXXzoTJbFX6uakvj5pK0yH24WpSZBo1S1jtWtmaRizWlks2zwYvJNYT3lf5g
 e4GXxZUUeHnTlE5zYP5MnHyy/c4uuEH/sjzUbUJe2o44eJKwPuvdqNPnh9vU5CgpLrP8
 cbeA==
X-Gm-Message-State: AOAM530XMBInn+NVNglZy4FBFBWayoPahiHxVectAjZETv57IIJDAqn8
 V495R4T3b+vmcekHZUFswm4=
X-Google-Smtp-Source: ABdhPJw3Ysuv/ZnplkK2tSj6Bw7F9Jc259ap4S6utzMFYszZTjJWpc/qVnmx2mAne+4c/bBN1eqSkg==
X-Received: by 2002:a05:600c:4ed0:: with SMTP id
 g16mr3266997wmq.19.1643289625602; 
 Thu, 27 Jan 2022 05:20:25 -0800 (PST)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id l40sm2187427wms.0.2022.01.27.05.20.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jan 2022 05:20:25 -0800 (PST)
Message-ID: <f42dff93-2139-6adf-1163-f2efbad8be20@grimberg.me>
Date: Thu, 27 Jan 2022 15:20:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/4] nvme: add host symbolic name
Content-Language: en-US
To: Martin Belanger <nitram_67@hotmail.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hare@suse.de, axboe@fb.com, hch@lst.de,
 Martin Belanger <martin.belanger@dell.com>
References: <20220125145956.14746-1-nitram_67@hotmail.com>
 <BL0PR13MB429181ED6E81FAC7DDB801E89C5F9@BL0PR13MB4291.namprd13.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <BL0PR13MB429181ED6E81FAC7DDB801E89C5F9@BL0PR13MB4291.namprd13.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220127_052027_699582_598D7D6D 
X-CRM114-Status: UNSURE (   8.71  )
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


> From: Martin Belanger <martin.belanger@dell.com>
> 
> TP8010 introduces the 'host symbolic name' as an optional
> parameter for explicit registration with a central discovery
> controller.
> 

If the other pieces move out, I don't see why the kernel needs
this given that it is not supposed to function as a sysfs kv-store.

