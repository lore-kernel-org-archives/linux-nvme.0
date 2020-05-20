Return-Path: <SRS0=LBLG=7C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7646C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2020 23:24:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F7342070A
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2020 23:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CeMDQr1d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F7342070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	From:Subject:To:Message-Id:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=igqGf2T1qdZ2gMpbVUw/btIPAEUfTLncJmG8lQASdpU=; b=CeMDQr1dbjgeuC
	1apNtnnfnKofo6H/iIljNTxb6n8l5jqbJfgPdPTz332Qm9SLBWql4odVlPnQ+++J6jCU1M+eQW/vH
	kR06n3592eYzenRplBhEGfUBEBXJXFTO7D4npd2/Qy26feEreTROLvd/Qzn8/zKz66H24Z5vwdKuG
	PfCC6CEwr3yak65FNvGoFKQxl05KZAXyhzoK9yceaii0uElRuwtnHcJ4aQ4k4Bk1KnqUsrHNwPaIw
	UCOWIKzf8aAFmOvUilDB89x+/jHd+AdmpNmAJES1u9wmuvIMkZKxoIM5at2/SZMob1iAdIUVhZCoo
	jHrYf5wK5puYnR3nSvDQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jbY4K-0005t3-3E; Wed, 20 May 2020 23:24:12 +0000
Received: from shards.monkeyblade.net ([2620:137:e000::1:9])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jbY4G-0005qU-UX; Wed, 20 May 2020 23:24:10 +0000
Received: from localhost (unknown [IPv6:2601:601:9f00:477:9e51:a893:b0fe:602a])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: davem-davemloft)
 by shards.monkeyblade.net (Postfix) with ESMTPSA id 9CDFF12728305;
 Wed, 20 May 2020 16:23:58 -0700 (PDT)
Date: Wed, 20 May 2020 16:23:55 -0700 (PDT)
Message-Id: <20200520.162355.2212209708127373208.davem@davemloft.net>
To: marcelo.leitner@gmail.com
Subject: Re: [PATCH 31/33] sctp: add sctp_sock_set_nodelay
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200520231001.GU2491@localhost.localdomain>
References: <20200520195509.2215098-1-hch@lst.de>
 <20200520195509.2215098-32-hch@lst.de>
 <20200520231001.GU2491@localhost.localdomain>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12
 (shards.monkeyblade.net [149.20.54.216]);
 Wed, 20 May 2020 16:23:59 -0700 (PDT)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200520_162408_984271_7DAC9FE7 
X-CRM114-Status: UNSURE (   5.42  )
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
Cc: edumazet@google.com, linux-nvme@lists.infradead.org,
 linux-sctp@vger.kernel.org, target-devel@vger.kernel.org,
 linux-afs@lists.infradead.org, drbd-dev@lists.linbit.com,
 linux-cifs@vger.kernel.org, rds-devel@oss.oracle.com,
 linux-rdma@vger.kernel.org, hch@lst.de, cluster-devel@redhat.com,
 kuznet@ms2.inr.ac.ru, kuba@kernel.org, ceph-devel@vger.kernel.org,
 linux-nfs@vger.kernel.org, nhorman@tuxdriver.com, yoshfuji@linux-ipv6.org,
 netdev@vger.kernel.org, vyasevich@gmail.com, linux-kernel@vger.kernel.org,
 jmaloy@redhat.com, ying.xue@windriver.com, ocfs2-devel@oss.oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Date: Wed, 20 May 2020 20:10:01 -0300

> The duplication with sctp_setsockopt_nodelay() is quite silly/bad.
> Also, why have the 'true' hardcoded? It's what dlm uses, yes, but the
> API could be a bit more complete than that.

The APIs are being designed based upon what in-tree users actually
make use of.  We can expand things later if necessary.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
