Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A86FDEDEC47
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Sep 2023 11:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Jw7VrG1wDiIT9Y0JnImTHxBRJ2Bt8wke3di/er57Oyk=; b=bE6Ym+BJZ00GFNFAq1an+cDT2n
	7aIpm5p3nvTwhQX4dTy7r47osxP1ZdwoHxsDuJ0JUsVmz9qC0O6e08C3uuDinx0hTniINUjK8RWV+
	npsO30gSQ4EsXgUAR4h/uaxISS3vQtdQnDZjo3fyLTU9yibaSSDD3X85btJDe5k3V731iGu/HVIUT
	aVqrlKB1K3UZLv9S/9Ylely3Kbd8jyzorNqaNkECtuFMMjaVqiRWMSxdZFEiIE8iJXS8uGRj4Tycs
	X90lLmtAxfHyZJQ83Hhvlj4cnHL7edzqvHUZ3nlCGzhcBfqjXJ/C2vCP/cXKm+Bv86A9oKIGx8K80
	CXSVlM4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qgOW9-005nSZ-1q;
	Wed, 13 Sep 2023 11:58:49 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qgOW5-005nRC-0m
	for linux-nvme@lists.infradead.org;
	Wed, 13 Sep 2023 11:58:47 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DC877218E3;
	Wed, 13 Sep 2023 11:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1694606320; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jw7VrG1wDiIT9Y0JnImTHxBRJ2Bt8wke3di/er57Oyk=;
	b=rrRJ5Wwycc/qfyFFS7rpx6l8AM9MmEFFLEKwB1N11nCDaUYb6PQGnFw+5qp7I6dpFJ+qJp
	12SpqKJB2OZh2jHu1ZzQWM4VtBIvFx4UveWSMNfVARmP2jRhM6oynspuOipGTs+EmWfPfL
	E2qdJnCKU08HxZgWeiGuPfetumgeEfs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1694606320;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jw7VrG1wDiIT9Y0JnImTHxBRJ2Bt8wke3di/er57Oyk=;
	b=QC90yT4DjDa3rPfezZsWpPsgjo2Azp8/Vdk/viCDvJRM5xa3G2QFpd92QizVz58tNHJ6gB
	BzuzlKaSgg7FuYCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D225F13582;
	Wed, 13 Sep 2023 11:58:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id ABUYM/CjAWVpFgAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 13 Sep 2023 11:58:40 +0000
Date: Wed, 13 Sep 2023 13:59:18 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>, Jason Gunthorpe <jgg@ziepe.ca>, 
	James Smart <james.smart@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [RFC v1 4/4] nvmet-discovery: do not use invalid port
Message-ID: <nnvprosph2h6ydtl2fcsseppgyrlju2bnc76lxmgcd6cbk62fo@vmdgzstnn2pz>
References: <20230829091350.16156-1-dwagner@suse.de>
 <20230829091350.16156-5-dwagner@suse.de>
 <20230905065032.GC19701@lst.de>
 <vml2mmhjurjaalzcmugnu2c4cm4okfkl43swbmudmaotew4gsy@o4q44el473to>
 <ebfmki7mifmo67x27wwrdpabdbiamalj7rsevxvabyi4sff4ck@4d5fyvrjggkw>
 <pti3xai6zkvitsqaw54sxut4lpb4qupo4c2n5alesb35ndhxv4@ni7ritoqopfe>
 <pzgeaisqmqz5up5fiorl46lmb6xglpdu4hp5lxotclnzvpfjrj@mgyfvcrvpl4x>
 <20230913113519.GA1565@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913113519.GA1565@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230913_045845_438764_71CBE993 
X-CRM114-Status: GOOD (  14.65  )
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

On Wed, Sep 13, 2023 at 01:35:19PM +0200, Christoph Hellwig wrote:
> So that's interesting.  But what I'm mostly worried about is how the
> nvmet kernel code allows a request without ->port to progress to the
> actual command handler.

nvmet_fc_handle_fcp_rqst()

	if (tgtport->pe)
		fod->req.port = tgtport->pe->port;

Not sure why this is there. Will test what happens when we just return
an error when we don't have pe set.

> We should never allow a command to get that
> far if ->port is NULL, and should not allow to clear ->port while
> commands are still handled.

Okay, makes sense. I'll test this when I have access to my rig again tomorrow.

