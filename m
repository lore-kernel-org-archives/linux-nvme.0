Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EFDBC3ABC0
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 09:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6R+/rzZGlEzyBHm38RJzx156qjs1ux1Xuk5DeVo6vl8=; b=khcNailJBztAtGvEgqE3ftADqv
	dXu2iHpx1+0lPbqLuF01WNiw09xsBLl7eaoHrrORrrBGTbSfFjar/1d75ClMHttlYu0GwveAuW6Ru
	/cfxWQieVPlB85OXD/uTnWC9KvoXZVjcq7b0bPmlTGavYyOvDSl0IlFVFXianVEz6FPZxmVBEP/YG
	NYs7vZ5CC34hSHQB3jD0kmvwwuYqDwyW4pE7D6Yo1moAPZRt2nJ8DtJjoWt/HAAtANXn05zAsL9ev
	Un0w4mheU50gF1RjrOVLNjBqfqR1APHOeMzibKBFwrl43uNI6oCCppOJ3vBk6K9OVes/HqApXONlS
	XMqWP/Qw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCae8-0000000Eq2i-2cb1;
	Wed, 07 May 2025 09:00:56 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCZfV-0000000EdFz-3s23;
	Wed, 07 May 2025 07:58:17 +0000
Date: Wed, 7 May 2025 00:58:17 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@infradead.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	kernel-tls-handshake <kernel-tls-handshake@lists.linux.dev>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	linux-nvme@lists.infradead.org
Subject: Re: kernel TLS configuration, was: Re: [ANNOUNCE] ktls-utils 1.0.0
Message-ID: <aBsSmc7W8Cx7n9md@infradead.org>
References: <oracle/ktls-utils/push/refs/tags/ktls-utils-1.0.0/000000-c787cd@github.com>
 <32e4bd99-a85f-4f53-94bd-b8c3ecf2c66f@oracle.com>
 <aBoCELZ_x-C4talt@infradead.org>
 <ee591788-e2fc-4407-9f78-d73a6f406438@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee591788-e2fc-4407-9f78-d73a6f406438@grimberg.me>
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

On Wed, May 07, 2025 at 10:50:00AM +0300, Sagi Grimberg wrote:
> Just so I understand, this is a separate issue from passing the keyring to
> tlshd correct? Is the suggesting that nfs will create a special .nfs keyring
> similar to what nvme does?

Yeah.

> Note that nvme also allows the user to pass its own keyring (never tried
> it before - we probably need a blktest for it //hannes). So in this case,
> the
> possessor will need to set user READ perms on the key itself (assuming that
> it updated tlshd.conf to know this keyring)?

I think so.  Or give user read permissions for the keys (which from
my limited undertanding renders the patches a bit useless).

Let me send out my current patches and discuss it there.

