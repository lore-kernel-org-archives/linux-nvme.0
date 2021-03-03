Return-Path: <SRS0=PLgZ=IB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF2AC433DB
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Mar 2021 17:10:00 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB25364EDB
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Mar 2021 17:09:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB25364EDB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=eMtHrYSicggmTB2zXj4EJkcqKgoiILvY9QxLs6j/3KU=; b=XBMQiIpXTOwAssZARlkpGraui
	aksZMz2jWbYhnKhWwWjNchjBUxGNeFd9JoflkepgqLzH0s5jNRvgUTNfhD2oN/xmZfIHT0hNsHohC
	3lpB/O+hz6nQA0OpGzXM3p9zxaC03tyPacXlQIjlYB/TOnLET4nT2WUIK6AoBKJRerTPEuf5PLLn7
	O2RpXfgLn8rnv1gX2iGMPShmwSL6ZB24mQQ80cWWvFsR0pM8ELUoCnNzNokBfSZqCKhMYNIElYXJk
	5Byo0xkkKiIWt+Fq2nTGdu8pqNy8CGjRglNv0Q9p5d7YHGGDANL4cVdpQmhnEVP0pXy1r1NlYMg+u
	TitBgEsTA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lHV0R-005jrO-1Q; Wed, 03 Mar 2021 17:09:51 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHStJ-005ExX-J4
 for linux-nvme@desiato.infradead.org; Wed, 03 Mar 2021 14:54:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=A7s65AcJddNiejAt/j1dQ/PZCmBcKsKPZE46vPg/zzM=; b=be6YEJmm5FVCKaEjcEE50jPH8h
 83UhCDhXbsNzneC3X1w55+vttsnCqoGydqFQxHTZKGX6ThFrR5D6j9hWVNA536Z4AwOJNOchlOZIb
 cgLYIK3K/2xuXJBDNVMfeUGM6XKqdgoVHLcdRmqSq0lCOXdmhKQTSyUUqSPmzixQGFafb8oipRDCg
 3zO38XBGHA3DeGtwrRiWsWM/Sv8OtVqFz378uyklNe7CRnyds+edgzMKgj25lGMRHFGIe0+jo6nkU
 bE+vEIih/A+r0rE8iqrvmG3dbocCcm2iDOKJn7b12lGOenWXQRotg5asc0C8llLXC/mHJXEqR7fZR
 ax5rpVwQ==;
Received: from verein.lst.de ([213.95.11.211])
 by casper.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHN2e-001rbu-EX
 for linux-nvme@lists.infradead.org; Wed, 03 Mar 2021 08:39:36 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id B04CC68B02; Wed,  3 Mar 2021 09:39:27 +0100 (CET)
Date: Wed, 3 Mar 2021 09:39:27 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Keith Busch <keith.busch@wdc.com>, Sagi Grimberg <sagi@grimberg.me>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: send uevent once a multipath namespace is
 operational again
Message-ID: <20210303083927.GA9898@lst.de>
References: <20210226080538.108392-1-hare@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210226080538.108392-1-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210303_083936_894416_9B9858EA 
X-CRM114-Status: UNSURE (   8.69  )
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

On Fri, Feb 26, 2021 at 09:05:38AM +0100, Hannes Reinecke wrote:
> In an all paths down scenario I/O will be requeued or aborted, and no
> further I/O will be ongoing on this namespace.
> This leaves the upper layers unable to determine if the namespace
> becomes operational again eg. after a successful controller reset.
> With this patch a 'change' uevent will be sent per multipathed namespace
> once the underlying controller moved to LIVE and started I/O processing
> by calling nvme_kick_requeue_lists().

This should use disk_uevent().

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
