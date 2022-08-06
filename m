Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B306C25B06
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Aug 2022 08:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BEUfRzIoKIx0c0BN5Z5CmPkYl3e0Vb4l3CNHTKDA8IA=; b=c0s70p/WjPMJn5C1HoxOSjtOeB
	phcf5CYQGNtHCAx9tf51rzYnL4jfu1WnK7+HGKVJ1VterT+OcpxicqqeHhLuCES0QJhUJJGTTB7n8
	72SUxKEtO5aoY9ukW0kU/xQru9bVsg8PJMwYkHu3IWC0lWM/t+QH2Xb4d5Bd9PDSDw8hyzadlVPRQ
	RV4kq/65xWO0hcZPQMuc3kQqS29MU6ADfUrmg62pTnxbm0u/L2bl7/Q5+XmfOIZ0aF3eRshMup0bp
	iocXdz8tFHYId4r+Fcm1KtXtI5D7DRcY6Xw1mXb7CObEqFbEuDrFftLDRZI9/o5FZQ6D1tjxx0yN9
	Z/L7faXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oKFGy-006ZKx-UE; Sat, 06 Aug 2022 08:35:04 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oKFGx-006ZJx-AI; Sat, 06 Aug 2022 08:35:03 +0000
Date: Sat, 6 Aug 2022 01:35:03 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Gilles Buloz <Gilles.Buloz@kontron.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: NVMe write protection support
Message-ID: <Yu4nt1bzSynhmeUF@infradead.org>
References: <DU0PR10MB62528F66099C2311E2AF1EEE809A9@DU0PR10MB6252.EURPRD10.PROD.OUTLOOK.COM>
 <YugctzU0uDZvfAal@infradead.org>
 <DU0PR10MB62528A77489B4ADE66503166809D9@DU0PR10MB6252.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR10MB62528A77489B4ADE66503166809D9@DU0PR10MB6252.EURPRD10.PROD.OUTLOOK.COM>
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

On Tue, Aug 02, 2022 at 09:20:02AM +0000, Gilles Buloz wrote:
> Sorry Christoph, I'm completely newbie in NVMe and don't know what "Namespace Write Protection Config" means.

Take a look at
https://nvmexpress.org/wp-content/uploads/NVM-Express-Base-Specification-2.0b-2021.12.18-Ratified.pdf
and search for this term.

> What I mean is that all the NVMe content seen by the user is write protected.

And that is what this feature is abut.

> Our NVMe manufacturer partner has dedicated a pin of the module for global write protection.

There is no concept of a 'module' in NVMe.

> But if we enable this protection and attempt a write (we should not), we get a "critical medium error" which seems a bit brutal for a disk that is still valid but just write protected. So I would like to make sure the NVMe manufacturer has used the right method/status to report this write protection, and if possible get a less fatal error feedback.

It seems like your manufacturer needs to read the NVMe spec and
implement the correct features.

