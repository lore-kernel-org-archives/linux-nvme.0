Return-Path: <SRS0=/503=JU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62482C433ED
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Apr 2021 22:05:30 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26F696146B
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Apr 2021 22:05:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26F696146B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Q9tHX+7SMLIs/stXT8a6BxfQcFVv838h/BZS011pB5g=; b=luQNEEageqozbsxQ5G+oKPDP2
	TEykb+CHY1YoZUb/T2nQKiHPnwHb/3VY505/042eqttEObzSad6U8Omth+/42vcv97BoOb3X51B3L
	BrW2+PjpQCe9z7r73x9Ei9Ggc8V83P1Rc7+BIpmJLorfMnqTWe/eWdtFcKG1FilSQvm8yfXJDTKy7
	nHwf/n/1zn2NFXjuIh05xtQ7jpx5MXMjXFjTIscZm2on54l+0AxoWsBrXLI11UGJIUFBwPDpuaVX9
	U4uWsk0z2n1a1ydPdn0FhmUpK5LExzgJvp7HsROo4ILYhf35C1cuwsCB6r4sg9BlI1VYLzyNwVqpV
	Qu66E6m3w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1la3v6-002T8k-DS; Fri, 23 Apr 2021 22:05:04 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1la3v1-002T89-Gm
 for linux-nvme@desiato.infradead.org; Fri, 23 Apr 2021 22:04:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=5I7f25efOcuG4ieJvT0ovuYzdBDs8s7FIQEiKrfubsg=; b=b9v/nNrLScAAXqDAuBPKy39kM3
 a2CcZzzA0SVryhJsX7y9GkBMgzUtGhc0l9jBUGCCWLHg2WKjVWwvBBpHzxJUpV5rfl1qExVg/ZtNP
 Jzlyjllnl7PdZlVucFuHtv5BFqf8yjLdtc+MYimNR4z5TJ8iVm3Lwb8MPKgqV+4ZPovTFRuE9hO4l
 qDp0Dwf71bUXjLXc59L9WDe8EVCWNt2P/k3+/xgytEdWRg72q5yxDNUH1rs4NNXTVfbjqBL0jferE
 p74GCLd+7/ov97NcORSuL35C1k6LknQclIU0VtpBPS4RCQFz9h1KfLUVNJrXmpa/1prBwhsf7jX4O
 1XR/04Xw==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1la3uz-00Ej5F-7v
 for linux-nvme@lists.infradead.org; Fri, 23 Apr 2021 22:04:58 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2DCAD613AB;
 Fri, 23 Apr 2021 22:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1619215496;
 bh=5I7f25efOcuG4ieJvT0ovuYzdBDs8s7FIQEiKrfubsg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=uJb1BLuwgvbLCn3VOnhT8g24kS+Qsf2bpOjaVfgt2Z4Ff9xTWV1LjqeWo9kHkyXy8
 5YpmTsSdRXxVQsrcNweb9QwPQ6FOYLc1Xk+u7n9B3a0KWhSYdDahYp+5OQy8CUCfqH
 aCE82GpDMUc8GLw0mq2+elsaYvOwHD3TaFSkQZ5wEQLdZ59UIDFPGgmSf+bcsWOxSf
 dzaIaKc18vDEaOAcXBjAMDKRo4e1LdMEHXmtRgiBopCRszWsruJuv9l8fI6m1NOQcx
 0ORszVHhg+KqKm9yyU1XxncEuyzB91jGYdUO5dG1DhDrRixNiR8ngWqatwFrISXRrV
 p/sgGk22cnMGg==
Date: Fri, 23 Apr 2021 15:04:54 -0700
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
 axboe@kernel.dk, linux-block@vger.kernel.org
Cc: Yuanyuan Zhong <yzhong@purestorage.com>,
 Casey Chen <cachen@purestorage.com>
Subject: Re: [PATCH 1/2] block: return errors from blk_execute_rq()
Message-ID: <20210423220454.GA40699@dhcp-10-100-145-180.wdc.com>
References: <20210423215800.40648-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210423215800.40648-1-kbusch@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210423_150457_326615_BED954E8 
X-CRM114-Status: UNSURE (   4.24  )
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

Sorry, please disregard this series. This came from the directory of the
first version of this patch, but I intended to send the v2.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
