Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83B2DC6FA82
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Sep 2022 00:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dM1RgLSc+qnvlGDJeSYTW+nQt03cuA1jE53a/YsqGUE=; b=oqmXh535A13QwikmXXe2FRVFLY
	c3NHNLaqBJ2fDlqlMJyYrQ/DZOgxY7Lzl6hEnqkQXQJy4w/hkqwNHWJfGZ51QSNVeUwhQfbhoCGuy
	6p82CfaYGdsIcy+dTfcQbv8m9qT3zdeDcxKJ9ofBeD5lGJ1P7hjs5bvBV5suLAeTBUoORpmMgtp3F
	BTp2Cfhgo4XmI/O2sWZTW7bWeFq9Nrt8KzAI/yTnzXvKQaTs00/+eq6ZFtk7rSzPFL0jCCGHszEbh
	HIsE1TDPyrOGdO2qVQVQI8LenBWuuIErNMyJvWphD0T1A1pv2FWww/A+H3ISvgmaR7ZqKrwCYzJK/
	RJxwnNSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaRUW-00GpF4-Ea; Tue, 20 Sep 2022 00:52:00 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaRUT-00GpEH-KW
	for linux-nvme@lists.infradead.org; Tue, 20 Sep 2022 00:51:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1663635115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dM1RgLSc+qnvlGDJeSYTW+nQt03cuA1jE53a/YsqGUE=;
	b=SBNQQQQarFBbu6OXW2QMSbY8UJo7fZWxgli4Xmb6d2U9Nsq/3z4IIGu+Wx8tSxPbptovJv
	zPvnsToJVniyJe3s72mV+gwXMZWJp/QGHpCWz5cN9SMFkC1Et2saYWvb3yw5XJWgLYfYUO
	D3cMQRP6JMmtw2k6ZLjex8I0dgjStks=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-628-zAQ3op65OAiK09h5iXprsQ-1; Mon, 19 Sep 2022 20:51:51 -0400
X-MC-Unique: zAQ3op65OAiK09h5iXprsQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 93FA93C025B5;
	Tue, 20 Sep 2022 00:51:51 +0000 (UTC)
Received: from T590 (ovpn-8-20.pek2.redhat.com [10.72.8.20])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C65DB200BA63;
	Tue, 20 Sep 2022 00:51:47 +0000 (UTC)
Date: Tue, 20 Sep 2022 08:51:42 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, Yi Zhang <yi.zhang@redhat.com>,
	Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 0/2] nvme: make NVMe freeze API reliably
Message-ID: <YykOngCxMDNhnWjw@T590>
References: <20220821084754.340585-1-ming.lei@redhat.com>
 <20220919145215.GA29098@lst.de>
MIME-Version: 1.0
In-Reply-To: <20220919145215.GA29098@lst.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220919_175157_779279_25994D52 
X-CRM114-Status: GOOD (  14.83  )
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

On Mon, Sep 19, 2022 at 04:52:15PM +0200, Christoph Hellwig wrote:
> Just trying to get back into this:  I think we're all in agreement
> that the approach is fine now, aren't we?

Accurately the approach in patch 2 is fine, but there is still
problem in patch 1.

> 
> Ming, can you respin the series to cover all transport and not just
> PCIe, please?

OK.


Thanks,
Ming


