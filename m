Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EA3DC369C2
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Apr 2025 10:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Uqj0wYkgYZSApP9Itot822yeUPxKopnn9yM4s5SZbC8=; b=TQ9W4CEqePBUR4R9cUBdnATyVt
	bnLwteme35N92GXOiB9TuK2TtpsIUirUyyahL9M3j9mOr1+VAHHj3Z9o2lKLAvYqpiw1F5qV9xvw0
	l/VAZ/oabk820CdpfeUfGlQ17QmsdgbHQoI6q7ON28xwyAW6ZmftX0RihVy1MelSQetUn1s+KfnC8
	9LxxUuQ+qDz2wzUvl546pbIV6Vq9OAAG/aDUGso5CIGIlM863tFSA0DUv8IbQv3zFisLJghNwURrF
	Eyw055dIE7BYnyeibN70a/aio2U7G8/rIfx8Sg8NpfIBDHtB137zGRh7TBtit3U5UKj6A+N+HMPLS
	GCh5b+1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7As5-00000006loc-02XQ;
	Tue, 22 Apr 2025 10:28:57 +0000
Received: from redcrew.org ([37.157.195.192])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7ABf-00000006bcp-2fd9
	for linux-nvme@lists.infradead.org;
	Tue, 22 Apr 2025 09:45:09 +0000
Received: from server.danny.cz (85-71-161-19.rce.o2.cz [85.71.161.19])
	by redcrew.org (Postfix) with ESMTP id EF1ADE8;
	Tue, 22 Apr 2025 11:44:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 redcrew.org EF1ADE8
Received: from talos.danny.cz (talos [IPv6:2001:470:5c11:160:47df:83f6:718e:218])
	by server.danny.cz (Postfix) with SMTP id B061315E001;
	Tue, 22 Apr 2025 11:44:59 +0200 (CEST)
Date: Tue, 22 Apr 2025 11:44:59 +0200
From: Dan =?UTF-8?B?SG9yw6Fr?= <dan@danny.cz>
To: Hannes Reinecke <hare@suse.de>
Cc: linuxppc-dev@lists.ozlabs.org, linux-nvme@lists.infradead.org
Subject: Re: frozen PHB on IBM Power9 system in 6.15-rc2 (bisected)
Message-Id: <20250422114459.898a2d196abf19aff43dc1ae@danny.cz>
In-Reply-To: <a13592e6-0259-4c12-ab6f-0e014bd62b3b@suse.de>
References: <20250417171026.b4474b4e2d0b528411c0e508@danny.cz>
	<a13592e6-0259-4c12-ab6f-0e014bd62b3b@suse.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; powerpc64le-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250422_024507_824766_9210D2F4 
X-CRM114-Status: GOOD (  16.05  )
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

Hi Hannes,

On Tue, 22 Apr 2025 08:37:32 +0200
Hannes Reinecke <hare@suse.de> wrote:

> On 4/17/25 17:10, Dan Horák wrote:
> > Hi,
> > 
> > I am seeing "frozen PHB" on Power9 bare-metal (PowerNV ppc64le) system
> > leading to non-accessible nvme drives (they are behind a switch) in the
> > 6.15-rc2 kernel (originally with kernel-6.15.0-0.rc2.22.fc43). I was
> > able to bisect the issue to commit
> > 62baf70c327444338c34703c71aa8cc8e4189bd6 [1].
> > 
> > Please see [2] for full console log and other details. Please ignore
> > the "soft-lockup" messages, they are unrelated and going to be resolved
> > with [3]. We are building the kernel with CONFIG_NVME_MULTIPATH=y
> > 
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=62baf70c327444338c34703c71aa8cc8e4189bd6
> > [2] https://fedora.danny.cz/ppc/rdsosreport.txt
> > [3] https://lore.kernel.org/all/20250410125110.1232329-1-gshan@redhat.com/
> > 
> Already fixed with 'nvme: fixup scan failure for non-ANA multipath
> controllers', included in the latest pull request to Jens.

thanks for the pointer, will give it a try soon


		Dan

> 
> Cheers,
> 
> Hannes
> -- 
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
> HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

