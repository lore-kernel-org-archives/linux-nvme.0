Return-Path: <SRS0=aO7+=M3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B43C4338F
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Aug 2021 14:15:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E07BC60E09
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Aug 2021 14:15:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E07BC60E09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5PNXckPTFGjylymbLHBCyFjSeOdcjcgBEHaniZzSVqk=; b=Tidqo0oF1uLoK0
	+1hUsqKQRLmHdzoE/+9+kO+X9kk3Lt0xNMELLkz5iNskWCZhQ/F8pP5u5RjefbW+2C4TT3RkT5lHY
	4NziQBjPff3/MZhrr49tu/oDKiEefqFI751/nfxi7tOXs5BeEXkU6obJEUhlSNSMb/p8+7ANPKBle
	60WYiQHtQJiSfKXTOyAo7tyQidEa3lfBiLYezwZJYQcuGFP6Ogj5SSn+C/XETMYqlG3gUgLqv/DQO
	xchn5WPg5NlzgTLTz9JqAXAl6zj8N2X8YyXC/Sas32LT8GU2iN6DlFxA3nzG1e8Lmz3BH1221YOJX
	3k+PqstghSuAN0Kc82qA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mBHfN-006NPc-FZ; Wed, 04 Aug 2021 14:14:41 +0000
Received: from mail-il1-x12b.google.com ([2607:f8b0:4864:20::12b])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mBHeq-006N9d-70
 for linux-nvme@lists.infradead.org; Wed, 04 Aug 2021 14:14:09 +0000
Received: by mail-il1-x12b.google.com with SMTP id x7so1782239ilh.10
 for <linux-nvme@lists.infradead.org>; Wed, 04 Aug 2021 07:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6E78/6zLDHtWRwajFV5K+kCnVIVVes2MqNHejOQaS6E=;
 b=vhAPM98ttnDbUN4JAbm0oJHOwVuyzxx1A3gOH5ff9H+jkXHwXrh98SfBcCaCrEdXH2
 htkVLFQJctJNT86mLuAlVwF2pSypVr7j5GVJi7UdTdfNVM9LRK4riLcQEzvk6IsiAxeO
 TPDDQJ0GW4LhBu9bix1JjBdiMvHfRujOg5EsLWfNXAiuHNjei3JkNC3GVeY7GE5svhsR
 dICREVX9pTY4wrdbx+noHQlbci9Fk8DE25D+RGniZwRLo2pz+zqVNZ5StlqOY6GJ78yH
 TQwlL7+reOx2rucQq3DcsR2OT4VcCcvfWt9K4B9I+Bvpl9zjPZ7JgK3lGMzibwsJV8GT
 JGGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6E78/6zLDHtWRwajFV5K+kCnVIVVes2MqNHejOQaS6E=;
 b=L4CsoSpa0Z73lssU4GypfflGOfpIqo8GEYTevjMCrfq9yG9xxgUtCb4Zqal1Z3Todc
 C8BxF6dkcJ8Kc7twbObJbKfep7vUfk2QVoqk0ES6MGV1ps+0GEA2Zx8VzibC4vA3S/GB
 KM2IO07dhVph4J4MRU1ugIUtm/FQQMmscosJSI4LhsJ8PKsC53z8NJHdOHkxhL0COsFZ
 U2upmSVKmeKr8YBtU85ujjVfUfIJOzEWnOuY/buCaUoLDZzaVyIdUR2P7rF4Qor8ERSm
 qxjNfiIC1/86IsbiZkrutSKl+6CjdcyWvv74v8jsmoTa2mCAJh3FfNNSeSbXJFkCl4Jc
 VrKA==
X-Gm-Message-State: AOAM530ElkyjOQV+sDFuGs+fvCPb+LfXi5+B4vtMijMVHCG+pUrzLI4N
 tyjRkv6zlU4XKUX5Jn7eaXCYZiI6+lUfyJBBkeI=
X-Google-Smtp-Source: ABdhPJzI07cnNLAaxl2fP6+LCl/V6mxvF+ndNz0UwEqi0SZof6epBx37dsf8PW4pOi/lXNC8iZe7Ls1qtbBBa7OxdhE=
X-Received: by 2002:a05:6e02:2190:: with SMTP id
 j16mr823136ila.144.1628086447042; 
 Wed, 04 Aug 2021 07:14:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210722110325.371-1-borisp@nvidia.com>
 <20210722110325.371-3-borisp@nvidia.com>
 <YPlzHTnoxDinpOsP@infradead.org>
 <6f7f96dc-f1e6-99d9-6ab4-920126615302@gmail.com>
 <20210723050302.GA30841@lst.de> <YPpRziMHmeatfAw2@zeniv-ca.linux.org.uk>
In-Reply-To: <YPpRziMHmeatfAw2@zeniv-ca.linux.org.uk>
From: Or Gerlitz <gerlitz.or@gmail.com>
Date: Wed, 4 Aug 2021 17:13:55 +0300
Message-ID: <CAJ3xEMid0sWkCf4CPK5Aotu=+U4=vtDrdJANqn+CnWd7HTb-vg@mail.gmail.com>
Subject: Re: [PATCH v5 net-next 02/36] iov_iter: DDP copy to iter/pages
To: Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>
Cc: Boris Pismenny <borispismenny@gmail.com>,
 Boris Pismenny <borisp@nvidia.com>, 
 David Ahern <dsahern@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, 
 Saeed Mahameed <saeedm@nvidia.com>, axboe@fb.com,
 Keith Busch <kbusch@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, Shai Malin <smalin@marvell.com>,
 boris.pismenny@gmail.com, 
 linux-nvme@lists.infradead.org, Linux Netdev List <netdev@vger.kernel.org>, 
 benishay@nvidia.com, Or Gerlitz <ogerlitz@nvidia.com>,
 Yoray Zack <yorayz@nvidia.com>, 
 Boris Pismenny <borisp@mellanox.com>, Ben Ben-Ishay <benishay@mellanox.com>, 
 Or Gerlitz <ogerlitz@mellanox.com>, Yoray Zack <yorayz@mellanox.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210804_071408_288359_C380AAA5 
X-CRM114-Status: GOOD (  15.18  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Jul 23, 2021 at 8:30 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Fri, Jul 23, 2021 at 07:03:02AM +0200, Christoph Hellwig wrote:
> > On Thu, Jul 22, 2021 at 11:23:38PM +0300, Boris Pismenny wrote:

>>> This routine, like other changes in this file, replicates the logic in
>>> memcpy_to_page. The only difference is that "ddp" avoids copies when the
>>> copy source and destinations buffers are one and the same.

>> Now why can't we just make that change to the generic routine?

> Doable... replace memcpy(base, addr + off, len) with
>         base != addr + off && memcpy(base, addr + off, len)
> in _copy_to_iter() and be done with that...

Guys,

AFAIR we did the adding ddp_ prefix exercise to the copy functions call chain

ddp_hash_and_copy_to_iter
-> ddp_copy_to_iter
-> _ddp_copy_to_iter
-> ddp_memcpy_to_page

to address feedback given on earlier versions of the series. So let's
decide please.. are we all set to remove the ddp_ prefixed calls and just
plant the new check (plus a nice comment!) as Al suggested?

re the comments given on ddp_memcpy_to_page, upstream move
to just call memcpy, so we need not have it anyway, will be fixed in v6
if we remain with ddp_ call chain or becomes irrelevant if we drop it.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
