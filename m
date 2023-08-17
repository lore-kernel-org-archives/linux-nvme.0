Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE947C2FC0E
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Aug 2023 08:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gtHPjUmwaHRpLRWbT3zdN8f2jVVD5Hmnt8RivMUM4u4=; b=Tygxco9c11NJUayXvA7JokWNP1
	+Fhm438nfK4x9hZxl96f6pFC1gk04NkHEXsGAiN3ofbMfMGeR/xO1+KOtFljgaZu+L2xqMIDGtNlK
	hia7taSMhe+LptIuivJtTtKCXxenRSHqNsJEVTokqNx4RX0H36veh1aII+19Vj9aoitzF/8aBz4G+
	YLJAqeV77O5W0dmjwwUOLKuPiHttt6CqM4WANTmivhWyuI25gSeJOKsZwWavZ7ZBm6PyUC4O+FyaB
	6vuR3EV66fUSdNPweuILwGMOXK4kOBgoPigB/outK89Gf3Scr04M7NKZxV8tUN2LrN64KSc12wLxI
	o1z57UfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qWYDH-005nla-0I;
	Thu, 17 Aug 2023 08:18:39 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qWYDE-005nlD-0E
	for linux-nvme@lists.infradead.org;
	Thu, 17 Aug 2023 08:18:37 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D8F4D1F895;
	Thu, 17 Aug 2023 08:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1692260313; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gtHPjUmwaHRpLRWbT3zdN8f2jVVD5Hmnt8RivMUM4u4=;
	b=ILPYFCsOs1ZNRiC15Yy34zYLdObs3aR3OmdTkgzNNV/VU8Yy1XgXg9Tlh6v59fJw7cg1h1
	rQOwX9YKbSq1FC3yRMepTyiBwdwCRKBwI0UfR7Q55TkStHhevcRTv1UAJb4+o2fKKw1JkG
	TftewAJnQVPgN8+TZZ3iqNnhByZWDrI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1692260313;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gtHPjUmwaHRpLRWbT3zdN8f2jVVD5Hmnt8RivMUM4u4=;
	b=i+vIbgC5hsYenW6Emdorro3G8ruAfTrMJO5gSBeU2vvcSoHCCSJekJt5ZaZTcd2oibBo4/
	GC4QBLLFQn5cfJAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C456C1392B;
	Thu, 17 Aug 2023 08:18:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id NgF3LtnX3WQMUQAAMHmgww
	(envelope-from <dwagner@suse.de>); Thu, 17 Aug 2023 08:18:33 +0000
Date: Thu, 17 Aug 2023 10:18:43 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	Yi Zhang <yi.zhang@redhat.com>, Sagi Grimberg <sagi@grimberg.me>, 
	Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH blktests v2 2/2] nvme: remove "udevadm settle" after
 _nvme_connect_subsys
Message-ID: <cplbxtua73zfpotuqrjthmwoziqpfjtolfpimk2z4rml437muk@x37qkkvc6twt>
References: <20230817073021.3674602-1-shinichiro.kawasaki@wdc.com>
 <20230817073021.3674602-2-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817073021.3674602-2-shinichiro.kawasaki@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230817_011836_260125_5DA04ECF 
X-CRM114-Status: UNSURE (   8.80  )
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

On Thu, Aug 17, 2023 at 04:30:21PM +0900, Shin'ichiro Kawasaki wrote:
> The previous commit introduced "udevadm settle" command at the end of
> _nvme_connect_subsys. Then the command is no longer required after
> calling _nvme_connect_subsys in test cases.
> 
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Reviewed-by: Daniel Wagner <dwagner@suse.de>

