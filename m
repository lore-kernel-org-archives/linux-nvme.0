Return-Path: <SRS0=vClw=OQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4022C433EF
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Sep 2021 08:44:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75C9F60F11
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Sep 2021 08:44:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 75C9F60F11
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6wOxMPs+6q8GhO7tFmvV0pPJu+LFV2bep7sf78vBoEw=; b=EJ36QN48Nugpuyxe4ajKLJSDDS
	Zm4hvVFD4englBe8aRr9gnQgs89PVm8+jZGbkIayoVBdwfgVyoxXNIeimUZ0SaBZbVqfmMk3CcuQZ
	6hQUEfYRwCi7xqHtzFSx7HugdfsZTjnCh6oLKwHaH36KCW5fZEi8ZHzv0+lR+QFitKjAJUYXnNjXf
	td5rzYA7QAVFx+YUh/vXF6zUyibX1P9n7HU8sf8CCne0qh1fqwPmpIjcq2KD4JpI3u17+iEVt+Xww
	l+uSmZr3IzpKf3rvCYXx1NRpqD9Q4Eatki38U1cM3WnJI5jg/X8UZCal0wlY8JSsk9wSnFsJchwGz
	a3NHfTkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mUPlZ-000FxU-Jr; Sun, 26 Sep 2021 08:44:09 +0000
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mUPlW-000Fwg-ON
 for linux-nvme@lists.infradead.org; Sun, 26 Sep 2021 08:44:08 +0000
Received: by mail-wr1-f52.google.com with SMTP id w29so41515226wra.8
 for <linux-nvme@lists.infradead.org>; Sun, 26 Sep 2021 01:44:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=aAFBCyjtuhLNOn+PcDwnYELkSeoZGc5qwL1Br1bF/Co=;
 b=z5LR3zQA5LQRNImgDg7UVT/NSUWG8nhsDR7j/crq3XR7dZLxGgXr9CV5MYz8iFs2YU
 Uuilli0jmEW/alyiZtf5cBX7E5nHAqQDqVBAa+r8mQDV2b5aY4SfG0LSc2Q9Bj2e04Ef
 Bs/KNh19KHtbnF9sN+92IirHoxfUkkWL658m3sscSavVDXFlAnOwe+BV+ukQ3okREYWL
 YLeNswVHKJUwo32bLtKeTXufYofiwpBth48Gxz0lKOMao468ilvoAWkVlcKVKmPNVrHV
 s0Qi+zl+CL9gc8WU4hC3GoH6o1p0tX9ZT77rb7ZBa7m+rMkysiJj0qyqjxgiasYU/+N9
 mBZg==
X-Gm-Message-State: AOAM5312MaPvm2Fr4kk7wRm++tDtmE+sP9HR7HvwaT7m78RdhPNcfGnH
 DzNU95joWXUAc4TYsFEmaLI=
X-Google-Smtp-Source: ABdhPJxPIy/7nnROozAnKEdQt1srpKLaC+qnjXQbjT4lVJRYGneCi6V2Y+SFC6wQ591TJ77HZo9JKw==
X-Received: by 2002:a05:600c:198c:: with SMTP id
 t12mr10510269wmq.128.1632645845252; 
 Sun, 26 Sep 2021 01:44:05 -0700 (PDT)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id f17sm3196901wrm.83.2021.09.26.01.44.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Sep 2021 01:44:04 -0700 (PDT)
Subject: Re: [REGRESSION] nvme: code command_id with a genctr for
 use-after-free validation crashes apple T2 SSD
To: Aditya Garg <gargaditya08@live.com>,
 Orlando Chamberlain <redecorating@protonmail.com>,
 "kbusch@kernel.org" <kbusch@kernel.org>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
 "hare@suse.de" <hare@suse.de>, "dwagner@suse.de" <dwagner@suse.de>,
 "hch@lst.de" <hch@lst.de>
References: <cjJiSFV77WM51ciS8EuBcdeBcv9T83PUB-Kw3yi8PuC_LwrrUUnQ3w5RC1PbKvSYE72KryXp3wOJhv4Ov_WWIe2gKWOOo5uwuUjbbFA8HDM=@protonmail.com>
 <20210925171618.GA116968@dhcp-10-100-145-180.wdc.com>
 <fa9de055-c3b8-20d3-41e0-12e43d0c336a@protonmail.com>
 <20210926020839.GA96176@C02WT3WMHTD6>
 <1a6f5030-27d9-d1ae-aff4-0ed2a10dce6b@protonmail.com>
 <1b5d6bef-db6f-073f-8d24-4963f0df82ab@protonmail.com>
 <PNZPR01MB4415801C6084E8CFD068A84AB8A69@PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <d65ecc69-35c9-4400-8fb0-95aa04360b03@grimberg.me>
Date: Sun, 26 Sep 2021 11:44:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <PNZPR01MB4415801C6084E8CFD068A84AB8A69@PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210926_014406_826180_0CE31081 
X-CRM114-Status: GOOD (  12.51  )
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


> I checked out the proposal sent by Orlando Chamberlain to replace NVME_QUIRK_SHARED_TAGS , by NVME_QUIRK_SHARED_TAGS | given in the patch on http://lists.infradead.org/pipermail/linux-nvme/2021-September/027665.html. The , still causes panics to the T2 as described before. In the case of |, the kernel boots correctly without panicking the T2, but in case we are having Linux on an External Drive, which is my case, then the internal SSD doesn't seem to be recognised at all. I've tested the patch on 5.14.7.

That sounds like a separate issue, because with this patch applied,
all tags should be within the queue entry range (with generation
set to 0 always).

Is it possible that the io_queue_depth is being set to something
that exceeds NVME_PCI_MAX_QUEUE_SIZE (4095) ? the default is 1024

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
