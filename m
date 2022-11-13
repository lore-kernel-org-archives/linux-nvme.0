Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBFF2C433FE
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Nov 2022 11:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FO4tBNnsvlDtV2GsZ7np0WZ40vRXN28UPGrupteRQso=; b=NSCHNcUUiH5AXRv14CAibO/bvm
	bAVIk+KeWtG3hqwYVWjHJGmf5wOQ8UjzSxyaiYuxoQxnOUD4W6ABrznzEkydt72NwsbyJQs6m315d
	BPlHfPgrM2uAbMusVtEaY2Ihjv01lGE625+ypHjqss12Mh/Aw03e3n+wzy8TON2eZQKZvLgYrw1Ix
	LnugOfL5ZY07UVMb39XHq9Ukt5bbX7F/zdBt38zrdtHaiTJMFrVLLKgVwqPDvTIN8oC/S3Frtrb2p
	YmpGHk7nyrWhCNMGjgnl/ihf2RTniPBZCUer8bOztaY/+keONpitcLCqa+zqU+/XF3iEkzvLQEMmm
	KxxoZNOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouAmJ-00B2Wa-Jv; Sun, 13 Nov 2022 11:03:55 +0000
Received: from mail-wr1-f53.google.com ([209.85.221.53])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouAmE-00B2Pi-9k
	for linux-nvme@lists.infradead.org; Sun, 13 Nov 2022 11:03:51 +0000
Received: by mail-wr1-f53.google.com with SMTP id k8so12373994wrh.1
        for <linux-nvme@lists.infradead.org>; Sun, 13 Nov 2022 03:03:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FO4tBNnsvlDtV2GsZ7np0WZ40vRXN28UPGrupteRQso=;
        b=vXHl/+ybykh2GVd7n6DXnrXSxydIe7KAdaAi4YZLYbj6ppHEmU9QShCKGw+Je9oB6z
         gAI5MQbQebfn9LyObUjfCo92y4rvU63qaCqnmc6TZ1B17MwkCVANF5Y8mvoWZmjhKlYL
         RUqglrA3FLMWoKbDTUMmM3el2uYCH/e2wZOtEjDzKIJwcLxSwW+YvGAyfG3GNeln2bzC
         q2CiC4nQjq3i5Nm6ebf3o+FoifqRvS91UIe81WOjFrTtCp54mDEVotQxniMZI5sDVuen
         gRtFPb8y85wlzwoDbUKD90ljOaea7Ee1Ykxx9+SwqBwwHJPfRnQqbtPu1BqbDoBYiQe6
         NP/w==
X-Gm-Message-State: ANoB5plCNdlkVDkbaxWC6q1of1O5q+JEJJWy3Jrmx2HTaNadWIUwtiHt
	p8MA8V3Q/2oCxE8QXeHa7eQ=
X-Google-Smtp-Source: AA0mqf7Kto3piGPK+pvmOlf7F/9EcGLeFFqS3qc3cyytI3ZKvlywKJKZoRb2hP+feT2xnXl+d11dlQ==
X-Received: by 2002:adf:d84b:0:b0:236:c65e:dcbd with SMTP id k11-20020adfd84b000000b00236c65edcbdmr5247173wrl.62.1668337427022;
        Sun, 13 Nov 2022 03:03:47 -0800 (PST)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id g10-20020a5d488a000000b0022cc3e67fc5sm6519296wrq.65.2022.11.13.03.03.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Nov 2022 03:03:46 -0800 (PST)
Message-ID: <1ffea25b-6f67-a1e6-5b96-22bf3b4d89ec@grimberg.me>
Date: Sun, 13 Nov 2022 13:03:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: Resets during user commands leads to hung task and controller
 stuck in connecting
Content-Language: en-US
To: Jonathan Derrick <jonathan.derrick@linux.dev>, Keith Busch
 <kbusch@fb.com>, hch@lst.de, linux-nvme@lists.infradead.org
References: <d4a25dc1-fd2b-8f25-9ec1-04b28dfac386@linux.dev>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <d4a25dc1-fd2b-8f25-9ec1-04b28dfac386@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221113_030350_370914_7DF746A7 
X-CRM114-Status: GOOD (  10.05  )
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



On 11/11/22 23:50, Jonathan Derrick wrote:
> Hi,
> 
> I'm (again) seeing a hung task when doing resets and formats simultaneously.
> Controller state is left in 'connecting'
> 
> Using nvme.git/nvme-6.2 as of 'nvme: implement the DEAC bit for the Write Zeroes command',
> but I have also repro'd with Christoph's latest reset/probe-split set
> 
> 
> ctrl="nvme0"
> nsid=1
> pci="/sys/block/${ctrl}n${nsid}/device/"
> echo 30 > /proc/sys/kernel/hung_task_timeout_secs
> while true; do
>          nvme format -f /dev/${ctrl}n${nsid} &

How long to it take the format to complete?

>          echo 1 > $pci/reset_controller &
> done

What happens if you set io_timeout to 20 instead of 30? (given
that you bound hung tasks at 30 seconds...

