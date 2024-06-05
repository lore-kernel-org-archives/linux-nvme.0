Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECC10C25B76
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Jun 2024 18:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Fd2byO/KenOZn3JNqRr82zIhD1Dtb3pD8qnBr2ef1Fo=; b=cWp6uXk6teqSPMMcN8/6ML2vcz
	BIKpchHks6skc5Vynma4dR44k4+wu2/TXDgJfUCJDpZnCHDJ/iLS9fPl5uzwyWnxpvpr6svM4knnq
	YsKyRXWwXmlAy7VD48SoWIFaCVgzklPULRNMjTrVlP6FMpkFGeXob16VtJsUP/RJWHy4SbRt9Pvwe
	qO1zK9pYaNDbglMGReVEH6rx2+TZtla7y79T+VrLpzMCi6kFEa1kBQPUDmoNAMARVdeR4jUQZXLbK
	uYsSwoA4jmT0NgJ7PaZfg3yjcCN/z4jlnCy19Q8I1hOdP6BL23AjeZf8WQj7Gg/6LSi5QUc2iepz1
	Ys98pQOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEv8l-000000077zp-21mt;
	Wed, 05 Jun 2024 18:13:39 +0000
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEv8i-000000077xt-3SGl
	for linux-nvme@lists.infradead.org;
	Wed, 05 Jun 2024 18:13:38 +0000
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-5b97f09cde3so4456eaf.0
        for <linux-nvme@lists.infradead.org>; Wed, 05 Jun 2024 11:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1717611212; x=1718216012; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fd2byO/KenOZn3JNqRr82zIhD1Dtb3pD8qnBr2ef1Fo=;
        b=WNf6PDN3XlI8dnLmQLjmaCNR+096TSDbQ7y0Q+UN+wyTA5LQiFzOMfqziCKcUmWPeE
         vPqIhqvWqVyQTHmr3YzN+POab5SAdTM67rPALTOLUAdZhyTcyK4LDIpDypY0C+D4e1zd
         wnLdGPCcUv2akWOFv77/GI07LXhmY1l5UFaIsImtZIHij0XqkVCJ8U0D2Nb5GGhDSHa3
         +cvy6rG79NYqlqdBQ/YQgoyLY3U0ThrJE0i2GENEvmSOj6/XguQ0IhBqAidV1HA3F2Fg
         QC5ge3EYi+g3OfvTmRFosXi2mADHcGzkXexMcKzyyi/OsE0cHqw93Goy2KdsTUWZm+5o
         NeMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717611212; x=1718216012;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fd2byO/KenOZn3JNqRr82zIhD1Dtb3pD8qnBr2ef1Fo=;
        b=AEjJVanHriVZe/x+GfhA8xJ8SqSQm/pTXUHiZhmh0eloR/nHLoIyRKnwgFJUebvEkK
         2Ig6tobGDqs+CHfQLbCXO/GTrU7VbB1sx9utzdFRcL41UXgGukFxi74CQCStd0sjdjZg
         1VR480+N5LPlgOvk4kNKUBP5DiFC0Tijbf1oNDrKhEj4YQZwHYUGJ0ZtZOHkzsRAfWDl
         nxKO4Ppa5MK+kM+L8uROWywixgWvafBhgCW+uFngWImheMtHQ/C+AhYvXr2d2ntzYkei
         yVocZBaK7Z5qXIHh/dKOq0QNUwYRDPPcRWJ8uOVpkf2L2bv1cvZ+R0kKhr54h2nMGzXf
         PFxA==
X-Gm-Message-State: AOJu0YzIRMHJBQi0sBpip5umZlxpN6l99n5wcmkmh7RTbV/xMUWuSRUc
	PP5+/RE2v8L1F8ES1WOq08tgfK2dyGa1ncfNe7Yb16IgaspgRXhy49HEbf15xlYt+9odm70xqg6
	6
X-Google-Smtp-Source: AGHT+IHvmAYrbI4X7nm6HeSdKbHE4w6ghqM63umF2ggIFw1qdBkDbXE3X0fLLr0tgO0UcWFsT0vj+w==
X-Received: by 2002:a4a:dfd8:0:b0:5af:be60:ccdc with SMTP id 006d021491bc7-5ba78d49b7fmr3495521eaf.0.1717611212575;
        Wed, 05 Jun 2024 11:13:32 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ba6df5ae07sm678769eaf.22.2024.06.05.11.13.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 11:13:31 -0700 (PDT)
Message-ID: <a69f0da0-1956-47f5-adce-b6c95101f278@kernel.dk>
Date: Wed, 5 Jun 2024 12:13:30 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme fixes for Linux 6.10
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
References: <ZmCp_ZJF9ExtjwUP@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZmCp_ZJF9ExtjwUP@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240605_111337_005253_9DDDCE76 
X-CRM114-Status: UNSURE (   9.96  )
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

On 6/5/24 12:10 PM, Keith Busch wrote:
> The following changes since commit 29459c3eaa5c6261fbe0dea7bdeb9b48d35d862a:
> 
>   block: Fix zone write plugging handling of devices with a runt zone (2024-05-30 15:03:52 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.10-2024-06-05
> 
> for you to fetch changes up to b1a1fdd7096dd2d67911b07f8118ff113d815db4:
> 
>   nvme: fix nvme_pr_* status code parsing (2024-05-31 13:50:59 -0700)
> 
> ----------------------------------------------------------------
> nvme fixes Linux 6.10
> 
>  - Use reserved tags for special fabrics operations (Chunguang)
>  - Persistent Reservation status masking fix (Weiwen)

Pulled, thanks.

-- 
Jens Axboe



