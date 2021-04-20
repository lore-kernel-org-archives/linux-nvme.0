Return-Path: <SRS0=/SuC=JR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C049AC433B4
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Apr 2021 09:55:04 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20925601FF
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Apr 2021 09:55:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20925601FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=SGSfewySZPRmhQuOqZpAJxy2I32DahsOaCFr0EmLJrU=; b=GZ/f2xsdglzZOG/HLWYBRVhNr
	gcBeFaQlnO/LcwymX4EfGe32rp1s5PjzsPwzvHB799ROpEpPDc3Q++cG9uN98EhxWh6zN9XoZYJ5F
	KBaaZpCmwAC3fvSfO65ZfZ8bv2cKeN0Q04QmT4ZYcsK9Ce/NR//bgfsMm1CelT5xuCRKvHA4zb7wS
	XX5IhbKu9umaawIAjgQh7RAqg4jkIRVdnYpwNbHYLJpAQw2Sm2t9Z7YxvPvmeQwQkwbdmapN0Y2QL
	URTNFiQz/airPrvN2W7hiG0hMc4GRMuMoflBL22sN7ZMJH1H6BT3vbIS2ME7BGvhWTX0LasIMqIfA
	PEVQlYRJg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lYn5c-00Bp3i-HP; Tue, 20 Apr 2021 09:54:40 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYn5Z-00Bp3N-U2
 for linux-nvme@desiato.infradead.org; Tue, 20 Apr 2021 09:54:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=YwZUoSM9et2bM2RxK/3sxasxYau43XvSgEtQnzYpIek=; b=kvL7fX8ofzKjv6wEqnhxb1Rdsy
 UJnUt6lVhOi7ssh1H9iBMbA1wupEmbl7u8SjTq+J7VtGNZcEcXXeKtAdJAFHiqIOaMqUMhyFqzh+/
 6kTZdoFO7/W8in9GuNhSHuPgbZmpnk2i3D4L/kGo3NzDoiRbKwldECaSDDY8EADYA7402kEdKzOM0
 d1LV1zo8z9j7SD8JvZICNhuoGMPSGe5AFtzhc9K3zIqaxy+rUoa87cKA101YRTAohBuCdy9rfvIxs
 B3FStDVAJYXWIuoZ/Fn/nNdGp2sgFW9ajYb7MlzmP28dFhJe1ZklCbTTa2HQAUpIv4RS0vfa3JfYT
 Qx82OlZA==;
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYn5X-00C0D9-G4
 for linux-nvme@lists.infradead.org; Tue, 20 Apr 2021 09:54:36 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id BC6FB68C4E; Tue, 20 Apr 2021 11:54:32 +0200 (CEST)
Date: Tue, 20 Apr 2021 11:54:32 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>, Daniel Wagner <daniel.wagner@suse.de>
Subject: Re: [PATCHv2] nvme-mpath: delete disk after last connection
Message-ID: <20210420095432.GA30142@lst.de>
References: <20210420080527.GA21651@lst.de>
 <91f25f95-e5a0-466f-b410-6f6dafdec0a0@email.android.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <91f25f95-e5a0-466f-b410-6f6dafdec0a0@email.android.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210420_025435_696853_40E16FC4 
X-CRM114-Status: UNSURE (   9.45  )
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

On Tue, Apr 20, 2021 at 11:41:23AM +0200, Hannes Reinecke wrote:
> <div dir='auto'><div dir="auto"><div dir="auto"><br></div><div><br><div class="elided-text">Am 20.04.2021 10:05 schrieb Christoph Hellwig &lt;hch@lst.de&gt;:<br type="attribution"><blockquote style="margin:0 0 0 0.8ex;border-left:1px #ccc solid;padding-left:1ex"><p dir="ltr">On Fri, Apr 16, 2021 at 08:24:11AM +0200, Hannes Reinecke wrote:

I'm unable to read this garbage unfortunately.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
