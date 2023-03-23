Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E08DAC6FD1C
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Mar 2023 17:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NnDzCLszP5/Q6ndlIapxQXAyg2mwpLo5xgavVMn2PYk=; b=mwwuGDsXv5u/Q6sChQ7xNN1IB/
	Rp1nZrp5m/p3WOsfKxUVPk/HsS1YvdGPhrjjygnCmCL2Sc3D3ZFTer9X1AZuWtp/q7yQrE5+eXEaK
	xIEXUO3apda0h4W2RqddM4a04ZG+37OSH9TuhwsqFYbERgQzAEjQssMqsK2MyahGhf9gCpcsEvocH
	SthIN1F+6cdgJPOpzDyqgBkh0TnXaY/4G7+EcUrbvecgUGBlr2Ts3M69UxP4EdHr1bThizJS+MQim
	TCpiVCYX+m520kIsZQRhZdWcJRPhEWD8+lp72n8lvSoZjy/YqjxrDJfIA3+aLgP3M2VoTQ8B26koY
	wB7EweCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pfP56-002f2e-3A;
	Thu, 23 Mar 2023 17:50:32 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pfP53-002f2J-18
	for linux-nvme@lists.infradead.org;
	Thu, 23 Mar 2023 17:50:30 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 47D57B821CB;
	Thu, 23 Mar 2023 17:50:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FFDAC433EF;
	Thu, 23 Mar 2023 17:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1679593826;
	bh=NnDzCLszP5/Q6ndlIapxQXAyg2mwpLo5xgavVMn2PYk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MH/RLus1jv1RgOe9+NF4gx4+6X9Wt983pTnsrxsz+5zJK1hpTIJ6lqcNH1QldZ6fK
	 eTSUvTsIbIgK1PwUSwXGR19maWBezKSZPT0qB6O946HxcuhP1NQOfNzsKR6ztIvDwE
	 vTsZrcUUrs/JJ8QYUMnPUJQz0xuHe02R8E6iDoNgOeKF7eVJ+ix/UJgV0EIsa0av1u
	 aZab1wq+m443PmmC6rZOf3kj9feIxCny9KkU9qfH+T9BEt0tVuVGbcMGyeuvanqaYw
	 HVRBqdR/NBQlLecy9hBl4iTAK4UPZeorNphdLuXnnoU8gge+8QJ1Ho3VNoa4d+BKzD
	 58532jjpRsx5Q==
Date: Thu, 23 Mar 2023 11:50:23 -0600
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	hare@suse.de
Subject: Re: [PATCH 5/9] nvme-core: use normal pattern
Message-ID: <ZByRXlzJg2XaZAXh@kbusch-mbp.dhcp.thefacebook.com>
References: <20230323033636.812758-1-kch@nvidia.com>
 <20230323033636.812758-6-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323033636.812758-6-kch@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230323_105029_556051_0917D4AB 
X-CRM114-Status: GOOD (  10.93  )
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

On Wed, Mar 22, 2023 at 08:36:32PM -0700, Chaitanya Kulkarni wrote:
> Although return is allowed in the switch ... case when function is
> returing void, it creates confusion for future code which is desirable
> pattern to use for switch ... case. Repalce return in the switch with
> break that is standard pattern for the switch ... case.

The previous patch replaced 'break' with 'return', and this one does the
opposite. What's special about a void return that makes this a standard
pattern?

