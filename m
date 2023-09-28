Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34941CE7B19
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Sep 2023 10:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cimd9e9bWTu4qn6Dyc9oTfXjj6FLz81n7FklBjwPPew=; b=gQxSpQe9s/zWO/LeTmDub6MFk6
	xfhBsrJEYhIxmjxAzkZe0qxhoiMEKu6dAWAxefkkYRySst8Zrp3LE7tiF+mCOUPEQaNnZc+pJUPIL
	Jzs1ha3qdcaDEqayRXCz+YcI1FYLYjGXsqBRjlohPIar2B94s/iNji7nNB4sUMS4U1t4YMWKAJNfX
	sMByb7gPZc2+h1EvmNpM+p9TR6PUPQcG43VzAVGEkqqTepOCKCAZl1u9nl5THE1FUqpW1RQR15RgY
	pm1FPrGAwGYnlRBt89+jQp3Be5CB3zoziBEdef9kVo7RnyLtsZ5esLwFrpvBpCkmbogan3gk9gNAP
	/iDEmHsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qlohJ-002zMZ-01;
	Thu, 28 Sep 2023 10:56:45 +0000
Received: from mail-wr1-f47.google.com ([209.85.221.47])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qlohC-002zK2-14
	for linux-nvme@lists.infradead.org;
	Thu, 28 Sep 2023 10:56:40 +0000
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3232bb059d3so1502137f8f.1
        for <linux-nvme@lists.infradead.org>; Thu, 28 Sep 2023 03:56:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695898595; x=1696503395;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cimd9e9bWTu4qn6Dyc9oTfXjj6FLz81n7FklBjwPPew=;
        b=bII7dm4DhaobGirOZOpwGepbUYK+EAtoOvvFa0Ux0Qz8sCOWKJbK85Cy8hUuG4Zeju
         o1sboDZOQLnGRy76aS41DgQl89waJZjbSwssPPA4k5BAOURpms4feYRECTYDe8DKqCMB
         yPiRpZDHrC4MJF3hy07OfRk1n3vymu7rZCPlc/kPVdHOZD6VucCOvnhLdSGG1QlaSOQs
         BU/GD/nImioISVrpBwjwSpShqujRzpqwoJ1YI9O8zSZTMRdZjrfFyehALsBzxdtJGfTg
         cMDo56Xw5wLs2KOiK6+gMWBkwyiikn3m3o0dcNY5iOJ/+Tn7/ZsyXdBQ3skbeEVdDGQg
         c5gg==
X-Gm-Message-State: AOJu0Ywh35NhNR4D9kSlviVqg7w9POX2a4V+4UqOLUthkC7bIjy154q2
	TV/IfndgSYZEjcNuVxPMe4wy7fuEtFWkxw==
X-Google-Smtp-Source: AGHT+IGibbR20PwXgdONfArpU7AW+P1El3c2EZe+EdFnu5dMAcIsjh1kYLfBQ13jZveS1LNUdC0V/w==
X-Received: by 2002:adf:f986:0:b0:321:5969:d46d with SMTP id f6-20020adff986000000b003215969d46dmr973528wrr.1.1695898594550;
        Thu, 28 Sep 2023 03:56:34 -0700 (PDT)
Received: from [10.100.102.14] (46-116-234-112.bb.netvision.net.il. [46.116.234.112])
        by smtp.gmail.com with ESMTPSA id z4-20020a1c4c04000000b004063ee0b10esm5310688wmf.46.2023.09.28.03.56.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 03:56:33 -0700 (PDT)
Message-ID: <4cbe1b8a-b973-570b-f446-641209ccac32@grimberg.me>
Date: Thu, 28 Sep 2023 13:56:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/3] block: introduce blk_queue_nr_active()
Content-Language: en-US
To: Ewan Milne <emilne@redhat.com>
Cc: linux-nvme@lists.infradead.org, tsong@purestorage.com,
 jmeneghi@redhat.com, mlombard@redhat.com
References: <20230925163123.16042-1-emilne@redhat.com>
 <20230925163123.16042-2-emilne@redhat.com>
 <e034b1ec-68d7-9ccd-4c3f-2bf3c34d3ade@grimberg.me>
 <CAGtn9rkhAttAi_+E_7G5sqtY8d_oUoV5+Qc+W_J8TYFB-rxfBQ@mail.gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CAGtn9rkhAttAi_+E_7G5sqtY8d_oUoV5+Qc+W_J8TYFB-rxfBQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230928_035638_398343_76CC2139 
X-CRM114-Status: UNSURE (   8.95  )
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


> I think it is unfortunately necessary to compute the sum from all the hctxs
> because in the general case there could be threads on other CPUs submitting
> I/O through another hctx that might significantly affect the result,

This argument is true in general, other threads issuing I/O on different
contexts may affect each other as you never know how a controller
processes the submission queues.

Its a tradeoff between the level of inspection and a reasonable
overhead. I do not think iterating over all hctxs of all available paths
is reasonable. But lets wait for your testing.

