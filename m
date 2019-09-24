Return-Path: <SRS0=cpn7=XT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5927C432C1
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Sep 2019 18:08:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0F49214AF
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Sep 2019 18:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OHclwtix"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0F49214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=XOleaLgRjYwGsjV/OF/LA7HugCRymcKgURdSeot36CM=; b=OHclwtixUOgYG/VCaAGLh4HoD
	SIWcb0mSm/G4oULW9v+sWX8as6DN7O32SkzEERYXRBE4jwfv427Y5WAYpENKQJVErbEw6pmwIleFl
	Y3Swk5bREt5NNdxQGUoRGZPvn+i7fFczLz8jScXBPGitUExDXtKzueoMtUios3YIq3NJYgQaQMaid
	2ny5bjJKlYVF+l/vK6U/MWMGL1AL0pCx4SNklhN43EryJ9ATBdIkQ67ZH4AxJpPzF4Mr81RxNh+0E
	AHPpXemTyq8lznLBk7UFzjXSl2EaTUVc7OZo5aLG06simPnq+sSOOPQ5/wTUTFGjipfa/Ku15+2xc
	YLHiGGQBQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iCpEc-0001Rm-19; Tue, 24 Sep 2019 18:08:22 +0000
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iCpEF-0001N1-Sd
 for linux-nvme@lists.infradead.org; Tue, 24 Sep 2019 18:08:17 +0000
Received: by mail-wm1-f43.google.com with SMTP id i16so1195951wmd.3
 for <linux-nvme@lists.infradead.org>; Tue, 24 Sep 2019 11:07:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AOhWCwdZH7LS7vl8GGNmjAhTRUuR1dDDZoIYqiSWkhk=;
 b=QlW9ZlYIyevduuQZB2E5aEHDPjMk9phywxQYFJGD0u2eYeAH4eiyRE8i/jQRFsmSDD
 nsY6Q4KgAMjbJVfkFdVvk7BVMsX6+xfvjHil3qSXhDBAltKmp48+oGfipSsMnV4ymzGP
 F2A/sdnFsY/pWn0UL3Od42Gt+xKJTJWjicpFyVHQ6dja/XwmT+utk2QH4rY7aElwN+AH
 fB0vUROxhA+P5TXosrVCwRjECR2tiHnTxIbD8HX4CmLzRjW6PaGKQeBHKcvKlvsal1HI
 21sVEvHM0EqsAc1dPYoWtEvCbT8QVb5ser3COBzWQdiQIjMMZrCYEKR81Nrds71pS2zW
 k2Bw==
X-Gm-Message-State: APjAAAUCcfpdkzauuNqUIqLOmR0yrIRzGk+W17gCUHgEG6YNtHTDUYLK
 Xd+V2oo3oN3R5tjfrerWu/8=
X-Google-Smtp-Source: APXvYqxIQaPBg6O7FUv3y3XNjiAyTsK6eLOABpoJWk/6gMktVsdsirL7B9Ff6e8xIk6ItYh3s2xNvQ==
X-Received: by 2002:a7b:c44d:: with SMTP id l13mr1451020wmi.160.1569348476162; 
 Tue, 24 Sep 2019 11:07:56 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id z4sm2645226wrh.93.2019.09.24.11.07.54
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 24 Sep 2019 11:07:55 -0700 (PDT)
Subject: Re: [PATCHv2 0/6] nvme: double reset prevention
To: Keith Busch <kbusch@kernel.org>
References: <20190919213431.7864-1-kbusch@kernel.org>
 <8cc6bc39-a060-3128-bf19-afb06a5c36ac@grimberg.me>
 <20190924150723.GA21929@C02WT3WMHTD6>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <fc948ff2-b5db-506a-a516-766e0dde5c02@grimberg.me>
Date: Tue, 24 Sep 2019 11:07:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190924150723.GA21929@C02WT3WMHTD6>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190924_110801_475334_EF13E29D 
X-CRM114-Status: GOOD (  13.20  )
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
Cc: Edmund Nadolski <edmund.nadolski@intel.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, James Smart <james.smart@broadcom.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> Keith,
>>
>> The series looks fine to me, do you think we need more eyes on
>> this or we should go ahead and apply this?
> 
> Sure, I think the series is okay as-is. It will clash with a fix from
> Mario, though, so one of us will have to rebase.

Mario's patch is already on the nvme tree, care to respin?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
