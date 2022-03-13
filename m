Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4286AC433F5
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Mar 2022 13:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iyGwvyM7kkYxTDOhwWN6QDh439OSnrb9cK7isNjqRxA=; b=4vfFCIRK23kvxTt0Athbn2+u+T
	49BT4GlMeEA0H2iW6nlTrfAbEfJgTWUOCv2mZpY/KYSjhTHR/COjxaq9oFLZPZlZ3abLh0olxi2qv
	i5M3O0Bw5kyPr/iUEVV7WTr6AkLhx/Ta0+ZQkSYg8H3fzgG0aWlR9alb10VB7mZ4GY+5tWhlcKuqL
	5RVT7QOFOsoonT9vwFduxHaq/IoHmkvPi5pBXPS2BRfJXkb8c2nTxbo+Y/7dnr0aLX/Y3hvkMnX4w
	azT53PecZ0ASlqc+CRd35iVoDNUJvjQdZ1SYTAj2QW8gEHUxrda37hj590KCnx75W7UFEM9mhuSx8
	RihBvHfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nTO3k-002oq2-7s; Sun, 13 Mar 2022 13:14:56 +0000
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nTO3g-002opS-RD
 for linux-nvme@lists.infradead.org; Sun, 13 Mar 2022 13:14:54 +0000
Received: by mail-ej1-x632.google.com with SMTP id bi12so28612205ejb.3
 for <linux-nvme@lists.infradead.org>; Sun, 13 Mar 2022 06:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=iyGwvyM7kkYxTDOhwWN6QDh439OSnrb9cK7isNjqRxA=;
 b=Jq9FPNaIbA+nMfPx75F0ET15t9Zla7FA75bXFaIu5/V1eUx8HxufuoSnMsoNECpcP0
 3CTSeHOLwu9RqjLm0uURTgCEJ2mb/XIiAnUOMaCEkuPVocpkXVNhkBcI+rlhvIbN3Cbc
 AEa8dRzWBeNLM5zl/YvMClMt40QYGWqGdhJ1ZziG2beT1DhGtjCF49HKJQGiOzFQsJfe
 h9ySnLmICXhAkDvkJmtXDbudkNU0LnRrk3ko610lgGyl504tx2l6e4+8S0ISabM9TXDC
 ZLCpsI1GDE0Xqmgi0MEssMyuNyhF2zJfry6GCaWIqEK28HHep9b+al1rkz3PcamX6JwU
 5VPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=iyGwvyM7kkYxTDOhwWN6QDh439OSnrb9cK7isNjqRxA=;
 b=HTdHInhgxmvgVoPhJSOK07znTQVfHwF3Fca6Okn4/NpF7Ixk0BrAKfcf1jgRpuu68Q
 qFp/ncZOWGTdpcHk1FPIwyJ+hy+Uvu5GUSUArmMCCsmcu2VTo3U+StGE2eh9pNoAcIg0
 wz9D/MOCanEYY4agSWDfLSHZdrgVFIFyKSGg3kDjFMryhPAlpj+bvBBAo8oZG9gc+hx0
 4hCj66Ew0nlmNMNM+cpVRZsqf/MNPp7oVm2e0xOts4NsYnkJv+Z7gHv8rP1nNSTFq78Y
 sXzwrAP81IoqeClgz9wjOaYWEJ5fX+KJ2D0yVVi7W71Yu7xM2i0r0OYtNt7gZQSys91H
 AzQA==
X-Gm-Message-State: AOAM531r+oc/j7VGwBGnTsqAvf9pbcci6E4eYKANYHW2FtyRvzyutsE1
 95gFR588/qJNihySxG7Xz3o=
X-Google-Smtp-Source: ABdhPJytolg2mj5g2hNNckSN+Qa1kOfXzNC00VL08uOoZzQHHDG67juj4TwOcnV5ycUpsDfI8JhivQ==
X-Received: by 2002:a17:906:c114:b0:6d8:cfd4:f746 with SMTP id
 do20-20020a170906c11400b006d8cfd4f746mr15508287ejc.538.1647177291262; 
 Sun, 13 Mar 2022 06:14:51 -0700 (PDT)
Received: from [192.168.0.59] (178-117-137-225.access.telenet.be.
 [178.117.137.225]) by smtp.gmail.com with ESMTPSA id
 m12-20020a1709060d8c00b006da972685bdsm5510997eji.215.2022.03.13.06.14.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Mar 2022 06:14:50 -0700 (PDT)
Message-ID: <9529e5ef-1362-2bba-a5d9-ac5a926f4506@gmail.com>
Date: Sun, 13 Mar 2022 14:14:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v3] nvmet: add missing lock around nvmet_ns_changed in
 nvmet_ns_revalidate
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>,
 Bart Van Assche <bvanassche@acm.org>
References: <20220310125130.16786-1-dossche.niels@gmail.com>
 <df1063c4-eff1-6a4e-0dbb-600ce8ed9721@grimberg.me>
From: Niels Dossche <dossche.niels@gmail.com>
In-Reply-To: <df1063c4-eff1-6a4e-0dbb-600ce8ed9721@grimberg.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220313_061452_937209_FDE80B9C 
X-CRM114-Status: GOOD (  26.32  )
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

