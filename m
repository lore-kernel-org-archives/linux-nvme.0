Return-Path: <SRS0=GcL3=KF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC967C433ED
	for <linux-nvme@archiver.kernel.org>; Mon, 10 May 2021 07:00:13 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 899DE61432
	for <linux-nvme@archiver.kernel.org>; Mon, 10 May 2021 07:00:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 899DE61432
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ipZ++3qt/rJSWqYMOhzVbRW1Cag0ERc9Zz5/dlFWSw8=; b=GzzhWXuymWKman/WrS9+4dkXo
	0JCodpxC9CT7M5gHADOAzLkZP6zK23YqIUI2aw5qmfFydldRHhaN/uP4v3hs7WTRX56uiDoOz9/cT
	X7bhwCGNBV+VStv4L4Aj2crP4rJJ3TyYmntzJUZqBerihQvjCnhj4yG1uIVsw+VwMRXnYRdBOlUXG
	RldeBm3szgXYVx+i9WFvFhXmUS7zD3j9vyfwmRK5WqKuXpUJ+lTGPKII92MQa4eUZmNJgUTobAQia
	9YuT1dXsSAWWOfQWYIiOe0cF/PkNvrZ6tzGAzlwXpQgNdeBRAl5hz2I4pNru7hijOCS2w8GBkhP44
	wj1PoI4wQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lfztc-00DR2t-1C; Mon, 10 May 2021 07:00:04 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lfztZ-00DR2D-8K
 for linux-nvme@desiato.infradead.org; Mon, 10 May 2021 07:00:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=ODhVYnPmLkf5EhCiurfrS9D6g7aqa3XhGjJJ3Gx07Wg=; b=WrHI0INDYbcH8BVBjgT471Ikeh
 0MnBe0n7yzbsuBGhy0vp5kD5sWz5YgbcY1rvyrgVvNpY0z+8+6vD6I1ZY4UKZrd8XxrjbhR0UhVXi
 V7lmUq7OQugN3NwApjOwrwtXcfCgYPUtQSSFo0BaCCHxlKitUvv/tRB8+UkUUnZDdtYZLlNfTs6jW
 QlHV6qQfu/y2ALPKqbU3fkcEh08cIgzJnA8x6k2/jEg77zm3ij7zwvoKIz7y94kfYYEhCeB1Dai6P
 2dH+1kB1lWwHLHctIuotkvH34cnu4HATqW6axFJEzsVeQiJgHhY4YJKYCevAh/Pca8BQ7sPCorFwW
 hhwKTIlA==;
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lfztW-008M7X-Lz
 for linux-nvme@lists.infradead.org; Mon, 10 May 2021 06:59:59 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id EFEFD67373; Mon, 10 May 2021 08:59:55 +0200 (CEST)
Date: Mon, 10 May 2021 08:59:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
 kbusch@kernel.org
Subject: Re: [PATCH 0/3] nvemt: demote high frequency err msg to debug
Message-ID: <20210510065955.GA30907@lst.de>
References: <20210430010651.36736-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210430010651.36736-1-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210509_235958_881803_B4BC2F00 
X-CRM114-Status: UNSURE (   8.74  )
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

I can't get this to apply.  Can you resend this to the latests nvme-5.13
I'm about to send out.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
