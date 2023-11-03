Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 364FEC4167D
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Nov 2023 14:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OLQ0poeG2hTbjPAwCdQl/GpYvsYsztDaO+xenptZW2I=; b=Xa3RuY6skwBoXFHXXNbwq87O2T
	Sa7NcVc+kdVFUPJQEOwhxSm384lkYnvZIBSzck14w/Wy1CyXg6lXTtygVj3tdT4qF98T2wd+Bo33I
	PBZ4fnazqGiZDVr3sAKFAFh5Asdpnv27mqxyhD0iZxqeqVnxoZzNjBRR+Epic32cbO0hWmxTEkl6b
	xgmntBbE/D0L5BBE3ETV5GorJzcLxznMyZg6g/BrkDh1VVVLl6isCaJeOzZ3kv2AIrb2FAwa2AYgq
	ZgNai1f91WzxADWDBUvQcmCpoge9rqFglzoidLQO6gwJoxvh07w8GgcH6k3KnyGhiFh816rLO5d0K
	IDNJPnFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qyv43-00BZL2-28;
	Fri, 03 Nov 2023 14:22:23 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qyv40-00BZKI-2J
	for linux-nvme@lists.infradead.org;
	Fri, 03 Nov 2023 14:22:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id EC1B2CE2293;
	Fri,  3 Nov 2023 14:22:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED2CC433C7;
	Fri,  3 Nov 2023 14:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699021334;
	bh=i4n+Ca8lHKiU8bKf7X1drUsWnYBFo6sjVmEhJySGhLc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lBqtSDCsfrF7qq6D7S2hdg43EUXJkXtETu1ye6NCHLfGWUk5WFYCsZrUuYLqAsCG1
	 RFAFUs7K4GLdJK2NtMq9QdY9FWmbKwh1RcGWD6uf6w5GCk5YfS6pfJ7H6rO5/0O84X
	 WE1GGVz9XFPH42p9ClNiUBdTvuZG5JPovtUIPVNHyWJfcvARVmnRiLtNisMK+M6JYO
	 D1uAxNFEnuVvkamh3TYXPwYoS2xMnQL+NXtUFscHQrryhTKFX06y2oEfTKUd5JTp7Q
	 VEhFhuoYTTwYOfN0q4fzcAO16+d1NjbYo0dMXA6MeyfWwadRjGFOiZ56gR1cZSdtCF
	 770S+I+gJJoRA==
Date: Fri, 3 Nov 2023 08:22:11 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Niklas Cassel <Niklas.Cassel@wdc.com>,
	Kenji Tomonaga <tkenbo@gmail.com>
Subject: Re: [PATCH v3] nvme: update firmware version after commit
Message-ID: <ZUUCE88vOi6Wj69a@kbusch-mbp.dhcp.thefacebook.com>
References: <20231030160044.20355-1-dwagner@suse.de>
 <ZUEmlRnBVr9LGDnF@kbusch-mbp.dhcp.thefacebook.com>
 <y32ounthrv2uuedtriy73oir5m7k5ryupzytd2x5wn436bcrj7@7xalhdepjyk6>
 <20231103135857.GA1871@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103135857.GA1871@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231103_072220_943923_F573B0FE 
X-CRM114-Status: GOOD (  19.47  )
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

On Fri, Nov 03, 2023 at 02:58:57PM +0100, Christoph Hellwig wrote:
> On Fri, Nov 03, 2023 at 01:11:02PM +0100, Daniel Wagner wrote:
> > This particular firmware seem to interpret afi one based, while
> > the this patch assumes it is zero based
> 
> >   Active Firmware Info (AFI): Specifies information about the active
> >                               firmware revision.
> > 
> >   Bit 7    is reserved.
> >   Bits 6:4 indicates the firmware slot that is going to be activated
> >            at the next Controller Level Reset. If this field is 0h,
> >            then the controller does not indicate the firmware slot that
> >            is going to be activated at the next Controller Level Reset.
> >   Bit 3    is reserved.
> >   Bits 2:0 indicates the firmware slot from which the actively running
> >            firmware revision was loaded.
> > 
> > 
> > It's not clear to me if afi bits 2:0 is zero or one based. Bits 6:4
> > indicate to be 1 based.
> 
> All 0's based (what a stupid term..) fields in NVMe are explicitly
> marked as such.  And even if that wasn't the case I'd very much
> expect the same encoding for the two sub-fields.

Yeah, it's just the firmware slot number, taken literally. AFI = 1 means
slot 1, AFI = 2 means slot 2, etc... Slot 0 either has special meaning
(firmware commit SF field, or fw log AFI bits 6:4), or is reserved
value, like in Identify Controller FRMW.NOFS, and has no place in the FW
Slot Info log page.

Our first slot in the log page is defined as slot one, so we have to
subtract one from the AFI field to index into the slot array. I messed
up for not catching that earlier, but thanks for pointing it out now.

