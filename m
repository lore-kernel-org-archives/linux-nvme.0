Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58367C05027
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Feb 2023 11:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=orZM8Nvs7jWh84k6Sgfl/Z5A9qbthR5Jz7WN21ZXfmA=; b=UNlYb1dvGLNMefoYxm+iMXAbQm
	f//Cw4uJh5F6HCuQKdmrFgIe8O56HiRhqHWl/ng7LICOv69WH8cMYkOJFTv31VFCBkLR4RBrCMOKm
	pMs9dCZMuw6edxZtpnmT1sSCGMPdI2LNxXKgJM3QlXpn7M2LZaP2W+Aii2vFjVV0qhTtraVPls0OU
	dpeMvuJIm3feuhxXDrq+tS4mXPrzeCWZ3HN6ke7OVk5WwmrraRCiB5RdhKPev5Yh80MZGbTuZVmwk
	qe3+qU+IdbcsWQxsT0lP2C45kvMPFLLdgob8SkFcrNDd78dj6PT10U6aCpFoBask3RuLxlqkxyBm5
	+kOB2MXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pU4Hc-003rAI-0m; Mon, 20 Feb 2023 11:24:36 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pU4HU-003r76-Dv
	for linux-nvme@lists.infradead.org; Mon, 20 Feb 2023 11:24:33 +0000
Received: by mail-wm1-f54.google.com with SMTP id bg28so677533wmb.0
        for <linux-nvme@lists.infradead.org>; Mon, 20 Feb 2023 03:24:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676892265;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=orZM8Nvs7jWh84k6Sgfl/Z5A9qbthR5Jz7WN21ZXfmA=;
        b=aYRQaPM1Mi85WgoOhjmQtt2MrbqUqeD5NJhe9HrgZGh3qdj6JocQYbqUDH0j84DmQJ
         NMTX0VwFH6jhqOT2v30zeQLGjIDwqPkAsMlup/dtRLpfIumhBVljLnKdg5tda88CcY4U
         lHWeavm9poTWiH2QiKzx+I+FyoO2MsUTguo++04Rj/Jx8u/Kui4H8TUZhxd5f4c7XPRU
         TQBu7zGyBDlbsaTKPSN2vIppiK58xp4m5rWctZgIFQKKhCsX45g8XCxPZsP5Bo1mycvl
         hvGP0uU7QBIBsfgY5thCLcb2icH/bxQ8TOoC0OCvVnvegJneytDZKpQxHOIWSR1lTnPK
         OrEA==
X-Gm-Message-State: AO0yUKWxCcyYmG40A+mTTvlXT+752+jBYgXtAc7v7znpcrjvRmkhZCo7
	xFaUvO6GLBxr+4U220Isubs=
X-Google-Smtp-Source: AK7set8pQ+BZnrr2+JhbY4ZPMILoc8gV4un+K1D4JYAGBAK2LUsn8tPAHo4akjUu2CZgieU/9HeLLA==
X-Received: by 2002:a7b:c842:0:b0:3db:2063:425e with SMTP id c2-20020a7bc842000000b003db2063425emr883467wml.1.1676892264834;
        Mon, 20 Feb 2023 03:24:24 -0800 (PST)
Received: from [192.168.64.80] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id f17-20020a7bc8d1000000b003e2066a6339sm13863450wml.5.2023.02.20.03.24.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 03:24:24 -0800 (PST)
Message-ID: <ad837a26-948a-c690-cd9e-4dfffb5f990d@grimberg.me>
Date: Mon, 20 Feb 2023 13:24:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [LSF/MM/BPF BOF] Userspace command abouts
To: Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 lsf-pc@lists.linuxfoundation.org
References: <3d3369f1-7ebe-b3b8-804c-ff2b97ec679d@suse.de>
 <Y+5cjPBE6h/IW9VH@kbusch-mbp>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <Y+5cjPBE6h/IW9VH@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230220_032428_507965_8D63CE13 
X-CRM114-Status: GOOD (  17.72  )
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


>> Hi all,
>>
>> it has come up in other threads, so it might be worthwhile to have its own
>> topic:
>>
>> Userspace command aborts
>>
>> As it stands we cannot abort I/O commands from userspace.
>> This is hitting us when running in a virtual machine:
>> The VM sets a timeout when submitting a command, but that
>> information can't be transmitted to the VM host. The VM host
>> then issues a different command (with another timeout), and
>> again that timeout can't be transmitted to the attached devices.
>> So when the VM detects a timeout, it will try to issue an abort,
>> but that goes nowhere as the VM host has no way to abort commands
>> from userspace.
>> So in the end the VM has to wait for the command to complete, causing
>> stalls in the VM if the host had to undergo error recovery or something.
> 
> Aborts are racy. A lot of hardware implements these as a no-op, too.

Indeed.

>> With io_uring or CDL we now have some mechanism which look as if they
>> would allow us to implement command aborts.
> 
> CDL on the other hand sounds more promising.
> 
>> So this BoF will be around discussions on how aborts from userspace could be
>> implemented, whether any of the above methods are suitable, or whether there
>> are other ideas on how that could be done.

I did not understand what is the relationship between aborts and CDL.
Sounds to me that this would tie in to something like Time Limited Error
Recovery (TLER) and LR bit set based on ioprio?

I am unclear where do aborts come into play here.

