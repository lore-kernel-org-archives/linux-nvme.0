Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C75EECDFA1
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Oct 2022 08:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5nl8uXxvLSlpL8nTxFfcKz9Rk4wiN1AtReEBVE5r49Q=; b=RbVygCWSDtHk4iZZ79dpah0Zq5
	sTEkjHTctjlMQCyASDJ2NGF5Zk3Do7yUMydDdiBgioQFUXPNDQk6YBFKj3b1C99/D3aG51ZH76Nqu
	GLWSu0KKeHmUCMkjUHecWiZI8mXLewxtr44/nU+GA3WtvhHkBMCzDfyn38+JyoVqbFmKq5CS02ma4
	lcdYQ2Eo7bHXawgaRBBJvO27nKguRygIvL0seFIR4NXMAku0ofekx7jtoRDH+3Ahvnn/vhRQjmPqt
	diqorwKhIeODWXcmdGYfypGFOzNO+eM8DEMBZUQMVXXWGwZZXeN9Dnag0+2DCiKvdm2gnFd+Y6mBk
	SsbZNHWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1omt3E-000D8n-DN; Mon, 24 Oct 2022 08:43:16 +0000
Received: from mail-wm1-f42.google.com ([209.85.128.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1omt3B-000D6V-I3
	for linux-nvme@lists.infradead.org; Mon, 24 Oct 2022 08:43:14 +0000
Received: by mail-wm1-f42.google.com with SMTP id c3-20020a1c3503000000b003bd21e3dd7aso9468738wma.1
        for <linux-nvme@lists.infradead.org>; Mon, 24 Oct 2022 01:43:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5nl8uXxvLSlpL8nTxFfcKz9Rk4wiN1AtReEBVE5r49Q=;
        b=Hh+OrvRL0b1+gmpyUMmffkF5DsOsLqZkPmNdznJrgg9ld2zhoTSpmf9VzxPCOyS/BP
         lzz5vYeK6KGMXR3ifUcV6T2aeinnXnThnvka8n8HgdlizmtyjWcUpJf8zIJelBMWR1ks
         LJOvwmhQxVvIm9M8pbSaerFkUwPX7QI5wjS1XrDWRzX3LHxgRmv3Zcfv2g3jmuumh9PH
         zz97QPpCcqRbQ0NdVp9b1tUWXB37wK6xQ1NjBirCaocEc4QrZtsoGLasuoN3D9zFOnnH
         pCp41OgU09PKk4eTibFY7AThYVOkV0fubKHX+r0kL0CqYLZWzQnB8b5omuupDtZAFqmq
         3yyg==
X-Gm-Message-State: ACrzQf0RRLffpw95pfmijZMG1y6ArlqxzlQZiBg26XUEMd1+5FaW4cAM
	LRy4//7JIlyfAgWtJ2KxoBQ=
X-Google-Smtp-Source: AMsMyM7cU24cXF9jl5CRz0itr0ES9hhFWmak90hM098d5DB+fmhzdY0B2UpiCMj/2SW9gAHejo84vQ==
X-Received: by 2002:a7b:cd93:0:b0:3c6:facf:1fa8 with SMTP id y19-20020a7bcd93000000b003c6facf1fa8mr22681746wmj.85.1666600990040;
        Mon, 24 Oct 2022 01:43:10 -0700 (PDT)
Received: from [192.168.64.94] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id v10-20020a5d4a4a000000b00236492b3315sm10520606wrs.104.2022.10.24.01.43.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 01:43:09 -0700 (PDT)
Message-ID: <7d93b4fe-f88b-2d2c-e58d-396e03f3bc72@grimberg.me>
Date: Mon, 24 Oct 2022 11:43:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 6/8] nvme: move the NS_DEAD flag to the controller
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Chao Leng <lengchao@huawei.com>, Ming Lei <ming.lei@redhat.com>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
References: <20221020105608.1581940-1-hch@lst.de>
 <20221020105608.1581940-7-hch@lst.de>
 <ac33021a-b7a1-37cf-b156-df021ac4de43@grimberg.me>
 <20221021132815.GE22327@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221021132815.GE22327@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221024_014313_624860_108EC496 
X-CRM114-Status: GOOD (  17.66  )
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


>>> -
>>> +	if (!test_and_set_bit(NVME_CTRL_NS_DEAD, &ctrl->flags)) {
>>> +		list_for_each_entry(ns, &ctrl->namespaces, list)
>>> +			nvme_set_queue_dying(ns);
>>> +	}
>>
>> Looking at it now, I'm not sure I understand the need for this flag. It
>> seems to make nvme_kill_queues reentrant safe, but the admin queue
>> unquiesce can still end up unbalanced under reentrance?
>>
>> How is this not broken today (or ever since quiesce/unquiesce started
>> accounting)? Maybe I lost some context on the exact subtlety of how
>> nvme-pci uses this interface...
> 
> Yes, this also looks weird and I had a TODO list entry for myself
> to look into what is going on here.  The whole interaction
> with nvme_remove_namespaces is pretty weird to start with, and then
> the code in PCIe is even more weird.  But to feel confident to
> touch this I'd need real hot removal testing, for which I don't
> have a good rig right now.

Lets for start move the bit check up in the function and reverse
the polarity to return if it is set. Unless someone can make sense
of why this is OK.

