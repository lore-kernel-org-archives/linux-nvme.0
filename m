Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F34B4C43334
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Jul 2022 13:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7xNUTPM5xiWLyG9S9s6/LqrFzcXh5UWRzCd70UcpvDw=; b=p1eREQLxcZqRZq1xgF+LZQUnXF
	Adk/DTFS3teaqBDi4ZUz5Q30Iui60zNcT7dXhvtZsxaKikM2sPf+o3jtB1SdKiUNPdyPInUfV+CPD
	gRnKKik7BbK91lX/o4Jsmj5h9EaDJJFs/eJXpRb5efw9W5xBDLPM9a6D81NIXqEhcWYR3XTv94Ten
	oGfqMoJYdh86g6yjkV02+VXm5vJ7kGxgo1EKdPiZs9inTNqCa8swkLXoLd1Hieiw/AYplHkBHEeXj
	YjMHwMNQzLQd2D88I3KjEATSiHdh26Vc7/v9qh9PY36bAqw7gkq+bbLlX48GDclm7cy2ykHmJBKdo
	1GNpbCwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEt1s-005JjV-C8; Fri, 22 Jul 2022 13:49:20 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEt1p-005JdH-Bs
	for linux-nvme@lists.infradead.org; Fri, 22 Jul 2022 13:49:18 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6F4273503F
	for <linux-nvme@lists.infradead.org>; Fri, 22 Jul 2022 13:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1658497753; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7xNUTPM5xiWLyG9S9s6/LqrFzcXh5UWRzCd70UcpvDw=;
	b=2J/ijfuTsba0fXhOcKDTuEuTVSgEhn4JyAT3bUVVnNdqf1TUD7wakC/wQdat821NVCr+cQ
	JSKmTPtQHpIrgBrlQzOj2jI3QZ8zyH6dLQDLKlFNGo7RpLE4lghEuVJMqGyp6GRz2PdXY4
	oW+j5rnuoGuYPyCItdx675NodX0yteA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1658497753;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7xNUTPM5xiWLyG9S9s6/LqrFzcXh5UWRzCd70UcpvDw=;
	b=7RWmywvvL/6s8lx0i4wpU8oxhSC3nQs/SShmWQWQgIQerNmVJ5Xgcf1Ghfz0DS4UM+U86Z
	YUd7gyAnBQT6jCCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6253D134A9
	for <linux-nvme@lists.infradead.org>; Fri, 22 Jul 2022 13:49:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 3YPfF9mq2mKAXQAAMHmgww
	(envelope-from <dwagner@suse.de>)
	for <linux-nvme@lists.infradead.org>; Fri, 22 Jul 2022 13:49:13 +0000
Date: Fri, 22 Jul 2022 15:49:12 +0200
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] nvme: consider also host_iface when checking ip
 options
Message-ID: <20220722134912.bqvtraq6jqtnuszt@carbon>
References: <20220722092456.24517-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722092456.24517-1-dwagner@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220722_064917_577324_43CAD647 
X-CRM114-Status: GOOD (  11.10  )
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

On Fri, Jul 22, 2022 at 11:24:56AM +0200, Daniel Wagner wrote:
> It's perfectly fine to use the same traddr and trsvcid more than once
> as long we use different a host_iface. This is used in setups where
> the host has more than one interface but the target exposes only one
> IP.
> 
> To keep the match logic simple don't allow mixed setups. The user
> needs to use host_iface option consistently for all controllers in
> such setups.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>

Please ignore this patch. The follow up patch is here: 20220722100335.1708-1-dwagner@suse.de

