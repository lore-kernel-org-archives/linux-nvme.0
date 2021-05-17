Return-Path: <SRS0=YADc=KM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47724C433B4
	for <linux-nvme@archiver.kernel.org>; Mon, 17 May 2021 20:28:11 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5C5D60FEB
	for <linux-nvme@archiver.kernel.org>; Mon, 17 May 2021 20:28:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5C5D60FEB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=y5NHQA6DD+PMtx2ZmnHhiBcTCYI7bhpUizAnjfmBAfY=; b=GaCZxNBmkALe9Cele6ncXNcEg
	tztmOeeerGndggvlncA1dW5kYvRwowvfngw6zcFePL6RGj34p1RpzQLJXwc14Ly6XxuwPDnLBCcYW
	DKevmnwXw9OMVWmVf2mtZgdKSgSoLkTIDYBxYdqYlxgbGUFwXm/JtLgnABZkjzWDUsjUPqUGp5TEn
	ed051XJhB1OYvs094R0CN4mgL2VprZnezbU+CKBLaNbEvBiRF3N9eByUH+Yfji3pzQtmnbAfcTFaF
	qBvVFNlruXJ5bkr8qkWt1KWHx3bmtVmVJ4F1LvcWQpm6T0Rxvr/f0hI+g0uIAjkryxRCMME4lKnCp
	AVNH1H/Hg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lijq5-00G3ya-6T; Mon, 17 May 2021 20:27:45 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lijpz-00G3xc-Vn
 for linux-nvme@desiato.infradead.org; Mon, 17 May 2021 20:27:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=aq56l47CCWeditDhAhqJsMZ7PBrfqrcnzwZQ7R+jeOY=; b=Ev1OKOdH6DaVoCn+45thmtTgK9
 5BI/QC1sd5627RON3QK6ciltBSmLTCrvkRue4dUfykliGin0e931xjRRaTY9u2dBKX49dVt7WtlgK
 VPQGCmTDwjrn9oeB4MdSyLT3V987W1lD5zRQjg8fKpYNuxUb2eEqbo5F68U2W9xHif8O912oFtD1R
 FKi6Ah9n4QSPw447PlJWzEHHNrCvP7wXVjqPhLMFjOk5Y2xRd8OhnhzSz/rc5UIqKfAoV00ozEEey
 6DTpJ7DIR8am8/Q0vPm1lPt18UzIa0pXONj3aGJC5XnF00jdRqPtZ1iNLyYL7xt9cSf9cVxVfxRRp
 VONJuLmQ==;
Received: from mail-pl1-f179.google.com ([209.85.214.179])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lijpx-00E84T-6M
 for linux-nvme@lists.infradead.org; Mon, 17 May 2021 20:27:38 +0000
Received: by mail-pl1-f179.google.com with SMTP id h7so3835906plt.1
 for <linux-nvme@lists.infradead.org>; Mon, 17 May 2021 13:27:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=aq56l47CCWeditDhAhqJsMZ7PBrfqrcnzwZQ7R+jeOY=;
 b=MITEAOd1UHc23sbWT8x9iAVIwUu9W+FcMvGhA194UBjnXvCWkekFPqcfwApeLJHjoy
 SaZpILBDM9yfduH/w5l13R9iVpTR3hyPwDcOSxEpHXhyfIN6JSMr+GAxivqpuykdDLE/
 4k2zncYpwJLXwGwcRzsyxKJtMiupNIy2IpjIqiU6zl4RexX2grBZKHKEWXyNOcFsOaVz
 MN1i49A2+B3Dq8eRzFM6XHYA6trhr1NzrQZK4+ETXrPno6etejDyMBb3rvBbDykfCmWd
 qCkmfFz7zzD5sX8aRNflgOJ9/vt/8Th/fhGhXORkl1KLeQJgRhOCcngLHyqC0rMOuE5/
 HW0Q==
X-Gm-Message-State: AOAM531lMYujv2P0yPh36RPsA4AcqzwGSTBnAvYtv1urFOW23nL6nVZ/
 6PuqNMZmScbIz5iKL6kL4cc=
X-Google-Smtp-Source: ABdhPJylVBZ/WmxArceLRkutj1BzbL/hjhObCJ8A14me9b3Q13kCBrdrPvajDWrJNpL2uM13XL5xzg==
X-Received: by 2002:a17:902:104:b029:ec:9fa6:c08 with SMTP id
 4-20020a1709020104b02900ec9fa60c08mr322053plb.10.1621283255232; 
 Mon, 17 May 2021 13:27:35 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:e600:1f8f:de79:17f9?
 ([2601:647:4802:9070:e600:1f8f:de79:17f9])
 by smtp.gmail.com with ESMTPSA id f18sm11302238pjh.55.2021.05.17.13.27.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 May 2021 13:27:34 -0700 (PDT)
Subject: Re: [PATCH 3/3] nvme: code command_id with a genctr for
 use-after-free validation
To: Keith Busch <kbusch@kernel.org>, Bart Van Assche <bvanassche@acm.org>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Daniel Wagner <dwagner@suse.de>
References: <20210517175955.602725-1-sagi@grimberg.me>
 <20210517175955.602725-4-sagi@grimberg.me>
 <0bd3f659-9691-4f25-6d3b-bdd19546186c@acm.org>
 <20210517194613.GA2709569@dhcp-10-100-145-180.wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <94cc18bf-e669-0253-263c-36cd9e9d2df9@grimberg.me>
Date: Mon, 17 May 2021 13:27:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210517194613.GA2709569@dhcp-10-100-145-180.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210517_132737_264518_84DE076E 
X-CRM114-Status: GOOD (  20.94  )
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


>>> We cannot detect a (perhaps buggy) controller that is sending us
>>> a completion for a request that was already completed (for example
>>> sending a completion twice), this phenomenon was seen in the wild
>>> a few times.
>>>
>>> So to protect against this, we use the upper 4 msbits of the nvme sqe
>>> command_id to use as a 4-bit generation counter and verify it matches
>>> the existing request generation that is incrementing on every execution.
>>>
>>> The 16-bit command_id structure now is constructed by:
>>> | xxxx | xxxxxxxxxxxx |
>>>    gen    request tag
>>>
>>> This means that we are giving up some possible queue depth as 12 bits
>>> allow for a maximum queue depth of 4095 instead of 65536, however we
>>> never create such long queues anyways so no real harm done.
>>
>> Is a four bit generation counter sufficient? Shouldn't such a counter be
>> at least 32 bits to provide a reasonable protection against e.g.
>> duplicate packets generated by retry mechanisms in networking stacks?
> 
> It has to fit in the protocol's command identifier, and that's only 16
> bits. Most of the bits for the tag, so the implementation uses the most
> available. More could be better, but that would require a spec change.

Yes, even if we can expand the genctr I don't think we should, we may
want to leave some bits for potential future usages. No matter how
many bits we allocate, we can't protect a 100% against everything here.

>> Additionally, I do not agree with the statement "we never create such
>> long queues anyways". I have already done this myself.
> 
> Why? That won't improve bandwidth, and will increase latency. We already
> have timeout problems with the current default 1k qdepth on some
> devices.

Well, if there is a use-case that requires queues that are deeper than
4095 entries, we have no space in the command to protect against this...

I also find it surprising that there is a real benefit for such deep
nvme queues...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
