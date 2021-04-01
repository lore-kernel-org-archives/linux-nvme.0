Return-Path: <SRS0=sXsN=I6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41238C433B4
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Apr 2021 15:13:02 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6BC961277
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Apr 2021 15:13:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6BC961277
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=SNoFZMC2tKMWdvGhX9Ikuqoncr0LB9t+J9VHNrgvRQQ=; b=CWH8K/a15XFzjI6SuV6vWwPa0
	i0i15OTYkyFJpQ9CawCFj7/4YxvBayh5ZCDhtM/s8jZ56h2VnjiDN0w5fAn0zh0OFGVf+q3rzpeaI
	45OfWn2G31oI6M7BlB3WcJFeCP2oyr8bigzCOmCeZKIlGqvXfeWHi6PwKiJbhvzaL78d8b/zbqsLI
	EJBxXfTmtcAGtzJxo2T6HfLzqJQCT2mY/9l1vWK4asY7j6LWWF74oROjaLZ84AYlZmabo2E8IEt70
	6qZGHNGnQjUTsCqhg5oU7GPnLQYv67PgyYq6quu60mdG2dqO7xKEIDutNEkC2TBQTTpMpeG3xMGb8
	ZCNzdJpHg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRyzz-009xqx-UX; Thu, 01 Apr 2021 15:12:44 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRyzw-009xqC-GS
 for linux-nvme@lists.infradead.org; Thu, 01 Apr 2021 15:12:42 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id C8ECE61369;
 Thu,  1 Apr 2021 15:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617289958;
 bh=RNONe9oly32stda/UPL/dgZMQApeW+L7RNnujmFJcuE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Y3sUvXlg4ZqtCTIrHOUA8y3xuUn+MQhZZ/iacVYOEMlRa6rl7O8OjXwng5BzsEE1O
 DN7NMgJTu4MXgwkGGMjfoSVKAt+2TNgoLLz1nEYyUSpJIn3XczlOsBRwYn0m32CLJ1
 EA6qD87ZqvT4r52Es8cf8aCmZvS50n/Y8HxZ2YzdqvPs16LWe2ggJWKhRq4xZri2b3
 0rrwAz52tbLFwhKxYz0fLBa2CsFagmR30cxxiQVJcWfU/zfBTNhZ1uxg6YFK3z72xq
 wQ4tmHiHuJ48CNEgkU/T9HeQ/gdKXcd2zA6eCNfBI9jC6qwgc8TxZ/76WnKe1M4zYN
 Wr1h1qt0fLL6A==
Date: Fri, 2 Apr 2021 00:12:34 +0900
From: Keith Busch <kbusch@kernel.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Hannes Reinecke <hare@suse.de>, Chao Leng <lengchao@huawei.com>
Subject: Re: [PATCH v2 2/3] nvme: Remove superflues else in
 nvme_ctrl_loss_tmo_store
Message-ID: <20210401151234.GB29196@redsun51.ssa.fujisawa.hgst.com>
References: <20210401095412.84254-1-dwagner@suse.de>
 <20210401095412.84254-3-dwagner@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210401095412.84254-3-dwagner@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210401_161240_820895_9CC37D82 
X-CRM114-Status: UNSURE (   5.54  )
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

For the subject, s/superflues/superfluous

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
