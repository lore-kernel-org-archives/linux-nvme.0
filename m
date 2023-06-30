Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D9FEB64DA
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Jun 2023 20:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w6joXddjHPCoQzy4/VLeowXcd9zCYbRo+Axvx24U/+U=; b=ZUdgWSr2G+DL8KmHjTXud3LQSo
	1u8xrMYEVjY6eXJD3g9R7IZPv8YscdBKRwyW6gzqjpw8WUhtIHcuQvEfh7l8kzn2b6bIGuZUVbewF
	csJ/LX8zdfeoruePmch6syRv4RFfCjF8YzulbxfyppE9uWWAjAATXctoswvW0YaOBvEmKQnG6foeN
	VWN4lf02PQ4ZxZjQT4ctWBwLybK6Ck/J6FZyF05nXxZw8/AtjwgLkXUhJoNAL0yv5bISk91HBIPMn
	Fz3LxYrc/h/jcM7uhkJdK8Xn9ie7OLJAEC5qAhCsxQY9ONt9dy/FGzLGqMtqY+teZ1smftGJ/cUzb
	8UuDztfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qFKMS-004SWH-2e;
	Fri, 30 Jun 2023 20:04:56 +0000
Received: from mail-il1-x135.google.com ([2607:f8b0:4864:20::135])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qFKMP-004SVm-07
	for linux-nvme@lists.infradead.org;
	Fri, 30 Jun 2023 20:04:55 +0000
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-345ac638074so3075395ab.1
        for <linux-nvme@lists.infradead.org>; Fri, 30 Jun 2023 13:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1688155491; x=1690747491;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w6joXddjHPCoQzy4/VLeowXcd9zCYbRo+Axvx24U/+U=;
        b=RIqHdFNVUqtNcSm95ayuqA6eXd7pRX9Q5FI40C6NMfNznx6VFa/CZrCYkVIqZDePJ2
         3N5rKf9hWZYQavY+hoUV9gQ3/e5OFkbkZV8gtNHu0acT5uQlG0Z8xOoAumsHw+HMwcpP
         RyA6Z5YYjdiMs14hL9yNnaAlFq0A/J0wPrU6Bnm5/8haCMuNGVdeANacdx37SHtyR9IX
         EEdx2JEeWwYJXB9T/qjDwjAiOcVuqzFsT/SKCKKDwgFz4SJz3GUmkYhzBb/hO645ZXwd
         qNn4vOS/n8N8asMDa5AmO4fe3y3NXR/fXPNKUTuBJNvzaJCtq2tOgP0Q5XJbbLWfd0C8
         Yw7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688155491; x=1690747491;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w6joXddjHPCoQzy4/VLeowXcd9zCYbRo+Axvx24U/+U=;
        b=lIWPKeGjyGXPRxRModDgGC7OBPBHk8wIfc+fuqxL3WSQGqS5XxTS80vD4lmRG54Z5I
         AJYvUrMLsAvk+8HIGGElSPCztgM7cNCal20Y18x2LvkKJ0t1IpsI/s0fhRFydRsph32B
         cIHyI4EQnML+TdK6pJFrGUQfZ8MkMmo/O9tGIsvdNVbbMHKHE0Dm3Vz1RdT7uNFvo5pl
         ijhzczXpXIP1G4peOlx9BhlsSU0LmmQBDHtIgIZffZCaSgYnDckghn64whM6Zl4HDpf3
         8HXTx/mGolG1T/9R74Vp9tlbMgwVDqMAuAxsPTdX62eU0mRM1JaFHEmqhe8CBsKwybGz
         o9uw==
X-Gm-Message-State: ABy/qLaSijeWBkh6NMIlCQdd6UMcycMFRfC5kfxT6gG34cSRZd13WF26
	8Mcf30DIUeBLNobWEJqNXq7c4g==
X-Google-Smtp-Source: APBJJlFumId8o4x1Ve0SIx8qeubRoJAchUCCPsQtX9ItUuFrTwTpztd64Cu8p9Gyil6puOTkkuWDjg==
X-Received: by 2002:a92:760d:0:b0:33b:d741:5888 with SMTP id r13-20020a92760d000000b0033bd7415888mr4262630ilc.0.1688155491568;
        Fri, 30 Jun 2023 13:04:51 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id h12-20020a92c08c000000b00345a98a2bacsm3783595ile.67.2023.06.30.13.04.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jun 2023 13:04:50 -0700 (PDT)
Message-ID: <3b585536-dbb6-45b1-1c65-5fdc53cb3e2a@kernel.dk>
Date: Fri, 30 Jun 2023 14:04:50 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [GIT PULL] nvme updates for Linux 6.5 (part 2)
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
References: <ZJ8fhWv2CuF+o//Z@kbusch-mbp>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZJ8fhWv2CuF+o//Z@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230630_130453_309863_44F29E5E 
X-CRM114-Status: GOOD (  10.62  )
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

On 6/30/23 12:31 PM, Keith Busch wrote:
> The following changes since commit 2293cae703cda162684ae966db6b1b4a11b5e88f:
> 
>   blk-mq: don't insert passthrough request into sw queue (2023-06-21 07:48:34 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.5-2023-06-30
> 
> for you to fetch changes up to 4e69d4dabd2379af57b0b8fb9b0d62c23f9cd3b8:
> 
>   nvme: disable controller on reset state failure (2023-06-30 10:48:20 -0700)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 6.5
> 
>  - Reduce spamming kernel logs on repeated controller updates (Breno)
>  - Improved struct packing (Christophe JAILLET)
>  - Misspelled command name in error logging (Damien)
>  - Failover fix for temporary frozen queue (Sagi)
>  - Reset error handling fixes (Keith)

Pulled, thanks.

-- 
Jens Axboe



