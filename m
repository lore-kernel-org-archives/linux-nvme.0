Return-Path: <SRS0=JVDK=LI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C65EC48BE6
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Jun 2021 06:36:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 217B761055
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Jun 2021 06:36:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 217B761055
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3G6OaFr9CA4BtHb2+Gs3OkDxVZMxsF7JpWCdgfz7wzo=; b=derGHK9coSQYPt
	wdViMDu/14WMQ9FLgOKna2rKrB5TkLPvEVFqDAFLAs8SwYizlWoBseJuCrsvUSiAnWDCAPS/2Lynp
	ognKMbIpB6qT5L9ckN95Y6VEmUxMpV+8GNsnp1NZjWVaTmKXUPl5vT3FuvQXkKMuEoItbqyo6C5KG
	N4oJbfeDpfnWVwEWiBGboNF4NisFmL+dr0FL0tigHkc6rNFnVfQSKsFyyOD7Bi3LgZ54FJM6yuB6i
	+gWAAciFBw3mGDKpjdIVEm7ApQyacpKfqJMQySp1GyLKJm2ht4QipDOQ6rEQ3fxktFT3MB4/GO9QU
	UFRvKVSd6cT/0mV9WMzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lsgD5-00CjwR-HC; Mon, 14 Jun 2021 06:36:35 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lsgD2-00Cjvn-5N
 for linux-nvme@lists.infradead.org; Mon, 14 Jun 2021 06:36:33 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id B32AF67373; Mon, 14 Jun 2021 08:36:29 +0200 (CEST)
Date: Mon, 14 Jun 2021 08:36:29 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, dwagner@suse.de,
 sagi@grimberg.me
Subject: Re: [PATCH 1/3] nvmet: use subsys->max_nsid to report MNAN
Message-ID: <20210614063629.GA29129@lst.de>
References: <20210613200252.9167-1-chaitanya.kulkarni@wdc.com>
 <20210613200252.9167-2-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210613200252.9167-2-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210613_233632_378196_6A53D05A 
X-CRM114-Status: GOOD (  14.62  )
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

On Sun, Jun 13, 2021 at 01:02:50PM -0700, Chaitanya Kulkarni wrote:
> For Spec regarding MNAN value:-
> 
> If the controller supports Asymmetric Namespace Access Reporting, then
> this field shall be set to a non-zero value that is less than or equal
> to the NN value.
> 
> Instead of using NVMET_MAX_NAMESPACES use subsys->max_nsid to set the
> MNAN value.

I think this is a rather bad idea as it is supposed to be a relatively
static number.  I think the right fix is to stop playing games with a
dyanmic NN and always report UINT_MAX in nn.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
