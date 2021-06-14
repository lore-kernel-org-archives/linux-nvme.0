Return-Path: <SRS0=JVDK=LI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFEEC48BE6
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Jun 2021 11:21:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A0A561055
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Jun 2021 11:21:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A0A561055
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xwTe8r3dpzMrQ1azdsPB3JepVenRl7t1ES35aVTFTnc=; b=B4zONVA/7h3H3k
	8A2wiNMnEEqgaAxV7Urdrbm+ipQp1kyMnimyiP3pX8sJR6M8cMacdKBfQs/+TsBD4LHZkF18YJdCv
	wBiwUN+Mf7AKVbq+nh9kAUnL3d9gTnG7Nzvh4p1W2kpuS9f2CVeX/80jEQXYDsnCr+KNs9d/NeNsX
	aTLzYGMXSZWZWhRMOIzfDOUNDS6AyQYjzzbby2p8aZDxpySVvaw6Ze/Vo0RjlvckYmxpMzSbhjkpN
	NgolD4L2vAMUF06OAVSA5t6SCjy4MBEbnPACHv5plVSR/5rY7b8QFydP38TZtUw5r836QCT00FI1D
	9o2KRhL2xjksA+wIiRvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lskeq-00DpJj-Ky; Mon, 14 Jun 2021 11:21:32 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lsken-00DpIH-Ik
 for linux-nvme@lists.infradead.org; Mon, 14 Jun 2021 11:21:31 +0000
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
 (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 891CF1FD29;
 Mon, 14 Jun 2021 11:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1623669686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dC3Kd9bVYWvyKEML8i1TkdPjvfwlYAfUWomuYyCdvEA=;
 b=KEty+8jQ0f13VsbRqoOOkQmakMeeoxWSa1RUOfgCPJeABBmBHJERlisY7j+8U1Gw/RrmxQ
 rwj5bnDuRrt+0CIsHhr6JUFKx16eIJrabZ+hUD4j90CmWnFzKj2Yxe+dCA5+3NZ2QeloTL
 KoVceFUu9VHNFlGGsLZta4tMKeEwTsE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1623669686;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dC3Kd9bVYWvyKEML8i1TkdPjvfwlYAfUWomuYyCdvEA=;
 b=hnlR+/vStjcFvu/Z8Stuo8vYr0sxzKM9OWGGyvT1n/+QO9guEB38gVWQH852Jpychcyhh5
 HBVAfx8Fnj6bD5CA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
 by imap.suse.de (Postfix) with ESMTP id 70798118DD;
 Mon, 14 Jun 2021 11:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1623669686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dC3Kd9bVYWvyKEML8i1TkdPjvfwlYAfUWomuYyCdvEA=;
 b=KEty+8jQ0f13VsbRqoOOkQmakMeeoxWSa1RUOfgCPJeABBmBHJERlisY7j+8U1Gw/RrmxQ
 rwj5bnDuRrt+0CIsHhr6JUFKx16eIJrabZ+hUD4j90CmWnFzKj2Yxe+dCA5+3NZ2QeloTL
 KoVceFUu9VHNFlGGsLZta4tMKeEwTsE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1623669686;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dC3Kd9bVYWvyKEML8i1TkdPjvfwlYAfUWomuYyCdvEA=;
 b=hnlR+/vStjcFvu/Z8Stuo8vYr0sxzKM9OWGGyvT1n/+QO9guEB38gVWQH852Jpychcyhh5
 HBVAfx8Fnj6bD5CA==
Received: from director2.suse.de ([192.168.254.72]) by imap3-int with ESMTPSA
 id phmNG7Y7x2BxDgAALh3uQQ
 (envelope-from <dwagner@suse.de>); Mon, 14 Jun 2021 11:21:26 +0000
Date: Mon, 14 Jun 2021 13:21:26 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCH 1/1] nvmet: use subsys->max_nsid to report MNAN
Message-ID: <20210614112126.aybtimgev7okdkvu@beryllium.lan>
References: <20210614013754.37940-1-chaitanya.kulkarni@wdc.com>
 <20210614013754.37940-2-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210614013754.37940-2-chaitanya.kulkarni@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210614_042129_807033_5091A84E 
X-CRM114-Status: GOOD (  12.19  )
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

On Sun, Jun 13, 2021 at 06:37:54PM -0700, Chaitanya Kulkarni wrote:
> For Spec regarding MNAN value:-
> 
> If the controller supports Asymmetric Namespace Access Reporting, then
> this field shall be set to a non-zero value that is less than or equal
> to the NN value.
> 
> Instead of using NVMET_MAX_NAMESPACES use subsys->max_nsid to set the
> MNAN value.
> 
> Without this patch it results in the following error :- 
> 
> [337976.409142] nvme nvme1: Invalid MNAN value 1024

Is this not the very same patch on which Christoph commented?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
