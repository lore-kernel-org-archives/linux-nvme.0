Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73687CD1284
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Apr 2024 09:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Kp/FvpFPW5dVoP6/BFNwzJCSZj85wgWx7zWptbsIJ4E=; b=gGFHKqx7DE1uFVlgw+I/SILTUo
	BS6OL7eycM+i/6wjwKNoqpHL9btc3MBkV99xjrS3tUat5OlC8p0OAR4TK6c4U/RfZHzs7pUKIkbQ9
	AwUJoZvT901u3aLjnivgV263X5MpR/iSXDQsFvpUBvZ6iiWK1XAOB11lnRzVb2uQbEfpwxUWlQzKa
	9z4zl1mQ+HccAbeEmFHB0s1jL8j8EDvEdrc53Kwo254hYi/4Ee/m1cTMKeHFSXSSRrQCCgUTb7tLv
	xFI6rmnvuIT14X27i4JnWRSIfIgVaWeyNcop2JpqLuHIY7yvOKAQrAicu6msAvf8DoK6mj/92rVh3
	Q5ILoDsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rraOD-0000000AQbO-33DV;
	Tue, 02 Apr 2024 09:25:09 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rraO8-0000000AQUa-0p8m
	for linux-nvme@lists.infradead.org;
	Tue, 02 Apr 2024 09:25:08 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B613020EBB;
	Tue,  2 Apr 2024 09:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712049874; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kp/FvpFPW5dVoP6/BFNwzJCSZj85wgWx7zWptbsIJ4E=;
	b=c3w1GWRaL477TdP1sqjSvk5MD7Uq3gyl6b0nKgE7KOg9jmVCHSGbzU2JV3wUHTkSvFPV9i
	RvStsxIHHbRJ2CMjAQzYqTGUVQJ/z+vMT9YU0GFBAvhBCTVzV5n3+Qv5qG4gbp2SWKRH5R
	Fu7YV24fIPE67vw6wXD2mMqwebrMflE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712049874;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kp/FvpFPW5dVoP6/BFNwzJCSZj85wgWx7zWptbsIJ4E=;
	b=4uBHXfwmxCv66vY05D9tqSZsj6GPyeKWjxAvXgEJ3qTCHoDHAI8jPmSki568pdvQTcQGha
	/IMHPQ+D8eTvELAg==
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A72B213357;
	Tue,  2 Apr 2024 09:24:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id AUVPKNLOC2YCewAAn2gu4w
	(envelope-from <hare@suse.de>); Tue, 02 Apr 2024 09:24:34 +0000
Message-ID: <80485684-0ab2-4cac-afb5-45c1a3fe34bb@suse.de>
Date: Tue, 2 Apr 2024 11:24:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: nvmetcli FC transport problem
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, =?UTF-8?B?xYF1a2FzeiBLb2rFgm8=?=
 <l.kojlo@sibersoft.pl>
Cc: linux-nvme@lists.infradead.org
References: <e7be9608-7e1d-4da3-985b-644b66443dec@sibersoft.pl>
 <ak47crahgtdwhb2ecc22eseidltasw2sppbrq2ik57r6raal5f@n67q7wbbl7jr>
 <a6ca5502-d25d-4add-9a55-65c0f5baa78a@sibersoft.pl>
 <oe5bodi7vgcg2e5xux5tasusbgpcwo4um72q5gqevmm5egs2ka@bqgol4qhzm7b>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <oe5bodi7vgcg2e5xux5tasusbgpcwo4um72q5gqevmm5egs2ka@bqgol4qhzm7b>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.55 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-0.26)[73.50%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240402_022504_423344_CF691900 
X-CRM114-Status: GOOD (  11.46  )
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

On 4/2/24 09:26, Daniel Wagner wrote:
> Hi,
> 
> On Fri, Mar 29, 2024 at 10:22:42AM +0100, Łukasz Kojło wrote:
>> */ports/1/subsystems> create test
>> Could not symlink test in configFS: [Errno 6] No such device or address:
>> '/sys/kernel/config/nvmet/subsystems/test' ->
>> '/sys/kernel/config/nvmet/ports/1/subsystems/test'*
>>
>> Nothing in dmesg
>>
>> FC card I'm using it's QLogic QLE2740
> 
> I've tried once to get a P2P setup with QLogic cards but failed. IIRC,
> I run into troubles with the QLogic firmware not be able to act as
> target. I'd suggest you enable the debug logs of the qla2xxx driver.
> There might be a hint what's going wrong.
> 
Quite simple: the qla2xxx driver doesn't support nvme-target.

There was a patch once, but never made it upstream. Blame Marvell.

Cheers,

Hannes


