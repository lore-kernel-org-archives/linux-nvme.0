Return-Path: <SRS0=ZbIm=I7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7BA9C433B4
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Apr 2021 17:27:27 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4753661155
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Apr 2021 17:27:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4753661155
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wX8ajcWjGMxtMr0t811R/iVFP0kUcuTXbSX/c5kMes0=; b=LtnaeZHGzHumWyMRPImufFX5k
	389RiWfmDlkpwK7d33TT9WpOZkW3kUGvzdNoQQSOa7MTYAd/NN54uARnBMUXhg9XLuycOMw1nI+g6
	rsyQAtTNQFoh9hYTXmtGPJKT2TfyqMRMl1DVodUrYmNrWFFCxY2DE3F5pvQ3fiWbTQICCpMJMJypl
	Gb9s5uaw7QETG61v7QeN3LD3TNCypRc2JBfwO6VVD0poDjTA5eyfla36LQshPHmbfIUQ3VQ7V/We8
	gTlcUEyDNXTj+wHRn27Wv/jqyriMqDBPI+S3bF1FBLFAKDo4ChNGIWAYNztZ1s4JBSKCYO9V2fY6z
	h439LlKhw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lSNZn-00DV0O-CD; Fri, 02 Apr 2021 17:27:19 +0000
Received: from mail-pl1-f182.google.com ([209.85.214.182])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lSNZj-00DUzm-1Y
 for linux-nvme@lists.infradead.org; Fri, 02 Apr 2021 17:27:16 +0000
Received: by mail-pl1-f182.google.com with SMTP id h8so2787478plt.7
 for <linux-nvme@lists.infradead.org>; Fri, 02 Apr 2021 10:27:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ul2j7pNBSBXsX8XVZrl3noith5/EY8lqOPmaPjizuHA=;
 b=pbdCbuiu4iA9PupYpl2XZVRlWnPnYnUVxJgEOrR0YC70NOJpzhQx8NkcVpIasRNVWo
 8PkeJKSPvggfbc8eA97WPhzsdh18lcYo7AKzUjaBY/3BPhSuoWuvFSm2RTpYnd/IItCV
 GgmDr1TFgLPnh7RViCd2syh8wEchzGGMcwtfUyuXjLeH3RWEasIz3DwBozfyN6IkIK/y
 E+GJwAYuH/irudTgHKxO5oFPRREi6or/ahzagS+u1o2QZ72ZhBKJEi4iUCnbUxNumK9F
 aMiIShzMfwfzEGgi7SNmm6UOj/+A015uNx3H8iD+gO9Bpo4g6p78oCItEn4JfBCUeq2b
 qCiA==
X-Gm-Message-State: AOAM532DpkZp3tuiJA5v3YT9dbB4V/KMpbAoBZQUzP4/lPONBX+rzJI5
 J6zm+QvA13MJgGfXHN0fgQ4=
X-Google-Smtp-Source: ABdhPJx3o81zaZksZiDBbRgKR6nKrk8cYlB+hougtZsce4wBuZ8sIX3/2bePWOkeIbnVPfvTigGROg==
X-Received: by 2002:a17:90a:598e:: with SMTP id
 l14mr14424176pji.187.1617384433136; 
 Fri, 02 Apr 2021 10:27:13 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:de32:cc5:ecd7:105c?
 ([2601:647:4802:9070:de32:cc5:ecd7:105c])
 by smtp.gmail.com with ESMTPSA id w84sm8828252pfc.142.2021.04.02.10.27.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Apr 2021 10:27:12 -0700 (PDT)
Subject: Re: nvme tcp receive errors
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de
References: <20210331161825.GC23886@redsun51.ssa.fujisawa.hgst.com>
 <0976ff40-751e-cb95-429a-04ffa229ebf0@grimberg.me>
 <20210331204958.GD23886@redsun51.ssa.fujisawa.hgst.com>
 <20210402171141.GA1944994@dhcp-10-100-145-180.wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <53a11feb-bc49-d384-3b7b-481a0dfc70e6@grimberg.me>
Date: Fri, 2 Apr 2021 10:27:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210402171141.GA1944994@dhcp-10-100-145-180.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210402_182715_207092_DB7934F5 
X-CRM114-Status: GOOD (  13.44  )
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


>> Thanks for the reply.
>>
>> This was observed on the recent 5.12-rc4, so it has all the latest tcp
>> fixes. I'll check with reverting 0dc9edaf80ea and see if that makes a
>> difference. It is currently reproducible, though it can take over an
>> hour right now.
> 
> After reverting 0dc9edaf80ea, we are observing a kernel panic (below).

Ah, that's probably because WRITE_ZEROS are not set with RQF_SPECIAL..
This patch is actually needed.


> We'll try adding it back, plust adding your debug patch.

Yes, that would give us more info about what is the state the
request is in when getting these errors

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
