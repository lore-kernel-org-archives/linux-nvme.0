Return-Path: <SRS0=EXAn=NX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40298C4320A
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Sep 2021 12:46:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12FF660232
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Sep 2021 12:46:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 12FF660232
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yMSK+KAAIADpwrGj2QwVCBq9A4ulrlYVhzBpm2W9OJk=; b=pW0ilPvIMKuaka
	VRLILMEInBvQF7V8grfd4NSxEGwRxZjx9YJvB6v8ya8jCYXEECow0KSyYvgsBpdOSCBPFrr1QdKkg
	Vks0BY3pBvzM1JvGP4vYDqpCn+/rm6REpyPn54XQRBcmDqfJNY0JxaeqfmNA6TSoAVZdKmzWgS+C3
	/8PxU+/G6shEnV7A8I1xD/1L+uQwWEqFGqfXc74910fRXZVX0DSXj+pTDv8OiYWGZAp+vPOu+4F1r
	pFeIrfp6yioLgXhHoJ9HkXad/9mKRnYOdQFUh4Lo0w/+QjQcKi0gVnH6pHdKTEaAW8l2zdE9NUHj+
	KISXycgIj+q0u1rYWI+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mLPbw-0063jP-7L; Wed, 01 Sep 2021 12:45:00 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mLPbo-0063hF-3m
 for linux-nvme@lists.infradead.org; Wed, 01 Sep 2021 12:44:56 +0000
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 833DD20208;
 Wed,  1 Sep 2021 12:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1630500288; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xYGbUhlPmATEs2buJMnfbI+JwLK0Updnoy96A7PJxac=;
 b=azaOUgyAb/Oe6XX+gP3K7p06FQezPxQMswrF7pFzaIPZt3dYBuUII+yZ1yY0KWDGaBI0sH
 2Eff0ywAEhdIN7AcTctbOIxlcKFvOM28CUDK8llZGijOWop0QVSGNmjofiL+gt/aSDOzvs
 FF9efZI+3M+92c2p7cpFqaRtJD/GxmM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1630500288;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xYGbUhlPmATEs2buJMnfbI+JwLK0Updnoy96A7PJxac=;
 b=hzep7aLyr++Ya++DuDZty075cHlU0+XpwyFiuB88IO/IF/yLhnohZL+wwoFSwMvBqQPVuO
 Ebc4OYszPDTIQ+Bw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 6D4B813ACB;
 Wed,  1 Sep 2021 12:44:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id wo9KGsB1L2GRUAAAGKfGzw
 (envelope-from <dwagner@suse.de>); Wed, 01 Sep 2021 12:44:48 +0000
Date: Wed, 1 Sep 2021 14:44:48 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] nvme: only call synhronize_srcu when clearing current
 path
Message-ID: <20210901124448.naki6kzntvsw4d6v@carbon.lan>
References: <20210901092524.131610-1-dwagner@suse.de>
 <YS9xKzRWW97L6ZN9@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YS9xKzRWW97L6ZN9@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210901_054452_364136_46896FB9 
X-CRM114-Status: GOOD (  10.99  )
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

On Wed, Sep 01, 2021 at 01:25:15PM +0100, Christoph Hellwig wrote:
> applied to nvme-5.15 with a cosmetic fixup to keep the lines from
> overflowing.

Thanks, forgot to check the length (I guess I should set max line length
back to 80). Looks way better anyway :)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
