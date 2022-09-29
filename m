Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE74DC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Sep 2022 15:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w50MylxXfZ4vHg0qzFBvUsz2PdC4z5idp77wnharSgw=; b=XmaiGintTMmcOyAHUHwYGZEWsW
	uGDaCI55faG98CV9H+RPElEMflzRP+6cDCq/z/WJSpfnMrTq+AXeP0lgNROYeo2wRCeoAzI+RI8Sk
	8m97J9/Jl+5xWH8BgrqQnScmivgagwWuXRIuVK0sctCXbJFoz1RcC92Ln98aW6KMv4tGy/KeSiEo9
	1ZG/zUCtmpB53kG7dMzWHYI+J9j8d+5cqPC67o9n0eKV9jwLztDFZWSakpMWBb8+Mv9jf7Eg4Ht6a
	9AtfQIc848H4eRcuz/540lXA2hLE3g8w3p2s+uc2DloNRAeKNkj37y8t+4aO1DdS3xW1gqLzU17at
	//nwim7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odvBX-003mil-6C; Thu, 29 Sep 2022 15:10:47 +0000
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odvBV-003mgg-0j
	for linux-nvme@lists.infradead.org; Thu, 29 Sep 2022 15:10:46 +0000
Received: by mail-pj1-x102e.google.com with SMTP id v10-20020a17090a634a00b00205e48cf845so6216227pjs.4
        for <linux-nvme@lists.infradead.org>; Thu, 29 Sep 2022 08:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=w50MylxXfZ4vHg0qzFBvUsz2PdC4z5idp77wnharSgw=;
        b=HDvQ0YaKEum0HowdgHXRtOqLXApElq2HtUWAJ/3MVCXC4neQYXCGqe2K/ziKBpWCjF
         pjACCucLlqWu573u5O11n+0NBhF6ZvgnUy3OKppOVEkJqChMLzl0Y30f0LlWdxH2bXCr
         S5M6OuNNdRooH3feqjQtd/IDK2PsL7c2M9qz673p99Mhrl6FtjE3PbXdgtDsv7zZ7NQg
         dCLWzbiXJInhbF8NrwoCxY4Q6IQOaaEOHlnz3KSUUKWZ2LrCWBt1MMmHtS6xwLcDoISK
         zGeJbZnwb9SDnq1tSRKN1D9torv656jcDMQ7nf6s+B9dQxpTQ0viC5tLc1tu9LdptDfw
         uzlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=w50MylxXfZ4vHg0qzFBvUsz2PdC4z5idp77wnharSgw=;
        b=LV3CVLKQSPKQ99S/fVwzJenzmiBs/5l9uRmMrGn4fHIOnahacs6N1UB85z3ayB/FmT
         H6kgjDCu00heFpWRLR3A/CpHNJnthv5y/gYIwVu8HwXgnJl5sBgDngWMHGiTc9+WFdNQ
         KLZUZecEvPgMDrXlQCa6vKlTnMMCiSMEnkadr/KAJ3IGayDzVbyEgf8gZO0H3YDbg3an
         IRdheI/BUoivSMohiPxb9B8BB6aRtziQwv4//JOziXje7cBwQZBPDTfPttfrjiQpSCOA
         nLHGtGoPYYuu6TREK45MQWioIHd5FUVYYpuQhBybg6rEDDhqK+6qF0OcXMxFy7KpmRon
         2CNA==
X-Gm-Message-State: ACrzQf0OAEen7Z0bR17a86kqdtG77jxmvBANfKgghmXx5og6zmics5VE
	+fHakTncFaQ1lrmkIGSnY9jjhQ==
X-Google-Smtp-Source: AMsMyM6ryP/KZf4Ql4/N5W72UfQpkoC2AwI6/M/ao4IXAK709OOvglJRoFV+mkbDxcPec1Xs6k5I+Q==
X-Received: by 2002:a17:90b:2644:b0:1fa:e0be:4dcb with SMTP id pa4-20020a17090b264400b001fae0be4dcbmr4168983pjb.85.1664464241240;
        Thu, 29 Sep 2022 08:10:41 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id s3-20020a170902ea0300b001782977fbcdsm6105629plg.206.2022.09.29.08.10.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 08:10:40 -0700 (PDT)
Message-ID: <9fa7658b-0bb3-7828-f0d9-3b9f645defa8@kernel.dk>
Date: Thu, 29 Sep 2022 09:10:39 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [GIT PULL] nvme fixes for Linux 6.0
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
References: <YzWzhIAX+vtSmo39@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YzWzhIAX+vtSmo39@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220929_081045_081903_BB676327 
X-CRM114-Status: UNSURE (   9.54  )
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

On 9/29/22 9:02 AM, Christoph Hellwig wrote:
> The following changes since commit 4c66a326b5ab784cddd72de07ac5b6210e9e1b06:
> 
>   Revert "block: freeze the queue earlier in del_gendisk" (2022-09-20 08:15:44 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.0-2022-09-29

Pulled, thanks.

-- 
Jens Axboe



