Return-Path: <SRS0=rw3x=BR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91614C433DF
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 00:45:05 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 799F7206B5
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 00:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ni6qT139"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 799F7206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5yvmECh+U+GBNcKhxbex3ghZkxGUa78B5TY/7WFFqZI=; b=Ni6qT139tFwlJypKCVdBIrEjE
	GkMYhGv+HFI7NB1iymdbmih2dDelJrw9BH3GQEmZDmuusvchltWn28A6WqDPDmNSKc+9BYac2Im4n
	DwCSVEumSBD/tcrXrRtLkG+ftA7kQbMAQlyXydmc1AF5iuPaLAgXTHbODE9Zq1Au48WGpEtZ8q1Tk
	kogrV503r+aZl6JHxcfrGqy4RaBLo0hv2xBPk8E9pfcoFF10UO9NGFenm1Obzg38lmNKC3KC6ksPc
	Y8gtyUju92kgRd131OqBx85+0Wzm0o4ysbwrxybkz7FE7Sj4Kf6xn9ylPwDnL2fAmhaQR1zD1KBhA
	fBxmllUhA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3qVJ-0001iZ-9C; Fri, 07 Aug 2020 00:45:01 +0000
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3qVG-0001hQ-Eu
 for linux-nvme@lists.infradead.org; Fri, 07 Aug 2020 00:45:00 +0000
Received: by mail-wr1-f43.google.com with SMTP id p20so126588wrf.0
 for <linux-nvme@lists.infradead.org>; Thu, 06 Aug 2020 17:44:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dfR9f0wlMILLb43P9erpIOx1JPpWqAF3IG4Zf5panFU=;
 b=nb60rsFv2vrhI9HqpeIMV5gMRhucmpJPNzEsfbCPrqoSejTQ1XfsRz2wgTMpl7t+kz
 +Z4CNUL9b8GwnyFK43XJC/fyzRU5xVSF1ahw8PAkjUORqbAoa2OgB7vPeJiV5pTRN89q
 tsVqfRsKlwWW3l60gb1lPFG7Lo7GH6iOs45ZVOU0CWqO1pIg+uDpseOKjdXPn4ChXspI
 /bIGGnZGLhdsJV7j3yhlV+c9Iu7bfdp3P06SHVakXBJDB9wHMSP0qiFrhWrAWwG1XjkP
 RsxW/r5JOGGa/CR1voHjzidJBiIgzaPOr0GHy7sMNDcDXtR2dZ9ZOegQm5w79mBLxJo0
 7c7g==
X-Gm-Message-State: AOAM530DL3e5T5hD1xN35mjnSz7nRe3DzGfFF+rkvkaayjUbV0tlTxYL
 uJXPDYV8tEaPyGR4OJ+VMZM=
X-Google-Smtp-Source: ABdhPJxi1CgTdBH+3G60LVpcm51gyKgtLhoq6f3FZye715RCsr9rAFnuICHtKDusoP0yV4xZULauvQ==
X-Received: by 2002:a5d:4907:: with SMTP id x7mr10362130wrq.166.1596761097316; 
 Thu, 06 Aug 2020 17:44:57 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:d88d:857c:b14c:519a?
 ([2601:647:4802:9070:d88d:857c:b14c:519a])
 by smtp.gmail.com with ESMTPSA id x2sm8837726wrg.73.2020.08.06.17.44.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2020 17:44:56 -0700 (PDT)
Subject: Re: [PATCH] nvme: restore use of blk_path_error() in
 nvme_complete_rq()
To: Mike Snitzer <snitzer@redhat.com>,
 "Meneghini, John" <John.Meneghini@netapp.com>
References: <6df01884-5498-0809-b358-0c9f7d775a73@huawei.com>
 <20200729055903.GC31113@lst.de>
 <43e5dee8-1a91-4d8b-fdb5-91f9679ddeb3@huawei.com>
 <8d01b123-478f-f057-1598-8283dd099b03@huawei.com>
 <20200805152905.GB1982647@dhcp-10-100-145-180.wdl.wdc.com>
 <255d55e3-f824-a968-e478-3efeda095696@huawei.com>
 <20200806142625.GA3075319@dhcp-10-100-145-180.wdl.wdc.com>
 <729820BC-5F38-4E22-A83A-862E57BAE201@netapp.com>
 <E3390A8E-D582-47BA-A085-21663D883365@netapp.com>
 <20200806184057.GA27858@redhat.com> <20200806191943.GA27868@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e140d739-1db9-83e2-c381-e68b24570d08@grimberg.me>
Date: Thu, 6 Aug 2020 17:44:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200806191943.GA27868@redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200806_204458_605155_989ADC9E 
X-CRM114-Status: GOOD (  13.10  )
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
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@infradead.org>, Hannes Reinecke <hare@suse.de>,
 Chao Leng <lengchao@huawei.com>, Keith Busch <kbusch@kernel.org>,
 Ewan Milne <emilne@redhat.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hey Mike,

> Regardless, reading back on this thread, I think there is at least some
> consensus about reverting commit 35038bffa87 ("nvme: Translate more
> status codes to blk_status_t") ?

We can probably make NVME_SC_CMD_INTERRUPTED an I/O error, its the
closest there is to something that is somewhat close to its meaning,
at least for some interpretation.. Although BLK_STS_TARGET is also
semantically correct from another interpretation.

> And on a related note, building on the thread I started here (but
> haven't heard back from any NVMe maintainers on):
> https://www.redhat.com/archives/dm-devel/2020-July/msg00051.html
> I'd also be happy as a pig in shit if this patch were applied:

I'll reply to the other thread.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
