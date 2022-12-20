Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47BABC4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Dec 2022 14:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Cc:To:Subject:
	From:MIME-Version:Date:Message-ID:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BqSPbndbaQbCzv9QOy/9ow2J5JkxA3qRYuse7+FM/mo=; b=S+IE2PQee9SnAfU7UUFXQnIV9y
	mjxEDi8/KDWBi8+XZSvvezu19YroVWOX4F9xRZgVOpsk7ahC+IF4OOivRRGkzPzN8VMaKovVSfwme
	xsr5lh9/078IS5tnNXFEGw0B6fVkZ7Y9kMlPlb+h039jaiddQGT6Um/am7rwEKGAL4Nke4b7E5nBT
	6SwO09yxdq4IiMLfqxMiB4G9iywQh55TiXdDM/BX8ShI8geMPH2iNycBlbx3yp4z7cgsIS+NdsaCD
	XH9tiYguNja2YNMEQIgnag6s+9ggBoNybZjElB8Jnlou6oSV+0THFfVonYUTYuTUXzYKzUcsNYhKm
	7u1CYbSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7dFK-00GRsI-3S; Tue, 20 Dec 2022 14:05:30 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7dF7-00GRbv-CR
	for linux-nvme@lists.infradead.org; Tue, 20 Dec 2022 14:05:19 +0000
Received: by mail-pl1-x631.google.com with SMTP id s7so12361044plk.5
        for <linux-nvme@lists.infradead.org>; Tue, 20 Dec 2022 06:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BqSPbndbaQbCzv9QOy/9ow2J5JkxA3qRYuse7+FM/mo=;
        b=P4OLupzsSXA4WQesDBw8k5DEgImbUsJx3bpGMsO1BGAlZd1aXGroxy5RDg5LQVoXLJ
         U6ooLkEtzFG5IV03NOabouBkNpK/C8gJWGP0d7j/2lUd0wpBiGe8jiDbPtnnDAqHOMS8
         UxoNG241HavAM2sKqHd88RbJ32Zk+WSOEzJXWjgDbIAr662wrngUn5gBj+Y6ilyax4CH
         CxB+LwIB/NkBkDu7sla+DcUP9dFouDwmyTi3uWF210E04pVsOveCFl3XuQ9DXDghmHtX
         ++mIuz6d2+GltETZXAtLldx2qAoZA6c136xIdC+X0Op6IEVOiB2CLQS5EMyMbMmFUhij
         h5ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BqSPbndbaQbCzv9QOy/9ow2J5JkxA3qRYuse7+FM/mo=;
        b=318pnkaBWkC/jxWC2pkJZAKqPTCE8UmK9NyI47aX8WJ2X0BdXXc/3cD4qeVOnIoZjF
         HmBJmPIT9W1NDY4kVz+TM254LgT7OLFjEtAgE75d4vNmqHm6lg2rV7mX7dh16PfRW3xf
         V9DFHgfKUc3WYVHYflje7QqCKkIz8fqE69H7+I4nBX5reywujJLNPBhJNZguGkIj6Kyy
         7vMvh6G/7Kz9PLjMrnPDLT+sUiJc+oTnHfHoBYybxsETFTC2h2PhsUF4eH6ByfZ6PGwY
         RIZaxhl+I9mMfjA9fD40YOgZvxcPPJA/4xuo1WeItJMpHpfZf2qT8a8NA+3vHjb1xSp+
         SEmw==
X-Gm-Message-State: ANoB5pmC/7yVr88i4Ox99K5L27KTnfr2jUogyFeQV401XYQ1b4jNM4JN
	YK+nDJsojAyxyob4n1NaFL5bZbKloa8=
X-Google-Smtp-Source: AA0mqf6lLYsYbohhcNxZNCO5sE4P3kKOYHo1+HCYnOBW1CIfLaw+jZ4/UV7ESUTPyuAIS6xqVAfvmQ==
X-Received: by 2002:a17:902:f211:b0:189:8f0c:d314 with SMTP id m17-20020a170902f21100b001898f0cd314mr42393352plc.39.1671545100863;
        Tue, 20 Dec 2022 06:05:00 -0800 (PST)
Received: from [192.168.0.23] (q014251.dynamic.ppp.asahi-net.or.jp. [203.181.14.251])
        by smtp.gmail.com with ESMTPSA id d18-20020a170903231200b001780e4e6b65sm9400392plh.114.2022.12.20.06.04.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 06:05:00 -0800 (PST)
Message-ID: <c8dda53f-8a90-f6ba-7c51-c762bdfd2ef3@gmail.com>
Date: Tue, 20 Dec 2022 23:04:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
From: "J. Hart" <jfhart085@gmail.com>
Subject: Re: nvme nvme0: I/O 0 (I/O Cmd) QID 1 timeout, aborting, source drive
 corruption observed
To: linux-nvme@lists.infradead.org
Cc: axboe@fb.com, hch@lst.de, sagi@grimberg.me,
 Keith Busch <kbusch@kernel.org>
References: <b302409a-f3d3-5bf8-2f84-01788d15267e@gmail.com>
 <Y6B49qkgqmOmuLLC@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: en-US
In-Reply-To: <Y6B49qkgqmOmuLLC@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221220_060517_497307_8551B77D 
X-CRM114-Status: GOOD (  12.47  )
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
Reply-To: jfhart085@gmail.com
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


As I mentioned in an earlier note, I have updated the util-linux and 
e2fsprogs packages to see if that makes any difference.  The versions I 
was using were rather old.  As expected, it unfortunately did not help, 
although it was a much needed update.

I am out of things to try.

My apologies for being rather a pest about this, but I was hoping I 
wouldn't have to scrap the time and money I put into it. I'll leave you 
all undisturbed and make no more requests of you.

With Thanks for your kind attention,

J. Hart

On 12/19/22 11:45 PM, Keith Busch wrote:
> On Sun, Dec 18, 2022 at 09:08:19PM +0900, J. Hart wrote:
>> Here are some consecutive fsck runs done on /dev/nvme0n1p3:
>>
>> -bash-3.2# fsck -f -C /dev/nvme0n1p2
> 
> I'm having some trouble following some of this. You mentioned nvme0n1p3
> corruption, but then show nvme0n1p2 instead. Could you possibly relay
> your recreation steps starting from a freshly formatted nvme drive?
> Partition setup, device mappers, filesystems, mount options, etc.?


