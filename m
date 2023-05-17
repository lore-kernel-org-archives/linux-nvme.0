Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66CC8C77B7A
	for <linux-nvme@archiver.kernel.org>; Wed, 17 May 2023 09:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=BrtCcuzsDQn6Kmk7cSTd5UgKFr
	p6Bs6eZVmGJ4Z9S9khO9unk0MgnPKSyhrR9HEZkLgXaJ6+kg5foO4+N+sK5LTcsiGdIN9Cg6hrGqz
	GGfiAVBe6SeQ7JSmfkmtJ0MAYP2OwhAV8cJ6fFipqu4aicHJliHdSaKILsmYicSC9n5jUDFkqQKGI
	pekF7yd5C7W3hTeSEAysvPcibw0PmQr3PzkSRWKO1GbxecZFm5icC0Wu9jEWrztaDY1TAsAmsHvSQ
	Y2l9VmmD8fZlXnCl1N+cyltrjyCEqoKdZj0NANwQI8ZWP5CfrPUuZenKKCfuNiXNuD0YsgIy/ZB68
	kbGJ9s+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pzDY3-0094go-1N;
	Wed, 17 May 2023 09:34:19 +0000
Received: from mail-wr1-f45.google.com ([209.85.221.45])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pzDY1-0094fT-0m
	for linux-nvme@lists.infradead.org;
	Wed, 17 May 2023 09:34:18 +0000
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3093aa2f2a5so69038f8f.0
        for <linux-nvme@lists.infradead.org>; Wed, 17 May 2023 02:34:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684316054; x=1686908054;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=LXotqU/kMlB/H3DTQQNu9XHg+SSHEHSZu/hdhENnYUiyu2QuiPrHSfbMFDofODkORc
         z3PiCUldZQLnr626r6tUEGYseG/dglxDTk4s6T4pQQ2rMWqoScZJZ1ceOL/yO2OgKRiP
         YwfqGGQ+t5OqmJ3hMcGjD4qoE8LYTLGUftBQ6zELu58R5cJZ++LXwPa/EfzuYYqtVG+H
         I/4t6qm5JBHytKBAawoTv7Dy6E281jbr3Yq5RHF592cTHoFnZUT8pRHZpjCFVCH6k0lh
         +oIrFZoiAR8oIPdQZJ8xZbpKM8VhIFAxLPYe40FDKVhq5rl4aT4xmI0u7pm89NtSVYCq
         y84A==
X-Gm-Message-State: AC+VfDy0G4cS2Zo+Hi41hcWa7AnrdSPM4xm8zViCuGRKesFDgE0tgH2T
	ywMahCdO2lOleMvPImj4p6s=
X-Google-Smtp-Source: ACHHUZ6r48J7O9f73rYJfdrJLkgLt7glW9ptzE3v4nCKD+wyNcsvK4L6HBV10fz6q7FDJ26r6Kuouw==
X-Received: by 2002:a5d:6509:0:b0:2f8:28e7:13e8 with SMTP id x9-20020a5d6509000000b002f828e713e8mr1155009wru.6.1684316053733;
        Wed, 17 May 2023 02:34:13 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id z21-20020a1c4c15000000b003f42d2f4531sm1571986wmf.48.2023.05.17.02.34.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 02:34:13 -0700 (PDT)
Message-ID: <dd1b440c-2ba3-e12c-e7d1-f3e941ea0c45@grimberg.me>
Date: Wed, 17 May 2023 12:34:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] nvme-multipath: don't call blk_mark_disk_dead in
 nvme_mpath_remove_disk
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org
References: <20230517075345.246138-1-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230517075345.246138-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230517_023417_276812_8A3CFA4E 
X-CRM114-Status: UNSURE (   6.40  )
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

