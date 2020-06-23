Return-Path: <SRS0=DDko=AE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C1EC433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jun 2020 15:21:50 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 273BB2070E
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jun 2020 15:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Xjm3Xok4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 273BB2070E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=bibsmYJPge4DCzXbxRH6C+qvHXyEQtTr0m/WU+xJCBk=; b=Xjm3Xok49v2TogU+HIZuAiP/V
	QayvVYeIb1KLZAsIiFoceV9Zajgp/Q0+Mv0UL2teWCj6kapYKDs16hHyZRU0Jjscw51f/l+bOOuG/
	RUn8z6r+1D2LJAS1mSBGqU+uEikPfFsaDbOwm7kCnpnKVy36peC8mvCce1RVGO5GTQ7FcwkbI8qii
	mprXK4N44cHR0xGSviOwoO4zAoe3ajpbIxYhaEUPzLTZoFOulL8m4OIFO1kFSDUOPJaujB78MNqKG
	Ya9uu9/qC9Eq1tsPqAMeIFgb0k1L6jlueKdk0So4JaKtrYrdsOWolcwiFMjGgoOWwxJcjLHiK6l56
	VuYZEATTw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jnkk7-0002hE-7o; Tue, 23 Jun 2020 15:21:47 +0000
Received: from mail-pl1-f194.google.com ([209.85.214.194])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jnkk4-0002gJ-Oj
 for linux-nvme@lists.infradead.org; Tue, 23 Jun 2020 15:21:45 +0000
Received: by mail-pl1-f194.google.com with SMTP id s14so5163526plq.6
 for <linux-nvme@lists.infradead.org>; Tue, 23 Jun 2020 08:21:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=yL6egmBY/qDNgh5Zp93ZnPYePZcK0s8BbQkbbimYx8A=;
 b=JPmALpAXZZhB5ptHWWrYEj/lXHDwnW2Ii6IAl5WVXqyc8BHqzeQhhOpGE7NCsI8F+7
 JRq6mG89+ROCW4XwtA7oGXkemww2AsOHIc0HWAjYpMkAGZ0qLr+wV0sQ6qXE7pE1jKhl
 RjZ+BVlvL6JOAhJpzEnDRJg2RZsOVvdWIq9ZBq9IEocL0SKPtkfdCSSDQ89QPjgXLFEc
 krGpbHaNxg1XKw9V6JoVtvQPZMY0ZFwe7UO1oWGF7QnuibSp4uDKXJAx6ysNmL7BvL+9
 06eOqMvQR75R7X1DL3IKeVbajnf0eD3Tu1U2lIvf4pMZlcmBWwmIBaaWHhaB0VZtg/Fo
 PqTA==
X-Gm-Message-State: AOAM531Y7VFgkPqFDdSOWIyLKArmBoNMsKMRU8Ax+WfQJ1dr3GCH4gz1
 e6JVQyKjvEQf9WsSOVSmAgts1PAu
X-Google-Smtp-Source: ABdhPJx8reIsJ84bNNHP+F9HThDJ9N7zcwDzIDQ0ZXdLaA0Due2QIz27f+0uYD9ZQ/f/pBAe9HUk0g==
X-Received: by 2002:a17:90b:3685:: with SMTP id
 mj5mr24293454pjb.162.1592925700607; 
 Tue, 23 Jun 2020 08:21:40 -0700 (PDT)
Received: from [192.168.50.147] (c-73-241-217-19.hsd1.ca.comcast.net.
 [73.241.217.19])
 by smtp.gmail.com with ESMTPSA id i20sm17891526pfd.81.2020.06.23.08.21.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2020 08:21:39 -0700 (PDT)
Subject: Re: v5.9-rc1 nvme_rdma regression?
To: Christoph Hellwig <hch@lst.de>
References: <593c1a8b-f5c5-fda1-99f6-1417186f0fff@acm.org>
 <20200623084232.GA5762@lst.de> <20200623084420.GA5886@lst.de>
