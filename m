Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C72B8C4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Dec 2022 01:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dHrne/19ZjN7gnhIrvUAXLtdk5Uo+4OyMRgbNxytMDY=; b=zu+oLmOifi9er5
	tpVcKLucp9dMlCVawunC/Iwz/x61+tSjNhzG+KY920FBogQGQIuxjD+gkrApKsG2KMrDOpjlGVaOO
	YBZnSR2sBzYVNhhEGtYSQoYCBLxBrNoyIVU/6N0Kgfenwm76pSNKzAc+ouZHKVN3BTpdF0UtDXzvd
	75s8VKKrvbNjwob8qe5T3lPMUBbjse1eQtOiPkSVryHuhIETkrtUi6619Ib6EFb1eghwIQfEERd65
	PSlt7BTPE+Bxo1uQA0V8B081Jy8eQZP4mNn1vs5nyvsX6zzCOHMufsYU4eFMDDGFAToS43XTu9rQy
	XC5pLWYaNGx81phXLb4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7R9S-0067A1-R8; Tue, 20 Dec 2022 01:10:38 +0000
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7R9Q-00677l-Gq
	for linux-nvme@lists.infradead.org; Tue, 20 Dec 2022 01:10:37 +0000
Received: by mail-pl1-x635.google.com with SMTP id n4so10763259plp.1
        for <linux-nvme@lists.infradead.org>; Mon, 19 Dec 2022 17:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dHrne/19ZjN7gnhIrvUAXLtdk5Uo+4OyMRgbNxytMDY=;
        b=jtedX9dWADx1yZ2SrvTEId/b7s+wI3DgawwWPT0fT0I0ERHS0FWyJZSHzr658ADp+e
         hwMi5uKfaKf8BvP4OVZ86dhUyNe3tWvRGxkcfpQpqCYyCOztuU0od18EKNnqBHgyvisP
         GdCsozUQvoQc1Nm7VgFcM1UJrN3RU4+ishzEADgTgyCUJk4jRTdVm308pjh8Y+rdLtZG
         5Jr0AmXrxop0YmJP7K3xKdgXzThxxJKAW41jy+Eoz2g4TGrRpcdxXfTrpbEwJTDuUixT
         7W0u7smeoIYYT8lJ2kVsSzDhUt3UnYCrFa+NDeDN9bYdviyon+icYxLqqXO6EoEnw+7o
         b49Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dHrne/19ZjN7gnhIrvUAXLtdk5Uo+4OyMRgbNxytMDY=;
        b=l0CHTBJFBE3tqPwjcrScu3QvVTz7MXBL1eigWAxKh9v4wuqeWgGqV56eHYO15MXnDH
         9hko2EvvljkUzWaHSzZ9imS1Uh95DL5tt4Ipz61Qvc5r3LXUguHrxfZFTj5Ht8Cncq10
         9R29quStRI4KNFVf7/jAiChNSlOHdyahRmgIZMco6fpleUaC0sc6uL0PzXopD7DyRlIs
         8ghEFILAzhtqaJ6M2HGq1F+RPWWsjVmGEyG+QPlMARejfOKR2EdzzAuhjEKYDLgV6zTA
         kWJFajIdpxbhUzy3cQALxr+TQhZ45sBJxUpyRthaFIavUE/fhfS9z4YNYDwf10OKMmBh
         UM1w==
X-Gm-Message-State: AFqh2kqrhYx1h2EQQBGo8yDeX4NH8N7bOo5VVodtZh9Y1+TTpJnY3ip+
	yzO2GGX4umVbz05hUa/A4jI=
X-Google-Smtp-Source: AMrXdXvHDvlkPUSMHz7cVAlKKELbuCW6LR3oA/nzqJFC7xj4sIM99MExqCZrn9GnV48kbwKqz3ofMw==
X-Received: by 2002:a17:90b:3947:b0:223:85a7:20c1 with SMTP id oe7-20020a17090b394700b0022385a720c1mr16206109pjb.2.1671498634056;
        Mon, 19 Dec 2022 17:10:34 -0800 (PST)
Received: from [192.168.0.23] (q014251.dynamic.ppp.asahi-net.or.jp. [203.181.14.251])
        by smtp.gmail.com with ESMTPSA id f2-20020a655502000000b004785d99321asm6980451pgr.86.2022.12.19.17.10.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Dec 2022 17:10:33 -0800 (PST)
Message-ID: <b82b44db-1169-6b77-4f1b-ffdf4fb7feae@gmail.com>
Date: Tue, 20 Dec 2022 10:10:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: nvme nvme0: I/O 0 (I/O Cmd) QID 1 timeout, aborting, source drive
 corruption observed
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me
References: <fe013f52-ac3c-4be2-6f1e-e68fea46e4c2@gmail.com>
 <Y5z8Sj+7N7HF4ZyP@kbusch-mbp.dhcp.thefacebook.com>
 <eb882c34-7b69-e0c2-f100-35f3a90ce94c@gmail.com>
 <Y6B4JFj5jIDs0cBI@kbusch-mbp.dhcp.thefacebook.com>
From: "J. Hart" <jfhart085@gmail.com>
In-Reply-To: <Y6B4JFj5jIDs0cBI@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221219_171036_632781_6A31C830 
X-CRM114-Status: GOOD (  16.10  )
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
Reply-To: jfhart085@gmail.com
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 12/19/22 11:41 PM, Keith Busch wrote:
> Given the potential flakiness of read corruption, I'd disable relaxed
> ordering and see if that improves anything.

I am not familiar with this part.  How is this done ?

> 
>>                          MaxPayload 128 bytes, MaxReadReq 512 bytes
>>                  DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
>>                  LnkCap: Port #0, Speed 8GT/s, Width x4, ASPM L1, Latency L0 <1us, L1 <8us
>>                          ClockPM+ Surprise- LLActRep- BwNot-
>>                  LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
>>                          ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>>                  LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-


> Something seems off if it's downtraining to Gen1 x1. I believe this
> setup should be capable of Gen2 x4. It sounds like the links among these
> components may not be reliable.
> 
> Your first post mentioned total transfer was 50GB. If you've deep enough
> queues, the tail latency will exceed the default timeout values when
> you're limited to that kind of bandwidth. You'd probably be better off
> from a performance strand point with a cheaper SATA SSD on AHCI.

It would be unfortunate I think if the linux driver could not be made to 
implement the NVME standards on the somewhat older equipment from 
perhaps ten or fifteen years ago.  Earlier than that is perhaps not 
terribly practical of course.  Equipment like that which is still 
operating does tend to be reliable, and it's something of a shame to 
have to waste it. Some of us also do lack the wherewithal to update 
equipment every two years, especially older people or those in areas 
where the economy is not so good.  As I think we all know, there's more 
of that these days then we'd like.....:-)

In any case, I'm very willing to run tests on this equipment if that 
will help.  I'm fairly familiar with building kernels, writing software 
and that sort of thing, but perhaps less so with fixing drivers.

J. Hart

