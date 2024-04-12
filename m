Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6AA2C4345F
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Apr 2024 08:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Jz1CgS1qJ/RvRGWVE2pbqsRqRr1qqHStF7Wi2/3cuEw=; b=ZoOTGXRixgqERY31hcgudMN3Sn
	CgO4RWmM/Ybo381JYFrWPtUa0ZVHuh97OXZYCbkL9OIBcrMx9y3GEWGif5JUTZzDzUt19KZAPpw42
	KHX/KncBht3AhZKoSEo+yhTLQeopQzDsbUEZPc+++2kOW8y9SPvHoMetJS6uQJiW7WTZwgzWjqBHf
	t4GmIZh0mV60zGl27wkI13udM6wMSxayh0h2/H5SJopIUoYEIZ2bb+ietHXG4FGw2y4/vgpXfF9fq
	nMTVDD3J9Gyza0J2RufeC0JQ89jAnlfdH4666vSs3taxNo0iuvFQFQdeUIlgFC7o5YH7lR+p3t4J9
	Bta6J5OQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rvCjN-0000000GFhJ-2VWB;
	Fri, 12 Apr 2024 08:57:57 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rvCjI-0000000GFg7-0BUA
	for linux-nvme@lists.infradead.org;
	Fri, 12 Apr 2024 08:57:53 +0000
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-343cb97e7f5so172175f8f.0
        for <linux-nvme@lists.infradead.org>; Fri, 12 Apr 2024 01:57:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712912269; x=1713517069;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jz1CgS1qJ/RvRGWVE2pbqsRqRr1qqHStF7Wi2/3cuEw=;
        b=IFxIulGIt7bc54bN+rz9BZulYtmGRIlzRfOc/R+Jca7vtpOVcxbP4lylnfn1FWPtJo
         lPz/QxrSe+9uziMzWiRx59ClERAIQq5g4VHxtOKw2YsXsIERH4bL/zr94ZvnNIXAXm2X
         JB4xteN4pHvNOR/r3LDp6Q0oVDLxsQy+ok2G19cyYzsb2CjDWTJBkjw2fjyad/Rkuv18
         2Dze8YcT9ULUnCtFKsW48hzhLWUHjipQKMnsYWvkaacPiBqOf1DA0bK4Y1tk6jLFxAQE
         fa48KiimpIwCumJcpKKKEq+otOwES2UGSMEENmXTJXIRRZS0h9F7QuVYFc1DlkfDQXq/
         +J7g==
X-Forwarded-Encrypted: i=1; AJvYcCUNP9PQZTnRtvvcMRd/Chck+T/TILPZBdtSqJ7FbSQ6W3cMMTRGBlBFMH+TVUwrPQjF1zQD7KVREAXmlKRpakeIGXnd5pfewXp6VbU/wrE=
X-Gm-Message-State: AOJu0YzVijUSirpowB7iu6NWoZRpBdx/yCfsiFHmBXZynZBc6OkHOaja
	pKi0KOzmw/69Aq1L/RNiiacDzEYi4N+rgpMSWhKLfXGR77+c2nSOUVf0U6uy
X-Google-Smtp-Source: AGHT+IGbYRVlfdhs3NfUDsakfCAwhY/LXjYslXfb8mRCxB8eg2gIzDWEbcghH22aqV59drzQWIQE4Q==
X-Received: by 2002:adf:e849:0:b0:343:72f5:8e7c with SMTP id d9-20020adfe849000000b0034372f58e7cmr1104945wrn.7.1712912268896;
        Fri, 12 Apr 2024 01:57:48 -0700 (PDT)
Received: from [10.100.102.74] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id q3-20020adfb183000000b00343cad2a4d3sm3802786wra.18.2024.04.12.01.57.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 01:57:48 -0700 (PDT)
Message-ID: <3f980a50-3405-45bf-8d66-5052930724dc@grimberg.me>
Date: Fri, 12 Apr 2024 11:57:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Should NVME_SC_INVALID_NS be translated to BLK_STS_IOERR instead
 of BLK_STS_NOTSUPP so that multipath(both native and dm) can failover on the
 failure?
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
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <b6fba9da-7039-4243-8cf7-9a9a33183556@easystack.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240412_015752_114090_AC8C35D2 
X-CRM114-Status: GOOD (  16.53  )
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



On 12/04/2024 10:52, Jirong Feng wrote:
>> So essentially there is no need for the host side patch? interesting. 
>> Are you sure?
>
> At least no failure is observed in a newer version(6.6.0) of kernel so 
> far. I can only tell that I've tested it for hundreds of times.
>
> In addition, I've got some scripts to enable/disable it continually, 
> we can observe it a few more days.
>
>
>> Can you please also try with mpath iopolicy=round-robin?
> All my previous tests were done with round-robin. I retested again 
> today both round-robin and numa, the results are still the same.
>
>
>> I'm asking because I cannot understand what is preventing this path 
>> from being selected again and
>> again for I/O....
>
> Perhaps we need to dive into the code of old 
> version(4.18.0-147.3.1.el8_1) and see what's different?
>
> Or should I try apply the host side patch to the old version and test 
> again?

What I think you want is to trace if the path where you disabled the 
namespace is actually being selected
over and over again, and failed over...

Can you please activate tracing and see where your mpath commands are 
actually going from?

I'd trace nvme_setup_cmd, and see that once you disable one nvmet ns, it 
is not selected by the mpath
namespace as a valid ns.

