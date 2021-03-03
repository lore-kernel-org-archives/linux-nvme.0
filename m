Return-Path: <SRS0=PLgZ=IB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC25C433E0
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Mar 2021 17:32:22 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E2B164E60
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Mar 2021 17:32:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E2B164E60
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=BBBDw1v+ZzbE/UfNIx7MzYCAmloHGA8oYMzad/CgUgU=; b=Tw7lQg9Fb1QjAVCjKYKfwIoMO
	K8rtkjxGKFnIZDsSltEXAbNOT6tZukWhue39RDr4sujZEQJhXdTDbFh1hos2u83pck/QtPXgR1hAU
	0t24/b3tQ02myTFjnOeE3wrihky57aOP7zstsEf97uhZLY+ACyjK75KgJ+tif2NOrYHUqjKR9+OXh
	XSbMMcAs818AUpVhIYaIGL8zDwnV/1vp9O1PHS/qmJzxLgxSIsI6u3659ZArIzTy0Hzg76s0MMDKx
	MU296PS1K/ufQfuDuI89AJprM9e8rXFzzeXPAaZHO5ljICmr66rCUTpnsTxXxSRCfqUDO3w1MB+am
	pPx5l/hbw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lHVM3-005okJ-CN; Wed, 03 Mar 2021 17:32:11 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHSvN-005FWp-Ew
 for linux-nvme@desiato.infradead.org; Wed, 03 Mar 2021 14:56:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=C4/RMHu5KWTYVaFuG6PWibPYd5o+5Hr0/RK3nDgR2fI=; b=gEeJ2ZijssKkwtgo+ctOhU2ijL
 MqtrimcYUV6m7YblvcV/YQhY6SBeJIxAeN588SaH6hUS5S3Sf+o1qQXeO/oOKbASGthlYPcR495c1
 LmcsQoXdWLm1BjRUgnblUjQ+zbRSlRaChTDVrJDP/fq6eB/5x1XU9BKfPN6rVvdsq++yvyWsHkk2B
 L/xCy/1QQ2UsO50TztPjbSaRy5bw8ZXoeUGEVkIB5auEByHFEYjgSSS2IlnTxvX7myfBT6/uEgrKA
 al3gGSk2bYwlMbpnQrxq+nohSMHZkcHL782mM5o53mexzawWuE+D4Kq1i6dFX0w0twQ2kj0S3cDlT
 SkF2h1qg==;
Received: from verein.lst.de ([213.95.11.211])
 by casper.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHN5C-001ss8-11
 for linux-nvme@lists.infradead.org; Wed, 03 Mar 2021 08:42:17 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id A802168B02; Wed,  3 Mar 2021 09:42:10 +0100 (CET)
Date: Wed, 3 Mar 2021 09:42:10 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>, Daniel Wagner <dwagner@suse.de>,
 Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/3] nvme: fixup kato deadlock
Message-ID: <20210303084210.GB9898@lst.de>
References: <20210302092644.80701-1-hare@suse.de>
 <20210302092644.80701-2-hare@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210302092644.80701-2-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210303_084217_301496_85303C13 
X-CRM114-Status: UNSURE (   9.53  )
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

On Tue, Mar 02, 2021 at 10:26:42AM +0100, Hannes Reinecke wrote:
> +	if (test_and_set_bit(NVME_CTRL_KATO_RUNNING, &ctrl->flags))
> +		return 0;
> +
>  	rq = nvme_alloc_request(ctrl->admin_q, &ctrl->ka_cmd,
> -			BLK_MQ_REQ_RESERVED);
> -	if (IS_ERR(rq))
> +			BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT);
> +	if (IS_ERR(rq)) {
> +		clear_bit(NVME_CTRL_KATO_RUNNING, &ctrl->flags);
>  		return PTR_ERR(rq);
> +	}

Adding BLK_MQ_REQ_NOWAIT should be a separate prep patch, together with
reducing the number of reserved tags.

Also why do we still need the extra test_and_set_bit with the
NOWAIT allocation?


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
