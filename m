Return-Path: <SRS0=bzk4=OV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91780C433EF
	for <linux-nvme@archiver.kernel.org>; Fri,  1 Oct 2021 11:12:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5108361A81
	for <linux-nvme@archiver.kernel.org>; Fri,  1 Oct 2021 11:12:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5108361A81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hajDIubZSdccyLscnwTJJDwtYIVe8+8GduWfNhJz5+Q=; b=rpltknYG0Pw9Io
	I5ZHaSkjgfaWuCHOxIOzZroDdPf2kv+5F6preX4qaucUutFJEemH2ezU2aDt7kz0319PJiCmvXcZF
	vaD9S8XyrbPChhHpjpzBGMyKs9aZHbdp8Aptv/Nqz190C2LMMSWPGPTUsiNMY4uiBEjlTBvpLiekm
	7rZKuh+EV60PF9ANSOejXG6NCgGl5LH+lLhJS7zdaUukHxdsPeoNtMMCs85DO0EZEOO0LN/17S1Ka
	NgU3so6N+f53N/3Yx2738sDszg9O8TYLOnZBfnPikqAZ3atT+SSpltqvJpJ9usb65bINNcJLw5DVm
	1/VOBKVyceOb2sd7mZ/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mWGSD-00HZCv-2T; Fri, 01 Oct 2021 11:11:49 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mWGSA-00HZCV-LL
 for linux-nvme@lists.infradead.org; Fri, 01 Oct 2021 11:11:47 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DF6AD1FEA5;
 Fri,  1 Oct 2021 11:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1633086702; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=epuZzu071kqSJ+QUQ5F2d/5qFn42BzVaqzXSEVR2ITs=;
 b=GuZFMV2DCjsZzrGslEg5jLeeAMvz/9QjG1bC2sDEwTUKRlSooChYGOfAh1A9uOfjs2tQJw
 q9LkWGUZQcD1Kqtg/cOhV/q4po9r0ttpA1pdw+IZembaXKTqmbQhrn9x63k8ZtqOFrSHdg
 bsMvt86EVH4eW8gu9yLqnf3hUyGqfEI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1633086702;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=epuZzu071kqSJ+QUQ5F2d/5qFn42BzVaqzXSEVR2ITs=;
 b=pv37wbbP1GKqIXFIFTJaibeG6be6KD8Oxzt3QZTHNPVbmyiGWyMFv9TWjt3CAUMrU6PxLv
 IzetsNHwX6KLh6AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CF0D313C21;
 Fri,  1 Oct 2021 11:11:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id FaZEMu7sVmEjMAAAMHmgww
 (envelope-from <dwagner@suse.de>); Fri, 01 Oct 2021 11:11:42 +0000
Date: Fri, 1 Oct 2021 13:11:42 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Martin Belanger <nitram_67@hotmail.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, axboe@fb.com,
 hch@lst.de, sagi@grimberg.me, Martin Belanger <martin.belanger@dell.com>
Subject: Re: [PATCH] nvme-fabrics: Use shutdown timeout on disconnect
Message-ID: <20211001111142.cpergy5bcleywv72@carbon.lan>
References: <BL0PR13MB42919DA26E7A75E9219F62DF9CAA9@BL0PR13MB4291.namprd13.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BL0PR13MB42919DA26E7A75E9219F62DF9CAA9@BL0PR13MB4291.namprd13.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211001_041146_895601_F2CB83FC 
X-CRM114-Status: UNSURE (   9.36  )
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

On Thu, Sep 30, 2021 at 10:56:34AM -0400, Martin Belanger wrote:
> @@ -244,8 +257,8 @@ int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val)
>  	cmd.prop_set.offset = cpu_to_le32(off);
>  	cmd.prop_set.value = cpu_to_le64(val);
>  
> -	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, NULL, NULL, 0, 0,
> -			NVME_QID_ANY, 0, 0);
> +	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, NULL, NULL, 0,
> +				     timeout, NVME_QID_ANY, 0, 0);

If I am not mistaken nvmf_connect_io_queue() suffers from the same
problem.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
