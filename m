Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEE3CC54E58
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Mar 2024 07:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=wZf/TftqrjD7ArXL84km8bnBpX
	1/ERSEwd+RiOMCQsjBXuCZ9ZBAcy1SlIc/1D/gMVHzj0ofWs0pG5XV+FaHlAcM2CPQK/9i65Gtz/u
	giyDTIHFoPxnoa2yxLSwps3kpsot1ssr59/YuxINlww66Au1DDmjHgrdD1SV529weulChODlumh6r
	K2htVRBSEqwTx6fzYY9k4IZt3m8Q/wv8IPKocg/e7s3UPrYdKA6k6y+eCb5ZKzKN+FrREpUajD5ev
	LYbnffvDAa+JUos0SISdorlibQxuNcLAxhpvjXpMYBSzy0wErwIEXxWnu4MnxuqqIxx7wjeM0nM49
	OGe/D4FQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkJK2-00000009Emx-2j1M;
	Wed, 13 Mar 2024 07:46:46 +0000
Received: from mail-wr1-f54.google.com ([209.85.221.54])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkJJy-00000009Eku-0Xm0
	for linux-nvme@lists.infradead.org;
	Wed, 13 Mar 2024 07:46:44 +0000
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33e972c8b67so676458f8f.1
        for <linux-nvme@lists.infradead.org>; Wed, 13 Mar 2024 00:46:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710315994; x=1710920794;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=nfXAZzDjit1qg3pGmnf+stLnC/XxInhYt++wtDteqataEVVUdQC7ULHscxoBNjprrQ
         1FBTA5Ub47apCAnTzX2BTCyuB/1UuNzYsmJXrENPd1OVCuEHPxZ1DxDeMxSxojHFLWeK
         VrZJOr3n7boQmR4waZzBdp4uIaZoShUbG1b2In6vzZ1/uJ4C6H399g15lJXhlA1PSksb
         zfTHVc9cZMgeReOCpRlQGpjFVP0n+gkZgHXoXy797eK8luQhxlg/EkQLEaxMqryGswDi
         iUauY/HGfoWWEGxaqxi+UgufhxNTiYN5Bz25egVkmypb60lBllc6eOVL4CozB3hAGi8D
         MJpQ==
X-Gm-Message-State: AOJu0YwGgBR8uwmfurtZ0B1wP1lP+wy8PsWlsD9KNhKUV9c5rDKAKrH+
	vrEoiu36xWlZN2wdQacYjErxdmPNbel4MwX1LgR8b1Uftee6/+cGLqVlC7no
X-Google-Smtp-Source: AGHT+IEaxZYGH3id7iL9uE7tVMPOw9cu3mtIX3H2vcISXaFi7UzJUWs4uK6eDHxemY78wdVfOPTVXg==
X-Received: by 2002:a5d:62d0:0:b0:33e:142f:7cb6 with SMTP id o16-20020a5d62d0000000b0033e142f7cb6mr7481648wrv.0.1710315994413;
        Wed, 13 Mar 2024 00:46:34 -0700 (PDT)
Received: from [10.50.4.153] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id p12-20020adf9d8c000000b0033cf60e268fsm10985839wre.116.2024.03.13.00.46.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 00:46:34 -0700 (PDT)
Message-ID: <b8495076-4df6-43d2-b162-81ac4c70e383@grimberg.me>
Date: Wed, 13 Mar 2024 09:46:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme: use nvme_disk_is_ns_head helper
Content-Language: he-IL, en-US
To: Guixin Liu <kanie@linux.alibaba.com>, kbusch@kernel.org, axboe@kernel.dk,
 hch@lst.de
Cc: linux-nvme@lists.infradead.org
References: <20240313022905.104092-1-kanie@linux.alibaba.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240313022905.104092-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240313_004642_276301_E0E3482B 
X-CRM114-Status: UNSURE (   4.54  )
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

