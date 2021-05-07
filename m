Return-Path: <SRS0=skSE=KC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC14C433ED
	for <linux-nvme@archiver.kernel.org>; Fri,  7 May 2021 19:51:02 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22E1761426
	for <linux-nvme@archiver.kernel.org>; Fri,  7 May 2021 19:51:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22E1761426
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=2fUl56pgxALEkxuW7n2qtrsQNUhJR9ACBZJHwD5BPU0=; b=VbOwl20h7poOO3DIZWkquDNcZ
	v3tkfZKHp6iTME3OISm22xLdAuJiupiqxvwp882ZKo/c+TdOlpLsdrVbX9dP80UWxZK4xL5V0O/VZ
	jcB/4D27yV/pihPwFcPwk5ckbFZOSPSHGOXtlh5MjBFk8rcPqVF6QmE2A1mzPtKB7cbgEk47jSj9o
	B7fy6W8GE7jRYY/i+GNcbhcTyuUOa6Y4lMA6uV9xymmJcd1eZjOMxSx1Z6JVEmUQyzl18k3gN5LxY
	riD/Zj6RUQ1HQ5VPprc+XaozUIFJRXBCiGpC85qdglgkXdytDxMu1VHjRo/ojCphA67miWRe43J41
	J6H7xupIw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lf6Uq-007uZQ-VX; Fri, 07 May 2021 19:50:49 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lf6Uo-007uYz-72
 for linux-nvme@desiato.infradead.org; Fri, 07 May 2021 19:50:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=HRncUjC4e3W4NDv2jq1CKqljsbhXiyJw/qdsh33NS2k=; b=h65j6De+1KdV6SM5AVf/QPEmJQ
 VjKQ0UGMbd/iqdgZ2fGoZHxzeeFC1B+V9Vbd7nqsmqc8TmCCBN2onmbEGaJ+nSQkLnLOOf/qq/MSO
 Rrxug+OHVllqLmnLIxscxXYpcw/nuEGYMgerNVLq/LnAysJfmxlV+W0qES7u1kE+icusVUt7gy2Kz
 ZO9e3OBOpM9xXfG/6zJ6AH5AxRraW6S5RcIXF6kXPzIDo0fKL710vGbcdqM9zS/Lb2rIA4n1C4wgg
 V4DZJ5nnym9btun8QDiZOmmj38BhkuIRBV3Z7IwrSRGfPGYCMf1G1AWcbVFzY+Ks+UEilFlZWo3RJ
 TV3oqRrQ==;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lf6Ul-0079Ia-N7
 for linux-nvme@lists.infradead.org; Fri, 07 May 2021 19:50:44 +0000
Received: by mail-wr1-f46.google.com with SMTP id h4so10364844wrt.12
 for <linux-nvme@lists.infradead.org>; Fri, 07 May 2021 12:50:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HRncUjC4e3W4NDv2jq1CKqljsbhXiyJw/qdsh33NS2k=;
 b=GcUdgnW6bCWZyHKyo2RryRNjiHQ5FabXBrnLhvYkX4lxc6qoO1CfB5yo4TDbKON4HH
 VCU5mgtoJwkfmwu/kyElyW6MAYQ1DFGjlMTX5vBuQ+0l2lyJ5O+k34SARYBY7NthhVqe
 qlTkKRufnd4xR7LwD4TiLWTM7YWvup/Gmh+OM2DR/+bZ1loyYu2Jdv15uPNxidMgbg+C
 zofTnWp3pn1cTtgjUdcgKCZs8EM3cTWhCrR8ilEe1YoPSZEl0bYDMFArQ2cfckO/AYHw
 F2NAt0VWsDva8ToRLBVso9WM/wrm7xv2D74ZxffRw3jOAb9awvz4c1sNYellHPQB57mz
 vgkA==
X-Gm-Message-State: AOAM530jcfIwJtYx6yrzgt38hlRzAQcRFUNYGYwoV2umligGY7cEZ3b0
 1TCXqeZqXS7yZK09BU0E1O3wXMFhI3s=
X-Google-Smtp-Source: ABdhPJxhenJjDgNGcWUs8elLDjO5IaECv4kbdGLsyYRiOc1D5jQx7vBKAONMcnr5o0FMDYXEN+5Bdg==
X-Received: by 2002:adf:d22c:: with SMTP id k12mr14644570wrh.25.1620417040651; 
 Fri, 07 May 2021 12:50:40 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:d07b:68ce:2d70:258f?
 ([2601:647:4802:9070:d07b:68ce:2d70:258f])
 by smtp.gmail.com with ESMTPSA id y5sm9038758wrm.61.2021.05.07.12.50.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 May 2021 12:50:40 -0700 (PDT)
Subject: Re: [bug report] blktests nvme/022 lead kernel WARNING and NULL
 pointer
To: Yi Zhang <yi.zhang@redhat.com>
Cc: linux-nvme@lists.infradead.org, skt-results-master@redhat.com,
 Bruno Goncalves <bgoncalv@redhat.com>, hare@suse.de
References: <CAHj4cs-hAaHhWU4Kb4NrQ9Fvi7DiH95P=Q=7zK-inxpeZtztkw@mail.gmail.com>
 <3243ab72-ffe3-e655-ef0a-d695885ce2c5@grimberg.me>
 <CAHj4cs9uOHRgRe9PJ3_0A4NMo4T1q4XzCYG6UAV-V=RZ39i1iQ@mail.gmail.com>
 <CAHj4cs-JawWOTNBnQ3OTeNXUb_zeH3-5MrPQWK0=1QPfEJ7ROA@mail.gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <201a97a9-e42f-8d8e-3cc7-e5cf8ba816c2@grimberg.me>
Date: Fri, 7 May 2021 12:50:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAHj4cs-JawWOTNBnQ3OTeNXUb_zeH3-5MrPQWK0=1QPfEJ7ROA@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210507_125043_784495_A9AA1191 
X-CRM114-Status: GOOD (  10.45  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> Hi Sagi
>>
>> Bisect shows bellow commits was the first bad commit.
>>
>> commit a70b81bd4d9d2d6c05cfe6ef2a10bccc2e04357a (refs/bisect/bad)
>> Author: Hannes Reinecke <hare@suse.de>
>> Date:   Fri Apr 16 13:46:20 2021 +0200
>>
>>      nvme: sanitize KATO setting
>>
> 
> Hi Sagi
> This issue has been consistently reproduced with blktests on recent
> linux-block/for-next, do you have a chance to check it?

I had not, Hannes can you have a look?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
