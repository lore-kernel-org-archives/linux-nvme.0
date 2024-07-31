Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C558BC3DA7F
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Jul 2024 09:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3ilcKjopp3Ixsk38sKct1Un6j+cqQNHWSl5QguoU7UI=; b=3rHj95kpnsRhGBF7kQzyzyfxNk
	ak/Ij0ZkiSrXZoIGknVnueUDWh7thA/0/D5VR007ZDVCtCogT7dmlgM6i172ba3gZwfhfkeTsX89N
	Khr3cmIUACF7V4ZJHEKCUWdygXLwCMfiHudGMiWsehgpFVGfZ9X6PKyDEzUJgQ7hL8Z9TGlcPUHID
	txByiBAI5VLNZr0tNnxcSx73yM3SWb7lxAu0H9DO79CvKXx1NxZPzCniimw0xGzgWhtsRG/FLNqU2
	nHJTk1VLoE2Yxs1HMaavw6TEwd2oDhKn97KuWXRSk531yYZ3t/cMWCYMO2jq1ITH673OYQrHg//FJ
	UKgVdq9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZ5wd-00000000bNg-1vgG;
	Wed, 31 Jul 2024 09:48:31 +0000
Received: from mail-wr1-f52.google.com ([209.85.221.52])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZ5uZ-00000000ait-25CW
	for linux-nvme@lists.infradead.org;
	Wed, 31 Jul 2024 09:46:25 +0000
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3684c05f7afso667494f8f.2
        for <linux-nvme@lists.infradead.org>; Wed, 31 Jul 2024 02:46:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722419181; x=1723023981;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ilcKjopp3Ixsk38sKct1Un6j+cqQNHWSl5QguoU7UI=;
        b=AbSRue9nzkeULA4hJQk0ELSzfIl8uNbadQDFemKd3+sXFPxCtd1xizHvfbUbvE7zj4
         X7qSDenUfPZZH43fgPL3g9PoH9IHQQJR7ws6W8vzXDlIimqs/HbTZDMVmWa0rQJpmOmG
         aLPX7d+TL2i/eYlKWC6SG/dX+F8eVokyurDAv+st6RmncG2/JKZSpLcr12uT6OmBHOKw
         Yz9DEpt6ca8I3JdJTA4fIAdwSmsKkntAcOCFTWo4khIxNl85DmE0f1eAwmCIEnspXUl/
         /k0z1q8LB9QUTRWJDBasR4VacKZXNxe66YzcBSdXwy7QfsstelGDJjeWUofvPn+lForg
         zY0g==
X-Gm-Message-State: AOJu0YzDhQjTQr9seCgsG+7xKnOSbbIs5xAKB4mohIFVzGxas6OL3Obc
	l/OLxuAfACLg1MGxiwcPqej0m1skpowSiELg5r/N/WeukR6HeV8ofS+EMg==
X-Google-Smtp-Source: AGHT+IGo6qJk6NESzJs71cxxNcDxDXcZR2qfM28Tl+PIT0Jw1IwmKm8jWGbNiyPBRZwypeqvmhsl4g==
X-Received: by 2002:a05:600c:3b87:b0:426:668f:5ed7 with SMTP id 5b1f17b1804b1-42805700160mr87938895e9.2.1722419181130;
        Wed, 31 Jul 2024 02:46:21 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282baf2b3esm15220425e9.31.2024.07.31.02.46.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 02:46:20 -0700 (PDT)
Message-ID: <2c881217-faf4-438e-9865-17bed92c529a@grimberg.me>
Date: Wed, 31 Jul 2024 12:46:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] nvme: change data type of lba_shift
To: Kanchan Joshi <joshi.k@samsung.com>, kbusch@kernel.org, hch@lst.de
Cc: linux-nvme@lists.infradead.org
References: <20240730103138.66714-1-joshi.k@samsung.com>
 <CGME20240730103943epcas5p392d6c4261213e7a9cf43e103e4dc76b7@epcas5p3.samsung.com>
 <20240730103138.66714-3-joshi.k@samsung.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240730103138.66714-3-joshi.k@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240731_024623_846292_A5AD0282 
X-CRM114-Status: UNSURE (   4.65  )
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>**

