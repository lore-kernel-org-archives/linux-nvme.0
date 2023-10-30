Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76A08C4167B
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Oct 2023 15:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pRSRixE2mgVa7EvEDqaaDxfv9jGRdAqZmDs0EgL3tJ0=; b=yj0C8A9unRfNDG8hhyOfHQX2Xx
	ey1K1tHiyU3AeeavGDnUGGOpeJBg9ZAvD7pofWv8uy4Pf5s2/pdY03M8bTxYDVLIapmk542uK1Fli
	NFkXdBCqELwBm7WP+laTtfX+MJ8KnCUW0+Pd+oeZGgd7Xjjrkm2rPuesNSvobGJwbJtLFH8qQ2AFf
	OQplEH8pWRMku/BDnxI6durz6w6lhRFXv60o2EPDwCWDe7AhK5vPVK10yh7a7UKmxz7AV1BGPJTHM
	dojgw0eoj9IshB5EuVt3FEbUr3T5rAs/qDBgtXrsKuXdJSzvvEYa2tiXK1HKvS+g07fiSef4lAAx2
	N+HEReRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qxTpx-003XMu-0B;
	Mon, 30 Oct 2023 15:05:53 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qxTpu-003XM6-02
	for linux-nvme@lists.infradead.org;
	Mon, 30 Oct 2023 15:05:51 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 314C9218D6;
	Mon, 30 Oct 2023 15:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1698678346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pRSRixE2mgVa7EvEDqaaDxfv9jGRdAqZmDs0EgL3tJ0=;
	b=DBG6F9BWLVvk/qnBjGmeeh4L/T31SoFVPzcLORdktl2gR3VdOuH70WJkQImKtuu3+WvAip
	ZrcabA/a7gFpz4n9Y/aLcjal20VYAEnBkXnY5r2N2V13Ru9RPgG6xOhghILuZMaI5qGdbk
	efFTa+0H9zXRkAtvYBCB7EgUdBlGBqs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1698678346;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pRSRixE2mgVa7EvEDqaaDxfv9jGRdAqZmDs0EgL3tJ0=;
	b=E8m9QPC1QxJVZvTMOoRu1BnzSKrZ/n3y2iFSoVnyWXVWle9Dx6kyqsGEzdmQjK8IO1L8I6
	asrlzLntKGUtSkCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 171D6138EF;
	Mon, 30 Oct 2023 15:05:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id f+eYBUrGP2XCWgAAMHmgww
	(envelope-from <dwagner@suse.de>); Mon, 30 Oct 2023 15:05:46 +0000
Date: Mon, 30 Oct 2023 16:07:21 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Cc: Keith Busch <kbusch@kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Christoph Hellwig <hch@lst.de>, Kenji Tomonaga <tkenbo@gmail.com>
Subject: Re: [PATCH v2] nvme: update firmware version after commit
Message-ID: <ed23l2ustamwrhseseuilvunwnenpuaaeduvcmfpk4up2nstpq@rtvf7emq3erl>
References: <20231013163420.3097-1-dwagner@suse.de>
 <ZSlzxGx8k9pgkhDk@kbusch-mbp>
 <ZSmqi7Va4CkpQ4zl@x1-carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSmqi7Va4CkpQ4zl@x1-carbon>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231030_080550_190078_B4F7C4CE 
X-CRM114-Status: GOOD (  13.05  )
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

On Fri, Oct 13, 2023 at 08:37:32PM +0000, Niklas Cassel wrote:
> On Fri, Oct 13, 2023 at 10:43:48AM -0600, Keith Busch wrote:
> > On Fri, Oct 13, 2023 at 06:34:20PM +0200, Daniel Wagner wrote:
> > >  	if (nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_FW_SLOT, 0, NVME_CSI_NVM,
> > > -			log, sizeof(*log), 0))
> > > +			 log, sizeof(*log), 0)) {
> > >  		dev_warn(ctrl->device, "Get FW SLOT INFO log error\n");
> > > +		goto out_free_log;
> > > +	}
> > > +
> > > +	afi = le64_to_cpu(log->afi);
> 
> BTW, this field is a single byte, so there should be no need to
> use *_to_cpu() on this. (Byte order is only important when the
> field is more than one byte.)

Indeed, I somehow thought afi is of type __le64.

