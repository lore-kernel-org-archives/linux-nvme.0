Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 962A5C4332F
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Dec 2023 16:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Etk5vLpARTZCtDjnSWMsQz05k8rTR1Ts7JusCc7oUXI=; b=O1KORkOKuSRj4iC2vMqON+QODa
	Odf+zxlCOOHi0QKg0cPVrssXNsB2QPWadY6F9kZvXY/gV0zhX2KuRWuqh6rZ2MBLlZx60hAR4c1HM
	JRnliiN+9qCzEmUMBr4vtnPDlV3juU/OQzTAteuRvzWCkv26jG6WPw0WyWagohJjNJGgGsSVpF+Aq
	f1atjcXUptk00UFcm8XfwHXsfCm0zM5btlJK69rupMA9BqRkMeNvO7ORBSeH4jrccvIftf/vNb2SB
	t+D4wWrrysxI8RzuogGwlvuM4rlmnWIS5imHbGRG9MmQD2XbhKAI2lvlNviJh8iUiJoskl72H8rm2
	2mZXTeLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rEBX6-003xD7-05;
	Fri, 15 Dec 2023 16:59:28 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rEBX3-003xCN-1y
	for linux-nvme@lists.infradead.org;
	Fri, 15 Dec 2023 16:59:26 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3C96468B05; Fri, 15 Dec 2023 17:59:21 +0100 (CET)
Date: Fri, 15 Dec 2023 17:59:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: hare@kernel.org
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCHv2] nvmet: implement unique discovery NQN
Message-ID: <20231215165920.GA3642@lst.de>
References: <20231215123929.172940-1-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215123929.172940-1-hare@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231215_085925_793091_CBCC4B09 
X-CRM114-Status: GOOD (  11.52  )
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

On Fri, Dec 15, 2023 at 01:39:29PM +0100, hare@kernel.org wrote:
> From: Hannes Reinecke <hare@suse.de>
> 
> Add a configfs attribute 'discovery_nqn' in the 'nvmet' configfs
> directory to specify the unique discovery NQN.

That's a bit of a sparse commit log.  What do  unique discovery NQN do?
Please include a reference and a bit of an explnation.  And tell us
why this feature is useful for Linux to have.


