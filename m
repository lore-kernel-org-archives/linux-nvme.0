Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB60C433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Apr 2022 06:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t5DsShxB7fFE1BkVceaVHmsVR3A3dHmWPPZNFepIb7Y=; b=x+9260574R1HW5Z39GNdyvvluu
	exn4GHu2PWbyELSabUnaVLLggs/fuBWdO8CdNT4BBx8ovzCKzo4RN6rWpV9Lsi0NuOVa7LYJ+eWwm
	0dSjT2UCub+v0BHua1B2onc9GveLqG9SWq35zuLVVjYw1nZojqvWDCPWQlLQOW/pAzlqEqIM7lCtz
	oOL/Bb4TZ3uFXlOzWdr2NcnGMp/FyXUKdVzfEMcNYXhoPIHujl+h8MerhwL32ZU5an8D9AKX0NdPs
	S7wUqVkOK8WNwBEWTeXNlSgUXHxoDDushbOXUb5KpMHe4GPimP1+BAbv/QEAXXO70TsDZpXrvvczw
	9M84dm7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nbcEx-00HEmO-Q6; Tue, 05 Apr 2022 06:00:31 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nbcEu-00HElI-FG
 for linux-nvme@lists.infradead.org; Tue, 05 Apr 2022 06:00:29 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BDDEB21100;
 Tue,  5 Apr 2022 06:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1649138426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t5DsShxB7fFE1BkVceaVHmsVR3A3dHmWPPZNFepIb7Y=;
 b=e1eUOH7Ol/JCY1j+b1Ua/gc6KMvVCW5JWAKBHhrK2lQhjiVT3uQ7lSkoqCWBZdj6P9gu5I
 S3xrgLUrbik7PDpY02Agon0LC8RfvKHXLvxHFZwQEQ8rH4iR6g5BCHRX0CbbWc6dcKgswh
 VATpZJKeeJ2/C06x/u0OxjBuWE4qYZw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1649138426;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t5DsShxB7fFE1BkVceaVHmsVR3A3dHmWPPZNFepIb7Y=;
 b=JpRsvTg3Vn96OMc5uLryCz0MhtBx9YkRYcy3F+GvDMINuO2yEV7BtRQWAmNQWvD7prS0Td
 MnSxlz8b6ZRU6eAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 827E813522;
 Tue,  5 Apr 2022 06:00:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +YcBHfraS2KVTAAAMHmgww
 (envelope-from <hare@suse.de>); Tue, 05 Apr 2022 06:00:26 +0000
Message-ID: <3d773039-ce36-277f-34c5-e0530567c4d3@suse.de>
Date: Tue, 5 Apr 2022 08:00:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 2/3] nvmet: make the subsystem type configurable
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20220317142634.49324-1-hare@suse.de>
 <20220317142634.49324-3-hare@suse.de> <20220405054740.GD23466@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220405054740.GD23466@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220404_230028_692365_0073861D 
X-CRM114-Status: GOOD (  17.42  )
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

On 4/5/22 07:47, Christoph Hellwig wrote:
> On Thu, Mar 17, 2022 at 03:26:33PM +0100, Hannes Reinecke wrote:
>> Make the subsystem type configurable to allow for unique
>> discovery subsystems by changing the subsystem type to
>> 'discovery'.
> 
> Does it make sense to change the type?  Or should we have a new top-level
> interface to create and configure discovery subsystems from the start?
> 
> If we had e.g.
> 
> /sys/kernel/config/nvmet/discovery-subsystems/
> 
> we could start that out with a pre-filled well known discovery subsystem
> but also allow disabling that for example if we really want.

I actually looked into that with my previous attempt, and really found 
no good way of having an entry which is
a) pre-filled
and
b) removable by the admin later on.
 From what I've seen all pre-filled entries are static; I haven't found 
a way to do pre-filled dynamic entries.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer

