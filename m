Return-Path: <SRS0=ZbIm=I7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A526C433ED
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Apr 2021 16:32:55 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5A1061008
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Apr 2021 16:32:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5A1061008
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7xin8YcM8UXA1N0nCbD4BbyDBrLeWo+T/XKKPOETZ9c=; b=kmG6S7ikPkC1lHidXc+EEqLNA
	dSYq9RSLUtd/g8aOjhkfw+gfxNduoLdLZdvISOKPA8jh6sUCxILtuCABq77SSmfEJzVA+WrJDIdgJ
	40c7y8JNworg1E5gU1ZE5w/sZW1l/KeXQi+dVWA5lE6+A9Phxfabw03YuUqxVEhsu1+Rhz3xeZUAq
	35RpjoPEZ8L9EtTeVmF6SO71djtb+WUurIeGHj00Jpoo1BPRVw50N+6FSSmc9u5EGEGNJIW/cFpdA
	yMrE/AP5xmml2Y/cT4av6ev7bK2Rjs2jy/5hvGRy/HLxYAySS+39fgs66cVHD91tjfXA13LNrfY7p
	eqt+R/dRg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lSMit-00DOW1-8K; Fri, 02 Apr 2021 16:32:39 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lSMis-00DOVw-8l
 for linux-nvme@desiato.infradead.org; Fri, 02 Apr 2021 16:32:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=JfcaAWiL9MX/KzgqZFMd5GxaGaNC7KsyrSBFfXwwLXo=; b=n+RLzaW9oKsqxQKT8ZKfBwuOLV
 dXuUqZZEcjE0VdW6FNgH48TsjRHItzOFTDtMHvFdOh+00AezW//ZP6KsQMPiboQwJYU039PBGbKIM
 z/mwK7tSRuMHNMtcC74HRPOXCIfXJ/slesQ2VZkkM2qIMCF8dR6gkwhM6+LFlv4N7W7syxflI6aTf
 uvykUj6mXeVvmq92jKMrV5t1OeUleRibrP77Pney7aNOpk/2QUyU1CHzZ9QxydOb//E96lDAU9OnA
 TSOWWXVzp/wS67mSC/5FwANJcGc8zhUNmYJUzBhUmYXEVVJjhE6RpsXbqt46dbNg19bxTvFJyyGwj
 1belJWVA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat
 Linux)) id 1lSMik-007s1i-MR; Fri, 02 Apr 2021 16:32:32 +0000
Date: Fri, 2 Apr 2021 17:32:30 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Wunderlich, Mark" <mark.wunderlich@intel.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH V5] nvmet-tcp: enable optional queue idle period tracking
Message-ID: <20210402163230.GA1875925@infradead.org>
References: <BYAPR11MB28695D512EFF1D501BF407F2E57C9@BYAPR11MB2869.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR11MB28695D512EFF1D501BF407F2E57C9@BYAPR11MB2869.namprd11.prod.outlook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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

applied to nvme-5.13.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
