Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0205CA0EE4
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Aug 2025 19:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3tTM9zVWXk5JWZ/zP3y0Q3J1/JvGGP8VWuPQP6NGfII=; b=eCE4AHbU7+w3LfHXL2r+wXCrs3
	0UcnxShsdB0AUfjGrAOoW/rGQ9oM2/UFwgvBeTupxpubHSOtRS7JAXp4IXmyZSaGpqr8RplcGOv+4
	hJe6ujosucgm1oxwLyjvZbnVNFj7w1SsuIYnRAnP/BT7bqyIfAwoj5U0rK/KnsuUK43NWRjynumAc
	zaoYBbJUd/1OzLQ00Wvl+iAD906XSK3UpQyi7ioen9QgO8rlarE8HA5zOkolhvq0j3NfUaRHDyzLk
	Z4d+7zGIIiolpBcrDwbNNKNBh0x+zrbfVWzBoQBJRGXmbKpTnOza8UTgrccF2JElBt9e9kpw4IK7F
	z6KCwxeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uo5fI-00000008XII-1PCr;
	Mon, 18 Aug 2025 19:37:08 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uo53s-00000008Qpd-3Du1
	for linux-nvme@lists.infradead.org;
	Mon, 18 Aug 2025 18:58:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 2600345549;
	Mon, 18 Aug 2025 18:58:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A74BC4CEEB;
	Mon, 18 Aug 2025 18:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755543507;
	bh=MPaIFepjtKBrXc6mf7qbOE8EkzC+VzXEcskg14nM3Lk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OmjKFCdx9HlvrOsi89BI1UyUSpDJ8INJ1uewRBINLS50kXwyxt+HsVgCPWri6mdHe
	 f+54Wuq2j2q6HbBTRhmNbMnkllqX74QUBCEaZpcbcKuWOMeXsnBlfPgbnT46YWnmAw
	 K394B3fN4SHNRRaKkY6g28wKrK04Gb6yHpoOddSHRrb7Wy3tz0KRGTMDuXKZ2UC6TR
	 L6un5qNJI+0B6UPw/pi4Gh588lKO9WtPqp5McI2whIWTAmdbmKK9RiWvzapuHjdaaT
	 b6DvrhG9JYEf3VSZiit0iUzUkuMvfHSnr6dvJqyleszeJMXIRJI9cig8SFZi0p71Q4
	 jb/hkRggNiU2Q==
Date: Mon, 18 Aug 2025 12:58:25 -0600
From: Keith Busch <kbusch@kernel.org>
To: Diederik de Haas <didi.debian@cknow.org>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG report] kernel warnings with Samsung 970 EVO 2TB SSD
Message-ID: <aKN30RVeM3p5NJm1@kbusch-mbp>
References: <DC3TO97G0RMI.3KKUONOCLJHFB@cknow.org>
 <aKCFjzai3Y0RcGHP@kbusch-mbp>
 <DC3WVB8IOMNV.14F1RIJHNO33Q@cknow.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DC3WVB8IOMNV.14F1RIJHNO33Q@cknow.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250818_115828_823446_1E19272A 
X-CRM114-Status: GOOD (  24.41  )
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

On Sat, Aug 16, 2025 at 04:11:00PM +0200, Diederik de Haas wrote:
> On Sat Aug 16, 2025 at 3:20 PM CEST, Keith Busch wrote:
> 
> > If you want to see what the driver is reacting to, you can check the
> > subnqn from command line:
> >
> >   # nvme id-ctrl /dev/nvme0 | grep subnqn
> >
> > It'll probably be all zeros. The field has been required by spec, but
> > the driver tolerates ones that don't implement it.
> 
> root@nanopi-r5s:~# nvme id-ctrl /dev/nvme0 | grep subnqn
> subnqn    :
> 
> So it seems to be just empty?

They, it's interpreted as a string. All 0's would be an empty string.
 
> > It's just a message that the device isn't spec compliant, but
> > otherwise perfectly operational.
> 
> But still worthy of a warning (instead of info) msg?
> 
> The other kernel warning is this:
> 
>   nvme nvme0: using unchecked data buffer
> 
> The SUBNQN message appears every time, this one appears often, but not
> always.

That one means you've sent a user space passthrough command to a device
that doesn't support SGL DMA. Without that, the nvme protocol uses
implicitly sized DMA that the driver can't be sure is accurate. The user
could theoretically provide a short buffer that can corrupt memory if
done by accident, or be used as an attack vector if done by malicious
software.

This is also not something to worry about unless you run malicious or
buggy software.
 
> When researching this/these issues, I discovered the nvme-cli package
> (with the nvme command) and via its manpage I found this command:
> 
>   nvme get-feature /dev/nvme0 -f 3
> 
> I didn't even know NVMe's had namespaces, but this didn't look good:
> 
>   The namespace or the format of that namespace is invalid(0x200b)
> 
> ... without actually understanding what it means and/or what its
> consequences are. It could be harmless and/or normal though.

The feature you're requesting is the LBA range, which is namespace
scoped. You need to specify a namespace id, either by opening the
namespace's block device (/dev/nvme0n1) instead of the admin handle
(/dev/nvme0), or you can manually specify the namespace with paramters
"--namespace-id=1" or just "-n1".

