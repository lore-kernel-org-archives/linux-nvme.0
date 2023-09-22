Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B6B2CD4F2B
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Sep 2023 08:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DJfuw9D8Q8SVQcNi/Y9NxwRtPgfMr2LRYJ7zesFH1as=; b=xMFpK+fuots7Gvz9MK8VYX6J+5
	OXUENipmrjrerktYRRS1m9CLdivNbhmATrg1MVyAD0eRawFEQLCc0d9UWiBHRZVguhGGuE6HFvHyl
	U5GtoRG9fZ9aSAKratNd+oHtPyN5HRehn0xQEJPJtZ38v4x/qa6lPeswMHzLFjnUSF/ADwcc+nLeE
	MlXVeu6sZ1pay1vxdRcBQaLxTuGmjzJMIbBXfVd9xheXJohhdwN6TIyVOqKaFIqY0UilOOUs6vQgX
	ySkrpKvZesrKvjbEmnUPFeJIoDoQa8EnS603bXrfwmTBzLZkcHvRCkICYvxKr9ocxk9e4iecOIAqB
	2fp775BQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qjbME-008OZF-22;
	Fri, 22 Sep 2023 08:17:50 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjbMC-008OVz-1f
	for linux-nvme@lists.infradead.org;
	Fri, 22 Sep 2023 08:17:50 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0C0641F37F;
	Fri, 22 Sep 2023 08:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1695370658; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DJfuw9D8Q8SVQcNi/Y9NxwRtPgfMr2LRYJ7zesFH1as=;
	b=qs5GreiwfzR4AR78pWOnQAY8KncZbIGVJLu2o9Ok70vI1WexIKDueCRRZl02QaU7O9DEx7
	Ui/+z+atYTVH8HasAWRnlfHeXJY7gfUTJHlFrOnxcOoX8zGNgKjkDA3bfMPPsEXYMIsrID
	NNYWK9m208QEWz/IS8Ae/ehhVL/eRwc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1695370658;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DJfuw9D8Q8SVQcNi/Y9NxwRtPgfMr2LRYJ7zesFH1as=;
	b=5zLbFo83z10CDu+zHO/ufvgymwiNVLpuSB8N0c74Os05IDdcOgd/QHvzMydqLMINtZMO4d
	AqsLKWHVbLRkveCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 49C7113597;
	Fri, 22 Sep 2023 08:17:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id ZvI5D6FNDWWRNwAAMHmgww
	(envelope-from <hare@suse.de>); Fri, 22 Sep 2023 08:17:37 +0000
Message-ID: <2fbed8cd-5d70-4384-a488-c21fc831e4e2@suse.de>
Date: Fri, 22 Sep 2023 10:17:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] nvmet: View subsystem connections on nvmeof target
Content-Language: en-US
To: Redouane BOUFENGHOUR <redouane.boufenghour@shadow.tech>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, kch@nvidia.com, hch@lst.de,
 antoine.damhet@shadow.tech, valentin.brice@shadow.tech
References: <20230920141205.26637-1-redouane.boufenghour@shadow.tech>
 <6596810b-103a-ff18-49b2-7ae5c8d01c38@grimberg.me>
 <CAEjkvFgh9nSbGs0sZOZZdB9TWOtx=i1XE0Q7XjL63fK7TLLjrg@mail.gmail.com>
 <CAEjkvFiHupE6tLjNyxLBTv1Mj76ddAM2zwDLHt5WyqOt-Pogsw@mail.gmail.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <CAEjkvFiHupE6tLjNyxLBTv1Mj76ddAM2zwDLHt5WyqOt-Pogsw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230922_011748_701367_67CBAE00 
X-CRM114-Status: GOOD (  21.86  )
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

On 9/20/23 17:36, Redouane BOUFENGHOUR wrote:
> You can find the path here
> https://lore.kernel.org/linux-nvme/20230920141205.26637-2-redouane.boufenghour@shadow.tech/
> 
> We chose to put the information in the configfs for nvmet which takes
> up the spirit of the "target" module for connection information.
> 
> In my humble opinion, this information would be better located in the
> sysfs so the kernel provides the info to userland. That being said,
> splitting the source of truth for the nvmet module into two separate
> pseudo-fs could generate some confusion which would make it harder to
> users to find all available informations provided by the nvmet module.
> This is one of the reason why in the "target" module this whole ordeal
> is handled by a 2-step procedure: first, userland creates ACLs
> directory (since we can't create a directory in the configfs from the
> kernel) based on an attr filling "dynamic_sessions" and then the
> kernel module fills the info in a dedicated configfs attr page in the
> created directory. (The "target" implementation is available in
> drivers/target/iscsi/iscsi_target_configfs.c in the
> lio_target_tpg_dynamic_sessions_show function)
> 
> To sum it up, I think it all boils down to the question: Do you want
> to maintain some similarities between target and nvmet modules or
> should the nvmet module go its own way and implement this in a
> different way ?
> 
Thing is, 'configfs' is, as the name implied, for configuration. Having 
the driver fill out information is not something the user can nor should 
edit, and as such it's arguably wrong to have this information in configfs.
You do have a point in that this information might be displayed in 
sysfs, but sysfs is pretty tied to the driver model (ie 'struct 
device'). And nvmet does not use 'struct device' internally, so really 
sysfs is not a good fit, either.
debugfs, OTOH, is pretty good fit, as this is information internal to 
the nvmet subsystem. And one can trivially avoid displaying that 
information by simply not mounting debugfs, thereby maintaining
backwards compability.

So I guess debugfs is it, even if it's more work.
Plus you can use the 'seq_file' interface to avoid the page size 
limitation when printing out data.

And I really would like to have this information, too, as occasionally
I've foud to have a need for that information, too.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


