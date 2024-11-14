Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F79FD68B36
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Nov 2024 16:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q/BvYOIg9smXddK/+jBBJuNSYc/Mc5+hS6P9vT9OfXA=; b=bcOVsVVfzhyGlKbyIs+hn+vDAN
	wJ3DMv+FKDPNfU/7zblhilMP9WpIA/uSnLDwM0vDyowoDAPGn3r6OpEzIR/+uoOij89Hzbil94P2K
	gsLlTyUBz4rHrlpr51m6F2VHSkwt42+t1IQ4zWHhCoJod5CUKmIA/lNjtxcbl8Ai0J/CFFquY4vpo
	tEvvJ2hV++0mpU83eZpuYWe3+fe47rjeu7bNgKSGhmNLPaSGJ6gmGH5qTLfX/MOvoEW8nLQSehjpo
	EC3mQwqDq/trpikTzJBKh/GuU7YZxhpgL+W1BqGRalGNmiB+W9ggTzhE9XeRVG5iVV+Ho4coWXfN7
	OP1jX6Cw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBcvw-00000000B2a-3EfK;
	Thu, 14 Nov 2024 16:43:04 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBcs5-00000000AMa-0UNp
	for linux-nvme@bombadil.infradead.org;
	Thu, 14 Nov 2024 16:39:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Q/BvYOIg9smXddK/+jBBJuNSYc/Mc5+hS6P9vT9OfXA=; b=L35r05iF4CTTGdAnEIV8EyctHt
	EAs874dRZrsKg9ZiOfLFC+DWQrWj/Y6tEtDKEAwKqbgL2FCxxU8Te77CXR7buiCPoNIl8BCogBGHw
	F2YUOxBGHoOql70TxEUr2x+zz1tNVa46KEeTIBhXFMykDQ1Io/C6J5B9tYZX7Cyl8AT/SPhIt8b7P
	A/pY2ePUcs2l+Dnduh7EXnfdUjk6mTZiIYypnYFdpBoVv1y+BwI/uIQh636m8kB+ERW1iAxDg4IgB
	0s9uqNZem24lCvILjrPLvE7USoMY1iyYcj8GcsLqsdc17O3cGQjtecVtGJB24fFe6vsyegM20H2Ep
	gfoL0A+Q==;
Received: from verein.lst.de ([213.95.11.211])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBbdX-000000004Lz-3nyM
	for linux-nvme@lists.infradead.org;
	Thu, 14 Nov 2024 15:20:01 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5473668C7B; Thu, 14 Nov 2024 16:19:21 +0100 (CET)
Date: Thu, 14 Nov 2024 16:19:21 +0100
From: Christoph Hellwig <hch@lst.de>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Anuj Gupta <anuj20.g@samsung.com>,
	axboe@kernel.dk, kbusch@kernel.org, martin.petersen@oracle.com,
	anuj1072538@gmail.com, brauner@kernel.org, jack@suse.cz,
	viro@zeniv.linux.org.uk, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, linux-scsi@vger.kernel.org,
	vishak.g@samsung.com, linux-fsdevel@vger.kernel.org,
	Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v9 06/11] io_uring: introduce attributes for read/write
 and PI support
Message-ID: <20241114151921.GA28206@lst.de>
References: <20241114104517.51726-1-anuj20.g@samsung.com> <CGME20241114105405epcas5p24ca2fb9017276ff8a50ef447638fd739@epcas5p2.samsung.com> <20241114104517.51726-7-anuj20.g@samsung.com> <20241114121632.GA3382@lst.de> <3fa101c9-1b38-426d-9d7c-8ed488035d4a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fa101c9-1b38-426d-9d7c-8ed488035d4a@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241114_152000_056698_820CF674 
X-CRM114-Status: GOOD (  15.68  )
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

On Thu, Nov 14, 2024 at 01:09:44PM +0000, Pavel Begunkov wrote:
>> Eww.  I know it's frustration for your if maintainers give contradicting
>> guidance, but this is really an awful interface.  Not only the pointless
>
> Because once you placed it at a fixed location nothing realistically
> will be able to reuse it. Not everyone will need PI, but the assumption
> that there will be more more additional types of attributes / parameters.

So?  If we have a strong enough requirement for something else we
can triviall add another opcode.  Maybe we should just add different
opcodes for read/write with metadata so that folks don't freak out
about this?

> With SQE128 it's also a problem that now all SQEs are 128 bytes regardless
> of whether a particular request needs it or not, and the user will need
> to zero them for each request.

The user is not going to create a SQE128 ring unless they need to,
so this seem like a bit of an odd objection.


