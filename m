Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5AC6C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Feb 2022 12:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1ImskptqTlGdUg+ZXkVAnR83VfXchWHbgmWNgyYYr+0=; b=4TZn0OHyTUZPLr82k8DrsG5IKe
	5A3JbkflxldWTK5x3acTxmolMIKwSU3NUY0OA9APAfu8NBBgRPgfAdlrjdvFjFsrhqYWcojMDu2Mf
	d/FvJUTCxzwOd+A6ihvRNnJ9BRBWI1h7o7OAe7XvK/crsgt9gHsOgjKGeZiSL3qOrLK1NW0sQGBEn
	Si1An3K7y+o6c02vp/W6BpodeGdkDrwyAmOdxMRBQd8+prYVhxqzTPvRNWu7fL2rx+X117cFHQLs3
	CDANJkAwdoRiVzCaatVeSBcWWCqCUJbAKVwggSTWhP5kkpjNTViHxlNecok2SXu5kWWLSZZWmWVMg
	jJdA7rgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nMTrn-009UXz-6p; Tue, 22 Feb 2022 12:02:03 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nMTrk-009UVJ-EU
 for linux-nvme@lists.infradead.org; Tue, 22 Feb 2022 12:02:02 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CC34D1F39A;
 Tue, 22 Feb 2022 12:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1645531313; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1ImskptqTlGdUg+ZXkVAnR83VfXchWHbgmWNgyYYr+0=;
 b=KWKN+JJzWQGHjlf2bHk+tZ/9uXeD0o+NvhRDL70FRXj0OwuhZg6i0Zt/jUMVIRG0JhxIr3
 UQ5Hb5OocrUaZFeSvYPDEDPlawp2TJbV/mJFueO5206ista5CT9Vtbd9JuzbEPcJIxGoW2
 rRtp70+05LpB3uJrEg7+LGfJZP5ScZU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1645531313;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1ImskptqTlGdUg+ZXkVAnR83VfXchWHbgmWNgyYYr+0=;
 b=mqHG/+WYDuhdODnhDF7c4k1MbgNdu1EjGySLsAGxdd3KpAqHrH1u/p3O3kmdTo9YqA287K
 0UjVGS/7or0u0nDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B3D9813BA0;
 Tue, 22 Feb 2022 12:01:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 9ItNK7HQFGKwLwAAMHmgww
 (envelope-from <hare@suse.de>); Tue, 22 Feb 2022 12:01:53 +0000
Message-ID: <9f61f02b-4bf6-996e-bc4a-83d31c4ad1ac@suse.de>
Date: Tue, 22 Feb 2022 13:01:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] nvmet: parametrize maximum number of ANA groups
Content-Language: en-US
To: Alex Talker <alextalker@yandex.ru>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20220222085522.296465-1-alextalker@ya.ru>
 <6aef5693-1ef8-45f1-741e-541cd5fdd98d@nvidia.com>
 <0500b120-4168-4981-0be5-164222a6eeed@yandex.ru>
From: Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
In-Reply-To: <0500b120-4168-4981-0be5-164222a6eeed@yandex.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220222_040200_668934_507BF6B2 
X-CRM114-Status: GOOD (  31.24  )
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

On 2/22/22 11:25, Alex Talker wrote:
>> Please no module param for this, right place is configfs subsys
>> attr.
> 
> Did you meant port attribute? Since the value mainly makes sense there.
> 
No, I _did_ mean the subsystem.
anagrpmax and nanagrpids are values in the identify controller data, and
will need to be derived from the subsystem values.

Also, the port merely controls which ANA groups are visible through that
port. It does not define how many ANA groups are present, as strictly
speaking this is a per-subsystem value, and it might well be that not
all ANA groups values are available through all ports.

> The main obstacle for me here, since again,
> i wanted to keep the change as simple as possible,
> is the 'nvmet_ana_group_enabled' "array".

And my suggestion is to keep that, with the difference being that each
subsystem can restrict how many ANA groups they will be using.

> I have a real doubt that I do understand what it is for much
> but the main issue would be if maximum number of ANA groups would
> differentiate per-port,
> then how does one pre-allocates such an 'array'?
> What this should be refactored to then?
> 

Primarily the patch will be introducing eg a per-subsystem
'attr_nanagrpids' configfs attribute. That will be set to
NVMET_MAX_ANAGRPS initially.

And then the 'nanagrpids' value will be used as the upper limit for
iterating in nvmet_execute_get_log_page_ana().

And when creating the 'subsystem' link in the configfs ports directory
we need to check if the ANA group IDs in the port matches with what the
subsystem declares, and refuse the link otherwise.

>> Also, if you are doing this please make sure to write a block test
>> for these two configfs params, since it definitely adds a code that
>> user input might missuse with invalid numbers.
> 
> Could you please give me an example of such a test?
> 
See above. You'll need to add a check in nvmet_port_subsys_allow_link()
to check the ana grp ids in the port against the maximum number of ana
groups as specified by the subsystem.

> And...
> 
>> We should keep anagrpmax a compile-time default, and have 'nanagrpids'
> a per-subsystem configfs setting. That way we can limit the memory
> requirements on the connecting host (as it can/will size the ANA log
> buffer by nanagrpids), and have the value configurable per subsystem.
> 
> Would that imply that ANAGRPMAX would be set to less than the maximum
> possible value? If so, which reasonable value do you think will fit?
> 2^16 or more?

Yes, I would have it less than the possible value, as there might be
implementation rely on that value to size internal structures, and we
don't want to overload them. I would put them at 1024, to have a nice
round number.

> Again, why 'nanagrpids' would be a subsystem attribute if validation
> comes into play(for creation of ANA group) on the port level at the moment?
> And the same issue as before, what to do if the value decreases while
> groups are in use? Deny the change?
> 
As mentioned, this is to reduce the memory consumption on the host side.
Linux is using nanagrpids to size the ANA log buffer, so if we put an
arbitrarily large number in here we'll end up having a massive memory
allocation just for the ANA log buffer (we've measured an order-7
allocation with one particular installation). And by allowing to have a
lower number here we'll get both, supporting large installations _and_
reduce the memory consumption.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		        Kernel Storage Architect
hare@suse.de			               +49 911 74053 688
SUSE Software Solutions Germany GmbH, 90409 Nürnberg
GF: F. Imendörffer, HRB 36809 (AG Nürnberg)

