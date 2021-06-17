Return-Path: <SRS0=fYEw=LL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E396C2B9F4
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Jun 2021 08:00:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F78661076
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Jun 2021 08:00:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F78661076
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iEpSSEY9UmOEs97ahJDhmtpIi1lbkn9O3RFMQ3yTZiM=; b=NQSP03zm9VLiH0
	u5EaOfSMXo27fmUk8fUSqdKStdr4MSpPzQnIpmHkw4oL6ce7P0Lka1qHDZT/qKoNSlNIqioMRipgl
	90Kvpb0KnFxDkV3h37FG35I8uMJr2p6bz/0zO6f4sy0cQsd0ciE9hN+9y6REBIHLRwdCgtG2oNBQc
	hdZo5Chi0/87uzg2hxHFpwV5YyzZacyp1WsJsSIa6klDQdNCHn92gJSlCgLT06+pvWUK6e9/RQ4AV
	6qrn/T47IChKbsicgBEhztUEcAAVVotuV7Q6xj6DZ+kZyKhDDig6rYtJfJzyNxucLPSfb69hEpP/1
	LcBZAbRFPuflta7nf5OA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ltmws-009Oqw-9d; Thu, 17 Jun 2021 08:00:26 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ltmwc-009Ona-3W
 for linux-nvme@lists.infradead.org; Thu, 17 Jun 2021 08:00:14 +0000
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
 (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 97F0A1FDC3;
 Thu, 17 Jun 2021 08:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1623916804; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dYWgjquMNUr2qAaJoEJYFH6SapdrDkrAMtVKTOuy4HQ=;
 b=XeP+EU5geKsRmup3Kv5U1/aDGpthZpvPlhDK69zeZfOfw2muXnmm84nMHjev1xoU0mtAY/
 lpIDzOE1lXk9/3+J7rmtRTLuWOlhSLGT69YcojW7LDw84S0iuXs1zX6SOLXQDN+SMgbdT/
 NQoAlirgeV+tOTesDsO7koxuMgXx8K0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1623916804;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dYWgjquMNUr2qAaJoEJYFH6SapdrDkrAMtVKTOuy4HQ=;
 b=97sHNAxNjrX5WaF8y2wM+WGhDy5wkt/l+q9glvOUTv+2pSNFJBiPYp7g/3mJbiJ4IM+zWj
 XxXFEfGUET7Bw7Ag==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
 by imap.suse.de (Postfix) with ESMTP id 7EAE9118DD;
 Thu, 17 Jun 2021 08:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1623916804; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dYWgjquMNUr2qAaJoEJYFH6SapdrDkrAMtVKTOuy4HQ=;
 b=XeP+EU5geKsRmup3Kv5U1/aDGpthZpvPlhDK69zeZfOfw2muXnmm84nMHjev1xoU0mtAY/
 lpIDzOE1lXk9/3+J7rmtRTLuWOlhSLGT69YcojW7LDw84S0iuXs1zX6SOLXQDN+SMgbdT/
 NQoAlirgeV+tOTesDsO7koxuMgXx8K0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1623916804;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dYWgjquMNUr2qAaJoEJYFH6SapdrDkrAMtVKTOuy4HQ=;
 b=97sHNAxNjrX5WaF8y2wM+WGhDy5wkt/l+q9glvOUTv+2pSNFJBiPYp7g/3mJbiJ4IM+zWj
 XxXFEfGUET7Bw7Ag==
Received: from director2.suse.de ([192.168.254.72]) by imap3-int with ESMTPSA
 id MINcHgQBy2C4FwAALh3uQQ
 (envelope-from <dwagner@suse.de>); Thu, 17 Jun 2021 08:00:04 +0000
Date: Thu, 17 Jun 2021 10:00:04 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH v3 1/4] params: lift param_set_uint_minmax to common code
Message-ID: <20210617080004.ujxn73bntthjuoqu@beryllium.lan>
References: <20210616211936.451128-1-sagi@grimberg.me>
 <20210616211936.451128-2-sagi@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210616211936.451128-2-sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210617_010010_333515_3B190676 
X-CRM114-Status: GOOD (  14.52  )
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

On Wed, Jun 16, 2021 at 02:19:33PM -0700, Sagi Grimberg wrote:
> It is a useful helper hence move it to common code so others can enjoy
> it.
> 
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> Cc: linux-nfs@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>

[...]

> +int param_set_uint_minmax(const char *val,
> +			  const struct kernel_param *kp,
> +			  unsigned int min, unsigned int max)
> +{
> +	unsigned int num;
> +	int ret;
> +
> +	if (!val)
> +		return -EINVAL;
> +	ret = kstrtouint(val, 0, &num);
> +	if (ret)
> +		return ret;
> +	if (num < min || num > max)
> +		return -EINVAL;
> +	*((unsigned int *)kp->arg) = num;
> +	return 0;
> +}
> +EXPORT_SYMBOL(param_set_uint_minmax);

Couldn't this be EXPORT_SYMBOL_GPL?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
