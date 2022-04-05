Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F034AC433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Apr 2022 06:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pH8gABgHlLAgXtPkDnfra8u3rJJin4rnxc4saBlpgto=; b=SiZNCdITZPQEhJRSuwMFT6VlxA
	2nP3XgUdEv4JIj+qLFsfaDwjpoc6vWKwUWU/kOx+wxJnnG8eMzDQ8FSuZ/J6F6LRFcwecGc0Hwmxy
	W7VxgANgtAdRBA8LIHSk55L/AqCNbDW+4BRnUQ7H1iH8GNaeYVMt7+101/H12rfy6Qi1taC6wbhDb
	c/7zzc7qvAUpE/YXoeVLxn3gMZvSfFIJvv95cwiwRCa8iCn3e+CbLkRxuFh64dQr0f1tWgZs34RHy
	ma0ERSe0BWUqSqK0kGOEBx8RA4mv5uzKwFTyBwsarhRer8rPMHtcAdhV0+1UXOZvm7I8tHOtSXHO/
	a/XmQzoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nbcTt-00HHSY-MN; Tue, 05 Apr 2022 06:15:57 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nbcTp-00HHS1-VT
 for linux-nvme@lists.infradead.org; Tue, 05 Apr 2022 06:15:55 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 41CBC210FC;
 Tue,  5 Apr 2022 06:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1649139352; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pH8gABgHlLAgXtPkDnfra8u3rJJin4rnxc4saBlpgto=;
 b=EUWQUVTwozlRVV6zCU/Sj7EupGrZokulFtei2IvTU06x0hghrw9QpVrFheNxm9ZHeLZmBQ
 5et/IFQ2TcGEwakiHRow/25mQRUvEO4IXD07MqfvrcLo4qB4/64DZncDUliEQ/b7Pum1Jy
 K6QDry2vcweh/2VYXjNuw6E3hub5qWM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1649139352;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pH8gABgHlLAgXtPkDnfra8u3rJJin4rnxc4saBlpgto=;
 b=gbEppcpXvMSh3S4Fus2fC9P1oSiMDAAre0m9qZKRNtSIfHWa7jFd+a9ieAqVQKx8R8rK+Y
 5yF7gVlGs7HX+7BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1B4E0132B7;
 Tue,  5 Apr 2022 06:15:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ftEzBZjeS2JRUgAAMHmgww
 (envelope-from <hare@suse.de>); Tue, 05 Apr 2022 06:15:52 +0000
Message-ID: <a129df40-6195-8b59-aa76-e3053e0960fd@suse.de>
Date: Tue, 5 Apr 2022 08:15:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 3/3] nvmet: include all configured ports in discovery log
 page for unique discover controller
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>
References: <20220317142634.49324-1-hare@suse.de>
 <20220317142634.49324-4-hare@suse.de> <20220405054601.GC23466@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220405054601.GC23466@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220404_231554_202344_965D5C7E 
X-CRM114-Status: GOOD (  10.79  )
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

On 4/5/22 07:46, Christoph Hellwig wrote:
> On Thu, Mar 17, 2022 at 03:26:34PM +0100, Hannes Reinecke wrote:
>> When an unique discovery controller is configured we should be reporting
>> all configured ports, and not just those which are reachable from the
>> current port.
> 
> Why?

To make it configurable.
Unique discovery controllers show up in configfs just like any other 
subsystems.
And with that we need to clarify the relationship between the discovery 
subsystem and the other subsystems, ie which subsystems should be 
presented by this discovery subsystem.

Linking the discovery subsystem into a given port makes it obvious that
a) this port will be presenting a discovery subsystem
and
b) that the discovery subsystem will be presenting all subsystems 
configured on that port.

The built-in mechanism for discovery subsystems was okay as long as the 
discovery subsystem was built-in, too.
But with this patchset we're moving to an explicit configuration.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer

