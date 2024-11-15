Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FAA5D68BCD
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Nov 2024 17:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qmPNXSMBcRF3EPs2ymFbYDP8FJ/tORd+2iTLP4nXqaI=; b=BEZk2E5+rIDqApz7rYmf6kTvxD
	EmdcID4H7qCiuuOcD2mtFA7v354rOhGdlSAfnPvKEKph/0D2kqTLjMTALv1hzqgJDAzfuX7vJ0yB1
	L6wHhSigkXnSUGndfMWOQH64JkWg+68zSc+cMZ5R+vcgdgc/rxuDEQRt1FiCy8YFSn1tAz7gyL07w
	pRM+Ui9Vf4r0mKJg177bH0U1TRWfRXDb3+cBtKCwjzYcEaEKt562dUnLdD+ZBzg7U5Mvt7iabSre+
	4GNL4pIL9VZ7wVF/QnK/H3M/UX0em3Waci8+LUJonyrBhufzWCEXvnS1Zc3eMB9sQ8QSzNui3UsIT
	R1H7CSTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBzrf-00000003VNi-4B93;
	Fri, 15 Nov 2024 17:12:11 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBzrd-00000003VMd-36wx
	for linux-nvme@lists.infradead.org;
	Fri, 15 Nov 2024 17:12:10 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 644E668D12; Fri, 15 Nov 2024 18:12:05 +0100 (CET)
Date: Fri, 15 Nov 2024 18:12:05 +0100
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
Message-ID: <20241115171205.GA23990@lst.de>
References: <20241114104517.51726-1-anuj20.g@samsung.com> <CGME20241114105405epcas5p24ca2fb9017276ff8a50ef447638fd739@epcas5p2.samsung.com> <20241114104517.51726-7-anuj20.g@samsung.com> <20241114121632.GA3382@lst.de> <3fa101c9-1b38-426d-9d7c-8ed488035d4a@gmail.com> <20241114151921.GA28206@lst.de> <f945c1fc-2206-45fe-8e83-ebe332a84cb5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f945c1fc-2206-45fe-8e83-ebe332a84cb5@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241115_091209_922938_0EF02849 
X-CRM114-Status: GOOD (  21.03  )
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

On Fri, Nov 15, 2024 at 04:40:58PM +0000, Pavel Begunkov wrote:
>> So?  If we have a strong enough requirement for something else we
>> can triviall add another opcode.  Maybe we should just add different
>> opcodes for read/write with metadata so that folks don't freak out
>> about this?
>
> IMHO, PI is not so special to have a special opcode for it unlike
> some more generic read/write with meta / attributes, but that one
> would have same questions.

Well, apparently is one the hand hand not general enough that you
don't want to give it SQE128 space, but you also don't want to give
it an opcode.

Maybe we just need make it uring_cmd to get out of these conflicting
requirements.

Just to make it clear: I'm not a huge fan of a separate opcode or
uring_cmd, but compared to the version in this patch it is much better.

> PI as a special case. And that's more of a problem of the static
> placing from previous version, e.g. it wouldn't be a problem if in the
> long run it becomes sth like:
>
> struct attr attr, *p;
>
> if (flags & META_IN_USE_SQE128)
> 	p = sqe + 1;
> else {
> 	copy_from_user(&attr);
> 	p = &attr;
> }
>
> but that shouldn't be PI specific.

Why would anyone not use the SQE128 version?


