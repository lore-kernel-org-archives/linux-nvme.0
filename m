Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27DEBEE57DF
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Sep 2023 18:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QJz0ppghQeuivFed2ka0+o0tWjZ51PoIztp82nSmwVg=; b=0Fq2gw070ZlH/WZEBpIdcfUDBj
	i7AqFxYGccs1K6TPrgZN8j004KTwFJBrt6YeKZ6Tf3ct2ador1rg4IHr+5imuqWW/Bw9joffxD3SI
	u/4RhvyXy/H9agozR363FUENHylGjj5JwPeyvsZNL9FaSLND4ttAOs17Qi3HUX2xKY++pSI2wDoPF
	t2l8ODaJKMrNzIG+DDOM4KNlyGJ60aYRLLpWzwjCqpbjXfeerIoOFTjtmr504kjLDAO77ZhQnF9CM
	sv76gkfCJIT6vXjsAYw/3hL8kzfgjTSXlLzRWjXvsprQxbDPJnDXVmKFfG5jj6bEVfHmyQn8L4kL5
	JB2CUzmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qflUp-0017FG-2u;
	Mon, 11 Sep 2023 18:18:51 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qflUm-0017ED-12
	for linux-nvme@lists.infradead.org;
	Mon, 11 Sep 2023 18:18:49 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9DD8B21842;
	Mon, 11 Sep 2023 18:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1694456325; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QJz0ppghQeuivFed2ka0+o0tWjZ51PoIztp82nSmwVg=;
	b=zNcOZqTqw46PDtGqIqxPVSBE5PGyrRLZmpcKtNfBu/96fPFyNPnKz4sJ6A3zoAq0Qjm+K/
	tYv5zuXzOD4nRxqcejD3iZujmHZj3NrH5EjH+vRZ+kPIanZDVIiiTOCuokyKp9vTeA6h/n
	9VQVO69eJ+XbY9czyLqxKUusMLJQM68=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1694456325;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QJz0ppghQeuivFed2ka0+o0tWjZ51PoIztp82nSmwVg=;
	b=EH10v/ELGuOTr7D/F51PwMP5+ItlGezPUgeW7ax7mKFr2co2W31ufC86d+rWUBv+R2xASv
	mw1qOEZ6UDXj5SAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8F88113780;
	Mon, 11 Sep 2023 18:18:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id MGzdIgVa/2SzPAAAMHmgww
	(envelope-from <dwagner@suse.de>); Mon, 11 Sep 2023 18:18:45 +0000
Date: Mon, 11 Sep 2023 20:19:21 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>, Jason Gunthorpe <jgg@ziepe.ca>, 
	James Smart <james.smart@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [RFC v1 4/4] nvmet-discovery: do not use invalid port
Message-ID: <pti3xai6zkvitsqaw54sxut4lpb4qupo4c2n5alesb35ndhxv4@ni7ritoqopfe>
References: <20230829091350.16156-1-dwagner@suse.de>
 <20230829091350.16156-5-dwagner@suse.de>
 <20230905065032.GC19701@lst.de>
 <vml2mmhjurjaalzcmugnu2c4cm4okfkl43swbmudmaotew4gsy@o4q44el473to>
 <ebfmki7mifmo67x27wwrdpabdbiamalj7rsevxvabyi4sff4ck@4d5fyvrjggkw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebfmki7mifmo67x27wwrdpabdbiamalj7rsevxvabyi4sff4ck@4d5fyvrjggkw>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230911_111848_502357_78C39EE5 
X-CRM114-Status: GOOD (  17.69  )
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

On Mon, Sep 11, 2023 at 04:44:47PM +0200, Daniel Wagner wrote:
> On Tue, Sep 05, 2023 at 12:40:25PM +0200, Daniel Wagner wrote:
> > > But I'm still confused how we can get here without req->port
> > > set.  Can you try to do a little more analysis as I suspect we have
> > > a deeper problem somewhere.
> 
> The problem is that nvme/005 starts to cleanup all resources and there
> is a race between the cleanup path and the host trying to figure out
> what's going on (get log page).
> 
> We have 3 association:
> 
>  assoc 0: systemd/udev triggered 'nvme connect-all' discovery controller
>  assoc 1: discovery controller from nvme/005
>  assoc 2: i/o controller from nvme/005

Actually, assoc 1 is also a i/o controller for the same hostnqn as assoc
2. This looks more like it assoc 0 and 1 are both from systemd/udev
trigger. But why the heck is the hostnqn for assoc 1 the same as the
hostnqn we use in blktests? Something is really off here.

The rest of my analysis is still valid.

