Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E431C54EAA
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Jan 2023 18:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mawGGYl3xNzEUxiRbmjEZ0yUhhxKM/y8ziqjypj5Hbc=; b=J9WeJlRS/6bQHr3UZHyNW7+Mmi
	gBgK0FKZkzLr5w/R8e1hyy4xeuzEH2qsDx4vgYdkIQaN2qKEtQzaFZwlB60aNcn6XbE7Gb0k+PFgy
	OQAY8BjlL9B5vj37YMQRE/HE+db1rWCEywSDcr3tJVeh1VgoTcurc35PDdsrlhjnm1uWJGESyiTr6
	NCYrLVPWrxFlkV7eN/NmT5hSDaxQ1bKS2KNiiVycaoYVE8oyMi2mXFvJwAckAM4BPghH6H9bMQls2
	gSPJGMUVdm/GPGNR4MXXx21jlFuRcTT6bBKYinXeO2B3zpJr29NzvkQtfzcMA5HWGATSJvYwjnnth
	13x0UR1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pL7EW-00CBUJ-T4; Thu, 26 Jan 2023 18:44:24 +0000
Received: from mail-il1-x134.google.com ([2607:f8b0:4864:20::134])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pL7ES-00CBSW-Qr
	for linux-nvme@lists.infradead.org; Thu, 26 Jan 2023 18:44:22 +0000
Received: by mail-il1-x134.google.com with SMTP id h10so1154905ilq.6
        for <linux-nvme@lists.infradead.org>; Thu, 26 Jan 2023 10:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mawGGYl3xNzEUxiRbmjEZ0yUhhxKM/y8ziqjypj5Hbc=;
        b=CQx57DH6Eeo+qgKuXMRJqhwzCCxkOX+3HyvZpvJA7Lu0mF8EcXY014KBj3nPMgXZYg
         5r8s2uRObOhGHGCUDv4jap2+wbgGmN+feoeAwb2mYW/xle+KvOKYqevSeSEBH+CtsTsV
         /d21+ih+RrNSgiWmBLDNSNOxl4FwOcXABy2Xeu6jgExVTGuwG12Z+tOB65ag97GqMs40
         p/sv+rUIcDulF6Rg5ix5R782jNOptQV9bDTfCHXyaIIlQ7kn/IzT7l1uHNyvmorf2DTq
         jlwFcwEPyPJ5Gz0H9iN5XGOqlSeXYx3QpwO/Ly8rdwEdsHV9he9/wpnYKvgWhcX9Mj40
         Sylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mawGGYl3xNzEUxiRbmjEZ0yUhhxKM/y8ziqjypj5Hbc=;
        b=0VmB4TxMkMY9QlcpN+F7qC0ZgaWJWYvvdWkbubUjMFMNcfMsNnIi5XH1LAHAGGke/x
         tMXDcWrzUhB0k5EG13RnkSDSnXUZXhAEWnhiOIKzSQk2pFvAXF9fz5lDgMWgvleYc2LS
         YQJoSVnar2nAnozPOAv5XN6b91Lb2SIPUuWQsmV0O5eKInjkPsndsNCM30YmodoAb4GQ
         dmofv5J/3xhwt2ZAyxvoRI6Ut1ahB3QqAFUM0zvZwpV4mAuLyoJMq344gy0XietL8L8r
         0Wcd2ecEQ7YDt0R1Bi8Mr6aB5Jn/OYaTA+NiN66ge9X5H75bQOJq6uSYyZigTni91LZr
         0irA==
X-Gm-Message-State: AFqh2kpWXZHDI2ZvQLaWhiDaL6zKUvX0sYqxLYPEa8DuNP53XvXZRIam
	zkNssIsfUJT/ZhRGYOubpNI+Mw==
X-Google-Smtp-Source: AMrXdXvrxP1Mfi9c66OovR6VnwlvB8hiVUCItG1eLAdItfplPqowUFYgb9MaB10+ckqksUQ+yOFRig==
X-Received: by 2002:a92:cda4:0:b0:30d:bf1a:b174 with SMTP id g4-20020a92cda4000000b0030dbf1ab174mr7145796ild.1.1674758658715;
        Thu, 26 Jan 2023 10:44:18 -0800 (PST)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id u15-20020a02aa8f000000b00385f2a30781sm195589jai.72.2023.01.26.10.44.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 10:44:18 -0800 (PST)
Message-ID: <6bea4ea1-9dac-6d74-c3b8-54982fd3de66@kernel.dk>
Date: Thu, 26 Jan 2023 11:44:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [GIT PULL] nvme fixes for Linux 6.2
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <Y9K6fTTrhXSWkVeZ@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y9K6fTTrhXSWkVeZ@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230126_104420_925360_7F003C9A 
X-CRM114-Status: GOOD (  11.81  )
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

On 1/26/23 10:38 AM, Christoph Hellwig wrote:
> The following changes since commit 955bc12299b17aa60325e1748336e1fd1e664ed0:
> 
>   Merge tag 'nvme-6.2-2023-01-20' of git://git.infradead.org/nvme into block-6.2 (2023-01-20 08:08:29 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.2-2023-01-26
> 
> for you to fetch changes up to 85eee6341abb81ac6a35062ffd5c3029eb53be6b:
> 
>   nvme: fix passthrough csi check (2023-01-25 07:09:38 +0100)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 6.2
> 
>  - flush initial scan_work for async probe (Keith Busch)
>  - fix passthrough csi check (Keith Busch)
>  - fix nvme-fc initialization order (Ross Lagerwall)

Pulled, thanks.

-- 
Jens Axboe



