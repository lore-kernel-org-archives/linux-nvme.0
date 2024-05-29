Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8008EC25B78
	for <linux-nvme@archiver.kernel.org>; Wed, 29 May 2024 03:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YcGgl0SXVpIqyoxoh79lT3Pq6551Z8JXvrLPNT45iLU=; b=o9nlcYNi7x/FexHzjNIhDY4N7z
	N0/eFy7gZNbyY4hDhTaS4Pc2KFeS9IqJAUd67arDD1FFRdjv/SsrnYK6Mqn8qMv/NfmW0b1BpywOT
	1B5QoDkzemmagtyRD152WxAUPhvAUlPsWvXre2gwWO4AWsyHxhtHijEClybwmHqQ8BdFK/7YeTHxM
	rPL1LmDDYepM/hyI57YX+X7xsVh/COk39gyQlf+g1Aa6pInr4QhGdQruhg6Ado0Thyg0g2x0H+2uw
	vOMuQB+bvxWsLeu+Mdi/3+8cSuDv2S/M/yY3pphnRD70XE5biWoJUcX9tagheUEnZ0wTHJahNZh6a
	nbwrs2gg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCA6M-00000002hrW-0Vei;
	Wed, 29 May 2024 03:35:46 +0000
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCA6I-00000002hqk-2lvS
	for linux-nvme@lists.infradead.org;
	Wed, 29 May 2024 03:35:45 +0000
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-24c9f9f52fdso757659fac.2
        for <linux-nvme@lists.infradead.org>; Tue, 28 May 2024 20:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716953734; x=1717558534; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YcGgl0SXVpIqyoxoh79lT3Pq6551Z8JXvrLPNT45iLU=;
        b=I53KFZuXs8gr05Q7grYhhCG6aap933GbxJLXYHSDoa8+Xxo7WX+F4X7JYUgIpo9XTO
         nX8M1gNZ3ltX97VIi12IwjuFEdG8bo+hvvcd9hx1nlXKSlxyH4LIOYPNm1FDmHSHLset
         Hp9liPRSNqlDYxsI/1W/w7mH4/chf9oVuzj2Uf9O6NQdJqdHZ+JvUo5LcVq9G59U9HYp
         qAkwfSRKKJzQNJEjTXECOfxF9QMYuh4ariSkpgV/1egy6ONRLqF1RPvarumPk3YKr9jI
         Ptd0Ev8e2JTcmuoIyLf5a9AQD+o5kySjgxWS+QiHn9Jhk2vhcunbrvPKmTfznWP22UUV
         1mYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716953734; x=1717558534;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YcGgl0SXVpIqyoxoh79lT3Pq6551Z8JXvrLPNT45iLU=;
        b=h9SapvOIFp30dICW1L2AXLuSRSQ8RVLAa8DMP3ZEQvDA630EElklfZxf0iwLkjdFZu
         qOCzEbJycSj+BRtvs4EdiaqX0DC+SEwQzIZuZ8Mi217jY/YE/rfGOXhEk2n5kq+j1jyh
         w/jPE+xW6ucS3TXTQgaj0gXYN8JmxBOg32FukRZUol80yxAJ3wo1YM27WE/zslHAQn8D
         rqm7G+wls7jKJt1OXpzAzcCJM4yv0b4iPZHj0JevUjRAOu5BGIuwrXbZhJe1QAZRg/7f
         2JxHqeIq2gyc0gD8IoDnvz+2uUeJsZpw9bCvpS9E6dJ05bU2eLDew3p0e5CvlEYnbZkC
         8JGg==
X-Forwarded-Encrypted: i=1; AJvYcCVihPeHuzPlYMv3jpguxszNOYWmtep5B+DD/gCQ7cL8sFmolFXx1i0P2FVFnTWZRJlZ9sqGpK2uOzlCl9fBi7O1OoXLXYbWOruiS5S38lw=
X-Gm-Message-State: AOJu0YxhtbUNmpYc0Sr1TVlPvWqKlZXU+4yBOg0w9qrBT9z5QxwSB9jt
	tj1mncEZda04tWLfVp+1gDUPMXAUa5FtB6xgBMCRv6P5Z6sNPHfC
X-Google-Smtp-Source: AGHT+IEMeEsXE9j72q9zDbE3gsRd/yUDcgLUVY8IEbz/CCazBQTHtpAxSbadTKCJoWH4iqmrS4BVfA==
X-Received: by 2002:a05:6870:d608:b0:24f:cddc:ccfe with SMTP id 586e51a60fabf-24fcddcdee4mr11298769fac.0.1716953734345;
        Tue, 28 May 2024 20:35:34 -0700 (PDT)
Received: from [192.168.1.224] (syn-067-048-091-116.res.spectrum.com. [67.48.91.116])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-24fe0a85880sm2040128fac.4.2024.05.28.20.35.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 20:35:33 -0700 (PDT)
Message-ID: <f480f2a4-2958-4b08-ae32-ce307c3c63aa@gmail.com>
Date: Tue, 28 May 2024 22:35:27 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/4] driver core: shut down devices asynchronously
To: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Tanjore Suresh <tansuresh@google.com>,
 Martin Belanger <Martin.Belanger@dell.com>,
 Oliver O'Halloran <oohall@gmail.com>, Daniel Wagner <dwagner@suse.de>,
 Keith Busch <kbusch@kernel.org>, Lukas Wunner <lukas@wunner.de>,
 David Jeffery <djeffery@redhat.com>, Jeremy Allison <jallison@ciq.com>,
 Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
References: <20240516154920.221445-1-stuart.w.hayes@gmail.com>
 <20240516154920.221445-4-stuart.w.hayes@gmail.com>
 <20240528063109.GA29965@lst.de>
Content-Language: en-US
From: stuart hayes <stuart.w.hayes@gmail.com>
In-Reply-To: <20240528063109.GA29965@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240528_203542_739721_B6BB8FDE 
X-CRM114-Status: GOOD (  15.22  )
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



On 5/28/2024 1:31 AM, Christoph Hellwig wrote:
> On Thu, May 16, 2024 at 10:49:19AM -0500, Stuart Hayes wrote:
>> Add /sys/kernel/async_shutdown to allow user control of this feature:
>>
>>    safe: shut down all devices synchronously, unless driver prefers async
>> 	shutdown (driver opt-in) (default)
>>    on:	shut down all devices asynchronously, unless disabled by the driver
>> 	(driver opt-out)
>>    off:	shut down all devices synchronously
> 
> The on option seems very odd.  IMHO safe is the only really sensible
> option, and maybe we have to support off as a bandaid due to userspace
> behavior dependent on synchronous shutdown, but I'd rather try even
> without that first.
> 

I added the option because of comments from Greg K-H on the v4 submission
of this patch--see

https://lore.kernel.org/lkml/2023102151-rejoicing-studio-6126@gregkh/T/#m5d0459480bc0fda4563040cab2036839bcbb79a8).

I thought it would be nice to have the option for testing, even if it gets
removed later, but I'll certainly remove it now if necessary.

