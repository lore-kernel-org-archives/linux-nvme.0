Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F25B2C61DB6
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Aug 2026 08:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hERaj2BmXbj0+LKek4ymkL12rg4BBFMd1g+2rA7+L/g=; b=kj/KGXqhbKK2c4IYEzOKZNDW3M
	YkxNsxX/48Xf7+A1ksalCUoxUJyETV8YUCjDdFypHfVQR6tpGCcGunyuM44l+ux9KMVjSpftJUsiY
	7/3OT+bVzwgMAYC7JCc+48cLuilcb7LYoV08oYvEE0PiWg4LNpPQuv7ZLVwu4whwM5kwGTCcaxNDr
	UBOxlwxljT1P0QjCENWHAk+lhkoGAL0Hol0YpvizY0j4FbsrZIjsi3CvmCqsxml+NsvPskNpGjOFI
	9p1/fxzKCP61qifJE+XnvDqzaQSH03WJfzhYTjAE/TFubiqsf+mClhoIUTD2D6BxoQ9Yckq7la5KP
	rUz7k8hQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wymHM-00000000LiR-2ZW6;
	Tue, 25 Aug 2026 08:13:08 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wymHK-00000000LiH-2ElG
	for linux-nvme@lists.infradead.org;
	Tue, 25 Aug 2026 08:13:07 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B91EE4047A;
	Tue, 25 Aug 2026 08:13:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED4A21F000E9;
	Tue, 25 Aug 2026 08:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787645585;
	bh=hERaj2BmXbj0+LKek4ymkL12rg4BBFMd1g+2rA7+L/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=J+nWssY3UStREm4Un5szeWUOt+SSCI4IgiK56HmzFjhzJ9KZWRGdWYAYgIi6Mj27h
	 SDAE+aBo9XQI/YioJO3TXM5Py0TsHHs9/bZGj7ESoZMCO6pzqyNBTnggeYXL6mxfqL
	 YZLz3KlghTVNmCCVHa8Ql4m2OosZZQedUyDXNI8w=
Date: Tue, 25 Aug 2026 10:13:00 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Shivam Kumar <kumar.shivam43666@gmail.com>
Cc: linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Ibrahim Hashimov <security@auditcode.ai>
Subject: Re: Prior report for the nvmet-tcp unbounded SGL length fix in 7.3
Message-ID: <2026082540-kiwi-dyslexia-1ab5@gregkh>
References: <CA+ysrSKO9ufMWQ=s_xM_uh1OhKmEb8v0tOwYH+g2vtxeWqW8DQ@mail.gmail.com>
 <2026082412-matchbook-perennial-03af@gregkh>
 <CA+ysrSKxTa--qGNrZu5SPLner+OTvHYFjfuSRnFW+xkqnQ+VBA@mail.gmail.com>
 <2026082438-stank-rectangle-bbdf@gregkh>
 <CA+ysrSK0VHVfkCow8gtJ6djJhtL0VULngWm6uZ+J9ZUdKOXBWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+ysrSK0VHVfkCow8gtJ6djJhtL0VULngWm6uZ+J9ZUdKOXBWw@mail.gmail.com>
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

On Mon, Aug 24, 2026 at 02:18:44PM -0400, Shivam Kumar wrote:
> On Mon, Aug 24, 2026 at 12:54 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Aug 24, 2026 at 12:07:28PM -0400, Shivam Kumar wrote:
> > > Hi Greg,
> > >
> > > Just the CVE, if one is assigned to 4a3f002, being recorded as the
> > > reporter would be all I'm after.
> >
> > We do not have names/reporters on CVEs at all, we rely on the git commit
> > text, but also will be glad to link to any external documentation as a
> > reference if needed.
> >
> > But I think you got the git id there wrong...
> >
> > thanks,
> >
> > greg k-h
> 
> Understood, thanks for explaining.
> 
> A reference link would be great if a CVE is assigned. The relevant
> thread is:
> https://lore.kernel.org/all/CA+ysrS+fsJQ+4x7jHoSEX_tiYRQJC8LEhuH2stKA6Q4qSK-MWA@mail.gmail.com/
> 
> And apologies for the bad commit id, the correct one is
> 4a3f00262a044e8e15064b1a6860968bf0500bf4
> ("nvmet-tcp: bound SGL data length before allocating command buffers").

Please see:
        https://www.kernel.org/doc/html/latest/process/cve.html
for how kernel CVEs are assigned.

thanks,

greg k-h

