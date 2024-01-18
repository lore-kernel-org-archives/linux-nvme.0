Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6F80C4707B
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jan 2024 14:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S2eMzECQ5AvlQFdpHnk1jkqzeOtRN5+enS73/qU9+1o=; b=WtUc2OtTjlQ8lEvh2NS2cTFvhm
	UNOx8tAb5mdCC3odDq6hk7Bwlep5wxAHdvtwS1NIHGTJemnq84jEkaW0CFWo9ZCv/B04wMd96DWEp
	PFQB2qjQXkMIubAPrVFqzctTApb1F56eY5vjoYmlpL/tZjANteIGLFef4qPWgJEKGbyyp/01qgU6G
	TSDd5FZ/CsnD1DuKaKLPDZzIPMTDrSrkCWKDyNg+PzWpotDak0qTlVVFOZbJ2Yn9hPydd0jtDqRDx
	79OYioSUx+lzo5OoXqs6CthMjxlYWBYAim7ZQU2J1r/RtzMAwu2UII+mbHnjfs6xUZt/E5AOg6rbk
	8d3m2aRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQTk1-0030no-18;
	Thu, 18 Jan 2024 14:51:37 +0000
Received: from mail-il1-x12b.google.com ([2607:f8b0:4864:20::12b])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQTjx-0030mV-1Y
	for linux-nvme@lists.infradead.org;
	Thu, 18 Jan 2024 14:51:35 +0000
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-36191ee7be4so3115395ab.0
        for <linux-nvme@lists.infradead.org>; Thu, 18 Jan 2024 06:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705589491; x=1706194291; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S2eMzECQ5AvlQFdpHnk1jkqzeOtRN5+enS73/qU9+1o=;
        b=HTxHlohnc2temVSH9/L53GJNGpMXCWFC33m6Z+WzzrZUgcsBFH8+e+aiLqQ6L9C4u+
         RsUKv+zqE3SKA/BxlKu7B4qTm6bcBw3G90S75lPQzA4szmA+nnqZJqm7eg3rohAxhCdC
         bL/wRNjRvW2YRMSIWC1jXcssNwP1zc+0plj3s/J9X/dfN8BQi2K/4NwLFjateRMHVqdg
         yvfHcqObqLwqosdIcgconTq+Nd2rPuI9Hx1LgSDysL42y0sfqB9hF+b9vYDdZ6l+9nQB
         oQ4hr/DugpzuFmzGuRb9ERlGaGx8ueboo9X3Q7kKzY4UBa8u50w4m+8dyFxZu0M5gsbE
         5YGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705589491; x=1706194291;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S2eMzECQ5AvlQFdpHnk1jkqzeOtRN5+enS73/qU9+1o=;
        b=J6VkYXDFkccXrGxVWqhHpmn+8Kt2b/H2qtEQ5yM4XWmKLg1yUiZsOenLwxGCBKgKG+
         ir296XQhBtHVjSuM89Bzl83DoyUvTEZz5t/9dsVQV3iGjvfuAJLZBXlneBNJ2BiMnnTI
         qB/TVUsOCOG9C/b0E3dAJ1xEpfyB5Sr2iDD/OosE09aTVAjuzEwovdPa8ypXdFChTR9Y
         N/MZKlrTNkfLkFVS4ndzBae4TOTAKUIAJzkmaK27jtaaS+Xwb+nvHzwkBvj4XaMIueLd
         846nPgKR1v4qK72G4EL0Rn7bTmdh6usxGx/w8xecednUpqo9lWBwTlXX+c1lCcv254kD
         Xmbg==
X-Gm-Message-State: AOJu0YwwE25yVoO9xzednLPEzZoyZru4T7w6L+5XbVhF+9Ksg6ZDMcqE
	/6My7ziE05D5odhYNmJVzyPr1arobqGmf/XvFE0ez6wyQuVPmeRxXgXzacYNWKk=
X-Google-Smtp-Source: AGHT+IG2EYYIBRPloa/IpijdR69rM+noRVZ/01wQX4YDEK4OaVXKvwNDsETrzZqVmf3TKC8snYfnjQ==
X-Received: by 2002:a6b:794c:0:b0:7be:e376:fc44 with SMTP id j12-20020a6b794c000000b007bee376fc44mr1756358iop.2.1705589491605;
        Thu, 18 Jan 2024 06:51:31 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5-20020a6b1505000000b007bf2c9bbdd6sm3416975iov.50.2024.01.18.06.51.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 06:51:31 -0800 (PST)
Message-ID: <b590c534-2c5c-41ca-a069-d83549c93dac@kernel.dk>
Date: Thu, 18 Jan 2024 07:51:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Improving Zoned Storage Support
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>, Damien Le Moal
 <dlemoal@kernel.org>,
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
 <86a1f9e6-d3ae-4051-8528-13a952cf74a1@acm.org>
 <90de77e4-ed8a-47be-b5df-2178913ec115@kernel.dk>
 <08d22893-9a05-415e-a610-9b1ceaaba96a@acm.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <08d22893-9a05-415e-a610-9b1ceaaba96a@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240118_065133_704450_56A260C4 
X-CRM114-Status: GOOD (  17.81  )
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

On 1/17/24 5:43 PM, Bart Van Assche wrote:
> On 1/17/24 13:40, Jens Axboe wrote:
>> On 1/17/24 2:33 PM, Bart Van Assche wrote:
>>> Please note that whether or not spin_trylock() is used, there is a
>>> race condition in this approach: if dd_dispatch_request() is called
>>> just before another CPU calls spin_unlock() from inside
>>> dd_dispatch_request() then some requests won't be dispatched until the
>>> next time dd_dispatch_request() is called.
>>
>> Sure, that's not surprising. What I cared most about here is that we
>> should not have a race such that we'd stall. Since we haven't returned
>> this request just yet if we race, we know at least one will be issued
>> and we'll re-run at completion. So yeah, we may very well skip an issue,
>> that's well known within that change, which will be postponed to the
>> next queue run.
>>
>> The patch is more to demonstrate that it would not take much to fix this
>> case, at least, it's a proof-of-concept.
> 
> The patch below implements what has been discussed in this e-mail
> thread. I do not recommend to apply this patch since it reduces single-

No, it implements a suggestion that you had, it had nothing to do with
what I suggested.

> threaded performance by 11% on an Intel Xeon Processor (Skylake, IBRS):

Not sure why you are even bothering sending a patch that makes things
_worse_ when the whole point is to reduce contention here. You added
another lock, and on top of that, you added code that now just bangs on
dispatch if it's busy already.

I already gave you a decent starting point with a patch that actually
reduces contention, no idea what this thing is.

-- 
Jens Axboe


