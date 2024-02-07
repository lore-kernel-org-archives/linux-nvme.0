Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57BC3C4829B
	for <linux-nvme@archiver.kernel.org>; Sun, 11 Feb 2024 16:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	MIME-Version:Message-ID:Subject:To:From:Date:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0eve9TSICHlgGWraOmtO+lqctetBC9VEkOfBIvtM2+w=; b=bvybnTkqpZ+8/iF9NVQy0p4L9M
	4eESiRBw/bUTJxI3pIcXtN4ac7iixiliOsffQXrHNMz+RwIZWiEfCtrHgHbDCxTN2U2ep0685lmr8
	eKjE2vQKKxnOEW6cNm9+05N0KF/hhmNWnkeTvBYOfaf9tKqtwogZu655Jfmd00QroRc5kd2K3aiFj
	DodaT61pPayMJn5wqfuWj7UYBNCO7xSVwogMAu3U58JScGS16KRuOSpCRCp+4/gx7Dlz6f+L8VKYO
	k7dI76sCQ7Lbddag+FQVONJNXa+Y/tGpUAoNS3C6VG8i2SS1OH8fCk0lceF+sbAa1WlvX0h2yzFiY
	4mtW8AOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZCNP-00000002zEq-33u2;
	Sun, 11 Feb 2024 16:08:19 +0000
Received: from hr2.samba.org ([2a01:4f8:192:486::2:0])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXoii-0000000BlTa-2gfE
	for linux-nvme@lists.infradead.org;
	Wed, 07 Feb 2024 20:40:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Message-ID:To:From:Date:CC;
	bh=0eve9TSICHlgGWraOmtO+lqctetBC9VEkOfBIvtM2+w=; b=104iJj7NyFHC09OKYx7sqURpGn
	LoAqNeSHp6PT1d7ICxQkKqgtjjbew25Lbk3+Fwwhouej7+jtN9Tw94BFpJXMGGbPhZnPD4+LOdEts
	0jxM+qkYiJrKOh8Yu08xn4GNffUjccjRTncdjY4iCu5dq1wLLcDoV5djIVMmkqmXIDfyNPqPvDS4Z
	+snKttQnRYfPazWWE9TndLaee4kF9ZdgJttm50Ys36fL74zyEpseC05kk2gvA4iCAEMpWxrbUEHfD
	qi76KTNHtamhZv2MhtYMjzlYMKNmPyX6nFahCWFCPfZt6+6t5Hbn77NnyfPGzWcczY/Mo2Q9ke3jn
	w5Y9A/pZ+TasKLn8ZPaJp88sdCFFTzRESmLnRhiCGqwNbanpPm5LSRT5agAGgfSgC7LOPGaoqSYIc
	oWrfX7sOCzoMxkdYPFfBrxzjlZe7YQQF1ioShzIcMWhyWuZAED4SJ0GSid9/kdY4WAxslROPW8RWT
	g7R4wb4vhUwHGDmf0mPMNWlL;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1rXoiR-00C0sD-1i;
	Wed, 07 Feb 2024 20:40:20 +0000
Date: Wed, 7 Feb 2024 12:40:15 -0800
From: Jeremy Allison <jra@samba.org>
To: jallison@ciq.com, jra@samba.org, rafael@kernel.org,
	tansuresh@google.com, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, djeffery@redhat.com, hch@lst.de,
	gregkh@linuxfoundation.org
Subject: Re: [RFC PATCH 0/6] async device shutdown support
Message-ID: <ZcPqr+9hqH1UXdwr@jeremy-HP-Z840-Workstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-Bad-Reply: 'Re:' in Subject but no References or In-Reply-To headers
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240207_124036_690410_5937E4BF 
X-CRM114-Status: UNSURE (   9.18  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Sun, 11 Feb 2024 08:08:17 -0800
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
Reply-To: Jeremy Allison <jra@samba.org>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> This is another attempt to implement an acceptable implementation of async
> device shutdown, inspired by a previous attempt by Tanjore Suresh. For
> systems with many disks, async shutdown can greatly reduce shutdown times
> from having slow operations run in parallel. The older patches were rejected,
> with this new implementation attempting to fix my understanding of the flaws
> in the older patches

Hi David,

It may have escaped your notice that I was shepherding a newer version
of Tanjore's original patchset through the nvme lists already. Please
look at version 5 here (I am working on version 6 currently).

https://lore.kernel.org/linux-nvme/20240129181953.1183084-1-jallison@ciq.com/

As your work is very similar (although has some of the same problems
that people already asked me to fix in earlier versions of the code)
maybe we can collaborate on getting a unified version of this work
reviewed.

Please take a look at the link above, and see if we can merge our efforts.

Thanks !

Jeremy Allison / CIQ.
Samba Team.

