Return-Path: <SRS0=yvpF=OW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265ACC433F5
	for <linux-nvme@archiver.kernel.org>; Sat,  2 Oct 2021 22:20:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE0BD61B27
	for <linux-nvme@archiver.kernel.org>; Sat,  2 Oct 2021 22:20:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AE0BD61B27
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rAcaYpwgEEliMJIZt7ulelonWUJP0BGJoXVN9VbZGV0=; b=nA6n520iCdWZAcXdSEMXg9yXy8
	N31XWfgkAXQ+JWlp1xutXKq9ybMEw3oHD6HMd+wxbkPHsT9Ub0JX5lU/w3D4lH11K8qBx2baph2it
	yZ1tY958os7/jORwMWAJmpYWTnYfYA5YVOcR1SREwfK9YZQCrFrpQarn0+o112MzZ9pTWXAG4e4ch
	IbAN9ZhDrdZjAiKgTexu8chZS6buYCJN+tsX9WaeLmuQZbVE7Fzfr7BlJ3nIXHCAlUvYiHOfh3Iw7
	bX4ZqjPAxC2wRvmUEKPi6k5IWBstcpo4iBLK1Y3n/ENvKI04d+/zKDoMtg9L31iqzMYi8jrDuXCEM
	cesRXzug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mWnMF-002pEY-Lu; Sat, 02 Oct 2021 22:19:51 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mWnLw-002pE3-Nl
 for linux-nvme@lists.infradead.org; Sat, 02 Oct 2021 22:19:34 +0000
Received: by mail-wr1-f50.google.com with SMTP id o20so3851117wro.3
 for <linux-nvme@lists.infradead.org>; Sat, 02 Oct 2021 15:19:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=89tXh8o7/0KtBldzOPuCdBrBw5c0oa+M5SA3mDPcjDo=;
 b=T5b9wE7g50vr2Padt+X8lwPIwMxkp5aKIfeIUn8SIdkVItoroGARsNp4N91ocheL2Z
 qmTymyV4Fx5nyZevglOok9GPpni67p8ZK2BH0oiKW9ZwvqebKd6RT+xqIoZvgDOx/jYi
 o4EnYqi4qBbjWIlUH3O7IqGxEz6l4gjf/2jzkyexXNEaJ3FLCjNGQZiyLPYaw2cNJcem
 vjnsWmg5wBcJ+sLo5wF39lCpd/7ObLEjYyIAZD67SH7YDLC5UJgrVTm6jyoMeuSv91rw
 UGXcoObgMOEGBkTK4iuzSlvU+4NmyS/RjJe1x9G4YK4UahnuRv5j1jsn9LhjzMU1OzCO
 HUTQ==
X-Gm-Message-State: AOAM53108fJBpmdXa60AhX3iIerZPCR8yrBs0T/r36M9D0dMWQsrP8Gj
 nGSmSFN8LVxWUWfQ+vPucdxMsQZrsl0=
X-Google-Smtp-Source: ABdhPJynpwxtAHXjk4J/xRN27mBxckYaYC2gpTYHZvHn672SaIl2tUVg59hqfZQwzwvHVNBbLyFTVw==
X-Received: by 2002:adf:a45c:: with SMTP id e28mr5318658wra.347.1633213170506; 
 Sat, 02 Oct 2021 15:19:30 -0700 (PDT)
Received: from [10.100.102.14] (109-186-240-23.bb.netvision.net.il.
 [109.186.240.23])
 by smtp.gmail.com with ESMTPSA id v6sm1851138wrd.71.2021.10.02.15.19.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 02 Oct 2021 15:19:30 -0700 (PDT)
Subject: Re: [PATCH] nvme-tcp: fix incorrect h2cdata pdu offset accounting
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
References: <20210914153855.16177-1-sagi@grimberg.me>
 <20210928204052.GA390773@dhcp-10-100-145-180.wdc.com>
 <d969a4b7-4d3c-9df7-5a7d-9700bff37d50@grimberg.me>
 <20210930201510.GA94540@C02WT3WMHTD6>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <0dedfd62-d61b-cfe3-8b5f-13c213323b46@grimberg.me>
Date: Sun, 3 Oct 2021 01:19:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210930201510.GA94540@C02WT3WMHTD6>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211002_151932_814257_0CB26636 
X-CRM114-Status: GOOD (  21.22  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>>> When the controller sends us multiple r2t PDUs in a single
>>>> request we need to account for it correctly as our send/recv
>>>> context run concurrently (i.e. we get a new r2t with r2t_offset
>>>> before we updated our iterator and req->data_sent marker). This
>>>> can cause wrong offsets to be sent to the controller.
>>>>
>>>> To fix that, we will first know that this may happen only in
>>>> the send sequence of the last page, hence we will take
>>>> the r2t_offset to the h2c PDU data_offset, and in
>>>> nvme_tcp_try_send_data loop, we make sure to increment
>>>> the request markers also when we completed a PDU but
>>>> we are expecting more r2t PDUs as we still did not send
>>>> the entire data of the request.
>>>>
>>>> Fixes: 825619b09ad3 ("nvme-tcp: fix possible use-after-completion")
>>>> Reported-by: Nowak, Lukasz <Lukasz.Nowak@Dell.com>
>>>> Tested-by: Nowak, Lukasz <Lukasz.Nowak@Dell.com>
>>>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>>>> ---
>>>> - Keith, can you ask the WD team to test this as well?
>>>
>>> I finally have some feedback on testing, and it looks like this patch
>>> has created a regression. The testers are observing:
>>>
>>>     [Tue Sep 28 02:12:55 2021] nvme nvme6: req 3 r2t len 8192 exceeded data len 8192 (4096 sent)
>>>     [Tue Sep 28 02:12:55 2021] nvme nvme6: receive failed:  -71
>>>     [Tue Sep 28 02:12:55 2021] nvme nvme6: starting error recovery
>>>
>>> Which we had seen before, and you fixed with commit:
>>>
>>>     https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=825619b09ad351894d2c6fb6705f5b3711d145c7
>>>
>>> I only just recently heard about this, so I haven't looked into any
>>> additional possible cause for this regression yet, but just wanted to
>>> let you know earlier.
>>
>> Yes I definitely see the bug... Damn it..
>>
>> The issue here is that we peek at req->data_sent and req->data_len
>> after the last send, but by then the request may have completed
>> and these members were overwritten by a new execution of the
>> request.
>>
>> We really should make sure that we record these before we perform
>> the network send to avoid this race.
>>
>> Can you guys check that this restores the correct behavior?
> 
> Unfortunately this was unsuccessful. The same issue is still occuring. Please
> let me know if you have another patch to try. I'll also keep looking for a
> solution as well.

Really? That's unexpected, this patch should ensure that the request
is not advanced after the last payload send. The req->data_sent and
req->data_len are recorded before we actually perform the send so
the request should not be advanced if (e.g. last send):
	(req_data_sent + ret == req_data_len)

So I'm surprised that the same issue is still occurring.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
