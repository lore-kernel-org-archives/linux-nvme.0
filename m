Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80DFFC48BF6
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 11:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=HKaOBMibT0mxRXiRtdNMhg6Nlc
	G/C+GMbjPnnj2Pcs+EzSKdwErZ71hceBixjFtsuJVPN/YZiDITCp+Jb+vuTj+hlEz/rrAPR/f9GCA
	I4TkLThUVxzPdEB7pGydo37MUGSTtcsDE2bzC8fIVkpyjM4YGvAcao6DQkX4u1hRu3YStxBirR9G9
	Bo1VcHlgSJhOy5T+S8CSM2DY162qN2EWfIxKgJ0YVYoyHDZc4B9k4VJs2UpQ0Wi7VhV6zU8eGpM1p
	BB8bPMnEIj6LbZR0Djea29Y8LfsqEOmNRXBrAj6kr2aZzP6B1rWv7XjHJ2ycVwBIPANP9oPiPnqLX
	qqTn3I3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riBtD-00000004IDd-1BqE;
	Thu, 07 Mar 2024 11:26:19 +0000
Received: from mail-wm1-f52.google.com ([209.85.128.52])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riBtA-00000004ID1-1WHa
	for linux-nvme@lists.infradead.org;
	Thu, 07 Mar 2024 11:26:17 +0000
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-412b30be60dso570225e9.0
        for <linux-nvme@lists.infradead.org>; Thu, 07 Mar 2024 03:26:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709810775; x=1710415575;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=g+CggsExYwGxBS06lOqa62NabUJetd5klTZlaN+vnnIxFmnhxDUby8LVxbUnuDqt2G
         sdTiHVlf7i+PDvcIiPVDSQTYQFah6zMuODvvz6ReH30M0zAdQ93CYgpPuTuciDfns8Wl
         yFPbEoGS34wJ2lwvCY/jQcYoakrhee/mXJaaach//eQ3/nDqHBmlmR9qI8ZI5P+vnIZv
         j+kVksA0xBe9m4GjdkFAg786e50aXhZqOwpxh6JUgg0Tp991Fs51PEVvFiIemiIwIMq2
         r5GNQCXVmlpvCTh+VeO1o/tRpD3nFa4tenlG6c1Lwu9iHRAeq8sx/9rHopJwNoP5Wnry
         NnUA==
X-Forwarded-Encrypted: i=1; AJvYcCUG1nsnFQ6gX+3GdUZnXZrOdpZ72qzOvxnBC8OD/N/0fxilljXIkBsnnXXYUfKNUxLA0eUN0dRKID9mjm9MVakdZ6ZJM7ahDvEIuRB4+MU=
X-Gm-Message-State: AOJu0YyrsJdhjQ0wBY3mzWjiNC+J3hw+O2N5X/3ICncvQBcBNrIRG1XB
	aqk2ESbaoGwgErm0ExNKv9npeKITp//iWHrPDqcOA//9XzXowlTn
X-Google-Smtp-Source: AGHT+IFm+7MxOu3fDpLkwzIcqHR9cgT2v8ltFU9iczqXmavVdH66t40nMcjz7U95lrybmjK45xN9Ug==
X-Received: by 2002:a05:600c:1d2a:b0:412:f887:644f with SMTP id l42-20020a05600c1d2a00b00412f887644fmr1205411wms.0.1709810774608;
        Thu, 07 Mar 2024 03:26:14 -0800 (PST)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id fb12-20020a05600c520c00b00412f81ba413sm2355351wmb.11.2024.03.07.03.26.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 03:26:14 -0800 (PST)
Message-ID: <e9fbe206-aac7-470e-9191-1949632e0304@grimberg.me>
Date: Thu, 7 Mar 2024 13:26:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] nvmet-fc: remove unused functions nvmet_fc_iodnum
 and nvmet_fc_fodnum
Content-Language: he-IL, en-US
To: Colin Ian King <colin.i.king@gmail.com>,
 James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240307110158.1981401-1-colin.i.king@gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240307110158.1981401-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_032616_455387_3C69F329 
X-CRM114-Status: UNSURE (   6.38  )
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


