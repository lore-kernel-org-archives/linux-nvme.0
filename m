Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA58BC6FD1C
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Mar 2023 12:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GBQh/e32RGe9v9WGlCa+SOrd9E3q84+zj4tZ8nuIydc=; b=SLIA2bER+jnQ/kIMZN+hhPGWXP
	ZHWzpU3iNcrCXQkH+dIXp5vJctgyu3c4kLvQzEw2AwBn+VX8xCtpnCgxnWkolbT/mrIhG4ytZ7bC6
	l1fHaMLXGBt5dlSl6yNKWhEAhyl8C4s4kfCZgfcOqh5FVR3Jx8qcLb11wWza6EC3dYBiMU2h+zMN4
	JBD5DssjHVSR/d9KlozBro/9u54QwDCknB9guE/TGIPF+8HDOEUnHHh0E27ULavHMAlWJqydI1tsc
	3/IFJ1vv0PHDG5H9tGbib0VCgNJYoKnZcXPUrWqhIZUmQJs71xBID4mJlHslTxs4l/8dU09VQMhFa
	uBhb3H0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pexyA-00G1Ny-32;
	Wed, 22 Mar 2023 12:53:34 +0000
Received: from mail-wm1-f48.google.com ([209.85.128.48])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pexy8-00G1NC-0r
	for linux-nvme@lists.infradead.org;
	Wed, 22 Mar 2023 12:53:33 +0000
Received: by mail-wm1-f48.google.com with SMTP id r19-20020a05600c459300b003eb3e2a5e7bso11434266wmo.0
        for <linux-nvme@lists.infradead.org>; Wed, 22 Mar 2023 05:53:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679489610; x=1682081610;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GBQh/e32RGe9v9WGlCa+SOrd9E3q84+zj4tZ8nuIydc=;
        b=jASTPoAz8uDxOAwfLZs0a1rHcliqI/eaHYZdtusAou3uDQXBWkL7bBS9WxYexeG/E9
         1b1xC8+RCSKkX31bgsg7ayG9rZmkTmvWbE86eRKGnekg0HNVQVM9pEHb6ap8v6gsEhrj
         bw/CXAVyawdvzzcIJeGA4WaFxagl+guVsMMA34AOt1p19Wchstbk2Fjh1Z+wPOEzEjjQ
         AQkS7VukZeiz6EZJbYClaacXNR53k6W5IyOYQsThLuQ2xijA3lubK5hsiMHLDG0ca1+V
         y4MGZ3kyL4xDwCtqUXkCxXaZNLNL+/jCsRzNQ8PTw53H3XS2wQFqHWjzaaLep5pU5cM+
         4Eaw==
X-Gm-Message-State: AO0yUKVIlixoBt5uf1eRRID8Eb6IEdyMiBW0iH/l0TFYfbG48ITcJcna
	sqEwB8hB/+euEY5TYxamRM0=
X-Google-Smtp-Source: AK7set/sHCiN0T0QIuyoA7Zr05W3132oqLlW19kbV9EId9352YrqIurcnzsWZJuRvlHgI2tIqpfl9g==
X-Received: by 2002:a05:600c:3b90:b0:3ee:52fb:6dd9 with SMTP id n16-20020a05600c3b9000b003ee52fb6dd9mr2686853wms.4.1679489610394;
        Wed, 22 Mar 2023 05:53:30 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id n23-20020a7bcbd7000000b003ed243222adsm16504786wmi.42.2023.03.22.05.53.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 05:53:30 -0700 (PDT)
Message-ID: <c2b69576-19ce-b39f-0ff6-1e5f6c143b40@grimberg.me>
Date: Wed, 22 Mar 2023 14:53:28 +0200
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
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <c90f39ed-1bcc-7a8f-fd2d-ee4663e94bb4@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_055332_303735_025FE0C3 
X-CRM114-Status: GOOD (  12.24  )
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


>>>>> Hi all,
>>>>>
>>>>> finally I've managed to put all things together and enable in-kernel
>>>>> TLS support for NVMe-over-TCP.
>>>>
>>>> Hannes (and Chuck) this is great, I'm very happy to see this!
>>>>
>>>> I'll start a detailed review soon enough.
>>>>
>>>> Thank you for doing this.
>>>>
>>>>> The patchset is based on the TLS upcall mechanism from Chuck Lever
>>>>> (cf '[PATCH v7 0/2] Another crack at a handshake upcall mechanism'
>>>>> posted to the linux netdev list), and requires the 'tlshd' userspace
>>>>> daemon (https://github.com/oracle/ktls-utils) for the actual TLS 
>>>>> handshake.
>>>>
>>>> Do you have an actual link to follow for this patch set?
>>>
>>> Sure.
>>>
>>> git.kernel.org:/pub/scm/linux/kernel/git/hare/scsi-devel.git
>>> branch tls-netlink.v7
>>
>> I meant Chuck's posting on linux-netdev.
> 
> To be found here:
> 
> <https://www.spinics.net/lists/netdev/msg890047.html>

Nice, it would be great to see code, if you have it, for nvme-cli and/or
nvmetcli as well.

