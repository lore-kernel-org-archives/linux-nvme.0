Return-Path: <SRS0=ZvdC=KH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23AC9C433ED
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 06:21:23 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D612161433
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 06:21:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D612161433
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=BlRX7Oh21eGSdWb5yhOq1Em7EOCS/vVEJ9NTFw2EAbA=; b=UL+tZN+mscGtmtzbMcxvS13DF
	NfYddZldQLZaKpqlQpxU5yesh+hmgmxb2m2xqJtbpfMz6JFRAde1fRbN2ZhOP/TLrp16MvVe9kvQP
	TbNG5rnWxfOisdN9pxCwsqmFaMC3fT56MSvzg/B+DjyHU7j12O2h5lxtOqDFjMHNMlpikO07YfDiz
	NiCfRrsU12KjBgGrrGwZWn4kRUVAIr/8o7GHYO32m2YFlYtVg44JMm0YCS393afbW5/+UjenTyeSA
	hUkZ+wUP5iKjW64bnhiZpgVnXWk2nex2BXMZwsrBFLf3eyVdrwOu2ADu3X/L4pZopifEZVdebd46g
	mpPQZ4lAA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lgiEt-0028YX-65; Wed, 12 May 2021 06:20:59 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgiEr-0028YM-GS
 for linux-nvme@desiato.infradead.org; Wed, 12 May 2021 06:20:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=NSQ3IVmhfUi893I151ACf/1/CmHwiI7wrcCwpwUziAY=; b=H8fLAZtp8Exc03U7jUs8pb+7gG
 E/40Y9JXs9EufbFOhbJo9DRpFWAV3Sl7E7bfe4xnjs+4pZKzW8Nhzwvhy/m+079JN6xVAnjudeBF8
 c01++8c6ZXEYGe3BSFBpNigKSk2AKeI4C93i04XrbSefoHLTVjFlq3GVe6EPmbDs2WjYGDFKOyLbF
 +qOluRm77yErdQrAXawN5D4GmYY/6T6R50PbriLbAXH2FvB2tmbKurqwV+mb2GPPcmDbhntcGlJrv
 OL/h6MrFeb+C0IZsHlVjqCpRPqqtczcXPNSCYdqZpBnJV38NCeEQHm3LcxH40N0qALhXNsf1lAbTg
 hKIS5rmQ==;
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgiEo-00A8x9-OM
 for linux-nvme@lists.infradead.org; Wed, 12 May 2021 06:20:56 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 63DCD67373; Wed, 12 May 2021 08:20:47 +0200 (CEST)
Date: Wed, 12 May 2021 08:20:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCHv2] nvme: generate uevent once a multipath namespace is
 operational again
Message-ID: <20210512062047.GA18271@lst.de>
References: <20210511080308.6734-1-hare@suse.de>
 <20210511161907.GA17525@lst.de>
 <7b01589e-3987-9573-ccd7-b599affed2a5@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7b01589e-3987-9573-ccd7-b599affed2a5@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210511_232054_966269_C22E3540 
X-CRM114-Status: GOOD (  10.48  )
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

On Wed, May 12, 2021 at 07:24:44AM +0200, Hannes Reinecke wrote:
>> Can you please also add a comment why we are sending the event?
>>
> You mean, why sending KOBJ_CHANGE and not KOBJ_ADD?

Maybe that to, but most importantly why we are sending an event here.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
