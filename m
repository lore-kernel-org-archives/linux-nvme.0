Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93AD1C00140
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Aug 2022 14:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=puqrfHZ3bJIga19iI0zbS18WIA5/W+W0T+Ht64clAu8=; b=HxLsPuV3VIZboHlQYCysbwONcg
	jhF3T/sStbB153Vc49x/HXVHJqPyODgqihIFNM58xwFhnl8e34ZxOfcT8nIw+CkJW5y12gs5vloYs
	JkWjoMI/RQUsAJh6k/+ehcZ3eY3Oovk70nAR7FHRJX87r+Zz2QgF8swdwQrx+Pw31Bc47UCuxZ4RV
	xJz9DubP82at7GRkslZcORHUiqc1vIAnem0dh5kWgj0O8mvkG8q0wRtFjyvvxQ/I+zqSLl2MsbAlN
	Z2tXPhxAooEeP6k4xSr8dmXGht5nS1Q6tDEd96kdCshql2hL+t+81RdnmMhIcnW0ofEtcKF2AoxUW
	+YoG7g0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLmbq-00CGwx-8D; Wed, 10 Aug 2022 14:22:58 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLmbn-00CGvr-2G
	for linux-nvme@lists.infradead.org; Wed, 10 Aug 2022 14:22:56 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0BCD468AA6; Wed, 10 Aug 2022 16:22:51 +0200 (CEST)
Date: Wed, 10 Aug 2022 16:22:50 +0200
From: Christoph Hellwig <hch@lst.de>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org, hch@lst.de,
	kbusch@kernel.org
Subject: Re: [PATCH] nvme-host tcp: check if the queue is allocated before
 stopping it
Message-ID: <20220810142250.GA25801@lst.de>
References: <20220801080900.391575-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801080900.391575-1-mlombard@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220810_072255_268522_05511FEF 
X-CRM114-Status: UNSURE (   7.74  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thanks,

applied to nvme-6.0 with the fixed up subject.

