Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02C5BC30653
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jun 2024 08:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=2tVg1sBZKPRR4EJAz+lRrM7chu
	K3PP4WuBYEjbjz7+aNJcx88hUnptUuvo1r5mJMxAMR7eN9/4dBP5znVo1mJEK+Z5qg+QtSC98KL0X
	vdbOuOKz28GBKEkA7TEz4FTaDzcU5Reo68S3cIJLOGvljcnqq6RheHWpPf07i6HIoM8d1M5wVE1xu
	d36QTwrOxIPJJrC79npQwd6QECDINpM+uvM/fMIgPAf3BGBmox7UVXGrHYLEomQjA7IgFSmdj8e/l
	GYEp9Sw6kjbULn/6097dofV34m9YIUk6lmvMeiCHcuBCw2/0oePViNS/Ut/dffjUxMxkX0Pp9Tqg9
	W+0nk94g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMNxd-00000005ufm-3Q8Z;
	Wed, 26 Jun 2024 08:25:01 +0000
Received: from mail-wm1-f49.google.com ([209.85.128.49])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMNxZ-00000005ucJ-2TSl
	for linux-nvme@lists.infradead.org;
	Wed, 26 Jun 2024 08:24:59 +0000
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-424a5d998eeso1538305e9.3
        for <linux-nvme@lists.infradead.org>; Wed, 26 Jun 2024 01:24:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719390296; x=1719995096;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=KEJaqvAbgr9YMVXbMcVy4Pa/s6azbwtQOKbPp/U6JN+NDcYlLUpAUEL7Obp6PzWu0s
         nucZyyykEqPGqZke0nqJiim/ITBgpdLsOvj06pe9nmDFZgw9N8E/xN1ROgIlpnDwiQrh
         P0THLlhx+1bAkI3rHP2KjgNHF1Rpvswoo+aoAZRmrDKdp7KrPY6aHNSiU5P0sC8jOmYk
         DwvYQg5cWulwFRH/D0XDnGHNQCM35wxBRzjqZ0La99glvsmegdj3RZ4bnfryALA9b7q5
         LEBX5K62BEN2xv2sFTiucvh+w0DG5a4m+2fNLssKjyihHCh7FLdWt04XTg+7OIufL1aK
         fmag==
X-Forwarded-Encrypted: i=1; AJvYcCVTY9xEzWw8M+CNx73mDpuIshHDlNdjlclXmiLNU1npmpRFKvUf2FvUYUwG3GsU0szIJad0gocXpj59R+L2gamOHpq0I3GeuKImW+gQ2AE=
X-Gm-Message-State: AOJu0Yw1uxtdg0ucEyz4LLkMj9n7iFvzrJwj8ENAUOb7NSUle5jiFOjx
	XXSk8qVNFeSgYRcpC+fPytbeVs091iJO6zzFDMQKVcc7ZLbHlS4K
X-Google-Smtp-Source: AGHT+IHDhPqxDyJDdoC2Tr1g08Bgg9sN3qjAyL9IN9hBwLgOx+rBH6K20JA3UwXq2vFSI1hlp2tx3A==
X-Received: by 2002:a05:600c:1c0f:b0:424:a74b:32d3 with SMTP id 5b1f17b1804b1-424a74b3420mr22915425e9.0.1719390295767;
        Wed, 26 Jun 2024 01:24:55 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424c82519bdsm16406265e9.13.2024.06.26.01.24.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 01:24:55 -0700 (PDT)
Message-ID: <65075b49-48e9-4ad1-91d3-b4334009cb13@grimberg.me>
Date: Wed, 26 Jun 2024 11:24:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] nvme-fc: go straight to connecting state when
 initializing
To: Daniel Wagner <dwagner@suse.de>, James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
References: <20240611190647.11856-1-dwagner@suse.de>
 <20240611190647.11856-2-dwagner@suse.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240611190647.11856-2-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240626_012457_648380_C48214D2 
X-CRM114-Status: UNSURE (   5.29  )
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


