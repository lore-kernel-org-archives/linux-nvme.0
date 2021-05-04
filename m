Return-Path: <SRS0=iWk4=J7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A94BC433B4
	for <linux-nvme@archiver.kernel.org>; Tue,  4 May 2021 08:55:28 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78A71611AD
	for <linux-nvme@archiver.kernel.org>; Tue,  4 May 2021 08:55:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78A71611AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=fvK2Xb9VWywdIeHIUACR7ffMYUwIjgrnCieKlzwb5wc=; b=jNGoiyQy2CpHgymTPeG7/tany
	B50cbSe4utCr2xsGog0K27CJMMC3rHWqMaPocC4e1car2X99C9605sw3jkJ8zrs9O9VWau+0+4+4x
	O6NIf4x0pKIECP4EI2tpb+TIs/3d7EuqD13GjClm8rYCp4795/WrtAUMomkt7ze5BerddtiMF6xUb
	u8z8Uzh7WU9TS5smYny0IchuXn5CM3FPgWAFpAsw8FQPlN7EjVpaHy4XrxffNtbTGBBT+CU2/EVls
	DTGaQIWKQQTjIBED8VWFXGRj8IGa3HJyo9pivHJseJ3c2mTMkv/IOYGEDTzktiPFK6+P4Xxjo2k7e
	2IN6/prCg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ldqph-00FoVF-1h; Tue, 04 May 2021 08:55:09 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldqpd-00FoUn-63
 for linux-nvme@desiato.infradead.org; Tue, 04 May 2021 08:55:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=thO7I/bV7oep86yqCZD/YdrpcqglHT5WdasgIsj1UGM=; b=EiDxSVlgtzhDyqGsMS5opninp/
 YjrAduq+qsfZtTByBIARZvq56AXZKqmBbzcxrHaH8U19PcBF0yiAyI/GHVvoVDz7Pz4zEWDVFQ53E
 PIBm4FPcaOutiW18jxDpbF4z3UeKWiNB4wvKNswLpB21dlm+jzPq1Lbqu8IA1qks27ULj8ZtBf6Bo
 tJT3Lm4p74K5tGO8y+psYny/vk8caWsId6H7LOFO/kGq2UiaXOVU7u8hrUE6sWLfSOq5QtFenT3R8
 J9dDvRgvhAVSAx/Fd/h9e5u5RQJnEBwFI2+f7AaSeHU65Hyjbn3kzfj+/kpKNC24VPwcpfjlpY6Ab
 r5c8tZDQ==;
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldqpa-003pop-OL
 for linux-nvme@lists.infradead.org; Tue, 04 May 2021 08:55:03 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 2413268AFE; Tue,  4 May 2021 10:54:58 +0200 (CEST)
Date: Tue, 4 May 2021 10:54:57 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>, Daniel Wagner <daniel.wagner@suse.de>
Subject: Re: [PATCHv3] nvme-mpath: delete disk after last connection
Message-ID: <20210504085457.GA21826@lst.de>
References: <20210501120447.45478-1-hare@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210501120447.45478-1-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210504_015502_952192_4CFE0098 
X-CRM114-Status: UNSURE (   9.06  )
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

As stated in the v3 review this is an incompatible change.  We'll need
the queue_if_no_path attribute first, and default it to on to keep
compatability.

Also this lacks a changelog documenting what changed from v2.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
