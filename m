Return-Path: <SRS0=k+Rq=MI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD711C12002
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Jul 2021 07:25:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89103613DA
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Jul 2021 07:25:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89103613DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iuktLIzarvHjEJlKtxuBEUVUXP0f2R+/dgHk/7kC0YA=; b=IzPheTwnR/ljlh
	KCiViCjTi8iChqFXcNRAG20TfP8URdLXtwQb5CSNqbgJUX32NClzTPsIJJi/PCP/kFG0FWzgBUnWV
	AkeNWoXwgY/Jyan1AvklbpMfRpxdeEsTcxafC6pRB/AgJaIiCh9KNg/qxy/s/8SFTYePbvnrBO2eR
	3Y9vvVRyWJgUa6kRaIDmN+2yif9nYLplRB92YD+mj4v8zN7fEtIezuty+glaaC0Bya46QktCWnORa
	E3SpJIjt9pGNeFOZyDwaDpwLsRHrqxNVrz4JD5vP+4mwfJhrQuELhJ7eIMN8ZltdRvGFk0/w5kcX1
	gMQpdG1u1wwsdlLWIy1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m4IE3-003VyK-R0; Fri, 16 Jul 2021 07:25:35 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m4IE1-003Vxi-A6
 for linux-nvme@lists.infradead.org; Fri, 16 Jul 2021 07:25:34 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 97FA267373; Fri, 16 Jul 2021 09:25:30 +0200 (CEST)
Date: Fri, 16 Jul 2021 09:25:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hou Pu <houpu.main@gmail.com>
Cc: sagi@grimberg.me, hch@lst.de, chaitanya.kulkarni@wdc.com,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-fabrics: remove superfluous nvmf_host_put in
 nvmf_parse_options
Message-ID: <20210716072530.GA14605@lst.de>
References: <20210709023247.69287-1-houpu.main@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210709023247.69287-1-houpu.main@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210716_002533_533049_262CB695 
X-CRM114-Status: UNSURE (   8.06  )
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

Thanks,

applied to nvme-5.15.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
