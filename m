Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41798C021A7
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Feb 2025 06:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZxZ7yIDRNJAgWbQ5GgsBn7MOoc4zESUrMj92p2KKbqY=; b=K8X5yh4XJXjkzkWLoflTeyuCnF
	uzzKOhwa2dvEESiqI580Kr3LUSXvj8lRGc2IIyfVSQicvbGesLxhmq0IXBRleJA42ZOXqJO6ZNUag
	CHSM7JIcmaM9Ncov0cL2bLGQSvvINh5HSZnv4kiaxxggfZ5Hz04M+LgMpOM7CeWrqvNALWLtqMUDx
	dQdL/X50IffG6Nb4eQqi2EsJgUaR+xO1eU1+K0CijLMoiVBNQ00+V+MgSmrWbB/HWsy6YCBsyfu9v
	iyKijK/yUbHChxt/HFF1wU+MRHGM0k/GyttxHtIX8NCeYXkhMgcJ1YSgYAAJ7OP4X9jHhUUhWEi60
	OOPqeh9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tiSM1-00000009sxD-0w8J;
	Thu, 13 Feb 2025 06:05:41 +0000
Received: from sender4-op-o12.zoho.com ([136.143.188.12])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tiSLy-00000009swo-2gcX
	for linux-nvme@lists.infradead.org;
	Thu, 13 Feb 2025 06:05:39 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1739426735; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=SOE4TRFa2TT1u+QYUl904QDNAiTtKmRuP2LuKhtVoIZm9/26nWXP0uNIf/7EplHZ2wWEbXJOEZcnQ5nwJzfnqVn4uoUva8Qj3U6trmxy6DkOhT9UH8fHTjHfWbyKW7BLhI9RPtopaIZ4+Nx1ofzSJNthdJtq5TCQi/EYgz/2fVI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739426735; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ZxZ7yIDRNJAgWbQ5GgsBn7MOoc4zESUrMj92p2KKbqY=; 
	b=PMf9kXUPIgWIeqe8DN3a0LYmfvR5Bun+o5s2amCVnX/tOCGytjVdLXGgtNwzHd8v7gdXet+rOiCbuXfFSQCpj5M1YTn8/dmrlCj/4PcL+RRLpe1R0R+U3PUvolwLMLIah4NUt9CQ0MTIlgpd7N+f3VAJp0wexovbENlVz9LQbCw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739426735;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=ZxZ7yIDRNJAgWbQ5GgsBn7MOoc4zESUrMj92p2KKbqY=;
	b=p2iNpECGvV1yMkGWzjXYgatN8kdiskF42X4Mxa7FeCj+8TZ+VGtGrLi0EvxC2GfV
	A6hD7pdqN0zvFv3gAyUB8IdvUFEO9JRbCo9Jw64V4TkDjiwlOCg97onNIIK01Xn4Xg+
	PjBzBE5vG3OtUN5UweDcXOESpN58suVA96IdDmmSf0/G3DDtt1mjWBazJ7xNd3x2FNz
	rkxC+wjf1Siq+BB4HN997R+Ru9jzPJX/JEGyK7On9pxfQtoinlziwkaE0mC8McYKHYL
	e31hNq7w0YdTWZ4qIBg6YhjzIrcCseuM0QROStRHZyB/LhWYOThSG7zG4Olsfgsyrmx
	VBToN6zLLA==
Received: by mx.zohomail.com with SMTPS id 1739426734227256.68236209443637;
	Wed, 12 Feb 2025 22:05:34 -0800 (PST)
Message-ID: <150c3e85594e6256d4f3254bd4ef597612cf8428.camel@icenowy.me>
Subject: Re: [PATCH 0/2] Misc fixes on registering PCI NVMe CMB
From: Icenowy Zheng <uwu@icenowy.me>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Sagi
 Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
Date: Thu, 13 Feb 2025 14:05:29 +0800
In-Reply-To: <20250213055449.GB19370@lst.de>
References: <20250212170444.16138-1-uwu@icenowy.me>
	 <20250213055449.GB19370@lst.de>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
MIME-Version: 1.0
X-ZohoMailClient: External
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250212_220538_782974_252E3EC7 
X-CRM114-Status: GOOD (  12.10  )
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

=E5=9C=A8 2025-02-13=E6=98=9F=E6=9C=9F=E5=9B=9B=E7=9A=84 06:54 +0100=EF=BC=
=8CChristoph Hellwig=E5=86=99=E9=81=93=EF=BC=9A
> On Thu, Feb 13, 2025 at 01:04:42AM +0800, Icenowy Zheng wrote:
> > Here is a small patchset that is developed during my investigation
> > of
> > a WARNING in my boot kernel log (AMD EPYC 7K62 CPU + Intel DC D4502
> > SSD), which is because of the SSD's too-small CMB block (512KB
> > only).
>=20
> Hah, that's certainly and odd CMB configuration.
>=20

Sure, maybe it's just intended for a little queue. Register 0x38 value
is 0x00000004, Register 0x3c is 0x00080001, and BAR 4 is 64-bit
prefetchable memory with size=3D512K. I tested writing arbitary data to
the BAR 4's first few words and it correctly retains (which means they
seem to be really memory instead of registers).

I saw some mention of support CMB for submission queue in the brief of
Intel D3700/3600, maybe this applies to D450x as a successor?

BTW I am not sure about the relationship between Intel D series and P
series SSDs (only knows that D series is for dual-port redundancy), and
I have a P4511 as my boot disk (D4502 is data storage), which comes
with no CMB at all. (P4511 and D4502 shares PCI ID, but not PCI
subsystem ID).

