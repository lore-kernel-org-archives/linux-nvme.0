Return-Path: <SRS0=15Zf=IO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D8EC433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 05:05:20 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1949A65137
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 05:05:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1949A65137
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=nr04Z1uZSaftxSy4sUYTtHlLzcbTPa2RLBzd+UVjLUE=; b=ULa3FBgWZu6Rk7sHUDTX4oaFJ
	cmvs7mkWl063TsNFl0Hd7l04BE5s9zWejiN/2K7mcA0UWhTj9ZiS1cZN+nOlE4tTOXPa5HKilqrgQ
	SjgkJE5nEq+49HtanYbvEVP4XUZQnNp78TBuCWyXh2XjTzQLmGhdgDZZeyt5sHFU5gJFkPSghTde2
	Wr7TwaiRWGIIu0s7t/gsGnXBqtqkIsKaywX5QV0nfTs6v6zf/CBUbb/+a1FAar4/HkjAsixHAQ2ij
	047/+EUAicESrggxv5b5vkCt335xKnR4qRvIlWdTuu+n+QJWM1DEOW5Rfrpf50gDVpbtq0eD87kit
	IfAkKbETw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lM1t0-00HQT1-Dp; Tue, 16 Mar 2021 05:04:54 +0000
Received: from mail-pg1-f171.google.com ([209.85.215.171])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lM1sv-00HQSc-Ir
 for linux-nvme@lists.infradead.org; Tue, 16 Mar 2021 05:04:51 +0000
Received: by mail-pg1-f171.google.com with SMTP id v14so14895846pgq.2
 for <linux-nvme@lists.infradead.org>; Mon, 15 Mar 2021 22:04:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=m6Eq0MO7QS4DuG2dGcNUAuxodK04DBSpc4XEwBB74NY=;
 b=LFzrJKrm+nWPMF7aEmf825/CgfymBHMWze14oaYEXvP0FNbrqbyabHgHIyIKswriqu
 KZn4q7yWmC9EqPrZmpqx5Tm+AclrAuiVg9nf6VRj0K0vyc/70zs577vEN8MBmV9ji7//
 7iGFy1cmcPvau4MK6wZByegv61/9C4I0/SZIHOUYuX6vE9HKlA7YYfIunGspfpdMz/9b
 QCK8pdzYqJbzpkiTBs2+tnaNa2JyKlHR+tCw0T+xsovN+kRj+2sN3e5Y4r7ChjgcSWdv
 tvDUGO9uq5Rq2PIrqND0IwvZcwG9IOn43wEQ8/7SY+iNkIu4z++8A1n29EoaweYoIS/+
 13Jw==
X-Gm-Message-State: AOAM532lbVRCjCH+1zNwZIMhfmda7AayrdvOPmUZdGC5NFRBS9vboZTj
 Sq9H6Snv+Au8M8mx9MtCn7i9kCcNTLU=
X-Google-Smtp-Source: ABdhPJxgAlAKxUOljf2mqhSs9ho+KMK2qogbDKaov3rdwaItMAAgsC/S4DqJ4MjAJm7I1IkiPHlouA==
X-Received: by 2002:a65:5bc6:: with SMTP id o6mr2214712pgr.127.1615871087132; 
 Mon, 15 Mar 2021 22:04:47 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4faf:1598:b15b:7e86?
 ([2601:647:4802:9070:4faf:1598:b15b:7e86])
 by smtp.gmail.com with ESMTPSA id y22sm14775424pfn.32.2021.03.15.22.04.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Mar 2021 22:04:46 -0700 (PDT)
Subject: Re: [PATCH 0/3 rfc] Fix nvme-tcp and nvme-rdma controller reset hangs
To: Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
References: <20210315222714.378417-1-sagi@grimberg.me>
 <7d552635-6f95-fca4-b0ca-709967465495@huawei.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <3a172ebf-eeb8-b7a0-4eb2-099fa74bc1c6@grimberg.me>
Date: Mon, 15 Mar 2021 22:04:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <7d552635-6f95-fca4-b0ca-709967465495@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210316_050449_813819_39732AB1 
X-CRM114-Status: GOOD (  16.44  )
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


> Does the problem exist on the latest version?

This was seen on 5.4 stable, not upstream but nothing prevents
this from happening in upstream code.

> 
> We also found Similar deadlocks in the older version.
> However, with the latest code, it do not block grabbing the nshead srcu
> when ctrl is freezed.
> related patches:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/block/blk-core.c?id=fe2008640ae36e3920cf41507a84fb5d3227435a 
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5a6c35f9af416114588298aa7a90b15bbed15a41 
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/block/blk-core.c?id=ed00aabd5eb9fb44d6aff1173234a2e911b9fead 
> 
> I am not sure they are the same problem.

Its not the same problem.

When we teardown the io queues, we freeze the namespaces request queues.
This means that concurrent mpath submit_bio calls can now block with
the srcu lock taken.

When another path calls nvme_mpath_set_live, it needs to wait for
the srcu to sync before kicking the requeue work (to make sure
the updated current_path is visible).

And this is where the hang is, the only thing that will free it
is if the offending controller reconnects (and unfreeze the queue)
or it will disconnect (automatically or manually). Both can take
a very long time or even forever in some cases.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
