Return-Path: <SRS0=pISK=JY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06407C433ED
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 08:56:52 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8264D61026
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 08:56:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8264D61026
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Date:Cc:To:From:
	Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Fypw3z6iawFbMtcQuCvEBhRdt780eAmZvrmcqm8vVf4=; b=YqbxzVfwCl7pQwXT4WzCxquM4
	nD2i0QZKdE4KX7KdSfhVYr0xGpcELVlpPy595BrdpxVoULAzpDwRCl9CHl/TKzU2ntaRUQZB88BMX
	vw4qitROKJ3HLLoIUIwhycjxd+0yUBHnfq/VTXSdfZnlnu8dPOOJ/5ePxEPTOWjthalWblm/k0949
	zqcOW9uZORGG0nE5QIPpoKnUufK4Ywobt3CzXj5mMR48lrK2rxismHINFKNatwHaa1uyhRCQMDIRk
	uUTfEtRrjVJwSx9upfdI6At9/4XB+ktyvqEbC/s5NjtoObw844onkuBXmqvFJQl3SZRXxX/bKnJWL
	2ZxCJhTXQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lbJWI-0019n7-Lc; Tue, 27 Apr 2021 08:56:38 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbJWE-0019ll-9C
 for linux-nvme@desiato.infradead.org; Tue, 27 Apr 2021 08:56:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:
 Message-ID:Sender:Reply-To:Content-ID:Content-Description;
 bh=SnAHfuGqaeDhKzcTd38s8oP1AHnHP0fW/UkU3wmlMo0=; b=zxl7aTqhP0XazOOgCkNtqXgL4+
 aOsZKJfr9FMJq9rEkuvSBYNCvNrMtZwqQ4R0UfRpdFqiZIQP/Q4jE08Q2SfGXJJsztd2ziHs8OA+z
 z+/uvfGE6su3W7nTukC66MB2PJ3QdxyDU/OvZBwPmHnZV4URjLmA+2Um2yhyNRneOCqI4GYusrzyq
 zO430M+NRTkP/HBsXYR3rPdSWwWGiVmyqa3MIUv+On9UXb4bi4qfDppH70GTKpBGeVIqGOOZc6EnR
 IQK1I0TF468LlPik8Oom4jkUCbO7HYsRLltaAEiDAwxI5u45ylHjWmmYqGVRLJEK3nf36bXEB5yAk
 QlbvpZzg==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbJW9-00GYqY-Df
 for linux-nvme@lists.infradead.org; Tue, 27 Apr 2021 08:56:32 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1619513783; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SnAHfuGqaeDhKzcTd38s8oP1AHnHP0fW/UkU3wmlMo0=;
 b=GGfEed9WeRNm4HwZYnLOy1YzTrifyf0Ym7jpCGcZkuVAAlQGOZVjEg+KA0eGfHUiVeIv95
 EsRbIGzMEUT7AR7tF8roEeEE0zaTl+ftbbZZT7qJsW8cVCNOlLW1VvO+/iKKL33r7gy5kz
 D0OFjFgY75VC3ewX/EUFc+r5KFZFK9Y=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id D7022B01E;
 Tue, 27 Apr 2021 08:56:23 +0000 (UTC)
Message-ID: <f129a005ba4be672a787a0d9a5cace910bf4f4a4.camel@suse.com>
Subject: Re: [PATCH v2] nvme: rdma/tcp: call nvme_mpath_stop() from
 reconnect workqueue
From: Martin Wilck <mwilck@suse.com>
To: Chao Leng <lengchao@huawei.com>, Christoph Hellwig <hch@lst.de>, Sagi
 Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>, Daniel
 Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Date: Tue, 27 Apr 2021 10:56:23 +0200
In-Reply-To: <069d47c70946bb5b7aabc2f0650c312fcc0b4157.camel@suse.com>
References: <20210423133835.25479-1-mwilck@suse.com>
 <37607acc-74a0-ea13-88a1-0197bf43fc2b@grimberg.me>
 <20210426145105.GA22120@lst.de>
 <2df7213105b42f08fdb021e084f277bb881fb230.camel@suse.com>
 <8b5c6deb-82d1-8803-48db-d104264e17dc@huawei.com>
 <069d47c70946bb5b7aabc2f0650c312fcc0b4157.camel@suse.com>
User-Agent: Evolution 3.38.4 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210427_015629_632936_9C1F39B9 
X-CRM114-Status: GOOD (  13.42  )
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

On Tue, 2021-04-27 at 09:30 +0200, Martin Wilck wrote:
> On Tue, 2021-04-27 at 09:45 +0800, Chao Leng wrote:
> > > 
> > > So ... resubmit and cc stable as Sagi suggested, or work out
> > > something
> > > else?
> > Another option:call nvme_mpath_stop in nvme_mpath_init.
> > In this way, transport drivers do not care mpath detail.
> 
> That would require that we determine in nvme_mpath_init() whether
> we're
> called for the first time for the given controller, or whether the
> controller is re-initializing. It's not obvious to me how to do that
> reliably without introducing a new state flag.
> 

I'll submit a v3 with changed subject as suggested by Sagi. That will
fix the list corruption; we can figure out a better solution later.

Martin



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
