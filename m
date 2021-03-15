Return-Path: <SRS0=15CP=IN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A4D2C433E6
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 17:42:16 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E29E464E41
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 17:42:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E29E464E41
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=D/u/y+i1qMwFcGAwqVWKU03XGPRlghvL0Pt8Wlm3AjQ=; b=K5Jd4vvq23jrg0Pib34C2SekM
	tcU7vb4aENSr6lzFMRh1jm5i8TCdwO6ZLsTe5yZdIQ4LSuOVIpQtZm0X4BkNnEV8+Yrewwc1TMj1M
	OxkRdPhuNLKU/2eUe2WsAxqzijHL0wPtrs1xryj2mVe+pCXHFGkQi2oST1E2LUmNtfd0lxgJO4M4M
	JTle3nBc0VJhOxf6Jd+60eIwGjWuh2U4RUWC+cEw/FFj9WVreThEHz6JLMa5I3i1bqYKb4anGXlpd
	rrAfLgp3/p90F1Xx//hid+9S5C3X/tKHQ/954Mfnj1/JzHl90K0PsjLK2NXEGuqBZMQfyMeISs1ax
	g+MLgWMnA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lLrEG-00GZ3k-E5; Mon, 15 Mar 2021 17:42:08 +0000
Received: from mail-pl1-f169.google.com ([209.85.214.169])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lLrBA-00GXnv-LW
 for linux-nvme@lists.infradead.org; Mon, 15 Mar 2021 17:39:03 +0000
Received: by mail-pl1-f169.google.com with SMTP id 30so11104824ple.4
 for <linux-nvme@lists.infradead.org>; Mon, 15 Mar 2021 10:38:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gHyzcvVBnAqA4Cp3d4kUgXNKcT5Rl6hrHw6+nxNIupE=;
 b=dQMEb1kRIeS0acYgyKT23NmJNykqob/4iofXvYfufzQqZPNTK/Fh/0JvVxNuUT6DXX
 s/YtLqUOvbHYI8TZTjVAyFHFm/rjIVOAa6VDBwhiMB2T1U3Qs/h1pC3DupeO6VmDmgal
 oU6RXnA93IyD/9Hy2QGHzXDhK6vPgz0Jjnj6lifCh4PS1c7WuDsegwgAhe21jD5FYhnQ
 Aq3zcWJ6Bb1Mg3RIyEXxQ2zmHULTXPVfgC6fF0M7dnsLAcASc0CPFCOxcyody7bU/kxD
 Ew1f8yT7tKeJWkiPxAy9MqcMv2L3mL6HaW1JJqaS3G+Vv2A3d14j9SNk2+nEQd9Cd+5u
 E8pg==
X-Gm-Message-State: AOAM5327ihTdqPnrTysBH2b7EBsJlsKXv0vwfe9nOYI+LLBqLHMpUY1E
 759IlW718/8AsQws3oewChHeYpE2FVQ=
X-Google-Smtp-Source: ABdhPJz++GUvSh4Xe4HIX4eccC23XSIdHx3nfQPeN8SoAZDdH3WHtNyKlnZHCTlsgDb16YaZRkl+uw==
X-Received: by 2002:a17:90a:ba05:: with SMTP id
 s5mr206946pjr.194.1615829935213; 
 Mon, 15 Mar 2021 10:38:55 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4faf:1598:b15b:7e86?
 ([2601:647:4802:9070:4faf:1598:b15b:7e86])
 by smtp.gmail.com with ESMTPSA id fv9sm261791pjb.23.2021.03.15.10.38.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Mar 2021 10:38:54 -0700 (PDT)
Subject: Re: [PATCH 01/10] nvme-discover: lookup existing persistent
 controllers
To: mwilck@suse.com, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org, Enzo Matsumiya <ematsumiya@suse.de>
References: <20210306003624.21102-1-mwilck@suse.com>
 <20210306003624.21102-2-mwilck@suse.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <b7f98f09-c21d-579d-c925-5b511796c7f5@grimberg.me>
Date: Mon, 15 Mar 2021 10:38:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210306003624.21102-2-mwilck@suse.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210315_173857_043014_E85ABB05 
X-CRM114-Status: GOOD (  12.25  )
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


> From: Hannes Reinecke <hare@suse.de>
> 
> If persistent controller connections are present they should be
> preferred even if no --device option is given on the commandline.
> To avoid selecting a temporary non-persistent controller the
> 'kato' attribute is checked; any controller which does not have
> this attribute or for which the attribute is '0' will be skipped.

Why?

You also need a fallback in case kato is not exposed in prior
kernels.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
