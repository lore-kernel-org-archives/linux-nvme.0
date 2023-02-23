Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4A61C61DA4
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Feb 2023 15:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pQe/WnpSMAW2mDbkmE0tjSb/o7wgQczEKKxf9Jtlnnc=; b=NaVUgjp5JONksmWRxeqWnlzskD
	Uy+uqb814esm1YQmi3ngbMbh3UjP5dWrYH1JaGgyfxMyu3gyhJYOMTshbBNwXMbay2xaZy3zuoH0y
	ubaQmdo315fENZELJra+j/U+kqvYWhTtVTvzOb5DmKOX3pSZuYhYA0o2kZqYmhP08gIhb522xOh47
	207rVjaxtJ5ActQrU6WLAzufzi0f/hguezJnsQ6h6jzM55bdfkjp86IsNf/eFSHApk/7cpdhviexs
	2tc9PEUxDvEZDgNLiWV8XH9U0N+E7A+s2NW+F1grxx2/XkuxRQf9XyJ7SKW3SPOaVitHnzaQHqkKr
	wAt2i0rg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pVDd6-00H4Qd-28; Thu, 23 Feb 2023 15:35:32 +0000
Received: from mail-wr1-f53.google.com ([209.85.221.53])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pVDd3-00H4OX-0z
	for linux-nvme@lists.infradead.org; Thu, 23 Feb 2023 15:35:30 +0000
Received: by mail-wr1-f53.google.com with SMTP id bw19so365597wrb.13
        for <linux-nvme@lists.infradead.org>; Thu, 23 Feb 2023 07:35:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pQe/WnpSMAW2mDbkmE0tjSb/o7wgQczEKKxf9Jtlnnc=;
        b=SNEfQYK9/zUae5Gvx/bqs5whpGSHYbtw/Bn3rsy0z1rOBh+VJqPaTmO4A3a1WOsMD8
         RUw+SBPHv8TmFEFcFZUWp/MhIr/4Q6EnrLH09KSXA64IIRtvyY2yOxs8tzumpNDwn+M5
         e8htK5ohMECZr8igEFwCTWcBMHk+myQqTt2b6VL3NT2xNEmdYdOu5RPaMpj2ke42C2fs
         YNHNYxisrL9qcIWrQ8jq++lFCMVC39vS6Oed8WQbuEBeApZEl3kgUnDuY2SfrUzb68TK
         qO1KaVLwY6TThHdSjOGx/Z/AqYT1ZDku3/JibH3IddC38n8bmpHOTuN+Fw3lG/Waon0d
         /iOg==
X-Gm-Message-State: AO0yUKVuX5MnGNJGTKlrdW4z0ue3j87E+LxpS+mSA94No9rGKQFxzE+t
	wQ+TTU6ZKMFoDMXK+ClLsk4=
X-Google-Smtp-Source: AK7set/KFJVUpx9U1606sZfdF40dDGZrrfSPJV+F9VjEhmT/9eemxiLat4EB5PwUkYTjkefYdPluRQ==
X-Received: by 2002:a5d:60c7:0:b0:2bf:de9c:4595 with SMTP id x7-20020a5d60c7000000b002bfde9c4595mr9390894wrt.5.1677166525786;
        Thu, 23 Feb 2023 07:35:25 -0800 (PST)
Received: from [10.100.102.14] (85-250-17-149.bb.netvision.net.il. [85.250.17.149])
        by smtp.gmail.com with ESMTPSA id v15-20020a5d4a4f000000b002c7107ce17fsm2078608wrs.3.2023.02.23.07.35.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 07:35:25 -0800 (PST)
Message-ID: <561afa67-04d0-c675-6bbb-048313da152b@grimberg.me>
Date: Thu, 23 Feb 2023 17:35:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [LSF/MM/BPF BOF] Userspace command abouts
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: dgilbert@interlog.com, Hannes Reinecke <hare@suse.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 lsf-pc@lists.linuxfoundation.org
References: <3d3369f1-7ebe-b3b8-804c-ff2b97ec679d@suse.de>
 <Y+5cjPBE6h/IW9VH@kbusch-mbp>
 <ad837a26-948a-c690-cd9e-4dfffb5f990d@grimberg.me>
 <57d8dff9-2fdb-8198-6cdc-7265797a704a@interlog.com>
 <23526cf9-d912-59a7-4742-6003d6ccfd45@grimberg.me>
 <Y/Yscr82hqdKl1Hw@kbusch-mbp.dhcp.thefacebook.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <Y/Yscr82hqdKl1Hw@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230223_073529_102109_54DDD709 
X-CRM114-Status: GOOD (  12.74  )
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


>>>> I did not understand what is the relationship between aborts and CDL.
>>>> Sounds to me that this would tie in to something like Time Limited Error
>>>> Recovery (TLER) and LR bit set based on ioprio?
>>>>
>>>> I am unclear where do aborts come into play here.
>>>
>>> CDL: Command Duration Limits
>>>
>>> One use case is reading from storage for audio visual output.
>>> An application only wants to wait so long (e.g. one or two frames
>>> on the video output) before it wants to forget about the current
>>> read (i.e. "abort" it) and move onto the next read. An alert viewer
>>> might notice a momentary freeze frame.
>>>
>>> The SCSI CDL mechanism uses the DL0, DL1 and DL2 bits in the READ(16,32)
>>> commands. CDL also depends on the CDLP and RWCDLP fields in the
>>> REPORT SUPPORTED OPERATION CODES command and one of the CDL
>>> mode pages. So there may be some additional "wiring" needed in the
>>> SCSI subsystem.
>>
>> I still don't understand where issuing aborts from userspace come into
>> play here...
> 
> The only connection is that aborts are obsolete and unnecessary if
> you have a working CDL implementation.

OK, that makes sense. Indeed I *think* that nvme can support CDL and if
this is useful for userspace then this is an interesting path to take.

