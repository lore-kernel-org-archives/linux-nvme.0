Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75487C48BF6
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 10:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LX71Wf074V1/LsC8TNu4ogtheEle/1fxXGYHlIyeoVo=; b=4TUTyh7YPcPLFI9fSC/1833R0W
	yonom5mUpKRwkPLHK0b/7+MULfs1T4IVkZpCihH99Y8AvbcZBN8d+DalejSX34Ni5MoT7DwrYPj2P
	IkgwCyFXiscHhr5qBQetf0NaNr1sedrK85qSv5DEISwYXPw4LtQmZJZYKLmnL9vJpSJdZVFFPZ+OK
	H7ZLXgQtiJJru0PZsC2gDev44JsU0DvudBRSaTAssttlv6ExYVUAUS/D0VM7W2sjaX1ecG24Y0fBS
	Ud7aN3fhPdgbm53sbQGCLnihKA504hGgEmWLgVNSPmQJ7zIUHenoiGBaz/pmdLcUu42wQHK1gthr5
	bIs/bdew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riAwG-000000044vY-0B23;
	Thu, 07 Mar 2024 10:25:24 +0000
Received: from mail-wr1-f49.google.com ([209.85.221.49])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riAwC-000000044uu-2bHm
	for linux-nvme@lists.infradead.org;
	Thu, 07 Mar 2024 10:25:21 +0000
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33db19538d0so169987f8f.1
        for <linux-nvme@lists.infradead.org>; Thu, 07 Mar 2024 02:25:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709807118; x=1710411918;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LX71Wf074V1/LsC8TNu4ogtheEle/1fxXGYHlIyeoVo=;
        b=jdA8YNz+Vj0ozLUWhFfsrjV7VcvU6GM5V/kmrwqO3l0w+xn3Rlpl3LCV+ZVelhahst
         UvkBayFvE8Bka5xKJDzoOD0tIOCdaoMakCC1XIF0aP6hfN5ADjSVhfwEH/fnI4BirEae
         yHTmDHPk2A/HEoxhyfAO0sQN4PEm+jamjlCGVj/A89Mgzcp1UJEQ5gMJNH7NfP6pm59k
         gxhuAsQUXmEgFXEM0u4xIWwZhGwpt+5nS8IIycGB3wjY91rIN1JJO4vkDzFoUhAap32k
         MCshfzSx+Jbz3/XIudD6clY49YpC5eB4kc0B95yNbmnm3RflFW/MUadlNEHk2MeAtx0s
         eIYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUG7DO9nIiDLBvc02uEXAnNjAryjg36uvmOIWS+FYt3lfPqyd08MSN9HAy1xjMWltMjvwJ1KfrznDgTF4pUnDK0/JpRdFculWfmFrRAGq4=
X-Gm-Message-State: AOJu0Yya28uNQqo3sXKIHNJUECQ/kV4ZtfpAvDe8R6qaOjSI9bR8Bz73
	yBvqnhZpjtLWAk7yrHdvQejzzqR6A1JM4Uz7vZXyZbHUnMSLNZbx
X-Google-Smtp-Source: AGHT+IGrxxiU6KmuJ1vc+U5CzL+knJ39wPcNZ/oyZhgYKvZD0scHVdJSNfxfSv1d7eLKlT5APcZ6zw==
X-Received: by 2002:adf:fe4f:0:b0:33e:55e8:5319 with SMTP id m15-20020adffe4f000000b0033e55e85319mr1200107wrs.2.1709807118353;
        Thu, 07 Mar 2024 02:25:18 -0800 (PST)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id r12-20020adfe68c000000b0033df5710fabsm19854052wrm.44.2024.03.07.02.25.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 02:25:18 -0800 (PST)
