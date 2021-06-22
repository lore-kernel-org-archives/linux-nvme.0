Return-Path: <SRS0=pSM9=LQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA89C2B9F4
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Jun 2021 14:57:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E57B8611BF
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Jun 2021 14:57:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E57B8611BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Zu1o0Ra88l6CczHsI7f0+yGErUGTnx3FktreZVLw6Dw=; b=FCRIFRJq3OBPCW
	U51mWo/Zh0B2W9pzgoq9LO8lApGb/hFPeHXl/Eve5rO4h5ctwYWWKpTz/QOR8Fzo5jZ3lP8lcAxA/
	fWabiTKhTZIYZTX3PgySydiugYhC9lKjrvRg9jz2UUT+K59xCrLT6t52Z63t3mTvCqZ0eltNKBC+j
	dhmXHOuAGbTre8RrQ5O8fo9aHBJelA0411BV+XzmbSb3h4IOMh5UM9UBV5dlEX+RUrwmNNv0NcGXl
	M357dx3ZIIMGyyqm5qG3cpBGpbZoGgSOWkiut0DlfeQncjbZF31hppl+1uy6REfXnqfKpgJGrj7Bg
	4mrg2E9NIskXdwqmSOOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lvhqC-007ZGP-4G; Tue, 22 Jun 2021 14:57:28 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lvhq8-007ZG3-SO
 for linux-nvme@lists.infradead.org; Tue, 22 Jun 2021 14:57:26 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 893F360FEA;
 Tue, 22 Jun 2021 14:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1624373844;
 bh=IhVaTTUCiqZBUzrBWDJ4f9rLfQX0JQeiWSx14O9TNuQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=sAVdnLQqGc7/MA48bzs6ct6xcAP8PQKjzNsfhFhqCVvu7l/7BcS487EGU7jtzNc2T
 /Ip11ZTekAxYxVWu+AT+OXrCbRcys5+GpGhQZEGicA/lPCzenlcWcLZqgxmEaGDeFm
 KqhAUGIEkEi3SWA7SCf6fJEgRZ7fhO1q1mWJptckzP6u3rcLg+mjS88Z8PBaSTpGoF
 j0LF7yLOf5HeCxluFwVcEkmRYWJAi71O3VbbYagBwfXXSp0bHrtkrh7ptRu5uwmcUx
 +SPlbZsUAZsKzuB8qReO9/5AoorNFPVo0l4V05HoYiZnlzsUWEiQG/AQhxNdKVxqaI
 ZM+rg4A+iowog==
Date: Tue, 22 Jun 2021 23:57:18 +0900
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
 linux-block@vger.kernel.org
Cc: axboe@kernel.dk, Yuanyuan Zhong <yzhong@purestorage.com>,
 Casey Chen <cachen@purestorage.com>, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCHv4 0/4] block and nvme passthrough error handling
Message-ID: <20210622145718.GA11584@redsun51.ssa.fujisawa.hgst.com>
References: <20210610214437.641245-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210610214437.641245-1-kbusch@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210622_075724_973249_31C53F0C 
X-CRM114-Status: UNSURE (   6.17  )
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

Jens,

Do you have any thoughts on this series? I think it's good to go and
have received reviews, and just want to check if you are okay to take
this through block.

Thanks,
Keith

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
