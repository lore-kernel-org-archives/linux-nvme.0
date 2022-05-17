Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F232C433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 17 May 2022 12:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1uiV+/OW5vkI7AHd2Wa28lJ4JD7OHBmnUD2QtGz8rrk=; b=nHrZSQG9G4nCen92c8gARx0ydL
	Oj1jAV4ist1MtF14gRs5sn4hTvmstehRm6C9OU/EX1DXJ/VEzjyj8jf6Hf0MzWLkLM2SIi1FCoxPo
	eaV4DLt7P1BbDDyMKWIEmeCYaDDuzR8nfuoAiNC/1GtHAGwJ0kApZFP/YEIWhjS7fKBrXa7JOSCyO
	6379zN69m2ZupNAzSftiBdV7ob66FjKhiRlmMhD2y9PcUH5tnCarN7P/YeqbkGjgOVjyVgSXtr5t/
	fzSWIbztPmh5VSgKJyEWf/txc7ErorbV1Dvfn2BWYF4MPVdtBNt3G/XTuHz8m3phldipCNr7zYr3l
	fjQRb69Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nqwgf-00Dgxi-7P; Tue, 17 May 2022 12:52:29 +0000
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nqwgc-00DgwE-Tl
 for linux-nvme@lists.infradead.org; Tue, 17 May 2022 12:52:28 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 k126-20020a1ca184000000b003943fd07180so1214036wme.3
 for <linux-nvme@lists.infradead.org>; Tue, 17 May 2022 05:52:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=1uiV+/OW5vkI7AHd2Wa28lJ4JD7OHBmnUD2QtGz8rrk=;
 b=dLnGmzzc9lg30j5SVIlFkAYpNArItj5JHszREZ2wRvPi9KFnaj6GU3Qf7P2XY07JnB
 ZWDU/ggfx+gqxfIlL5G6KCFEnrAhOGkHOtSZN5m+kzaXbDdXoIPpaJYzQkdlb8IMNGUG
 UQ6uQrhTq7YZk7ZdzySAaz+RDSeuRv2RcJKE1wWffD+PzcsmRu95iXjOR1NMPtVg05jO
 pbKa6DkVKYu+BZvR088mZLBhei/azYUqCSr8TVlHaVEs8p8mj5nVsp5yRBbhuOWbi+eV
 xvLfVT1ORnTedVsgD2Sr3d9py1NVbfYsvVFC6qIdacyDF6m/LeoiWgmex6CGy+Su7DhG
 grYg==
X-Gm-Message-State: AOAM533lWnClCl38dW2gLHHIcwdQ5uLHkoG+hCHTzQDcsG/XOV+DxW0i
 UaWwfSz39bW7OInp6qFnyW0=
X-Google-Smtp-Source: ABdhPJy1y6m7zBFWaH0D4Jt0E4QON0mKtZL/Ic+qFLx+a3MdTKKzc7Kr6A9y8cDDrk/S2x9VQR9zKw==
X-Received: by 2002:a05:600c:5112:b0:394:55bd:5f9d with SMTP id
 o18-20020a05600c511200b0039455bd5f9dmr32370012wms.188.1652791944213; 
 Tue, 17 May 2022 05:52:24 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90]) by smtp.gmail.com with ESMTPSA id
 m19-20020adfc593000000b0020c7ec0fdf4sm14991038wrg.117.2022.05.17.05.52.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 May 2022 05:52:23 -0700 (PDT)
Message-ID: <b5f0557f-bccc-e19f-bf66-7de1f891b6e2@grimberg.me>
Date: Tue, 17 May 2022 15:52:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: kernel panic due to a nvmet race
Content-Language: en-US
To: "Engel, Amit" <Amit.Engel@Dell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: "Grupi, Elad" <Elad.Grupi@dell.com>
References: <CO1PR19MB4885A916016D38EF6CFD07B6EECE9@CO1PR19MB4885.namprd19.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CO1PR19MB4885A916016D38EF6CFD07B6EECE9@CO1PR19MB4885.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220517_055227_007609_981715FC 
X-CRM114-Status: GOOD (  13.37  )
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


> Hi All,
> 
> We observed a kernel panic which based on our analysis is due to a nvmet race.
> the race is between nvme connect and nvmet tcp port removal.
> The scenario:
> In case that nvmet_port_release is freeing the nvmet port just before nvme connect is trying to 'nvmet_find_get_subsys' (as part of nvmet_alloc_ctrl) nvmet_find_get_subsys is trying to access a port which is already freed:
> 
> nvme/target/core.c:
> static struct nvmet_subsys *nvmet_find_get_subsys(struct nvmet_port *port,
>> ------->-------const char *subsysnqn)
> ...snip
>> -------down_read(&nvmet_config_sem);
>> -------list_for_each_entry(p, &port->subsystems, entry) {
>> ------->-------if (!strncmp(p->subsys->subsysnqn, subsysnqn,
> 
> crash> bt
> PID: 30216  TASK: ffff888c1e163f00  CPU: 0   COMMAND: "nt"
>   #0 [ffffc90020153858] machine_kexec at ffffffff81062fcc
>   #1 [ffffc900201538b0] __crash_kexec at ffffffff811273ef
>   #2 [ffffc90020153978] panic at ffffffff810851f7
>   #3 [ffffc90020153a18] no_context at ffffffff8107104f
>   #4 [ffffc90020153a80] page_fault at ffffffff81801184
>      [exception RIP: nvmet_find_get_subsys+161]
>      RIP: ffffffffa0bbce01  RSP: ffffc90020153b38  RFLAGS: 00010282
>      RAX: ffff888c1e163f01  RBX: 0000000000000000  RCX: 0000000000000020
>      RDX: 0000000000000000  RSI: ffffffffa0bc5895  RDI: ffffffffa0bce040
>      RBP: ffff88aeafc3f520   R8: ffffc90020153ba0   R9: 0000000000000000
>      R10: ffffc90020153bf8  R11: ffff888cb8e97b00  R12: ffff888bb3469a00
>      R13: ffff888bb3469900  R14: ffffc9000c41ba70  R15: ffffc90020153ba0
>      ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
>   #5 [ffffc90020153b58] nvmet_alloc_ctrl at ffffffffa0bbe4c2 [nvmet]
> 
> Can you please review and provide your inputs ?

Indeed it seems that nothing is preventing this from happening..

The main issue is that ->remove_port() currently does not
guarantee teardown of all the resources, it is just triggering
it asynchronously. At least this is the case for tcp/rdma (and
appears that fc as well).


