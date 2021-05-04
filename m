Return-Path: <SRS0=iWk4=J7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 055BAC433ED
	for <linux-nvme@archiver.kernel.org>; Tue,  4 May 2021 08:08:40 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF55861168
	for <linux-nvme@archiver.kernel.org>; Tue,  4 May 2021 08:08:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF55861168
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Date:Cc:To:From:
	Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=YU2gfk9bZbJs1T1gOck78wavRvZTGKTVeL57j1sxfYQ=; b=jNyomN+fIBGRKWV1OnIbB9DUB
	lgozASqJoVNpDhfg+3+i7VLJzgO2FTQfhisKEyygtgt1jzt6bIOF5IX+BE4D/X3aKskferQ++g7Z4
	UlCuh0tQyPIBLycE5dIFik2pHModl5NnuUO87SuV+nEni4uq3qyyQ9muQvUtGdryEVkJI6BH5C4Mq
	B1orKmDFBW2rSwuNXwAXZ7RXoKgvCTNUETI/TWKQNllDVV/up1wTTCIn0E26XUXWTY7JWsaHZmTzX
	96BHM4BIdKDeWhIO0okp/0jdWYzabOTPB8tXVTvZ9Fu/UkgY7Ewgek9dfdOUozl+Fo/oOVANrAbyo
	J9n4RvlOw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ldq6U-00Fh9M-6l; Tue, 04 May 2021 08:08:26 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldq6R-00Fh9D-O4
 for linux-nvme@desiato.infradead.org; Tue, 04 May 2021 08:08:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:
 Message-ID:Sender:Reply-To:Content-ID:Content-Description;
 bh=7YLxD4201LgDHt76WCSlvgaGUhn0EbWLY1JsN+RF+qE=; b=qpoJ58Kd2xiUCxcK0MIyyVLCNq
 nnS0yxpGNDFEIb2meZrLFnI/omVBf0PghLQtXd7Lq7nWD2G4rUpzjmAVcl4bN8vU1RgNPRvSvHLhx
 nBDBbuqSJ+sFY1+4NLAg/aJBpqPJKDKGdVYTVGaY4YmHzV3U+jCCLlEHqx/duPLW53VZN88yJm34l
 cDwLrvp87iJ7wO4IMtguhWuuJKqsgHEZUfd3MnS8j/0Y1XN6StNkiUUk5A18rB+gU+iOfc/nYY8LB
 OImKaeTp7Go2i2r1rsQgl9AZA8/YdQCW5dzSafsqc4NbiRZzianZxtqx8WnkAvUTF/9F5fLcyWoml
 9oG22/yA==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldq6P-003n9t-79
 for linux-nvme@lists.infradead.org; Tue, 04 May 2021 08:08:22 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1620115696; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7YLxD4201LgDHt76WCSlvgaGUhn0EbWLY1JsN+RF+qE=;
 b=WzESRdUbXbhqakrRxoTT0SfkiyVbjoCvrnlMo9UhEgBb3mYjFBOs1QnMxyNgXXQLbMcQpb
 17ESFnkWA87pr++MRcEoAUatkLeilEsqJU0u356DhfvqwDFU31DoGF9fo8TVtvn09OnRcA
 IrbcqQM65gK7KqANW53zNzqSs2feNfM=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 9BCC5AECB;
 Tue,  4 May 2021 08:08:16 +0000 (UTC)
Message-ID: <976928a1a0ea430f48af8c20b6b3799e7e6791ec.camel@suse.com>
Subject: Re: [PATCH v4] nvme: rdma/tcp: fix list corruption with anatt timer
From: Martin Wilck <mwilck@suse.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, Chao
 Leng <lengchao@huawei.com>, Hannes Reinecke <hare@suse.de>, Daniel Wagner
 <dwagner@suse.de>,  linux-nvme@lists.infradead.org, stable@vger.kernel.org
Date: Tue, 04 May 2021 10:08:14 +0200
In-Reply-To: <20210504075257.GA17142@lst.de>
References: <20210427093110.16461-1-mwilck@suse.com>
 <20210429122433.GA27567@lst.de> <20210504075257.GA17142@lst.de>
User-Agent: Evolution 3.38.4 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210504_010821_456251_F91AEAEF 
X-CRM114-Status: GOOD (  10.76  )
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

Hello Christoph,

On Tue, 2021-05-04 at 09:52 +0200, Christoph Hellwig wrote:
> On Thu, Apr 29, 2021 at 02:24:33PM +0200, Christoph Hellwig wrote:
> > Martin,
> > 
> > can you give this patch a spin and check if this solves your issue?
> 
> ping?

I've provided a test kernel with your patch to the SUSE partner in
question, but it's hard to reproduce, the test will take time.

Regards
Martin



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
