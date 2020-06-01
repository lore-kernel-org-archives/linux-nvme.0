Return-Path: <SRS0=I3sE=7O=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42668C433E0
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jun 2020 15:03:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13EE82065C
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jun 2020 15:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fjdNmxFR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wVfow37n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13EE82065C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TQa9nPNumVAj//3u8uCI4mkSSqgBQOhf4034tLDxw1U=; b=fjdNmxFRCZT/Jv
	53TiG77f0zjJvCoFGkW7aD5UklNfpm/RvjnbOW22+ahbCyDNRdCToQMMRmWuWN92+J8GZaNS8PNYo
	ZXWOO2EswfaGO6+aJ2Bf35vX6FikFufiNavUMyfOFigpjMx7sX8ZqWUa52zZzUlOPdALnqaU/d1xH
	AtL3rQlWBI+SrvVVZVEFro8VLIqa27hkumOY88XOh4NuXQa3OGCKIhVsRT1KbO81LmxKpcuYihZ2a
	ctNKNz+IAOFCw3hkQFx/fln0X5YRw443DcZTnubWi+8zBxR6fQ6OKZtSkS+SZ+rOuxSFue4eS3Taf
	fB55Y2pdYmQyD8wcS/oQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jflxq-0003iQ-3b; Mon, 01 Jun 2020 15:02:58 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jfg3b-0000nY-56
 for linux-nvme@lists.infradead.org; Mon, 01 Jun 2020 08:44:32 +0000
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B0D94206E2;
 Mon,  1 Jun 2020 08:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1591001068;
 bh=++2cB/ePJhne1YRp0fru1zBYoji5d1nprT5N9O4udpk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=wVfow37nJUctQuczEjtuvdKVbO338MPrWmtxn6qzZZHMLNELwOQlIvzJoFUuF/1kq
 q5DWi1Wf0naUXbCdA1uSgSP2CWJRK7dS8k1Y+Djaw8xRkHX+tVonEUHstDVdezlly+
 CKUb/UU3oTLuSzgUFnUcgt1pHUYemwJpSNjNMHJk=
Date: Mon, 1 Jun 2020 10:44:26 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Tao pilgrim <pilgrimtao@gmail.com>
Subject: Re: [PATCH v2] blkdev: Replace blksize_bits() with ilog2()
Message-ID: <20200601084426.GB1667318@kroah.com>
References: <20200529141100.37519-1-pilgrimtao@gmail.com>
 <c8412d98-0328-0976-e5f9-5beddc148a35@kernel.dk>
 <CAAWJmAZOQQQeNiTr48OSRRdO2pG+q4c=6gjT55CkWC5FN=HXmA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAAWJmAZOQQQeNiTr48OSRRdO2pG+q4c=6gjT55CkWC5FN=HXmA@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200601_014431_214856_0068BCE0 
X-CRM114-Status: GOOD (  15.52  )
X-Mailman-Approved-At: Mon, 01 Jun 2020 08:02:54 -0700
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: hoeppner@linux.ibm.com, heiko.carstens@de.ibm.com,
 linux-nvme@lists.infradead.org, dhowells@redhat.com, clm@fb.com,
 deepa.kernel@gmail.com, houtao1@huawei.com, hch@lst.de,
 linux-s390@vger.kernel.org, bvanassche@acm.org, darrick.wong@oracle.com,
 Mark Fasheh <mark@fasheh.com>, satyat@google.com, hch@infradead.org,
 borntraeger@de.ibm.com, gor@linux.ibm.com, ajay.joshi@wdc.com,
 chaitanya.kulkarni@wdc.com, chao@kernel.org,
 Josef Bacik <josef@toxicpanda.com>, ming.lei@redhat.com,
 viro@zeniv.linux.org.uk, Muchun Song <songmuchun@bytedance.com>,
 dsterba@suse.com, jaegeuk@kernel.org, jlbec@evilplan.org, sagi@grimberg.me,
 Jens Axboe <axboe@kernel.dk>, balbi@kernel.org, damien.lemoal@wdc.com,
 martin.petersen@oracle.com, joseph.qi@linux.alibaba.com,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
 asml.silence@gmail.com, linux-btrfs@vger.kernel.org, sth@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Jun 01, 2020 at 03:22:01PM +0800, Tao pilgrim wrote:
> On Fri, May 29, 2020 at 10:13 PM Jens Axboe <axboe@kernel.dk> wrote:
> >
> > On 5/29/20 8:11 AM, Kaitao Cheng wrote:
> > > There is a function named ilog2() exist which can replace blksize.
> > > The generated code will be shorter and more efficient on some
> > > architecture, such as arm64. And ilog2() can be optimized according
> > > to different architecture.
> >
> > When you posted this last time, I said:
> >
> > "I like the simplification, but do you have any results to back up
> >  that claim? Is the generated code shorter? Runs faster?"
> >
> 
> Hi  Jens Axboe:
> 
> I did a test on ARM64.
> unsigned int ckt_blksize(int size)
> {
>    return blksize_bits(size);
> }
> unsigned int ckt_ilog2(int size)
> {
>     return ilog2(size);
> }
> 
> When I compiled it into assembly code, I got the following result,
> 
> 0000000000000088 <ckt_blksize>:
>       88: 2a0003e8 mov w8, w0
>       8c: 321d03e0 orr w0, wzr, #0x8
>       90: 11000400 add w0, w0, #0x1
>       94: 7108051f cmp w8, #0x201
>       98: 53017d08 lsr w8, w8, #1
>       9c: 54ffffa8 b.hi 90 <ckt_blksize+0x8>
>       a0: d65f03c0 ret
>       a4: d503201f nop
> 
> 00000000000000a8 <ckt_ilog2>:
>       a8: 320013e8 orr w8, wzr, #0x1f
>       ac: 5ac01009 clz w9, w0
>       b0: 4b090108 sub w8, w8, w9
>       b4: 7100001f cmp w0, #0x0
>       b8: 5a9f1100 csinv w0, w8, wzr, ne
>       bc: d65f03c0 ret
> 
> The generated code of ilog2  is shorter , and  runs faster

But does this code path actually show up anywhere that is actually
measurable as mattering?

If so, please show that benchmark results.

thanks,

greg k-h

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