On 3/13/22 14:03, Sagi Grimberg wrote:
>
>
> On 3/10/22 14:51, Niels Dossche wrote:
>> nvmet_ns_changed states via lockdep that the ns->subsys->lock must be
>> held. The only caller of nvmet_ns_changed which does not acquire that
>> lock is nvmet_ns_revalidate. nvmet_ns_revalidate has 3 callers, of which
>> 2 do not acquire that lock: nvmet_execute_identify_cns_cs_ns and
>> nvmet_execute_identify_ns. The other caller
>> nvmet_ns_revalidate_size_store does acquire the lock. Add a parameter to
>> nvmet_ns_revalidate to indicate whether the lock was already taken or
>> not, and thus whether the function still needs to take a lock when
>> calling nvmet_ns_changed.
>> 
>> The alternative solution is to let nvmet_ns_revalidate return a bool
>> which indicates whether nvmet_ns_changed needs to be called and let the
>> callers handle the locking responsibility. This however places the
>> responsibility with its callers and causes more duplicate code and
>> potential to forget to check the return value.
>> 
>> Both of those identify functions are called from a common function
>> nvmet_execute_identify, which itself is called indirectly via the
>> req->execute function pointer.
>> 
>> This issue was found using a static type-based analyser and manually
>> verified.
>> 
>> Signed-off-by: Niels Dossche <dossche.niels at gmail.com>
>> ---
>> 
>> Changes in v3:
>>   - improve commit description
>>   - do the locking locally
>> 
>> Changes in v2:
>>   - added sentence about how the issue was found.
>>   - added missing &
>> 
>>   drivers/nvme/target/admin-cmd.c | 2 +-
>>   drivers/nvme/target/configfs.c  | 2 +-
>>   drivers/nvme/target/core.c      | 9 +++++++--
>>   drivers/nvme/target/nvmet.h     | 2 +-
>>   drivers/nvme/target/zns.c       | 3 ++-
>>   5 files changed, 12 insertions(+), 6 deletions(-)
>> 
>> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
>> index 6fb24746de06..efa462374783 100644
>> --- a/drivers/nvme/target/admin-cmd.c
>> +++ b/drivers/nvme/target/admin-cmd.c
>> @@ -511,7 +511,7 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
>>   		goto done;
>>   	}
>>   
>> -	nvmet_ns_revalidate(req->ns);
>> +	nvmet_ns_revalidate(req->ns, true);
>>   
>>   	/*
>>   	 * nuse = ncap = nsze isn't always true, but we have no way to find
>> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
>> index 091a0ca16361..a803cd66dc4b 100644
>> --- a/drivers/nvme/target/configfs.c
>> +++ b/drivers/nvme/target/configfs.c
>> @@ -586,7 +586,7 @@ static ssize_t nvmet_ns_revalidate_size_store(struct config_item *item,
>>   		mutex_unlock(&ns->subsys->lock);
>>   		return -EINVAL;
>>   	}
>> -	nvmet_ns_revalidate(ns);
>> +	nvmet_ns_revalidate(ns, false);
>>   	mutex_unlock(&ns->subsys->lock);
>>   	return count;
>>   }
>> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
>> index 5119c687de68..0ceef97e4093 100644
>> --- a/drivers/nvme/target/core.c
>> +++ b/drivers/nvme/target/core.c
>> @@ -531,7 +531,7 @@ static void nvmet_p2pmem_ns_add_p2p(struct nvmet_ctrl *ctrl,
>>   		ns->nsid);
>>   }
>>   
>> -void nvmet_ns_revalidate(struct nvmet_ns *ns)
>> +void nvmet_ns_revalidate(struct nvmet_ns *ns, bool should_acquire_lock)
>>   {
>>   	loff_t oldsize = ns->size;
>>   
>> @@ -540,8 +540,13 @@ void nvmet_ns_revalidate(struct nvmet_ns *ns)
>>   	else
>>   		nvmet_file_ns_revalidate(ns);
>>   
>> -	if (oldsize != ns->size)
>> +	if (oldsize != ns->size) {
>> +		if (should_acquire_lock)
>> +			mutex_lock(&ns->subsys->lock);
>>   		nvmet_ns_changed(ns->subsys, ns->nsid);
>> +		if (should_acquire_lock)
>> +			mutex_unlock(&ns->subsys->lock);
>> +	}
> 
> What is the harm locking it always and avoid the conditional?

In my patch v2 submission I wrote the following text in my commit message:
> nvmet_ns_changed states via lockdep that the ns->subsys->lock must be
> held. The only caller of nvmet_ns_changed which does not acquire that
> lock is nvmet_ns_revalidate.
on which Christoph Hellwig replied:
> So acquire it in nvmet_ns_revalidate only when we actually call
> nvmet_ns_changed.  Otherwise we take a subsystem-wide lock for every
> Identify Namespace all.

Therefore, I changed it to a conditional lock in this patch submission.

My commit message in v2 did not clearly state that nvmet_ns_revalidate has 3 callers, of which
2 do not acquire that lock: nvmet_execute_identify_cns_cs_ns and nvmet_execute_identify_ns. The other caller
nvmet_ns_revalidate_size_store does acquire the lock. Maybe I caused some confusion because of the unclear wording.

Thanks

