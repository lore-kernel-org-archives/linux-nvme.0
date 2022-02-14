Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE350C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Feb 2022 13:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:Subject:From:References:To:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2W3jXde9AK8jQYLgLG82+wVWF6MufyAXlry9SmwpNjY=; b=WW/6JOT9+EyvJHK54NZAJAHlHr
	M750VOcu3zn8/bU2PwjWx+gfEmr/6cs8NtqvH3a6/FnTY6vc9UOm+1EeTlunFOgR9PB52VS0Xruqk
	Sf57cY2eHieunbiuK9YvFSu3v8/2G/ERuveDdOCRs3FXzU9RPUSZRa3Iuh7yjRtyq8sYIHM35o0Xr
	N/TE8rhSupIK53uR9iSrYNqdhjXxDdENEjDe1lw/oVJiBI7t8+oeJY5kzzF2GZmMqkJeGur45MdH1
	CuODcdBdfE2cx/PG+HpdXo8hwwD3GTCtCiIVOuOhVX9t1eLsVNwf6OMAVALcizAMSlFTzy6+DYcTi
	O/OGnn8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nJbE5-00FP3d-PA; Mon, 14 Feb 2022 13:17:09 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nJbE1-00FP1m-CI
 for linux-nvme@lists.infradead.org; Mon, 14 Feb 2022 13:17:08 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0ECCD1F38A;
 Mon, 14 Feb 2022 13:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1644844616; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2W3jXde9AK8jQYLgLG82+wVWF6MufyAXlry9SmwpNjY=;
 b=z/D3rT7F+zzhL1ih6BIBBo1jTVowj1TmFxPDoS+4JnJsfHtijRv7301D6QAYzr1Y4m81YG
 EcXpFN0vO+098e+mki1Vx1sPAgw5M0L/S34hXzfx0pkpb5BCXWeZU1HOkjOrAET3OyaLdf
 fpoIyBbehcIDnlrBYyU0CtpdsyqFF7k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1644844616;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2W3jXde9AK8jQYLgLG82+wVWF6MufyAXlry9SmwpNjY=;
 b=KPFTY2FPIm9MJI9S8S7qHwhLAqCZOhkQXzS3yGw+LJFhyItRJ+Kt6uIInD073zmHYAJeG9
 o230xcVB1l01OXCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F27B413B2B;
 Mon, 14 Feb 2022 13:16:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id T5myOkdWCmImIQAAMHmgww
 (envelope-from <hare@suse.de>); Mon, 14 Feb 2022 13:16:55 +0000
Message-ID: <4cd1f9c1-e31a-2a41-1f96-ba54103cc3a2@suse.de>
Date: Mon, 14 Feb 2022 14:16:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To: Alex Talker <alextalker@yandex.ru>,
 linux-nvme <linux-nvme@lists.infradead.org>, Sagi Grimberg
 <sagi@grimberg.me>, "Knight, Frederick" <Frederick.Knight@netapp.com>
References: <3fec0f6d-508c-c783-1779-a00e43fa2821@yandex.ru>
 <9a765265-0200-0eea-872f-780c4dbb69b8@grimberg.me>
 <02375891-2f92-c3d9-8a55-019b84c14c1c@yandex.ru>
 <205b91c3-4da1-744d-3d06-ccfdf2b93cff@grimberg.me>
 <5b5cfff7-6c07-0cb1-491a-0fa3d13c2cbd@yandex.ru>
 <fd8600bd-aa73-82f7-3ca7-ed7f766f1568@grimberg.me>
 <DM8PR06MB770480F38397C8FE8D4D0F22F1309@DM8PR06MB7704.namprd06.prod.outlook.com>
 <3de626e3-4d03-50a8-9bd2-c974227add02@yandex.ru>
From: Hannes Reinecke <hare@suse.de>
Subject: Re: NVMe over Fabrics host: behavior on presence of ANA Group in
 "change" state
In-Reply-To: <3de626e3-4d03-50a8-9bd2-c974227add02@yandex.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220214_051705_591861_0E7D7323 
X-CRM114-Status: GOOD (  24.19  )
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

On 2/11/22 10:21, Alex Talker wrote:
>  > [FK> ] I think I'm missing a bunch of context here. What is the
>  > original question? I take a stab at some assumptions: What is an
>  > empty ANA group? That is an ANA Group with NO NSIDs associated with
>  > that group. Meaning the "Number of NSID Values" field is cleared to
>  > '0h' in the ANA Group Descriptor. That descriptor can be used to
>  > update some host internal state information related to that ANA
>  > group, but it has no impact on any I/O because there can be no I/O
>  > (since there are no NSID values). So I'm not sure where that is
>  > going (because RGO=1 also can return ANA Groups that have state, but
>  > no attached namespaces (it's a way to get group state without any
>  > NSID inventory requirements)).
> 
> That's exactly right, "nnsids=0" case. I/O is not a problem for such a 
> group, for sure.
> I suppose the main argument we're having here is that when such a group 
> has a "change" ANA state, the host("nvme-core" module) starts a timer
> for ANATT which upon expiration resets the controller.
> Now, I do not disagree that having such a group is "ugly" but rather 
> argue that ANATT-related functionality could be only invoked for 
> "nnsids>0" case, since only then there's a relation between "change"
> state and a namespace via "ANAGRPID".
> 
Ah. So now I get where you are coming from.

The problem seems to be around a static ANA group with status 'change'.
The whole idea behind the 'change' ANA status (and ANA groups in 
general) was that ANA groups could _change_ the ANA status, and such a 
change would affect all namespaces in that group.
 From that angle having a 'change' state makes sense, as one could use 
them to signal "hey, I'm busy transitioning to another state" to the host.

But when using _static_ ANA groups the whole concept become shaky.
While it's perfectly okay to have static ANA groups with 'normal' states 
(ie excluding the 'change' state), things become iffy if you have a 
static 'change' state.
Thing is, having a 'change' state indicates to the host that a 
controller will need time to transition between states. And this 
transitioning out of necessity will always be between 'normal' ANA 
states (ie excluding the 'change' state).
The spec doesn't allow the controller to specify "I need time to 
transition _to_ the 'change' state"; the transition to and from 'change' 
is always assumed to be atomic.
(Because the 'change' state is used to signal precisely that condition.)

Exec summary: having static ANA groups is okay, having a static ANA 
group in 'change' state questionable and not something I would recommend.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

