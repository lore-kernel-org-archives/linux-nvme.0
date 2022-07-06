Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2403C433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Jul 2022 15:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A8vqba4NnweGXupGCchYZa0RxtHVuOldVd2BKTFhsw8=; b=IKb4MkK7rmA2k5uFS8Dg35exhw
	2L4v0rYM6JDQHHEAWZ88RpywpOEtx8t5QEcqresgUnM7G2/wM5h/Vhdm9AMMq+q5DtNvyVuDrcIfA
	tgly4Ce5WDpmz1YcStv/VD+bpiVUZ9uRI588QlFe0mARTWBB5MxHS6wRtPelYPTCKhCnLdFVEO2+w
	Rz/7U3jgAyWyHtkOkVFVp9RJXnpKCKtZAu03HLe/svy8lvtJxAp5ft+/Rg3pTaKTpFKuf72Uoc6XM
	tklsMiWy8P+YkoQ9f8zkPYWNcNN16u8lpxuyySBBNwumWcGFroOTJmvkJ1bzwNF11e1iBIo9pztZI
	M2RO1kFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o978F-00B6Hb-Vm; Wed, 06 Jul 2022 15:40:03 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o978D-00B6D7-IQ
	for linux-nvme@lists.infradead.org; Wed, 06 Jul 2022 15:40:02 +0000
Received: by mail-wr1-f51.google.com with SMTP id a5so7934032wrx.12
        for <linux-nvme@lists.infradead.org>; Wed, 06 Jul 2022 08:39:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=A8vqba4NnweGXupGCchYZa0RxtHVuOldVd2BKTFhsw8=;
        b=ucdvzqloXuRb6E9J6PjAZIEtVQzAKC6h4NOvfexTXFGFPKcTo3/gjE9+BoB5N5WSvF
         k62DASIKyvFIkocV1/cV0YQO7w5WUGkzUkuLNs47+ZizqZqz/o+XKlNxu8zD+HhQ127B
         NymvcQBzaLRPPakOpM8OFBOyL/LMA7P9NKYBLuPD13DJSBkMBd6JQ7PPjhiobXS0ifwj
         tQnhjb4/QJZwxdatepfSMFeQoZHmoNdnXWlOmL7nrK7BIeV7GDyXPYELnjUZi2NZJF0y
         jw4Wi1EekcM2PeBmjghBk8BzGE6ABPmw5AGQZsJr6Sshu+hD3exV3MIi2Sa0RwLqU47c
         rMhQ==
X-Gm-Message-State: AJIora9cVbqnzA7nn0nSoGP+UAQ8vFJkKFdeMv5FoX/iKZPeQFiglVSG
	UVpQLryopW24Jkc2ZnpfURs=
X-Google-Smtp-Source: AGRyM1tHSlcBmTr7K1xePwN9/q5cYXhxjV/DhZQER8Z37YJX7L3IhZPVd6nrNl7f/2o+ejV4uHHrNA==
X-Received: by 2002:adf:ed44:0:b0:21d:81a3:d78 with SMTP id u4-20020adfed44000000b0021d81a30d78mr798470wro.677.1657121998195;
        Wed, 06 Jul 2022 08:39:58 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id c7-20020adffb47000000b0021b9504cc83sm36199929wrs.31.2022.07.06.08.39.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 08:39:57 -0700 (PDT)
Message-ID: <02683c5f-a3e2-667d-7234-9fb29cf659b9@grimberg.me>
Date: Wed, 6 Jul 2022 18:39:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCHv18 00/11] nvme: In-band authentication support
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20220627095207.105201-1-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220627095207.105201-1-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220706_084001_667339_754689A6 
X-CRM114-Status: GOOD (  19.23  )
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


> Hi all,
> 
> recent updates to the NVMe spec have added definitions for in-band
> authentication, and seeing that it provides some real benefit
> especially for NVMe-TCP here's an attempt to implement it.
> 
> Thanks to Nicolai Stange the crypto DH framework has been upgraded
> to provide us with a FFDHE implementation; I've updated the patchset
> to use the ephemeral key generation provided there.
> 
> Note that this is just for in-band authentication. Secure
> concatenation (ie starting TLS with the negotiated parameters)
> requires a TLS handshake, which the in-kernel TLS implementation
> does not provide. This is being worked on with a different patchset
> which is still WIP.
> 
> The nvme-cli support has already been merged; please use the latest
> nvme-cli git repository to build the most recent version.
> 
> A copy of this patchset can be found at
> git://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel
> branch auth.v17
> 
> The patchset is being cut against nvme-5.20.
> 
> As usual, comments and reviews are welcome.
> 
> Changes to v17:
> - Return error on authentication failure
>    (reported by Sagi)

Hannes, I think v18 is in solid shape...

On the series:
Tested-by: Sagi Grimberg <sagi@grimberg.me>

