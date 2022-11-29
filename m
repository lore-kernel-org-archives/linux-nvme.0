Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36825C4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Nov 2022 08:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=82mYdcpdrhXJxAPIiQq8RXg4Du8I+ct5SS1d07SZgVM=; b=mRj2ElJffrA4E0tAfUPVTNWCR0
	8cVe6Ce5WpO6fLiWsNdtOEjtLYf5F/ZetDnYxtH0Wyv79MKkkygXFlDqxLnyPSso0KZPjQPRt6BYm
	/MezC8/aDSTXy29SYNsFrua6cMUbuLeJQFshl6A1C7nETJ54wRRMdkNR8Z9yV3HLzWI8haPaYVA7w
	5Wa/TCugj6ML4z3xQhbecVUbwDUaU76Ic5lvk79bZEzRqbdhj04z8SRpSuiOwM+0WhBwl8WhNawlR
	prUm4pmE/eZxGlhDFRzmckuHb0jmNqPqVMF3HDgXno71Bjit/orFnEwMbdHGzwmT3dFGV/77aAj/7
	CjivzQmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ozwGd-007VLp-RU; Tue, 29 Nov 2022 08:47:03 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ozwGZ-007VHa-Gf
	for linux-nvme@lists.infradead.org; Tue, 29 Nov 2022 08:47:01 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id D2E4C68AFE; Tue, 29 Nov 2022 09:46:55 +0100 (CET)
Date: Tue, 29 Nov 2022 09:46:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH] nvme-pci: Netac has bogus namespace ids
Message-ID: <20221129084655.GA26082@lst.de>
References: <20221122112428.1573353-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221122112428.1573353-1-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221129_004659_755170_4E3562A9 
X-CRM114-Status: GOOD (  10.49  )
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

This seems to be the same device we just quirked with
"nvme-pci: add NVME_QUIRK_BOGUS_NID for Netac NV7000"

