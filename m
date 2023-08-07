Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB25DC001B0
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Aug 2023 08:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QDdidH8b3MvArZlP5odlqS4No01atw+CrsZYpTqbDJQ=; b=ZjJLEMwlON+H5GU5S/5FamwUBS
	cRdksezkL1L0VCIkkr0Iv1GqtHEH7Aitsrs4M7Qeb9EmTy7p/hjzZEcyXCK+VnkRMAsLsIz9HcUGL
	wEED+G171Wx/AFu7GruyZYRjPC4LFo7s2838oRT+M8rbT4xK7IS92+3io3x5XyKRGZD8biywHVB/A
	WcJa3ok/6FoVcvL0ecRxxRrQUL6SJbEsq5rZJR3kj+IEwJ0uy918vMcD2AWZl70+zZ63QpgKyoaLr
	AOodCt+MV8r6HesBZvn4+cxhw0ARjqu5qLN1td78ueL6FgHzCu2QzRtC0i5qBXLfTmFhATnIqDiMn
	pLePcD1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qSvzb-00GV3j-0V;
	Mon, 07 Aug 2023 08:53:35 +0000
Received: from mail-wr1-f41.google.com ([209.85.221.41])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qSvzY-00GV2y-2Q
	for linux-nvme@lists.infradead.org;
	Mon, 07 Aug 2023 08:53:33 +0000
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3174ca258bbso650197f8f.1
        for <linux-nvme@lists.infradead.org>; Mon, 07 Aug 2023 01:53:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691398410; x=1692003210;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QDdidH8b3MvArZlP5odlqS4No01atw+CrsZYpTqbDJQ=;
        b=j7c4uib7LVzonGKDh3eKjXSeNg0ga5LZ0DfPkt0ujODZIEzZjzKXf/pLyaFEjgnHEO
         mb5aDJ1fphGHx4CMbXcCjbbbPRNLbA5b5Yw/tvYOklhmh6zA9lnNNArfY3JKAJpGtL/b
         fw5JgwFwfk58R+VxBRsy2K6rDJsJ6c5fAVHbGxFKUGkLDnO5SzQVJbxtc/YTkKxUGqjQ
         EH/9qZuhUdOCoWYbahlW8GAeD1Id261zbkn9I+5Om4BTKIuJNhGoiqNPRbsAlmtetx0r
         1n1sdT43V06PtRgMOliennCahCnDTAI7F/grwpG+6S6F5uMc31oepv5zfYu/9ML6VNc7
         fpsA==
X-Gm-Message-State: ABy/qLaSZeiSqkT9I1At/RxJsNi6IUXtCnAUxBrcpigcxvcl3s+WtK8f
	lPR9AJ0/qLSAhil0vyImrIN8NpVA46c=
X-Google-Smtp-Source: APBJJlHzU0Cc9sgCadTWscxbGqN3QZErBi1oxE1NolJGYYgxwtztOH+xBrsxPrAk6aKQUw/rj8hOcg==
X-Received: by 2002:a5d:4ec2:0:b0:317:5f08:32a3 with SMTP id s2-20020a5d4ec2000000b003175f0832a3mr20003928wrv.6.1691398409760;
        Mon, 07 Aug 2023 01:53:29 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id d17-20020a5d6dd1000000b003140fff4f75sm9815632wrz.17.2023.08.07.01.53.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 01:53:29 -0700 (PDT)
Message-ID: <8e0a1503-266f-0368-9eb2-ebeb256bd091@grimberg.me>
Date: Mon, 7 Aug 2023 11:53:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 12/14] nvmet-tcp: allocate socket file
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20230803105102.30949-1-hare@suse.de>
 <20230803105102.30949-13-hare@suse.de>
 <0ac55b10-6917-9247-59f3-5f3b8e121a9f@grimberg.me>
 <432fd12b-3da0-a3d0-73cc-863a272a0f85@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <432fd12b-3da0-a3d0-73cc-863a272a0f85@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230807_015332_783078_42F9FA0D 
X-CRM114-Status: UNSURE (   8.81  )
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


>>> -static int nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
>>> +static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
>>>           struct socket *newsock)
>>
>> Why does the function change from retcode to void in this patch?
> 
> Because the return code was never evaluated.

??

I see it is evaluated.

