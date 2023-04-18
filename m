Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B79D8C77B75
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Apr 2023 13:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oMzXDgeIe9bFmA8zBDQFasaEMBj1BPB8PAmctp5SKQA=; b=cgiuCMxxcRZHZRBgSvoizZMXHJ
	Ir3zlzzDZ141jOzKc0941RUPe5CYrZd9PDzfrs2snQ1Hp9+Ptybz+L6Z4WPtTZB4YVU0spjUw8mA5
	V20EvdS00nWlo9S+eFZZvaNMOke+tiBcsmaxfr/PGKMKxwzRJZPhQQGabSHuQRLm8ZArhVT5d3GTy
	XsVUeialSx4GFAgA5zbHkjUi9Da/UHggzkxn4qo4Rzy+t0AvbBPJgd1lZfA18nAyTey7Hvl9kvLJo
	ljnVtIjhyneKtvb5uWhyGL1rY8AXeKVISH9FMuwOdF+AzRyMQ8ISqZ8hzgnMpxi+YiW+XiQpURFIf
	tuk5fs7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1polcF-002Iya-1R;
	Tue, 18 Apr 2023 13:43:27 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1polcC-002IxO-1E
	for linux-nvme@lists.infradead.org;
	Tue, 18 Apr 2023 13:43:25 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 111E31F8D7;
	Tue, 18 Apr 2023 13:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1681825402; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oMzXDgeIe9bFmA8zBDQFasaEMBj1BPB8PAmctp5SKQA=;
	b=CHxs2l1AEj5yGxv61LcqpY0Y4cgMYFe4bldA2RQC2uDDd8nXfC1fSU26Zdrx+9CgXmUtH3
	QEssjcy8kgDoeaho/XiY1XGrlxO6YB2tQqzWUWPXgmVLOwjy9bn+v0zM72A79fWqgDipmN
	gTceghiK5McVB3rDEr97Y/IdRUugGs8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1681825402;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oMzXDgeIe9bFmA8zBDQFasaEMBj1BPB8PAmctp5SKQA=;
	b=KSexhj329+sezaAzmQF0TKFP8+X7DF5TORB/c3xF8eRfF1h5evdqburXoZU4hWjVQMhCGN
	JhCJQjp9ljY4XuAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 00FC513581;
	Tue, 18 Apr 2023 13:43:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id yDI9AHqePmTLQAAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 18 Apr 2023 13:43:22 +0000
Date: Tue, 18 Apr 2023 15:43:21 +0200
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	Sagi Grimberg <sagi@grimberg.me>, James Smart <james.smart@broadcom.com>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Martin Belanger <Martin.Belanger@dell.com>, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH v3 0/4] nvmet-fcloop: unblock module removal
Message-ID: <nlogr5rdxqvilsz4iolktfpdvflvvithwaoa3vrx2fsjqlho4q@4upw7jq3aem2>
References: <20230418130159.11075-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418130159.11075-1-dwagner@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230418_064324_561705_057FF1C7 
X-CRM114-Status: UNSURE (   8.14  )
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

On Tue, Apr 18, 2023 at 03:01:55PM +0200, Daniel Wagner wrote:
> nvme/041 (Create authenticated connections)                  [failed]
> nvme/042 (Test dhchap key types for authenticated connections) [failed]
> nvme/043 (Test hash and DH group variations for authenticated connections) [passed]
> nvme/044 (Test bi-directional authentication)                [failed]
> nvme/045 (Test re-authentication)                            [passed]

I suppose these should be disabled for fc as all this is tcp specific.

