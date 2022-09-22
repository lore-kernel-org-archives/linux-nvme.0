Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3A42C6FA82
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Sep 2022 08:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CPk4yJLp5nAwPMQ7/S12v4yNbZATvb7y9YHNB6g8LwQ=; b=qfHl/Q/deYut8qlu3CeVLUA1Gt
	WoYUXNMNeMRIMSZ3dCIEZTOKMQXuUOsFgJnVFA1xpz52EwGuB2TTIKRaJOFH5LKDXGQf82GUow37b
	YNAeEeShLYqHRNenTTxY5H+z2fpxBwP6uugsoukKfboFModmCKi4hw96HRzfO6u9fqZyKQ+BEnUvj
	QpE34lr9VZx2DBZh605xkCpIf2rc8U3OMHOko913+XwD3GG2qmZyeMbqHq3YSTgg6dPY3chrct9WW
	bF1v0+Hwwj52ZYnnbna3zXStRBSMYl5Qf9gGkf5jkDU3ZCdJg0RiOKSkiS4KTy1cfbBjnStIUL6v0
	IdmJ2CgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obHep-00EBKX-HT; Thu, 22 Sep 2022 08:34:07 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obHem-00EBJK-RM
	for linux-nvme@lists.infradead.org; Thu, 22 Sep 2022 08:34:06 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AE0C61F388;
	Thu, 22 Sep 2022 08:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1663835641; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CPk4yJLp5nAwPMQ7/S12v4yNbZATvb7y9YHNB6g8LwQ=;
	b=V1E90u2nj3K1EWdo0eBCG8RMzet0QTU042EP7CO5tf3UgxDmtJMtYwk/DhnbIQJZ8JdYO2
	8TweGGaXgCmIU9HF+7wr4ImwFEahnhJSzkn5lkmLRccreTnLJh30pZ+zulBJRANZgFq2Oi
	6fJi+Casuq8g7RBaIUOGnhU3jeJDX7Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1663835641;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CPk4yJLp5nAwPMQ7/S12v4yNbZATvb7y9YHNB6g8LwQ=;
	b=JilE5mIskwZv7D4x7OnhIkUcBfExcn2z5lkbNkOAfoGmCb93y+8iDIgpPqdmtr/gdq30fD
	6W0Ki6Vv0RboXWBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A08B513AA5;
	Thu, 22 Sep 2022 08:34:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id lfMPJ/kdLGN6ZQAAMHmgww
	(envelope-from <dwagner@suse.de>); Thu, 22 Sep 2022 08:34:01 +0000
Date: Thu, 22 Sep 2022 10:34:01 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	James Smart <james.smart@broadcom.com>
Subject: Re: [PATCH v2 2/2] nvme: send a rediscover uevent when a persistent
 discovery controller reconnects
Message-ID: <20220922083401.i5ktgvk3266iivth@carbon.lan>
References: <20220922081538.13364-1-sagi@grimberg.me>
 <20220922081538.13364-3-sagi@grimberg.me>
 <20220922083024.rk2igxroroqextzc@carbon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922083024.rk2igxroroqextzc@carbon.lan>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220922_013405_048760_6340E16E 
X-CRM114-Status: GOOD (  10.40  )
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

On Thu, Sep 22, 2022 at 10:30:25AM +0200, Daniel Wagner wrote:
> Stupid question: nvme_start_ctrl() is obviously also used in pci.c. Is
> it expected that a PCI device also sends out the rediscover event?

Forget it. I missed the nvme_discovery_ctrl() part.

