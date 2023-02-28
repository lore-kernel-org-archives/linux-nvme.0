Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEB56C64EC7
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Feb 2023 08:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0guNErct7/1yTAJGBCGWn62sdzg7Fin9ZNo8MlFXzNk=; b=O/5NqNKVCXsCT/wx7ePuzEaF5U
	pFWMS2JgzTltSKf2BTnta1CMlWx0e/q7XibzxVQCPqje5m/cvKTPBQnxCVTQe8iyxYx+ObhzcgE+N
	4BwMnDiIe+FupxssJPshdjY7VBFTwD1G0fzPdeMW6xqkN/IEcMHeuWwU1n5FNsQrZEDqASOrqXbZk
	s/kXWj8e/UUgmIGl7n9TZEhoqxFrdn/vp8puNQ1WAepzYNqOlefp+wL0S/Ot1bAr3+Zh0OyCf5k0h
	tDIb1ZdSa4yZpOd73EQR2BUj+GySYgqiVpNo7+uXPXWAXmtjzV6bzwtCVqmgDovvmaGioxc13D3kv
	a4iCmk7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pWuzN-00CKjr-QI; Tue, 28 Feb 2023 08:05:33 +0000
Received: from mail-ed1-f46.google.com ([209.85.208.46])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pWuzI-00CKif-7r
	for linux-nvme@lists.infradead.org; Tue, 28 Feb 2023 08:05:29 +0000
Received: by mail-ed1-f46.google.com with SMTP id h16so36231649edz.10
        for <linux-nvme@lists.infradead.org>; Tue, 28 Feb 2023 00:05:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677571523;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0guNErct7/1yTAJGBCGWn62sdzg7Fin9ZNo8MlFXzNk=;
        b=tYoeMaKMwAXfNJ++twO51ojOJWSCsjERRMVSlalHB7VVi7SZ/84vhxjLKg0TQlVDnA
         EirFGDlOiGHaTFoymjQvvV1NihDAKpsk37FHdFIXf0qSbvHaX3rCd2qOR8WNIVVnkSB8
         5NOoEIJSN71GumnF6YKgc0raWA/Uclbdm9UncvEvqGgFfFHiJfG4TwmbGqf7oPAgtVEg
         20EYxzXSyyegFwryiqRZA/mOBuDCW3RFz3Na04fFFihTLJ9d7s7p890nsNJ1Hdo72UIu
         saiLoFFhlEAygOpO4sUAhNrYBHTyEGKvNC0qQxEOzbDvE31ilsIcIMOOs/kJjtdKfgC5
         fRyw==
X-Gm-Message-State: AO0yUKUkGrZ7wJgqzLcMo6bjcQi6G9BR9fZmDCy9pqPYZZftmqGOLuho
	iuj673b2q2aqW/U04ruEhgI=
X-Google-Smtp-Source: AK7set+c7o0xjmPWudHmmkUqfo5PvjF0F5NViP/fOHyF3G/zLvjuTOYbHp4mz1meRuScW5Q7gKs7UA==
X-Received: by 2002:a05:6402:268e:b0:4af:593c:c09b with SMTP id w14-20020a056402268e00b004af593cc09bmr2472874edd.0.1677571523749;
        Tue, 28 Feb 2023 00:05:23 -0800 (PST)
Received: from [10.100.102.14] (85-250-17-149.bb.netvision.net.il. [85.250.17.149])
        by smtp.gmail.com with ESMTPSA id d17-20020a056402401100b004aee4e2a56esm4016076eda.0.2023.02.28.00.05.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 00:05:23 -0800 (PST)
Message-ID: <bffe500a-24b9-eaa7-71f2-891be21c7ed5@grimberg.me>
Date: Tue, 28 Feb 2023 10:05:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [LSF/MM/BPF BOF] Userspace command abouts
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, "hch@lst.de" <hch@lst.de>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 "dgilbert@interlog.com" <dgilbert@interlog.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "lsf-pc@lists.linuxfoundation.org" <lsf-pc@lists.linuxfoundation.org>
References: <ad837a26-948a-c690-cd9e-4dfffb5f990d@grimberg.me>
 <57d8dff9-2fdb-8198-6cdc-7265797a704a@interlog.com>
 <23526cf9-d912-59a7-4742-6003d6ccfd45@grimberg.me>
 <Y/Yscr82hqdKl1Hw@kbusch-mbp.dhcp.thefacebook.com>
 <561afa67-04d0-c675-6bbb-048313da152b@grimberg.me>
 <73b4dd39-9ce8-9b55-8a1d-06865f3bde32@nvidia.com>
 <Y/lpmrwuehnsWmmR@kbusch-mbp.dhcp.thefacebook.com>
 <0fe59301-65e6-d8a9-033e-0243ad59c56b@opensource.wdc.com>
 <316431ed-1727-7e80-2090-84ac5b334f74@grimberg.me>
 <3ea301b1-c808-ce08-8ec8-3a631b385fb9@suse.de>
 <Y/zsE9i7012Ivwe1@kbusch-mbp.dhcp.thefacebook.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <Y/zsE9i7012Ivwe1@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230228_000528_314449_D9E26E33 
X-CRM114-Status: GOOD (  13.30  )
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


>>> I'm not up to speed on how CDL is defined, but I'm unclear how CDL at
>>> the queue level would cause the host to open more queues?
> 
> Because each CDL class would need its own submission queue in that scheme. They
> can all share a single completion queue, so this scheme doesn't necassarily
> increase the number of interrupt vectors.

Ah, that is less desirable I think, Although we can already do
multiple queue maps, I think that the proliferation of queues is
harmful in the long run.

>>> Another question, does CDL have any relationship with NVMe "Time Limited
>>> Error Recovery"? where the host can set a feature for timeout and
>>> indicate if the controller should respect it per command?
>>>
>>> While this is not a full-blown every queue/command has its own timeout,
>>> it could address the original use-case given by Hannes. And it's already
>>> there.
>> I guess that is the NVMe version of CDLs; can you give me a reference for
>> it?
> 
> They're not the same. TLER starts timing after a command experiences a
> recoverable error, where CDL is an end-to-end timing for all commands.

Ah, ok. I didn't realize that TLER starts after an error.

