Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE317C433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jun 2022 16:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Lppt8980/tB9Zbvmc9AUhdqZNXfdhmf9QtaVIK386yI=; b=jjyUqTrpS8yQLAYOven9l3f8Zq
	E58kPaDGV8ZiUc9bmQm2TpdWmv6Stqe57fttCdM8Farh0shzFRvkX5eA5h7jwkph3gEig6lGZkSzt
	6y+rMGnkTZ/kvRKXhkBmp1TabuVCBr0V3nWHrElEU+AASwAq2999AZd/+VQ31+TF3lDtuhFaclSmB
	j4K7934u08SQx9Lvr1ypTW5Vb+/s3qVFHy2+gcXw7O9N6lw4QrfwFhPwvEy/lmW8uFdMV15xrI2Jz
	MlOYOJFcDs+AmbNRekVt7Q4cioQa1f6xY0e8noc01lLge2JvblPzoK6nNLsFZBeQSlNbzg5s0CAE7
	3w9FdRtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nwRBW-00H7Pq-1G; Wed, 01 Jun 2022 16:27:02 +0000
Received: from mail-pg1-f176.google.com ([209.85.215.176])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nwRBS-00H7KT-IO
	for linux-nvme@lists.infradead.org; Wed, 01 Jun 2022 16:26:59 +0000
Received: by mail-pg1-f176.google.com with SMTP id d129so2351469pgc.9
        for <linux-nvme@lists.infradead.org>; Wed, 01 Jun 2022 09:26:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Lppt8980/tB9Zbvmc9AUhdqZNXfdhmf9QtaVIK386yI=;
        b=ZU0ZHJwBYD93rnQcm11IytCK1SYW/kREWMMs4dA8KTrlD/WFX0dcX+FrFQyP5M6qTa
         uRtXPh51+axSJ5lctdAQTEycq09tVl926QFjNQ2V/V3ArAwmm1cpaTQXaRrdUt08zT2G
         ilPtfBwRa4aWt6kk/5kk1IhNPatC6tPGsQuvxGCkGvUkyFRxq+Fe17ewrHkuhWsHXrE3
         1VTR2yebaLZFHXxuJfzYhwqW9XmdcnaQjHkgQztG/hjvmEWxMQb0nvVkyg9awG9f6f+d
         HfBgQg/QIFqsOvM2ww7V3YE33Cka+8rpA7/Z0hfaM9rylbjHqjNFFPzNuF8l15eA+hTd
         gNeQ==
X-Gm-Message-State: AOAM533+UrX8F5p5D+Gwn6wFEznxmaohVPikRrkfzSdFv2UQXqQD0F25
	rMic5ey0OldCkb2SAW/SV1pd6QNKhys=
X-Google-Smtp-Source: ABdhPJxwonQO+A/ZPdB1ZTjiqdXZ9STxcAjAxs46OSGQhx0SCMwkcpkJRREuAKWhCmPWYlbkJ2dUWQ==
X-Received: by 2002:a05:6a00:815:b0:518:8acd:be39 with SMTP id m21-20020a056a00081500b005188acdbe39mr405069pfk.70.1654100815518;
        Wed, 01 Jun 2022 09:26:55 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:be8c:a3d9:f876:d119? ([2620:15c:211:201:be8c:a3d9:f876:d119])
        by smtp.gmail.com with ESMTPSA id s11-20020a170902a50b00b001661f9ada6dsm1443930plq.143.2022.06.01.09.26.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 09:26:54 -0700 (PDT)
Message-ID: <109ac246-5cc0-8d5a-ac0a-2937d86fbe06@acm.org>
Date: Wed, 1 Jun 2022 09:26:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [bug report] WARNING: possible circular locking at:
 rdma_destroy_id+0x17/0x20 [rdma_cm] triggered by blktests nvmeof-mp/002
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Sagi Grimberg <sagi@grimberg.me>, Yi Zhang <yi.zhang@redhat.com>,
 RDMA mailing list <linux-rdma@vger.kernel.org>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
References: <CAHj4cs93BfTRgWF6PbuZcfq6AARHgYC2g=RQ-7Jgcf1-6h+2SQ@mail.gmail.com>
 <13441b9b-cc13-f0e0-bd46-f14983dadd49@grimberg.me>
 <4f15039a-eae1-ff69-791c-1aeda1d693df@acm.org>
 <20220527125229.GC2960187@ziepe.ca>
 <4d65a168-c701-6ffa-45b9-858ddcabbbda@acm.org>
 <20220531123544.GH2960187@ziepe.ca>
 <355f1926-9a0d-f65e-d604-6b452fa987e9@acm.org>
 <20220601124556.GI2960187@ziepe.ca>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220601124556.GI2960187@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220601_092658_637856_4A672997 
X-CRM114-Status: GOOD (  21.47  )
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

On 6/1/22 05:45, Jason Gunthorpe wrote:
> On Tue, May 31, 2022 at 10:55:46AM -0700, Bart Van Assche wrote:
>> On 5/31/22 05:35, Jason Gunthorpe wrote:
>>> On Sat, May 28, 2022 at 09:00:16PM +0200, Bart Van Assche wrote:
>>>> On 5/27/22 14:52, Jason Gunthorpe wrote:
>>>>> That only works if you can detect actual different lock classes during
>>>>> lock creation. It doesn't seem applicable in this case.
>>>>
>>>> Why doesn't it seem applicable in this case? The default behavior of
>>>> mutex_init() and related initialization functions is to create one lock
>>>> class per synchronization object initialization caller.
>>>> lockdep_register_key() can be used to create one lock class per
>>>> synchronization object instance. I introduced lockdep_register_key() myself
>>>> a few years ago.
>>>
>>> I don't think this should be used to create one key per instance of
>>> the object which would be required here. The overhead would be very
>>> high.
>>
>> Are we perhaps referring to different code changes? I'm referring to the
>> code change below. The runtime and memory overhead of the patch below
>> should be minimal.
> 
> This is not minimal, the lockdep graph will expand now with a node per
> created CM ID ever created and with all the additional locking
> arcs. This is an expensive operation.
> 
> AFIAK keys should not be created per-object like this but based on
> object classes known when the object is created - eg a CM listening ID
> vs a connceting ID as an example
> 
> This might be a suitable hack if the # of objects was small???

Lockdep uses hashing when looking up a lock object so the lookup time 
shouldn't increase significantly if the number of hash collisions stays 
low. I think this is likely since the number of hash entries is 
identical to the maximum number of synchronization objects divided by 
two. See also the definition of the lock_keys_hash[] array in 
kernel/locking/lockdep.c.

Thanks,

Bart.

