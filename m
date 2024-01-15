Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 097DDC4707B
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Jan 2024 12:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=JAkKewXE9vHXHR+EqiO2FDX6FL
	HHKpabB2njoYePVxyxF+ezEj0YYMkpbRjYe7QuQrJdQj6PRg1iakdau/uMZWzLkf55rVG9SC9FutW
	WjMnwgJA/DhrnnQ0CUoMtvQXwKyRk5ZM24Q6VFeRxRpscdsbCpSgy6jKvoKeIHUDZqhzcQeBpyf19
	cGHjOpg4H2gLaDE0j+3/KWzuJdCvDPdylsTRI/tFq1EYBfOX4xIr1NKIDikxbuwF3+2VmN/jUrQ6s
	KZYAHXeajC7M74YfEIu9+PAv37nVrgrHjuxdCcGtxGwG/iR2kh40hOOxSwbVWOVAkOhUIitX/rFry
	jFsSoLQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rPMUN-008xG2-2T;
	Mon, 15 Jan 2024 12:54:51 +0000
Received: from mail-wm1-f49.google.com ([209.85.128.49])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rPMUK-008xDZ-2t
	for linux-nvme@lists.infradead.org;
	Mon, 15 Jan 2024 12:54:50 +0000
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40e412c1c58so10778005e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 15 Jan 2024 04:54:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705323286; x=1705928086;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=C1wfw8UNbYhjOwDgnq1Ap79GAQRE5qWS+FH3axUrD5WyfUukR/5r4G/QKiqJ6+PkXy
         OW1BflH7UmkeXnZ5NY5PIKsanW5cWqwY1smIki9/s6fsejTmMCzMbcM0+kWqGmVLWQWR
         aqaVYVRHhg2qHMvk8ObhX9H3T3s7M26vpJDAIrbxyjs6S+iJO3spWcbDtBhLqhvNnAMS
         PwLF+ixKfSgWLaEo35JGKrbwcN4FfJV7QYPlJzQa2oMjv2v3NWrSdI4z/hAY9vjVHoDm
         2PuYkwi4/GtCXEG7VKo0/RMhaH5QJv47hGhFjouDHNXjgeLvhDdEeguw+xRqZ0WG2FdE
         gE4g==
X-Gm-Message-State: AOJu0YzYh1BSrGtTpY+ntK44Rg4cmt2zdMHjn6Rdab5+ZK/VIWdo5rQs
	Frb4Hk3IPRtlvA6ooljsAxQ=
X-Google-Smtp-Source: AGHT+IG0Zs9H/sLeQfWHe2nei+ubySI7JYfJWo4TDfWhxYJc0oiPt3vdFjE96GiKjZLVspX98hxVkA==
X-Received: by 2002:a05:600c:510a:b0:40e:550e:4102 with SMTP id o10-20020a05600c510a00b0040e550e4102mr6280469wms.4.1705323285587;
        Mon, 15 Jan 2024 04:54:45 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id t21-20020a05600c451500b0040e3ac9f4c8sm19545682wmo.28.2024.01.15.04.54.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jan 2024 04:54:45 -0800 (PST)
Message-ID: <cee2f54b-1bf4-4db0-a96d-1b5b49613e2c@grimberg.me>
Date: Mon, 15 Jan 2024 14:54:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet-tcp: do not continue for invalid icreq
Content-Language: en-US
To: hare@kernel.org, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
References: <20240112072303.141891-1-hare@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240112072303.141891-1-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240115_045448_937092_EEC6E957 
X-CRM114-Status: UNSURE (   5.36  )
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

