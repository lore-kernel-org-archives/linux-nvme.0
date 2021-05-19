Return-Path: <SRS0=q7uG=KO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A5AC433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 19 May 2021 07:01:33 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E69B86109F
	for <linux-nvme@archiver.kernel.org>; Wed, 19 May 2021 07:01:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E69B86109F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=KuWi+es1P/b+pZo/z5ZFGxrcRX+6KRReLQazcuQ7ZC4=; b=Pg4/dDsHvSMJxCVolihTlY2zf
	Dau/FX4t64NWno45HcMWDync/kQx7VdE4QjFvtvfNLwt1G5XKpnyhJUH+MmawrLB9wv9/Bhy02wCP
	Gx7iHcRNTth8+xclleA90LrscuPBSOj4x6HEhajSOK6aVBzZQ5ZjM0SifUKsuC6F62iVnn6ftMZxA
	50w8VZsygCRv17/XZ1rH/RJPLkH00luI14qfFA5vuR+gf7DUIGA3EhR43FpR9PadIGLSSuDPW3ABA
	3HUZgda1OLp4fXYiX8nR23ypSqcFzlHp8JFDS3i5OLex51ZlF5U9zQC2yYRuMG//UyQhulaRaoXKk
	zv405b/mw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ljGCa-0035PL-2u; Wed, 19 May 2021 07:01:08 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljGCC-0035LF-Bd
 for linux-nvme@desiato.infradead.org; Wed, 19 May 2021 07:00:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=AtLQOmT3RWv+aEdvfhmvoXrvtO8TBTQq5ZLyKjbSK3s=; b=VWGZSH3HiyzjrjPu4SzSAFQNic
 me4WfIcw2DSvPNOIwgd7NKRK2DLNd1TXEHD56ub5dNyy6LNXrclLi3lsyMxuARp+Ho2dcKl5MECNA
 vBoqS9Wnu/TBbFw76DZkRjCo4VwA8KcsZ2PuPiH2C+Aj0/TPH0sLviIbxJFdg5dVmBD8E7NOzCLdw
 9dVrttM3jN+U/Ucg9i8S9TdQAckZznF32u3GOG1dc0SmfZmryNZYDhePKk+fxZHXMqV47Lh8M2zbA
 Qkk2HyOjdtHibcGNQ9hf5B2fNNg4DRLnN9fon4pkIF21GQCd9/BqiEqP6eEETEMbqZeSXfEJX3JCR
 5S0jUPfQ==;
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljGC7-00FCZ3-4v
 for linux-nvme@lists.infradead.org; Wed, 19 May 2021 07:00:43 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id B7DFC67373; Wed, 19 May 2021 09:00:35 +0200 (CEST)
Date: Wed, 19 May 2021 09:00:35 +0200
From: "hch@lst.de" <hch@lst.de>
To: Alexey Bogoslavsky <Alexey.Bogoslavsky@wdc.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "axboe@fb.com" <axboe@fb.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 1/1] nvme: extend and modify the APST configuration
 algorithm
Message-ID: <20210519070035.GA32339@lst.de>
References: <BY5PR04MB704131DBB47254C9F1FF12B38B409@BY5PR04MB7041.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BY5PR04MB704131DBB47254C9F1FF12B38B409@BY5PR04MB7041.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210519_000039_356224_FD8518F2 
X-CRM114-Status: UNSURE (   7.76  )
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

Thanks,

applied to nvme-5.14.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