Message-ID: <83bca01f-fc34-405b-9f2e-8079130400ce@grimberg.me>
Date: Thu, 7 Mar 2024 12:25:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] nvme-fc: do not retry when auth fails or
 connection is refused
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Cc: James Smart <james.smart@broadcom.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240221132404.6311-1-dwagner@suse.de>
 <20240221132404.6311-3-dwagner@suse.de>
 <d5b3d5b2-ec27-4057-aa76-63fe17066cfc@suse.de>
 <sqmla42yoidail73xukhxb6uoyayo66pxpdlrhns3v533wm7wy@ppyr7t5gk3u3>
 <609e0031-e97c-466b-8cbd-47755374b117@suse.de>
 <3xhhdconprn3vvkky4yj4iazku4eiqxl6l6rw6z5tivvdjwaby@ts7satqbih7w>
 <hxr2hztb64dank3jvbnrlciaebo4k2qkkrg3brhrppizeyelpo@ewupxurl7iqm>
 <5d67a55e-e979-4c3c-8dcc-597cb13c7c9d@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <5d67a55e-e979-4c3c-8dcc-597cb13c7c9d@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_022520_686577_30C39EFC 
X-CRM114-Status: GOOD (  18.72  )
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



On 23/02/2024 13:58, Hannes Reinecke wrote:
> On 2/22/24 18:02, Daniel Wagner wrote:
>> On Thu, Feb 22, 2024 at 08:45:04AM +0100, Daniel Wagner wrote:
>>> On Thu, Feb 22, 2024 at 07:46:12AM +0100, Hannes Reinecke wrote:
>>>> On 2/21/24 17:37, Daniel Wagner wrote:
>>>>> On Wed, Feb 21, 2024 at 04:53:44PM +0100, Hannes Reinecke wrote:
>>>>> In this case yes, I've tested on top of this patch. This breaks 
>>>>> the loop
>>>>> where the provided key is invalid or is missing. The loop would happy
>>>>> retry until reaching max of retries.
>>>>
>>>> But that's to be expected, no?
>>>
>>> Why? If the key is wrong/missing it will be likely wrong/missing the
>>> next retry again. So what's the point in retrying?
>>>
>>>> After all, that's _precisely_ what
>>>> NVME_SC_DNR is for;
>>>> if you shouldn't retry, that bit is set.
>>>> If it's not set, you should.
>>>
>>> Okay, in this case there is a bug in the auth code somewhere.
>>
>> With the change below nvme/041 also passes:
>>
>> modified   drivers/nvme/host/fabrics.c
>> @@ -467,7 +467,7 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
>>           if (result & NVME_CONNECT_AUTHREQ_ASCR) {
>>               dev_warn(ctrl->device,
>>                    "qid 0: secure concatenation is not supported\n");
>> -            ret = NVME_SC_AUTH_REQUIRED;
>> +            ret = NVME_SC_AUTH_REQUIRED | NVME_SC_DNR;
>>               goto out_free_data;
>>           }
>>           /* Authentication required */
>> @@ -475,7 +475,7 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
>>           if (ret) {
>>               dev_warn(ctrl->device,
>>                    "qid 0: authentication setup failed\n");
>> -            ret = NVME_SC_AUTH_REQUIRED;
>> +            ret = NVME_SC_AUTH_REQUIRED | NVME_SC_DNR;
>>               goto out_free_data;
>>           }
>>           ret = nvme_auth_wait(ctrl, 0);
>> @@ -540,8 +540,9 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, 
>> u16 qid)
>>           /* Secure concatenation is not implemented */
>>           if (result & NVME_CONNECT_AUTHREQ_ASCR) {
>>               dev_warn(ctrl->device,
>> -                 "qid 0: secure concatenation is not supported\n");
>> -            ret = NVME_SC_AUTH_REQUIRED;
>> +                 "qid %d: secure concatenation is not supported\n",
>> +                 qid);
>> +            ret = NVME_SC_AUTH_REQUIRED | NVME_SC_DNR;
>>               goto out_free_data;
>>           }
>>           /* Authentication required */
>> @@ -549,7 +550,7 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, 
>> u16 qid)
>>           if (ret) {
>>               dev_warn(ctrl->device,
>>                    "qid %d: authentication setup failed\n", qid);
>> -            ret = NVME_SC_AUTH_REQUIRED;
>> +            ret = NVME_SC_AUTH_REQUIRED | NVME_SC_DNR;
>>           } else {
>>               ret = nvme_auth_wait(ctrl, qid);
>>               if (ret)
>>
>> Is this what you had in mind?
>
> Which, incidentally, is basically the patch I just posted.

Reading this, the patchset from Hannes now is clearer.
Isn't the main issue is that nvme-fc tries to periodicly reconnect
when failing the first connect? This is exactly what the test expects
it to do right?

