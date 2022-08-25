Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9C6CC04AA5
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Aug 2022 10:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dxzbJ2vCvSwAIVdbJ4VBLT/JAENDDgOFWtlEfbpDxTk=; b=eFNYAgzpXtuiJt5TzE9OX3qF0w
	TfjQG6ZtioDq2ath9YoDOaHsFFxyUe5N8s6cmFo+kHPNibtNLJf4l53/hknOwtjxfI2oHqZ542NWB
	srY43E5Jtd6OLxrHasz7cY+LuHiYX7rwtRzgMqYcsl1pbTUUjRjYXojp2y080VUQPWLEOAKp5oBvh
	uTyR2zuBkZaCqPfcm9qy+qU2v78tA3BM0sTlgl9YQ24ZyUL+f+ltDgRJGkE/s28vSiCwh6T+R5d4F
	KN0/Hns53WG5NZCvrasAv1pNsrIctrmOWorHZAIweAMu+RUp959ZgC156wR1SPjkOCcuTuK8czqpM
	NTtlKXhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oRAWk-00C8w4-Al; Thu, 25 Aug 2022 10:55:58 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oRAWh-00C8nb-Lb
	for linux-nvme@lists.infradead.org; Thu, 25 Aug 2022 10:55:57 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A88EE34474;
	Thu, 25 Aug 2022 10:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1661424950; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dxzbJ2vCvSwAIVdbJ4VBLT/JAENDDgOFWtlEfbpDxTk=;
	b=N3vmscKex1M3uYQIbioyU+/NU3wcMkEsbbVjUju0MUjMdLA/+x/cwySdQTcQT6lKtpD48Q
	dwBI5C9lIvmPEMS49Vys4oewI0pdOy70od1/LB7wHnuQdXgJDmD81sqLEHFQF4ig2q4dIV
	wPBHhHZakyYogXRpR9cLx5os7CMyL7w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1661424950;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dxzbJ2vCvSwAIVdbJ4VBLT/JAENDDgOFWtlEfbpDxTk=;
	b=welTTXfBdQzIH7OYXUllnwrSsV2jTboPJzb7yjvUfbOBtqZ1MYYH5KJ9AvCHEwKPMrs2Y3
	mwc/UIcte6n4o2Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 93E1C13517;
	Thu, 25 Aug 2022 10:55:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id eNloIzZVB2NLbAAAMHmgww
	(envelope-from <dwagner@suse.de>); Thu, 25 Aug 2022 10:55:50 +0000
Date: Thu, 25 Aug 2022 12:55:50 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Chao Leng <lengchao@huawei.com>
Cc: linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v2 3/3] nvme-rdma: Handle number of queue changes
Message-ID: <20220825105550.3hxjveuex4nmup54@carbon.lan>
References: <20220823074451.12170-1-dwagner@suse.de>
 <20220823074451.12170-4-dwagner@suse.de>
 <17886a4c-8443-19a1-c2fa-d7ea0f2e5a1f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17886a4c-8443-19a1-c2fa-d7ea0f2e5a1f@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220825_035555_896789_3252470A 
X-CRM114-Status: GOOD (  12.15  )
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

On Thu, Aug 25, 2022 at 06:08:10PM +0800, Chao Leng wrote:
> > +	/*
> > +	 * If the number of queues has increased (reconnect case)
> > +	 * start all new queues now.
> > +	 */
> > +	ret = nvme_rdma_start_io_queues(ctrl, nr_queues,
> > +					ctrl->tag_set.nr_hw_queues + 1);
> > +	if (ret)
> > +		goto out_cleanup_connect_q;
> > +
> Now the code looks weird.
> Maybe we can do like this:
> first blk_mq_update_nr_hw_queues, and then nvme_rdma_start_io_queues.

We have to start the exiting queues before going into the 'if (!new)'
part. That's why the start of queues is splited into two steps.


