Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3370EB64D8
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Jun 2023 09:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C7PPqDZAmzcbcg0rWIZX01hC1JN4/nlDeRusA0hxj38=; b=w08krhBje90hk3b0GQ8H/a1K7H
	Kq7o3hUTq+dBOpjIGtsgM7tU14wrAlD9EkQywyuoIleuhG6/D1dRAvYZ528QuiXxwoUP+yoPZIata
	G7OWZ2daSlMakr2soqrRU63GG9658NAerhdjSDFJGFqoQKkiQ4pf2wLcS1cRr+1orJV4+qs9rzx+B
	NSnhMbNAoVe/k1wuE2IzaAlnY2+X92NS/ZNRX9G92TceRkyPQtjBZ/XAKcU2EWD2S/3V1O5k9yX/j
	pz4zzA0dftLDqgjhwDm9tBvRRIFNF1+zitCf8eaeOEysy5eNj78jjE6S8j2a5wb0/cZiM/Yw7Ib0M
	mW8Gql5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qBtjQ-00Dmho-2v;
	Wed, 21 Jun 2023 09:02:28 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qBtjO-00DmhG-06
	for linux-nvme@lists.infradead.org;
	Wed, 21 Jun 2023 09:02:27 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B93C221A44;
	Wed, 21 Jun 2023 09:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1687338144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C7PPqDZAmzcbcg0rWIZX01hC1JN4/nlDeRusA0hxj38=;
	b=PVbKK07wbYQLl7N/k95ONxfqybkfrZz3Sd26AdMOljQkkvKs23hIY62UaiM9Yy+Qngxl8n
	yBiRGjeD0Jc/PbHIpI7bTatZKg8TksnWrmoErbcArSB4teDzgJAE1hYXZhmw0ttzZsMsqi
	SYGYLE3S4HqNGpkY0m9LMBJFvxE5uGo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1687338144;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C7PPqDZAmzcbcg0rWIZX01hC1JN4/nlDeRusA0hxj38=;
	b=2dZQ1LcBI9BComcRh1bGM2eti1X2u0XXMJpg/eBfRfeZmpsO4M+ZXDu7K9iLxfuT+1wVK4
	yrxg3tEzF7/qjICw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AAA31134B1;
	Wed, 21 Jun 2023 09:02:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id WzqeKaC8kmQrZAAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 21 Jun 2023 09:02:24 +0000
Date: Wed, 21 Jun 2023 11:02:24 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>, 
	Shin'ichiro Kawasaki <shinichiro@fastmail.com>, Hannes Reinecke <hare@suse.de>, 
	James Smart <jsmart2021@gmail.com>, Martin Belanger <Martin.Belanger@dell.com>
Subject: Re: [PATCH blktests v1 2/3] nvme/rc: Avoid triggering host nvme-cli
 autoconnect
Message-ID: <ouked4rirrquxur3zzkzm2tsnjtdyfme4hqzetd7hyudtneuhl@feetyajbpqcq>
References: <20230620132703.20648-1-dwagner@suse.de>
 <20230620132703.20648-3-dwagner@suse.de>
 <af640019-b867-d488-0443-797a75ba4195@grimberg.me>
 <vbbbnzcm6r4jzcc54crix7kjsg647w57te7t2weu7vhuwxg54n@u6cwcn62bfbd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vbbbnzcm6r4jzcc54crix7kjsg647w57te7t2weu7vhuwxg54n@u6cwcn62bfbd>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230621_020226_216683_41B134A3 
X-CRM114-Status: GOOD (  13.07  )
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

On Tue, Jun 20, 2023 at 07:43:35PM +0200, Daniel Wagner wrote:
> On Tue, Jun 20, 2023 at 05:07:43PM +0300, Sagi Grimberg wrote:
> > Hmm... is this hapenning with non-fc as well?
> 
> I haven't seen a problem for TCP or RDMA yet but in principle it should also
> exists. I can do some tracing to see if we have also problem thern. Two of the
> udev rule match on the subsystem and the event type.

The only udev rule which gets triggered during blktests execution is this one:

# nvme-fc transport generated events (old-style for compatibility)
ACTION=="change", SUBSYSTEM=="fc", ENV{FC_EVENT}=="nvmediscovery", \
  ENV{NVMEFC_HOST_TRADDR}=="*",  ENV{NVMEFC_TRADDR}=="*", \
  RUN+="@SYSTEMCTL@ --no-block restart nvmf-connect@--device=none\t--transport=fc\t--traddr=$env{NVMEFC_TRADDR}\t--trsvcid=none\t--host-traddr=$env{NVMEFC_HOST_TRADDR}.service"

That explain why blktests didn't get disturbed by the autoconnect rule as this
rule has a match on the fc subsystem.

