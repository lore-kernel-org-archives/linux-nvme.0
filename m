Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42B5DC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Mar 2022 10:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g1v6ovUNSf+kFskR5R+v2NInQ6xsMS01QhfDEC1m/98=; b=dqtskNtjlVseoMlvDqe+87vlev
	lDitGPOoRz4OEmi87CJmFho4EmPdK83z0yVVTXHID2txcEe1lmHPgfrlLTroA92Egm7Y9lJaoFiYu
	nrAyuryUgPaz845K4Lc20XKTesZj03LRVV9CXpXJlovIMzyGAoRPUOpOfYmFz6YPCGxgj2E5V4Fv1
	Q/61wWCZvj1eGTGFIcJmTOlIl6x9BolT+B3zT4B3Ed9eGsq/AeOsVDkoOEYJmQ9Ct9sj9SKzxKm4F
	K2cW6PTeEvgMaxGkT3K7m0DU6ru40LiyIggoDgI2j4luc+7E1Q+tQaAGOrpVWRFy4OaJgJtM+ICtb
	cPYljOPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nSFgL-00CHzY-0b; Thu, 10 Mar 2022 10:06:05 +0000
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nSFfk-00CHkV-Td
 for linux-nvme@lists.infradead.org; Thu, 10 Mar 2022 10:05:30 +0000
Received: by mail-lf1-x132.google.com with SMTP id w27so8514849lfa.5
 for <linux-nvme@lists.infradead.org>; Thu, 10 Mar 2022 02:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=g1v6ovUNSf+kFskR5R+v2NInQ6xsMS01QhfDEC1m/98=;
 b=ns33X3mSvUp/dV4LlGedMNO7aMi7dLjkJEUK4S+oJGMyRCgCRbpIY/bN1lKR7coIXt
 fgnlmrPnvIUWbzXLZXsahgLPJJhWkeuczEbUHP5ElqKexNzJYP0gAxHjGPJX/CqPQ8QH
 kpmjVHzhjJ7tMioIgTAfkNZ4h0efJFIsYgBVKYRvA4/s8c3a3BH+AEJgU8qpbf+bbY2g
 uXSUBVqregysJ4ss/HApTFtigwZZsAH+zVvVgLhTS54BwnE+AcGY/PjPVE3mFH+r28D8
 p/MNit5koONLvhhlYyCG0wohubRoqL2ukmTOS7AqUs+r4XjBh3AtK8PrI0HUlMBfQFsM
 zNaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=g1v6ovUNSf+kFskR5R+v2NInQ6xsMS01QhfDEC1m/98=;
 b=IRHtx61aacBE3jOmSws+NKv9GnsYp6+2YTnjbP9bOYFy3YseRnTIVe46sqw2yuSSdp
 fT1sUo+N7syP4ScGNB6YpkqksRo6uUIUhSvsj6JMKcJQv4VqRN4rO6MAJWSaRFUl/Ehm
 LRmxsZaVSMX+PGoknA9Z510DcjERrYBX+bZE1smNqkQypZRZnAGM7hbwzN5S9un6clJF
 fJLCKIBtw2/UtCuHKEVkFXyQ2/5QAGtdpDVxo+jkCQCcu7K3pMI1ndykcXeQQSOgFVbk
 nm8VUXhtHGtQi4ZjIfMCWNcRcNT5/2GB83VeTsjf7hNfVom/XnPpCMRw5w9hgOKFCJi4
 ILgA==
X-Gm-Message-State: AOAM530RQsF+qHEf98+ZwgxSjrQz9zfOREQx4Haz9dBhO/hQx4kYvN5t
 PRoIiEV1KX4gdAc7DIcJtmAV4uW+Rj+LlnuTYqY=
X-Google-Smtp-Source: ABdhPJwDzqA1hnug0wbCxuMMC9bwFUJgrX7k50AuAyOlBBQCCbHd+EQ98+xL/K6bjR+dxXF673VzxbFS2cGid0d5Jgc=
X-Received: by 2002:a05:6512:2208:b0:448:5c7a:6dd9 with SMTP id
 h8-20020a056512220800b004485c7a6dd9mr2577551lfu.334.1646906726687; Thu, 10
 Mar 2022 02:05:26 -0800 (PST)
MIME-Version: 1.0
References: <CGME20220308152651epcas5p1ebd2dc7fa01db43dd587c228a3695696@epcas5p1.samsung.com>
 <20220308152105.309618-1-joshi.k@samsung.com> <20220310082926.GA26614@lst.de>
In-Reply-To: <20220310082926.GA26614@lst.de>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Thu, 10 Mar 2022 15:35:02 +0530
Message-ID: <CA+1E3rJ17F0Rz5UKUnW-LPkWDfPHXG5aeq-ocgNxHfGrxYtAuw@mail.gmail.com>
Subject: Re: [PATCH 00/17] io_uring passthru over nvme
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>, 
 Keith Busch <kbusch@kernel.org>, Pavel Begunkov <asml.silence@gmail.com>,
 io-uring@vger.kernel.org, 
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, 
 sbates@raithlin.com, logang@deltatee.com, Pankaj Raghav <pankydev8@gmail.com>, 
 =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>, 
 Luis Chamberlain <mcgrof@kernel.org>,
 Adam Manzanares <a.manzanares@samsung.com>, 
 Anuj Gupta <anuj20.g@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220310_020529_014385_2B02404D 
X-CRM114-Status: GOOD (  10.65  )
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

On Thu, Mar 10, 2022 at 1:59 PM Christoph Hellwig <hch@lst.de> wrote:
>
> What branch is this against?
Sorry I missed that in the cover.
Two options -
(a) https://git.kernel.dk/cgit/linux-block/log/?h=io_uring-big-sqe
first patch ("128 byte sqe support") is already there.
(b) for-next (linux-block), series will fit on top of commit 9e9d83faa
("io_uring: Remove unneeded test in io_run_task_work_sig")

> Do you have a git tree available?
Not at the moment.

@Jens: Please see if it is possible to move patches to your
io_uring-big-sqe branch (and maybe rename that to big-sqe-pt.v1).

Thanks.

