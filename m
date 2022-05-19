Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C410C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 19 May 2022 15:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rj0LLD+GhcnwrTRHq/dFr3Mwh+FjHxEzsjGfPynBta8=; b=elTSbJ6zv2beXI0uzN34MQtTQ4
	fH/G65F6ctz4oFAHQX2U6edV8bOZLFCgT1juSQsbyK7Zcrilob6HqzXQsEwwCh2lR815ybNHgOHlL
	fdms3dBGQ3TJ/CVKNS26OAMmCUAiUmWK7UrzhrSNeiT96/ST+1Eh0AgfFa0r5R6v5oQEhyUCXSF2H
	1GDRJ0sCQE6ljf/gmry5qK9BcgLg9ADOHfiXM355LqzBqLUXXxZKenfbaVx4cuLemnupnENkkYR17
	nIUqU7Gy7Mypxc+7HVS/TN4Nee8Snvoba7WQLG9JuZidgeJFgStyH36tOdrnhMB5zExp2/uV4Np2F
	vzRaWgXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nrhz6-007tyU-1K; Thu, 19 May 2022 15:22:40 +0000
Received: from mail-il1-x132.google.com ([2607:f8b0:4864:20::132])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrhgy-007hRS-RH
 for linux-nvme@lists.infradead.org; Thu, 19 May 2022 15:03:59 +0000
Received: by mail-il1-x132.google.com with SMTP id j4so3819031ilo.12
 for <linux-nvme@lists.infradead.org>; Thu, 19 May 2022 08:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=rj0LLD+GhcnwrTRHq/dFr3Mwh+FjHxEzsjGfPynBta8=;
 b=Sp2/uiiLNbgL9R1tphyrUyI7tgSy2JPlQLF1K2JNOaKRT6V/ibDgS7OjPvB3COMec2
 OaSQxtNqn4SoHtsZKkQFvaSwPftUrw2YyiL0FZoLZULvzgRe4jNAkc+CVeSRVHlZlaXm
 seoT9krghOGjnl8KddC+ryWzPKDDYHX8NtuYU7uwGUfGxGec2tiO1Zq4vWv/nKM1OySQ
 bfwEsMQiWVWYJKIK20b7dcd/8YZUf6k4HS5MNXv9lVqzQ8FZZZrpl3EWRbBOqO6ZWNJ3
 rTaO7gPV3yNYBwVLy+djNSgOU63D35AkX+viHNI9OW09GJg17YOcFizOnOcabFJ7MUD0
 bptg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=rj0LLD+GhcnwrTRHq/dFr3Mwh+FjHxEzsjGfPynBta8=;
 b=pn+D+i4hIiDeTW0fdQtEDBZhrpkTJ8ujyjakmE41Nl6+yHg6Ofc4YiCitcOSUlrbKi
 ZPpfabKAjxkwaHsBIvG2Sn2lzwfLFjJHVXlqfSuMm9jHRyfiVhTnMn805SQB7FdtKagT
 rQdsWYzZyyA8+c9TJCVHYCpsziyvzknfq6GqEZhIVZqtcZM4ZARY7x2H7fg06b2lu/3m
 X4MgCPw9GbOxxtIbxqrx0asSHc9aVDGGfNlHbGaObA/GysQosVIiFo0GK88PRYl2m2ER
 toQpUQ9PjUsz184G9Y4hK8mtwJnDtGL+pNaS+evXxIXsuywsIItDFhCZMN8psBUhFKle
 sYfA==
X-Gm-Message-State: AOAM532lehJfHpP0hS5heydfUW3W5T6k1MjiQ+b35CJ+4LBjTNBn65gt
 L2cg1bOWPaUi/oIFH/1rwryeOg==
X-Google-Smtp-Source: ABdhPJwcVoiz8Rc2uaOTrNO/AvGJLBT0BZxBlNiMr1idOVcadH9jYg5ZRjxvy6ArxdYVGO+7CLI64Q==
X-Received: by 2002:a05:6e02:12eb:b0:2d1:6335:8e28 with SMTP id
 l11-20020a056e0212eb00b002d163358e28mr2553116iln.51.1652972633870; 
 Thu, 19 May 2022 08:03:53 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
 by smtp.gmail.com with ESMTPSA id
 cl9-20020a0566383d0900b0032b3a78177csm679227jab.64.2022.05.19.08.03.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 May 2022 08:03:53 -0700 (PDT)
Message-ID: <1ca9f030-d873-5b27-6641-fadee25b30bd@kernel.dk>
Date: Thu, 19 May 2022 09:03:52 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] nvme-fc: mask out blkcg_get_fc_appid() if
 BLK_CGROUP_FC_APPID is not set
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Muneendra <muneendra.kumar@broadcom.com>, James Smart <jsmart2021@gmail.com>
References: <20220519144555.22197-1-hare@suse.de>
 <84a7c290-5e75-3e24-0674-7b51dcafa2eb@kernel.dk>
 <0b33e180-9e23-f737-3c93-5b5b13a7ded2@suse.de>
 <be88c0b4-ddc6-c851-c160-a929adc1e433@kernel.dk>
 <20220519145931.GA25382@lst.de>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220519145931.GA25382@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220519_080357_006230_9972BBC6 
X-CRM114-Status: GOOD (  14.29  )
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

On 5/19/22 8:59 AM, Christoph Hellwig wrote:
> On Thu, May 19, 2022 at 08:57:53AM -0600, Jens Axboe wrote:
>> I'm assuming that commit is from the scsi tree? It's certainly not in
>> mine. So your commit message may be correct, but since it was sent to me,
>> I was assuming it's breakage from my tree. Which doesn't appear to be the
>> case, and I don't see any of the SCSI maintainers on the to/cc.
> 
> Yes, all this went in through the scsi tree.

OK, Hannes please send it to the SCSI list/folks then.

-- 
Jens Axboe


