Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86B3BC76196
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Apr 2023 14:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xLPI3C1EeVbUw6oXyOWF//ALGry4R5vG6k4f/LjCiFc=; b=4ZstpbsGEJY1gEPBZxOG+jGT7c
	Wn4Eqm7D6fhjx4QX+wJF31sjoY52L6li7TlOXbUUhVneefUKNJ6wqEcAzTSlM2cVHRe8zFRjJ1Ndj
	SbsozOMA0kY5+JxdOTGeiZaf0y1nJ1GdtrHIiSs18NXUbvfQgLVuSZR2t/1T0+lQG3dwhggS7nvra
	Y1fGbb7x/TAflrRQvs9O3yfwwkUGkUdHP4ZFVRi5NSnMUGO2mSSimLWQkQJJEN10o9iRxFtibfrl+
	Q3AJJegBZIAzLSKBhd0qfqkKciqC1XvX9NO4v55oBjDfV0+QMfPsasJ5nq8mFB3Gz7uYvoB6YwMjt
	7z50ipFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pjKwS-00Fb8S-1n;
	Mon, 03 Apr 2023 14:13:52 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pjKwP-00Fb75-3D
	for linux-nvme@lists.infradead.org;
	Mon, 03 Apr 2023 14:13:51 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 427F81FFC3;
	Mon,  3 Apr 2023 14:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1680531226; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xLPI3C1EeVbUw6oXyOWF//ALGry4R5vG6k4f/LjCiFc=;
	b=LRopvu8GTBXFVssmbjg2y5PEM5jWraoKsllhavFa0LMNIgXJeSLxl3mTeV7XgNwA9Rfutw
	OggV5CqPq+IO4AX3DUVHC46wxob2kTNPX+/YyP5trKlkn8flLTOYd5Prv1JFUhYN48tukx
	0TpRKBveerajAdW3zNN3YMH9JAtQd7M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1680531226;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xLPI3C1EeVbUw6oXyOWF//ALGry4R5vG6k4f/LjCiFc=;
	b=Dwh+MknTyz0phYk3dPXP3vheJOXAynlK4/7xKj+zrElq/phL+1dtvZnEDDBiVYZoceBUDB
	ZO9pW3CV/5iTPsCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 211E113416;
	Mon,  3 Apr 2023 14:13:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id iafoBhrfKmS5DwAAMHmgww
	(envelope-from <hare@suse.de>); Mon, 03 Apr 2023 14:13:46 +0000
Message-ID: <c7e895f1-1c95-f658-f7a1-c4cee5cf8c91@suse.de>
Date: Mon, 3 Apr 2023 16:13:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 18/18] nvmet-tcp: add configfs attribute 'param_keyring'
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chuck Lever <chuck.lever@oracle.com>, kernel-tls-handshake@lists.linux.dev
References: <20230329135938.46905-1-hare@suse.de>
 <20230329135938.46905-19-hare@suse.de>
 <60ff89b4-5d63-a6db-18b1-e0f28055c5d9@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <60ff89b4-5d63-a6db-18b1-e0f28055c5d9@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230403_071350_177709_7C07190C 
X-CRM114-Status: GOOD (  10.50  )
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

On 4/3/23 15:03, Sagi Grimberg wrote:
> 
>> Add a configfs attribute to list and change the default keyring.
> 
> is the keyring an attribute of a port? or a subsystem? Why the choice
> of making it per port?
> 
As per discussion at fmds each port might want to use different credentials.
We can move it to subsystems if we decide we don't want to support that 
use-case.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Frankenstr. 146, 90461 Nürnberg
Managing Directors: I. Totev, A. Myers, A. McDonald, M. B. Moerman
(HRB 36809, AG Nürnberg)


