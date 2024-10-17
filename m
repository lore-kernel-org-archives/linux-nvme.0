Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66DB8D3C52D
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Oct 2024 19:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h7dY53t5FwRrp/FbF9GWcGwvugesPt2rkdIPAJWrC0c=; b=P1N+gYVsTueyQhETLaMhSh9O22
	7xEzfOfTOCnBoPf08LADK2WlrTo6lJsDYQSlT1aVRCwPcjaBHHfc6bomKan6AExLpnnmhMdREmQ39
	NghNEmEUqEFeISXiICWKg9hKBd/QtrqOOhf3RQRSiZ9gL3yPorZ3iNnqOswcfaPhk8U/9KcGTp9tK
	x+9alMaEFL7x56TZwgjTkft5lc+F7/fB92ZlJGsFUbfjnW7o3vrBX1Pv6nrbqzPJ1A9bqc07xat3U
	S2Dcy4enUEZOsi6MszGX2h1mkFrY0a/95dox+T5ln7pAnTws6iv5iZ05ajt5E9iXgywjJAvQtYjyu
	YpPvFq5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1Vw8-0000000G0BD-1xKP;
	Thu, 17 Oct 2024 19:13:28 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1Vuv-0000000FzzA-2Neu
	for linux-nvme@bombadil.infradead.org;
	Thu, 17 Oct 2024 19:12:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=h7dY53t5FwRrp/FbF9GWcGwvugesPt2rkdIPAJWrC0c=; b=m885fSePZIG3phM+cVj9rNF8d/
	BT66m8AQjKIorsLDkfIG8h9gS/hz7vmmdfwfCkDc2+J6v0VK3YrU4DTKILw8aEEO6bqVGtzAkaIlF
	rrloKq6YMv9g/0BXF9PUa6pLwYvv3Zx0wgVVlgfA98YTF8N0c9Zdyh/fNK0Gw3ybsyLNHIDaNKJm4
	q/UQxoPKp05LSuOklesm1EU1lmPgkaMAOvfOgUeyNGEhi+5kGVxr2/y99HFVE1fmM4P25qgnhXTFY
	0kMOjLdfQCQPySIujiG/Z5+FVbsKFMI97791d3RIobi3IdI1ObeZuTAV/MRCJIV4vLmkEdGZN+bOv
	Bu7r9y8Q==;
Received: from mail-io1-xd2d.google.com ([2607:f8b0:4864:20::d2d])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1Vuq-00000007CZv-0fnY
	for linux-nvme@lists.infradead.org;
	Thu, 17 Oct 2024 19:12:12 +0000
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-83ab694ebe5so21869339f.0
        for <linux-nvme@lists.infradead.org>; Thu, 17 Oct 2024 12:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1729192324; x=1729797124; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h7dY53t5FwRrp/FbF9GWcGwvugesPt2rkdIPAJWrC0c=;
        b=TnyrIIFkHSZJI4xcjaYLp2wZtw9ue7ZyRpgwV5Eh3RkwiunUPP8587TtYRA6ddV8C3
         mJr2rK8ppS2fLQkz7Val9KAOgswV4d6krQRVbwGfVCbynLTzwtH36coooh3JTcWcTKtX
         +jQAYownprlUm/Sq09HJ8g6iuKn8orVHpJpJLoaiI7UbD9cW9f27YGpqQSV1V2YsNMrT
         PglDqFesreXOHyBb22VDZKC2ypEDNAWRhBscCqWe9inXPJd+7MNPUoMfGeN49ryB/N8b
         lQWHAJxKNnvxBw8Ve6cogBknwll+uGRYSOtZFEDhwdWFBP+Mm+wCWbSrCgDVcZz1rDHG
         R8iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729192324; x=1729797124;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h7dY53t5FwRrp/FbF9GWcGwvugesPt2rkdIPAJWrC0c=;
        b=Lcp7MI8NzzTAbz2olsN7zWuxXMfqAWV9EdOmQ28XDv648eZ8GBbGc0YdDSwdlAhjvV
         /6VnevddNhyIDok/x1A/xNCZkVgDS3B2dA4ZSvbZb30Xp3vv3iYg3dDyF45WRJHvHbsL
         J06svheVvGGtB3n4XSGqioHDEXkXN7dZKcPfnKCgJwVUtgZmLnGO0TilfJf8A4JnXRDz
         1txlkB3wvuSSAHNe+V6vSG7mTqLOrUxNb75n+4ZJz6AfWbbbMyB22jX3uGsAvJzcMtO6
         gGzcJa5mMQBf+/n5QF2DIC/qHCLFI6UFTd4TpjyzRz9z7KEke7FygWyWlPi/m/lUwx+i
         oRsg==
X-Forwarded-Encrypted: i=1; AJvYcCU3PTdkz5PjS2heA2gti75uLF7JLSdT6o2RyqtPePN4Yg/udO8RerevU8sv6osT+T7Djw6gDHd/snnh@lists.infradead.org
X-Gm-Message-State: AOJu0YwSR8B2iALv2ZGPzM4Fczo4trlpESxTlbLjzE6sfMr5lR0N5plE
	FC1Qwp1UuI1iPbT06gWXt56i0l/l2oF9a67UOk/mRPhdq8QGcXV6qtra+bo3xFw=
X-Google-Smtp-Source: AGHT+IHbxg0kynsczm9UHLwwtaGTvsDJPtZPOLcLjCNgMpekDxqpkAJkVkjm5J+CTr91DQKhOGp0sg==
X-Received: by 2002:a05:6602:6301:b0:83a:9f64:6c75 with SMTP id ca18e2360f4ac-83a9f646e5fmr699310139f.3.1729192324505;
        Thu, 17 Oct 2024 12:12:04 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dc10c2b7fasm9145173.119.2024.10.17.12.12.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 12:12:03 -0700 (PDT)
Message-ID: <a49bd6e1-c20d-4b88-8c16-a9f00f81129e@kernel.dk>
Date: Thu, 17 Oct 2024 13:12:03 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme fixes for Linux 6.12
To: Keith Busch <kbusch@kernel.org>
Cc: hch@lst.de, linux-nvme@lists.infradead.org, sagi@grimberg.me
References: <ZxFb7BMydvpLbDuh@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZxFb7BMydvpLbDuh@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241017_201208_404196_B42F7BE4 
X-CRM114-Status: GOOD (  10.26  )
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

On 10/17/24 12:48 PM, Keith Busch wrote:
> The following changes since commit 8be007c8e0911d0450b402ca8cbb1a8cbd00e8f2:
> 
>   block: fix blk_rq_map_integrity_sg kernel-doc (2024-09-27 04:19:53 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.12-2024-10-18
> 
> for you to fetch changes up to 599d9f3a10eec69ef28a90161763e4bd7c9c02bf:
> 
>   nvme: use helper nvme_ctrl_state in nvme_keep_alive_finish function (2024-10-17 11:07:37 -0700)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 6.12
> 
>  - Fix target passthrough identifier (Nilay)
>  - Fix tcp locking (Hannes)
>  - Replace list with sbitmap for tracking RDMA rsp tags (Guixen)
>  - Remove unnecessary fallthrough statements (Tokunori)
>  - Remove ready-without-media support (Greg)
>  - Fix multipath partition scan deadlock (Keith)
>  - Fix concurrent PCI reset and remove queue mapping (Maurizio)
>  - Fabrics shutdown fixes (Nilay)

Pulled, thanks.

-- 
Jens Axboe


