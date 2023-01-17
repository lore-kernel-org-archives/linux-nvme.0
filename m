Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B33C3DA78
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Jan 2023 10:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wCu5FEtvuGKKNR0zZnH8joxxvrfQkJX96/+lONkCrHk=; b=CKCrWO1daFZhd39DmDJaxE7lN8
	r23NA1uQAm8E4SggXGxoWNn/OBXd9s+s48DbbUmXpl4FeB7l0FV88tmUcMmCK9GaT/hUf3NFiQJoj
	Nq+rSoVu23GYYk47u1vF1EDrLjhGnc5aXh4lw81+C5pdQ4+3jiqhWn9ma4QmNKt8kx93a+NO+fUPP
	tjhiji7D62aIpCrD/8AvbmxELChbyqIl+7p9VBC6fOYzu6ufnM4mpmTZeNLM7yV7xYdwupP3/S2dW
	2bH4158ywrw8fs5xegftsUnnlXFiiAzw+M1MqkbjpHl6XXfQwqMgalEm8+ux9dOI+rpdEihlOlerb
	dIG0pMCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHjZM-00DrC9-3Y; Tue, 17 Jan 2023 10:51:56 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHjZK-00DrBj-BQ; Tue, 17 Jan 2023 10:51:54 +0000
Date: Tue, 17 Jan 2023 02:51:54 -0800
From: Christoph Hellwig <hch@infradead.org>
To: "Belanger, Martin" <Martin.Belanger@dell.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>,
	"smith, erik" <Erik.Smith@dell.com>,
	"Ghalam, Joe" <Joe.Ghalam@dell.com>,
	"Hayes, Stuart" <Stuart.Hayes@dell.com>,
	"White, Joseph L" <Joseph.L.White@dell.com>,
	"Glimcher, Boris" <Boris.Glimcher@dell.com>
Subject: Re: nvme-fabrics: devices are uninterruptable
Message-ID: <Y8Z9ypvhwFYUnqkp@infradead.org>
References: <BLAPR19MB453154491C6DE9CB7C2A310BF2FC9@BLAPR19MB4531.namprd19.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BLAPR19MB453154491C6DE9CB7C2A310BF2FC9@BLAPR19MB4531.namprd19.prod.outlook.com>
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

On Wed, Jan 11, 2023 at 02:37:58PM +0000, Belanger, Martin wrote:
> POSIX.1 specifies that certain functions such as read() or write() can act as cancellation points.

device special files are mostly out of scope for the normal Posix
rules..

> I wanted to ask the community if there is a reason for the nvme driver to not support POSIX cancellation points? I also wanted to know whether it would be possible to add support for it? Is there a downside to doing so? 

How do you propose to allow for safe interruption?

