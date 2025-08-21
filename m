Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99ABECA0EEB
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Aug 2025 19:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hXYqDChkgaosTZOYyjIhldhib+U8KwIE5HJX1cdaDDE=; b=BsWMZZ0R1xSQ3hjGBBuxDi/rWK
	rdukctzMvQPV4iSduIncocH9TRKXz372/K5Feie3lJpUDpXPRxfBq7lHLK6YkAUYyMkt5HPCJAaM1
	8v+qNJ8lA6uG4duV7Nr5HDFWw2qQIb2lMPNyMxJt1U/4DR+5uxwtNrNgkhX0lJL1Mzzw+C9SL7n//
	ce1LtOx9BqWVGxcunL7Jk4VLWwLWdx6Kf64ie7Uwog7Ciez/Dkhkj67SDKafdtSwQxDo+FjC1zXKj
	EwBm31pZJTHmYfI/UwXwuJg3ocgaFr/xZsSqNw/vwig9Nw4f5/Y/aH6JSt7daTHC0YyhoL9Yw+K0A
	hMfFVkgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upAi7-00000000EzP-2Nzz;
	Thu, 21 Aug 2025 19:12:31 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1up5rE-0000000H9ai-3TEg
	for linux-nvme@lists.infradead.org;
	Thu, 21 Aug 2025 14:01:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 543B85C6CC5;
	Thu, 21 Aug 2025 14:01:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7EE0C4CEED;
	Thu, 21 Aug 2025 14:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755784896;
	bh=fPFpDcD5IoxktsMx43cYimZsbxu1wQFHGY0B5ONqI+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CBZbiO+u0jnyT/QGYfPK58tb7SkDHf7TnD6mTq5jfAmGCYn5ThhwQBfRcPNhHFcTM
	 eQjyVgQ69lPhefuQvvkjB7K5TAsb5ZQdv1w7eFx6j64qrpBWhzIYrqxL6AoJCebPEm
	 E3ds54S/IKBi7nfgAt1pkwRuEJbiTa1ZJXCtbUCHmYXrqcN2SFZ3Egk8tgVcylrGje
	 re2tLHiZpiaoH2XbU7utb+SJZdcbYpxhCEQ/ZeDsceUCweYwTq0DWlO4PtQJv5tflI
	 AwCCEyK6rYOhejR/MLYuvMQt2yiuCqXn0QQ977AvzvqlweOjjqkj0h+mYH4VM7TooN
	 r1fVhUxmBnb8A==
Date: Thu, 21 Aug 2025 08:01:34 -0600
From: Keith Busch <kbusch@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Christoph Hellwig <hch@infradead.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: Do we need an opt-in for file systems use of hw atomic writes?
Message-ID: <aKcmvfECWdv6CedK@kbusch-mbp>
References: <20250714131713.GA8742@lst.de>
 <6c3e1c90-1d3d-4567-a392-85870226144f@oracle.com>
 <aHULEGt3d0niAz2e@infradead.org>
 <6babdebb-45d1-4f33-b8b5-6b1c4e381e35@oracle.com>
 <20250715060247.GC18349@lst.de>
 <072b174d-8efe-49d6-a7e3-c23481fdb3fc@oracle.com>
 <20250715090357.GA21818@lst.de>
 <bd7b1eea-18bc-431e-bc29-42b780ff3c31@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd7b1eea-18bc-431e-bc29-42b780ff3c31@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250821_070136_905762_9513E651 
X-CRM114-Status: UNSURE (   8.24  )
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

On Tue, Aug 19, 2025 at 12:42:01PM +0100, John Garry wrote:
> 
> If we always ignore AWUPF, I fear that lots of sound NVMe implementations
> will be excluded from HW atomics.

It's not that they're excluded from HW atomics. They're just excluded
from the block layer's attributes and guard rails. People were using
NVMe atomics long before those block layer features, at least.

