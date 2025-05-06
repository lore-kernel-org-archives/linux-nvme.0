Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E41B2C3ABBC
	for <linux-nvme@archiver.kernel.org>; Tue,  6 May 2025 18:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IHZn7Z4ecIgUYMvftdIgf5bc8WU89/3P1Mm0q/KINBE=; b=jIg/jnIAc3k5MqCsOCIINXhw0J
	9zteJmHyyPWcO+wx9/KgmQrAbhK8kZBsLOy5pZ62gCin/t6Wvh2aryWxjeR7cMXoSqdNrMnioYsgf
	aLKcwGIKWRI3YOO7PBhOiPiiu0qBm6HXeLcRlaqN0aUSZ07uXSuHXcJ7steguG3RaccAz6o6aTZeA
	/s1oK+fDCIlIF8XdkDumM6YN0eXdjC8lcfxq/vkIX1jS7uMteLRqYf+UUxyidWP9ST1m3BbrJM3lb
	nAfo8aAvYwUQ9T+UbWnQX5d+5XvqNPhCqwAsyD5afq/aTgb6VdT3GEZPGseX4GAUFxpXbmqjd4NNU
	NniLB5OA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCN0l-0000000D6F1-3pen;
	Tue, 06 May 2025 18:27:23 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCJGi-0000000CJyN-11jJ;
	Tue, 06 May 2025 14:27:36 +0000
Date: Tue, 6 May 2025 07:27:36 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	kernel-tls-handshake <kernel-tls-handshake@lists.linux.dev>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	linux-nvme@lists.infradead.org
Subject: Re: kernel TLS configuration, was: Re: [ANNOUNCE] ktls-utils 1.0.0
Message-ID: <aBocWAKRbttPeStt@infradead.org>
References: <oracle/ktls-utils/push/refs/tags/ktls-utils-1.0.0/000000-c787cd@github.com>
 <32e4bd99-a85f-4f53-94bd-b8c3ecf2c66f@oracle.com>
 <aBoCELZ_x-C4talt@infradead.org>
 <63b16277-d651-4f37-9e32-965dc6d1e7b0@oracle.com>
 <aBoYDS84d8N5STLq@infradead.org>
 <fb8862b6-97aa-43d0-882f-f0ab9f873e16@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb8862b6-97aa-43d0-882f-f0ab9f873e16@oracle.com>
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

On Tue, May 06, 2025 at 10:17:48AM -0400, Chuck Lever wrote:
> On 5/6/25 10:09 AM, Christoph Hellwig wrote:
> > On Tue, May 06, 2025 at 09:42:29AM -0400, Chuck Lever wrote:
> >> are very welcome. (But you do have to sign the Oracle Contributor's
> >> Agreement, unfortunately, to get the patches into ktls-utils).
> > 
> > I guess we should just for it, which would also take care of the
> > musl support?
> 
> My employer might not take kindly to that.
> 
> The "MUSL issue" isn't due to the OCA, directly. The developer got
> agreement from his employer (WD) to sign, he just hasn't gotten around
> to it.

the point is that any kind of CLA is completely unacceptable for
something needed in the core Linux stack.

Someone at your employer might have smoked some really bad stuff if
they thought it as a good idea and I don't think anyone gives a rats
ass if they take it kindly or not.


