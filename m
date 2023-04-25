Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12799C77B61
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Apr 2023 15:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oE1UR9p58TRG5JqUJQVdFrEMVwxDxdi4krWKinyEy9E=; b=paL3SnIJypiIySChRTW9uP07fu
	4Eo7j2q38bUUO/u+jZBcpcsaXEC1v3YtuP1CE/NX0viahUcwEbG+U0sIOcH1KBHQ698rcWM8Sp48I
	Uq8aAt1QtmkJ/N7m2tCJbj0x93zkP/aoyviI0fnxfVkvo3XFPFf3gkfQPse5m4QUC8Cxcad0r21gg
	3Yxld4n+l6Tl4P7VHDyy6nNsGMQ05szKMcryz4RE6Lhp08FkeANkD3KNpcp7Ocl7owzodIBlmU5Nw
	muOu846/eAKX7NG9uVEFZ9/1ZSMjN4sPw9b/BLgR04Ypz+O4DlgKbSpwwdz+EA5apelTMdXSPL/AJ
	GER4mACw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1prKaI-001XF3-1w;
	Tue, 25 Apr 2023 15:28:02 +0000
Received: from mail-io1-xd32.google.com ([2607:f8b0:4864:20::d32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1prKaC-001XEA-36
	for linux-nvme@lists.infradead.org;
	Tue, 25 Apr 2023 15:27:58 +0000
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-760a1c94c28so31372839f.1
        for <linux-nvme@lists.infradead.org>; Tue, 25 Apr 2023 08:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1682436474; x=1685028474;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oE1UR9p58TRG5JqUJQVdFrEMVwxDxdi4krWKinyEy9E=;
        b=ABt6nVnIorpNK+LUQZMcXl8DCtKOkmL0BmOnW+edxXADmF57A59VPB4qnpvn4xPaFd
         KaYWIwKhGQcbOceuImbhbnf9webk9efYxB3GtQsAxeI/NqWbIOPM5lOkUBXPM1kLISBo
         8MjE2jLc95aTXlaqG6Xad71EUaxsiR3e6t3R7aibeZtfB4vrv7kCzm6ifsRHAMi+Txuv
         GWhZ29urThMT9ymlD24R1V5o9qULxNAElB5XFZmoi3Gp6knQxB6DMgIBc7Rt2CP/HWkc
         IdFQcaBz566ouZb5mODX93hXcG12t1tK0LSdiQDe2wV3Na+kH2I00SJZUf9xUSkY5TDx
         yPpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682436474; x=1685028474;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oE1UR9p58TRG5JqUJQVdFrEMVwxDxdi4krWKinyEy9E=;
        b=T99uOG7Tqx6JycMZJHQXzofoVp9RpJvh9ImCD5vpTe5X8medfDOHuVDS0UDg+3vXA9
         LvFdghaJHnXMtweNCY1Uf/BiVwoZ1c3qYPCySdknh/GcXTZYOzH0V7g7HIjPLJ6ZExgk
         LjUFqAPxqWNrvyuQFJovuQ2Tvlw9KMXKSjdoOhSKCyYYjStRacR/q7j/SX1nBLKGhR9P
         EaYPBM1QwVOiFGVlD+DvPICTwa9qIqBrKwFdmnZX66TxZGs2Ja0gEXyQdw52CDiYB2XE
         Is4g8dnVMOY+rifYAgwz1dxESOcQt1uNURTWwZFDCl5EKSqKiM0iFU++CQllcxsqkrFA
         CALA==
X-Gm-Message-State: AAQBX9egHib2yHF59SDYh0+RmpBdD8aAtMvnBsxsOAXM23u5RxjUDMUH
	uDlPwo6x8qTUfzGaOY0BM55zaQ==
X-Google-Smtp-Source: AKy350ZgSJ01uruBwEONUm+m+Qtyxj/hR+6mL/somJSOyVHtLY8irt4nwYeitqlQ8ZLbaVN20VMFZA==
X-Received: by 2002:a6b:8d86:0:b0:763:5714:973 with SMTP id p128-20020a6b8d86000000b0076357140973mr1354818iod.0.1682436474175;
        Tue, 25 Apr 2023 08:27:54 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id a5-20020a5d89c5000000b00763b0bb3e74sm2693188iot.17.2023.04.25.08.27.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 08:27:53 -0700 (PDT)
Message-ID: <0ad22261-6a4e-4f0d-eedf-04dbf2c483a7@kernel.dk>
Date: Tue, 25 Apr 2023 09:27:52 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/1] nvme: move sysfs code to a dedicated sysfs.c file
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, hch@lst.de, sagi@grimberg.me,
 kbusch@kernel.org, linux-nvme@lists.infradead.org
Cc: oren@nvidia.com, israelr@nvidia.com
References: <20230424211242.19614-1-mgurtovoy@nvidia.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230424211242.19614-1-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230425_082757_002976_D2EC7E06 
X-CRM114-Status: GOOD (  10.58  )
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

On 4/24/23 3:12?PM, Max Gurtovoy wrote:
> The core.c file became long and hard to maintain. Create a dedicated
> file to centralize the sysfs functionality. This is a common practice to
> separate sysfs/configfs related logic from the main driver logic .c file.
> For example, in the nvmet module the configfs interface has its own
> dedicated file.
> 
> This patch does not include any functional changes.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe


