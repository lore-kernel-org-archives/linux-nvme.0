Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18BC8C83030
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jul 2025 05:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CYIHXyKkYCi/d8k0OaCZeCnCFZ7UpUIFVSIhHq6JV3M=; b=w7sy39qQ8eN7oPvOVgnNdWJGZE
	S3shQ9viLs1A38GGZG3zV0JelN2/QKNS+eVVZ8QvKBAZCyfR6b8baMlWIeHNnxKLQ5ohNMXGLJmjp
	idLu1b35dBS+7/+HRKiKIgohMDKiKBC2QX3qty3vaNdFkidr2I77RdRHDf5YaLUseVRlhpj/iBINu
	DXzrW4Ej1/LPIf4wMztDErz2urvdwK36wCEaHdivAdcX8HaIfOnYg4bPvrXfXYxw68XzryVsl8Fjv
	KS8vRu6lhtMcKtH0lsmXr/zmm5BfxHqGtv5fSmglUEZ1HCCJUn6g4vOo/l0eLbEHAYA9mBlXLg4Ef
	d/so2teg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYeZG-00000001SI1-1IEn;
	Mon, 07 Jul 2025 05:39:06 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYeYG-00000001SFH-3Zfc
	for linux-nvme@lists.infradead.org;
	Mon, 07 Jul 2025 05:38:06 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6E406227A87; Mon,  7 Jul 2025 07:37:50 +0200 (CEST)
Date: Mon, 7 Jul 2025 07:37:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Yi Zhang <yi.zhang@redhat.com>, Christoph Hellwig <hch@lst.de>,
	alan.adamson@oracle.com, linux-block <linux-block@vger.kernel.org>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
	John Garry <john.g.garry@oracle.com>,
	Maurizio Lombardi <mlombard@redhat.com>
Subject: Re: [bug report] nvme4: inconsistent AWUPF, controller not added
 (0/7).
Message-ID: <20250707053749.GA28625@lst.de>
References: <CAHj4cs_Ckhz4sL5k5ug_Dc5XfjSo9QDRSrHMfBj2XYGm_gb2+g@mail.gmail.com> <6e74e9a8-2dbb-4ad4-a48b-9af40d6af711@oracle.com> <20250703080359.GA365@lst.de> <CAHj4cs_pJDR-VH7-RzGwt9KmNCdTnQ38bejeB72280e9ke8ebg@mail.gmail.com> <aGc5wlj0Vgk6Mf6d@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGc5wlj0Vgk6Mf6d@fedora>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250706_223805_032826_D3AFED1C 
X-CRM114-Status: GOOD (  11.14  )
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

On Fri, Jul 04, 2025 at 10:17:38AM +0800, Ming Lei wrote:
> Per NVMe spec, AWUPF unit is 'logical blocks', and logical block size is changed
> by 'nvme format', so AWUPF value retuned from `Identify command` can be changed
> because the controller implements fixed-length atomic write size(512*8, 4096 * 1)?
> 

Yes.  And that's an issue because NVMe doesn't have a controller-level
concept of a logical bloc ksize, the logical block size is per-namespace.

Or in other words, AWUPF is a mess.


