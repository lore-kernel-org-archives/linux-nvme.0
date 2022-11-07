Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A0F8C433FE
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Nov 2022 19:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DaMY5vWp4Koe+83yub/e9Mvr7um6ph02u9kFP1DWcnQ=; b=yCiI0vEzC8OKi/bJJ6XhgO4VxH
	Me9CJ9zHm5m434KO8n6vi4raU38e1Gj7RPMKwJVz9ombsnI7gY4/zL16qIFA2bCegWL9j/0dTGTF/
	tckfi8+ph2ShywaooNxlwrpaaKUtslsEHzFpW/TpQ2N0kHTmt/LHJt2Gj3jm1MAujehqCTi2mF9mJ
	lWRIMA9Vc8Y9EXXRLccGZB+YVoCqCAoIy4tTHvW2mm8+QayvNAd6iU3rDLOchBZJ8GQFQIY5mUoBz
	dL6baiAdvN7dL5Tr71Q0kd4IlUEKpk6gUNnzehuDNwpNldT+uogiwbCx6O8YPKMQWk5x/gtvwh4fL
	ArhK5RDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1os7oK-0001HL-3y; Mon, 07 Nov 2022 19:29:32 +0000
Received: from mail-pf1-x461.google.com ([2607:f8b0:4864:20::461])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1os7oB-0001EP-30
	for linux-nvme@lists.infradead.org; Mon, 07 Nov 2022 19:29:25 +0000
Received: by mail-pf1-x461.google.com with SMTP id g62so11553645pfb.10
        for <linux-nvme@lists.infradead.org>; Mon, 07 Nov 2022 11:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DaMY5vWp4Koe+83yub/e9Mvr7um6ph02u9kFP1DWcnQ=;
        b=JDsa5HXv8C9PvR2p/2MVAtyCkQ369Rq6N1Q7ijoZT+2rJNggIjApHuyGwy60eMle/5
         M8r9MD7kYZ9lVjN5zM8cblFOG3FKumaE8/Moid6vpuoM8aCjWP1VK3UlqL3UBG4NKBKr
         fnqjUASpxdyXqP29Tjeek+TdBw0IzWRTozH38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DaMY5vWp4Koe+83yub/e9Mvr7um6ph02u9kFP1DWcnQ=;
        b=5TH/1jeXBAUELpHz0tgSkkvaVvzci8zpve4ve7VhzHHIBsm+DJ9NAvs6Yc/fP9gADk
         +IqAjTL1M30pboOkZLghiTrZFj5znffLfaZcmlNeU8CjjTeOsJoIbqXU61dpi8OFfDKK
         THujTlxD7PvNQPOCNuSUTU+ipPmngE1NIfXzY3q0eOc1yzrQWDaJZrYid4ssBnG87mmE
         iUGkSWOoHKwbgBDevSwhJ941tlV3mF2hEbxHy2L+hW9ukzTCUTbgm9+e6dbE/HxoB02x
         noc0U2pEbD8bX+WtQOQNGZ+lbbZiID0s1ExcXoG537VMNMeZERcAAWhgJfH7om1x3r5y
         PeWg==
X-Gm-Message-State: ACrzQf2nGvyyc1pUfJ0uqnVzJzNpW3xDybCmXhzFUgnk0hqpBr1dKQUB
	74zU5by+02T9Pbr4SHgBvidkfyFMuq+UGqfh5c4elg9uBsRqME8feVVolFZy+pKSOg==
X-Google-Smtp-Source: AMsMyM6peUjattgdkbe3JRTpNIKVQK4l2ckqyOlxbzwDaVax0W44JI7fAZyRxp0sstSPY34GqmM4l3wH7dHF
X-Received: by 2002:a63:d66:0:b0:46f:8979:30e2 with SMTP id 38-20020a630d66000000b0046f897930e2mr40694869pgn.348.1667849357589;
        Mon, 07 Nov 2022 11:29:17 -0800 (PST)
Received: from c7-smtp.dev.purestorage.com ([2620:125:9007:320:7:32:106:0])
        by smtp-relay.gmail.com with ESMTPS id mr22-20020a17090b239600b00213225d6e47sm461949pjb.15.2022.11.07.11.29.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Nov 2022 11:29:17 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp.dev.purestorage.com (Postfix) with ESMTP id 5BE5D21B14;
	Mon,  7 Nov 2022 12:29:16 -0700 (MST)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 574EBE40496; Mon,  7 Nov 2022 12:29:16 -0700 (MST)
Date: Mon, 7 Nov 2022 12:29:16 -0700
From: Uday Shankar <ushankar@purestorage.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@fb.com>
Subject: Re: [PATCH] nvme: scan sequentially only when list scan unsupported
Message-ID: <20221107192916.GA2075022@dev-ushankar.dev.purestorage.com>
References: <20221104223621.1435666-1-ushankar@purestorage.com>
 <20221107055605.GF28873@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107055605.GF28873@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221107_112923_245320_73C64041 
X-CRM114-Status: GOOD (  11.99  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Nov 07, 2022 at 06:56:05AM +0100, Christoph Hellwig wrote:
> Maybe make this a bit more clear by lifting the nvme_ctrl_limited_cns
> check into nvme_scan_work, though:
> 
> 	if (nvme_ctrl_limited_cns(ctrl))
> 		nvme_scan_ns_sequential(ctrl);
> 	else
> 		nvme_scan_ns_list(ctrl);
> 
> and drop the now superflous error return from nvme_scan_ns_list.

Sure. I will resubmit with that revision.