From: Bart Van Assche <bvanassche@acm.org>
Autocrypt: addr=bvanassche@acm.org; prefer-encrypt=mutual; keydata=
 mQENBFSOu4oBCADcRWxVUvkkvRmmwTwIjIJvZOu6wNm+dz5AF4z0FHW2KNZL3oheO3P8UZWr
 LQOrCfRcK8e/sIs2Y2D3Lg/SL7qqbMehGEYcJptu6mKkywBfoYbtBkVoJ/jQsi2H0vBiiCOy
 fmxMHIPcYxaJdXxrOG2UO4B60Y/BzE6OrPDT44w4cZA9DH5xialliWU447Bts8TJNa3lZKS1
 AvW1ZklbvJfAJJAwzDih35LxU2fcWbmhPa7EO2DCv/LM1B10GBB/oQB5kvlq4aA2PSIWkqz4
 3SI5kCPSsygD6wKnbRsvNn2mIACva6VHdm62A7xel5dJRfpQjXj2snd1F/YNoNc66UUTABEB
 AAG0JEJhcnQgVmFuIEFzc2NoZSA8YnZhbmFzc2NoZUBhY20ub3JnPokBOQQTAQIAIwUCVI67
 igIbAwcLCQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEHFcPTXFzhAJ8QkH/1AdXblKL65M
 Y1Zk1bYKnkAb4a98LxCPm/pJBilvci6boefwlBDZ2NZuuYWYgyrehMB5H+q+Kq4P0IBbTqTa
 jTPAANn62A6jwJ0FnCn6YaM9TZQjM1F7LoDX3v+oAkaoXuq0dQ4hnxQNu792bi6QyVdZUvKc
 macVFVgfK9n04mL7RzjO3f+X4midKt/s+G+IPr4DGlrq+WH27eDbpUR3aYRk8EgbgGKvQFdD
 CEBFJi+5ZKOArmJVBSk21RHDpqyz6Vit3rjep7c1SN8s7NhVi9cjkKmMDM7KYhXkWc10lKx2
 RTkFI30rkDm4U+JpdAd2+tP3tjGf9AyGGinpzE2XY1K5AQ0EVI67igEIAKiSyd0nECrgz+H5
 PcFDGYQpGDMTl8MOPCKw/F3diXPuj2eql4xSbAdbUCJzk2ETif5s3twT2ER8cUTEVOaCEUY3
 eOiaFgQ+nGLx4BXqqGewikPJCe+UBjFnH1m2/IFn4T9jPZkV8xlkKmDUqMK5EV9n3eQLkn5g
 lco+FepTtmbkSCCjd91EfThVbNYpVQ5ZjdBCXN66CKyJDMJ85HVr5rmXG/nqriTh6cv1l1Js
 T7AFvvPjUPknS6d+BETMhTkbGzoyS+sywEsQAgA+BMCxBH4LvUmHYhpS+W6CiZ3ZMxjO8Hgc
 ++w1mLeRUvda3i4/U8wDT3SWuHcB3DWlcppECLkAEQEAAYkBHwQYAQIACQUCVI67igIbDAAK
 CRBxXD01xc4QCZ4dB/0QrnEasxjM0PGeXK5hcZMT9Eo998alUfn5XU0RQDYdwp6/kMEXMdmT
 oH0F0xB3SQ8WVSXA9rrc4EBvZruWQ+5/zjVrhhfUAx12CzL4oQ9Ro2k45daYaonKTANYG22y
 //x8dLe2Fv1By4SKGhmzwH87uXxbTJAUxiWIi1np0z3/RDnoVyfmfbbL1DY7zf2hYXLLzsJR
 mSsED/1nlJ9Oq5fALdNEPgDyPUerqHxcmIub+pF0AzJoYHK5punqpqfGmqPbjxrJLPJfHVKy
 goMj5DlBMoYqEgpbwdUYkH6QdizJJCur4icy8GUNbisFYABeoJ91pnD4IGei3MTdvINSZI5e
Message-ID: <648e4335-092e-008d-a07f-e0c96aa3e897@acm.org>
Date: Tue, 23 Jun 2020 08:21:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200623084420.GA5886@lst.de>
Content-Language: en-US
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
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020-06-23 01:44, Christoph Hellwig wrote:
> Actually, please just try this patch:
> 
> 
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 97b1054efb8409..6d5c4495f352ea 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -1696,9 +1696,10 @@ static void nvme_rdma_process_nvme_rsp(struct nvme_rdma_queue *queue,
>  			nvme_rdma_error_recovery(queue->ctrl);
>  		}
>  		/* the local invalidation completion will end the request */
> -	} else {
> -		nvme_rdma_end_request(req);
> +		return;
>  	}
> +
> +	nvme_rdma_end_request(req);
>  }
>  
>  static void nvme_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc)

That helps, so feel free to add:

Tested-by: Bart van Assche <bvanassche@acm.org>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
