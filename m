Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 004EAC10F1D
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Dec 2022 11:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=xpFuFCLY87XlrRBwruUqRtI/lx
	I4sKB0DmHJRUnJxDXzqFqoXgNP8caZUQ2BEe8DmPZIYawxR+DP4mK1ilqmKVrQhlar+U5Tyb+wwEs
	+YqLQXrE14eDJ0XNm2VZiFGukrpQxdGCnC7Bm6Jthsev9/vhLVT2kLqBlkRvq++HrrJ53sEYovteI
	opi+MY7/1aVCuIWEaNY2UErXWYRNyZqkWyT8oQrOKXEeOt/ZmSke/H8u2N9OsoOwCJ5Nya1cBFmlC
	zk81g9lZafnNvyIuhps7QGWPwHvEAO0YMvYDiElc+TpjyNNyqWunBnyBxiF0wJte7HWshf08Q1mY6
	HiYaMQjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p9Owp-00AMip-DC; Sun, 25 Dec 2022 11:13:43 +0000
Received: from mail-wr1-f49.google.com ([209.85.221.49])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p9OEZ-00A089-6F
	for linux-nvme@lists.infradead.org; Sun, 25 Dec 2022 10:28:02 +0000
Received: by mail-wr1-f49.google.com with SMTP id d4so132894wrw.6
        for <linux-nvme@lists.infradead.org>; Sun, 25 Dec 2022 02:27:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=O09CfaC+iEWZKTJklG6OSJn+yhuQ8oqNOKZfUJ5ySWG5STqffb2snzSZ0zqSPgwrCH
         jlC7eMZ0hziP3QdaJLtQuv5GH4uWlnY2bFmLIQXtUceBLDBJ0KYt7uX/htncXTEtin1Z
         Lh9fdFo8c8tC3d017h1OESu7kLBiyZbu8j2QVZhf+Axaky4nrBVklPDPVyHwsg4X2YB6
         QkvePqJaEk5CXpJ1nkPsL8nHNi1K9cLgrMtsRghlhPc6SDILwXlxUIfSzTEV8kzHMa9d
         VEbcYljb0mOO7bSYsZB7tC4aQFNde6xNOOEPrg0m7MDqYSFs3cWpypgBc4y8H4SzEqaD
         /ZTg==
X-Gm-Message-State: AFqh2korMTAKw6AmXva/qlRNIBPY2uBOACZu7gt2aNG8AGgB438sWDdh
	qYG9Hu8JIDA3ShUkQcQby7aWYqe/kv4=
X-Google-Smtp-Source: AMrXdXvUo9bmma6coAd5TL96dpsb3WcxOPIlov1zYS+fpk1O8foJQHVncMn9IixeQJSEwrW9Ed6csQ==
X-Received: by 2002:a5d:6e8c:0:b0:26b:e7e1:ad03 with SMTP id k12-20020a5d6e8c000000b0026be7e1ad03mr9152033wrz.55.1671964077377;
        Sun, 25 Dec 2022 02:27:57 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id n14-20020a5d484e000000b00242814c2cf0sm7851598wrs.4.2022.12.25.02.27.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Dec 2022 02:27:56 -0800 (PST)
Message-ID: <caf84a97-d08a-d3fc-22e1-21e2655c087d@grimberg.me>
Date: Sun, 25 Dec 2022 12:27:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 6/6] nvme: consult the CSE log page for unprivileged
 passthrough
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>, linux-nvme@lists.infradead.org
References: <20221223071814.43564-1-hch@lst.de>
 <20221223071814.43564-7-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221223071814.43564-7-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221225_022759_341217_56ABCDE8 
X-CRM114-Status: UNSURE (   5.71  )
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

