Return-Path: <SRS0=mQhi=PX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F91BC433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Nov 2021 13:00:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A02B60EDF
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Nov 2021 13:00:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4A02B60EDF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n6+r1tSzsN9GXH/50geoCfOUXyJ+pR9OYyaVCDXWowQ=; b=yJInrI+wp/ZqJpmVsfVbdxYZDh
	tttoCrNbg4m7Uwg7IwfbX2X+R7c6IK/MemO8pEXv4fsff35FJOJeifAit9xTDxKJiAq1zrzb8/hfv
	L/b7bMlaW+1H4Am/KQkPfg1eqTkC2ejwaihM0AVTEIj7DvP0IoaS9p0cEykU7GlgvxYCzmn4/zx2a
	lBCIyCdZAz4NCxz70jKDpKZXe/Z6GwXlCgBXZ5Wp9oGZOXCFw1cFKwQ2Ixk69LC6iuAgeyNQkTOVC
	/Q4Si3kbN7vKEO0OGVtGZMWm71e7DXa9uGRROBgtdyQObhcN3ZkSHROHh09xRs11up2z6SSX6QFhg
	DZ4ntlbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1micLY-008xKa-A1; Thu, 04 Nov 2021 13:00:00 +0000
Received: from mail-ed1-f51.google.com ([209.85.208.51])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1micLU-008xJi-SB
 for linux-nvme@lists.infradead.org; Thu, 04 Nov 2021 12:59:58 +0000
Received: by mail-ed1-f51.google.com with SMTP id f4so20848752edx.12
 for <linux-nvme@lists.infradead.org>; Thu, 04 Nov 2021 05:59:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=n6+r1tSzsN9GXH/50geoCfOUXyJ+pR9OYyaVCDXWowQ=;
 b=01QAPzwD6tRDCdaThcdvCaIqCCGAM+bGIHCmEimy/zWfDYuyaVyEtgze/NF28E+a7+
 TEpD4qIkkkLnFU2L3gzWIK+2/xjfM7eGhnX3Q8niLz4Dc8M/wctk2kjIAiC0YdhcEHc5
 pMuBS6rpjwpJP06X8bjZvgzbYoQq0Hlen+AhQu1h4HBBjyWYu/WvALCiQwXOoeO/JdV4
 8ykqXlFVoPmWEEMMPE3uighrBEn774j9iAsPSmiZxP9k2Hv65kpkn87GCOezMdbveT7b
 QN8Jr5kWfyNzAcKK7wvD/VbEQj2CuP3HznxOeiep/ghOLLJbqfVoubbP0ExR9i8pcpli
 Xx4Q==
X-Gm-Message-State: AOAM5323kHKDfaWiHje9PS/cV4hqviXA1XsP8nHOSdnYcOwY9NEOyvgX
 ggZbmumGFLycXYGM9hzXGcY=
X-Google-Smtp-Source: ABdhPJxSGRJ33n8D1hqAXbnugoXvQU+q7EE+Zh7rgeNi6eRR34QdnvNouqn2SzA1MTLD+LoNI3la7g==
X-Received: by 2002:a17:906:a4e:: with SMTP id
 x14mr61123878ejf.1.1636030795254; 
 Thu, 04 Nov 2021 05:59:55 -0700 (PDT)
Received: from [10.100.102.14] (109-186-251-144.bb.netvision.net.il.
 [109.186.251.144])
 by smtp.gmail.com with ESMTPSA id k9sm2785129edo.87.2021.11.04.05.59.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Nov 2021 05:59:54 -0700 (PDT)
Subject: Re: [PATCH 2/2] nvmet: fix a race condition between release_queue and
 io_work
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, hare@suse.de,
 chaitanya.kulkarni@wdc.com, jmeneghi@redhat.com
References: <20211021084155.16109-1-mlombard@redhat.com>
 <20211021084155.16109-3-mlombard@redhat.com>
 <54e0464e-0d05-4611-10d9-7b706900af28@grimberg.me>
 <20211028075531.GA4904@raketa>
 <68b69eee-c08c-a449-7e18-96e67a3c0c9d@grimberg.me>
 <20211103113125.GA106365@raketa>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <24a4036b-4f11-91f4-ee0e-80a43f689b09@grimberg.me>
Date: Thu, 4 Nov 2021 14:59:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211103113125.GA106365@raketa>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211104_055956_949491_FE6C358D 
X-CRM114-Status: GOOD (  21.75  )
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


>> So this means we still get data from the network when
>> we shouldn't. Maybe we are simply missing a kernel_sock_shutdown
>> for SHUT_RD?
> 
> Hmm, right, kernel_sock_shutdown(queue->sock) is executed in
> nvmet_tcp_delete_ctrl() and sock_release(queue->sock) is called
> in nvmet_tcp_release_queue_work(), so there could be a race here.
> 
> I will try to move kernel_sock_shutdown(queue->sock) in nvmet_tcp_release_queue_work()
> and test it.

Not move, but perhaps add another SHUT_RD call.

> 
>>
>>>
>>>>
>>>>> * Fix this bug by preventing io_work from being enqueued when
>>>>> sk_user_data is NULL (it means that the queue is going to be deleted)
>>>>
>>>> This is triggered from the completion path, where the commands
>>>> are not in a state where they are still fetching data from the
>>>> host. How does this prevent the crash?
>>>
>>> io_work is also triggered every time a nvmet_req_init() fails and when
>>> nvmet_sq_destroy() is called, I am not really sure about the state
>>> of the commands in those cases.
>>
>> But that is from the workqueue context - which means that
>> cancel_work_sync should prevent it right?
> 
> 
> But nvmet_sq_destroy() is called from the release_work context,

Yes

> we call cancel_work_sync() immediately after but we can't be sure
> that the work will be canceled, io_work might have started already and
> cancel_work_sync() will block until io_work ends its job, right?

Right, after the call to cancel_work_sync we will know that io_work
is not running. Note that it can run as a result of a backend completion
but that is ok and we do want to let it run and return completion to the
host, but the socket should already be shut down for recv, so we cannot
get any other byte from the network.

