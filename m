Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D182C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 24 May 2022 15:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xfU5NzszzCp4VuHouyJLjWzwib5ilgcXgHinaoqaEpg=; b=IY16MEVo64cTNj4XKBXLF9UV77
	8ytbmmsIliN8zapCILq9+nV0T73Laiq3wR4+hvZDK3ZhZNv8gQkAc7B45bkm1QvkXUXpl1pO6A2Dy
	pwJOqTYGS2aB3CfJSoSMIL0d9mklbtPQmaYVygY70yD3d5FNXvCOtwFQ9wvAr96OA2TD1cGQ/cIdI
	a4hVRErn8QV9DT9Ua9kuLwxsncA7ILq4kA8B+BE99T6BbosxWDPQ4YK2ZHC3A0HIZXFzzwQA0XIa4
	8GljeufKqvowwE4j3i/WHuHgIA1xHfLjmny2exQ0b26ufPVBGBcemwOwZeEZ3yGO/wvGj2kLoRRj9
	E8Wy/S4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ntW88-008N6v-FW; Tue, 24 May 2022 15:07:28 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ntW85-008N5x-Py
 for linux-nvme@lists.infradead.org; Tue, 24 May 2022 15:07:27 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9AEE721A6E;
 Tue, 24 May 2022 15:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1653404842; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xfU5NzszzCp4VuHouyJLjWzwib5ilgcXgHinaoqaEpg=;
 b=eV1ZpnfsWoN57/yboyWyrbtMSyNf3vbM0Rh6Sh0rZ6Xjef51kK2HEhDsgU6JMPv+6VyA4w
 IWLFSd6PG0qe1nWq08zAIHBKB7SDwqvSvfRXJA3sXh8tzsqsfHTWreSG+jFLA9d+aZWrKU
 jd7yGHpM4XdG3kd04YFDUgPxAna7PtU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1653404842;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xfU5NzszzCp4VuHouyJLjWzwib5ilgcXgHinaoqaEpg=;
 b=KXTTkX1X1Elxmg7sTQ0ru8J3UGvm2Kpqujzqkib5yxRkdiDnLBm07PIpJ3dRA2cRgseW7z
 4p/CECoJLyfFDHCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8BBEB13AE3;
 Tue, 24 May 2022 15:07:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id I00WIqr0jGIdMQAAMHmgww
 (envelope-from <dwagner@suse.de>); Tue, 24 May 2022 15:07:22 +0000
Date: Tue, 24 May 2022 17:07:22 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Subject: Re: [RFC] nvme-rdma: Stop queues when starting with error recovery
Message-ID: <20220524150722.lsfpoftjx4dcx4ho@carbon.lan>
References: <20220523152102.41000-1-dwagner@suse.de>
 <c3e5bad8-8cca-8058-38d7-0eea2ddfd6bc@grimberg.me>
 <95e18f3a-7997-ccbe-7889-18585bb72ff3@grimberg.me>
 <20220524133803.3f6dql3waflypl5q@carbon.lan>
 <f1143d78-107a-bef0-626d-df71ca431584@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1143d78-107a-bef0-626d-df71ca431584@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220524_080726_023126_69B43218 
X-CRM114-Status: GOOD (  12.90  )
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

On Tue, May 24, 2022 at 04:48:27PM +0300, Sagi Grimberg wrote:
> > I suspected that nvme_stop_ctrl() might have unwanted side
> > effects. Maybe factoring out the common bits from nvme_stop_ctrl() into
> > nvme_stop_ctrl_fast() and call it from here sounds like a reasonable
> > thing to do. The function name could be better, but naming is hard.
> 
> The only name that comes to mind is nvme_stop_ctrl_noio, which is
> arguably worse... Or maybe just __nvme_stop_ctrl.

I pondered for a while and no good idea. I'd prefer __nvme_stop_ctrl()
clearly over nvme_stop_ctrl_foo() though, because I read
__nvme_stop_ctrl() as to be called by nvme_stop_ctrl().

