Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 047B7C77B7F
	for <linux-nvme@archiver.kernel.org>; Wed,  3 May 2023 09:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1PDsSAco8cHUixikjZOolUtD+5H8EiTfwaQidAB+Qko=; b=ACWCcPV5nbOrHqa7j2nU7Ko0NI
	3eGzzdyuCJTn0Jo3PJj4j4+LilhFJSRFmjWSuHBuSQs94xKYGWFvHEd05RpoJjfWao6jXI/4wK+Ml
	jt5sH5Ub3qLMUk7TyIjTBCI/fBTVfdEeh0vxT99L3iiOHBdGa/xRLvljAju7ukg+bMO6M8mt7Z4yG
	GoUPBecD3t26lVkr1pC2st4pmKArGRfx/IAeksPVQhsTBOs4yfI0PKaLphFqdR98CSVLdzHKNScuh
	V79mGUQMPF9V2A0Je/SNdqRDVN6K2bstiRPx4QV9AiRNsJxiNIGJqbAVzoa6Zg0GVcr7vNieWpcn+
	QsDdqDLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pu8l2-0040Jz-1M;
	Wed, 03 May 2023 09:26:44 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pu8kz-0040JQ-2C
	for linux-nvme@lists.infradead.org;
	Wed, 03 May 2023 09:26:42 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0FC92224E9;
	Wed,  3 May 2023 09:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1683106000; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1PDsSAco8cHUixikjZOolUtD+5H8EiTfwaQidAB+Qko=;
	b=1RnvefgQoYI61aYy0NCfmMqi2RGDq3YmAqwQE8zGGB4EISiw9cMvq+D42rr75UNO1J7OL+
	MwHk9DHqe7/9TGLVKtigHbETACiNwhiuFM76xv6wJ5QxLUQJ0W2hDNiyn8HAbWqb/QWErA
	CDsMDCcqlgS5HHd7XdsyHKEwi3m0uo4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1683106000;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1PDsSAco8cHUixikjZOolUtD+5H8EiTfwaQidAB+Qko=;
	b=dcpOmmQZgay41/gjTazJQbd9fzWz2TLkx+O2T2ReVo3wPHdmik6n+qdWruOJDNbp0chFMG
	1NrTPqZeQJMcWWBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 001B21331F;
	Wed,  3 May 2023 09:26:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 8/V/O88oUmT1EwAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 03 May 2023 09:26:39 +0000
Date: Wed, 3 May 2023 11:26:39 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	Shin'ichiro Kawasaki <shinichiro@fastmail.com>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v3 01/12] nvme/rc: Auto convert test device size
 info
Message-ID: <w4cdwu5ol4gbwdwyig5rk76xvqqe3xzpolcvbypfjkzl47mgwx@dhztqv36j3xu>
References: <20230503080258.14525-1-dwagner@suse.de>
 <20230503080258.14525-2-dwagner@suse.de>
 <c7532fd7-f9da-b8b3-a7d1-b72c18d8df11@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7532fd7-f9da-b8b3-a7d1-b72c18d8df11@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230503_022641_872019_FB1756F4 
X-CRM114-Status: GOOD (  11.96  )
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

On Wed, May 03, 2023 at 09:22:07AM +0000, Chaitanya Kulkarni wrote:
> On 5/3/23 01:02, Daniel Wagner wrote:
> > Introduce a convert_to_mb() helper which converts the size argument
> > to MBytes and use in test device require function. This makes it
> > possible to use user input strings in future.
> >
> > Reviewed-by: Hannes Reinecke <hare@suse.de>
> > Signed-off-by: Daniel Wagner <dwagner@suse.de>
> > ---
> >
> 
> Much needed mb helper, looks good.

I am sure the helper can be written way smarter but my shell-foo
skills are a bit limitted. Still a starting point :)

