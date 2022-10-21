Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D1C1C38A2D
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Oct 2022 21:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Pcjz87d34ZLL9ZZDYHNrEVpvA2PEjvPMwiSpgcT6SWQ=; b=sNIDyFpTkPEtKUduGjJBmUBMna
	diAdqlLSsoy/uqHhf1CNG5kw8LQDwfG2U7Sa0NSGKGbwlnLh7KTotrIQkQro7V6FD2zOP9P/VsUQi
	7L5+Z43cowHdrWnF8leVSRmJU1019ZuE4csGr9+OauSEMM002UKsnPNTSkrcl3XDHdIl6ckBdZN1c
	SGkyIecfcKMK+rFo57psGXcY5D9wYvTORkC/wm6ARg8OGZMoPs2mtM9tsxt6lyBfIObOI6Ul0LSmI
	vcTlFfHm1TQQITTnxjHGo3+R0QUR3HDEjtcGN8j0WF8ctyMHjidW6bedGGz/2g6+UEb1fkqfVl9d3
	O2T5U6Dw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olzJT-009yKd-4W; Fri, 21 Oct 2022 21:12:19 +0000
Received: from mail-pj1-f46.google.com ([209.85.216.46])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olzJQ-009yJK-7E
	for linux-nvme@lists.infradead.org; Fri, 21 Oct 2022 21:12:17 +0000
Received: by mail-pj1-f46.google.com with SMTP id z5-20020a17090a8b8500b00210a3a2364fso5119198pjn.0
        for <linux-nvme@lists.infradead.org>; Fri, 21 Oct 2022 14:12:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pcjz87d34ZLL9ZZDYHNrEVpvA2PEjvPMwiSpgcT6SWQ=;
        b=EqILO46g6vjIJfDEGAbD9tTud+MXrF2DnKRWYWsgavApMx+FCDxFMx7bpmI5f0mFs7
         sTTcubVX+M6a8df1RxrPuoleyZvN7A+TheJUJXw41BefzoLtBXRcn2lnvLC571BiMV1i
         yuueuX8UTE+NaCaFTAEYVq1O8QHu6uN2VTYPlOXunR1VTR+AvGIBrUx/8XcOR82x3NDR
         BqzVpbzS4bAfXcfHnJjas4fDd1yuuYdijsa5hvYo4JWl4tNBJvZAqblZgAcqBfqYCwaR
         ClJ8KAtJGkZc9UkyVuIUfExKjlOd0W3wIDROs0dwq+nU3M6fh4J3flVU2UiQK6RicLre
         5Iug==
X-Gm-Message-State: ACrzQf3lNdScYzYsY+EhAhJy8ZgRu3QoHEiHTgY4OReA/OaIPzRP7VEp
	trUZmk1DlTYJPvVq0wJ/uS8=
X-Google-Smtp-Source: AMsMyM6yHva/jmanLq8t+P2Y5eaV6hJ0WMqvjtEOki7lZBwAN/QENndu8aDK5QJqKK9mzOdmphwsJw==
X-Received: by 2002:a17:902:778f:b0:17f:8347:ff83 with SMTP id o15-20020a170902778f00b0017f8347ff83mr20721524pll.146.1666386734082;
        Fri, 21 Oct 2022 14:12:14 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:3bff:84a:36de:737? ([2620:15c:211:201:3bff:84a:36de:737])
        by smtp.gmail.com with ESMTPSA id d11-20020a17090ab30b00b00202618f0df4sm278032pjr.0.2022.10.21.14.12.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Oct 2022 14:12:13 -0700 (PDT)
Message-ID: <a954e484-af67-d41e-38f2-843a945d1de2@acm.org>
Date: Fri, 21 Oct 2022 14:12:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 1/8] block: set the disk capacity to 0 in
 blk_mark_disk_dead
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chao Leng <lengchao@huawei.com>
Cc: Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
References: <20221020105608.1581940-1-hch@lst.de>
 <20221020105608.1581940-2-hch@lst.de>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20221020105608.1581940-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221021_141216_285598_72839EAA 
X-CRM114-Status: UNSURE (   9.17  )
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

On 10/20/22 03:56, Christoph Hellwig wrote:
> +	/* stop buffered writers from dirtying pages that can't written out */

Hi Christoph,

If this series is reposted, please insert the missing verb "be" in the 
above comment.

Thanks,

Bart.

