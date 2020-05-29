Return-Path: <SRS0=L+eZ=7L=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA4B7C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 29 May 2020 16:22:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CD11207F9
	for <linux-nvme@archiver.kernel.org>; Fri, 29 May 2020 16:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Q4wpUuGz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ifAhSGQc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CD11207F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=s7+GEjtHdtrrw1HITllEbkcqcNIjEpDDjyHp6LBZfk0=; b=Q4wpUuGzaBtQTY
	VwfUb2p2IXzK4DifLIj4L9uK3OetqxTg4FhBxSmjFRRjrNhpFTAnftsheT1jQaebHB2xt3kV3sDQV
	p+7w4cPQ6HYGgRvVXLlNYrwPvb+VKwhtohITR4d1JrXk47O5TsFR23AsvKVmr6dil3uYaomdJxxrn
	36A2/khlns8TorEV0O37hiTR1TSMs0DhKvI9woDjSYrRBzGh1G4S6Av3eOCijE20BFymTjBDRPdwc
	5tyb1N/E3h/IwkYzjq+DzQfs01p/ke5W0vbSaq34He4PPiMeIvSZfsuiB33wTLcrHb3kk7+WrrkxY
	9fjoeGecOv0rkb2SrkJg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jehmA-0006MN-AD; Fri, 29 May 2020 16:22:30 +0000
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jehm8-0006Lj-Gr
 for linux-nvme@lists.infradead.org; Fri, 29 May 2020 16:22:29 +0000
Received: by mail-pl1-x629.google.com with SMTP id bh7so1329017plb.11
 for <linux-nvme@lists.infradead.org>; Fri, 29 May 2020 09:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Nzu2wkl8+oSfKrgNVFOxPyYjIUC7u3RtTW7DS1t/Sd0=;
 b=ifAhSGQct0IadeveV6vqjVrkQgaAs7HHuv/EHvRRUIZz8CHX/xPOvdga2YBAMWr5Ee
 WKIhM6iBKPr+/VYJ22FO0UI1sfU+O0rQzzIq3jjK4NgaYrXIFUrZ1yj6poVHHaXSK5In
 ZgjhVSYlGh1Fd6zAYfJXzHsFqQLZWmHCcUEjdOjnlPfTUKlEwgiBooi0CgIF2cKAh2zA
 56txihviS+3i4RIksUrBXGXxEDAN7nhr0jM+XoPz4qYTmUmgDuIQVw/74XWt5mcHkO2+
 7lx+nVhBVp7c8mDMn7HUlKOmwebuxfZzuKl+ainVhFH7voVPFrWp752smr3LqMnVuKg9
 0Vdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Nzu2wkl8+oSfKrgNVFOxPyYjIUC7u3RtTW7DS1t/Sd0=;
 b=lXYyxvtrvT22TrYrxTfnasSxgVMJhDEOmdkB/ZyqAqDI+OJM/p6SShIXFHFmthpyG0
 ZKQSMujaNWY6Xs64cQVqLlq239kAtGmouGzjv6NXK5E7/DxK1QOS4nO3/3d7JpDiw20k
 jpVykGoHu/ayh0D8HRLFw9tLn/E0i6sZzwnswERVKY+dUAIgc77ZSUe85+jaUeO2vdFu
 FsE/YE38xDh5BJowCK/B8WXeaecoPHjoYI0kJ/xE9HzUV0siFV5G8T/9NuzsSAPFMYjh
 zPkWbDhxDClXygq6e6wd7mw1y6XXTkpqa1a+wDKpNC/PjC8l+WMS949O/iM3uBUsz/WD
 V0Gw==
X-Gm-Message-State: AOAM530JQD/BbwyC0J90btGRBQjQ0eMTYz/xBX6v41XBdvtPR5djUzfU
 OAu4/PTax0DkmhTauRIQP8x2mw==
X-Google-Smtp-Source: ABdhPJzpJksd9gHWFeqDPKwm5t5oRCWO73ePHFntKbFUddQeeybr4Yt2h4/Q6bXbuKOrzgZ3+G9aaQ==
X-Received: by 2002:a17:902:ab87:: with SMTP id
 f7mr9981615plr.166.1590769346013; 
 Fri, 29 May 2020 09:22:26 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
 by smtp.gmail.com with ESMTPSA id y18sm7694402pfr.100.2020.05.29.09.22.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 May 2020 09:22:25 -0700 (PDT)
Subject: Re: [PATCHv4 1/2] blk-mq: blk-mq: provide forced completion method
To: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 hch@lst.de, sagi@grimberg.me, linux-block@vger.kernel.org
References: <20200529145200.3545747-1-kbusch@kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <634cf954-337d-1804-a0d8-5a2745d3e48d@kernel.dk>
Date: Fri, 29 May 2020 10:22:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200529145200.3545747-1-kbusch@kernel.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200529_092228_558747_7F7C68EF 
X-CRM114-Status: UNSURE (   9.58  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: alan.adamson@oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 5/29/20 8:51 AM, Keith Busch wrote:
> Drivers may need to bypass error injection for error recovery. Rename
> __blk_mq_complete_request() to blk_mq_force_complete_rq() and export
> that function so drivers may skip potential fake timeouts after they've
> reclaimed lost requests.

Applied 1-2, thanks Keith.

-- 
Jens Axboe


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
