Return-Path: <SRS0=uaVC=IP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 149B7C433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 14:16:51 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80DDA64F38
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 14:16:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80DDA64F38
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=P/0pvNne0YtkHHzLee++pnnVthFhW3BbMmRw5geCVBc=; b=C+loyaViByivaN1r8fYicL+BR
	UTY/RiII4S4LEANcCvjnI56bldEI6//z+84f6uKOCWbaHhWXZ4TJnFWClhH7p7tUrBR9oBrxuaSwc
	5APDf8H9ekPoi5chV1OsOeDj/0cQIY8yNSp0EkpxtSaCfapsQJ0Fh/qaAK+O+uJTkIHqbtnf41U8U
	mlc5bMe6YXP4oE31J9Tx28ovZ6n3q/nGyhoHaMoBfXzuWhljwkFk4lCVrUfS7zYKl+fYXejXJyVJc
	KdnKMG+LjwlIeYZs8R1vbKu/gvgUZdiCKC7pWGuZ+LSiIyrKgUhdfpZF9JYPbQ8fNhUTkIN4joJzg
	nLv9k6aBg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMWyP-003Efx-AD; Wed, 17 Mar 2021 14:16:33 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMWyI-003EeO-EF
 for linux-nvme@lists.infradead.org; Wed, 17 Mar 2021 14:16:29 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2B12F64F26;
 Wed, 17 Mar 2021 14:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615990584;
 bh=4l0ijklVRAY6ZLtIUCUdjEaiEzmGWaPshoXmWN7Eud4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=akNLoZJR8xR8xlYSFxwMaYMEvQkIJK1hKNCVZ6ENwFCEQIXHRVPj3KFdDLklR5ppa
 eExg+NuvWrwiyhoQUiBEc4rrf5oeq3s6NaBPFD7OiF4rjHuktRBaRMdovDL13s9zDa
 FtnBVdnhGmJPxRHDLRqNLTcxqQaYiSScWt9+6NJ7w5r84NEUuXNiPsm6uPBPgk7Ngw
 lV4GKPH3UMtUh4SOrDuJ3RaCUnYm2VOxyFcA6Y5OyHoNP/IA3wYA3F7fWjJ1Z2WG00
 xGKKFSe9DKgFqifVXuNO/2gMwfqWcUCqMTmJo6zwC4lf8T0A5y+cb+G/8gFH6mkRTJ
 Few+PR4XYJzvA==
Date: Wed, 17 Mar 2021 23:16:21 +0900
From: Keith Busch <kbusch@kernel.org>
To: "Ye, Jinhe" <jinhe.ye@intel.com>
Cc: Christoph Hellwig <hch@infradead.org>, "Zheng, Wu" <wu.zheng@intel.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme-pci: add another device ID with stripe quirk
Message-ID: <20210317141621.GB26641@redsun51.ssa.fujisawa.hgst.com>
References: <1615864938-6757-1-git-send-email-wu.zheng@intel.com>
 <20210316073042.GA376417@infradead.org>
 <20210316210852.GB23332@redsun51.ssa.fujisawa.hgst.com>
 <MN2PR11MB4221937A2D8E84C1BAF4D4239D6A9@MN2PR11MB4221.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <MN2PR11MB4221937A2D8E84C1BAF4D4239D6A9@MN2PR11MB4221.namprd11.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210317_141626_748471_CA18C457 
X-CRM114-Status: UNSURE (   9.41  )
X-CRM114-Notice: Please train this message.
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

On Wed, Mar 17, 2021 at 08:58:23AM +0000, Ye, Jinhe wrote:
> Checked P5510 and it supports noiob field. 
> nvme id-ns /dev/nvme0n1 |grep noiob
> noiob   : 256

Awesome! So you don't need the quirk. :)
 
> The purpose of the patch is for customers who are using old kernels. May I know from which kernel will support "stripe" quirk by noiob field checking? Thank you!

Linux initially supported noiob since v4.13, which was released 9/2017.
If you need to go older than that, I think backporting noiob support
is a better option adding more quirks.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
