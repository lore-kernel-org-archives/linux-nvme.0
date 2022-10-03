Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBBD3C433FE
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Oct 2022 06:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5Yfvpj3irbzzIGak5LtEwb8E/Hr2f7IjmaFpcQg0/o4=; b=g/UHvggrFJLhKz5DBbXEVpUv5l
	LnU5qcIGqgYSz8ANkpW1CFDINtLM8pEDfVsYmheF8+TdHg7JAFBMO8R79d8Yn0kUlqSwJqccgThgn
	2zTVsxXvQTuMrybJuQhWgaq0ZB1qoE8Ns7t/7uzTPtB/llqxRrmXaVww/atIgg1aoIe7iIWGb3mKY
	8I1aIDmu7q3c3qr0QVncgyez7TDrmRp+J/Fjtv+ykbcrNLFwDm8UVvniQuEeniS0BecKK0agQwv9A
	sxhBNDSYQz/adHelITh+d0UC0tz1OePsM0njzfTlJ4DNlHts68rdhwM+Vjwr46yQVP9Ixsh9df1Wk
	qWzQVp9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ofEsl-004CXr-U4; Mon, 03 Oct 2022 06:24:51 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ofEsj-004CXR-O8; Mon, 03 Oct 2022 06:24:49 +0000
Date: Sun, 2 Oct 2022 23:24:49 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Gilles BULOZ <gilles.buloz@kontron.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: NVMe write protection support
Message-ID: <YzqAMcFwXysfS0Le@infradead.org>
References: <DU0PR10MB62528F66099C2311E2AF1EEE809A9@DU0PR10MB6252.EURPRD10.PROD.OUTLOOK.COM>
 <YugctzU0uDZvfAal@infradead.org>
 <DU0PR10MB62528A77489B4ADE66503166809D9@DU0PR10MB6252.EURPRD10.PROD.OUTLOOK.COM>
 <Yu4nt1bzSynhmeUF@infradead.org>
 <DU0PR10MB6252E237D18FCFB37CB17B8F80729@DU0PR10MB6252.EURPRD10.PROD.OUTLOOK.COM>
 <6a50bd55-e8be-283d-1e57-731958bd1820@linux.dev>
 <d92eae14-8ae7-a142-fb6b-26cc40791741@linux.dev>
 <e49c0b48-cf93-9247-6362-c3f2efd40ee0@kontron.com>
 <YyiDufvEa+dEtziJ@infradead.org>
 <9ae13173-44ec-707f-46f0-edbe3c35e0cb@kontron.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ae13173-44ec-707f-46f0-edbe3c35e0cb@kontron.com>
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

On Fri, Sep 30, 2022 at 07:49:38PM +0200, Gilles BULOZ wrote:
> Hi Christoph,
> Our disk manufacturer told me their NVMe does not follow NVMe specification 2.0 but 1.3.
> Is there also something in 1.3 to handle the write protection cleanly ?

NVMe 1.3 has not write protection feature.  That being NVMe is designed
so that new functionality (new TPs in NVMe terms) can be implemented by
devices that comply to older versions.  So if you just set the bit as
described earlier Linux (and other drivers that know about the feature)
will still do the right thing even if the compliance level is left as
NVM 1.3.

