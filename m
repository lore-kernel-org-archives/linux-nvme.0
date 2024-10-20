Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46BA8D3C92A
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Oct 2024 21:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c+LOEsPdekgzjdxRqQ1SaWjVF5woUyJlxPhGcaWje58=; b=zzweLJcu8XfNkK/9RtA6O9kAvZ
	geTgS7pgpJG/PHrvIEsLQwjdpS2UnOL2mHJtFpz9QeR00HzKJ0bbEEXtlZ4BAvkRj2CVN4R120UB8
	beGjCPCOg6o4FM/+ZEq0nireIkpvELk/t6cVReN2gzJRjMM6SBMOApcEpsUzF2JsYjhYa5Qw3t3OP
	bd0Zpbm4mnDvyhrxr8TqfgRHB1jT8eC4JhGOSb3KMG5R4MHCxsWvaCQW3aAaBnoF5u+XOfa588L5n
	fWn4o7a5AQODjapET/IN8xg0+79LKtBPaZkJgbSHWRdKhhMwJ3vQTvSUvX2ZfN4JxibqbEwiQW94g
	Bt8Ox4SQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t2da7-00000005Uv0-3UMp;
	Sun, 20 Oct 2024 21:35:23 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t2da5-00000005Uud-0zKx
	for linux-nvme@lists.infradead.org;
	Sun, 20 Oct 2024 21:35:22 +0000
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37d4ba20075so2894369f8f.0
        for <linux-nvme@lists.infradead.org>; Sun, 20 Oct 2024 14:35:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729460119; x=1730064919;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c+LOEsPdekgzjdxRqQ1SaWjVF5woUyJlxPhGcaWje58=;
        b=E2owYQazD7oqfRobHjU2wzTL9PpfOy0sSYSldwFvLAUHVAUb8/dx/wH9THHGQ2ZVAx
         ywYAd1RmQ2j56itcHPDp/8R009AD/aYOZQsw0z//q8fu6m0STL7Wf37hGE0IRsl9BbSF
         T+MheED4ARmod1BnZWWBITdjX5ywklKnkMWtYvSeeUGeWGOdfoIt3nzAdyJhBCt2lCjJ
         ok5fOFJ5mGBFE5gWgKFhOoUTzbW3MxycdZU/JCigneXsX8Tsxi9pIx1muJ3CtRaop8Ca
         9ZLNooVrfcVqmBL7jEg/Y+K3k6xCopqkHR94MLrtj4OvLxI8ai7ms4Qn1UFFzq3tV7T3
         MpYw==
X-Forwarded-Encrypted: i=1; AJvYcCVjaAvDEJ5IGsADobU4RcZ6QUc92pjgEk4Tx4xCiUx0AT4WBaQv3a5/OF/wSk4Z+MYK2qeoxMR66aN1@lists.infradead.org
X-Gm-Message-State: AOJu0YxmHVaj0ZJ/z5kg8gFW0NmZbrfuOHPkVPM2d0FwUhiWSGdGG9ki
	T9EQXAiP/c85CduwR753SsHIIZjnlYxOIkr8rZKXDDDKc78YCjC4
X-Google-Smtp-Source: AGHT+IFPZDCmEG1lroGe2WFiPcwBuk68uTfcvNLAKxHmVBfPhekO5rJIV+VLE9BFUWSm+WVEZFv9eQ==
X-Received: by 2002:a5d:4529:0:b0:37d:46e3:4e88 with SMTP id ffacd0b85a97d-37ea21518aemr6421542f8f.9.1729460119358;
        Sun, 20 Oct 2024 14:35:19 -0700 (PDT)
Received: from [10.100.102.74] (89-138-78-158.bb.netvision.net.il. [89.138.78.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b9bdbasm2593201f8f.105.2024.10.20.14.35.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Oct 2024 14:35:18 -0700 (PDT)
Message-ID: <64f4d599-3261-4544-90c2-4cb3e1ad96fb@grimberg.me>
Date: Mon, 21 Oct 2024 00:35:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-loop: set blocking flag
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@meta.com>,
 linux-nvme@lists.infradead.org,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20241017172052.2603389-1-kbusch@meta.com>
 <7846e57b-fb03-42ed-af8e-0df88cc566a4@kernel.dk>
 <ZxFRpdU-GI76uetA@kbusch-mbp.dhcp.thefacebook.com>
 <20241018051056.GC19831@lst.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20241018051056.GC19831@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241020_143521_306493_FE009BDE 
X-CRM114-Status: GOOD (  16.83  )
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




On 18/10/2024 8:10, Christoph Hellwig wrote:
> On Thu, Oct 17, 2024 at 12:04:21PM -0600, Keith Busch wrote:
>>> Looks fine to me, but might be worth looking at doing that a bit
>>> differently so that the target loop driver can remain non-blocking
>>> as it should be considerably more efficient.
>> That's what I first looked at, but it's too hard. Maybe if we can make a
>> lookup that doesn't rely on searching the configfs group, but it's
>> definitely not this nice one-liner patch. :)
> Searching configfs in the I/O path sounds like a train wreck no matter
> what.  I feel a bit bad for not noticing that earlier.
>
> Let me see what I can do.

Note, the search is ONLY in the error case, i.e. when nsid is not found in
subsys->namespaces.

I agree its a shame to make the loop driver blocking for this niche case.

Note that this doesn't do anything, because it is really designed to 
make the
host failover work correctly (i.e. not fail IO) when nvmet disabled the 
ns in
one server, and the namespace is available in the same nvmet subsystem 
on another server.

We could escape this entirely for loop transport because it there are no 
multi-server nvmet
subsystems for loop? There is a weird case where one can use mpath 
device where one
path is loop and another is tcp/rdma... Which is very weird but maybe 
possible with nvmet.

