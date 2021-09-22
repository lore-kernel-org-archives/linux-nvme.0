Return-Path: <SRS0=1D85=OM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45EACC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 08:03:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13A306124A
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 08:03:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 13A306124A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YbftsEbhWRQ1Sy/u4YrE/B0LFEeVUIgsI93GGJQ90+Q=; b=SaAxQWjovUWaPX
	/urRc3shTymp73YdecY2OkT8Cr21H73KRmL0c78C3waZ9CMJbrtaN94WeZI/lfyfaPZ/VvFJNmJFn
	abBRb6pA1Pfg0Vo1nGC1CD/YldTPvMdivUfSZO7Oj3zNAfQ2cvBj5n5u0xFBhQ5ypoCHk4UQfJ7vi
	XzRDH1MXTclpjibOW/aVxSZpNkPr5zVrYqaMweUhJ9hg9eOXxY/EO+fPfL6fUUSl2vZgA4ZT5nVRE
	lS5w2TOqPBYTsbcKuoP5zUH9WB/FTdVc+bDpgdEhrhmtORmI/2HMDTUiUQdu+o5Z1kDgo50bMjJ4c
	p5qS+XpE2xt0UCyYi9bw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mSxDb-007OhI-E5; Wed, 22 Sep 2021 08:03:03 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mSxDY-007OgW-IO
 for linux-nvme@lists.infradead.org; Wed, 22 Sep 2021 08:03:01 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2EE08201C1;
 Wed, 22 Sep 2021 08:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1632297777; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ps6SuMdyQgaa+80mRbdHxICSUvJApS7cA3JFhJTKX80=;
 b=Z5TTCKY5NX1K52v+N29dDmLlk3o4IO8JqNSG+XULAWCmnrZZ01UyMh1Lr2gEEAxne60vPE
 JcQmf6dmdya+Y2nzlONuYK766dyieOoWPIue6Q0eUaaW4YckCZ09bdF9oRqPtgytSiud/u
 j1X3yt8i/lvlHP6mKmXtSQi0/LzmUVI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1632297777;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ps6SuMdyQgaa+80mRbdHxICSUvJApS7cA3JFhJTKX80=;
 b=Lx4QYeJ0l7KmIBYXI82pKVe4gJbSSd5i5+L6mk5mqEVIaoe46xL4C/XNI+mupp1oWEG/W+
 a40up0cJPlDJP8AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 193A113D65;
 Wed, 22 Sep 2021 08:02:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id HQ2iBjHjSmH+fwAAMHmgww
 (envelope-from <dwagner@suse.de>); Wed, 22 Sep 2021 08:02:57 +0000
Date: Wed, 22 Sep 2021 10:02:56 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 linux-nvme@lists.infradead.org, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH 5/7] nvme: expose subsystem type in sysfs attribute
 'subtype'
Message-ID: <20210922080256.sxl437n22f2mcmsq@carbon.lan>
References: <20210922063525.143045-1-hare@suse.de>
 <20210922063525.143045-6-hare@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210922063525.143045-6-hare@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210922_010300_802559_F333F078 
X-CRM114-Status: UNSURE (   9.43  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Sep 22, 2021 at 08:35:23AM +0200, Hannes Reinecke wrote:
> +static SUBSYS_ATTR_RO(subtype, S_IRUGO, nvme_subsys_show_subtype);
> +
>  #define nvme_subsys_show_str_function(field)				\
>  static ssize_t subsys_##field##_show(struct device *dev,		\
>  			    struct device_attribute *attr, char *buf)	\
> @@ -2618,6 +2636,7 @@ static struct attribute *nvme_subsys_attrs[] = {
>  	&subsys_attr_serial.attr,
>  	&subsys_attr_firmware_rev.attr,
>  	&subsys_attr_subsysnqn.attr,
> +	&subsys_attr_subtype.attr,


Shouldn't this be subsystype to stay consistent with subsysnqn?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
