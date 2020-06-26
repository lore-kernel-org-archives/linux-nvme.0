Return-Path: <SRS0=morU=AH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A39A3C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 11:21:38 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70874206A1
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 11:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PMw4navb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70874206A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=kmg691RQJ6g0giEYfkQvIAhhxfejqgwV+qEPG9cij0I=; b=PMw4navb4LkRGxX63AtTXHpDF
	GgkOckYsl5QJNmS2wGLQbzDlc9CUH2oTofDMV6CBzeBVeax844VfWjtDQa6RSEOVk08+eOnm1nT2j
	RG+M0MB2EZZOVHydSzTp1eSjxa+0o4MIjWlq2ZJ7qGfEHIWyd6XF6rV7OmCzsnFuqKYiM794wBJpg
	DQd8em8/sgSVH6WGVpTbsc3GSNyQ6xsx7IDpjTVuHaIuMFAnKeSszW07Hou2UmT8NbwBNeOlQcUiy
	sThgvqircw559MFNi3Wa39QxvXl3OySUgeh4Wr4xd7qPT0bovaPFVHuX1337m7UQ35orArALRtg4S
	RuVpZQ5mA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jomQH-0000XO-DH; Fri, 26 Jun 2020 11:21:33 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jomQF-0000Wf-2p
 for linux-nvme@lists.infradead.org; Fri, 26 Jun 2020 11:21:31 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 6891768C65; Fri, 26 Jun 2020 10:54:45 +0200 (CEST)
Date: Fri, 26 Jun 2020 10:54:45 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCHv3 3/5] nvme: implement I/O Command Sets Command Set support
Message-ID: <20200626085445.GB25535@lst.de>
References: <20200622162530.1287650-1-kbusch@kernel.org>
 <20200622162530.1287650-4-kbusch@kernel.org>
 <69e8e88c-097b-368d-58f4-85d11110386d@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <69e8e88c-097b-368d-58f4-85d11110386d@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
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
Cc: axboe@kernel.dk, Niklas Cassel <niklas.cassel@wdc.com>,
 Daniel Wagner <dwagner@suse.de>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>,
 Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>, hch@lst.de,
 Matias =?iso-8859-1?Q?Bj=F8rling?= <matias.bjorling@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jun 23, 2020 at 01:53:47AM -0700, Sagi Grimberg wrote:
>>   	if (ns->lba_shift == 0)
>>   		ns->lba_shift = 9;
>>   +	switch (ns->head->ids.csi) {
>> +	case NVME_CSI_NVM:
>> +		break;
>> +	default:
>> +		dev_warn(ctrl->device, "unknown csi:%d ns:%d\n",
>> +			ns->head->ids.csi, ns->head->ns_id);
>> +		return -ENODEV;
>> +	}
>
> Not sure we need a switch-case statement for a single case target...

I think a switch makes inherent sense when there is an identifier that
can have multiple values, even if there only is one for now.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
