Return-Path: <SRS0=uBfD=K4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27952C47083
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Jun 2021 15:18:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED26261246
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Jun 2021 15:18:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED26261246
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ol8wpeQh+yTZSaLk1tCm/kJcVucxIa8bE9ssk+3d2MU=; b=m9XveHhRNg6y9l
	MJuiHuAewoeva9NacNC8PTJRQ4T8z+xJe6dsljp8zjVtIe8FiZj+ykaPbijVIZ07ViyFdnF6wZLEh
	OAAdzrVIzFYVZXu4RuwbusF0HHQwOc+ztlezvVCLVNLbiVrsNZtIyn4VF5jifVJZJ4a19a2BQQnX5
	RPYch58GK7ThH3WHtvvVeOC+a18vERuthTI6x2zgD/jL7zPdN5sFWl8FwH3FJB6FFb59kTni0ASEF
	c6hEo7QGhF33zsQMAQ8LNBDmB9i2H2w00AyNQFtq46cWCbZorWEN8CKqB/KV+b4hTWSuP2aF/v7Ki
	ud+TSF/+rNbSvWP4qFSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1loSdm-004oLw-An; Wed, 02 Jun 2021 15:18:42 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1loSdf-004oH7-7i
 for linux-nvme@lists.infradead.org; Wed, 02 Jun 2021 15:18:40 +0000
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
 (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0E59D336E7;
 Wed,  2 Jun 2021 15:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1622647112; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=94BwVvcKrAI+NWGxu/ROld7wZlGsxt52f6M4Ri++3BE=;
 b=JRfdjcjezHVUWId4flW7MPoRofk3c5D4AdW7mxSCnNVBrDflbgNjb82S5WvkI8x3m+1e0v
 77O6UlA+5afJ5qOdRQzYsEsMPRTTICRhCwpueILy3T7ZKvNZGmidXx51v5MTLBqMTZBQAF
 dPOXjBpIgq0NUX86Q26XiC9tPnVYML0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1622647112;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=94BwVvcKrAI+NWGxu/ROld7wZlGsxt52f6M4Ri++3BE=;
 b=zW7ehgWWMVNp82+eHjE5dkp1SiuEYRFvQfpM28o01y8BD+lpX53mSGzKT8lQw1h+8Z7IpQ
 9tTJvwi/zc1OpHAg==
Received: by imap.suse.de (Postfix, from userid 51)
 id 03A5311CD6; Wed,  2 Jun 2021 16:07:31 +0000 (UTC)
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
 by imap.suse.de (Postfix) with ESMTP id 8A29F11E3F;
 Wed,  2 Jun 2021 12:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1622638159; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=94BwVvcKrAI+NWGxu/ROld7wZlGsxt52f6M4Ri++3BE=;
 b=Ps9Uk4tk3AruLw4qiTFIcIwsJABrdJW5I6U31BJHSQzSrxmX6AevNLGDxO982AvpYgJabc
 eHyIafbNhQ59P9c40um7S8v4pFnHlFfUs1IDfRSqoztKJevZa4azzYPsapVVFkENi4NeEa
 lCazp7RCu+OjG7g/RrjPKRlNt47OfEA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1622638159;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=94BwVvcKrAI+NWGxu/ROld7wZlGsxt52f6M4Ri++3BE=;
 b=XYlQNIbld5R0Ky8IzRBkiK0ydxAQkpkwPKbOyrNrOKkb2qwXNcnyyHEu1AhP1HL1qv5idB
 Fv6Ywi+lAZg/fuAA==
Received: from director2.suse.de ([192.168.254.72]) by imap3-int with ESMTPSA
 id 87PuIE9+t2D+KgAALh3uQQ
 (envelope-from <dwagner@suse.de>); Wed, 02 Jun 2021 12:49:19 +0000
Date: Wed, 2 Jun 2021 14:49:19 +0200
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvme: reset disk to the mpath node also when requeuing
Message-ID: <20210602124919.gdzorzhbjitjr4uj@beryllium.lan>
References: <20210602123429.103935-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210602123429.103935-1-dwagner@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210602_081835_441327_6A836B63 
X-CRM114-Status: GOOD (  10.32  )
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

On Wed, Jun 02, 2021 at 02:34:29PM +0200, Daniel Wagner wrote:
>  		spin_lock_irq(&head->requeue_lock);
> +		bio_set_dev(bio, head->disk->part0);

Obviously, this needs to be done for all bios. Let me send an updated
version.x

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
