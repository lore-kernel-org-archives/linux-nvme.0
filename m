Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA4D6C4345F
	for <linux-nvme@archiver.kernel.org>; Sun, 14 Apr 2024 08:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rODNJ0Ukhp6xqvTSkV55aTTmI0Z+BHUMDDSzoazWTg4=; b=YYrqBW5AeotAfikkOkvC97NkvP
	xTORfvAjQfVsYO/jGRsPBNYk983mhFeK9c5vgKMcuXuHp0q4Yv2xxhCHAKsxN2fwijD390W8xy934
	S/YRZEYdFnMmJ8OgCvd1RPAUHI56zQK6rZrjjVIIH01MBb55UJABeXFzPwUaA6l+KAm7PxQNl9dvD
	rJrTQr36F333LruCx3sFS88r6FgfmSN4mKhinmEkFL/yOn/kr8VeNoWdcFW0PjH3CDZIE1fgGqcdA
	WbDGQs24OWu6oe+JIk8end70R3oy9GeGaswKLUyVL/k2U/PmZ30g+ToRP3xnJ2KEBEkOvzAsL5oLr
	TUxStUlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rvvKN-000000052T0-1zXe;
	Sun, 14 Apr 2024 08:35:07 +0000
Received: from mail-lf1-f53.google.com ([209.85.167.53])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rvvKK-000000052Rv-279I
	for linux-nvme@lists.infradead.org;
	Sun, 14 Apr 2024 08:35:05 +0000
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5176a67d6b5so774684e87.0
        for <linux-nvme@lists.infradead.org>; Sun, 14 Apr 2024 01:35:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713083700; x=1713688500;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rODNJ0Ukhp6xqvTSkV55aTTmI0Z+BHUMDDSzoazWTg4=;
        b=kGYdJwo3PE1RSqNvmqQ3WaC0Ps9kZDPEWUPH6nnEcNr4D+lOZ6UVnjajeZFJjMZsAi
         iBSGiGI0VlGHVZZp/lGK8Ns3cMQ+g7p3o9sb7iVdMNehtD4gg0PLMmusrMM5BWJ/pmSX
         Oog/t1ElC+SZWWmGNr1M5k1PV/PmNayqt+MfaTK1qdwus1WYo8cHvx08zoHDdv7EzwoT
         aZ8S7RbDWW0sQtES5u7ERj5yfddxVEHP2Cuxw3eHyB3w8aFcFnR2Nr3bL1EqIqfzX4Dj
         OyRJ9Z3rKyYgBNb8GqExpA7SWhh7XCsYsQT3GsWo+SSXp9pZPHUT98GRnuZbXk1O4Sln
         zXiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUP/anvNrCXU7bemLIR51Geiy5PkV/pVJsZwTbg7O4p6sC8CDVBM8rNfs0FbbkDxW003lMv8MOwfrdIs39pKEPF9n9Gs3ftpH1rY8Rquj8=
X-Gm-Message-State: AOJu0YwaiFEDRtwltYGIiDK8V/1Yfngj0dECs0mMGklTLAr+lAqEfqCC
	9bD5ewrY7AZvvE2NnJsBmvkpofm6lXYnSeHS+cA6S6z/a8ey03IO
X-Google-Smtp-Source: AGHT+IHUerSoHWBsGEYAfYQTKd/vCWDjdmSOFzRHu8Rk87rKdywP2XPry+/l30vZZvfgcddZaKXuMA==
X-Received: by 2002:a2e:3a18:0:b0:2d4:25c5:df1e with SMTP id h24-20020a2e3a18000000b002d425c5df1emr3891400lja.5.1713083699832;
        Sun, 14 Apr 2024 01:34:59 -0700 (PDT)
Received: from [10.100.102.74] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id gw7-20020a05600c850700b004146e58cc35sm14861616wmb.46.2024.04.14.01.34.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Apr 2024 01:34:59 -0700 (PDT)
Message-ID: <bd345f52-3435-4e40-975d-321f706857be@grimberg.me>
Date: Sun, 14 Apr 2024 11:34:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/6] nvme-fabrics: short-circuit connect retries
To: Keith Busch <kbusch@kernel.org>, Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, James Smart <james.smart@broadcom.com>,
 Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240409093510.12321-1-dwagner@suse.de>
 <ZhiBzXBvjTeDuHbS@kbusch-mbp.dhcp.thefacebook.com>
 <vbptto5zefkdadnpyhcjelfrsgadb2stjh3sole6n6mdd4h7dq@lrdxk5p5qh6w>
 <ZhlSJcTwGVrlk8OP@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZhlSJcTwGVrlk8OP@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240414_013504_586450_69718868 
X-CRM114-Status: GOOD (  16.29  )
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



On 12/04/2024 18:24, Keith Busch wrote:
> On Fri, Apr 12, 2024 at 09:24:04AM +0200, Daniel Wagner wrote:
>> On Thu, Apr 11, 2024 at 06:35:25PM -0600, Keith Busch wrote:
>>> On Tue, Apr 09, 2024 at 11:35:04AM +0200, Daniel Wagner wrote:
>>>> The first patch returns only kernel error codes now and avoids overwriting error
>>>> codes later. Thje newly introduced helper for deciding if a reconnect should be
>>>> attempted is the only place where we have the logic (and documentation).
>>>>
>>>> On the target side I've separate the nvme status from the dhchap status handling
>>>> which made it a bit clearer. I was tempted to refactor the code in
>>>> nvmet_execute_auth_send to avoid hitting the 80 chars limit but didn't came up
>>>> with something nice yet. So let's keep this change at a minimum before any
>>>> refactoring attempts.
>>>>
>>>> I've tested with blktests and also an real hardware for nvme-fc.
>>> Thanks, series applied to nvme-6.9.
>> Thanks! I have an updated version here which addresses some of Sagi's
>> feedback, e.g. using only one helper function. Sorry I didn't send out
>> it earlier, I got a bit side tracked in testing because of the 'funky'
>> results with RDMA.
>>
>> Do you want me to send a complete fresh series or patches on top of this
>> series? I'm fine either way.
> Oh sorry, I didn't notice the discussion carried on after the "review"
> tag. Please send me the update, I'll force push.

I think that what we want is to have a special handling in the very specific
connect failure when the host/ctrl credentials mismatch, because out of all
the reasons to a connection failure, this _could_ be transient.

