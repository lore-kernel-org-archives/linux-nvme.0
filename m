Return-Path: <SRS0=/SuC=JR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD20EC433ED
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Apr 2021 08:06:18 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 302596109E
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Apr 2021 08:06:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 302596109E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=nYsu161XYaR+ZasieOHpvel8MJI2syKQdB9tHzNkj6g=; b=TnrPq4BrPQhmcyyqPOT0Ja+su
	We9DUx/yVGWJDSIC330V72bA2YIJ1SvPdoMbJAbiair7/7pa5iRf+q/XVR2XNsQIfI9j6e9O9UzMV
	BL5njiq1MkZY1ENY5oVE7YiCCc7RgrjpvHd+CHGBo7clAmGT/jNsLExoIuc1/FhjN5QX9f84uFgOe
	EeGH+GMoxGWF4cD39kHYzV4pHPZQxLuDbHdyUsephGg8DgY9JsXphkWKXaqBhYFxOc57ezlZoY2DB
	T+18yLQ7s3MhlagOZZAEUkjXXrtzB16ve4RnMtwqO+Wyg4FIc9nbAD0ckupP2uJ+hytF5Yv0JtZDw
	3MD/5PKxQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lYlOF-00BX6B-Dy; Tue, 20 Apr 2021 08:05:47 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYlOB-00BX39-00
 for linux-nvme@desiato.infradead.org; Tue, 20 Apr 2021 08:05:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=Kn7Ksdke/pd9vtKtiyYBSuVcOkyKMfe++Qop3w03gCQ=; b=H6nhWiRXmQnzvVjfdE9yHJMNL3
 IkHeyVogNJobVjU7hVSopLI7DmUmeUY7iooeY01dvCIX4BYW/hWDMQYSmxFup+VLX10hWiP/Z2evx
 7Kcs/wfqnHXs2244ZXxzhzD6pelew2n19c7F5Hzpqd7Tm3dqs59xWkzJVDdNFFFD/UWs9J0ucWBUJ
 E4MjLKA+sFvEbU79dm4gSQBL2x7QxkZdRilNY6OqP5ot+SxJmpRmUVRU8AV9RMJV6s22MxlirKXbl
 xQJxwYgVyrjSgkca2SawiL3XJW9o9b529ZkQd4ZWVavxDopaw/9MdwevHQsseByEpxfLPnmG9vAh0
 MrVzTVAw==;
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYlO3-00Bu2H-RP
 for linux-nvme@lists.infradead.org; Tue, 20 Apr 2021 08:05:41 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id BFC7D68C4E; Tue, 20 Apr 2021 10:05:27 +0200 (CEST)
Date: Tue, 20 Apr 2021 10:05:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>, Daniel Wagner <daniel.wagner@suse.de>
Subject: Re: [PATCHv2] nvme-mpath: delete disk after last connection
Message-ID: <20210420080527.GA21651@lst.de>
References: <20210416062411.47958-1-hare@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210416062411.47958-1-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210420_010536_072470_F2BA3EE3 
X-CRM114-Status: GOOD (  11.36  )
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

On Fri, Apr 16, 2021 at 08:24:11AM +0200, Hannes Reinecke wrote:
> With the proposed patch, the following messages appear:
> 
>  [  227.516807] md/raid1:md0: Disk failure on nvme3n1, disabling device.
>  [  227.516807] md/raid1:md0: Operation continuing on 1 devices.

So how is this going to work for e.g. a case where the device
disappear due to resets or fabrics connection problems?  This now
directly teards down the device.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
