Return-Path: <SRS0=iTsx=OX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3546C433F5
	for <linux-nvme@archiver.kernel.org>; Sun,  3 Oct 2021 10:19:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DED461B40
	for <linux-nvme@archiver.kernel.org>; Sun,  3 Oct 2021 10:19:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2DED461B40
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tCW3aHVocSirxQFyoKCeDZ0R4fCYaWIm2mMNgDXrYfQ=; b=TqhYwyNlt9PcF+
	szgP3Ygp22osqh0+JPPgPM8YqElluh/8M33tOOqQkcI6a1RseQDv4ipstmVwnWfc8ofohX88SwicA
	8ctpV1tYuXlPFyOz80CA4biLFOlh3I6/8sVFXZn4Hp9qfntec4nsrvk5MnC623TVY+fZSjB6l34Ur
	4ID+fq0GUnaq6vNkpGJNeSFdstyt6mMoqOz/DjELaX+YvQVIX86Qy/nynR+5y3YGztPlX1Q5Hn4DY
	B1C+kv9AZmKI3wPmoRK9UWjGlLE0WUjqyFzmWBwS7OnJYqtH3htSKZ/QOgcOH0IBYDFEoltR5Pij2
	wB5aRJlYQeTN72Ik3fSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mWyaN-003YZl-Ld; Sun, 03 Oct 2021 10:19:11 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mWyaK-003YYg-Kv
 for linux-nvme@lists.infradead.org; Sun, 03 Oct 2021 10:19:10 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 1EEC368B05; Sun,  3 Oct 2021 12:18:58 +0200 (CEST)
Date: Sun, 3 Oct 2021 12:18:57 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Logan Gunthorpe <logang@deltatee.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Stephen Bates <sbates@raithlin.com>,
 David Sloan <David.Sloan@eideticom.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [RFC PATCH] nvme: allow specific passthrough IOs without
 CAP_SYSADMIN
Message-ID: <20211003101857.GA10943@lst.de>
References: <20211001234017.4519-1-logang@deltatee.com>
 <f1e00f76-235a-e4b0-ce98-3eabe0a50ea3@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f1e00f76-235a-e4b0-ce98-3eabe0a50ea3@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211003_031908_882064_C88342B7 
X-CRM114-Status: GOOD (  14.82  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sun, Oct 03, 2021 at 12:29:22PM +0300, Sagi Grimberg wrote:
>> Users that want to send any of these passthrough commands will still
>> require access to the NVMe char device or namespace. Typically, the
>> char device is only accessible by root anyway and namespaces are
>> accessible by root and the disk group. Administrators are free to
>> add udev rules to adjust these permissions for specific devices they
>> want to allow.
>
> I don't understand what is the difference between VS commands and normal
> commands? Why do you consider VS commands safe to relax privileges as
> opposed to any other command?

They are different in that it is cometely undefine what they do.
So relaxing that checks is an absolute non-starter while for simple
things like Read it might be possible if we really care.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
