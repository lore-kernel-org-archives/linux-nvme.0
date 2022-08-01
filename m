Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC5FEC00144
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Aug 2022 18:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Rt/HaZMtrRDWowUOuoH76MAO1yQw2CcNdbbiE7T7254=; b=MZI24bFQGiRxTvZnh2ZX989fd4
	6SlUTumi3lOcyF4hhaOJxQmfOTbdDjeVTVN+Lj81t65bf3IkO6Xf9noBNxBUVr9h0awPWy+02TJI9
	9HjCdPFPG3zWZ5wAsFhQlzlI4nZGTxCa8d+iAGac9G0S4g4mWY31CFs8sCM11XsMzHiUkVpuduLep
	3cUFbX5zkSoq/jFDSLS0OoCHf4V9DIOYYXwqgFA+XAo/YOKtq0mLV95wm2yaPLwDShO+2vWUVDseu
	N8yvpsZXFvgqUPmWyIakoFPgR+h2BABOKOkbH2HI3QMOrRTMS+su0H0kcy3hy22qnk9imRRuo54Qw
	ZTrC3Cqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIaGl-0094DT-8K; Mon, 01 Aug 2022 18:35:59 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIaGk-0094Bv-54; Mon, 01 Aug 2022 18:35:58 +0000
Date: Mon, 1 Aug 2022 11:35:58 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Engel, Amit" <Amit.Engel@dell.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: Re: parse nvme connect Linux error codes properly
Message-ID: <YugdDtiK59xT4K90@infradead.org>
References: <CO1PR19MB488539073167D496A9A7D991EE9A9@CO1PR19MB4885.namprd19.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO1PR19MB488539073167D496A9A7D991EE9A9@CO1PR19MB4885.namprd19.prod.outlook.com>
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

On Mon, Aug 01, 2022 at 04:20:44PM +0000, Engel, Amit wrote:
> I can provide a simple fix for your review if you have no comments to the above analysis 

Yes, please send the fix.

