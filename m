Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81DB7C04A68
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Jul 2022 08:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZYSdY578I1v2dGPAqt08m5gXJuAIvODY8T2iLcuoOZM=; b=cCoVAOCH4jND4G5X4VMNT5RVaC
	4wlNquyD1n3v3qYYfLyarW0IZ3hG0RL2l8GpAMXEXw3WgKKdhahWTdbIo7Mfp6TfDJ5BbQo2/Veeh
	tQ5dDRgeCKSRFltVVrN4IXaRiSdGlF186LgYnpo82M1iHftqDsdz6IsD0JOtO5avj0KJnc/BkcMSG
	/BezPJVZSKYStD3s9+iXFxsT2F8SGdymfF8C8HPm3ZMgKLOTs6FcURUdwUP3vzGl+91wd63znLM+P
	d1Ci6kws5wIBFqcAC7aSt9466EuvuXi/gkpajOxaOvzd91cNbJf40je8cqbCY0HCYrcRCVMjImRob
	lDZCDv1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGc0m-00AsUL-F6; Wed, 27 Jul 2022 08:03:20 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGc0c-00AsLO-Ij
	for linux-nvme@lists.infradead.org; Wed, 27 Jul 2022 08:03:12 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AB29D204A4;
	Wed, 27 Jul 2022 08:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1658908984; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZYSdY578I1v2dGPAqt08m5gXJuAIvODY8T2iLcuoOZM=;
	b=pTk1UIptKn0+B44pby+mdyQAourfHSSZcFNSfHC8E4Rx83jhmqfpvcfmKOMZebHAkUsz5A
	RThwJLyMhOkJNCsAZokG8Y9BzgjL3EaLil8jJ9t1VbnAVhS7dgxCX10ipx5eGLMSZ5EXS2
	10JVmpnlm7jb/s6CxVDo6oIppH2rXVs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1658908984;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZYSdY578I1v2dGPAqt08m5gXJuAIvODY8T2iLcuoOZM=;
	b=zv0ZjREkDsoXKo+5VcPWhAKpJqYx0XS42KICmxlVMhoniGk5GAOjVHvpdXfO/63amDJIR9
	3zqsyh1BOsnWHWAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 91DD013AD7;
	Wed, 27 Jul 2022 08:03:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id lWSSIzjx4GLRIQAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 27 Jul 2022 08:03:04 +0000
Date: Wed, 27 Jul 2022 10:03:04 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Chao Leng <lengchao@huawei.com>
Cc: linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] nvme: consider also host_iface when checking ip
 options
Message-ID: <20220727080304.vlgrszlqmbnbpyin@carbon>
References: <20220722092456.24517-1-dwagner@suse.de>
 <3f0528a5-73d2-3dc5-32fb-0eb73797bf71@huawei.com>
 <20220722094648.i6w3dymag3mfjpuo@carbon>
 <ce2ba75a-3dd6-8530-c868-298bbeb93d67@huawei.com>
 <20220722100932.tyjljbccwv47tg4z@carbon>
 <a37fc589-b47b-61c6-0c36-c3b13e7ce56d@huawei.com>
 <20220725092522.i7lch2p4tn7uj6ii@carbon.lan>
 <37845bb2-c868-938b-8aed-cbc18594b9d6@huawei.com>
 <20220726071845.i2sq2p3c6e6hoa7h@carbon>
 <dee8e066-c898-1d48-eb78-668a0bb94d11@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dee8e066-c898-1d48-eb78-668a0bb94d11@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220727_010310_815371_14357832 
X-CRM114-Status: GOOD (  17.40  )
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

On Wed, Jul 27, 2022 at 02:52:25PM +0800, Chao Leng wrote:
> host_iface is different with traddr and trsvcid.
> traddr is required opt, trsvcid can be specified or the default.
> host_iface is NULL if without specified. It is same with host_tradr.
> 
> For example:
> nvme connect -t tcp -n nvmet-test -a 192.168.19.54 -s 4420 -f eth0
> nvme connect -t tcp -n nvmet-test -a 192.168.19.54 -s 4420
> According to your patch, the second will be treated as a duplicate.

Correct. And incidentally this is a duplicate :)

> It is similar like this:
> nvme connect -t tcp -n nvmet-test -a 192.168.19.54 -s 4420 -w 192.168.154.50
> nvme connect -t tcp -n nvmet-test -a 192.168.19.54 -s 4420
> This will be treated as a different new.

Yes, though if in this case eth0 has only IP 192.168.154.50, it would be
a duplicate.

> host_iface and host_tradr are similar opts related to host outgoing.
> host_iface and host_tradr may or may not be specified.
> The check logic should be consistent.

I see. The comment nvmf_ip_options_match() on this topic says the whole
logic is a bit 'rough'. Bringing iface_host into this picture makes the
whole logic even more complex. it's possible to use iface_host and
host_traddr combined. That's why I thought it would be a good idea to
make it more restrict.

I suspect the correct solution would be to inference each option set
which actual configuration is used. Not sure if it is worth the
hassle. Is there any real harm with duplicate connections, except
performance?

Even with this patch, it's possible to do something like this here:

# nvme list-subsys
nvme-subsys0 - NQN=nvmet-test
\
 +- nvme0 tcp traddr=192.168.19.54,trsvcid=4420,host_iface=eth0 live optimized
 +- nvme1 tcp traddr=192.168.19.54,trsvcid=4420,host_traddr=192.168.154.50 live optimized

It is a duplicate connection...

I don't mind relaxing the check but the question is should it combined
with the host_traddr logic or stay separate?

