Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C433C3DA5D
	for <linux-nvme@archiver.kernel.org>; Sun, 21 Jul 2024 11:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=zHdULI5Z+RcOuafiURYwJLmT7Y
	ZlVFu42u2LIh0NEY2oLACQ9W8uA5QKFA0HdEjSG5eiTN9RyppH0dzPK54zIa6Jz+oFlT8W1KOFnjM
	+3u5scgNwlYrVjXSbNhEG5mY5QdFk/Rw4mp+5JOkFVsd3gY94z7Nx/jLQeiiQPArPuLYyYQ/Nsfmo
	29fzrUh4uYPWCZV5Ry3b+waQa6HVo33jBrbKtAlIIL1AjlyX2CFvKSnY47u6OnUqyVzIA81SKlZBU
	5zfE1ol9HB6/cpXbQodmyd1FmCjhT5cwMoFwrVOZfehIpl09X2+SYIYCdhGYUpTR8P99WSyIH86kS
	LwEum2MA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVUXz-00000006hyx-3Baj;
	Sun, 21 Jul 2024 11:16:11 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVUXw-00000006hy1-11iF
	for linux-nvme@lists.infradead.org;
	Sun, 21 Jul 2024 11:16:09 +0000
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-36874d7f70bso290650f8f.1
        for <linux-nvme@lists.infradead.org>; Sun, 21 Jul 2024 04:16:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721560566; x=1722165366;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=omT+XHxNxwiKOsxrOyLJfHvYwnXwddFbuiYZMOhjHLZa9kxhZOPY6zO97dOi02thVa
         x9DSLrfEpIZc5FqTdvC0djJ4ZIDBth1RH5LoOpcT7pP08njG7nupG5P7fokxPuwMGkAX
         Li7l1rlHCNozqyxCA8P+zFsXFrT2lFVlkaRspyHXCqX6Eh/+f5tpXg4++Ij+Uecr3l1m
         Z5uvtEAzKOpNUWC1MhDIuMPl+mVxZzWMCN/avtIg3AvJ1lJ54KkJr2xyttD3+wI46lGf
         rWrtYenk8XVvaVCQFTcfI0LcYlANBgXtQaTGtHGGCMqlWb9PHSiU+pgtYApzobKlNWaG
         3rnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBpASAVJNDjlsEtv6UCOtvxgErg6ql73bwbi345aowN4tSoNtFs6//EKlIYD/qOTEUvBgxSMDL8ByywDX7h68NM0xWRd0FOW1NYbR6EVI=
X-Gm-Message-State: AOJu0YyCzaDph6Laph403fQpAqaMxiLV9PLPGU7vz+T2XZMRh2M4rhQ1
	R7ykYaa3J6SQ4oj9dFWUqc7NTJhuvG57NM3dGvQGvv7HRbkpRSl9b/CARQ==
X-Google-Smtp-Source: AGHT+IHB4iiRaF+Kjkm5HatqDMBIbzrpagGd2f6amEgpj51ugfUmxTAEqbZ+bpbZDKFTxTmFuLLgjQ==
X-Received: by 2002:a05:6000:1844:b0:368:4e31:7735 with SMTP id ffacd0b85a97d-369b69c6f6amr1889998f8f.9.1721560566314;
        Sun, 21 Jul 2024 04:16:06 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-368787ced86sm5724465f8f.68.2024.07.21.04.16.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jul 2024 04:16:05 -0700 (PDT)
Message-ID: <05cc2ba9-5b6a-416f-9ad5-e4f3550628d9@grimberg.me>
Date: Sun, 21 Jul 2024 14:16:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] nvme-sysfs: add 'tls_configured_key' sysfs attribute
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240719083901.35399-1-hare@kernel.org>
 <20240719083901.35399-7-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240719083901.35399-7-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240721_041608_287320_AF6DB007 
X-CRM114-Status: UNSURE (   4.87  )
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

