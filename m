Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7670BC6FD1C
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Mar 2023 15:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=suxlETsiUUstEeIIOtW+butzcDb1YEUR9bU5l0vZ7v8=; b=szSfSuok7QYyEboAo98gz4XsJT
	lkgayTDDjQ9sdLo81kTDrUx9vXqRTXUE9sFI4T8e85qSe9KoDO3qekgxStqhUL9pm/I8f2Q4LuJpm
	CCm8JzuCKNBzlwTmLwRGB1ZTxQZZ/5eZmjRqxuEo2EpfL4rdQClQMAXuAOR/htzK/j/I06ulUS/aZ
	ohjPEZYYjuAFb1kdQtQCyl5KWbjlsWeY+arlNZktsX3wYrDZQaA3RNhLysEIA19fJS+C6KlVm6cKR
	ABINDtBVQoL8znSNkBGfJs1X+yf6Vum0fVp2ocYNOeILgtLyI2yLyFyyb9ELqNdQERodwz/ryr2W5
	dEMY78ow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pf0cR-00GXgY-1l;
	Wed, 22 Mar 2023 15:43:19 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pf0cP-00GXfU-1d
	for linux-nvme@lists.infradead.org;
	Wed, 22 Mar 2023 15:43:18 +0000
Received: by mail-wm1-f53.google.com with SMTP id u11-20020a05600c19cb00b003edcc414997so6923629wmq.3
        for <linux-nvme@lists.infradead.org>; Wed, 22 Mar 2023 08:43:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679499793; x=1682091793;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=suxlETsiUUstEeIIOtW+butzcDb1YEUR9bU5l0vZ7v8=;
        b=AfFCj3PhuI/2rWR/TVLKLtTR1gelJMWo9FDD4WhauBhAgYBgrVoqiHkFrZJVTpXA2t
         FurkAUXKEe6wLxuCnkfgRK55y3LnNlt4a36LQy36+b55ommeSR9Cwao9hsLmPEqtfyqg
         OYZUxuMg7hN3Ac6JgFHUHQeYCpnNlRBbek2TZaujJ1n/rvNHlTvieTZkQqe1XJ0PHwht
         6YDYYSSv4EKkpGpefFFSiUnhpbGtojm1OsjosWG530FG/iBQRBffDfLB34BUJQXAsRSv
         YzkjIHhKWNiUI7YFEuynkRHIxRuDDHSE++EJ37Q0BxFHjo8d8Wh1Bp4iDM1TC8QDyLsE
         vyQw==
X-Gm-Message-State: AO0yUKUTOqz4xouJLBX8CAMWIUycswvfv4Nrss45FFaPUuRdTji+V+Pq
	nxfZ6L0ZqrnDWVuIxm733b0=
X-Google-Smtp-Source: AK7set9faYtwodnXHEpRE7JF1cgnlftbDh34WlKE8E9X6c9u7j0JCl5cyHTw1onWCe50C8cCsm3jfA==
X-Received: by 2002:a05:600c:46c4:b0:3eb:2e2a:be95 with SMTP id q4-20020a05600c46c400b003eb2e2abe95mr6676349wmo.2.1679499793209;
        Wed, 22 Mar 2023 08:43:13 -0700 (PDT)
Received: from [10.100.102.14] (85.65.206.11.dynamic.barak-online.net. [85.65.206.11])
        by smtp.gmail.com with ESMTPSA id v10-20020a05600c470a00b003ee11ac2288sm8192063wmo.21.2023.03.22.08.43.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 08:43:13 -0700 (PDT)
Message-ID: <9f3feb6c-6bb9-2293-df4c-41ddcb3bf99f@grimberg.me>
Date: Wed, 22 Mar 2023 17:43:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH 00/18] nvme: In-kernel TLS support for TCP
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chuck Lever <cel@kernel.org>, kernel-tls-handshake@lists.linux.dev
References: <20230321124325.77385-1-hare@suse.de>
 <98884644-99f3-7b3c-387a-66fbdd98d4ed@grimberg.me>
 <f9630511-d843-89fe-64db-1a4c41dbbd08@suse.de>
 <d57b8847-b57e-487d-cf90-c63f86716d6a@grimberg.me>
 <c90f39ed-1bcc-7a8f-fd2d-ee4663e94bb4@suse.de>
 <c2b69576-19ce-b39f-0ff6-1e5f6c143b40@grimberg.me>
 <363f4965-87a0-829b-8556-1bc5006e916f@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <363f4965-87a0-829b-8556-1bc5006e916f@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_084317_542882_446130A5 
X-CRM114-Status: GOOD (  15.92  )
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


>>>>>>> Hi all,
>>>>>>>
>>>>>>> finally I've managed to put all things together and enable in-kernel
>>>>>>> TLS support for NVMe-over-TCP.
>>>>>>
>>>>>> Hannes (and Chuck) this is great, I'm very happy to see this!
>>>>>>
>>>>>> I'll start a detailed review soon enough.
>>>>>>
>>>>>> Thank you for doing this.
>>>>>>
>>>>>>> The patchset is based on the TLS upcall mechanism from Chuck Lever
>>>>>>> (cf '[PATCH v7 0/2] Another crack at a handshake upcall mechanism'
>>>>>>> posted to the linux netdev list), and requires the 'tlshd' userspace
>>>>>>> daemon (https://github.com/oracle/ktls-utils) for the actual TLS 
>>>>>>> handshake.
>>>>>>
>>>>>> Do you have an actual link to follow for this patch set?
>>>>>
>>>>> Sure.
>>>>>
>>>>> git.kernel.org:/pub/scm/linux/kernel/git/hare/scsi-devel.git
>>>>> branch tls-netlink.v7
>>>>
>>>> I meant Chuck's posting on linux-netdev.
>>>
>>> To be found here:
>>>
>>> <https://www.spinics.net/lists/netdev/msg890047.html>
>>
>> Nice, it would be great to see code, if you have it, for nvme-cli and/or
>> nvmetcli as well.
> 
> PR for libnvme: PR#599
> PR for nvme-cli: PR#1868
> 
> which is just for updating 'nvme gen-tls-key' to allow the admin to 
> provision 'retained' PSKs in the kernel keyring.
> 
> For nvmetcli we actually don't need an update; everything works with the 
> existing code :-)

Can you send these patches together with the next round of submission?

