Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E842C4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Dec 2022 21:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BOl6ICJ8RqdJV/GOC1RaekskBBpoDf7iE7ORiDpKG5M=; b=a2p7XPNA2WCvOOyQKb97rYKoax
	LcE00KFITaVmClk2HBKBHwjmEDyTrac9kOnRj47UAz7TY86IDxwM2jaGLpkkRuOeKS3xB607p+DOS
	nNXuI9EAOMVFEPOvoKKw5/3wVRCHKFC/ovXAH4Vi2gykCyGkZttWqmVj+7tpL+2CopQwq2C6oIU2r
	j9mEbxPyAvy6DOFDrb4Z0fsxXab/tS+F5hxATZXSw0OPODKVTrlTAZ9xHLhHYI2ILbs/Ya9wqj9Iu
	6swqLGp4ms8LogNyifQaOwBtG2qQAMqUni2+8+JkLRaYW89H/npP3gqa7kQfXEUbUJeCanigV7v5G
	nRZ8//8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p8TVf-00HTzP-AV; Thu, 22 Dec 2022 21:53:51 +0000
Received: from ms.lwn.net ([45.79.88.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p8SaQ-00H81v-2G
	for linux-nvme@lists.infradead.org; Thu, 22 Dec 2022 20:54:43 +0000
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id A1715774;
	Thu, 22 Dec 2022 20:54:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A1715774
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1671742476; bh=BOl6ICJ8RqdJV/GOC1RaekskBBpoDf7iE7ORiDpKG5M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=opBNAa42RBXIgcq6/Wg3Wpkatc+UgO6KGWwH/W1NGxg8UlxYjdfHc3b/ECEkJOA96
	 oKIbeDIfKwNEYyBR4dF88k9GtXuVx2OKnWARuS478xNZn9ArfsmOCZm6I7OErHrmLX
	 vh00GCngBsJY+etnO0p3KN7UaujLje7WhZbxWrcG9BUSm7eWRaNo8oC6FXGAwTNnLY
	 uJlU22BEshbtF0J/R4NhDLGq7msohT105z0dniqiB/u9vEbnpyohLtiLNhoTJUv/4B
	 8gAcsLIdpoI7MJDqdjomF1XRHl3AV0VWnqN8mXAh+ZedKourXzUgsqWR8nqx9b9MBG
	 cdi3W/pIl9Kpw==
From: Jonathan Corbet <corbet@lwn.net>
To: Christoph Hellwig <hch@lst.de>
Cc: Christoph Hellwig <hch@lst.de>, axboe@meta.com, sagi@grimberg.me,
 kbusch@kernel.org, linux-nvme@lists.infradead.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Jens Axboe
 <axboe@kernel.dk>
Subject: Re: [PATCH] docs, nvme: add a feature and quirk policy document
In-Reply-To: <20221222160920.GA10193@lst.de>
References: <20221215125130.261098-1-hch@lst.de>
 <87zgboddb7.fsf@meer.lwn.net> <20221215132622.GA21083@lst.de>
 <20221221083450.GA23903@lst.de> <87mt7g27lv.fsf@meer.lwn.net>
 <20221222160920.GA10193@lst.de>
Date: Thu, 22 Dec 2022 13:54:35 -0700
Message-ID: <87zgbfma5w.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221222_125442_179198_563B646D 
X-CRM114-Status: GOOD (  17.05  )
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

Christoph Hellwig <hch@lst.de> writes:

> On Wed, Dec 21, 2022 at 06:45:32AM -0700, Jonathan Corbet wrote:
>> Sorry, the argument is that the subsystem profiles there were created
>> for the very purpose of documenting subsystem-specific patch policies
>> like those found in your document.  The hope is that, someday, people
>> will be able to go to one place to learn what special hoops any given
>> subsystem will make them jump through.
>> 
>> This isn't something I'm going to dig in my heels on, though.  But at a
>> minimum, could you add an entry to
>> Documentation/maintainer/maintainer-entry-profile.rst ?
>
> What about the following?  This moves the file to a new
> Documentation/nvme/ directory and then links it form
> Documentation/maintainer/maintainer-entry-profile.rst:

I'm not really a fan of adding more top-level directories; one of these
years I'd like to try to move things in the opposite direction.  That is
a battle for another day, though; for now let's just go with this and
get the document merged.

That said, I suspect you'll add a build warning about the new document
not being included in any toctree.  Fixing that would involve adding a
basic index.rst to the new directory and adding that to a file like
Documentation/subsystem-apis.rst.

Thanks,

jon

