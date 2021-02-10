Return-Path: <SRS0=Gy4h=HM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B07FC433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Feb 2021 22:35:03 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0546364E42
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Feb 2021 22:35:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0546364E42
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=fBJSI1nIsNIGCO4D3kdc04Gm5xvyK5HDKSzmxPacNic=; b=sE774x4w1g9iW971Dwj0YHOcv
	j5AO/9B1uHa6myCatsZVhLu7etu6e2LBF9cpjSkMkH63kGOktRwQHu19aIGmHJJRX/VOraFR8uwkC
	jjRm6dbk+x1KLUtW+k8WEfZBkuwyBXeff9h9A0PMQjVpKFIu8QN0so8UGuXWB8e0RjoNRR3LtgcXN
	4xDcuUxU9AIAkWMO5P26y9hHR9ZljXLzGGAD6dgMRfR4khC6/gbDMtrIeg5voQfYumLUoP3zDNkep
	z0oncFrV0O7MOOK8FH/5G69hZOpW9Q9Kee32nNWCj5vU+auyyzS8Jtdx8C1XGhrsD3foJAfXb2bCY
	L7kpzZvsQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9y4Z-0006sm-6U; Wed, 10 Feb 2021 22:34:59 +0000
Received: from mail-pl1-f181.google.com ([209.85.214.181])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9y4X-0006s1-4L
 for linux-nvme@lists.infradead.org; Wed, 10 Feb 2021 22:34:58 +0000
Received: by mail-pl1-f181.google.com with SMTP id a24so105810plm.11
 for <linux-nvme@lists.infradead.org>; Wed, 10 Feb 2021 14:34:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rNpmYZPfLsgih6Kv9xdPiD2/eloJljfEPpTnP4IBfQo=;
 b=qiLBsuttf9GNNHWpFR5hqKyen9dag4vbvPkEp+6f33JNqbLSH4f7VsTxDPz0YCYEP+
 X2YZSiOvk6sAr1SahosqmoINUpUHwoqYeuP6JCDuz8fAlUG9fVwVOXY+0oleW7oEH1o/
 QPERBb6eFLLtTip0WInne7ilD6+thJlpBhP5nqj3pqqpi9bNrNj7fThREaHJjbEz2Zvi
 oO+BfffyYNgSsJkN5Cd5wHX/4WD7VMFN5wxarIQIqnl/5ELDyLsqSEDvXSUJ1DiTjC4f
 ZFrTXeFC+H505yWo82oPU4WCfnrOX/UO8ArbR6n9DkwsocuuOv+4NjlbEeduBfLNI2A5
 +YJg==
X-Gm-Message-State: AOAM5333Y6SQvVux7KUl/9vtbH13H8X1lOisIOX3eEZPX07GxeSXQw6o
 5K8DRJmlE1HH10d3hByXR7k=
X-Google-Smtp-Source: ABdhPJwzDkeKNe5o+1HbfmxVz25FpmMyh2v+AHBe7wCd+Ck2rIIaPOsA43U3nJTtRG+IVhsEqXfVAg==
X-Received: by 2002:a17:90a:e2ca:: with SMTP id
 fr10mr1074078pjb.118.1612996495878; 
 Wed, 10 Feb 2021 14:34:55 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:d52b:e830:d3b2:ec6f?
 ([2601:647:4802:9070:d52b:e830:d3b2:ec6f])
 by smtp.gmail.com with ESMTPSA id m23sm2900167pgv.14.2021.02.10.14.34.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Feb 2021 14:34:55 -0800 (PST)
Subject: Re: [PATCH 1/2] nvmet: don't check iosqes,iocqes for discovery
 controllers
To: Christoph Hellwig <hch@lst.de>
References: <20210209101235.1539917-1-sagi@grimberg.me>
 <20210210101037.GA26576@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <bf05392c-8c92-d6c2-d9f9-a22ac23bc338@grimberg.me>
Date: Wed, 10 Feb 2021 14:34:54 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210210101037.GA26576@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210210_173457_249528_62B5B03E 
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
Cc: Keith Busch <kbusch@kernel.org>, Martin.Belanger@dell.com,
 linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> +	if (!ctrl->subsys->type == NVME_NQN_DISC &&
> 
> I think the normal way to write this would be a !=.

:)

>> +	    (nvmet_cc_iosqes(ctrl->cc) != NVME_NVM_IOSQES ||
>> +	     nvmet_cc_iocqes(ctrl->cc) != NVME_NVM_IOCQES)) {
> 
> By the spec we'd need to check these are 0, but of course we'd break
> the existing Linux host.  Maybe throw in a comment?

Sure, I'll add it.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
