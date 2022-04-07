Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B4DDC433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Apr 2022 10:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:Subject:From:References:Cc:To:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gUlW3vy8nwh4Mnyiag+ZXgLVq84szdiK2fYNjIQBdNE=; b=DBaqXyJZlnH2xeO7Zk0yOfIEB2
	3wUbuQZ08LQk/YgsSByykrkbI9GmgxzZ8ByBV+cKNc/uwea7fEKSdewYB2x4ugzF+KnOdurNUvSYj
	RxF1hPhTbsWxXvUKie4P0EY77b9TyqAPMRzAyW4exy3PVE/TOVd2uvvvtKxilQJiyzOhjD7e14gTd
	d9xIn3/ECLmZn8eX9PRFd0okWfUGfRA7Qi0dz4eswSdYw10WlKEIsY5f3gN8TB54CRagMYwj2NDJG
	KXPOL/+vqQcNeXE1/U2r9ZMXejzTAcnayqXJ6nB4NBky/Lz6N0zeFfHjXnNBy51EcLrO0FSQsOxxg
	Lq707I7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ncP9M-00B9la-FA; Thu, 07 Apr 2022 10:14:00 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ncP9I-00B9kt-8b
 for linux-nvme@lists.infradead.org; Thu, 07 Apr 2022 10:13:57 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1CE8B21122;
 Thu,  7 Apr 2022 10:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1649326434; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gUlW3vy8nwh4Mnyiag+ZXgLVq84szdiK2fYNjIQBdNE=;
 b=BvWO7AWM69udP/vDVmvggBZekeBhYCVQd0UX69LoX5+6VsK6Ry8zjb/+4epLSZmRJDtXNm
 h6ag4C4PDfc26ogUeZXjcPIEtmNGoPsx7q8qWITLtslt3PcE674ChSbE8dD24DOKkvY8rT
 Je8MwCXfAdH5JW5EUR77uWZYidQXSys=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1649326434;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gUlW3vy8nwh4Mnyiag+ZXgLVq84szdiK2fYNjIQBdNE=;
 b=iLdbAp1NKo/gQTmF9EeKomMcI64P4z07vHY6cP1ga+jDZlcure0WztQOAVJE7edhGYYy9r
 nL9Cy6c86KQLfHAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0FACB13485;
 Thu,  7 Apr 2022 10:13:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id oHl+A2K5TmL5RAAAMHmgww
 (envelope-from <hare@suse.de>); Thu, 07 Apr 2022 10:13:54 +0000
Message-ID: <99db949a-b390-c6d2-9c66-5341bbbb4070@suse.de>
Date: Thu, 7 Apr 2022 12:13:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20220406142210.71248-1-hare@suse.de>
 <20220406142210.71248-3-hare@suse.de> <20220407094537.GA23413@lst.de>
From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 2/3] nvmet: expose discovery subsystems
In-Reply-To: <20220407094537.GA23413@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220407_031356_485981_D73E17FC 
X-CRM114-Status: GOOD (  11.55  )
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

On 4/7/22 11:45, Christoph Hellwig wrote:
> On Wed, Apr 06, 2022 at 04:22:09PM +0200, Hannes Reinecke wrote:
>> Add a module parameter 'expose_discovery_subsys' to allow creation
>> of discovery subsystems through configfs.
>> If the option is enabled no default discovery subsystem is created
>> per default, and the user is required to create one via configfs.
> 
> I'm not fan of module parameters.  Can we do this using configfs on a
> per-port basis?

configfs: yes.
per-port: we could, but then we cannot configure the default discovery 
subsystem. But we can't do that anyway. I'll give it a shot.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

