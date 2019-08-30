Return-Path: <SRS0=Ir45=W2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D6CC3A59B
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Aug 2019 18:04:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E499823407
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Aug 2019 18:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="imET8y+L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E499823407
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=nx1C84sF+gdRlQn27aaTs3iBYppw+TjVcPje+MQSi9s=; b=imET8y+L335KgPNC0H3lKKB4R
	8vijNzDPtV0nLY80wkNLalSsACKy+SAwjX+lGz1/NI3Ni2rE6BMTQTkHFe6M684orkMNWxJOehG0U
	nt5Rs95a6ZZNtsG3OUY9UC27/OLOySajaFkjXtyAgP0gkSebjptXVj2ck6HmRY9g5NPr0i7p2479f
	tTM0G5A/IAP7yywrtc22gHzKMJaVnoTc8zb61P09/UGYIUM6zvbbTwZLcnzCCEXZkrRsZnS2wtS64
	aGfkx+sJWlJ5F09KbiBM0dVqo1kX3H7UfPKtW8pbDqtBvQet9+qRdXhxAAFbkwhlw1V3+cGiPsYiN
	CeHkS3cRQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i3lFh-0007xS-4Q; Fri, 30 Aug 2019 18:04:01 +0000
Received: from mail-ot1-f68.google.com ([209.85.210.68])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i3lFe-0007x9-N7
 for linux-nvme@lists.infradead.org; Fri, 30 Aug 2019 18:03:59 +0000
Received: by mail-ot1-f68.google.com with SMTP id m24so7714267otp.12
 for <linux-nvme@lists.infradead.org>; Fri, 30 Aug 2019 11:03:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=y1bfrqZMtyKtHjROhmA58gn9KXYuiOk3sj5GqbPU8gw=;
 b=iVl7I+2BPpdgRb3stkXAgXekSBq+Iyb3wECiq75rGmFEnEkfKed61f9vAoQBFTHYFN
 m7W5yUEJCADLMR8N800bKmOrrtlk76a0kAMHGACd7LyccA80qP793oMeAcSvirmRwEfj
 xB4r+fthAs4exKoPLtM6VyaXpxS6yllXwSV0yoOUJXH5/WmbNI6n63lLCgAbw5kyVPq5
 4NIGfD1Wf8f7Q/jyegtXSCpHXfIU19DYsMWQgPTjItsMzVsRYa6ciHi4LlN5q8UXDFES
 37CJcL9erz66pYOPR8YtIfYxXMgskRo7zSkFUEycQs0m5QE4Xi/sk+eSF5C/HnjC82Fy
 bfKw==
X-Gm-Message-State: APjAAAVrl2Zss8Gg1vsa1OOkg/MhzNs7npnopjLUGH97HKBj/tOS1QUe
 o/AxwA3TT5Rf0YGsjRrd5HE=
X-Google-Smtp-Source: APXvYqxPbsBJCsHpu8LtT2okpPAqMcYZjhdWXoXxgWzbTQcsoKurr7wwQakl4zPxHK98dJOcFz4C6Q==
X-Received: by 2002:a9d:340b:: with SMTP id v11mr13688804otb.317.1567188237748; 
 Fri, 30 Aug 2019 11:03:57 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id f31sm1187488otb.81.2019.08.30.11.03.56
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 30 Aug 2019 11:03:56 -0700 (PDT)
Subject: Re: [PATCH v8 7/7] nvme: fix ns removal hang when failing to
 revalidate due to a transient error
To: Christoph Hellwig <hch@lst.de>
References: <20190823055442.19148-1-sagi@grimberg.me>
 <20190823055442.19148-8-sagi@grimberg.me> <20190825013813.GC23887@lst.de>
 <20190825205700.GA3911@lst.de>
 <a7dca3f1-5b51-ac6a-cfee-2cb8a5e3718d@grimberg.me>
 <20190830055435.GB8492@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <b4fbecce-f647-71c2-45fc-00352734e4ca@grimberg.me>
Date: Fri, 30 Aug 2019 11:03:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190830055435.GB8492@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190830_110358_763181_24D30021 
X-CRM114-Status: GOOD (  12.87  )
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
Cc: Keith Busch <keith.busch@intel.com>, James Smart <james.smart@broadcom.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>> After looking into various revalidate_disk refactoring I think we could
>>> do something simple like this to just ignore the non-fatal errors
>>> (won't apply as is, but you get the idea):
>>
>> This will quietly ignore errors even for the routine ns allocation path,
>> do we want that to happen?
> 
> Why not?  Why would we treat an -ENOMEM or transport error different
> when doing a scanning (e.g. because we have to reconnect) vs just when
> revalidating?

OK, I'll give that a shot because I think it solves the issue as well.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
