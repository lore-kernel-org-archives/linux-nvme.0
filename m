Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23627C7EE24
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Jun 2023 06:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5pd4LJ393MH2zbaS3t5GhZsJobD7uMEtaVcs7FxZFz4=; b=vvNE9Ll08od/5u5MUAzJqpvOO/
	zU5pESjmrAdF4BbVFwSkIr+ofDr+CILkG9GijrcLqxCcsVMuyCOmd1VH/W+ps96QpQ73zPn9HykDg
	9HH+V0JZkYVxwDH+0r8PiivuTxuRWGqAcXZ37zWF34e8GxV6gVB/X++ixnr4caCLP+9cdn1xD2V25
	9HZ8Z4Ka5OHAlTXL4fYkJmb9/HvpNDet++bH7lbyL+oF3ij2bdnCQ9NC0V0U5/v9XmoV8mtEF6Byf
	1oMKn/mvqGEMrqmHDbVb2nlrUr8OZHtN+aOaYABqnJNQphE1qzsa4itsBoPbB+fe84ITC5sOJgpVC
	7pN2vUAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6PrS-000KAM-30;
	Tue, 06 Jun 2023 06:08:06 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6PrP-000K8d-1u
	for linux-nvme@lists.infradead.org;
	Tue, 06 Jun 2023 06:08:04 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BFCEB1FD5F;
	Tue,  6 Jun 2023 06:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1686031668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5pd4LJ393MH2zbaS3t5GhZsJobD7uMEtaVcs7FxZFz4=;
	b=CFi7uHJq+bc/MQQP+AOnEXYMOq7WaP9XVZPWFIQ8m8FN/2uXOCdvGc1shzscPvnxDH+0YG
	Fjv6JVVQmVJPhLl1RPGtlL5w7tcdGmOoz9SPxqwA8Z5of8r3DU/WhFaeFCxf4lhdKXJVaP
	8WSXTQLHOuJplgxnwRDTDnPGjKhLYyA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1686031668;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5pd4LJ393MH2zbaS3t5GhZsJobD7uMEtaVcs7FxZFz4=;
	b=ORwIyJATjZ8EeUcFEzqSKJPOHIgQfeaK43R9+ErjXCDfaGYI+9gAjcXZosmO0MXV0I2Zvv
	HQPYe0XjRCW3ttBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A671913776;
	Tue,  6 Jun 2023 06:07:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id ZBUfKDTNfmRgZQAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 06 Jun 2023 06:07:48 +0000
Date: Tue, 6 Jun 2023 08:07:48 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Shin'ichiro Kawasaki <shinichiro@fastmail.com>, 
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v3 0/2] nvme_trtype=fc fixes
Message-ID: <kk2ijfx4dwdih274niskq3yi4mcsnnfveus36pu6wagjklx7fc@hprfzp7pi2wz>
References: <20230503083816.18792-1-dwagner@suse.de>
 <ydocewz6ls4bjow726voiqlk3hi3nziss7ppmao6a7c5v4yv6s@t24bkmsjcm6a>
 <ffazxcr66mlu2wecsr2tdsd2fugz425gqplu66cczbchub4kwa@j4ug5w37aefz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffazxcr66mlu2wecsr2tdsd2fugz425gqplu66cczbchub4kwa@j4ug5w37aefz>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230605_230803_784732_D0B93364 
X-CRM114-Status: GOOD (  11.52  )
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

On Tue, Jun 06, 2023 at 05:24:22AM +0000, Shinichiro Kawasaki wrote:
> On Jun 01, 2023 / 11:01, Daniel Wagner wrote:
> > These patches are necessary to get to get the FC transport off the ground. At
> > least with those applied, blktests should be in shape and only the kernel part
> > needs to be addressed from then one.
> 
> Sorry, I missed this v3 post. I've just applied them. Thanks!

No worries. Thanks!

Since we have all in place now, I'll rebase/repost the fc patches again.

