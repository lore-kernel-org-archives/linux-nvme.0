Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9781CC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Jan 2022 16:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Mwfq2KJQz0V13p1h8wzoFbJ2FfQVWps4zGexsGIn8rM=; b=e9NOkitZlb/xoZsNA3EzAQapE+
	s3mLslzxmRdeweV/3gvZE446oqeZd0+R1qQIUdDgQGXdQQZ2Ho/XwxN3lIq9q9YfvIiPzyqum3fpI
	vmvOQKZrHOl5iftEnXjDXFOiCeznt1f/X9bkuQYhxmt6yVf9zKlWbQMOa1WAbajTZ6yTcZwSmGiky
	VYBnpYAgHe1Kz41yxE2dIM9ZSwNxNkkJ7ByhjYNb8U8C9B1dChZLNAqLV0eKrLV/nHDyf40iL5mhS
	Nw2V1pDwrLxWQt3ET1EGBKIf7RKCLcGLNzm+YIxVkNzZK41gnv/HbxJRX/xtyh6zzDci3zR92pYQA
	YlQPmFjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nCOGS-008XQp-HW; Tue, 25 Jan 2022 16:01:48 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nCNvG-008Qg9-Lj
 for linux-nvme@lists.infradead.org; Tue, 25 Jan 2022 15:39:57 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id E7B59616C0;
 Tue, 25 Jan 2022 15:39:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBE3FC340E0;
 Tue, 25 Jan 2022 15:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1643125193;
 bh=uNyjZOcU2IAryn5EV8J/+fRYJaBYG5sJZ9cOcNYSXKM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=C1r3iAOnInePO7W2vzlG/JCu7lpHJTZx4DYsvuA7G/wWHlrehhV+RLui7rytxsvKO
 5469WoSZY7zhTDHqhHTWbF5x6iJsdWNZxJNwCNfmchq7orWCL0dn53zMGOqmP6YIHs
 7EsnU1SHCe5Kg1vmj4Sl1BW3cha5XoK4AW8/kFOSJEAcVdundY/CLjUw1g1ues6qqg
 7yKk1nRlhXRJnxTVLMKfbj2BCfZHB+3sRUhriuY1rmTSJEmspj7qRqaai5lTr3Zkis
 /OLzRAPmaeqonHrRZ9p+F7HuS35/vfC0K337VHjKa+TIyZ2YqTzounznnT76g5ODss
 KbX0i1RJ4mhjw==
Date: Tue, 25 Jan 2022 07:39:50 -0800
From: Keith Busch <kbusch@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
 martin.petersen@oracle.com, colyli@suse.de, arnd@arndb.de
Subject: Re: [RFC 3/7] lib: add rocksoft model crc64
Message-ID: <20220125153950.GB1683949@dhcp-10-100-145-180.wdc.com>
References: <20220124160107.1683901-1-kbusch@kernel.org>
 <20220124160107.1683901-4-kbusch@kernel.org>
 <Ye+GTkrZ5YMe5qGt@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ye+GTkrZ5YMe5qGt@sol.localdomain>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220125_073954_806789_629B4EF9 
X-CRM114-Status: GOOD (  14.29  )
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

On Mon, Jan 24, 2022 at 09:10:38PM -0800, Eric Biggers wrote:
> On Mon, Jan 24, 2022 at 08:01:03AM -0800, Keith Busch wrote:
> > Since this model reflects inputs and outputs, a helper table and
> > function are added to reverse bits of 8 and 64 bit values.
> 
> That's a silly way to do a bit-reflected CRC.  The proper way to do it is to
> reflect the bytes too, so that the bits and bytes are ordered consistently, so
> explicitly reflecting the bits isn't needed.  Most CRC-32's are bit-reflected,
> and they are usually implemented this way.  E.g., see crc32_le() in lib/crc32.c.
> 
> Here's a Python script that shows that the Rocksoft CRC-64 can be computed
> without explicitly reversing the bits.  It passes the tests from your patch 4:

Thanks for the tip! I'll use that for the next version.

