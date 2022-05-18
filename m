Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 667A0C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 18 May 2022 06:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RIywc+SxobWL+9khYXy2RCeZwG3Yuriq51ugyBiW/eE=; b=S5GNtSqnT1Nq64G7jhG6du+Sim
	MNe0Bv+pA1vhfNGXs++g1TYPpdBTHslEbwoz5YStROYABy8sTWIMsvfHK3r/3iBrStNCI+HtEkTZe
	FgSfqcxsJUyFf6kAm2C2a/dPLoXvG7T8MMs4vxIETsfIgTHnLNQqcMr41HAu3GKPHurbth+0yo4jf
	LLTUxFUDuOYTobN0ume7uhuPrUvYwwSXXTms3bwkPdZG8dqAZzSZGWPcqi0bG8YR/HE42CXuRFii1
	NqmqT5R+kXI7LZep+/9XbpYE0i1LM4I0fmZ3gSXOIWJbYL9rr3X0rDCSpG/YrPVJN3JpBO3NsjHNB
	2JSWeO/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nrDTk-00HTq7-RT; Wed, 18 May 2022 06:48:16 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrDTh-00HTnZ-SS
 for linux-nvme@lists.infradead.org; Wed, 18 May 2022 06:48:15 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E3B7C1F9A5;
 Wed, 18 May 2022 06:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1652856489; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RIywc+SxobWL+9khYXy2RCeZwG3Yuriq51ugyBiW/eE=;
 b=KiHATNiX7Zs7wxkRAjKPnlcOXJU6dzYiOi+HTNXnA4gZuZG/Z8K0dILuH0ju5wdPXNM1/9
 ksxXRJQJVofd1l+CqESTeCgfrKlVJ1r3dyItiPkBAOq76EQajE5dTB69BBzIe8twkmFm3e
 MydRH4ITX1y+w4TWEjib+vSqCNC/y4U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1652856489;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RIywc+SxobWL+9khYXy2RCeZwG3Yuriq51ugyBiW/eE=;
 b=YkYrr5K1Dvd0uPgbeVnuZ3BmoYcy3BUyHcW4pssCdmFWmr4U9PWbMjX/RL1T7wWy7XeINQ
 EHXwdvnC8rvq1ECg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C8B0613A6D;
 Wed, 18 May 2022 06:48:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id RSL4MKmWhGIvPQAAMHmgww
 (envelope-from <dwagner@suse.de>); Wed, 18 May 2022 06:48:09 +0000
Date: Wed, 18 May 2022 08:48:09 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Arthur Shau <arthurshau@fb.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Wei Zhang <wzhang@fb.com>, Venkat Ramesh <venkatraghavan@fb.com>
Subject: Re: [PATCH nvme-cli] ocp: Update license to GPL-2.0-or-later
Message-ID: <20220518064809.ssqyw3hmvmt3ngck@carbon.lan>
References: <20220517060256.6733-1-dwagner@suse.de>
 <DM6PR15MB290789265C9D82CC90216BD0B6CE9@DM6PR15MB2907.namprd15.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR15MB290789265C9D82CC90216BD0B6CE9@DM6PR15MB2907.namprd15.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220517_234814_103248_3EF03FCE 
X-CRM114-Status: UNSURE (   6.96  )
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

On Tue, May 17, 2022 at 05:51:48PM +0000, Arthur Shau wrote:
> Looks good!
> 
> Signed-off-by: Arthur Shau <arthurshau@fb.com>

Thanks Arthur!

