Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6370BCFD2F6
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Nov 2025 07:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nZvOZnMAnx1zOEgYP1YGj2cerA28YaqBJ135PxGutMU=; b=d3KpeBcpRnkeyupjkOPndncsJ6
	6lQE+Rsd7PzNNpWKfKv1xC7jSrOlSzHHynDj6XYv0MeM4kF2NlWQoqFWuCG+l2jIv3o+e6kEwhBJ2
	jccXxtKtNr6pT7h8+FcgOS/3Zjsk1eK0pbukwjTxEQ3mt4HHu9gvg7u1IC32bBIC/3bovE2drPBlF
	ZHqntGIAxKzqISpyFaf3LBe1ZnxICNkixlGrB0TQnn6N4IUJh4TJfAoIyeea4C9ex5QOD7wzVgCX6
	oCSIsnjo0DRLXJQIHne1AttzVt5U4upZss+FWU7MH5QV//9F7fGFsCq04hmlf2zLlc6sP5sbnSr3A
	iv8aSiXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOWcD-0000000G8tY-3R3u;
	Thu, 27 Nov 2025 07:40:33 +0000
Received: from out30-97.freemail.mail.aliyun.com ([115.124.30.97])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOWc9-0000000G8tC-28js
	for linux-nvme@lists.infradead.org;
	Thu, 27 Nov 2025 07:40:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1764229222; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=nZvOZnMAnx1zOEgYP1YGj2cerA28YaqBJ135PxGutMU=;
	b=Nn9TcqxGYPNdzPCUEb+xP6a86+VBpE6D7F72qYMMfL7NJMGj/MWBkmU6BDLOLfkMrKZdcJ/rNnrNqaGAx97iqNp8/B7J8ydksZK3CkNy6Smse2Ht/ZydHBGBYBATJha9jhT3xDapaX8lke4uICOolpl0AzxkuJvf4C1gawTuWao=
Received: from 30.221.131.208(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WtWMC3B_1764229221 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 27 Nov 2025 15:40:21 +0800
Message-ID: <3a29b0d8-f13d-4566-8643-18580a859af7@linux.alibaba.com>
Date: Thu, 27 Nov 2025 15:40:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fix potential data loss and corruption due to Incorrect BIO Chain
 Handling
To: Christoph Hellwig <hch@infradead.org>,
 Stephen Zhang <starzhangzsd@gmail.com>
Cc: Ming Lei <ming.lei@redhat.com>, Andreas Gruenbacher
 <agruenba@redhat.com>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, nvdimm@lists.linux.dev,
 virtualization@lists.linux.dev, linux-nvme@lists.infradead.org,
 gfs2@lists.linux.dev, ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org,
 zhangshida@kylinos.cn
References: <20251121081748.1443507-1-zhangshida@kylinos.cn>
 <aSBA4xc9WgxkVIUh@infradead.org>
 <CANubcdVjXbKc88G6gzHAoJCwwxxHUYTzexqH+GaWAhEVrwr6Dg@mail.gmail.com>
 <aSP5svsQfFe8x8Fb@infradead.org>
 <CANubcdVgeov2fhcgDLwOmqW1BNDmD392havRRQ7Jz5P26+8HrQ@mail.gmail.com>
 <aSf6T6z6f2YqQRPH@infradead.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <aSf6T6z6f2YqQRPH@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251126_234029_913111_336635EB 
X-CRM114-Status: UNSURE (   8.60  )
X-CRM114-Notice: Please train this message.
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

Hi Christoph,

On 2025/11/27 15:14, Christoph Hellwig wrote:
> On Thu, Nov 27, 2025 at 03:05:29PM +0800, Stephen Zhang wrote:
>> No, they are not using bcache.
> 
> Then please figure out how bio_chain_endio even gets called in this
> setup.  I think for mainline the approach should be to fix bcache
> and eorfs to not call into ->bi_end_io and add a BUG_ON() to

Just saw this.

For erofs, let me fix this directly to use bio_endio() instead
and go through the erofs (although it doesn't matter in practice
since no chain i/os for erofs and bio interfaces are unique and
friendly to operate bvecs for both block or non-block I/Os
compared to awkward bvec interfaces) and I will Cc you, Ming
and Stephen then.

Thanks,
Gao Xiang

