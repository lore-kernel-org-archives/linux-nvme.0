Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD59C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Jul 2022 10:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ee8+7/5zAPNiTzdzCiCtVj3eiJ2dbvlR4fpS0Y8LPDc=; b=EEkDLMQwjucCDc3gMDPitEa36r
	b6Kd3CXrGt3OgGNOLcQopRVn+qWyvn0Bn/lyQaa4Wag2J/V6Mw61yl8njUli0f0XaHnsXCUX+wvWx
	IzUrAdO6/nEwBVzcl3XvUNJutvjx2k8Om3Oc3PXM6li8yEOuGE0vR2g++iACAGuQw8XxIyb9nPx0H
	0r1+qsy5/1RFN1Q/DerBrLtMeAPuYftCltT8o5e9zsxmAeaNbhhLozcRchER8QS8zNENyNmRVQNbQ
	M9cL685fi9pcb2nsAOG2RRqiWGLeG21CcBE2t0XVdMlkg5zsP10K0lOKzAe8zr7jiTYO9cZ7uti/K
	wW2cMdLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEpbG-002LMQ-WC; Fri, 22 Jul 2022 10:09:39 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEpbD-002L4j-QM
	for linux-nvme@lists.infradead.org; Fri, 22 Jul 2022 10:09:37 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A0F2F35083;
	Fri, 22 Jul 2022 10:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1658484572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ee8+7/5zAPNiTzdzCiCtVj3eiJ2dbvlR4fpS0Y8LPDc=;
	b=EPogqwCuhv12a8Kr6LHGX/T0W/AAo/Nb8PATSpUrufatu6ztkeM09vB/28jBQ6z5joYoD1
	bMAhZ3VsBm8aRMcpHf5ChABFoyVw1jQEQiFAoplxuqxDFWkZO9/UlhHZti+7BcIvyZY/fw
	4my0ubCd9TiSWhtgpRwEMHztBZjAtDY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1658484572;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ee8+7/5zAPNiTzdzCiCtVj3eiJ2dbvlR4fpS0Y8LPDc=;
	b=Z29if3m8Q+SDxWi9Wt+UL/1UWp6Q3xbBHXzfmhxkjY/PJxRZCYQoohCPW9/WVNI4N9g3kP
	sFGS5iui44IzviDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8EE1713AB3;
	Fri, 22 Jul 2022 10:09:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id /3z1IVx32mKCeAAAMHmgww
	(envelope-from <dwagner@suse.de>); Fri, 22 Jul 2022 10:09:32 +0000
Date: Fri, 22 Jul 2022 12:09:32 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Chao Leng <lengchao@huawei.com>
Cc: linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] nvme: consider also host_iface when checking ip
 options
Message-ID: <20220722100932.tyjljbccwv47tg4z@carbon>
References: <20220722092456.24517-1-dwagner@suse.de>
 <3f0528a5-73d2-3dc5-32fb-0eb73797bf71@huawei.com>
 <20220722094648.i6w3dymag3mfjpuo@carbon>
 <ce2ba75a-3dd6-8530-c868-298bbeb93d67@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce2ba75a-3dd6-8530-c868-298bbeb93d67@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220722_030936_019460_0E7B4CFA 
X-CRM114-Status: UNSURE (   8.82  )
X-CRM114-Notice: Please train this message.
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

On Fri, Jul 22, 2022 at 05:55:40PM +0800, Chao Leng wrote:
> We should add the N:1 related controller management first, and then add
> the host_iface cheching. Thus it might be better.

I am not following you here. What do you mean with controller
management?

I've tested this patch against our nvmet backend. This allows additional
connections. E.g. the host has following setup:

 eth0: 192.168.154.50/24
 eth1: 192.168.154.214/24

and the target:

 br0: 192.168.19.54/24

With this change we can do this here:

nvme connect -t tcp -n nvmet-test -a 192.168.19.54 -s 4420 -f eth0
nvme connect -t tcp -n nvmet-test -a 192.168.19.54 -s 4420 -f eth1

What's wrong with it?

