Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A07F7C7EE30
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Mar 2023 08:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z2wBECbEai+ENb4mymiKGb7BAtH1X7W/JAg2TcmHQco=; b=1xmITZr1R4VnSSM5fjsh2ai1lu
	VFX4OQoXQWC4qZ+5TkoY2tCbXQqJB7GXUu2kRc942RR36EaeMEIwcVO1H+d+Mps9v4g/gGOF31Kb3
	z3atn4+kThf5dn7dFzLXRNV4vDMOKTAq/RVMvzxd6QePpa0nvru8lUp2iCgA+oJRwcxwz0sf5kK6n
	nnqN+wfsTPHUb/A1rnVBAoIH7d2mHC06JEipKRUoi5TpbH/QbFE97+Nhu0gxI2qxBTdzwZUvkyGir
	6Fz+fN2F62Gj6lup0lb2/klStazPSMCa4+CqvCto8uuNX1nw0DirkbAS1uPbpwJ0XQTARCUA/zIoG
	k6vCq5nA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pXe5u-001F3d-8x; Thu, 02 Mar 2023 08:15:18 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pXe5s-001F2f-6l
	for linux-nvme@lists.infradead.org; Thu, 02 Mar 2023 08:15:17 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2C0261FE6E;
	Thu,  2 Mar 2023 08:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1677744912; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z2wBECbEai+ENb4mymiKGb7BAtH1X7W/JAg2TcmHQco=;
	b=vii8KZBKEuDaff5DgqaxViOmgpwnOIdNbC7yeQ3nK8aDs3QTN8A5s3lIcv+J9UobyFWhcq
	Cr38q+/DmlF8ACO9YUpA54SLbbp3m0P1xFJH+lxLRZsxbAYyiQ5lkXMN57A33J43m4gRxm
	d0Lx+Xj2HKK8JeytKUMIc+mC0IoZsZo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1677744912;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z2wBECbEai+ENb4mymiKGb7BAtH1X7W/JAg2TcmHQco=;
	b=GwnJ2LcCCjOA7daoGccJnpqPmN9nnjpPBcs78GT2BFBrJAj3TQytdKmoxBTQdaTRH/0L2x
	IQvAWxRS466c0oBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1D13513A7D;
	Thu,  2 Mar 2023 08:15:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id KFIRBxBbAGR9FwAAMHmgww
	(envelope-from <dwagner@suse.de>); Thu, 02 Mar 2023 08:15:12 +0000
Date: Thu, 2 Mar 2023 09:15:11 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [RFC v1 0/3] Unifying fabrics drivers
Message-ID: <20230302081511.apoyvinsfqxzimxm@carbon.lan>
References: <20230301082737.10021-1-dwagner@suse.de>
 <6e4fc38c-4b08-1f3b-f746-2fb4f2b4c2b8@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e4fc38c-4b08-1f3b-f746-2fb4f2b4c2b8@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230302_001516_434220_136D94AA 
X-CRM114-Status: GOOD (  18.57  )
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

On Thu, Mar 02, 2023 at 03:02:38AM +0000, Chaitanya Kulkarni wrote:
> On 3/1/2023 12:27 AM, Daniel Wagner wrote:
> > The two fabrics rdma and tcp share a lot of common code. This here is my attempt
> > to consolidate the common code.
> > 
> > I've picked just one function (setup admin queue) for this RFC to get a feeling
> > and feedback if this is a valid approach or if people hate it. I've left out fc
> > for the time being because it differs too much two the other two drivers.
> > 
> > I've tested quickly tcp, rdma is only compile tested.
> > 
> 
> It is really hard to give any feedback without seeing entire code.

Surely you can give some feedback, for example does this approach make sense, or
do you think we should reorganize the data structures?

> What kind of impact this will have on the current TCP offload series
> once it is merged ?

I don't expect a lot of impact at all. The common code between tcp and rdma is
the state machine code and not the transport bits. The offload code doesn't
touch any of the code I would touch.

See it's not so hard to give some feedback?

Daniel

