Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8605FC6FD1C
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Mar 2023 07:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v6J3+QauBWL5ndTBnzt0rTm716Q0+7hRHA2BOFMAJ0E=; b=vT4bsL1vflAlIdxjl3+uIkWt2E
	KvXWAdTwVzcYfor0MBOKtb62wrOCMqoN19QpE6JohIItiaojfnjeqoNrR4P+c65ymstEn6JFgCdK7
	nlw/rhE8OrScvxU744We65JXEPoTv3G0N92Hz3M2HGqoomhMR5pHeDT9/M764Q6Xph3MVF4rvSL9X
	P0j9rZcJpAUonjNEX9Jv3aezU2AIIFY9h22IQPA0Npg/gAZazSojP6yDjD+Y3U8YGFhC+CzWzIUkb
	MmHRvPDe5Go0WTfpH6MAS1ZI/dFWQqx2rodVSXQEZInAQBqXq67urBw8JRLBJrGLx4kRsugD9XVjb
	EJBw2OVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pgKiX-0087y5-0B;
	Sun, 26 Mar 2023 07:23:05 +0000
Received: from mail-ed1-f44.google.com ([209.85.208.44])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pgKiV-0087xh-0r
	for linux-nvme@lists.infradead.org;
	Sun, 26 Mar 2023 07:23:04 +0000
Received: by mail-ed1-f44.google.com with SMTP id cn12so23833860edb.4
        for <linux-nvme@lists.infradead.org>; Sun, 26 Mar 2023 00:23:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679815381;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v6J3+QauBWL5ndTBnzt0rTm716Q0+7hRHA2BOFMAJ0E=;
        b=VlguXdntXqcbR5GfHstm39nJi+zrtbWW4YZxTyvBmX2b3KOKmpY4+2eHyx8AatJozW
         JEvWVsV043UVyqxQ9pPaDYpR2cz6vji10iIIeQ1xbUbcT3MLgdtAbbmnoneJZonIRDXJ
         WyDL1G2yQcUY5mLlj1e7HFV+lz/2hvMD3nhwfX4fml7GFHZLY8eJfpIze7T8Bo+u/Ecp
         29OQ3H/Nt9hYD1wSZ8+LtMwN8iQ115cpGwYmH1jQ8gze+kc5z7g+WAeUblcEne3cZsEp
         tNoEppWw0EWzeOEa3QmAZEPJjS1CsaBbqaVW/a6z8oj4eomCa4pj2fUfUvFjcxgJIgfs
         Pr9A==
X-Gm-Message-State: AAQBX9eB69o+DAA+J2O6tUR2wHwSJzwxlxlQhHjp5XwN8N7Bx6EbgEgl
	zcKeZO8nwJtg160Vgqq818U=
X-Google-Smtp-Source: AKy350ZpcW6zhhI50Bk1HbnXjRhJazUGQH6gnzeZsd2XjMeH9nHTo6H7e+VMJF8fAeK+apwK0ZKneA==
X-Received: by 2002:a17:906:5303:b0:930:180f:db19 with SMTP id h3-20020a170906530300b00930180fdb19mr7627802ejo.6.1679815381463;
        Sun, 26 Mar 2023 00:23:01 -0700 (PDT)
Received: from [10.100.102.33] (109-186-69-235.bb.netvision.net.il. [109.186.69.235])
        by smtp.gmail.com with ESMTPSA id l14-20020a170906644e00b009353066595csm8995405ejn.136.2023.03.26.00.23.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Mar 2023 00:23:01 -0700 (PDT)
Message-ID: <aa985b18-5ee8-2af3-24a9-b04eaa756a0b@grimberg.me>
Date: Sun, 26 Mar 2023 10:22:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/9] nvme-core: use uint type for shutdown timeout
Content-Language: en-US
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
 "hare@suse.de" <hare@suse.de>
References: <20230323033636.812758-1-kch@nvidia.com>
 <20230323033636.812758-2-kch@nvidia.com>
 <5639f28e-ec89-f2f8-5737-8209b36088e9@grimberg.me>
 <2745623e-2b0f-edf3-2cf1-7a8ca9415545@nvidia.com>
 <3584deb2-1bdd-4980-b2e7-a87067302118@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <3584deb2-1bdd-4980-b2e7-a87067302118@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230326_002303_307323_3D9A2929 
X-CRM114-Status: GOOD (  10.23  )
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


>>>> Use consistent type unsigned int for shutdown_timeout that matches
>>>> other timeout types.
>>>
>>> Does it make sense to allow shutdown timeout to be that long?
>>>
>>
> 
> thinking on the same line do we really need admin and io timeout
> values to be unsigned int (sizeof(unsigned int) = 4 bytes on
> my machine ? as this value is in seconds 0xffffffff is way
> to long wait to finish admin command..
> 
> perhaps we should change it to u16 for io/admin/shudown timeout ?

I think we can leave the io/admin and shutdown as they are.

