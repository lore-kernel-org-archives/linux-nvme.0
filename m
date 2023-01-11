Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C37FDC46467
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Jan 2023 12:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Content-Type:References:In-Reply-To:Date:To:From:Subject:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZIBOUo4Wwdsj1b6qfl+WtYDAPLPVt1hwM/dh0jlpi9o=; b=prgTk1+4+XqWutzwxt0yb+Z68w
	BDSnyC+OINI7z4C4lOzuXco21WhcZK1F+1escK9qdtoK5mFxoGQ54JhlRnve6H/h7rxPLAeCiDaUP
	yrQhXHcPRJ9eppMdRpEvFSePIcMCAPu7Tl68nSqe75uB14MeTmvrYiIhFWDENtgP0IsIzDcCjrxCj
	aWrccN2FRSvrpR5XOh9kdYH9bcgSxFMYHEub/YiyQGZNzf0voDxWL254XICAQyHvHLpPVWJobcPu8
	9N6w5LehzYGj0z+S06q0b8BWZ9XhgEl5MynPeWRid6va+OG8pAor62Af+IlRwjGCgCzWHd2WW5fin
	Ekik7oCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pFadw-00BOCO-S1; Wed, 11 Jan 2023 12:55:48 +0000
Received: from bedivere.hansenpartnership.com ([96.44.175.130])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pFadt-00BO9S-GC
	for linux-nvme@lists.infradead.org; Wed, 11 Jan 2023 12:55:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1673441736;
	bh=15bnm4Ptwx3L0kPhiEQGs6ffDlqS9qM7HUNQGS2ztwU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=uk7P9Bt9PvhL7DPXUkq53QKSLXXTtHYTgpDJ4nJFcrQBT/D6D2zJJzD+MQyrv7Mdf
	 OFuC5ESTJmrGmhTr3JdpXLR8qgtwEQ1dWYh60a5ngU6hNq4Bk8CTJXPYVLN0gDCXm7
	 yl6b4jX5kNLjw/2DhvMcmXA34l3fRjNKMpqnxKSM=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 725D21285F58;
	Wed, 11 Jan 2023 07:55:36 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
	by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YdYPBYHkeX3w; Wed, 11 Jan 2023 07:55:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1673441736;
	bh=15bnm4Ptwx3L0kPhiEQGs6ffDlqS9qM7HUNQGS2ztwU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=uk7P9Bt9PvhL7DPXUkq53QKSLXXTtHYTgpDJ4nJFcrQBT/D6D2zJJzD+MQyrv7Mdf
	 OFuC5ESTJmrGmhTr3JdpXLR8qgtwEQ1dWYh60a5ngU6hNq4Bk8CTJXPYVLN0gDCXm7
	 yl6b4jX5kNLjw/2DhvMcmXA34l3fRjNKMpqnxKSM=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits))
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id AC4BF1280ECC;
	Wed, 11 Jan 2023 07:55:35 -0500 (EST)
Message-ID: <5230135e68bdf7b3fcbff78e7ffd51beebe509c8.camel@HansenPartnership.com>
Subject: Re: [LSF/MM/BPF TOPIC] Limits of development
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Hannes Reinecke <hare@suse.de>, lsf-pc@lists.linux-foundation.org, 
	"linux-nvme@lists.infradead.org"
	 <linux-nvme@lists.infradead.org>, linux-scsi@vger.kernel.org, 
	linux-block@vger.kernel.org
Date: Wed, 11 Jan 2023 07:55:34 -0500
In-Reply-To: <06e4d03c-3ecf-7e91-b80e-6600b3618b98@suse.de>
References: <06e4d03c-3ecf-7e91-b80e-6600b3618b98@suse.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230111_045545_593094_3BB8A268 
X-CRM114-Status: GOOD (  16.10  )
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

On Wed, 2023-01-11 at 12:49 +0100, Hannes Reinecke wrote:
> Hi all,
> 
> given the recent discussion on the mailing list I would like to
> propose a topic for LSF/MM:
> 
> Limits of development
> 
> In recent times quite some development efforts were left floundering 
> (Non-Po2 zones, NVMe dispersed namespaces), while others (like blk-
> snap) went ahead. And it's hard to figure out why some projects are
> deemed 'good', and others 'bad'.

It's not any form of secret: some ideas are just easier to implement
and lead to useful features and others don't.  It's exactly why we
insist on code based discussions.  It's also why standards that aren't
driven by implementations can be problematic: what sounds good on paper
doesn't necessarily work out well in practice.

> I would like to have a discussion at LSF/MM about what are valid
> reasons for future developments, and maybe even agree on common
> guidelines where developers can refer to when implementing new
> features.

I don't think anyone can give you this.  If it could be achieved then
all the standards bodies that are currently forced to deal with
implementations could happily go back to abstract proposals.

James


