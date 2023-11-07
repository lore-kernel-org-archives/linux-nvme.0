Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61679C4332F
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Nov 2023 08:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1u87Op1Avjfzk4F3A5PES4CvYVv+HZ+af/U/BgOTjHc=; b=OTB8YzJHGquYdx8GMsoUW69g55
	5tPzVM4A2QfHc+NPSStqJthK7QdmibpSLQzVh4qlHOrimIwJfmNq80VrUmZ3SKdX5UP1MhgTqNP/k
	NLqbdYFs3N+GUSy+8Z7FhFDGg6vTZqg+r06YH2aICao3bAcJFCr+uKJpMwqeOYApNqrv5jvXkWd2y
	lqwV2pFxtxlHVmR3Ho1gxTT2Td6NknzMp9B9KPRueLDfgiW7UknVLUm/kSXZhqtfuF5yZSB4VWB58
	cu7u+21rwP2wVn0oH1qAOiHItzarLnDaN1u6ne4vnMgfiu58Bx4s07aSdjHZa/XeuGkJboOkurMPr
	4yWt5DkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r0HtE-000rom-0C;
	Tue, 07 Nov 2023 08:56:52 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r0HtC-000roV-0P;
	Tue, 07 Nov 2023 08:56:50 +0000
Date: Tue, 7 Nov 2023 00:56:50 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Wen Xiong <wenxiong@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, Wenxiong <wenxiong@us.ibm.com>
Subject: Re: Saw I/O errors while delete/create/attach a namespace on nvme
 device.
Message-ID: <ZUn70pL+YV0adqd0@infradead.org>
References: <ee222a8c6574d754d7e6355591e1a06a@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee222a8c6574d754d7e6355591e1a06a@linux.ibm.com>
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

On Mon, Nov 06, 2023 at 10:10:33PM -0600, Wen Xiong wrote:
> Hi All,
> 
> I am working on new nvme device and found this: nguid is changed while
> delete/create/attach a namespace, we saw some error messages in linux log.
> 
> Should we see these errors messages since recreating namespaces or are there
> some issues in error path?

What exactly are you doing?  To the Linux host code this looks like the
NGUID changed for an existing namespace.  Are you deleting and
recreating nsid1 rapidly and the controller is assigning a different
nguid?


