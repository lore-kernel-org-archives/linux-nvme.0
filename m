Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36AA4D6B6B3
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2024 17:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XKM46jgi8Yb1+VYNYuSNNFeBemqErGUoGTbIhzVz62A=; b=WtoMJUDsxwtx86i0YWBN3eCOPS
	Km3YemWq89FsKQr866bkdlL/yMNdGmhwZGzTg/R6zJT76r9S2y40W/SwHbizhUrSy9uXlDjGLdkD2
	JTuMinesjfhg0FtLVNyg7YvVk/Z3q24e42AR7RBu39z24YIObNC8TMC+ah53mJRYxjM4OVnyXr6zr
	HBqB4OU0n10vFoho1/wRg9nKpneWQ6dkb9zZMlljqjXUH69CEbdB5+BiYO71shNB0zlTHEgVqnDm4
	ehm5k+VcIIJnr/HPFwSCBJRQujWzJojrtBj2mxbKYBgndLp5K9Y6cjk+Rt0mwj7kNwY9Gi2EBbmQg
	mHF6qL9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6CkH-00000001Jdw-25Wz;
	Wed, 30 Oct 2024 17:44:37 +0000
Received: from 008.lax.mailroute.net ([199.89.1.11])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6CkE-00000001Jb9-1sPr
	for linux-nvme@lists.infradead.org;
	Wed, 30 Oct 2024 17:44:35 +0000
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4XdvdL5nBGz6Ckj6M;
	Wed, 30 Oct 2024 17:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1730310256; x=1732902257; bh=XKM46jgi8Yb1+VYNYuSNNFeB
	emqErGUoGTbIhzVz62A=; b=zImrgFtcbi/b+BsWzqM8JJ2ZzeJJgF9nZnCpY0G+
	VfQoLefBtzp2V+h0cHbKPel70cGrwEW0eYQYWPQzC7cqVj03wDJ2dTnFb8n26wT4
	HJe8qhv0hP/eL4QjAmO76lKliGk4pCeWbQGQFv05Vp5K9NjXh8JmFfxnjotq3cwe
	jbmAYDT09ra6N0BbHC7TfHNDEz/AO/Icr2Uebe9/uMgOhfP/sDe9tdQotKlfYOUC
	kz97G3cG4+GOpoWeFB9zuwWI+kDHoo30JT0MIzbOcD4c1rL5JdZ4GPobF6pfkhCN
	djXky8JNaa8HKzFdgT8GwO8SZzwcuwSHYUVKbAf7DAThiA==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id r8M1mEJJhr-B; Wed, 30 Oct 2024 17:44:16 +0000 (UTC)
Received: from [IPV6:2a00:79e0:2e14:8:6fdd:1e16:9f71:469c] (unknown [104.135.204.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4Xdvd66wP8z6CklsR;
	Wed, 30 Oct 2024 17:44:10 +0000 (UTC)
Message-ID: <f644c6b2-7549-458d-8a24-07aa44c4b4ee@acm.org>
Date: Wed, 30 Oct 2024 10:44:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv10 9/9] scsi: set permanent stream count in block limits
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Keith Busch <kbusch@meta.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, io-uring@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, joshi.k@samsung.com, javier.gonz@samsung.com,
 Hannes Reinecke <hare@suse.de>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>
References: <20241029151922.459139-1-kbusch@meta.com>
 <20241029151922.459139-10-kbusch@meta.com> <20241029152654.GC26431@lst.de>
 <ZyEAb-zgvBlzZiaQ@kbusch-mbp> <20241029153702.GA27545@lst.de>
 <ZyEBhOoDHKJs4EEY@kbusch-mbp> <20241029155330.GA27856@lst.de>
 <ZyEL4FOBMr4H8DGM@kbusch-mbp> <20241030045526.GA32385@lst.de>
 <c9c2574b-b3be-47ac-8a82-10d92c5892bc@acm.org>
 <20241030171450.GA12580@lst.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20241030171450.GA12580@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241030_104434_501886_33475CE9 
X-CRM114-Status: GOOD (  14.83  )
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

On 10/30/24 10:14 AM, Christoph Hellwig wrote:
> On Wed, Oct 30, 2024 at 09:59:24AM -0700, Bart Van Assche wrote:
>>
>> On 10/29/24 9:55 PM, Christoph Hellwig wrote:
>>> For the temperature hints the only public user I known is rocksdb, and
>>> that only started working when Hans fixed a brown paperbag bug in the
>>> rocksdb code a while ago.  Given that f2fs interprets the hints I suspect
>>> something in the Android world does as well, maybe Bart knows more.
>>
>> UFS devices typically have less internal memory (SRAM) than the size of a
>> single zone.
> 
> That wasn't quite the question.  Do you know what application in android
> set the fcntl temperature hints?

I do not know whether there are any Android apps that use the
F_SET_(FILE_|)RW_HINT fcntls.

The only use case in Android platform code I know of is this one: Daejun
Park, "f2fs-tools: add write hint support", f2fs-dev mailing list,
September 2024 
(https://lore.kernel.org/all/20240904011217epcms2p5a1b15db8e0ae50884429da7be4af4de4@epcms2p5/T/).
As you probably know f2fs-tools is a software package that includes
fsck.f2fs.

Jaegeuk, please correct me if necessary.

Bart.




