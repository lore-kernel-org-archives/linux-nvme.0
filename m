Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 633FFC47258
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jan 2024 21:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qKRTEGEdrJ4uSy0DPEMsw7O2DbfmPLHSdmoAR4y/Lbs=; b=HMWDpoXTueMAq1mmEabg2yAbo4
	y5K6vIQdCZozBtV6kg1ziyfRVTsGFizEhUhgJ91du551cOakj7lTuoUlqmCk4cZGyjtl9klFgySDJ
	mWW8pWqtpifLULmkw4M+2NhOPmXZiifcwchxDcdXp9R1wIHJRnZHzvURE9KW5TvTO2LqIWN3H9YWL
	q/wAD0uOyJ8YJq4QJZ0HmgEVc3fD1B3GnnF3/eqKLiyl34WR+DENncvoKRZjkZMo/0bSNvlZkOI92
	/nHUb+9KdOWEEvHEgeJviRxoZ33xDoxjJpYIGN0fclYdFprnMaitnoFq3BZNlJ5wdKArpm0ccIiJ+
	42WBEFTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQDXi-000oHZ-1w;
	Wed, 17 Jan 2024 21:33:50 +0000
Received: from mail-pl1-f180.google.com ([209.85.214.180])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQDXe-000oGk-30
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jan 2024 21:33:48 +0000
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d427518d52so961525ad.0
        for <linux-nvme@lists.infradead.org>; Wed, 17 Jan 2024 13:33:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705527223; x=1706132023;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qKRTEGEdrJ4uSy0DPEMsw7O2DbfmPLHSdmoAR4y/Lbs=;
        b=kibb3Np9ypgdthg13HNjs98SDnX4yoKl4ppwPDOI0d0HJwXs/tpy7N0QaKWlv1iZhj
         90nMLuAdoyZyYVc5nLEPuMtKkIzJ0c86jr8JuTZu0BgNrpGWpcRFCKgJLTz9/QvRsGbq
         QXnIHXj/2CznvfvrlNGHgSmkdUNFqFN2AoQSONVQcEMPE1u7dFVrtaNZ2BLHOLPULyBg
         oyhYOhvxSkRnt2ZXuOqM52ADJj+VbF6GkdddVcBeE8pccyKUAQGSrneHReCIpd+KJR95
         gJMJsDr4ZIfEVw/xTwQjHNkoLgLBDlFoq4Ds94HNEoSjmo26o2ocF8fCoyX8qSskpQ7b
         J1zg==
X-Gm-Message-State: AOJu0YzVgZpWtXmOK7EAbjlrrU9IbFDVdqoBTW+FcA905WPKGtrtydbJ
	msfOoNRWR8/eODFCAXks02g=
X-Google-Smtp-Source: AGHT+IGPxShij0/HAOZ8P3At6ZhQ6kIOlS3Ebm0BxPvhf5meWiuDz5mRMRPBO3ETKVp2Fgqhxw+dyg==
X-Received: by 2002:a17:902:d58c:b0:1d5:4b88:9ffc with SMTP id k12-20020a170902d58c00b001d54b889ffcmr2377964plh.1.1705527223358;
        Wed, 17 Jan 2024 13:33:43 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:718b:ab80:1dc2:cbee? ([2620:0:1000:8411:718b:ab80:1dc2:cbee])
        by smtp.gmail.com with ESMTPSA id ki4-20020a170903068400b001d5ea27932csm108599plb.77.2024.01.17.13.33.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 13:33:42 -0800 (PST)
Message-ID: <86a1f9e6-d3ae-4051-8528-13a952cf74a1@acm.org>
Date: Wed, 17 Jan 2024 13:33:41 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Improving Zoned Storage Support
Content-Language: en-US
To: Jens Axboe <axboe@kernel.dk>, Damien Le Moal <dlemoal@kernel.org>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>
References: <5b3e6a01-1039-4b68-8f02-386f3cc9ddd1@acm.org>
 <cc6999c2-2d53-4340-8e2b-c50cae1e5c3a@kernel.org>
 <43cc2e4c-1dce-40ab-b4dc-1aadbeb65371@acm.org>
 <c38ab7b2-63aa-4a0c-9fa6-96be304d8df1@kernel.dk>
 <2955b44a-68c0-4d95-8ff1-da38ef99810f@acm.org>
 <9af03351-a04a-4e61-a6d8-b58236b041a3@kernel.dk>
 <276eedc2-e3d0-40c7-b355-46232ea65662@kernel.dk>
 <39dfcd32-e5fc-45b9-a0ed-082b879a16a4@acm.org>
 <9f4a6b8a-1c17-46b7-8344-cbf4bcb406ab@kernel.dk>
 <207a985d-ad4e-4cad-ac07-961633967bfc@kernel.dk>
 <e8c32676-114b-4aaf-8753-5a6d7b04fc4b@kernel.dk>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <e8c32676-114b-4aaf-8753-5a6d7b04fc4b@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240117_133346_973196_14567442 
X-CRM114-Status: GOOD (  11.29  )
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

On 1/17/24 13:14, Jens Axboe wrote:
>   /* Maps an I/O priority class to a deadline scheduler priority. */
> @@ -600,6 +604,10 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
>   	struct request *rq;
>   	enum dd_prio prio;
>   
> +	if (test_bit(0, &dd->dispatch_state) ||
> +	    test_and_set_bit(0, &dd->dispatch_state))
> +		return NULL;
> +
>   	spin_lock(&dd->lock);
>   	rq = dd_dispatch_prio_aged_requests(dd, now);
>   	if (rq)
> @@ -616,6 +624,7 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
>   	}
>   
>   unlock:
> +	clear_bit(0, &dd->dispatch_state);
>   	spin_unlock(&dd->lock);

Can the above code be simplified by using spin_trylock() instead of
test_bit() and test_and_set_bit()?

Please note that whether or not spin_trylock() is used, there is a
race condition in this approach: if dd_dispatch_request() is called
just before another CPU calls spin_unlock() from inside 
dd_dispatch_request() then some requests won't be dispatched until
the next time dd_dispatch_request() is called.

Thanks,

Bart.


