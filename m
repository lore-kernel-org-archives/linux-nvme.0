Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 583F8C3DA6E
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Jan 2024 19:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mPgSYdyg0vJbc0oY7GHDCNU+QLqplixDcaSjAanyb7k=; b=1A9xAHYFroV6fCWlXrqY3BZlTN
	0Po2POI0Z5ozgOqFqRbwW+eJYXMUkEVZelgiFvAfltKOSUaE/NBwiKwHjSjw4ALsYiZEWn/ZDNmj7
	yI+rvalqhrbNsp/s2pOyI7mnPzAABbaZz+jr+3WPLlQM/BiMoMa4ZMsnRMS1zZ4BOh95rQ3HiZQvA
	bSeAxFM7jI2M2Bac/qQKOKpW3Ja22Nuiuo39UgIFmzZzQRmmfYNWrjeeFxYcMkJRaNl4Lc0Z8d1G/
	cwPmMBNl+SIQfpfONq2xjLWLfMjRN60LtcfWTGupnI1ZEeNZGr+qEXSX5VqFrIE5gpmj7t/IX+gsH
	XlusJY/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rMvKC-00632m-2y;
	Mon, 08 Jan 2024 19:30:16 +0000
Received: from mail-pg1-f171.google.com ([209.85.215.171])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rMvKA-00630Q-2C
	for linux-nvme@lists.infradead.org;
	Mon, 08 Jan 2024 19:30:15 +0000
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5ce07cf1e5dso719610a12.2
        for <linux-nvme@lists.infradead.org>; Mon, 08 Jan 2024 11:30:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704742213; x=1705347013;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mPgSYdyg0vJbc0oY7GHDCNU+QLqplixDcaSjAanyb7k=;
        b=F9ygJn+DZOIpkPyweQqjCFPsLeAsefc56Yh4Px/XdpMQqbBK///eeGUmkQkLHK5NUv
         s7m5mtsRR6WtOtP/HjaIiwyc3PUFmrgy7+CjBpfEhDWOK8jdEDdSgpQOJVPwrbdbmuwH
         kVmH6loHtrXY48PqfwbDtehR4DCNyxF6mHhZne403gZyrv/tAN7a+ZXBYtkG6R6s+Q0W
         0aezuGycNV0IzQKa7rd2aJD2q+5BBTpMU0u2uxhuCdpsPOE+Abbb3VkysliMakTjutmq
         Q72Wh7idscTUo2wnE8iS56HDXYBPGx34xucr5dFrCwtrjy2dwjQHXDE5eaarZi06woNy
         YlDQ==
X-Gm-Message-State: AOJu0YwnINQvkaj9uowp6cDoJ7FSUtJ5S3TVE870gVOmNfQXQXFgrU/X
	pHdlyU5TKG8jYoqvphL++Nk=
X-Google-Smtp-Source: AGHT+IF9dFWPN1tQY/0ojsSkLwZINpIlgjvVcvpzzmGaFhbrOj0bf8qRtWX+L0MtV9ncMN2wK/MWEw==
X-Received: by 2002:a05:6a20:a115:b0:199:31af:9207 with SMTP id q21-20020a056a20a11500b0019931af9207mr1834279pzk.52.1704742213013;
        Mon, 08 Jan 2024 11:30:13 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:fe53:b285:ad53:95e0? ([2620:0:1000:8411:fe53:b285:ad53:95e0])
        by smtp.gmail.com with ESMTPSA id s9-20020aa78d49000000b006d9b2d86bcasm233119pfe.46.2024.01.08.11.30.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jan 2024 11:30:12 -0800 (PST)
Message-ID: <9b46c48f-d7c4-4ed3-a644-fba90850eab8@acm.org>
Date: Mon, 8 Jan 2024 11:30:10 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Large block for I/O
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>,
 Matthew Wilcox <willy@infradead.org>
Cc: Hannes Reinecke <hare@suse.de>, lsf-pc@lists.linuxfoundation.org,
 linux-mm@kvack.org, linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <7970ad75-ca6a-34b9-43ea-c6f67fe6eae6@iogearbox.net>
 <4343d07b-b1b2-d43b-c201-a48e89145e5c@iogearbox.net>
 <03ebbc5f-2ff5-4f3c-8c5b-544413c55257@suse.de>
 <5c356222-fe9e-41b0-b7fe-218fbcde4573@acm.org>
 <ZYUbB3brQ0K3rP97@casper.infradead.org> <ZYUgo0a51nCgjLNZ@infradead.org>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ZYUgo0a51nCgjLNZ@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240108_113014_750922_BE579864 
X-CRM114-Status: GOOD (  15.33  )
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

On 12/21/23 21:37, Christoph Hellwig wrote:
> On Fri, Dec 22, 2023 at 05:13:43AM +0000, Matthew Wilcox wrote:
>> It clearly solves a problem (and the one I think it's solving is the
>> size of the FTL map).  But I can't see why we should stop working on it,
>> just because not all drive manufacturers want to support it.
> 
> I don't think it is drive vendors.  It is is the SSD divisions which
> all pretty much love it (for certain use cases) vs the UFS/eMMC
> divisions which tends to often be fearful and less knowledgeable (to
> say it nicely) no matter what vendor you're talking to.

Hi Christoph,

If there is a significant number of 4 KiB writes in a workload (e.g.
filesystem metadata writes), and the logical block size is increased from
4 KiB to 16 KiB, this will increase write amplification no matter how the
SSD storage controller has been designed, isn't it? Is there perhaps
something that I'm misunderstanding?

Thanks,

Bart.



