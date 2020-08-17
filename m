Return-Path: <SRS0=j3u6=B3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03694C433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2020 07:56:57 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C61DB2078A
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2020 07:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="wJxvVGnQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C61DB2078A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=gXvYzFrS2fQ96IqoiNN+vP5K1UrwB25gnjHY6je5Ji0=; b=wJxvVGnQfyxlLTRlEzaiUVJhE
	kNHrQK/Fn40GMmmYwCfpi1Gs/6zBezZmN5BIJ1q1/7uBdnsD7K2Sb+mPb8JTk15vOPyHTpU2Rl7It
	PoL0c6AAExgeMWOpBhwScgwjeXVHO9w5jhpIA7vjr0JxTWRj64Gs0AUwu2QR6miYYXYbk7+8Oh26s
	jBgeQ5fRUuHsv9eTLgSNooCS4opL+8eBZImZ64qaywwkJbx9DRpY1uuO4wvLqJxQMkKRKaV1apSuS
	Qnhr+xLtV5Eu7hpteT2gaUxqE2G7okG3xcSQWNVlnQqc3EBosbZLxw1k39k3lM+JSs9+BcpgWNBjM
	lj54glPUA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k7a0i-0007UJ-Fr; Mon, 17 Aug 2020 07:56:52 +0000
Received: from mail-pf1-f175.google.com ([209.85.210.175])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k7a0g-0007TU-Hc
 for linux-nvme@lists.infradead.org; Mon, 17 Aug 2020 07:56:51 +0000
Received: by mail-pf1-f175.google.com with SMTP id 74so7816494pfx.13
 for <linux-nvme@lists.infradead.org>; Mon, 17 Aug 2020 00:56:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fR4Zf49pEbUhmNTP0eWRFVlTep27HhCh1e3SWzmCO0A=;
 b=EWQtkA/rznv4lH2t7Ed1a7hrZxzih6HXyJm2xztzu5CJDOF292PwFiIDjLtfyTp5gf
 f1E7ASjja755svoRuIigjTuS/xKW+UPZ1YO3qQ2g08m+UO4wNOYu9yOvzG9hMjquZ4m9
 PuL4XTF2cgOS3mBzrKYL1oBdrDoZv34ynV6Esx7QKHZ7uEO+KQTd/1FX2wqTt80YMjy3
 dbvSe33jILE+tx+X3Hn4y8960vreHXfiwRNG8V3m/vSSFg/Xv3JTOF2q2c2VvdD/g+Fz
 FHdgE/UKtivKOzuzV2TbLKQEoUVEl2aA65/3JaDkpxMFbTBzpuJ1EfwLcFZtUIjtRfyD
 0f6Q==
X-Gm-Message-State: AOAM5330rZuMJN6EJHoHe1EQOzOuTooXigae2m/YT3ME1FueZqJ+J1wP
 xcxoXnO4l1MY0PNGgQUiq7I=
X-Google-Smtp-Source: ABdhPJwelVzQJ49RinU19mne7JpeC7nDIAhf5XNbCa2B2a1deJNUGWzkOJUy+XrNKSk2pFuGl+YI5g==
X-Received: by 2002:a62:86ca:: with SMTP id
 x193mr10221370pfd.152.1597651009359; 
 Mon, 17 Aug 2020 00:56:49 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:c8a:c3fd:4152:60d0?
 ([2601:647:4802:9070:c8a:c3fd:4152:60d0])
 by smtp.gmail.com with ESMTPSA id u15sm16671019pju.42.2020.08.17.00.56.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Aug 2020 00:56:48 -0700 (PDT)
Subject: Re: nvme reservation commands during controller reset
To: Christoph Hellwig <hch@infradead.org>
References: <MN2PR19MB30052441F4F22A4CAC8D396FEE4B0@MN2PR19MB3005.namprd19.prod.outlook.com>
 <20200809161016.GA63121@C02WT3WMHTD6> <20200810124036.GA25070@infradead.org>
 <MN2PR19MB3005A46208EE2B65E5F9B330EE440@MN2PR19MB3005.namprd19.prod.outlook.com>
 <20200810154846.GB4159317@dhcp-10-100-145-180.wdl.wdc.com>
 <462babf2-7cde-af4a-8bf9-a5b230e282b7@grimberg.me>
 <20200814082015.GB18371@infradead.org> <20200814100911.GA9975@infradead.org>
 <83dbae6f-01a0-a9a4-9271-de8c1cf06c66@grimberg.me>
 <20200815070134.GB20460@infradead.org>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e312ae98-5b40-d0ee-c13e-b65db1f3acd7@grimberg.me>
Date: Mon, 17 Aug 2020 00:56:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200815070134.GB20460@infradead.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200817_035650_604203_12CD0660 
X-CRM114-Status: GOOD (  17.05  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <kbusch@kernel.org>, "Anner, Ran" <Ran.Anner@dell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "Engel,
 Amit" <Amit.Engel@dell.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>> Amit,
>>>
>>> can you try the branch below?  Pretty much hot off the press, but I
>>> think this should address your problem:
>>>
>>> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/nvme-pr-fix
>>
>> I like the approach, but I think we'll need a bit more path awareness
>> like we check for available paths if we requeue or fail..
> 
> If there is no available path, nvme_find_path will fail and thus we'll
> error it.  This is the same mechanism as used by
> nvme_ns_head_submit_bio.

nvme_find_path will return ns=NULL even if none of the paths is LIVE,
but we want to requeue if we have an available path (e.g. ANA state is
inaccessible temporarily or ctrl state is RESETTING/CONNECTING).

Only if no path is available for request execution we are failing the
request.

If we are providing multipathing for reservations, we should give
the same efforts as we do for normal I/O. This could mean waiting
for some indication on the ns path states (wait for a completion in
nvme_submit_sync_cmd_disk and wake it up in nvme_mpath_set_live).

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
