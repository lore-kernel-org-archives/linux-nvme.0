Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18A4CC4345F
	for <linux-nvme@archiver.kernel.org>; Sun, 21 Apr 2024 11:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=ACUCyPSdK0PaEZOghpxKFDblN/
	TNjf/bMIZzIcqpZObvyVQZUmB5B6wie+hc+lo3fBfYBzESCBvrRsARSAkDX1l2F/48RMWLhQ4nR8u
	M3FfBZXNivdSyF6gz9pQ3xKBJ6BL31N5NtdlmEiGQbPhNLwmbN8xfJ4OO2qLcdr/tqUB1w3gKT9M1
	w+uEwZxQMsl9XBL7cs7WnDjpsPLDthEEyFXeeTB6Z6NKJHhSiC+yfjepLjmR3UyRzbVUympDhOV1p
	8bk35JTlrPKId/4IqmFnmmz+14rw1c9KPe9cIjKq8R56tOyS7kzgkFd8xWLJRq/BDOadssn8Wa2Oc
	dW7LBpNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ryVdd-0000000APEP-4BSR;
	Sun, 21 Apr 2024 11:45:42 +0000
Received: from mail-wr1-f45.google.com ([209.85.221.45])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ryVdZ-0000000APDc-46jj
	for linux-nvme@lists.infradead.org;
	Sun, 21 Apr 2024 11:45:40 +0000
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-346407b8c9aso954776f8f.0
        for <linux-nvme@lists.infradead.org>; Sun, 21 Apr 2024 04:45:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713699934; x=1714304734;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=WroMuYyFEc6YhCuhg2dtrAPOFXVgSpY7U2hN0HYUIpIJSRRexFShAhDYzrpA6r67fr
         EQzknE848QutaoFIXpPTkCAG5ZN2w9GREEHnXsb2pAt60v6n5acQLqDoAnQQtIoKQCFA
         kNNWFhvkUI0RradNBrUqXuKMj1XQhVgXqef9yCnLOvpwn5bRg/Pm38hWQ3EiXRhFORsL
         EomrlBO0fj2K1zHKsOzoLxykmGXwGaSJd6dVi5l4zskZgqxH9gP9PpY+N467tCH5JtNF
         jryo8NBIoz7VbwwxGEa9IWYVeId7V+88N6FETG+62jftCbyDwkDF3pGUuglNUhRUXoYm
         6xew==
X-Forwarded-Encrypted: i=1; AJvYcCWB+2wRKSXES69rBEaV0rwbszs3XTQZvVQ8qi009j+IQyU4IwsmIEkGQFFvxSN8bsWX+1D7G8eKKPzI56Ex52IsHOijqC6kaVaa9s9blrM=
X-Gm-Message-State: AOJu0YzBEpiqAPkvP+TTxDQVn8VvrjNeKxHTdM9kpwax4hW6Rwh6Y6us
	jz90j2al+3sVyaIo68rBPv/TO83GJHdbEPGCu21FcKR/L3WM6/eC
X-Google-Smtp-Source: AGHT+IGKbDQdZLCEdcfv2ITJSmNJdZcmNMkVGtrt/JvZZ5rqfW0ovQOoE1Ke1UTdDiZ3RlrtCg8INg==
X-Received: by 2002:a05:600c:4496:b0:419:db8f:dfa0 with SMTP id e22-20020a05600c449600b00419db8fdfa0mr3094191wmo.0.1713699934100;
        Sun, 21 Apr 2024 04:45:34 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id l23-20020a05600c1d1700b00418f99170f2sm10731705wms.32.2024.04.21.04.45.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Apr 2024 04:45:33 -0700 (PDT)
Message-ID: <f91bd5b3-79c6-46c6-be1d-9256b4755340@grimberg.me>
Date: Sun, 21 Apr 2024 14:45:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v24 04/20] net/tls,core: export get_netdev_for_sock
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: aurelien.aptel@gmail.com, smalin@nvidia.com, malin1024@gmail.com,
 ogerlitz@nvidia.com, yorayz@nvidia.com, borisp@nvidia.com,
 galshalom@nvidia.com, mgurtovoy@nvidia.com, edumazet@google.com,
 pabeni@redhat.com, john.fastabend@gmail.com, daniel@iogearbox.net
References: <20240404123717.11857-1-aaptel@nvidia.com>
 <20240404123717.11857-5-aaptel@nvidia.com>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240404123717.11857-5-aaptel@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240421_044538_204955_CDE622C7 
X-CRM114-Status: UNSURE (   3.70  )
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

