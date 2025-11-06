Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49FFFCCFA05
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Nov 2025 13:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9An2GtS4jepstOAp9/ykXzh+eyX/bl5vuGDgUcajRJc=; b=pfUnqfgx2A7axAt4rkhBsQVOXD
	vqbqiQG8hoPcF2uKR+3yVCiDjrkT+xixTWPaYy4d2+IvZYWXjLm3sNnhV6fMTXbyBEh/JO37qWJvv
	G0naY2q9i5jBRkc1oKx8M/tYNpm1DWxFLVAnMD/7rzFFJzmp08uCaHjuMzAjHb90dNrYqzQdmRL+2
	GIOC+gg+YngJYm1mr4VRLvKGO1hBfQVRwEf8LC+lh0zxjBIzkoZGlGTqoqWIoVVU23qCQ/3+22h2h
	MXDuBA0+mSHG+N1XrZBABI9ir22lbzAbycARXbwEzoBh14FN+/FIimmyzkYhfhM2Wvji4btbK3G9g
	5NPh14XA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGzk5-0000000FXwT-08IB;
	Thu, 06 Nov 2025 13:09:33 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGzk3-0000000FXvQ-2YR0
	for linux-nvme@lists.infradead.org;
	Thu, 06 Nov 2025 13:09:32 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8B5B3227A87; Thu,  6 Nov 2025 14:09:25 +0100 (CET)
Date: Thu, 6 Nov 2025 14:09:24 +0100
From: Christoph Hellwig <hch@lst.de>
To: Martin George <martinus.gpy@gmail.com>
Cc: alistair23@gmail.com, hare@suse.de, kbusch@kernel.org, axboe@kernel.dk,
	hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v2] nvmet-auth: update sc_c in target host hash
 calculation
Message-ID: <20251106130924.GA7528@lst.de>
References: <20251104231414.1150771-1-alistair.francis@wdc.com> <adba53a05329dc8399c3bd49c7bcd5eff5e69574.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <adba53a05329dc8399c3bd49c7bcd5eff5e69574.camel@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251106_050931_788374_0E40BF1F 
X-CRM114-Status: GOOD (  11.92  )
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

On Thu, Nov 06, 2025 at 06:35:48PM +0530, Martin George wrote:
> >  	req->sq->dhchap_tid = le16_to_cpu(data->t_id);
> > +	req->sq->sc_c = le16_to_cpu(data->sc_c);
> 
> Given sc_c is an unsigned 8bit int, is there really a need to make this
> endian safe by calling le16_to_cpu()?

... calling le16_to_cpu on a u8 actually messed up the endianess (on
big endian systems anyway).  Everyone please run sparse on your
submissions to catch this.


