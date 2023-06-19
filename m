Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A0DCEB64DA
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Jun 2023 11:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:Subject:References:In-Reply-To:Message-ID:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+DL0OF7uuuNOYsqXOPSGvFJ/HjEnbDBZl0VpUNHErKM=; b=E85oTOEQRjw8Ss9T7zc9/77vx+
	jF2XnNnv+YehiazXpJaGWPLYqArZFswU7w9yXefyaIZ6Q6K2n55nNYwEdMkEOagugk+QIZV1McmRU
	Gg/V07HvhL6qZmWKRvoj5rafBHwP7XIzilro8z9sU0Jy7sdu//aZnUnXWErcILCER3F5C75RX3Wd1
	mrUFRnAgPbsEPVvagk+dPvHiVX5Mf3YjKBDUC7T+VxZl4p5qse/vrWseqXOpQ42FlJ7lgRCLhVcd1
	Oen7SNuP2cU/L0xwSmpHM9hgfawqmJ2RUzLisSHKrvrRjkgDmeD/v5z4ki2VF3VpS4f7d37s57org
	SRsxiZBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qBDLW-008OkM-3C;
	Mon, 19 Jun 2023 11:46:58 +0000
Received: from mail-qv1-xf31.google.com ([2607:f8b0:4864:20::f31])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qBDLU-008OjE-0V
	for linux-nvme@lists.infradead.org;
	Mon, 19 Jun 2023 11:46:57 +0000
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-62fec6068bbso30436866d6.2
        for <linux-nvme@lists.infradead.org>; Mon, 19 Jun 2023 04:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687175215; x=1689767215;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+DL0OF7uuuNOYsqXOPSGvFJ/HjEnbDBZl0VpUNHErKM=;
        b=nlMY23NVUs2/TV+4X1loiY46xV6KKlwv5w9g1oziAw3FFBWCs1oaRqWXorL4zeWrKM
         yNs/OVxOvtjDlfeamQV8dQP0N1MOXMARRiFBuiXEug37L5tCEVGAoMGS5XAUdUrfqGDH
         zfrPnB25ELPugT/FJzVlpx+Mj9Yg1ThZUj496XCTfiL6d11YRAa2kq0B3qDeUPZXCobI
         t7zP9Qhg0FT+SBkNok5LXxaby6qjtqhW4UGZV5xSusfM/Mox16LA4vlC/QsEaCb3+dw9
         2q6W+6bV7UANVGEnlVFFe/vlIU1OsmmXfS/DBwlIEGhvq786JOecG07G75f3yk1RV1gE
         xuFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687175215; x=1689767215;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+DL0OF7uuuNOYsqXOPSGvFJ/HjEnbDBZl0VpUNHErKM=;
        b=QiBnb5i8q7BuzH9g+O32xra954VRKovNoCB0KVMNOkPa+pnK6cbRBmYCkDrhYWLRad
         Mbs8BSKwAXVOcSM9Mb8t2/Qal5qQa5DMXYhffORkbiGgZkA6U/jDyojaoaaRXrHE0RPA
         /SgUO1wmZ7iRxqH3HqZe91tsnQiAJYVunHamnZLNlIa4C8ETXcltXbBnqLlUjHebFoVO
         XxYAESIxNQTOG8+1wHEChAXWLy2ZlnAf5kk4neRdGflpA/3fAC5/eUTlBgPR3gokll+R
         AlOVgs5k6ymeVcfNq2x53HeldUsExm3maVNoQ4S7N0cvQp/zluIVDqtBT/ug+zQmg6pE
         xLBA==
X-Gm-Message-State: AC+VfDxix+J00+xVFQvuy9jLPfL2bbAJse9TH+fWNU9esI9v6MFpyznA
	ZEbD4k1v3zNm9KD+WL1JOfQ=
X-Google-Smtp-Source: ACHHUZ7WJGHmzDBSaJdMmZtj2q9g+F+HBvoIaWkaobPS5K/bb1dOY9PCsUd743jpPaFGn1z+i9saIw==
X-Received: by 2002:a05:6214:401d:b0:626:376b:c95d with SMTP id kd29-20020a056214401d00b00626376bc95dmr12389587qvb.47.1687175214665;
        Mon, 19 Jun 2023 04:46:54 -0700 (PDT)
Received: from localhost (172.174.245.35.bc.googleusercontent.com. [35.245.174.172])
        by smtp.gmail.com with ESMTPSA id a20-20020a0ca994000000b0062de1ed9d15sm8529497qvb.102.2023.06.19.04.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 04:46:53 -0700 (PDT)
Date: Mon, 19 Jun 2023 07:46:53 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: David Howells <dhowells@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: dhowells@redhat.com, 
 netdev@vger.kernel.org, 
 Alexander Duyck <alexander.duyck@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 David Ahern <dsahern@kernel.org>, 
 Matthew Wilcox <willy@infradead.org>, 
 Jens Axboe <axboe@kernel.dk>, 
 linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, 
 Keith Busch <kbusch@kernel.org>, 
 Jens Axboe <axboe@fb.com>, 
 Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, 
 Chaitanya Kulkarni <kch@nvidia.com>, 
 linux-nvme@lists.infradead.org
Message-ID: <6490402d8401a_37b5c7294c6@willemb.c.googlers.com.notmuch>
In-Reply-To: <755077.1687109321@warthog.procyon.org.uk>
References: <648f353c55ce8_33cfbc29413@willemb.c.googlers.com.notmuch>
 <20230617121146.716077-1-dhowells@redhat.com>
 <20230617121146.716077-11-dhowells@redhat.com>
 <755077.1687109321@warthog.procyon.org.uk>
Subject: Re: [PATCH net-next v2 10/17] nvme: Use sendmsg(MSG_SPLICE_PAGES)
 rather then sendpage
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230619_044656_195935_0EDF8D68 
X-CRM114-Status: GOOD (  13.08  )
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

David Howells wrote:
> Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:
> 
> >     struct bio_vec bvec;
> >     struct msghdr msg = { .msg_flags = MSG_SPLICE_PAGES | ... };
> > 
> >     ..
> > 
> >     bvec_set_virt
> >     iov_iter_bvec
> >     sock_sendmsg
> > 
> > is a frequent pattern. Does it make sense to define a wrapper? Same for bvec_set_page.
> 
> I dunno.  I'm trying to move towards aggregating multiple pages in a bvec
> before calling sendmsg if possible rather than doing it one page at a time,
> but it's easier and more obvious in some places than others.

Ok. I just wanted to have your opinion. Fine to leave as is.

Acked-by: Willem de Bruijn <willemb@google.com>


