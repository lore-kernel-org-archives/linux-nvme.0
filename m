Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 008D5EB64DA
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Jun 2023 08:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Yhf+D93t2hF5TyQymxDCyCJ2/QdID6WD7JzdyiVmt8s=; b=j6n9TfQb9MwkeQDHlxORC9oNu4
	w6j+SMJUYZNkjxNvhvDtA0kEvfSMBasi/y94p4RhGElYtu7AfS/PgS/OCdHHv7atUap6MYm+LvDF6
	9NLp3driZ69k55VAmGK7u5kImPbQ7khQVlZ4j2ny5GxAKpOefT8BcViPftpIRWKeUN3YytttNenxy
	wfJ2Gf9vF40XQCA0hPLVdxLkjjiab3CWIt2u7Qv2vXvCN5peA8MG8NuQeLwKg4SgE728kf67jw4Da
	0D23E3+QA+fguX3UNdZ8ADuB0y23BbCUvv3jSsYRYM6cT6CREYf2hRbJm4pfwiTy4TT5GWFDMKOSd
	SZoDWfew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qEQJq-00F8n9-2O;
	Wed, 28 Jun 2023 08:14:30 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qEQJo-00F8lu-2U
	for linux-nvme@lists.infradead.org;
	Wed, 28 Jun 2023 08:14:29 +0000
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-313f5f5c6c3so766260f8f.1
        for <linux-nvme@lists.infradead.org>; Wed, 28 Jun 2023 01:14:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687940063; x=1690532063;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yhf+D93t2hF5TyQymxDCyCJ2/QdID6WD7JzdyiVmt8s=;
        b=ItbGu73jon+autabDV/6lYt25Zf8C2M3dUjQBILbn8C7dKjOigl57kEolL3S2jXaZC
         o5WxcKLt8Nicm+XXrBEgMz6CM2Rfp3KEpm3KVdTEuPjs4myOZfNcc7Up6rnBrR3yhE5k
         kI3zK7bmXBkceZvoPygRhBqrusGSBCjRMXrf4+mJdloyTMrn+o/NLsfZv+UKs0bkbjt/
         foUtu6Yh8F+nBcArpjaxzfGp/H/K3D05kuujaEpxfRp73NjouC0MxB6e6xHjqG4xr3q2
         j5VTbj2F/UitD11qpleNTN4k9bGfuHTQCF1LW5aOj3dzdE79WCBslo/l55O/DPvuvh8x
         H37g==
X-Gm-Message-State: AC+VfDwIptPorxQntCiBNagxJF0ziMwU78n/E6XBX6BSu24xWTPSMyZI
	lzzn0IxxG5CGu76qLEkRrfDBxrmTra0=
X-Google-Smtp-Source: ACHHUZ5R0HhectT5beWOt9I9uEKUEPSmy/YQduSYSGHDvkOnr2U/tjaSRzTDgHU8mjwgRLHaYl1emw==
X-Received: by 2002:adf:f703:0:b0:313:e9da:772c with SMTP id r3-20020adff703000000b00313e9da772cmr7886230wrp.5.1687940062678;
        Wed, 28 Jun 2023 01:14:22 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id p12-20020a5d638c000000b00313f61889e9sm6590300wru.36.2023.06.28.01.14.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 01:14:22 -0700 (PDT)
Message-ID: <000e3d0c-0022-c199-1f8d-97e191345197@grimberg.me>
Date: Wed, 28 Jun 2023 11:14:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [bug report] most of blktests nvme/ failed on the latest linux
 tree
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, Yi Zhang <yi.zhang@redhat.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 linux-block <linux-block@vger.kernel.org>
References: <CAHj4cs_qUWzetD0203EKbBLNv3KF=qgTLsWLeHN3PY7UE6mzmw@mail.gmail.com>
 <4b8c1d77-b434-5970-fb1f-8a4059966095@grimberg.me>
 <8a15d10e-f94b-54b7-b080-1887d9c0bdac@nvidia.com>
 <0c4b16a5-17da-02d9-754a-3c7a158daa56@nvidia.com>
 <CAHj4cs9ayQ8J+wDCWVKjmBTWTi7Bc3uqqTCDzL2ZY6JhpdDhsQ@mail.gmail.com>
 <1fda4154-50f4-c09d-dbb1-3b53ed63d341@nvidia.com>
 <CAHj4cs_+yBbs+MgrC8Z8J7X8cKYwwr6wcR5tLfUCcYkftL7N1Q@mail.gmail.com>
 <52df24f1-ebb7-cd24-3aaf-7b946acab3ee@grimberg.me>
 <CAHj4cs9=8fPRtXj4uyjN9MV1OMNNXwcVGte7CDnFxXYYbnnX0A@mail.gmail.com>
 <b3377b27-28de-c8ed-d45a-c3f241c24415@grimberg.me>
 <83ef44fb-fcef-4b61-9de1-bc24e3c0f4d2@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <83ef44fb-fcef-4b61-9de1-bc24e3c0f4d2@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230628_011428_806051_3E453BEC 
X-CRM114-Status: GOOD (  11.49  )
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


>>
>>>> Yi,
>>>>
>>>> Do you have hostnqn and hostid files in your /etc/nvme directory?
>>>>
>>>
>>> No, only one discovery.conf there.
>>>
>>> # ls /etc/nvme/
>>> discovery.conf
>>
>> So the hostid is generated every time if it is not passed.
>> We should probably revert the patch and add it back when
>> blktests are passing.
> 
> Seems like the patch is doing exactly what it should do - fix wrong 
> behavior of users that override hostid.
> Can we fix the tests instead ?

Right, I got confused between a provided host and the default host...

I think we need to add check that /etc/nvme/[hostnqn,hostid] exist
in the test cases.

