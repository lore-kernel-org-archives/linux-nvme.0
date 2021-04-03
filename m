Return-Path: <SRS0=UR7E=JA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 928BFC433ED
	for <linux-nvme@archiver.kernel.org>; Sat,  3 Apr 2021 08:16:16 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B43A461208
	for <linux-nvme@archiver.kernel.org>; Sat,  3 Apr 2021 08:16:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B43A461208
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=pp/9ZQF49dKe+S2O/S1/EXD1BHa595HaksMxeDVYfvM=; b=NgQr/wM1DfAnFLXbKoEB0vJ9v
	padCiBgfdMMz0pXKQ7WBdtCBL1FrayjWYJD2ORs0YGi7zG/Wp3LbUnfg6jTp4qDZxRH0/W5Zx/VIj
	3Ayil460fNpiDMI9BxjLjjVtqoSjYiRosgF7guQ/3/nXFiaTJoipmoSQpvTXt/yLdYai6bzV37Ml7
	XHBMYAnmEjWeKbDuP0Cyt9R1EkPw0bw87NOKIySz/5GvkFeH8Qwzh3WZOzJIOOeIzPS+AQhCjamp5
	OVfgqi+jaO8clRqpCptREhXy51M4VO9UzKTiUhp2wj25LIJq71/R98MyOYMAgWk9tXbJHD4Vni4O+
	CHdlWyiBA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lSbRu-00ESqo-C0; Sat, 03 Apr 2021 08:16:06 +0000
Received: from verein.lst.de ([213.95.11.211])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lSbRq-00ESq4-Gx
 for linux-nvme@lists.infradead.org; Sat, 03 Apr 2021 08:16:04 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 8AC1768BEB; Sat,  3 Apr 2021 10:15:56 +0200 (CEST)
Date: Sat, 3 Apr 2021 10:15:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: Niklas Cassel <nks@flawful.org>
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
 niklas.cassel@wdc.com, joshi.k@samsung.com, javier@javigon.com,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] nvme: disallow passthru cmd from targeting a nsid
 != nsid of the block dev
Message-ID: <20210403081556.GA26879@lst.de>
References: <20210402201808.31979-1-nks@flawful.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210402201808.31979-1-nks@flawful.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210403_091602_638921_E38383A4 
X-CRM114-Status: UNSURE (   9.24  )
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

So it turns out that while git-am complained it did apply the patch
just fine and it didn't look whitespace mangled.  No idea what went
on there, but the patch is in nvme-5.13 now.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
