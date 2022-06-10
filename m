Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6260C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jun 2022 09:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gqlsvCAiBDzVzN4+AAH/B1IN1CGc4aUObnIJQIU3o30=; b=C8kbhpIYeI9B/tbSze4rWUp2qD
	AMWT7aEQ4op0hThgDFvn6AegU8yN1jhDojzal5SwK+SHRGkeWvywjFfyQ+OaQlrB2vCZTQR8/wx15
	qcPmvo7wgcbnD47+qAC3pKstyJuwan43EbHKjGpive3sgAxjJD9clw20oxpVNn9jvVgQqZecxaK4w
	jXhf7rI7T/ooWwo4hm0DjrVxytqESLiJ7joPsZuRI/MyJeglCk58Md/ypRrdWPahZPYPThORu3Ffd
	1g+ILMdyO9XWXL4boSObTBu96mbR7fYEJCB4W8dhMjZ2wE7+GWiA6tuSh/Z4BtfgF/MhZSHla5SZ2
	1TNgE39g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzbLq-007N83-11; Fri, 10 Jun 2022 09:54:46 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzbBi-007Hv7-2t
	for linux-nvme@lists.infradead.org; Fri, 10 Jun 2022 09:44:20 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9B2DE21DC0;
	Fri, 10 Jun 2022 09:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1654854256; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gqlsvCAiBDzVzN4+AAH/B1IN1CGc4aUObnIJQIU3o30=;
	b=Do1bFhTYZm7hmMsRRw0T4UlNfK6ANuDrqQx7I2guODVieaBML7btxSfYf59vdC/6BJUCRy
	QV192Iu6RtqfxMPxvb1FA93ZjIDGrVEf6zI4kgP7e60GmVshMo34cWMSg2iAnV0fFRHhCW
	lG37iamhHiti5T+k2azT6YkCHeM5pBk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1654854256;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gqlsvCAiBDzVzN4+AAH/B1IN1CGc4aUObnIJQIU3o30=;
	b=eInibW3Ij+Pp84fRTYCRaGHRLG+/eDu+aldWjFoF5ez4iS+5saf0szyhQ//id/E2j26UwY
	Mc1lV28yWPqOpYDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8AEF6139ED;
	Fri, 10 Jun 2022 09:44:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id qdCKIHASo2JoZwAAMHmgww
	(envelope-from <hare@suse.de>); Fri, 10 Jun 2022 09:44:16 +0000
Message-ID: <d4d391fd-1fec-f5bf-d06a-ae6b58993f4c@suse.de>
Date: Fri, 10 Jun 2022 11:44:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCHv14 00/11] nvme: In-band authentication support
Content-Language: en-US
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20220608144518.67607-1-hare@suse.de>
 <bc6d292f-f1f7-3cc4-772b-ef8e2a6466db@nvidia.com>
 <3d2cd533-6bd8-abfa-4df9-40aa6a2eae63@suse.de>
 <7b9bdd9a-1411-ca0d-9f87-71e2c25dffbb@nvidia.com>
 <af8d390c-abd7-d4da-6bd9-99354b2ab2c0@suse.de>
 <c0da59d2-52ab-e219-8610-5f253cde7076@nvidia.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <c0da59d2-52ab-e219-8610-5f253cde7076@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220610_024418_363151_68385E6E 
X-CRM114-Status: GOOD (  18.10  )
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

