Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 338CDC4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Dec 2022 19:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ddcYLuYHLNg/0LyeyDiWjfI/YSGKnd0CVrlSkJjzmJA=; b=sP9QsWSWuymhB0CiqTnkR02vZo
	chLvbA8jxNBf6CxjE9C7Zz0tvNQim0RXlUrkCCPro9zmJl2OU4m//01wbrxoGQT/hMYJ3jZjkLUmy
	tIh4KQ6c/290RsgSO66D9VpHVBLOPgx+/LDdib4PPDXMC9FL0gVcnD4HzB4/s/ny/nR26SC4SElbl
	qPtF+LhvkHIRqTNaRjlg6JVIjHDItx7EjF087QfeVv9WrskqOKVSHOsHWezVEPsH3aLxHiozh8FQ5
	9kW7UWRXSrHJ/32mf5dsstqiLGaAWXMxRvNfcyPRLWvrXu/18qeE23TyPdGxb8QGrFPEljKPX8F3d
	MRrH3ntA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7MCE-001Ppg-1Z; Mon, 19 Dec 2022 19:53:10 +0000
Received: from mail-il1-x131.google.com ([2607:f8b0:4864:20::131])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7LUI-000ZEA-5g
	for linux-nvme@lists.infradead.org; Mon, 19 Dec 2022 19:07:48 +0000
Received: by mail-il1-x131.google.com with SMTP id u8so1678971ilq.13
        for <linux-nvme@lists.infradead.org>; Mon, 19 Dec 2022 11:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ddcYLuYHLNg/0LyeyDiWjfI/YSGKnd0CVrlSkJjzmJA=;
        b=7bMrXtQvuNqYqDX52XWqFv93Y3FwdVcYqrgTm1kLW3UFn3e48qy9nBRmxDlt2uxN5Q
         It9UnQQr1f9Ru/V62TXajw1XckQ/uJvrf7SlNX24w7IsyTVJvYF15Br9+UkeM3yydB11
         RTRtOAkxPi7kHMMKI9+1dtlIO+OUYfZl5DBVx+HIsdHIa6SwOYyxT+rhq45wbUTmr1Z1
         43XSaOM7uqqYBfwNxqitk5hXvmUx8EaEspcFmSvAUkhZNXYIx1yKxXynlbq5fhbbOHTu
         MaUGIe57sCpyyneWmM7BPECHTnJK2Nwuy80VGHW4GH92+URBLPJ22Z1z8HSucA3470Vb
         tFKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ddcYLuYHLNg/0LyeyDiWjfI/YSGKnd0CVrlSkJjzmJA=;
        b=f6ZBA23jkZPItmNGm61HZ/nLK72n2TnCeOjT9KH8PAZ1MfC2eyHENnYmS1GeiTPw4a
         SXRMsmOWwI5cqfWpnvxA9HAVyyosjEsYEKAMGqBtBguoQysJ+W9DUMadH2uY40nBA5rL
         NUwF+vXpUiZLw0uwMhAdBqO7jDATGTaOjgPQ3kOXqC5W28PVqF6SBXjCdR2eJ5tyrBVw
         uNQDRg2qOcXW7OuBDz0uxEqL1meHOtEsI34J34DznvSxnQH/hk3CxcW3JzNPFfys5BCq
         l2fHjUWgx/BIR52c2SQh3Luk8dKo/pcF5SYRpSXjUAxyR13QmNx+R62ygla0RbCU1VVd
         2s9w==
X-Gm-Message-State: ANoB5plR2TFAphVKjIpbFwiGDKadO7mBXKJNE9nn2Hgk0m6l4QCSAnIU
	Wwvqf7bCttIqA+zeib9siXqIcQFXRhOJyZHVgLg=
X-Google-Smtp-Source: AA0mqf4jwLDL9CHWjCwSSjy3NWhPv7Tnq/2I2/iWqeVvq/m9z9COwR/Qeouf+yomBmY8dftpAPUOmw==
X-Received: by 2002:a92:dc83:0:b0:302:42c9:8f2f with SMTP id c3-20020a92dc83000000b0030242c98f2fmr4426191iln.1.1671476864089;
        Mon, 19 Dec 2022 11:07:44 -0800 (PST)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id b4-20020a026f44000000b0039bd05275f5sm1064653jae.176.2022.12.19.11.07.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Dec 2022 11:07:43 -0800 (PST)
Message-ID: <434beef4-05d1-7b93-9a1f-92d29cd849f2@kernel.dk>
Date: Mon, 19 Dec 2022 12:07:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] nvme-pci: Fix mempool alloc size
Content-Language: en-US
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org, hch@lst.de
Cc: sagi@grimberg.me, Keith Busch <kbusch@kernel.org>
References: <20221219185906.3595984-1-kbusch@meta.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20221219185906.3595984-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221219_110746_815154_9EDCACFF 
X-CRM114-Status: GOOD (  12.94  )
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

On 12/19/22 11:59 AM, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Convert the max size to bytes to match the units of the divisor that
> calculates the worst-case number of PRP entries.
> 
> The result is used to determine how many PRP Lists are required. The
> code was previously rounding this to 1 list, but we can require 2 in the
> worst case. In that scenario, the driver would corrupt memory beyond the
> size provided by the mempool.
> 
> While unlikely to occur (you'd need a 4MB in exactly 127 phys segments
> on a queue that doesn't support SGLs), this memory corruption has been
> observed by kfence.

Good catch!

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe



