Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92367C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Jan 2022 06:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Sse1WxrHGIECJIb/N5nUnkyrKIKOvUIn7elJq2OSQuI=; b=RnK6QlyIas7iCtVT1K1IfYa+32
	dG0t8cAb4QDKo44xhtwHYqyaZuM2PjvYbn2DfGD/I24OqpRdJUToBdSZ0sgeuxWMEBXZNbAzZWNOj
	dwg6VNR+zRt+Q5RZKKaIs1ELTTcas6b5OTASgJ1eEyYFUe6l63lJJRg9TXTHJ+nq+PGzsHFoh856R
	VeQR4xLhKyCSvIwsvbYAxBzf/+KMHyPH/KEUFBCcVd6zayK9D7PqJgGDd4d8NLghY8zWNHC5BSW04
	yoxL9v4MITBKVLijB2zNKCvmEyVSdvNNZvDTly0JPx5NM6mTwpjloLsRA/W/m7ChOE9vwXKhcZ7/c
	y8ZF38iA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nA4Xm-003yDQ-Ir; Wed, 19 Jan 2022 06:34:06 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nA4Xi-003yBX-5R
 for linux-nvme@lists.infradead.org; Wed, 19 Jan 2022 06:34:04 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 h206-20020a1c21d7000000b0034d95625e1fso3837772wmh.4
 for <linux-nvme@lists.infradead.org>; Tue, 18 Jan 2022 22:34:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Sse1WxrHGIECJIb/N5nUnkyrKIKOvUIn7elJq2OSQuI=;
 b=D+xfk03CUSWKH8K7qqLv0NdPAXOVSGW2Q8a07LW9PxPs1yE6K6erf52xEGagNfNKUD
 CbeDzqDpn6IF5o+TM49Hh1JvBuOJ2tio3KDAgm7RQLxv3/4HJC6Zbmutmh2YXheRjpU8
 vU9PpISLjiBTpnIRxzMCHBaOzv5en07m6eZS5uCylB6PwbjWDtYJGcVmWz+Nnt4q6Yqu
 MDfvpqVzY0oiUyZ13a5vM20ICjCspI5F33JUDSRntJvMDjuhpS/LTzR/XqDUtTZAD4ve
 vJNu7mzJi2qCCgN5dIzMxUewrkzmquRXGyUrZT7BuXR/ipL8QS64DDET0kTOh9CMfswR
 zu7A==
X-Gm-Message-State: AOAM531HEzAasR8uQSUoCimSDCVs6WZZIH/5UBLjg0Lqz4MwXOSBzlNC
 fiGs0jKpG9qxulS9jFU4IWwWyoV40LA=
X-Google-Smtp-Source: ABdhPJwws82c281/120i0c3CnFj4mBbmP59qP9GnQ/OwYIeWhoE3HgJMddKNGmP4BbPzheqrqCddmA==
X-Received: by 2002:a05:6000:1a8c:: with SMTP id
 f12mr23549509wry.352.1642574039791; 
 Tue, 18 Jan 2022 22:33:59 -0800 (PST)
Received: from [10.100.102.14] (85.65.248.190.dynamic.barak-online.net.
 [85.65.248.190])
 by smtp.gmail.com with ESMTPSA id s84sm1670423wme.15.2022.01.18.22.33.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jan 2022 22:33:59 -0800 (PST)
Subject: Re: ncme-tcp: io_work NULL pointer when racing with queue stop
To: Chris Leech <cleech@redhat.com>
Cc: linux-nvme@lists.infradead.org
References: <CAPnfmXLsLwUKU_OdELsxy9gkR+21yTHFst0KUqb-c6Zd7OyB_A@mail.gmail.com>
 <0617b76f-6335-5dbf-9f9e-ba5151651e5b@grimberg.me>
 <CAPnfmXKEeTrQ2KH-UwM1V-vkAqk6KVxu9iZ5n2EpisJmY5eVkw@mail.gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <0ff519b9-9248-1f88-7117-ace764e18f64@grimberg.me>
Date: Wed, 19 Jan 2022 08:33:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAPnfmXKEeTrQ2KH-UwM1V-vkAqk6KVxu9iZ5n2EpisJmY5eVkw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220118_223402_243227_41E56ADF 
X-CRM114-Status: GOOD (  23.63  )
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


> On Tue, Jan 18, 2022 at 3:32 PM Sagi Grimberg <sagi@grimberg.me> wrote:
>>
>>> Hi,
>>
>> Hey Chris,
>>
>>> I'm looking at a reported NULL pointer fault with controller reset
>>> testing under load
>>
>> Just to understand, is this upstream kernel?
> 
> This was a CentOS Stream 9 kernel, which should be largely in sync
> with upstream currently.

Understood, can you perhaps share a reference to the bug report?

>>> and it appears that the nvme_tcp_stop_queue
>>> sequence is racing against scheduled io_work.  The fault occurs when
>>> kernel_sendpage is called from the workqueue context and hits a NULL
>>> sock->ops pointer, which is cleared by kernel_sock_shutdown before the
>>> call to cancel_work_sync.
>>
>> Hmm, can you point me to where kernel_sock_shutdown is clearing
>> sock->ops? The assumption that nvme-tcp takes is that accessing
>> the socket is not allowed only after sock_release() but
>> still valid after kernel_sock_shutdown.
> 
> Looks like I need to apologize Sagi.  I'm not sure where I got turned
> around looking at the socket code, but you're right and
> kernel_sock_shutdown doesn't look to be the culprit here.
> 
> Thank you for the following detailed description. I'm going to go back
> to my crash report and take another look at this one.

No worries Chris, perhaps I can assist.

Is the dmesg log prior to the BUG available? Does it tell us anything
to what was going on leading to this?

Any more information about the test case? (load + controller reset)
Is the reset in a loop? Any more info about the load?
Any other 'interference' during the test?
How reproducible is this?
Is this Linux nvmet as the controller?
How many queues does the controller have? (it will help me understand
how easy it is to reproduce on a vm setup)

Cheers,
Sagi

