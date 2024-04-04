Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CA25CD1284
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Apr 2024 08:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aOCHfZV2to3mP9ulNHVH8wnZcCwje64b6rHU6KARrEU=; b=F0waUQpZ3W12798t0yoqobW/GP
	aEmDcom5IBiTqbg5K1ySjSnQtWiydPrDc8x0Z8NO71EOG814U1b/v+w8KVilW8kJ2F+2K4inyJoTy
	HLHlToIGSWVs/1DHrc8c+wHTeaLbFnvSXE2gu4rmtBbtek0ApKj0yifdBwBDD2E2dcPEAglkFuDUg
	PAJtZU62RH1fmShG8oAVWTG5LN9uqIzTdXFs0WcJfm+sTQhcATOudPm0K7dWW07LHpl7IU2am+55q
	nV8WEh3ROd7rLg/0f44bzKIJ/ryPC4NDq6xOo0Es2+cSOHrHXbKG+G/75gl5iIHS47Tu2uvGmngrx
	TSJaM84A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsITE-00000001qYP-2p60;
	Thu, 04 Apr 2024 08:29:16 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsIT8-00000001qXU-3y1r
	for linux-nvme@lists.infradead.org;
	Thu, 04 Apr 2024 08:29:14 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D8B8B37712;
	Thu,  4 Apr 2024 08:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712219348; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aOCHfZV2to3mP9ulNHVH8wnZcCwje64b6rHU6KARrEU=;
	b=uidFzKy6N75OzaBZMpY/shM1UkBze+Ow1P07dBbgPdMN+Elvcii0FzCPbKVfd+E8K8gEZ3
	XaFbq1qR0BJTyqpllvW44b3IMyiN8BzBOhnux7F+5O04nWKm5rxpOyyricIy9HemgD45fu
	5KMHAXEIMnThLMdAPCfhluCLFYfWv8A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712219348;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aOCHfZV2to3mP9ulNHVH8wnZcCwje64b6rHU6KARrEU=;
	b=91gAsNjjmgvrTqfsJjCpkTX2w9dnMBSUNMW2b/Q4nnK8cblm/E0GvN5gynshjiE58fK9e6
	9JDM9rpv5/rwCiAA==
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id C686A13298;
	Thu,  4 Apr 2024 08:29:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id PekAL9RkDmbyDwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Thu, 04 Apr 2024 08:29:08 +0000
Date: Thu, 4 Apr 2024 10:29:08 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Chaitanya Kulkarni <chaitanyak@nvidia.com>, 
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v1 0/3] add blkdev type environment variable
Message-ID: <j47jtsnraylush4xlxu6sng5frrawim5j2vjwt7zgei7jwi7ke@7ga6dd5sssur>
References: <20240402100322.17673-1-dwagner@suse.de>
 <mqpuf2a7obybtw42ydte2wq7ktema5odvc3dqm32hknjmamgdb@rbo3i6lqqkld>
 <j6awxljufwg6r5rs5kojwsnatfb4aj3vnqsq43hkuuhgvcflvh@u6l5cf2ponaw>
 <w2eaegjopbah5qbjsvpnrwln2t5dr7mv3v4n2e63m5tjqiochm@uonrjm2i2g72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <w2eaegjopbah5qbjsvpnrwln2t5dr7mv3v4n2e63m5tjqiochm@uonrjm2i2g72>
X-Spamd-Result: default: False [-3.80 / 50.00];
	 ARC_NA(0.00)[];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.996];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240404_012911_163198_A5E8BE05 
X-CRM114-Status: GOOD (  24.26  )
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

On Thu, Apr 04, 2024 at 07:43:28AM +0000, Shinichiro Kawasaki wrote:
> Actually, similar feature is implemented in the common code so that some
> test case can be run twice, once for regular the block device, and one more
> time for the zoned block device. You can find test cases with CAN_BE_ZONED=1
> flag. They are run twice when RUN_ZONED_TESTS is set in the config.
> 
>    To be precise, this applies to the test cases with test() function.
>    CAN_BE_ZONED has different meaning for test cases with test_device().
> 
> Now we want to run some of test cases twice for the two nvmet block device
> types. This is essentially common feature as the repeated runs for the
> CAN_BE_ZONED test cases. I think it's time to generalize these two uses cases
> and support "repeated test case runs with different test conditions".

Sounds reasonable.

> > requires() = {
> > 
> >  _nvmet_setup_target
> > }
> 
> Hmm, I think this abuses the hook. IMO, it's the better to introduce a new hook.

Indeed :)

> >
> > What do you think about this idea?
> 
> It sounds an interesting idea :) I prototyped the common code change based on
> the idea and shared it on GitHub [*]. It introduces two new config arrays
> NVMET_BLKDEV_TYPES and NVMET_TR_TYPES. When these two are set in config file as
> follows,
> 
>   NVMET_BLKDEV_TYPES=(device file)
>   NVMET_TR_TYPES=(loop rdma tcp)
> 
> it will run a single test case as follows. 2 x 3 = 6 times repeptitions.
> 
> $ sudo ./check nvme/006
> nvme/006(nvmet dev=device tr=loop)(create an NVMeOF target)  [passed]
>     runtime  0.090s  ...  0.091s
> nvme/006(nvmet dev=device tr=rdma)(create an NVMeOF target)  [passed]
>     runtime  0.310s  ...  0.305s
> nvme/006(nvmet dev=device tr=tcp)(create an NVMeOF target)   [passed]
>     runtime  0.149s  ...  0.153s
> nvme/006(nvmet dev=file tr=loop)(create an NVMeOF target)    [passed]
>     runtime  0.138s  ...  0.135s
> nvme/006(nvmet dev=file tr=rdma)(create an NVMeOF target)    [passed]
>     runtime  0.300s  ...  0.305s
> nvme/006(nvmet dev=file tr=tcp)(create an NVMeOF target)     [passed]
>     runtime  0.141s  ...  0.147s
> 
> I hope this meets your needs.

Yes, this is very useful.

> [*] https://github.com/kawasaki/blktests/tree/conditions

 I quickly looked into the changes. The only thing I'd say it looks a
 bit hard to extend if we have yet another variable. But maybe I'd make
 it too complex. I don't think we have to be too future proof here,
 because we can change this part without problems, it is all 'under the
 hood' and doesn't change the 'user interface'.

Great stuff!

