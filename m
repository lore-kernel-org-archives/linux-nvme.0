Return-Path: <SRS0=yO6k=IU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08134C433C1
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Mar 2021 06:34:53 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACB0561937
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Mar 2021 06:34:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACB0561937
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=sifN8mPS9JNu4dBseurX0axFSC7ZzufJK/s9Ud9D+tI=; b=aLmRY/b7MN3MwwsNlKaPuNZOE
	sRJzf7JGQh2dyBD5QyoFIFRlT32NVCLoLC2HQZwevhyXCA0aXexgKwfHiabAeLibPAuRxk/05oR0y
	DbFq2UMYYsGsgTGulB0Iw58ynxvPM093tZ7XArvIrWjrvusZQQsdKXilMFih9MTu5R+1RelfplKd9
	tPc++PrRvjG8lgf2dJEFeeqvlOi3GKTrd7APaoOZtfbxpdio3lVcHSlLpMKUQqzudRQx1y3knYpEO
	zo/jzZ674K/J5cz1s6TuMCMYZur9ujFj54qoeyiosuMRvEiu6lxPgiI3HhgqtlAl0cYOnSPne6gJX
	DBoLWImnw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lOE96-00B1qH-Cf; Mon, 22 Mar 2021 06:34:36 +0000
Received: from verein.lst.de ([213.95.11.211])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lOE8w-00B1oV-EM
 for linux-nvme@lists.infradead.org; Mon, 22 Mar 2021 06:34:28 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id B6B9067373; Mon, 22 Mar 2021 07:34:20 +0100 (CET)
Date: Mon, 22 Mar 2021 07:34:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH 0/3 rfc] Fix nvme-tcp and nvme-rdma controller reset hangs
Message-ID: <20210322063420.GB2325@lst.de>
References: <55142c25-9a70-08a0-d46a-cad21da59d19@huawei.com>
 <7b7d5223-ddaf-eb88-f112-02834f8c8f93@grimberg.me>
 <20210318191613.GB31675@redsun51.ssa.fujisawa.hgst.com>
 <be15cc68-2129-286e-55b3-a2c23f8c93fd@grimberg.me>
 <20210318215256.GC31675@redsun51.ssa.fujisawa.hgst.com>
 <20210319140532.GA7019@lst.de> <20210319172817.GA23660@lst.de>
 <ac05c7cc-3613-ec8c-a718-6f3e74710b42@grimberg.me>
 <20210320061123.GA20852@lst.de>
 <6c83c0c6-0f00-0163-40f3-0ce2b2b2cc32@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6c83c0c6-0f00-0163-40f3-0ce2b2b2cc32@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210322_063426_964479_6AAE98F1 
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sat, Mar 20, 2021 at 11:49:35PM -0700, Sagi Grimberg wrote:
>> Hmm.  I don't think head->srcu is intended to protect the current path.
>> We also call nvme_mpath_clear_current_path from nvme_complete_rq or
>> nvme_ns_remove, which has no locking at all.  The srcu protection is
>> for head->list, but leaks into the current path due to the __rcu
>> annotations.
>
> OK, care to send a formal patch that I can give a test drive?

I'll write a changelog.  But as-is this should be testable.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
