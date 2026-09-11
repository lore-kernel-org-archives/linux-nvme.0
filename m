Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA2A1C88E4D
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Sep 2026 21:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=51c/ZwsqvwLANn29Bca8ztxTQOQJG+9tSAaUO0OsyiI=; b=Z4kdZVJyTNr+8ILAubMxr+HuZS
	WFSdrHW4yht+g/ePj1RVPHMdm34rcc/mmevYIvkc2Wr5L7fs5cb9l2fCwaqWrPQULgI4BtOcDJGE8
	K29gioHX+6Nph3sDOnj3dfw2iQiaHrzlwuhcRlU7Vf3Y/nlGDWWurbOoFIHCw2H1Plp5Mn0Dc43Ee
	FNjkokn2bnsRcrLQbi4cBfCXAdiyPlx/lcj147V02wePwi0J7zrajuz/ZLHqiDRersIzQ+9QU/Oax
	nTvhK2LUdzpOpfDctMH8qL440oh4ytCmVUIDgYDYoxKRDtILqd6fxGWrBHLFY6IyCD5gH0s6gHcA/
	E2HYyfNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x58we-00000000Bhb-2cbB;
	Fri, 11 Sep 2026 21:38:04 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x58wc-00000000BhA-2TW7
	for linux-nvme@lists.infradead.org;
	Fri, 11 Sep 2026 21:38:03 +0000
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49e6bad7b79so1915745e9.1
        for <linux-nvme@lists.infradead.org>; Fri, 11 Sep 2026 14:38:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789162680; x=1789767480;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=51c/ZwsqvwLANn29Bca8ztxTQOQJG+9tSAaUO0OsyiI=;
        b=Oz4y/n1c8ITCOAum9vtC1/XHLPRiohCBL9khT8UveCF+Lmhm8FclGhE94Pjkpeoo00
         HT1JrvmQbYFIapnYP2x8DtslEmExz60H0O1tzmsbwp50+OpCey4b+bXDjH5ZlW2DU2oU
         M/gVrEd2gfaZqdunq9PQVQQYQRDwdK+nbTluMMdZwfQxfPS8KhNMaXdt4Kmz1kyzcNrM
         zKzHxcGxrsWHSNo7um8j+QZbmBJDGWf2b9pDHlHECndowDdh3J07kQWlQ3EQBbHk9249
         EWL/Q4hPTme3LD9adVEoNszBlNJD5uo78+mTJWew7lVY9baBtpPiaTadruPPZKkv1pD6
         qYAg==
X-Forwarded-Encrypted: i=1; AKwUvBzq+Djg5VZQ+EtoNBLlia5rClNh+UfBuFqBkpvJ3AYJlohQQWAE2bM+ePj4keEPbppFVNOxszzH4mrT@lists.infradead.org
X-Gm-Message-State: AFuF++nyfYgqKvtnR3ozMObCb1JnvTZdKfJZE0QuBrPmakgQoOfaNPP7
	Pgd/RN90AyaefXn8XdLSyEbY3EgmPzyL8/76BCsVpkn1q865XaPB0jZi
X-Gm-Gg: AYBFou3q0WW6bMPkHaeIM+htR+lHTqlHI2k4tJLAtSd49ZsVB3uS6TcB0J/LQ0oJdMc
	/9BYDQcz3wGGq9kT33/QXkFnxzKt6c5lUPzM319WMYR2x1Hwk40vqamxwPjzy/tXBHJOB6t6EM5
	JQw5m6Tfob1SgRCRRCg+Jhf76iFwpEjv02PKhAfJYvnd0ScIftf43bcbMwiPF1RH6qN0gwPfnIh
	tAulCdYKd9giVhWgwPMiJcL2TRImA1Zd30Lbh2A/MXbm9TmDILIwSTbSqjM1rhtt79eamc9qBBQ
	6ORLQ2XUSorIX7DQrAjBnaykExcxzjjibuL3aL1NchXv63sz2IURMhI5O1laHpKuvST6vEJkt7M
	lG7X1T7EbS4bF/Ccb4W+mStfeUVC6z8U/32vOSpX6gIq6/bpexznlV0GpQHqZkSEJRbOiFA/jJU
	Rm5Duw/wx1VA7H4RRZbZLOemVJ/kbjdMJt3yBpEH3cSKmjIc2JxuVrb9i0qvTFUbBHu5kVDb7Zo
	GBs0G40hBAEdGD5fjkjM68yw5PAIUZh
