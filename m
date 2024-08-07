Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64076C49EA1
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Aug 2024 02:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NgRma1pFlOiWyVYjbdnZagJ3GFYqPSXD8K6gLydxidI=; b=Vw//kfOFQR3uOF7xPJaVLeobRY
	yguUvY8VHIViCxuLzT5vU7VA0/TTDTslLhVwe5KHwdiRCsAE7655vYVfpwoMhUa4uXJHK0ExtcXup
	w6jTsj2XZL6DqB7tIlIsYXfG6I0YFIJFz6rTFQNeR+DPygTtDPjL3E3w6rhncDCSocfZDbCWyXkMc
	ayWylbVXLNfF5/kcCTLN6OmlbOVXKdnVPaUqG/Q69t0F12Xi6sNYYpmZybLfStIY+s4N/+g3TEO5+
	21cpFWDUMVbj+6IvMoWN5vCtTIgz8ihtQS3Bjt/6o8fCtu4w/yaGJ1vxGk0PzHPmMgr2NwIU4kMeW
	6+AS290Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbWJV-00000003c2p-3qmN;
	Wed, 07 Aug 2024 02:22:09 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbWJT-00000003c2V-0xck
	for linux-nvme@lists.infradead.org;
	Wed, 07 Aug 2024 02:22:08 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 5918E6068A;
	Wed,  7 Aug 2024 02:22:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CABE1C32786;
	Wed,  7 Aug 2024 02:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722997326;
	bh=V4ilyxEVw4T0gLN4kqoQcDXrZ/lkQcbNxFDdNmlzWdQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ur5cA6+nJpMZTyCipsXNGNeVzkjDFj99OOvvecG5bVhugn9AnpoDVDvgAQjF9j1Od
	 jPEQWOP7o5P6FHdkDRu4DMznXN8CYgxKaiqTDi8+zojbNMbKQf9iKcSaVgASFAqRhn
	 bZwTXaydsa6EKAq/zNxFoYZWw1mDPTpDCOWhcCbKgJsN5y7n3eJOUZ+ygYGxfqkzFO
	 sPuwWqOz4fRcNSCoPVtk6OnKRQUjEY3xtYQrFVi9eQGxOFkutsc+S9zd4nsqTMSbN0
	 HP9o9Z2bAYhdjLCjgU0GNYywKgRsk8cHfp48ZDmhWFd09999WNqxPpzlym1icUfhJR
	 bWZx+6F22+M/A==
Date: Tue, 6 Aug 2024 19:22:04 -0700
From: Keith Busch <kbusch@kernel.org>
To: Eric Robinson <eric.robinson@psmnv.com>
Cc: Daniel Wagner <dwagner@suse.de>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: Disk Says It is Full But There's Nothing on It
Message-ID: <ZrLaTHyvN6F7qZf5@kbusch-mbp>
References: <SJ0PR03MB65014AE3AD77A352D0C88855FABE2@SJ0PR03MB6501.namprd03.prod.outlook.com>
 <zsyfgzmoyvjgvywkbkgtxchpfei3pyfcaf2mzu4gltraf34ymx@vocftyxjmedn>
 <SJ0PR03MB65010C717291244293A88CAEFABF2@SJ0PR03MB6501.namprd03.prod.outlook.com>
 <vqbcmbet5jfbhmjfuhr66om2ta5lw2octpynjdzyvk66ok47kd@oj7vhatyai3g>
 <SJ0PR03MB650188563CEBA3B2E6D2130BFABF2@SJ0PR03MB6501.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ0PR03MB650188563CEBA3B2E6D2130BFABF2@SJ0PR03MB6501.namprd03.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240806_192207_351228_5398A46E 
X-CRM114-Status: UNSURE (   9.15  )
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

On Tue, Aug 06, 2024 at 08:28:05PM +0000, Eric Robinson wrote:
> Disclaimer : This email and any files transmitted with it are confidential and intended solely for intended recipients. If you are not the named addressee you should not disseminate, distribute, copy or alter this email. Any views or opinions presented in this email are solely those of the author and might not represent those of Physician Select Management. Warning: Although Physician Select Management has taken reasonable precautions to ensure no viruses are present in this email, the company cannot accept responsibility for any loss or damage arising from the use of this email or attachments.
> 

Please fix your email client. This message is not appropriate for public
mailing lists.

