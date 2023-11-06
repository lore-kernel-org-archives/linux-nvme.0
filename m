Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F91C4332F
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Nov 2023 06:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+p3StKUp0N4ggikwgytWyMwdQGjDE4+4rKwUV67bhsU=; b=KCqNmngPVsJ4GTmom5UK9HbhIY
	7BmQQO5tdG8Vcodru24E3cAaOl4iLc+UcXBf9R9Q2lk/qjdvb6ydM7stqGCJrkLoDOpmM1EKRSCGc
	wYgaXmMLs2MIxIfK3sKxYJGLZ1FVn9busY7d/NwF/27IwaaL1b1mX2dkm4B5luPqdeUOylvlqWlNE
	d7H/bmI2yv69IgOV3pniLitN7eJrmD2CAURvUA83b0pZ/nte0QsUpZz8xu0S9teP3Hc1ub9FFxagj
	bLktrF+Ud4VNi8NA3LEHZCcm7wU1E667s1MFXbUAZaFG/GTK5fUWbZHRTDwjOlWreTYjZyeX33YaF
	yLSmbeeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qztZh-00Fy9P-34;
	Mon, 06 Nov 2023 06:59:05 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qztZf-00Fy92-1t
	for linux-nvme@lists.infradead.org;
	Mon, 06 Nov 2023 06:59:04 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2E5F32183B;
	Mon,  6 Nov 2023 06:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1699253940; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+p3StKUp0N4ggikwgytWyMwdQGjDE4+4rKwUV67bhsU=;
	b=PuVxkGtZdtGmu2UK2oJtGPxV3OeuBHA8hWosz3VO6B72F8zNW073K8Pa/ruiqVQJ/OqNy/
	vj1QFwOl2uPr2r+rDNVn4B+wgYXobgM/SPA8yf794+WHH//u21oGTrWHT+CkRQuNabeNSx
	0J5OXt+lPSTkAEYLERd/qKf3oHTNJs0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1699253940;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+p3StKUp0N4ggikwgytWyMwdQGjDE4+4rKwUV67bhsU=;
	b=rH1xXDK1/rY2sTVfHR8aJIYhU5jI+sDMzb34PHQNE+F4UMqEXZlQlOt+MO+WVKYECRBlk/
	byzUjO0xxZ3jFGDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 20B3A138E5;
	Mon,  6 Nov 2023 06:59:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id vyT3B7SOSGVDMAAAMHmgww
	(envelope-from <dwagner@suse.de>); Mon, 06 Nov 2023 06:59:00 +0000
Date: Mon, 6 Nov 2023 08:00:44 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Niklas Cassel <Niklas.Cassel@wdc.com>, 
	Kenji Tomonaga <tkenbo@gmail.com>
Subject: Re: [PATCH v3] nvme: update firmware version after commit
Message-ID: <gwyjg43fnkzhrxmeub7zdoikvwfpatdrmaaoaqggdlfgopnpki@uba2ulvqruk3>
References: <20231030160044.20355-1-dwagner@suse.de>
 <ZUEmlRnBVr9LGDnF@kbusch-mbp.dhcp.thefacebook.com>
 <y32ounthrv2uuedtriy73oir5m7k5ryupzytd2x5wn436bcrj7@7xalhdepjyk6>
 <20231103135857.GA1871@lst.de>
 <ZUUCE88vOi6Wj69a@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUUCE88vOi6Wj69a@kbusch-mbp.dhcp.thefacebook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231105_225903_791667_D4D27A63 
X-CRM114-Status: GOOD (  14.53  )
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

On Fri, Nov 03, 2023 at 08:22:11AM -0600, Keith Busch wrote:
> > All 0's based (what a stupid term..) fields in NVMe are explicitly
> > marked as such.  And even if that wasn't the case I'd very much
> > expect the same encoding for the two sub-fields.
> 
> Yeah, it's just the firmware slot number, taken literally. AFI = 1 means
> slot 1, AFI = 2 means slot 2, etc... Slot 0 either has special meaning
> (firmware commit SF field, or fw log AFI bits 6:4), or is reserved
> value, like in Identify Controller FRMW.NOFS, and has no place in the FW
> Slot Info log page.
> 
> Our first slot in the log page is defined as slot one, so we have to
> subtract one from the AFI field to index into the slot array. I messed
> up for not catching that earlier, but thanks for pointing it out now.

Thanks for the clarification.

Do you want me to send a follow up patch, a new version of this one or
do you fix up yourself?

