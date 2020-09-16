Return-Path: <SRS0=FbzM=CZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F31C43461
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Sep 2020 07:12:29 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C49E8206C9
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Sep 2020 07:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lvs8QQI9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C49E8206C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=p4NwjSdaHg8iNZia9TJJHSWT0YTUPU++cR24zdyQdyk=; b=lvs8QQI9pvw0kzfKtgZqIClOp
	wQy6HEvoxe0oisBEMF9PG7cdJZZeuA/uot7EaMbtxF8JiXVOEboXoJI1xP+orkgp19fr2SGOpzeez
	IcXVkLC1/8Z7rRUjQ5/aadLt43yPl+rk5+nuHY0uyyIxmWnnIdXzQ/FPkx10myQ//q5WG83T5M3yq
	yQmAiMXCW0Sp8y7qbbM6Cx1HE47aOP5lKN2oN91SNy/o+zC0T4Z8hCMN6O4OzYDSakxq5/SatyuPk
	tE2+uqKkfWOJ/TOVgl+qP33hT7tGm5ubpx5eSsl8AtRZX2XN4aCFViHTkPfhTcyOjxRxONAeiSlVq
	G1obbRa+g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kIRcA-0005SP-Nn; Wed, 16 Sep 2020 07:12:26 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIRc8-0005RQ-G8
 for linux-nvme@lists.infradead.org; Wed, 16 Sep 2020 07:12:25 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id DCA4368B05; Wed, 16 Sep 2020 09:12:21 +0200 (CEST)
Date: Wed, 16 Sep 2020 09:12:21 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH V3 5/7] nvmet: add passthru admin timeout value attr
Message-ID: <20200916071221.GB9592@lst.de>
References: <20200915215118.3934-1-chaitanya.kulkarni@wdc.com>
 <20200915215118.3934-6-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200915215118.3934-6-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200916_031224_690297_A0235E27 
X-CRM114-Status: GOOD (  10.24  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: kbusch@kernel.org, hch@lst.de, linux-nvme@lists.infradead.org,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Sep 15, 2020 at 02:51:16PM -0700, Chaitanya Kulkarni wrote:
> NVMeOF controller in the passsthru mode is capable of handling wide set
> of admin commands including Vender unique passhtru admin comands (VUAC).

VUAC sounds like someone is throwing up and certainly is not NVMe
terminology.   I also don't think we should care about stange verndor
specific commands.  If we want to communicate command timeout we need
to add them to the command supported and effects log, similar to what
SCSI does in REPORT SUPPORTED OPERATION CODES.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
