Return-Path: <SRS0=cJ6X=ZA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BEADFA372C
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Nov 2019 10:42:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 289272178F
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Nov 2019 10:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LsqczLkY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 289272178F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=io3FMlRgFCXTKLEoGH9k5MuhBT5poFgHFJuRI41aUhU=; b=LsqczLkYDnM8uO
	uV+oiNIj4L8wXlDFA9bOuSbaA8SnZ1nQeNYvamjOF94n/jFkq3k7Q4VJz+VEiHp2nytJVQNiAOTpD
	AQffUw0jHWdEj+QURmeVJfSHgD4FsKxb6490GZndJa+EVhx774jrNzKH2gioeKxJ3+7bi4JqjUryk
	Q2rC3UQrCxO3Vi/aKQ62isJ5l2u3vPEkfeN0YPROoOpJ4daiQmTupIRJUJEZHmcodnd+Q3hV9b582
	GYbK3OeYhaH29MSyucDCl8Q2B9pO7xjpM1Ag4pt7g6VEVhHIbKoxrcVYj8SIabbN4hi+f7+DBTnOT
	ucq+nxkbiKmQM3mq9iQw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iT1ia-0006Q5-9d; Fri, 08 Nov 2019 10:42:16 +0000
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iT1iX-0006PR-GA
 for linux-nvme@lists.infradead.org; Fri, 08 Nov 2019 10:42:15 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 2C1A6AE24;
 Fri,  8 Nov 2019 10:42:09 +0000 (UTC)
Date: Fri, 8 Nov 2019 11:42:07 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH] nvmet: Always remove processed AER elements from list
Message-ID: <20191108104207.7paup72lz2ipqynf@beryllium.lan>
References: <20191103201310.24785-1-chaitanya.kulkarni@wdc.com>
 <20191104081338.gdrk2a4mlov2io6s@beryllium.lan>
 <20191104095034.GA3193@linux-lxv2>
 <20191104101935.lzdhraz5wnd56g4r@beryllium.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191104101935.lzdhraz5wnd56g4r@beryllium.lan>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191108_024213_684938_E440BB46 
X-CRM114-Status: UNSURE (   7.20  )
X-CRM114-Notice: Please train this message.
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
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, hch@lst.de,
 linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Nov 04, 2019 at 11:19:35AM +0100, Daniel Wagner wrote:
>   Run perf to write data to tgt1 and tgt2 for a long time , command:
>     sudo ./perf -q 1 -w read -o 4096 -t 600000 -r 'trtype:RDMA adrfam:IPv4 traddr:192.168.219.4 trsvcid:4420'
>     sudo ./perf -q 1 -w read -o 4096 -t 600000 -r 'trtype:RDMA adrfam:IPv4 traddr:192.168.219.4 trsvcid:4421'

This tool is from the SPDK project:

https://github.com/spdk/spdk/tree/master/examples/nvme/perf


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
