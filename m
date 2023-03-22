Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9139EC6FD1F
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Mar 2023 14:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CZc0Qj4tZ4zTkmzE1ji+h6aLVP7ArKKuE6NKqyNX8Ms=; b=HHYB2Anp6pv7ersBXXzjwQq4Ds
	A5nCejciFGcuJodtoYuTauVgbTFSuxWU2ePYO6GrBk2Ld5NtajCErjVwNcbGqFwh6dI3VQIwinc/B
	j7jZeT3mDJhYjSzzNcMRa1Qee2htUngIZFrxURlG9FcSBP2MnPbMWE8JMtD3tAx5GGJT2m60AX8gK
	SUb2KMjkxAZ4u8XtAJRuQafAAG8odaUZM1I3eEoW1324cogScbUZUd7n/0v3UONXlYi7yw/fT7qhc
	PnAigTdyAF8dap58TUyYcwIXReGPinDRtvMYPjnYKSG7h1PNXtDNFiOYLSW2sHl04OdoOFsv93gWb
	Wqbu+nvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pez6e-00GEIR-2v;
	Wed, 22 Mar 2023 14:06:24 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pez6c-00GEHk-1u
	for linux-nvme@lists.infradead.org;
	Wed, 22 Mar 2023 14:06:23 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 12C2733BA6;
	Wed, 22 Mar 2023 14:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1679493980; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CZc0Qj4tZ4zTkmzE1ji+h6aLVP7ArKKuE6NKqyNX8Ms=;
	b=jq8ibrVdnjgWoiHkuYTGpLBdgrAUEpiIZxVYbZr7nBs5CKgbLQF5IOoAD2jWoxlFdTbtAI
	t35kjRmeXHl/5BVLg6S0uVGTkDhWP2OlD/sgDqDHEyuek6H0uOABk1EtMPr8vWkGNsK47k
	3ovwAsK325TrQjDjNJVtQOaIBy7z7bI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1679493980;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CZc0Qj4tZ4zTkmzE1ji+h6aLVP7ArKKuE6NKqyNX8Ms=;
	b=kzC+o+meSy0BCfmHz3IjoqPjmj78VDc2SPNV32nysLHEL1uiiFvucEZJ6COdAsphz+MLbe
	OUrfz0ieohwpfjCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 03CC613416;
	Wed, 22 Mar 2023 14:06:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id K2DfAFwLG2ToGAAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 22 Mar 2023 14:06:20 +0000
Date: Wed, 22 Mar 2023 15:06:19 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	axboe@kernel.dk, linux-nvme@lists.infradead.org, sagi@grimberg.me,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 2/3] nvme: add polling options for loop target
Message-ID: <20230322140619.zy2msly7mcuwgo6a@carbon.lan>
References: <20230322002350.4038048-1-kbusch@meta.com>
 <20230322002350.4038048-3-kbusch@meta.com>
 <20230322082310.GA22782@lst.de>
 <20230322084651.xmnup2ag3ve6jr3a@carbon.lan>
 <20230322135200.GA16587@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322135200.GA16587@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_070622_779625_2F7C7C31 
X-CRM114-Status: UNSURE (   9.87  )
X-CRM114-Notice: Please train this message.
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

On Wed, Mar 22, 2023 at 02:52:00PM +0100, Christoph Hellwig wrote:
> Who says that we could support polling on all current and future
> fabrics transports?

I just assumed this is a generic feature supposed to present in all transports.
I'll update my new blktest test to run only tcp or rdma.

