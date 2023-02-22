Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D40E4C636D6
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Feb 2023 14:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YPaNPqJ7NTdhLdoefSDD/2tnPkQZdBqEzt2HHI6VRiE=; b=2Q1L0ZehNd1pwH5S4IqnXhCrmX
	AkC92OeLSyIt1d5GhuxlfeGUBBCe1EAFZYcHeaKIR66fnbCCxybJ9tmDGKw9hJYBH5WBumcWFSHNm
	CwxwZWcoW9/1T06TdXFKNnRWr0G/W9ilbK5g774yjOEo6igdqKtDK6TgKlACPiYk7ZEeTG3CHWDv3
	BtWM0fzuncudA+zQ2McZ9P7fTjTRJvFNiX20HoErPsW2cvgL/0anXPKe+2rxqKtNjxvUcCtiuASXB
	LA2YlZn50RsdWUbFn53tXc2E+tu1Koa3BgP8VJSdSNBow+JU3o8IcYaCic4mOjuXUpyWo+nf2wHvg
	WfstSDmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pUqFt-00CheY-KF; Wed, 22 Feb 2023 14:38:01 +0000
Received: from mail-wm1-f41.google.com ([209.85.128.41])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pUqFr-00Chdb-E1
	for linux-nvme@lists.infradead.org; Wed, 22 Feb 2023 14:38:00 +0000
Received: by mail-wm1-f41.google.com with SMTP id p26so5853267wmc.4
        for <linux-nvme@lists.infradead.org>; Wed, 22 Feb 2023 06:37:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YPaNPqJ7NTdhLdoefSDD/2tnPkQZdBqEzt2HHI6VRiE=;
        b=UTxmh/PM22c+ZPZDilD4+e4/0Vfgt8lk2OoiF3oYba7Leze4GG819OoZMDD1Nwdzct
         Dx+afFaDenMi++A5WM4TYLuhEFqTs4rgJLhUBT5Kl+sym6iLbi5+lZjAVp1ctU5z5WOo
         jlNJzKpblYk5cTMxvkCs5k6Q+Q1bQnO1Xkgu6U0eG5rfd48wasgBhORtQtgNylPHOum/
         t6LTeYu18QTdjSX8V+gOIl0u6ZU3xEP1Mu4/C4dHbtxZtrFBp27pr2MXIpI6q63vGXcR
         O/sCuLRPaUXDOEw1iKwImsQAzUjyG9jNP78VK2K+B821Lzdy/vQ4xC0izSXqEqOj1FnW
         OkgA==
X-Gm-Message-State: AO0yUKV/zc3VPbDh0w1cq6Fc5waNOmVBYEyh0HRRfFfIYQ1AktW1Vnog
	V3licwSM54Axx5iaPY8Rips=
X-Google-Smtp-Source: AK7set9Iyo2XZf9njsohvl6jQWWjwtumo6cSyVfz6pzF1NPaxBFBsjV55INndXP/cVZZKt9qxow0FQ==
X-Received: by 2002:a05:600c:1d1a:b0:3e0:b1:c12d with SMTP id l26-20020a05600c1d1a00b003e000b1c12dmr8064390wms.1.1677076674118;
        Wed, 22 Feb 2023 06:37:54 -0800 (PST)
Received: from [192.168.64.80] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id p13-20020a05600c1d8d00b003e1f6e18c95sm7914118wms.21.2023.02.22.06.37.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 06:37:53 -0800 (PST)
Message-ID: <23526cf9-d912-59a7-4742-6003d6ccfd45@grimberg.me>
Date: Wed, 22 Feb 2023 16:37:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [LSF/MM/BPF BOF] Userspace command abouts
To: dgilbert@interlog.com, Keith Busch <kbusch@kernel.org>,
 Hannes Reinecke <hare@suse.de>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 lsf-pc@lists.linuxfoundation.org
References: <3d3369f1-7ebe-b3b8-804c-ff2b97ec679d@suse.de>
 <Y+5cjPBE6h/IW9VH@kbusch-mbp>
 <ad837a26-948a-c690-cd9e-4dfffb5f990d@grimberg.me>
 <57d8dff9-2fdb-8198-6cdc-7265797a704a@interlog.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <57d8dff9-2fdb-8198-6cdc-7265797a704a@interlog.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230222_063759_505043_682586FC 
X-CRM114-Status: GOOD (  13.06  )
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


>> I did not understand what is the relationship between aborts and CDL.
>> Sounds to me that this would tie in to something like Time Limited Error
>> Recovery (TLER) and LR bit set based on ioprio?
>>
>> I am unclear where do aborts come into play here.
> 
> CDL: Command Duration Limits
> 
> One use case is reading from storage for audio visual output.
> An application only wants to wait so long (e.g. one or two frames
> on the video output) before it wants to forget about the current
> read (i.e. "abort" it) and move onto the next read. An alert viewer
> might notice a momentary freeze frame.
> 
> The SCSI CDL mechanism uses the DL0, DL1 and DL2 bits in the READ(16,32)
> commands. CDL also depends on the CDLP and RWCDLP fields in the
> REPORT SUPPORTED OPERATION CODES command and one of the CDL
> mode pages. So there may be some additional "wiring" needed in the
> SCSI subsystem.

I still don't understand where issuing aborts from userspace come into
play here...

