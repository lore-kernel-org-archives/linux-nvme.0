Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4868C10F15
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Apr 2024 09:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=57AWbzfyLDixfZnMNHsLoLqNv29Sbs8WNkJqZQdXbzY=; b=rOuyJRFOd9eyeK8O681bixeVHP
	FLoAv/RVWUKUP3p67XfniQkJnkG8jzB65QQSmsVjH3+LpTeUf+vAe+G9T2VuVrktc1Yq3P9j0dZqF
	qMlZajaLEwAw5iaCGBCSDgPROxuYPuB2TogoXFIUMnXYprw0yNJJaJZfG8N/OsJ3C6jG1zOPlkVrQ
	kUmAhl96BSdt4xtvLKhDj34ZthaU84ujlR6MkVb9tWGSBgXcRXMe/Qf/VR4PQiiakDxu/Yu4ZsJtl
	yM+qjPj0OHC0gbEjv+dDoSZYzYU+aj5ay0GLrf5gNxVqC0a/qsU4f6anEY6MueccuJY+h7qauANqR
	iKVMOZqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ryqHs-0000000D0xY-2TB7;
	Mon, 22 Apr 2024 09:48:36 +0000
Received: from mail-wr1-f54.google.com ([209.85.221.54])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ryqGz-0000000D0Hp-1wPd
	for linux-nvme@lists.infradead.org;
	Mon, 22 Apr 2024 09:47:53 +0000
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-349a33a9667so612628f8f.3
        for <linux-nvme@lists.infradead.org>; Mon, 22 Apr 2024 02:47:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713779258; x=1714384058;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=57AWbzfyLDixfZnMNHsLoLqNv29Sbs8WNkJqZQdXbzY=;
        b=KFn1krijvKDlDvRUPf6rsuVrMJESWUawfvPrHCGwcgQ01CQXwqxnvu4L3KYqSHpQTZ
         lJPIigl4+/aY451GmwPIPr4+wmcr62ZGXukXbVTISAvK285u7xvG8jeft14kwfhX5AXW
         Jm+m7uJlxlbXaQlqBYM7nUXNKByN973Rdq3GP5CMN9cjpJqIojWdjldGzuLQQPeZfSYE
         flI8m7KBv7abtEsOUIQfowmccTh+iPET0gP9E3U070AnR9PJPZ8TlD9KGHLopl11p/SS
         pGB3B4SpWJDXIdKxYOcSawtdgaYtBukDmoGjyMA606mOFbAHz+PYsriYh2WmOnwzBiJ4
         nS1g==
X-Forwarded-Encrypted: i=1; AJvYcCVaJD/EEaUNX0wXf2whLisb7i8yf4c47jl6NIU+SwhsCHvN+UORBYmx3OVDwcO//WmWOncDP70eukoM0M6R0ov3bchyE00HAc75WqTDb08=
X-Gm-Message-State: AOJu0Yx++hQfuIaz2GvsC/qg8wOHbG5GPVc0y7buW1c1tok1zDFnyJoR
	JXOFk7Uo2DHjOkRD/3SB1J3hJExHq1a56KbU67JcwEZOXqsKnU26
X-Google-Smtp-Source: AGHT+IFj/pIdlTT/ZrX2AFlEHJy0hOovSNe1OHWJXXEVkAI3MM9c1I4XXNZ878BEvC7vofwz9FYbvQ==
X-Received: by 2002:a05:600c:3b8a:b0:419:f241:6336 with SMTP id n10-20020a05600c3b8a00b00419f2416336mr4094741wms.1.1713779257719;
        Mon, 22 Apr 2024 02:47:37 -0700 (PDT)
Received: from [10.100.102.74] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id j6-20020a5d5646000000b0034b19cb1531sm1913959wrw.59.2024.04.22.02.47.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 02:47:37 -0700 (PDT)
Message-ID: <5758ea16-62d8-477f-91f2-51fe237df70b@grimberg.me>
Date: Mon, 22 Apr 2024 12:47:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Should NVME_SC_INVALID_NS be translated to BLK_STS_IOERR instead
 of BLK_STS_NOTSUPP so that multipath(both native and dm) can failover on the
 failure?
From: Sagi Grimberg <sagi@grimberg.me>
To: Jirong Feng <jirong.feng@easystack.cn>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 linux-nvme@lists.infradead.org, peng.xiao@easystack.cn,
 Christoph Hellwig <hch@lst.de>
References: <a99971dc-9157-4a0f-8fb7-5fa495434b99@grimberg.me>
 <b8cd8de7-9167-4b8f-b255-c022376a7c9d@easystack.cn>
 <dda859d1-41f5-423c-a9e2-900a1573c3a9@easystack.cn>
 <ae40ced9-9f30-4e93-813c-5b94d0667d66@grimberg.me>
 <e27ef3fd-d43c-4dc2-8969-4a0f86d9c64c@easystack.cn>
 <a688834a-99b1-4dd2-b698-c9e54070f78f@grimberg.me>
 <89b542d3-dedb-4d5c-ad7a-279467d28e51@easystack.cn>
 <53b68337-8370-4deb-9a90-bf5dbb7d6d33@grimberg.me>
 <6b345b99-3dd3-4c96-8644-e9b40d387b58@easystack.cn>
 <b3821176-b6f6-4617-92c9-ce8ad9f1118e@grimberg.me>
 <20240131062526.GA16177@lst.de>
 <08b936ff-10d0-48d8-aacd-6ae1e2659600@easystack.cn>
 <68f99d6e-b79f-42a9-bb19-ece27d35dfa6@grimberg.me>
 <d0d87635-839a-43bb-89e4-9ff853d0a878@easystack.cn>
 <bf0752e1-8fb9-45f6-9cf2-e88716952fe6@grimberg.me>
 <b6fba9da-7039-4243-8cf7-9a9a33183556@easystack.cn>
 <3f980a50-3405-45bf-8d66-5052930724dc@grimberg.me>
Content-Language: he-IL, en-US
In-Reply-To: <3f980a50-3405-45bf-8d66-5052930724dc@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240422_024741_688094_99D7D893 
X-CRM114-Status: GOOD (  17.41  )
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



On 12/04/2024 11:57, Sagi Grimberg wrote:
>
>
> On 12/04/2024 10:52, Jirong Feng wrote:
>>> So essentially there is no need for the host side patch? 
>>> interesting. Are you sure?
>>
>> At least no failure is observed in a newer version(6.6.0) of kernel 
>> so far. I can only tell that I've tested it for hundreds of times.
>>
>> In addition, I've got some scripts to enable/disable it continually, 
>> we can observe it a few more days.
>>
>>
>>> Can you please also try with mpath iopolicy=round-robin?
>> All my previous tests were done with round-robin. I retested again 
>> today both round-robin and numa, the results are still the same.
>>
>>
>>> I'm asking because I cannot understand what is preventing this path 
>>> from being selected again and
>>> again for I/O....
>>
>> Perhaps we need to dive into the code of old 
>> version(4.18.0-147.3.1.el8_1) and see what's different?
>>
>> Or should I try apply the host side patch to the old version and test 
>> again?
>
> What I think you want is to trace if the path where you disabled the 
> namespace is actually being selected
> over and over again, and failed over...
>
> Can you please activate tracing and see where your mpath commands are 
> actually going from?
>
> I'd trace nvme_setup_cmd, and see that once you disable one nvmet ns, 
> it is not selected by the mpath
> namespace as a valid ns.

Any update on this?

