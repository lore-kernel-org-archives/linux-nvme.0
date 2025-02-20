Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08AE4C021B3
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Feb 2025 12:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=e1D3QdDDRPmERWQZ5aTB4Pb7ax
	EcM1AsHDr6dXAJzDcAPB3ACyFFvkcFTOK1jhxnYDN+D3UWMTvbddvHFUiRXl5TF2CljaY1icj3An3
	sTijLcFyw/eHWAFSXz0rCXmHzgXKkVJfBEJmH1iP4+b9OL5zGzuwvb1f+1DO5tUM+l7uB1iPe+kep
	IoHC15p+wKcmu+zorCWHPT7wRtrriucjpuGbssWW/YMumcwR3Rox5I8f48tESGhyGztAkuSmT7ljY
	nuCsFZJy6+82g2sm83m05v0B4nY9D9pAM83NG19V1Xo8EoerYG/CXoTBbn93tOT6kX4XwZBKrRJeE
	4cR3IJ7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tl66h-00000000uj4-1lcI;
	Thu, 20 Feb 2025 12:56:47 +0000
Received: from mail-wm1-f45.google.com ([209.85.128.45])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tl5gv-00000000o1K-20F7
	for linux-nvme@lists.infradead.org;
	Thu, 20 Feb 2025 12:30:10 +0000
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-439a2780b44so5342405e9.1
        for <linux-nvme@lists.infradead.org>; Thu, 20 Feb 2025 04:30:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740054608; x=1740659408;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=ONZZw/ukxJq4g+yadh2BT4EgbOHPVfha0r/9WL0sviXU/RdP3hTYiTnkmmK8E+Z7u2
         B3RqNo3gZ1R5EjSNWKGyDPn2mgHmTUJPoHom/ERn1D8SvkY+KzsGy2Tu9b1gEdl96kXl
         5Gk/SpqviSrjtvDC8N7oI2beBWisBVHenbp2Wmvd79apeIRPS6qSv4BTSo5iKtEEtT3Y
         /2H47r2A5VVPBSYV0AqZeHalldchI8tgJnipbu5NogX6bYjwlie0EG65dWziCpC6QS/+
         PmUDsCFEmmIKhDuqxAREqH/2ug/x5YDd/7dCjCUHugZWTPb8+KHkyUxXvMkZT4WgXOq4
         6IRQ==
X-Gm-Message-State: AOJu0YzE2bVf3V9GHKqriL4gqOtwAxavmA+yd8NhNv/K56PU2oKTZkg4
	dEK4YCeclI1yVr9/lnx8+Xw5FnZTroDqy/CwzNvWEnsUgHbPdnF6
X-Gm-Gg: ASbGncuQAXlwWOKtlCkCN8TjP5NOLfHODN2X/588yKJuiOkpouC5MtkxyfNc2/+u28M
	Fsui2MDtA+9jlstihOEIcZQWP5mIbvCdFVGwWHLav2tDM9BHljzHzLWOG3yd/6xY5LRnOLLGHAp
	mJPisNyIXHQ6cwtDrlJIApH8UGjbpHSPjgpDiblFqqcsL3+MclxlfuWNXQm6k2QjFqhqpdRpz5n
	CUUBVnSEfnIf3r5avG56YBEiCis35do3PZYlFVDlMHRql3Svl9U9JeC9REax4RyIyyyPiBroyIC
	+oKc2OWbHN0LxCN4xyzRFPR0XFOZbyRgNEJdYPv0l+ltFYkFBe8=
X-Google-Smtp-Source: AGHT+IEGCDzDGCQOExFduOuYtguph+XekXD9HH9d1WRx6aFa/bmD4/A4zQ2jjF7oiDPIfErkbIUiCw==
X-Received: by 2002:a05:600c:46cf:b0:439:8b19:fa92 with SMTP id 5b1f17b1804b1-43999d76df8mr66278545e9.3.1740054607552;
        Thu, 20 Feb 2025 04:30:07 -0800 (PST)
Received: from [10.100.102.74] (89-138-75-149.bb.netvision.net.il. [89.138.75.149])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43992ad82cfsm82018215e9.37.2025.02.20.04.30.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 04:30:07 -0800 (PST)
Message-ID: <727ef073-126c-4ed5-b7fd-8b9e202aba12@grimberg.me>
Date: Thu, 20 Feb 2025 14:30:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet-tcp: Fix a possible sporadic response drops in
 weakly ordered arch
To: Meir Elisha <meir.elisha@volumez.com>, Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org
References: <20250220115409.3271289-1-meir.elisha@volumez.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250220115409.3271289-1-meir.elisha@volumez.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250220_043009_508481_E96312DA 
X-CRM114-Status: UNSURE (   5.68  )
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