X-Received: by 2002:a05:600c:4f88:b0:49b:2796:be30 with SMTP id 5b1f17b1804b1-49e6198cf7emr67461635e9.11.1789162680312;
        Fri, 11 Sep 2026 14:38:00 -0700 (PDT)
Received: from [10.100.102.74] (89-138-77-243.bb.netvision.net.il. [89.138.77.243])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb33fd3bsm8720494f8f.19.2026.09.11.14.37.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2026 14:37:59 -0700 (PDT)
Message-ID: <8d06416e-a0be-4a0a-b1fe-f5b7831f8574@grimberg.me>
Date: Sat, 12 Sep 2026 00:37:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-multipath: add fail_io_now sysfs attribute to fail
 queued I/O
To: Krishna Iyer <kiyer@crusoe.ai>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, sj@kernel.org,
 saravanand@crusoe.ai
References: <20260904032605.65758-1-kiyer@crusoe.ai>
 <6b8ff0b7-c606-471d-b3be-12df3dac350b@grimberg.me>
 <20260906042235.71778-1-kiyer@crusoe.ai>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260906042235.71778-1-kiyer@crusoe.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260911_143802_653837_464B1B79 
X-CRM114-Status: GOOD (  24.51  )
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



On 06/09/2026 7:22, Krishna Iyer wrote:
> On 06/09/2026 1:36, Sagi Grimberg wrote:
>> I don't understand what is not sufficient with fast_io_fail_tmo? It would
>> determine the time that IO will fail when all paths are down.
> Thanks for taking a look, Sagi. fast_io_fail_tmo is indeed the closest
> existing knob. Like this patch, it fails the parked I/O without
> touching controller state. Three things make it unsuitable for this
> case though:
>
> 1. It cannot be engaged after the fact. nvme_start_failfast_work() has
> a single call site, the RESETTING -> CONNECTING transition in
> nvme_change_ctrl_state(), and it returns without scheduling if
> fast_io_fail_tmo is -1 at that instant. A controller in the reconnect
> loop stays in CONNECTING, and the sysfs store only updates opts, so
> once an outage has begun with failfast disabled there is no way to
> make the timer fire for that outage. That is exactly the situation in
> which the need for this arises.

At that point you can disconnect the controllers, which will teardown
the inflight blocked IO.

>
> 2. It decides based on time, and this decision is not about time. For
> deployments like ours the right policy for an outage of any length is
> to keep queueing; that is why we connect with ctrl_loss_tmo=-1 to
> begin with. The exception is not "the outage got long" but "this
> particular submitter was just killed and will never consume its
> completions", which host software learns at a moment no timer can
> anticipate. Any timeout short enough to release such I/O promptly
> would also fail I/O for every healthy workload whenever an ordinary
> outage outlasts it.
>
> 3. It is scoped to the controller. FAILFAST_EXPIRED marks the whole
> controller, so with all paths down it releases I/O for every namespace
> in the subsystem. The process being reaped owns exactly one namespace;
> the others belong to VMs that are still running and should keep
> queueing until the fabric heals.
>
> So fail_io_now is the failfast expiry made available on demand and per
> namespace: the same nvme_available_path() mechanism, and it likewise
> clears itself on reconnect, but it is triggered by the admin, for one
> volume, at the moment it is actually needed.
>
> Happy to work any of this into the changelog if that would help.

I am not sure I am following.

If you have a namespace that is attached to controllers say X,Y,Z,W
Now all of these controllers are unavailable, aren't all of the namespaces
on these paths also unavailable?

Or is it that the paths are online, but the ANA group got into a state where
there is no optimized path?

