Return-Path: <SRS0=2jH7=HJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 253EEC433DB
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Feb 2021 14:25:01 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C7DF64E42
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Feb 2021 14:25:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C7DF64E42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=2dsj/bj/xj2PZRs2ZZ0uKFmbg2xSxDpqbFjRhZ7cINU=; b=P4inRFx4XlTNT9XV6t8Q/LZnm
	EgQYZCDOHtg303BV5C1xKUED4lIga31UMQZ3MI1GYHPbh9m3MfmyBH6tvnhL2JkRxlxriTL7LVWbz
	vd+uIn8Vs36IHBiphQEXoaHsQ7EbI+2jHzkpBjlQmU2FXb72RT/wq8mBse0IDlxFz7Shl6Stwp4zU
	Y0mNUcUAkOvvX4QIsitofHhRNUIBLHczpLutvO2pJxR4CodBu2e/vEAePzrgkKl37J+IYNO6CYPfh
	ol9o4FYTeJJElLlaP5tNp2zT0MetAhglOAy4PcZMKJ/r8ZEQmiOj2e6NE2VF0onnT4pOnNzEv7Zut
	pATuPZ+xA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l8kze-0001Fa-RQ; Sun, 07 Feb 2021 14:24:54 +0000
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l8kzc-0001F5-Sz
 for linux-nvme@lists.infradead.org; Sun, 07 Feb 2021 14:24:53 +0000
Received: by mail-ed1-x534.google.com with SMTP id y8so15127918ede.6
 for <linux-nvme@lists.infradead.org>; Sun, 07 Feb 2021 06:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=HbB/FXTzI09kyJuyCwUrYmeuHtf2T5FGWb7rJ2ZR5F8=;
 b=W4+UC/HohousM95ZIFtzMKsW5CYsQ0CcYdvLzLlTY/sKYXObjacj2Hyp/xcGCAqzLK
 4V5NqIqRK4fRYRak92eEKi1l2jApPlFosOY0xIiX3xvQ7vgvS+zgA81v6sm+3HQ7mKmf
 ku03yJpj0I2HISdK2AoMFla48mT0pHVyiu9rUxFzJMYftfYFcRAdrlElZVpk/r9SfnP+
 +Z4tqs+w0K37+llJ8tsOH5IhD4p3JEYRjIIUAb1JtMibWgli82RDxo9yXhvgNS7fwCnN
 olq/YvlqUvRDIesforqY2PPJI/25OMJo1PGzpsffAP40osK9KulCWNM6Crn3XJy57LFB
 bnTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HbB/FXTzI09kyJuyCwUrYmeuHtf2T5FGWb7rJ2ZR5F8=;
 b=EK0GwUCxUOxVa1ztm5uf5Nh/ZWCnIcZvbbZcB6zCrZwQLd2LMJotqKHJxfQ0p2W0UL
 PbvDJ3CUmZGis57n+3VSZ7bnxCIcyTd9dXclZ8hyy2B+ihpR1a/tefa2SavANAPslgYB
 0WWzl4xMZzWXlkMA6MB4uU/niDTZAYJRm0seVapI/6xMNz1/IR/0dKeVgZo5t0oww9fI
 8p9NEP7PBgHzGc/pHXEaZ3j2dd09R/O12WJDL9LLBkEY/kytt9Z/jw9HJN4SOndNSNmQ
 9EYKGLgETySkIXcETpnWGZseaQR7i4aRdvFrI2+V69oRC4/+/Y5WluLuf+lxvaxTzDLI
 lN5g==
X-Gm-Message-State: AOAM531Q8zittOpcZ/DCYC9eSW9lFNt6uPhc/vMfj8AM7xgV+l1rWEng
 qpGF/k+fK9Xpzc5GOBBaHyU=
X-Google-Smtp-Source: ABdhPJw1tBsdjlf1a+IKr2w1PwOxDawwUzqyhRcghXLa/z+58ShyHO6E6GMhf7p5E3kdT+xcVV/BTQ==
X-Received: by 2002:aa7:d692:: with SMTP id d18mr13054264edr.327.1612707891637; 
 Sun, 07 Feb 2021 06:24:51 -0800 (PST)
Received: from [132.68.43.187] ([132.68.43.187])
 by smtp.gmail.com with ESMTPSA id hc40sm1165122ejc.50.2021.02.07.06.24.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 07 Feb 2021 06:24:51 -0800 (PST)
Subject: Re: [PATCH v3 net-next 01/21] iov_iter: Introduce new procedures for
 copy to iter/pages
To: Christoph Hellwig <hch@lst.de>, Or Gerlitz <gerlitz.or@gmail.com>
References: <20210201100509.27351-1-borisp@mellanox.com>
 <20210201100509.27351-2-borisp@mellanox.com> <20210201173548.GA12960@lst.de>
 <CAJ3xEMjLKoQe_OB_L+w2wwUGck74Gm6=GPA=CK73QpeFbXr7Bw@mail.gmail.com>
 <20210203165621.GB6691@lst.de>
From: Boris Pismenny <borispismenny@gmail.com>
Message-ID: <736bdc2f-8073-6d34-9509-182ed1ab2b4f@gmail.com>
Date: Sun, 7 Feb 2021 16:24:47 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210203165621.GB6691@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210207_092453_003800_A74312AE 
X-CRM114-Status: GOOD (  13.35  )
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
Cc: smalin@marvell.com, David Ahern <dsahern@gmail.com>,
 Boris Pismenny <borisp@mellanox.com>, Ira Weiny <ira.weiny@intel.com>,
 yorayz@nvidia.com, boris.pismenny@gmail.com,
 Ben Ben-Ishay <benishay@mellanox.com>, Yoray Zack <yorayz@mellanox.com>,
 linux-nvme@lists.infradead.org, axboe@fb.com,
 Eric Dumazet <edumazet@google.com>, Or Gerlitz <ogerlitz@nvidia.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Linux Netdev List <netdev@vger.kernel.org>, Keith Busch <kbusch@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Or Gerlitz <ogerlitz@mellanox.com>,
 benishay@nvidia.com, Saeed Mahameed <saeedm@nvidia.com>,
 David Miller <davem@davemloft.net>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 03/02/2021 18:56, Christoph Hellwig wrote:
> On Tue, Feb 02, 2021 at 08:00:51PM +0200, Or Gerlitz wrote:
>> will look into this, any idea for a more suitable location?
> 
> Maybe just a new file under lib/ for now?
> 

That doesn't work unless we copy quite a lot of code. There are macros
here (in lib/iov_iter.c) that we rely on, e.g. iterate_and_advance and
friends.

Instead, I propose that we place all of the new code under an ifdef to
reduce the impact on object size if the code is unused. We'll also
improve documentation around this commit.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
