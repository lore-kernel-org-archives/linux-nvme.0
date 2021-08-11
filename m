Return-Path: <SRS0=LdLJ=NC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13935C4338F
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Aug 2021 10:32:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8C2360D07
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Aug 2021 10:32:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C8C2360D07
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4je+NGaZCbQyc+45AGL9L2JcfoqF0nOlEhrng2JoYIM=; b=k1hd/aj9IjsJlO
	QP4bMVl5v3YA9j9YQpeRgHZSgnWs/04jBVSpFHiiQw4Wo1GvbWQuDdOSuTa2z2tl+GROzdDRtjRk8
	NCoXcgqAQHrapjS3ryj6R+ctjrb/l7iykMH/D2TSSNcAw9dTQw8l2Pd3APhaROeqImxKA3JcNQCHn
	XIMbFWQIio18Db0FVwLK/16by3dK6fWK/8NnyCuSU+2nJzlAn0/j6ZSV89eFF0C894pJ1q5jpQUP0
	WG6XczAPZJmPe7305oxuab+y9Aqru5VBcwUuWHZnIiOpWj0pt05q9ZTtWUZjAr4mkQpqbB7UPG10k
	9OljRDWcPNx6vLXvdZWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mDlWa-006ddo-Tz; Wed, 11 Aug 2021 10:31:52 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mDlWV-006db9-S9
 for linux-nvme@lists.infradead.org; Wed, 11 Aug 2021 10:31:51 +0000
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 89530221D2;
 Wed, 11 Aug 2021 10:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1628677906; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KpLDPZd/N2/VcLHworm+Mh4R910b9m4Ub0D/eTKpZ2c=;
 b=VbVynxJn3fn2qBccx43dG5RN+NVZw3aHD5cjvxnZ5rKYdjuQsvDMB3Al86aCK7tCfP0AKK
 /ovX2lHHToJW+qgSviR6HEyPdpUKbZZEoiNVvrX33cP5rJI6ZDcleJStVKwc5K+MjUABhL
 tIDHI5P5plKELLqIZyr0tVo3bhFcrCk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1628677906;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KpLDPZd/N2/VcLHworm+Mh4R910b9m4Ub0D/eTKpZ2c=;
 b=9pnAPYyX7BnYcKFd8cyLrvcHazFsOhpr/jdI5zJ8HW59Gk4gssjbYPKcor7+nnfKHMagHd
 rK0PknAIjWdbsRCw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 78E2E131F5;
 Wed, 11 Aug 2021 10:31:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id IpSAHRKnE2EQEAAAGKfGzw
 (envelope-from <dwagner@suse.de>); Wed, 11 Aug 2021 10:31:46 +0000
Date: Wed, 11 Aug 2021 12:31:46 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Hannes Reinecke <hare@suse.de>, yi.he@emc.com
Subject: Re: [PATCH] nvme-tcp: Do not reset transport on data digest errors
Message-ID: <20210811103146.ytqj5mqpioiba56x@carbon.lan>
References: <20210805121541.77613-1-dwagner@suse.de>
 <47ef76c6-4430-ca24-405e-a226d4303a39@grimberg.me>
 <20210809090947.luoqaooi7gc6u6yu@carbon>
 <2e91c065-d3c6-1bef-5906-1a4648368894@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2e91c065-d3c6-1bef-5906-1a4648368894@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210811_033148_124328_94770129 
X-CRM114-Status: GOOD (  18.40  )
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

On Tue, Aug 10, 2021 at 06:02:36PM -0700, Sagi Grimberg wrote:
> 
> > Hi Sagi,
> > 
> > On Fri, Aug 06, 2021 at 12:42:00PM -0700, Sagi Grimberg wrote:
> > > > @@ -89,6 +89,7 @@ struct nvme_tcp_queue {
> > > >    	size_t			data_remaining;
> > > >    	size_t			ddgst_remaining;
> > > >    	unsigned int		nr_cqe;
> > > > +	u16			status;
> > > 
> > > Why is this a queue member and not a request member?
> > 
> > I was not sure if the TCP transport specific error handling should
> > impact all other transport (size of struct request). Also I tried to
> > avoid accessing cachelines which are not already in use. Except this I
> > don't see there should be no problem to put this to struct request.
> 
> It is the correct place, lets see that it doesn't increase the struct.

It should not according pahole:

        /* XXX 7 bytes hole, try to pack */

        void *                     pdu;                  /*   144     8 */
        int                        pdu_remaining;        /*   152     4 */
        int                        pdu_offset;           /*   156     4 */
        size_t                     data_remaining;       /*   160     8 */
        size_t                     ddgst_remaining;      /*   168     8 */
        unsigned int               nr_cqe;               /*   176     4 */
        u16                        status;               /*   180     2 */

        /* XXX 2 bytes hole, try to pack */

Daniel

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
