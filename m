Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C8A4C3ABBC
	for <linux-nvme@archiver.kernel.org>; Tue,  6 May 2025 18:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yLfgEo5e51dsFgpTvqr2VoDFtYP7Qypd0vMn4KluLlk=; b=C6D8rAPt7XbxBa/8QJNFAt0qv7
	ZPTKLlo71qX+ab8oOg3uxlwiFOeRv7fEXo0TX3gC1da0lI471HMHlMfjWj+fiEfpCDQNeV1xMGvkg
	2C/xzAHOFVK7x/a8ngG5JQKhRc+b3Tf86LxAcZRIs5Dlxuh//8+UyPwYpmwzyhkGofMWwdmd0FVSk
	+bX6/aQCqcdYlHyzi/3UlPd4hy9OTpyA/hJ+P0bX8x7TITrdtonxpbEYG9w7ELmBFaH/w342HxKhy
	NwghnpAP7wAc2a/m6Q4c2EOh2XuwPzpTJO+cwPV6SlyP1+G0b9ngwPHFyglQisyxqViF/eJ992ycl
	Cheq8rDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCNAv-0000000D7th-3e2A;
	Tue, 06 May 2025 18:37:53 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCJSp-0000000CMA8-0KDx;
	Tue, 06 May 2025 14:40:07 +0000
Date: Tue, 6 May 2025 07:40:07 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	kernel-tls-handshake <kernel-tls-handshake@lists.linux.dev>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	linux-nvme@lists.infradead.org
Subject: Re: kernel TLS configuration, was: Re: [ANNOUNCE] ktls-utils 1.0.0
Message-ID: <aBofRwc5u-sqFgPY@infradead.org>
References: <oracle/ktls-utils/push/refs/tags/ktls-utils-1.0.0/000000-c787cd@github.com>
 <32e4bd99-a85f-4f53-94bd-b8c3ecf2c66f@oracle.com>
 <aBoCELZ_x-C4talt@infradead.org>
 <63b16277-d651-4f37-9e32-965dc6d1e7b0@oracle.com>
 <aBoYDS84d8N5STLq@infradead.org>
 <fb8862b6-97aa-43d0-882f-f0ab9f873e16@oracle.com>
 <aBocWAKRbttPeStt@infradead.org>
 <8094c0f2-3f83-45c0-9b1f-0cee682997d4@oracle.com>
 <aBoddkwEbyqGllOh@infradead.org>
 <8ad8cced-c5eb-45b9-b3d1-7409b3ae507c@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ad8cced-c5eb-45b9-b3d1-7409b3ae507c@oracle.com>
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

On Tue, May 06, 2025 at 10:39:00AM -0400, Chuck Lever wrote:
> On 5/6/25 10:32 AM, Christoph Hellwig wrote:
> > On Tue, May 06, 2025 at 10:31:04AM -0400, Chuck Lever wrote:
> >> I do. I can't burn that bridge and stay employed. So calm yourself,
> >> sir. Let me ask around.
> > 
> > No one expects you to support this.
> 
> That's just the kind of detail we need to decide before we can "just
> fork it" -- who will be the maintainer going forward?
> 
> 
> > But you should also not expect
> > much support for a project with a silly CLA.
> 
> I respect my employer enough that I think they deserve your feedback
> first before the rug is yanked. The best outcome would be that we have
> their permission to move this project somewhere more open.

That would be extremely helpful.  In the meantime I'm happy to host a
development branch freed from the CLA pains.


