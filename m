Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D1EAC0218D
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jan 2025 17:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Subject:Cc:To:From:Message-ID:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5GnOF+VEY7TThX1eeQY6brGBNSRNv8obohwk3AJ667M=; b=QTjjBu9R3KuMUUO0V/z64AmqnX
	k3oeNHWGBv50MoDy6YBhCLqDaw0MX/Gel4PkwatGIMiqXAn/LB0GsMBTDmOCUMzmD7f4aq7a5BAla
	FkMcC2ufsa30zRTF1kwEwoC464SXq07Mhy3Fl2I3psrVc9nR3jsfLFvuda4hs94ct+Ayn3P2bFmlL
	Q+r+p9bxtPoCmnjJa2W7KfrjmDmRF+9B3iKbXc1CZ9Z5xodoMfbZUBg6F2EnD9U3uhW1w4LOV0meA
	vEu4JZRU0u2Tgh4zs4rM/pJcH2tSrIlB+fsf7xxmucsJBubUYzBA27V4KyQkma9LDIEqS6PDCbQv+
	kOSHdpMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tdC15-00000007VXv-0vCU;
	Wed, 29 Jan 2025 17:38:19 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1td4ev-00000006g1F-3xY6;
	Wed, 29 Jan 2025 09:46:59 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B8E0D210F5;
	Wed, 29 Jan 2025 09:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738144014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5GnOF+VEY7TThX1eeQY6brGBNSRNv8obohwk3AJ667M=;
	b=i5Mwxy/RNBFOPwFWyefOclI67Mfl4LeClU7BnbzMU2Z49ioZnnFhEdIes2aDRWIG5Qpb0p
	rLBunYuvEC7qM4x5OkOhkaKWeK+V8WjsDgKTMLf0D51Ecutz5uFtjpJqDsgAbMqJDTQ7GK
	s83Yq9bri99hD1Q5u+s3qZtg9o5bDOg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738144014;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5GnOF+VEY7TThX1eeQY6brGBNSRNv8obohwk3AJ667M=;
	b=pmRhPydCZ+RgrhzOPZu1wdQVPJGdMmu2lFLf4y8etatrnARzlhrJMUPMdZgyI5WSug4evo
	LP9tmUY05JKAOgCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738144014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5GnOF+VEY7TThX1eeQY6brGBNSRNv8obohwk3AJ667M=;
	b=i5Mwxy/RNBFOPwFWyefOclI67Mfl4LeClU7BnbzMU2Z49ioZnnFhEdIes2aDRWIG5Qpb0p
	rLBunYuvEC7qM4x5OkOhkaKWeK+V8WjsDgKTMLf0D51Ecutz5uFtjpJqDsgAbMqJDTQ7GK
	s83Yq9bri99hD1Q5u+s3qZtg9o5bDOg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738144014;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5GnOF+VEY7TThX1eeQY6brGBNSRNv8obohwk3AJ667M=;
	b=pmRhPydCZ+RgrhzOPZu1wdQVPJGdMmu2lFLf4y8etatrnARzlhrJMUPMdZgyI5WSug4evo
	LP9tmUY05JKAOgCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6489C137DB;
	Wed, 29 Jan 2025 09:46:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id C9NOFw35mWf7LAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 29 Jan 2025 09:46:53 +0000
