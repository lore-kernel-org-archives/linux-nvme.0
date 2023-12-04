Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D540C4167B
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Dec 2023 15:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mFu/WEPzXTIUnCGJQ8uWfl8c0+zaXa08beUT2qQU0Ko=; b=db1KALNSauULQJIer5azZlZR0O
	sAJrhpUc0un5qoSxUxrh3gzkI5qFJp1ibdNxJnHTty6AP+XRGwD27PLVuL2MRXReBOH8JKcflkc+J
	GJ8FF0YDbPMbdCaFzlpqfx9o/pWU2JPoWFKt7aqm2z4MrTHNKSriUKiWC/lPAEPMpuNvHILeaRDT7
	eRFo9kd66X/Smxord5bgN9oyxTXu5F7gxQLWeNtdUVBL3cbFTJgYa92q31tggDJQtVxbe2aqfcaZx
	Z2NkDX9DLvxBirmfXbm0dRNUOSOrM+x20iQPWAEOpPQ0Tfi63NWCZY09yp8dXGHayBMoPaV16wQW9
	WnCkQ29w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rAB2a-004zDE-2f;
	Mon, 04 Dec 2023 15:39:24 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rAB2W-004zBb-0k
	for linux-nvme@lists.infradead.org;
	Mon, 04 Dec 2023 15:39:22 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 59D36227A8E; Mon,  4 Dec 2023 16:39:12 +0100 (CET)
Date: Mon, 4 Dec 2023 16:39:12 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, kbusch@kernel.org,
	sagi@grimberg.me, jejb@linux.ibm.com, martin.petersen@oracle.com,
	djwong@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
	chandan.babu@oracle.com, dchinner@redhat.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-api@vger.kernel.org
Subject: Re: [PATCH 17/21] fs: xfs: iomap atomic write support
Message-ID: <20231204153912.GA3580@lst.de>
References: <20230929102726.2985188-1-john.g.garry@oracle.com> <20230929102726.2985188-18-john.g.garry@oracle.com> <20231109152615.GB1521@lst.de> <a50a16ca-d4b9-a4d8-4230-833d82752bd2@oracle.com> <c78bcca7-8f09-41c7-adf0-03b42cde70d6@oracle.com> <20231128135619.GA12202@lst.de> <e4fb6875-e552-45aa-b193-58f15d9a786c@oracle.com> <20231204134509.GA25834@lst.de> <a87d48a7-f2a8-40ae-8d9b-e4534ccc29b1@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a87d48a7-f2a8-40ae-8d9b-e4534ccc29b1@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231204_073921_203121_C4DFBA64 
X-CRM114-Status: GOOD (  20.59  )
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

On Mon, Dec 04, 2023 at 03:19:15PM +0000, John Garry wrote:
> On 04/12/2023 13:45, Christoph Hellwig wrote:
>> On Tue, Nov 28, 2023 at 05:42:10PM +0000, John Garry wrote:
>>> ok, fine, it would not be required for XFS with CoW. Some concerns still:
>>> a. device atomic write boundary, if any
>>> b. other FSes which do not have CoW support. ext4 is already being used for
>>> "atomic writes" in the field - see dubious amazon torn-write prevention.
>>
>> What is the 'dubious amazon torn-write prevention'?
>
> https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/storage-twp.html
>
> AFAICS, this is without any kernel changes, so no guarantee of unwanted 
> splitting or merging of bios.
>
> Anyway, there will still be !CoW FSes which people want to support.

Ugg, so they badly reimplement NVMe atomic write support and use it
without software stack enablement.  Calling it dubious is way to
gentle..

>> Relying just on the hardware seems very limited, especially as there is
>> plenty of hardware that won't guarantee anything larger than 4k, and
>> plenty of NVMe hardware without has some other small limit like 32k
>> because it doesn't support multiple atomicy mode.
>
> So what would you propose as the next step? Would it to be first achieve 
> atomic write support for XFS with HW support + CoW to ensure contiguous 
> extents (and without XFS forcealign)?

I think the very first priority is just block device support without
any fs enablement.  We just need to make sure the API isn't too limited
for additional use cases.

> Ignoring FSes, then how is this supposed to work for block devices? We just 
> always need HW support, right?

Yes.

