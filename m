Return-Path: <SRS0=+L5I=ML=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF21DC12002
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Jul 2021 09:44:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B33EC6108B
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Jul 2021 09:44:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B33EC6108B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pTlfnOVhieYfBuljztHdrkFTdOXi7I48S/Hq2F45yoA=; b=qnPrRZiTqgUtEv
	NMzHt4Lr1RcB96A70kMz3hmeKpOS8R50rUiLNcDaSYGwjtrNxWGRJClk0gnlmHMAQxn4yEGkudlFJ
	xV7aQKhAcRUAiRXolvgfUWXwPcOnQhmUX2dmNeHH1AGzQNsJYpLAkI9o+8sEVEAEXFnTohRe4oyt3
	U5qdvT71M4nyS6lIZ1CJ/gFheTOgqoq29ylaLQ3EKLTuftBn9Se6qrOIpgwQ4sNc1zIfKPzNs1WXB
	v8sGpIPSJ4c2tuAPeIdd9utNRTlzEKVHJzvvEppuy1RA9a5vl0ggYTXpYVjFWziZAtXpTtGmG9smr
	hV09opqm6t2dMo4d+RgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m5Pp5-0098dM-Ry; Mon, 19 Jul 2021 09:44:27 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m5Pp2-0098ba-SM
 for linux-nvme@lists.infradead.org; Mon, 19 Jul 2021 09:44:26 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 7A7BF68B05; Mon, 19 Jul 2021 11:44:15 +0200 (CEST)
Date: Mon, 19 Jul 2021 11:44:14 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.garry@huawei.com>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>,
 Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
 Wen Xiong <wenxiong@us.ibm.com>, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH V4 1/3] driver core: mark device as irq affinity
 managed if any irq is managed
Message-ID: <20210719094414.GC431@lst.de>
References: <20210715120844.636968-1-ming.lei@redhat.com>
 <20210715120844.636968-2-ming.lei@redhat.com>
 <5e534fdc-909e-39b2-521d-31f643a10558@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5e534fdc-909e-39b2-521d-31f643a10558@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210719_024425_095593_FA57660B 
X-CRM114-Status: GOOD (  15.57  )
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

On Mon, Jul 19, 2021 at 08:51:22AM +0100, John Garry wrote:
>> Address this issue by adding one field of .irq_affinity_managed into
>> 'struct device'.
>>
>> Suggested-by: Christoph Hellwig <hch@lst.de>
>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>
> Did you consider that for PCI device we effectively have this info already:
>
> bool dev_has_managed_msi_irq(struct device *dev)
> {
> 	struct msi_desc *desc;
>
> 	list_for_each_entry(desc, dev_to_msi_list(dev), list) {
> 		if (desc->affinity && desc->affinity->is_managed)
> 			return true;
> 	}
>
> 	return false;

Just walking the list seems fine to me given that this is not a
performance criticial path.  But what are the locking implications?

Also does the above imply this won't work for your platform MSI case?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