On 6/10/22 11:28, Chaitanya Kulkarni wrote:
> On 6/10/22 02:12, Hannes Reinecke wrote:
>> On 6/10/22 10:55, Chaitanya Kulkarni wrote:
>>>
>>>>>
>>>>> blktests (master) # ./check nvme/039
>>>>> nvme/039 (Create authenticated connections)                  [failed]
>>>>>         runtime  1.400s  ...  1.707s
>>>>>         --- tests/nvme/039.out    2022-06-08 18:09:06.239931529 -0700
>>>>>         +++ /mnt/data/blktests/results/nodev/nvme/039.out.bad
>>>>> 2022-06-08
>>>>> 18:09:40.596663692 -0700
>>>>>         @@ -1,6 +1,7 @@
>>>>>          Running nvme/039
>>>>>         +tests/nvme/rc: line 269: printf: write error: Invalid argument
>>>>>          Test unauthenticated connection
>>>>>         -no controller found
>>>>>         +no controller found: failed to write to nvme-fabrics device
>>>>>          NQN:blktests-subsystem-1 disconnected 0 controller(s)
>>>>>          Test authenticated connection
>>>>>         ...
>>>>>         (Run 'diff -u tests/nvme/039.out >
>>>>> /mnt/data/blktests/results/nodev/nvme/039.out.bad' to see the entire
>>>> diff)
>>>>
>>>> Hmm. Not sure what has happened here, but all blktests worked on my
>>>> testbed. I'll be rechecking with the latest nvme-cli build.
>>>>
>>>> Which nvme-cli version did you use?
>>>>
>>>
>>> ~ # nvme --version
>>> nvme version 2.0 (git 2.0-96-g0b286b1)
>>> libnvme version 1.0 (git 1.0-62-gaacaeea)
>>> ~ #
>>>
>>> I'm I using wrong version ?
>>>
>>> Can we please add check in the blktests to skip the test
>>> if we have wrong wrong nvme-cli version ? it will help
>>> others to not misdiagnosed the problem...
>>>
>> Hmm. No, that version looks okay.
>>
>> What's the kernel message log? Does it say something about 'dev_loss_tmo' ?
>>
>> If so, can you try with 'export nvme_trtype=tcp' and then running the
>> tests? Previous versions of nvme-cli had issues with nvme-loop, and were
>> trying to set the 'dev_loss_tmo' parameter, which isn't valid for loop.
>>
>> Cheers,
> 
> blktests (master) # nvme_trtype=tcp ./check nvme/039
> nvme/039 (Create authenticated connections)                  [failed]
>       runtime  1.398s  ...  1.397s
>       --- tests/nvme/039.out	2022-06-08 18:09:06.239931529 -0700
>       +++ /mnt/data/blktests/results/nodev/nvme/039.out.bad	2022-06-10
> 02:28:28.077262601 -0700
>       @@ -1,7 +1,10 @@
>        Running nvme/039
>       +losetup: /tmp/blktest-ns1.img: failed to set up loop device:
> Device or resource busy
>        Test unauthenticated connection
>       -no controller found
>       +no controller found: failed to write to nvme-fabrics device
>        NQN:blktests-subsystem-1 disconnected 0 controller(s)
>        Test authenticated connection
>       ...
>       (Run 'diff -u tests/nvme/039.out
> /mnt/data/blktests/results/nodev/nvme/039.out.bad' to see the entire diff)
> blktests (master) # dmesg  -c
> [ 2294.783157] run blktests nvme/039 at 2022-06-10 02:28:26
> [ 2294.829279] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> [ 2294.829568] nvmet: nvmet_ns_enable_store 535
> [ 2294.829573] nvmet: nvmet_ns_enable 555
> [ 2294.829574] nvmet: nvmet_ns_enable 559
> [ 2294.829575] nvmet: nvmet_ns_enable 565
> [ 2294.829576] nvmet: nvmet_ns_enable 573
> [ 2294.832318] nvmet: nvmet_ns_enable 580
> [ 2294.832325] nvmet: nvmet_ns_enable 596
> [ 2294.832327] nvmet: nvmet_ns_enable 601
> [ 2294.832328] nvmet: nvmet_ns_enable 605
> [ 2294.832329] nvmet: nvmet_ns_enable 607
> [ 2294.832330] nvmet: nvmet_ns_enable 610
> [ 2294.833335] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
> [ 2294.840597] nvmet: creating nvm controller 1 for subsystem
> blktests-subsystem-1 for NQN
> nqn.2014-08.org.nvmexpress:uuid:e4f6b1f3-b215-498e-88c0-cfd20c7dee98
> with DH-HMAC-CHAP.
> [ 2294.840641] nvme nvme1: qid 0: no key
> [ 2294.840645] nvme nvme1: qid 0: authentication setup failed
> [ 2294.840668] nvme nvme1: failed to connect queue: 0 ret=401
> [ 2294.857350] nvmet: creating nvm controller 2 for subsystem
> blktests-subsystem-1 for NQN
> nqn.2014-08.org.nvmexpress:uuid:e4f6b1f3-b215-498e-88c0-cfd20c7dee98
> with DH-HMAC-CHAP.
[ .. ]
> [ 2295.105378] nvme nvme1: new ctrl: NQN "blktests-subsystem-1", addr
> 127.0.0.1:4420
> [ 2296.126821] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"
> [ 2296.159534] nvmet: nvmet_ns_enable_store 535
> blktests (master) #
> 
Ah. Found it.
It's just that the output of the nvme-cli command changed. I'll be 
sending a new version of the blktest scripts.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

