Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AE0AC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 17 May 2022 06:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aeU3VoXUXZKdsv2GJJoS5Rv0ysce6O+QxLYOfJv4X4o=; b=hJ4QsYwqwrJ/Zg8NGwupXy/+r+
	m3HbyzIV4pVb7MnNFjNfe7+n6Gvtz00Ucj1LZW7HZkkqZLEz13Rp74wDWLdw1R4Rs6gOfwcfxNHZg
	RfmKhgL3L/dAscFL3bGom6Rno1xxLUYEw1ejMlPa+WlTFxl8dO4agSoZoVqYAB5JWCX1rgF+O9DuV
	C1rZV2EA6ZMz7/3g5PLOB15JZ5VYVYcb2Sxkm9jSflKRigQ36KTWItEGWRG3rl5t/qF/TM1g7AxkH
	pNu+i2AOYud3pOC9aDCIppPcO6p1RpPs/132jJlj2Gfw9YGoChiLdDMQ8hKXLaiFJlpZSbVcX8VUG
	80VPB1uQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nqr91-00BwXy-Bl; Tue, 17 May 2022 06:57:23 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nqr8w-00BwVR-Vq
 for linux-nvme@lists.infradead.org; Tue, 17 May 2022 06:57:20 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 973A321FD9;
 Tue, 17 May 2022 06:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1652770636;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aeU3VoXUXZKdsv2GJJoS5Rv0ysce6O+QxLYOfJv4X4o=;
 b=oRKdPDmIyHac+91X4pyeFresFqS607s1+r39s684KHOdsED4+GJPPdsCbrDNnoS6WRQ/eJ
 D5Oc4fbwTQOSZ0qQrkLO3I/gpmyDLDlDky6Mo921kT77tpMp29I754Fbnq3yiOwSMpnnGu
 1eHQNQ/P5Zjv/CR1O3mvHxmNuhS8RuM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1652770636;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aeU3VoXUXZKdsv2GJJoS5Rv0ysce6O+QxLYOfJv4X4o=;
 b=pCOoV0Z2YOrTejKvwErPrybw9a4ULDvAWXOK8JsOk3efv/Bz52R7lNLnoh8EyZ9GINohej
 tn4V26ae5XjLoMAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 87ECF13AA2;
 Tue, 17 May 2022 06:57:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id QFEVIUxHg2LwZQAAMHmgww
 (envelope-from <dwagner@suse.de>); Tue, 17 May 2022 06:57:16 +0000
Date: Tue, 17 May 2022 08:57:16 +0200
From: Daniel Wagner <dwagner@suse.de>
To: "Hanumanthu Hanok (hanumanthuh)" <hanumanthuh@micron.com>
Cc: linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-rpmb: Update license to GPL-2.0-or-later
Message-ID: <20220517065716.o3z3ebflxnr5olqp@carbon>
References: <20220517062806.9448-1-dwagner@suse.de>
 <DM6PR08MB4764309003A593FC20D4E144D0CE9@DM6PR08MB4764.namprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR08MB4764309003A593FC20D4E144D0CE9@DM6PR08MB4764.namprd08.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220516_235719_233242_8125D0D7 
X-CRM114-Status: GOOD (  25.24  )
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
Reply-To: 20220517062806.9448-1-dwagner@suse.de
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Hanu,

No idea if your reply to the mailing list will be granted. So let's just
let me reply on the mailing list.

Thanks a lot!
Daniel

On Tue, May 17, 2022 at 06:46:40AM +0000, Hanumanthu Hanok (hanumanthuh) wrote:
> Daniel, 
> I am not part of the linux-nvme mailing list (my request is still pending) so using my official address.
> Please feel free to add 
> 
> Signed-off-by:  Hanumanthu H <hanumanthuh@micron.com>
> 
> to this patch.
> 
> Best Regards
> Hanu
> 
> -----Original Message-----
> From: Daniel Wagner <dwagner@suse.de> 
> Sent: Tuesday, May 17, 2022 11:58 AM
> To: linux-nvme@lists.infradead.org
> Cc: Daniel Wagner <dwagner@suse.de>; Hanumanthu Hanok (hanumanthuh) <hanumanthuh@micron.com>
> Subject: [EXT] [PATCH] nvme-rpmb: Update license to GPL-2.0-or-later
> 
> CAUTION: EXTERNAL EMAIL. Do not click links or open attachments unless you recognize the sender and were expecting this message.
> 
> 
> The project is using the GPL-2.0-or-later license. Relax the license requirement to GPL-2.0-or-later.
> 
> Cc: Hanumanthu H <hanumanthuh@micron.com>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
> Hi Hanumanthu,
> 
> Would you mind to singed-off-by this change?
> 
> Thanks,
> Daniel
> 
>  nvme-rpmb.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/nvme-rpmb.c b/nvme-rpmb.c
> index 1ae262af95a5..8f6e6a0fa3b2 100644
> --- a/nvme-rpmb.c
> +++ b/nvme-rpmb.c
> @@ -1,9 +1,11 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * Copyright (C) 2020 Micron Techology Inc. All rights reserved.
>   *
>   * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License version
> - * 2 as published by the Free Software Foundation.
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
>   *
>   * This program is distributed in the hope that it will be useful,
>   * but WITHOUT ANY WARRANTY; without even the implied warranty of
> --
> 2.36.0
> 