Date: Wed, 29 Jan 2025 10:46:53 +0100
Message-ID: <87o6zq6jg2.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,	Yaron Avizrat
 <yaron.avizrat@intel.com>,	Oded Gabbay <ogabbay@kernel.org>,	Julia Lawall
 <Julia.Lawall@inria.fr>,	Nicolas Palix <nicolas.palix@imag.fr>,	James Smart
 <james.smart@broadcom.com>,	Dick Kennedy <dick.kennedy@broadcom.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,	Jaroslav Kysela
 <perex@perex.cz>,	Takashi Iwai <tiwai@suse.com>,	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,	David Sterba <dsterba@suse.com>,	Ilya
 Dryomov <idryomov@gmail.com>,	Dongsheng Yang <dongsheng.yang@easystack.cn>,
	Jens Axboe <axboe@kernel.dk>,	Xiubo Li <xiubli@redhat.com>,	Damien Le Moal
 <dlemoal@kernel.org>,	Niklas Cassel <cassel@kernel.org>,	Carlos Maiolino
 <cem@kernel.org>,	"Darrick J. Wong" <djwong@kernel.org>,	Sebastian Reichel
 <sre@kernel.org>,	Keith Busch <kbusch@kernel.org>,	Christoph Hellwig
 <hch@lst.de>,	Sagi Grimberg <sagi@grimberg.me>,	Frank Li
 <Frank.Li@nxp.com>,	Mark Brown <broonie@kernel.org>,	Shawn Guo
 <shawnguo@kernel.org>,	Sascha Hauer <s.hauer@pengutronix.de>,	Pengutronix
 Kernel Team <kernel@pengutronix.de>,	Fabio Estevam <festevam@gmail.com>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,	Hans de Goede
 <hdegoede@redhat.com>,	Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
 <ilpo.jarvinen@linux.intel.com>,	Henrique de Moraes Holschuh
 <hmh@hmh.eng.br>,	Selvin Xavier <selvin.xavier@broadcom.com>,	Kalesh AP
 <kalesh-anakkur.purayil@broadcom.com>,	Jason Gunthorpe <jgg@ziepe.ca>,	Leon
 Romanovsky <leon@kernel.org>,	cocci@inria.fr,
	linux-kernel@vger.kernel.org,	linux-scsi@vger.kernel.org,
	dri-devel@lists.freedesktop.org,	linux-sound@vger.kernel.org,
	linux-btrfs@vger.kernel.org,	ceph-devel@vger.kernel.org,
	linux-block@vger.kernel.org,	linux-ide@vger.kernel.org,
	linux-xfs@vger.kernel.org,	linux-pm@vger.kernel.org,
	linux-nvme@lists.infradead.org,	linux-spi@vger.kernel.org,
	imx@lists.linux.dev,	linux-arm-kernel@lists.infradead.org,
	platform-driver-x86@vger.kernel.org,	ibm-acpi-devel@lists.sourceforge.net,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH 04/16] ALSA: ac97: convert timeouts to secs_to_jiffies()
In-Reply-To: <20250128-converge-secs-to-jiffies-part-two-v1-4-9a6ecf0b2308@linux.microsoft.com>
References: <20250128-converge-secs-to-jiffies-part-two-v1-0-9a6ecf0b2308@linux.microsoft.com>
	<20250128-converge-secs-to-jiffies-part-two-v1-4-9a6ecf0b2308@linux.microsoft.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,intel.com,kernel.org,inria.fr,imag.fr,broadcom.com,HansenPartnership.com,oracle.com,perex.cz,suse.com,fb.com,toxicpanda.com,gmail.com,easystack.cn,kernel.dk,redhat.com,lst.de,grimberg.me,nxp.com,pengutronix.de,amd.com,linux.intel.com,hmh.eng.br,ziepe.ca,vger.kernel.org,lists.freedesktop.org,lists.infradead.org,lists.linux.dev,lists.sourceforge.net];
	R_RATELIMIT(0.00)[to_ip_from(RL41ih3fejwepcmbj4wj583m3u)];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_GT_50(0.00)[59];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250129_014658_133630_8E3F5726 
X-CRM114-Status: GOOD (  19.42  )
X-Mailman-Approved-At: Wed, 29 Jan 2025 09:38:17 -0800
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

On Tue, 28 Jan 2025 19:21:49 +0100,
Easwar Hariharan wrote:
> 
> Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
> secs_to_jiffies().  As the value here is a multiple of 1000, use
> secs_to_jiffies() instead of msecs_to_jiffies to avoid the multiplication.
> 
> This is converted using scripts/coccinelle/misc/secs_to_jiffies.cocci with
> the following Coccinelle rules:
> 
> @depends on patch@
> expression E;
> @@
> 
> -msecs_to_jiffies
> +secs_to_jiffies
> (E
> - * \( 1000 \| MSEC_PER_SEC \)
> )
> 
> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>

Acked-by: Takashi Iwai <tiwai@suse.de>


thanks,

Takashi


> ---
>  sound/pci/ac97/ac97_codec.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/sound/pci/ac97/ac97_codec.c b/sound/pci/ac97/ac97_codec.c
> index 6e710dce5c6068ec20c2da751b6f5372ad1df211..88ac37739b7653f69af430dd0163f5ab4ddf0d0c 100644
> --- a/sound/pci/ac97/ac97_codec.c
> +++ b/sound/pci/ac97/ac97_codec.c
> @@ -2461,8 +2461,7 @@ int snd_ac97_update_power(struct snd_ac97 *ac97, int reg, int powerup)
>  		 * (for avoiding loud click noises for many (OSS) apps
>  		 *  that open/close frequently)
>  		 */
> -		schedule_delayed_work(&ac97->power_work,
> -				      msecs_to_jiffies(power_save * 1000));
> +		schedule_delayed_work(&ac97->power_work, secs_to_jiffies(power_save));
>  	else {
>  		cancel_delayed_work(&ac97->power_work);
>  		update_power_regs(ac97);
> 
> -- 
> 2.43.0
> 

