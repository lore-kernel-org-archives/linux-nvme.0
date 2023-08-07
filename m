Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A11EEB64DD
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Aug 2023 09:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S4IXeTOvgIhaUL6TMLHTzEnjkuhur8rRbBQuHbppQPg=; b=yDvBETnGRCr+c4/ouvo+19UHkK
	6Kc09fQ0+xhy38RL3z+SS0SZX2h/ccbG8bJA363fVp0JrypShugPlBklNtD0tHodbAtoycYLIWqkW
	7yCthPWiR4bT31FfS5Rwi7n1Xcd3/wFSfwfAouLq7hfAVetCUjx7PrzV04Qi1+hFNOewZePVSZLlY
	WHSJILMg5k++3Ny2blWBpfCwqzFjA7etCb4u2MYJYD8IPXBaANDI4Yz6VkQPerJTIns6AV/1Md5+l
	tJCRNODjx1H1sog3RjDVbMGuKvLBYf6SkyZSVvXIIqw4JYr8xfzUD1lhm4Mlj2dIjTWSvvEcyopTz
	FUE1rQXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qSwLC-00GXhP-0g;
	Mon, 07 Aug 2023 09:15:54 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qSwL8-00GXh0-2q
	for linux-nvme@lists.infradead.org;
	Mon, 07 Aug 2023 09:15:52 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F11E81F460;
	Mon,  7 Aug 2023 09:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691399747; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S4IXeTOvgIhaUL6TMLHTzEnjkuhur8rRbBQuHbppQPg=;
	b=u2UoHAedLhV5sF++7bV3dDHUQ1ekRdd+Mcyijmgxtrg2YlTnC3U3vnChxg9pR3eP6nEqcb
	M49hgZ0+hQJDQ57ObI7BYY0G9cbaLveUZT3bxdVHVvKvXwRGbfetI1U65xJAS1FHtttixh
	+MQ/to5vTeuIemgOhUlBq01sS5/RCHs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691399747;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S4IXeTOvgIhaUL6TMLHTzEnjkuhur8rRbBQuHbppQPg=;
	b=YRS9t+OMHxSyl8L0dW9HnooFnWSwON4vjBrEkbq4JS7cBzyRLIyrM0StxTT7gOPWnNAGOS
	mENTdT/yIRHpsUDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E2BC613910;
	Mon,  7 Aug 2023 09:15:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 1ENSN0O20GRrHAAAMHmgww
	(envelope-from <dwagner@suse.de>); Mon, 07 Aug 2023 09:15:47 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-nvme@lists.infradead.org
Cc: Daniel Wagner <dwagner@suse.de>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH nvme-cli v2] fabrics: Use corresponding hostid when hostnqn is generated
Date: Mon,  7 Aug 2023 11:15:46 +0200
Message-ID: <169139953072.32683.5290248262382877675.b4-ty@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230803112139.2116899-1-shinichiro.kawasaki@wdc.com>
References: <20230803112139.2116899-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230807_021551_089140_CE31236E 
X-CRM114-Status: GOOD (  10.21  )
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

On Thu, 3 Aug 2023 20:21:39 +0900, Shin'ichiro Kawasaki wrote:
> After the kernel commit ae8bd606e09b ("nvme-fabrics: prevent overriding
> of existing host"), kernel ensures hostid and hostnqn maintain 1:1
> mapping and "non 1:1 mapping will be rejected". This makes 'nvme
> discover' and 'nvme connect' commands fail when they generate hostnqn,
> since it does not use corresponding hostid.
> 
> To avoid the failures, prepare and use corresponding hostid to the
> generated hostnqn, taking the hostid from the hostnqn string. Also add
> checks for prepared hostnqn and hostid. If the hostid taken from the
> generated hostnqn is different from the hostid from file, print a
> warning message. Also, if the prepared hostnqn are inconsistent with the
> prepared hostid, print a warning.
> 
> [...]

Applied, thanks!

[1/1] fabrics: Use corresponding hostid when hostnqn is generated
      commit: 7d1c18f581e489e0cedfd9991bc97a2f8239cf82

Best regards,
-- 
Daniel Wagner <dwagner@suse.de>

